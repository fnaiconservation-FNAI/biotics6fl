CREATE OR REPLACE FUNCTION ext.remove_ref_code(IN cstring TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    rstring CHARACTER VARYING(6000);
BEGIN
    /* Step 0: Substring CLOB */
    rstring := oracle.substr(lob_loc => cstring, amount => 4000, "offset" => 1);
    /* Step 1: Remove reference codes (keep brackets) */
    rstring := regexp_replace((rstring)::TEXT, ('([[:alpha:][:digit:]?]{3,}FLUS|[ABDFGIJMNPRSUW](ND|[0-9]{2})[[:alpha:]?]{3}[0-9]{2}|S[0-9]{2}[[:alpha:]?]{3}(FS|UF|SF|WF|SM)FLUS)')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    /* Step 2: Remove standalone codes exactly 8 characters long */
    /* that do not end in FLUS */
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]?])([ABDFGIJMNPRSUW](ND|[0-9]{2})[[:alpha:]?]{3}[0-9]{2}|S[0-9]{2}[[:alpha:]?]{3}(FS|UF|SF|WF|SM))([^[:alnum:]?]|$)')::TEXT, coalesce((E'\\1\\5')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    /* Step 3: Trim and normalize whitespace */
    rstring := TRIM(rstring);
    rstring := regexp_replace((rstring)::TEXT, ('[[:space:]]+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    rstring := replace(rstring, '(flus)', '');
    rstring := replace(rstring, '(FLUS)', '');
    /* Step 4: Remove brackets containing only spaces, */
    /* punctuation, or delimiters */
    rstring := regexp_replace((rstring)::TEXT, (E'\\([[:space:],;:/|.-]*\\)')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    /* () */
    rstring := regexp_replace((rstring)::TEXT, (E'\\[[[:space:],;:/|.-]*\\]')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    /* [] */
    rstring := regexp_replace((rstring)::TEXT, (E'\\{[[:space:],;:/|.-]*\\}')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    /* {} */
    /* Step 5: Remove empty brackets */
    rstring := regexp_replace((rstring)::TEXT, (E'\\(\\)|\\[\\]|\\{\\}')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    /* Step 6: Remove spaces before period */
    rstring := replace(rstring, ' .', '.');
    /* Final cleanup */
    rstring := TRIM(rstring);
    rstring := regexp_replace((rstring)::TEXT, ('[[:space:]]+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    RETURN rstring;
END;
$BODY$
LANGUAGE  plpgsql;


CREATE OR REPLACE FUNCTION ext.clean_up(IN cstring TEXT)
RETURNS TEXT
AS
$BODY$
/* rstring VARCHAR2(6000 CHAR); */
DECLARE
    rstring CHARACTER VARYING(6000);
/* rstring VARCHAR2(32767); */
BEGIN
    IF cstring IS NULL THEN
        RETURN NULL;
    END IF;
    /* Remove line/formatting characters */
    rstring := replace(cstring, coalesce(CHR(10), ''), '');
    /* Line Feed */
    rstring := replace(rstring, coalesce(CHR(11), ''), '');
    /* Vertical Tab */
    rstring := replace(rstring, coalesce(CHR(12), ''), '');
    /* Form Feed */
    rstring := replace(rstring, coalesce(CHR(13), ''), '');
    /* Carriage Return */
    /* Remove soft hyphen (U+00AD = CHR(173)) */
    rstring := replace(rstring, coalesce(CHR(173), ''), '');
    /* Normalize dashes */
    rstring := replace(rstring, '–', '-');
    /* en dash */
    rstring := replace(rstring, '—', '-');
    /* em dash */
    /* Remove ampersand encodings */
    rstring := replace(rstring, coalesce(CONCAT_WS('', CHR(38), 'gt;')::TEXT, ''), '>');
    rstring := replace(rstring, coalesce(CONCAT_WS('', CHR(38), 'lt;')::TEXT, ''), '<');
    rstring := replace(rstring, coalesce(CHR(38), ''), 'and');
    /* Strip HTML tags */
    rstring := regexp_replace((rstring)::TEXT, ('<[^>]+>')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    /* Trim and normalize whitespace */
    rstring := TRIM(rstring);
    /* Standard Trim */
    rstring := regexp_replace((rstring)::TEXT, (E'\\s+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    /* Replace multiple spaces */
    rstring := regexp_replace((rstring)::TEXT, (E'\\(\\)|\\[\\]|\\{\\}|\\( \\)|\\[ \\]|\\{ \\}')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    /* Remove empty brackets */
    rstring := TRIM(rstring);
    /* Standard Trim */
    rstring := regexp_replace((rstring)::TEXT, (E'\\s+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    /* Replace multiple spaces */
    RETURN rstring;
END;
$BODY$
LANGUAGE  plpgsql;


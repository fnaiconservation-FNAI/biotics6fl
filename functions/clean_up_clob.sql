CREATE OR REPLACE FUNCTION ext.clean_up_clob(IN cstring TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    rstring TEXT;
BEGIN
    IF cstring IS NULL THEN
        RETURN NULL;
    END IF;
    rstring := cstring;
    /* Remove line/formatting characters */
    rstring := replace(rstring::TEXT, coalesce(CHR(10)::TEXT, ''), '');
    rstring := replace(rstring::TEXT, coalesce(CHR(11)::TEXT, ''), '');
    rstring := replace(rstring::TEXT, coalesce(CHR(12)::TEXT, ''), '');
    rstring := replace(rstring::TEXT, coalesce(CHR(13)::TEXT, ''), '');
    rstring := replace(rstring::TEXT, coalesce(CHR(173)::TEXT, ''), '');
    /* Normalize dashes */
    rstring := replace(rstring::TEXT, '–'::TEXT, '-'::TEXT);
    rstring := replace(rstring::TEXT, '—'::TEXT, '-'::TEXT);
    /* Remove ampersand encodings */
    rstring := replace(rstring::TEXT, coalesce(CONCAT_WS('', CHR(38), 'gt;')::TEXT, ''), '>'::TEXT);
    rstring := replace(rstring::TEXT, coalesce(CONCAT_WS('', CHR(38), 'lt;')::TEXT, ''), '<'::TEXT);
    rstring := replace(rstring::TEXT, coalesce(CHR(38)::TEXT, ''), 'and'::TEXT);
    /* Strip HTML tags */
    rstring := replace(rstring::TEXT, '<i>'::TEXT, '');
    rstring := replace(rstring::TEXT, '</i>'::TEXT, '');
    rstring := replace(rstring::TEXT, '<b>'::TEXT, '');
    rstring := replace(rstring::TEXT, '</b>'::TEXT, '');
    rstring := replace(rstring::TEXT, '<span>'::TEXT, '');
    rstring := replace(rstring::TEXT, '</span>'::TEXT, '');
    rstring := replace(rstring::TEXT, '<br>'::TEXT, ' '::TEXT);
    rstring := replace(rstring::TEXT, '<br/>'::TEXT, ' '::TEXT);
    rstring := replace(rstring::TEXT, '<br />'::TEXT, ' '::TEXT);
    rstring := replace(rstring::TEXT, '<BR>'::TEXT, ' '::TEXT);
    rstring := replace(rstring::TEXT, '<BR/>'::TEXT, ' '::TEXT);
    rstring := replace(rstring::TEXT, '<BR />'::TEXT, ' '::TEXT);
    /* Trim and normalize whitespace */
    rstring := replace(rstring::TEXT, '      '::TEXT, ' '::TEXT);
    /* 6 spaces */
    rstring := replace(rstring::TEXT, '     '::TEXT, ' '::TEXT);
    /* 5 spaces */
    rstring := replace(rstring::TEXT, '    '::TEXT, ' '::TEXT);
    /* 4 spaces */
    rstring := replace(rstring::TEXT, '   '::TEXT, ' '::TEXT);
    /* 3 spaces */
    rstring := replace(rstring::TEXT, '  '::TEXT, ' '::TEXT);
    /* 2 spaces */
    rstring := TRIM(rstring);
    /* Standard Trim */
    RETURN rstring;
END;
$BODY$
LANGUAGE  plpgsql;


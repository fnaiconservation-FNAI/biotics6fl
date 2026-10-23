CREATE OR REPLACE FUNCTION ext.trimm(IN cstring TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    rstring CHARACTER VARYING(6000);
BEGIN
    rstring := TRIM(cstring);
    rstring := regexp_replace((rstring)::TEXT, (E'\\s+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    rstring := regexp_replace((rstring)::TEXT, (E'\\s+([,.;?!:%"''])')::TEXT, coalesce((E'\\1')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    rstring := regexp_replace((rstring)::TEXT, (E'\\s+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    RETURN (rstring);
END;
$BODY$
LANGUAGE  plpgsql;


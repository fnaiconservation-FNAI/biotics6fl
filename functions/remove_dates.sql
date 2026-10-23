CREATE OR REPLACE FUNCTION ext.remove_dates(IN cstring TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    rstring CHARACTER VARYING(6000);
BEGIN
    rstring := regexp_replace((cstring)::TEXT, ('[[:digit:]]{1,2}/[[:digit:]]{1,2}/[[:digit:]]{2,4}|[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}|[Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|January|February|March|April|May|June|July|August|September|October|November|December][[:space:]][0-9]{2},[[:space:]][0-9]{4}|19[[:digit:]]{2}-19[[:digit:]]{2}|20[[:digit:]]{2}-20[[:digit:]]{2}|19[[:digit:]]{2} no data|20[[:digit:]]{2} no data|surveyed in[[:space:]](19|20)[[:digit:]]{2}')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, (E'(^|[[:space:],.;])\\d{1,2}\\s+(January|February|March|April|May|June|July|August|September|October|November|December|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\s+\\d{2,4}([[:space:],.;]|$)')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, (E'([[:space:],.;])?(January|February|March|April|May|June|July|August|September|October|November|December|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\s+\\d{4}\\s*[-–]{1,2}\\s*(January|February|March|April|May|June|July|August|September|October|November|December|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\s+\\d{4}([[:space:],.;]|$)')::TEXT, coalesce((E'\\1')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := TRIM(rstring);
    rstring := regexp_replace((rstring)::TEXT, (E'\\s+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    rstring := regexp_replace((rstring)::TEXT, (E'\\(\\)|\\[\\]|\\{ \\}|\\( \\)|\\[ \\]|\\{ \\}')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('^[:;]+[[:space:]]*')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := TRIM(rstring);
    rstring := regexp_replace((rstring)::TEXT, (E'\\s+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    RETURN (rstring);
END;
$BODY$
LANGUAGE  plpgsql;


CREATE OR REPLACE FUNCTION ext.txt_num_to_int(IN cstring TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    rstring CHARACTER VARYING(6000);
BEGIN
    rstring := replace(cstring, 'tens of thousands', '20000');
    rstring := replace(rstring, 'several thousand', '4000');
    rstring := replace(rstring, 'few thousand', '3000');
    rstring := replace(rstring, 'couple thousand', '2000');
    rstring := replace(rstring, 'one thousand', '1000');
    rstring := replace(rstring, 'two thousand', '2000');
    rstring := replace(rstring, 'three thousand', '3000');
    rstring := replace(rstring, 'four thousand', '4000');
    rstring := replace(rstring, 'five thousand', '5000');
    rstring := replace(rstring, 'six thousand', '6000');
    rstring := replace(rstring, 'seven thousand', '7000');
    rstring := replace(rstring, 'eight thousand', '8000');
    rstring := replace(rstring, 'nine thousand', '9000');
    rstring := replace(rstring, 'ten thousand', '9000');
    rstring := replace(rstring, 'thousands', '2000');
    rstring := replace(rstring, 'thousand', '1000');
    rstring := replace(rstring, '1000s', '2000');
    rstring := replace(rstring, 'one hundred', '100');
    rstring := replace(rstring, 'two hundred', '200');
    rstring := replace(rstring, 'three hundred', '300');
    rstring := replace(rstring, 'four hundred', '400');
    rstring := replace(rstring, 'five hundred', '500');
    rstring := replace(rstring, 'six hundred', '600');
    rstring := replace(rstring, 'seven hundred', '700');
    rstring := replace(rstring, 'eight hundred', '800');
    rstring := replace(rstring, 'nine hundred', '900');
    rstring := replace(rstring, 'several hundred', '400');
    rstring := replace(rstring, 'few hundred', '300');
    rstring := replace(rstring, 'couple hundred', '200');
    rstring := replace(rstring, 'hundreds', '200');
    rstring := replace(rstring, 'hundred', '100');
    rstring := replace(rstring, '100s', '200');
    rstring := replace(rstring, 'several dozen', '48');
    rstring := replace(rstring, 'few dozen', '36');
    rstring := replace(rstring, 'couple dozen', '24');
    rstring := replace(rstring, 'one dozen', '12');
    rstring := replace(rstring, 'two dozen', '24');
    rstring := replace(rstring, 'three dozen', '36');
    rstring := replace(rstring, 'four dozen', '48');
    rstring := replace(rstring, 'five dozen', '60');
    rstring := replace(rstring, 'six dozen', '72');
    rstring := replace(rstring, 'seven dozen', '84');
    rstring := replace(rstring, 'eight dozen', '96');
    rstring := replace(rstring, 'nine dozen', '108');
    rstring := replace(rstring, 'dozens', '24');
    rstring := replace(rstring, 'dozen', '12');
    rstring := replace(rstring, 'numerous', '10');
    rstring := replace(rstring, 'several', '4');
    rstring := replace(rstring, 'scattered plants', '10 scattered plants');
    rstring := replace(rstring, 'large area of plants', '10 plants');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])one([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 1\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])two([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 2\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])three([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 3\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])four([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 4\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])five([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 5\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])six([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 6\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])seven([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 7\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])eight([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 8\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])nine([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 9\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])ten([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 10\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])few([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 3\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := regexp_replace((rstring)::TEXT, ('(^|[^[:alnum:]])couple([^[:alnum:]]|$)')::TEXT, coalesce((E'\\1 2\\2')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
    rstring := TRIM(rstring);
    rstring := regexp_replace((rstring)::TEXT, (E'\\s+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    RETURN (rstring);
END;
$BODY$
LANGUAGE  plpgsql;


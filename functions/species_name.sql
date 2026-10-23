CREATE OR REPLACE FUNCTION ext.species_name(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    full_name CHARACTER VARYING(255);
    species_epithet CHARACTER VARYING(80);
BEGIN
    /* Get the scientific name */
    SELECT
        oracle.substr(sn.scientific_name, 1, 255)
        INTO STRICT full_name
        FROM core.element_subnational AS est
        JOIN core.scientific_name AS sn
            ON sn.scientific_name_id = est.sname_id
        WHERE est.element_subnational_id = est_id_arg;
    /* Extract the second word (the species epithet) */
    species_epithet := regexp_substr((full_name)::TEXT, ('[^ ]+')::TEXT, (1)::INTEGER, (2)::INTEGER);
    RETURN species_epithet;
END;
$BODY$
LANGUAGE  plpgsql;


CREATE OR REPLACE FUNCTION ext.est_lookup(IN in_sname TEXT)
RETURNS BIGINT
AS
$BODY$
DECLARE
    OUT_EST_ID BIGINT;
BEGIN
    BEGIN
        /* first find sci name in sci name table and see if it's used in EST */
        SELECT
            est.element_subnational_id
            INTO STRICT OUT_EST_ID
            FROM core.scientific_name
            LEFT OUTER JOIN core.element_subnational AS est
                ON core.scientific_name.scientific_name_id = est.sname_id
            WHERE core.scientific_name = IN_SNAME::VARCHAR(8000)
            LIMIT 1;
        /* if not in EST then check subnational syn table */

        IF OUT_EST_ID IS NULL THEN
            SELECT
                element_subnational_id
                INTO STRICT OUT_EST_ID
                FROM core.scientific_name AS sn
                LEFT OUTER JOIN core.synonym_subnational AS ss
                    ON sn.scientific_name_id = ss.scientific_name_id
                WHERE scientific_name = in_sname;
        END IF;
        /* if name found but not a synonym then return */

        IF OUT_EST_ID IS NULL THEN
            OUT_EST_ID := '-8888'::NUMERIC;
        END IF;
        /* if not found in either place return -9999 */
        EXCEPTION
            WHEN no_data_found THEN
                OUT_EST_ID := '-9999'::NUMERIC;
    END;
    RETURN OUT_EST_ID;
END;
$BODY$
LANGUAGE  plpgsql;


CREATE OR REPLACE FUNCTION ext.federal_all(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    status CHARACTER VARYING(20);
BEGIN
    SELECT
        state_interpreted_usesa
        INTO STRICT status
        FROM core.taxon_subnational AS ts
        WHERE ts.element_subnational_id = est_id_arg;

    IF (status IS NULL) THEN
        SELECT
            tg.interpreted_usesa
            INTO STRICT status
            FROM core.element_subnational AS est
            JOIN core.element_national AS ent
                ON est.element_national_id = ent.element_national_id
            JOIN core.taxon_global AS tg
                ON ent.element_global_id = tg.element_global_id
            WHERE est_id_arg = est.element_subnational_id;
        /* FROM element_subnational est, element_national ent, taxon_global tg */
        /* WHERE est_id_arg = est.element_subnational_id */
        /* AND est.element_national_id = ent.element_national_id */
        /* AND ent.element_global_id = tg.element_global_id; */

        IF (status IS NULL) THEN
            SELECT
                usesa_cd
                INTO STRICT status
                FROM core.element_subnational AS est
                JOIN core.element_national AS ent
                    ON est.element_national_id = ent.element_national_id
                JOIN core.taxon_global AS tg
                    ON ent.element_global_id = tg.element_global_id
                JOIN domain.d_usesa
                    ON tg.d_usesa_id = domain.d_usesa.d_usesa_id
                WHERE est_id_arg = est.element_subnational_id;
        /* FROM element_subnational est, element_national ent, taxon_global tg, d_usesa */
        /* WHERE est_id_arg = est.element_subnational_id */
        /* AND est.element_national_id = ent.element_national_id */
        /* AND ent.element_global_id = tg.element_global_id */
        /* AND tg.d_usesa_id = d_usesa.d_usesa_id; */
        END IF;
    END IF;
    /* IF status IN ('No Status','UR','RT','N') THEN status := ''; */
    /* END IF; */

    IF status = 'LE' THEN
        status := 'E';
    ELSIF status = 'LE, LT' THEN
        status := 'E, T';
    ELSIF status = 'LE, PDL' THEN
        status := 'E, PDL';
    ELSIF status = 'LE, PT' THEN
        status := 'E, PT';
    ELSIF status = 'LE, XN' THEN
        status := 'E, XN';
    ELSIF status = 'LT' THEN
        status := 'T';
    ELSIF status IN ('No Status', 'N') THEN
        status := 'N';
    END IF;
    RETURN (status);
END;
$BODY$
LANGUAGE  plpgsql;


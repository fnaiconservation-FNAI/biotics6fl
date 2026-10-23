CREATE OR REPLACE FUNCTION ext.usesa_on_date(IN est_id_arg BIGINT, IN date_arg TIMESTAMP WITH TIME ZONE)
RETURNS TEXT
AS
$BODY$
DECLARE
    status CHARACTER VARYING(40);
BEGIN
    SELECT
        ext.value_on_date('TAXON_SUBNATIONAL'::TEXT, 'STATE_INTERPRETED_USESA'::TEXT, ts.element_subnational_id, date_arg)
        INTO STRICT status
        FROM core.taxon_subnational AS ts
        WHERE ts.element_subnational_id = est_id_arg;

    IF (status IS NULL) THEN
        SELECT
            ext.value_on_date('TAXON_GLOBAL'::TEXT, 'INTERPRETED_USESA'::TEXT, tg.element_global_id, date_arg)
            INTO STRICT status
            FROM core.element_subnational AS est, core.element_national AS ent, core.taxon_global AS tg
            WHERE tg.element_global_id = ent.element_global_id AND ent.element_national_id = est.element_national_id AND est.element_subnational_id = est_id_arg;

        IF (status IS NULL) THEN
            SELECT
                ext.value_on_date('TAXON_GLOBAL'::TEXT, 'D_USESA_ID'::TEXT, tg.element_global_id, date_arg)
                INTO STRICT status
                FROM core.element_subnational AS est
                JOIN core.element_national AS ent
                    ON ent.element_national_id = est.element_national_id
                JOIN core.taxon_global AS tg
                    ON tg.element_global_id = ent.element_global_id
                WHERE est.element_subnational_id = est_id_arg;
            /* FROM element_subnational est, */
            /* element_national ent, */
            /* taxon_global tg */
            /* WHERE tg.element_global_id = ent.element_global_id */
            /* and ent.element_national_id = est.element_national_id */
            /* and est.element_subnational_id = est_id_arg; */

            IF (status IS NULL) THEN
                status := 'no status';
            ELSE
                SELECT
                    fed.usesa_cd
                    INTO STRICT status
                    FROM core.element_subnational AS est
                    JOIN core.element_national AS ent
                        ON ent.element_national_id = est.element_national_id
                    JOIN core.taxon_global AS tg
                        ON tg.element_global_id = ent.element_global_id
                    JOIN domain.d_usesa AS fed
                    /* have to cast id as varchar because value_on_date can return non-numeric values */
                        ON CAST (fed.d_usesa_id AS CHARACTER VARYING(40)) = ext.value_on_date('TAXON_GLOBAL'::TEXT, 'D_USESA_ID'::TEXT, tg.element_global_id, oracle.TO_DATE('2015-01-01', 'YYYY-MM-DD'))
                    WHERE est.element_subnational_id = est_id_arg;
            /* FROM element_subnational est, */
            /* element_national ent, */
            /* taxon_global tg, */
            /* d_usesa fed */
            /* WHERE */
            /* -- have to cast id as varchar because value_on_date can return non-numeric values */
            /* CAST(fed.d_usesa_id AS VARCHAR(40)) = */
            /* value_on_date('TAXON_GLOBAL','D_USESA_ID',tg.element_global_id , TO_DATE('2015-01-01','YYYY-MM-DD')) */
            /* */
            /* --           fed.d_usesa_id = to_number(value_on_date('TAXON_GLOBAL','D_USESA_ID', */
            /* --                   tg.element_global_id , date_arg)) */
            /* and tg.element_global_id = ent.element_global_id */
            /* and ent.element_national_id = est.element_national_id */
            /* and est.element_subnational_id = est_id_arg; */
            END IF;
        END IF;
    END IF;

    IF status = 'No Status' THEN
        status := 'no status';
    END IF;
    RETURN (status);
END;
$BODY$
LANGUAGE  plpgsql;


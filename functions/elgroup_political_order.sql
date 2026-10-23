CREATE OR REPLACE FUNCTION ext.elgroup_political_order(IN est_id_arg BIGINT)
RETURNS INTEGER
AS
$BODY$
DECLARE
    sort_order INTEGER;
    elcode CHARACTER VARYING(10);
BEGIN
    SELECT
        oracle.substr(egt.elcode_bcd, 1, 2)
        INTO STRICT elcode
        FROM core.element_global AS egt
        LEFT OUTER JOIN core.element_national AS ent
            ON egt.element_global_id = ent.element_global_id
        LEFT OUTER JOIN core.element_subnational AS est
            ON ent.element_national_id = est.element_national_id
        WHERE est.element_subnational_id = est_id_arg;
    sort_order :=
    CASE
        WHEN oracle.substr(elcode, 1, 1) = 'I' THEN 7
        WHEN oracle.substr(elcode, 1, 1) IN ('P', 'N') THEN 1
    /* when substr(elcode,1,1) = 'N' then 8 */
        WHEN oracle.substr(elcode, 1, 1) = 'C' THEN 9
        WHEN oracle.substr(elcode, 1, 1) = 'A' THEN
        CASE oracle.substr(elcode, 2, 1)
            WHEN 'F' THEN 2
            WHEN 'A' THEN 3
            WHEN 'R' THEN 4
            WHEN 'B' THEN 5
            WHEN 'M' THEN 6
        END
        ELSE 10
    END;
    RETURN (sort_order);
END;
$BODY$
LANGUAGE  plpgsql;


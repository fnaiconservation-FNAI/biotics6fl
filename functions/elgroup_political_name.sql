CREATE OR REPLACE FUNCTION ext.elgroup_political_name(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    name CHARACTER VARYING(40);
    order_code CHARACTER VARYING(20);
    order_hcun CHARACTER VARYING(20);
    cls_hcun CHARACTER VARYING(20);
    elcode CHARACTER VARYING(10);
BEGIN
    SELECT
        ordr.concatenated_cd, ordr.higher_class_unit_name, cls.higher_class_unit_name, egt.elcode_bcd
        INTO STRICT order_code, order_hcun, cls_hcun, elcode
        FROM core.element_subnational AS est
        JOIN core.element_national AS ent
            ON est.element_national_id = ent.element_national_id
        JOIN core.element_global AS egt
            ON ent.element_global_id = egt.element_global_id
        LEFT OUTER JOIN core.higher_class_unit AS genus
            ON genus.higher_class_unit_id = egt.higher_class_unit_id
        LEFT OUTER JOIN core.higher_class_unit AS family
            ON family.higher_class_unit_id = genus.parent_unit_id
        LEFT OUTER JOIN core.higher_class_unit AS ordr
            ON ordr.higher_class_unit_id = family.parent_unit_id
        LEFT OUTER JOIN core.higher_class_unit AS cls
            ON cls.higher_class_unit_id = ordr.parent_unit_id
        WHERE est.element_subnational_id = est_id_arg;
    /* FROM element_subnational est, */
    /* element_global egt, */
    /* element_national ent, */
    /* higher_class_unit genus, */
    /* higher_class_unit family, */
    /* higher_class_unit ordr, */
    /* higher_class_unit cls */
    /* WHERE cls.higher_class_unit_id(+) = ordr.parent_unit_id */
    /* and ordr.higher_class_unit_id(+) = family.parent_unit_id */
    /* and family.higher_class_unit_id(+) = genus.parent_unit_id */
    /* and genus.higher_class_unit_id(+) = egt.higher_class_unit_id */
    /* and ent.element_global_id = egt.element_global_id */
    /* and est.element_national_id = ent.element_national_id */
    /* and est.element_subnational_id = est_id_arg; */
    name := 'OTHER ELEMENTS';
    /* Order_code may NOT always be an order (i.e. it may be a class or some other level) */

    IF order_code IN ('VF', 'VFGOBI') THEN
        name := 'FISH';
    END IF;

    IF order_code = 'VA' THEN
        name := 'AMPHIBIANS';
    END IF;

    IF order_code IN ('VR', 'VT', 'VC') THEN
        name := 'REPTILES';
    END IF;

    IF order_code = 'VB' THEN
        name := 'BIRDS';
    END IF;

    IF order_code = 'VM' THEN
        name := 'MAMMALS';
    END IF;

    IF order_code LIKE 'I%' THEN
        name := 'INVERTEBRATES';
    END IF;

    IF (order_code LIKE 'P%' OR elcode LIKE 'N%') THEN
        name := 'PLANTS';
    END IF;

    IF elcode LIKE 'C%' THEN
        name := 'NATURAL COMMUNITIES';
    END IF;
    RETURN (name);
END;
$BODY$
LANGUAGE  plpgsql;


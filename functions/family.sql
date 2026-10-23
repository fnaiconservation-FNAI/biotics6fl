CREATE OR REPLACE FUNCTION ext.family(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    name CHARACTER VARYING(40);
    fam_hcun CHARACTER VARYING(40);
    order_hcun CHARACTER VARYING(40);
    cls_hcun CHARACTER VARYING(40);
BEGIN
    SELECT
        family.higher_class_unit_name, ordr.higher_class_unit_name, cls.higher_class_unit_name
        INTO STRICT fam_hcun, order_hcun, cls_hcun
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
        /* FROM element_subnational est, */
        /* element_global egt, */
        /* element_national ent, */
        /* higher_class_unit genus, */
        /* higher_class_unit family, */
        /* higher_class_unit ordr, */
        /* higher_class_unit cls */
        WHERE est.element_subnational_id = est_id_arg;
    /* AND cls.higher_class_unit_id(+) = ordr.parent_unit_id */
    /* and ordr.higher_class_unit_id(+) = family.parent_unit_id */
    /* and family.higher_class_unit_id(+) = genus.parent_unit_id */
    /* and genus.higher_class_unit_id(+) = egt.higher_class_unit_id */
    /* and ent.element_global_id = egt.element_global_id */
    /* and est.element_national_id = ent.element_national_id */
    name := fam_hcun;
    RETURN (name);
END;
$BODY$
LANGUAGE  plpgsql;


CREATE OR REPLACE FUNCTION ext.ord(IN est_id_arg BIGINT)
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
        FROM core.element_subnational AS est, core.element_global AS egt, core.element_national AS ent, core.higher_class_unit AS ordr
        LEFT OUTER JOIN core.higher_class_unit AS cls
            ON (cls.higher_class_unit_id = ordr.parent_unit_id), core.higher_class_unit AS genus
        LEFT OUTER JOIN core.higher_class_unit AS family
            ON (family.higher_class_unit_id = genus.parent_unit_id)
        WHERE ent.element_global_id = egt.element_global_id AND est.element_national_id = ent.element_national_id AND est.element_subnational_id = est_id_arg;
    name := order_hcun;
    RETURN (name);
END;
$BODY$
LANGUAGE  plpgsql;


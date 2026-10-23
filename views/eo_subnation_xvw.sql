CREATE OR REPLACE  VIEW ext.eo_subnation_xvw (eo_id, subn_id, subn_cd) AS
SELECT DISTINCT
    (core.eo.eo_id), core.element_subnational.subnation_id AS subn_id, domain.subnation.subnation_code AS subn_cd
    FROM core.eo, core.shape, core.element_subnational, domain.subnation, domain.d_name_category
    WHERE core.eo.element_subnational_id = core.element_subnational.element_subnational_id AND core.element_subnational.subnation_id = domain.subnation.subnation_id AND core.element_subnational.sname_id IN (SELECT
        scientific_name_id
        FROM core.scientific_name, domain.d_name_category
        WHERE core.scientific_name.d_name_category_id = domain.d_name_category.d_name_category_id AND (domain.d_name_category.d_name_category_id != 7)) AND core.eo.shape_id = core.shape.shape_id
WITH CHECK OPTION;


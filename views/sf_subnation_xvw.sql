CREATE OR REPLACE  VIEW ext.sf_subnation_xvw (shape_id, subn_id, subn_cd) AS
SELECT
    core.source_feature.shape_id, core.element_subnational.subnation_id AS subn_id, domain.subnation.subnation_code AS subn_cd
    FROM core.source_feature, core.eo_source_feature, core.element_subnational, domain.subnation, core.eo
    WHERE core.source_feature.shape_id = core.eo_source_feature.source_feature_shape_id AND core.eo_source_feature.eo_shape_id = core.eo.shape_id AND core.eo.element_subnational_id = core.element_subnational.element_subnational_id AND core.element_subnational.subnation_id = domain.subnation.subnation_id AND core.source_feature.shape_id IN (SELECT
        core.eo_source_feature.source_feature_shape_id
        FROM core.eo_source_feature, core.eo
        WHERE core.eo_source_feature.eo_shape_id = core.eo.shape_id AND core.eo_source_feature.eo_shape_id IN (SELECT DISTINCT
            (core.eo.shape_id)
            FROM core.eo, core.shape, core.element_subnational, domain.d_name_category
            WHERE core.eo.element_subnational_id = core.element_subnational.element_subnational_id AND core.element_subnational.sname_id IN (SELECT
                scientific_name_id
                FROM core.scientific_name, domain.d_name_category
                WHERE core.scientific_name.d_name_category_id = domain.d_name_category.d_name_category_id AND (domain.d_name_category.d_name_category_id != 7)) AND core.eo.shape_id = core.shape.shape_id))
WITH CHECK OPTION;


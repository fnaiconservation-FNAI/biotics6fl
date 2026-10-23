CREATE OR REPLACE  VIEW ext.fnai_basic_src_feature_info_vw (feature_id, elcode, sname, comname, sf_locatr, sf_dscrptr) AS
SELECT
    shape.shape_id AS feature_id, ext.elcode(sf.element_subnational_id) AS elcode, ext.sci_name(sf.element_subnational_id) AS sname, ext.comm_name(sf.element_subnational_id) AS comname, sf.source_feature_locator AS sf_locatr, sf.source_feature_descriptor AS sf_dscrptr
    FROM core.source_feature AS sf, core.shape AS shape
    WHERE shape.shape_id = sf.shape_id AND shape.has_shape_ind = 'Y';


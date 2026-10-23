CREATE OR REPLACE  VIEW ext.fnai_basic_eo_rep_info_vw (feature_id, eo_id, elcode, eonum, sname, scomname, directions, lastobs, gen_descr, eodata) AS
SELECT
    core.eo.shape_id AS feature_id, core.eo.eo_id AS eo_id, ext.elcode(core.eo.element_subnational_id) AS elcode, ext.report_eonum(eo_id) AS eonum, ext.sci_name(core.eo.element_subnational_id) AS sname, ext.comm_name(core.eo.element_subnational_id) AS scomname, directions, last_obs_date AS lastobs,
    CASE
        WHEN oracle.substr(lob_loc => core.eo.gen_desc, amount => 254, "offset" => 1) IS NULL THEN 'No general description given'
        ELSE ext.clean_up(oracle.substr(oracle.substr(lob_loc => core.eo.gen_desc, amount => 254, "offset" => 1), 1, 254))
    END AS gen_descr,
    CASE
        WHEN oracle.substr(lob_loc => core.eo.eo_data, amount => 254, "offset" => 1) IS NULL THEN 'No EO data given'
        ELSE ext.clean_up(oracle.substr(oracle.substr(lob_loc => core.eo.eo_data, amount => 254, "offset" => 1), 1, 254))
    END AS eodata
    FROM core.eo;


CREATE OR REPLACE  VIEW ext.fnai_frm_comname_view (element_id, sname, scomname, fcomname) AS
SELECT
    est.element_subnational_id AS element_id, oracle.substr(ext.sci_name(est.element_subnational_id), 1, 60) AS sname, est.s_primary_common_name AS scomname, ext.frm_comm_name(est.element_subnational_id) AS fcomname
    FROM core.element_subnational AS est
    WHERE ext.frm_comm_name(est.element_subnational_id) IS NOT NULL AND est.d_eo_track_status_id = 1
    /* (it's a tracked species, i.e.track all extant and selected historical EOs) */
    ORDER BY sname;


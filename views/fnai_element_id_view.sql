CREATE OR REPLACE  VIEW ext.fnai_element_id_view (sname, scomname, elgrp_ordr, elgroup, element_id, datasens, grank, srank, federal, sprot) AS
SELECT
    oracle.substr(ext.sci_name(est.element_subnational_id), 1, 50) AS sname, est.s_primary_common_name AS scomname, ext.elgroup_sort_order(est.element_subnational_id) AS elgrp_ordr, oracle.substr(ext.elgroup_name(est.element_subnational_id), 1, 60) AS elgroup, est.element_subnational_id AS element_id,
    /* est.s_data_sensitive_ind datasens, */
    CASE
        WHEN d_data_sensitive_id = 1 THEN 'Y'
        WHEN (d_data_sensitive_id = 2 OR d_data_sensitive_id IS NULL) THEN 'N'
        WHEN d_data_sensitive_id = 3 THEN 'C'
    END AS datasens, ext.grank(est.element_subnational_id) AS grank, est.s_rank AS srank,
    CASE
        WHEN ext.federal(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(ext.federal(est.element_subnational_id), 1, 8)
    END AS federal,
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, 8)
    END AS sprot
    FROM core.element_subnational AS est
    WHERE est.d_eo_track_status_id = 1
    /* (it's a tracked species, i.e.track all extant and selected historical EOs) */
    ORDER BY sname;


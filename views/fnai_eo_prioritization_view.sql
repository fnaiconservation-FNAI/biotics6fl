CREATE OR REPLACE  VIEW ext.fnai_eo_prioritization_view (id, el_group, eo_id, sci_name, last_obs_date, eo_rank, srank, grank) AS
SELECT
    ROW_NUMBER() OVER (ORDER BY ext.grank(core.eo.element_subnational_id), ext.elgroup_sort_order(core.eo.element_subnational_id), ext.sci_name(core.eo.element_subnational_id), core.eo.last_obs_date) AS id, ext.elgroup_name(core.eo.element_subnational_id) AS el_group, eo_id, ext.sci_name(core.eo.element_subnational_id) AS sci_name, core.eo.last_obs_date, domain.d_basic_eo_rank.basic_eo_rank_cd AS eo_rank, est.s_rank AS srank, ext.grank(core.eo.element_subnational_id) AS grank
    FROM core.eo
    LEFT OUTER JOIN core.element_subnational AS est
        ON core.eo.element_subnational_id = est.element_subnational_id
    LEFT OUTER JOIN domain.d_basic_eo_rank
        ON core.eo.d_basic_eo_rank_id = domain.d_basic_eo_rank.d_basic_eo_rank_id
    WHERE grank IN ('G1', 'G1?', 'G1?Q', 'G1G2', 'G1Q', 'G1T1', 'G2', 'G2?', 'G2T1', 'G2T2') AND (domain.d_basic_eo_rank.basic_eo_rank_cd NOT LIKE '%X%' OR core.eo.d_basic_eo_rank_id IS NULL) AND est.d_eo_track_status_id = 1
    ORDER BY ext.grank(core.eo.element_subnational_id), ext.elgroup_sort_order(core.eo.element_subnational_id), ext.sci_name(core.eo.element_subnational_id), core.eo.last_obs_date;


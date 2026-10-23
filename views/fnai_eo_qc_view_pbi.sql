CREATE OR REPLACE  VIEW ext.fnai_eo_qc_view_pbi (eo_id, eo_data_link, eo_map_link, sfs, d_data_qc_status_id, map_qc_status, version_author, version_date, sname, group_name) AS
SELECT
    core.eo.eo_id AS eo_id, CONCAT_WS('', 'https://bioticsfl.natureserve.org/biotics/services/page/Eo/', core.eo.eo_id, '.html') AS eo_data_link, CONCAT_WS('', 'http://bioticsfl.natureserve.org/biotics/services/page/map.html?records=E', core.eo.eo_id) AS eo_map_link,
    CASE
        WHEN ext.nbr_src_features(core.eo.eo_id) = 1 THEN CONCAT_WS('', ext.nbr_src_features(core.eo.eo_id), ' SF')
        WHEN ext.nbr_src_features(core.eo.eo_id) > 1 THEN CONCAT_WS('', ext.nbr_src_features(core.eo.eo_id), ' SFs')
    END AS sfs,
    /* , SF_CHECK.SF_review_list SF_To_Review */
    d_data_qc_status_id, map_qc_status, core.eo.version_author_name AS version_author, core.eo.version_date AS version_date, ext.sci_name(core.eo.element_subnational_id) AS sname, ext.elgroup_name(core.eo.element_subnational_id) AS group_name
    FROM core.eo
    LEFT OUTER JOIN core.element_subnational AS est
        ON core.eo.element_subnational_id = est.element_subnational_id
    LEFT OUTER JOIN core.eo_shape
        ON core.eo.eo_id = core.eo_shape.eo_id
    LEFT OUTER JOIN core.shape
        ON core.eo.shape_id = core.shape.shape_id
    /* LEFT OUTER JOIN ( */
    /* select eo.eo_id, */
    /* listagg(sf.source_feature_id, ', ') within group (order by sf.source_feature_id) as SF_review_list */
    /* from source_feature sf */
    /* inner join eo_source_feature eo_sf on sf.source_feature_id = eo_sf.source_feature_id */
    /* inner join eo on eo_sf.eo_id = eo.eo_id */
    /* inner join shape on sf.shape_id = shape.shape_id */
    /* inner join visit on eo_sf.source_feature_id = visit.source_feature_id */
    /* where ((visit.rec_create_date > last_change_date('EO','D_DATA_QC_STATUS_ID', EO.EO_ID)) */
    /* or shape.map_qc_status <> 'P') */
    /* group by eo.eo_id */
    /* ) SF_CHECK */
    /* ON EO.EO_ID = SF_CHECK.eo_id */
    WHERE est.d_eo_track_status_id = 1 AND NOT (ext.elgroup_name(est.element_subnational_id) LIKE 'Natural Communit%' AND core.eo.eo_data IS NULL AND core.eo.gen_desc IS NULL) AND core.shape.shape_id NOT IN (SELECT
        core.shape.shape_id
        FROM core.shape
        WHERE core.shape.qc_com LIKE '%uncertain ident%') AND (d_data_qc_status_id <> 2 OR map_qc_status <> 'P')
    ORDER BY ext.elgroup_sort_order(est.element_subnational_id), ext.sci_name(est.element_subnational_id), core.eo.eo_id;


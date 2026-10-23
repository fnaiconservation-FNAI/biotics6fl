CREATE OR REPLACE  VIEW ext.fnai_eo_sources_view (eo_id, feature_id_rep, sci_name, eo_number, shape_type, feature_id_src, conc_feat_type, loc_uncert_type, loc_uncert_dist, rep_acc) AS
SELECT
    eo.eo_id AS eo_id, eo.shape_id AS feature_id_rep, oracle.substr(sn.scientific_name, 1, 40) AS sci_name, ext.report_eonum(eo.eo_id) AS eo_number, shape.shape_type, sf.shape_id AS feature_id_src, RPAD(dcft.conc_feature_type_desc, 14, ' ') AS conc_feat_type, oracle.substr(dloc.loc_uncertainty_type_desc, 1, 20) AS loc_uncert_type, sf.loc_uncertainty_distance AS loc_uncert_dist,
    /*
    get rep accuracy from the source feature, but if that's empty then use
    the overall EO rep accuracy estimate
    */
    CASE
        WHEN sf.d_est_rep_accuracy_id IS NOT NULL THEN domain.d_est_rep_accuracy.est_rep_accuracy_desc
        ELSE shared.delimlist(CONCAT_WS('', 'select D_EST_REP_ACCURACY.EST_REP_ACCURACY_DESC ', 'from eo, source_feature sf, D_EST_REP_ACCURACY, eo_source_feature ', 'where EO.D_EST_REP_ACCURACY_ID=D_EST_REP_ACCURACY.D_EST_REP_ACCURACY_ID(+) ', '  and eo.shape_id = EO_SOURCE_FEATURE.EO_SHAPE_ID ', '  and sf.SHAPE_ID=EO_SOURCE_FEATURE.SOURCE_FEATURE_SHAPE_ID ', '  and sf.SOURCE_FEATURE_ID = ', sf.source_feature_id))
    END AS rep_acc
    FROM core.scientific_name AS sn, core.element_subnational AS est, domain.d_loc_uncertainty_type AS dloc, core.shape AS shape, domain.d_conc_feature_type AS dcft, core.eo AS eo
    LEFT OUTER JOIN core.eo_source_feature AS eosf
        ON (eo.shape_id = eosf.eo_shape_id), core.source_feature AS sf
    LEFT OUTER JOIN domain.d_est_rep_accuracy
        ON (sf.d_est_rep_accuracy_id = domain.d_est_rep_accuracy.d_est_rep_accuracy_id)
    WHERE eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id AND eosf.source_feature_shape_id = sf.shape_id AND shape.shape_id = sf.shape_id AND dloc.d_loc_uncertainty_type_id = sf.d_loc_uncertainty_type_id AND dcft.d_conc_feature_type_id = sf.d_conc_feature_type_id AND shape.has_shape_ind = 'Y';


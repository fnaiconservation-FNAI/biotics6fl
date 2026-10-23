CREATE OR REPLACE  VIEW ext.fnai_src_data_for_occstatus (sf_id, feature_id, eo_id, sname, comname, eltype, data_src, grank, srank, federal, sprot, descriptor, locator, dig_com, map_com, sf_rank, descrip, directions, comments, last_vi_by, last_visit, last_data, rep_acc, cf_type, lu_type, orig_dist, lu_units, lu_distm, occ_status, overlap, join_field, eoshp_id, rpteonum, eo_num, eo_rank, eo_last_obs, eo_datasen, eo_qc_stat) AS
SELECT
    CAST (core.source_feature.source_feature_id AS NUMERIC(10, 0)) AS sf_id, core.source_feature.shape_id AS feature_id, CAST (core.eo.eo_id AS NUMERIC(10, 0)) AS eo_id, ext.sci_name(core.source_feature.element_subnational_id) AS sname, ext.comm_name(core.source_feature.element_subnational_id) AS comname,
    CASE
        WHEN oracle.substr(ext.elcode(est.element_subnational_id), 1, 1) = 'A' THEN 'Animals'
        WHEN oracle.substr(ext.elcode(est.element_subnational_id), 1, 1) = 'I' THEN (CASE
            WHEN oracle.substr(ext.elcode(est.element_subnational_id), 1, 2) IN ('II', 'IL') THEN 'Inverts-insects'
            ELSE 'Inverts-other'
        END)
        WHEN oracle.substr(ext.elcode(est.element_subnational_id), 1, 1) IN ('P', 'N') THEN 'Plants'
        WHEN ext.elcode(est.element_subnational_id) LIKE 'C%' THEN 'Nat. community'
        WHEN ext.elcode(est.element_subnational_id) LIKE 'G%' THEN 'Geological feature'
        ELSE 'Other elements'
    END AS eltype, 'Biotics' AS data_src, ext.grank(est.element_subnational_id) AS grank, est.s_rank AS srank,
    /* case when est_usesa(est.element_subnational_id) is null then 'N' */
    /* else substr(est_usesa(est.element_subnational_id),1,8) */
    /* end as federal, */
    CASE
        WHEN ext.federal(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(ext.federal(est.element_subnational_id), 1, 8)
    END AS federal,
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, 8)
    END AS sprot,
    /* Added 201109 */
    core.source_feature.source_feature_descriptor AS descriptor, core.source_feature.source_feature_locator AS locator, core.source_feature.digitizing_com AS dig_com, core.source_feature.mapping_com AS map_com, ext.d_source_feature_rank.source_feature_rank_desc AS sf_rank, ext.source_feature_flext1.description AS descrip, ext.source_feature_flext1.directions, ext.source_feature_flext1.comments, obs_data.visited_by AS last_vi_by, obs_data.visit_date AS last_visit, obs_data.visit_notes AS last_data,
    /*
    get rep accuracy from the source feature, but if that's empty then use
    the overall EO rep accuracy estimate
    */
    CASE
        WHEN core.source_feature.d_est_rep_accuracy_id IS NOT NULL THEN domain.d_est_rep_accuracy.est_rep_accuracy_desc
        ELSE (SELECT
            STRING_AGG(domain.d_est_rep_accuracy.est_rep_accuracy_desc, ', '::TEXT ORDER BY domain.d_est_rep_accuracy.est_rep_accuracy_desc)
            FROM core.eo
            JOIN core.eo_source_feature AS esf
                ON core.eo.shape_id = esf.eo_shape_id
            JOIN core.source_feature AS sf
                ON sf.shape_id = esf.source_feature_shape_id
            LEFT OUTER JOIN domain.d_est_rep_accuracy
                ON core.eo.d_est_rep_accuracy_id = domain.d_est_rep_accuracy.d_est_rep_accuracy_id
            WHERE sf.source_feature_id = core.source_feature.source_feature_id)
    END AS rep_acc,
    /* case when SOURCE_FEATURE.D_EST_REP_ACCURACY_ID is not null */
    /* then D_EST_REP_ACCURACY.EST_REP_ACCURACY_DESC */
    /* else delimlist ('select D_EST_REP_ACCURACY.EST_REP_ACCURACY_DESC ' || */
    /* 'from eo, source_feature sf, D_EST_REP_ACCURACY, eo_source_feature ' || */
    /* 'where EO.D_EST_REP_ACCURACY_ID=D_EST_REP_ACCURACY.D_EST_REP_ACCURACY_ID(+) ' || */
    /* '  and eo.shape_id = EO_SOURCE_FEATURE.EO_SHAPE_ID ' || */
    /* '  and sf.SHAPE_ID=EO_SOURCE_FEATURE.SOURCE_FEATURE_SHAPE_ID ' || */
    /* '  and sf.SOURCE_FEATURE_ID = ' || SOURCE_FEATURE.SOURCE_FEATURE_ID) */
    /* end as rep_acc, */
    domain.d_conc_feature_type.conc_feature_type_desc AS cf_type, domain.d_loc_uncertainty_type.loc_uncertainty_type_desc AS lu_type, core.source_feature.loc_uncertainty_distance AS orig_dist, domain.d_unit.unit_keyword AS lu_units,
    /* IMPORTANT NOTE: */
    /* the language below was designed for when LU wasn't incorporated into source features (pre-Biotics5) */
    /* in Biotics 5 LU is incoporated into all sfs so all that needs to be done to create fleo sources is to buffer points and lines */
    /* so that the are visible at the mmu (4.5m buffer) */
    
    /*
    convert the loc uncert distance to meters
    If there is no distance, use loc uncert type.
    */
    CASE
        WHEN domain.d_unit.unit_keyword = 'METERS' THEN core.source_feature.loc_uncertainty_distance
        WHEN domain.d_unit.unit_keyword = 'FEET' THEN ROUND(core.source_feature.loc_uncertainty_distance * 0.3048, 2)
        WHEN domain.d_unit.unit_keyword = 'KILOMETERS' THEN core.source_feature.loc_uncertainty_distance * 1000
        WHEN domain.d_unit.unit_keyword = 'MILES' THEN ROUND(core.source_feature.loc_uncertainty_distance * 1609.344, 2)
    /* else case when D_LOC_UNCERTAINTY_TYPE.LOC_UNCERTAINTY_TYPE_DESC in */
    /* ('Negligible','Linear') then 4.5 */
    /* when D_LOC_UNCERTAINTY_TYPE.LOC_UNCERTAINTY_TYPE_DESC = */
    /* 'Areal - Delimited' then 0.01 */
    
    /* above section rewritten 20110930 as follows: */
    /* 1007 = point, 1008 = line */
        ELSE
        CASE
            WHEN shape1.feature_code IN (1007, 1008) AND domain.d_loc_uncertainty_type.loc_uncertainty_type_desc IN ('Negligible', 'Linear') THEN 4.5
        /* 1009 = polygon */
            WHEN shape1.feature_code IN (1009) AND domain.d_loc_uncertainty_type.loc_uncertainty_type_desc IN ('Negligible', 'Delimited') THEN 0
        /*
        note - even though the distance should be zero for areal delimited, we
        introduce a small distance so ArcMap will be forced to buffer the shape.
        (ArcMap drops shapes with zero distance in its buffer routine)
        */
        END
    END AS lu_distm, 'Occurrence status not assigned' AS occ_status, /* initialize occ_status */ CAST (0.0 AS NUMERIC(6, 2)) AS overlap, 'not assigned' AS join_field, COALESCE(core.eo.principal_eo_shape_id, core.eo.shape_id) AS eoshp_id, ext.report_eonum(core.eo.eo_id) AS rpteonum, CAST (core.eo.eo_num AS NUMERIC(10, 0)) AS eo_num,
    CASE
        WHEN domain.d_basic_eo_rank.basic_eo_rank_cd IS NULL THEN 'NR'
        ELSE domain.d_basic_eo_rank.basic_eo_rank_cd
    END AS eo_rank, core.eo.last_obs_date AS eo_last_obs,
    /* eo.data_sensitive_eo_ind as datasens, */
    CASE
        WHEN est.d_data_sensitive_id = 1 THEN 'Y'
        ELSE
        CASE
            WHEN core.eo.d_data_sensitive_id = 1 THEN 'Y'
            WHEN (core.eo.d_data_sensitive_id = 2 OR core.eo.d_data_sensitive_id IS NULL) THEN 'N'
            WHEN core.eo.d_data_sensitive_id = 3 THEN 'C'
        END
    END AS eo_datasen,
    CASE
        WHEN (core.eo.d_data_qc_status_id = 2 AND core.shape.map_qc_status = 'P') THEN 'P'
        WHEN (core.eo.d_data_qc_status_id = 3 OR core.shape.map_qc_status = 'F') THEN 'F'
        ELSE 'I'
    END AS eo_qc_stat
    FROM core.eo
    LEFT OUTER JOIN core.element_subnational AS est
        ON core.eo.element_subnational_id = est.element_subnational_id
    LEFT OUTER JOIN core.shape
    /* EO Shape */
        ON core.eo.shape_id = core.shape.shape_id
    LEFT OUTER JOIN core.eo_source_feature
        ON core.eo.shape_id = core.eo_source_feature.eo_shape_id
    LEFT OUTER JOIN core.source_feature
        ON core.eo_source_feature.source_feature_shape_id = core.source_feature.shape_id
    LEFT OUTER JOIN core.shape AS shape1
    /* Src Shape */
        ON core.source_feature.shape_id = shape1.shape_id
    LEFT OUTER JOIN ext.source_feature_flext1
        ON core.source_feature.source_feature_id = ext.source_feature_flext1.source_feature_id
    LEFT OUTER JOIN domain.d_conc_feature_type
        ON domain.d_conc_feature_type.d_conc_feature_type_id = core.source_feature.d_conc_feature_type_id
    LEFT OUTER JOIN domain.d_loc_uncertainty_type
        ON core.source_feature.d_loc_uncertainty_type_id = domain.d_loc_uncertainty_type.d_loc_uncertainty_type_id
    LEFT OUTER JOIN domain.d_basic_eo_rank
        ON core.eo.d_basic_eo_rank_id = domain.d_basic_eo_rank.d_basic_eo_rank_id
    LEFT OUTER JOIN domain.d_est_rep_accuracy
        ON core.source_feature.d_est_rep_accuracy_id = domain.d_est_rep_accuracy.d_est_rep_accuracy_id
    LEFT OUTER JOIN domain.d_unit
        ON core.source_feature.loc_uncertainty_unit_id = domain.d_unit.d_unit_id
    LEFT OUTER JOIN ext.d_source_feature_rank
        ON ext.source_feature_flext1.d_source_feature_rank_id = ext.d_source_feature_rank.d_source_feature_rank_id
    LEFT OUTER JOIN
    /* Subquery below selects src obs with max dates and unions with src obs with no date */
    /* luckily all srcs with obs with no date have only one obs so far, but this should be */
    /* checked when this view is used */
    (SELECT
        source_feature_id, visited_by, visit_date, visit_notes
        FROM (SELECT
            source_feature_id, visited_by, visit_date, visit_notes, replace(oracle.substr(visit_date, 1, 10), '-', '') AS date_, MAX(replace(oracle.substr(visit_date, 1, 10), '-', '')) OVER (PARTITION BY source_feature_id) AS max_date
            FROM core.visit) AS var_sbq
        WHERE date_ = max_date
    UNION
    SELECT
        source_feature_id, core.visit.visited_by, core.visit.visit_date, core.visit.visit_notes
        FROM core.visit
        WHERE visit_date IS NULL) AS obs_data
        ON core.source_feature.source_feature_id = obs_data.source_feature_id
    WHERE
    /*
    EXCLUDE parent EOs from the view (all of their sources should
    be represented as sources in sub-EOs)
    */
    core.eo.shape_id NOT IN (SELECT DISTINCT
        (core.eo.principal_eo_shape_id)
        FROM core.eo
        WHERE core.eo.principal_eo_shape_id > 0) AND
    /* tracked elements only */
    est.d_eo_track_status_id = 1 AND
    /* EOs Identification Confirmed = 'Y' Only */
    core.eo.d_id_confirmed_id = 2
/* Testing SubSet */
/* and eo.ELEMENT_SUBNATIONAL_ID in (18098,22211) */
;


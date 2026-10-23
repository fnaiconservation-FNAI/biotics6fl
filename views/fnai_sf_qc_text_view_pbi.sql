CREATE OR REPLACE  VIEW ext.fnai_sf_qc_text_view_pbi (sci_name, "Filters_FeatureSearches_ForMap", eo_link, sf_link, sf_map_link, map_type, lu_type, lu_dist, created_, mapper, sf_descriptor, sf_locator, map_com, obs_area, obs_unit, line_l, line_u, source_feature_visit_notes, visit_date, visited_by, last_visit_detected, sf_rank, ref, source_feature_gen_description, source_feature_directions, source_feature_comments, eo_data_qc, sf_qc_status, sf_qc_comment, eo_v_author, eo_id, source_feature_id, d_data_qc_status_id, map_qc_status, version_author, version_date, sname, group_name) AS
SELECT
    core.scientific_name.scientific_name AS sci_name, CONCAT_WS('', 'Filter sname=''', core.scientific_name.scientific_name, ''', FeatureSearch SOURCE_FEATURE_ID =', core.source_feature.source_feature_id) AS "Filters_FeatureSearches_ForMap", CONCAT_WS('', 'https://bioticsfl.natureserve.org/biotics/services/page/Eo/', core.eo.eo_id, '.html') AS eo_link,
    /* , 'EOID: '||'<a href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/'||eo.eo_id||'.html" target="_blank">'||(eo.eo_id)||'</a>'  eoid */
    CONCAT_WS('', 'https://bioticsfl.natureserve.org/biotics/services/page/SourceFeature/', core.source_feature.source_feature_id, '.html') AS sf_link, CONCAT_WS('', 'http://bioticsfl.natureserve.org/biotics/services/page/map.html?records=S', core.source_feature.source_feature_id) AS sf_map_link,
    CASE
        WHEN ext.pre_sf_type(core.source_feature.source_feature_id) = 'PT' THEN 'view point'
        WHEN ext.pre_sf_type(core.source_feature.source_feature_id) = 'PY' THEN 'view poly'
        WHEN ext.pre_sf_type(core.source_feature.source_feature_id) = 'LN' THEN 'view line'
        ELSE 'unknown'
    END AS map_type,
    CASE
        WHEN COALESCE(ST_Area((sf_py).shape), 1) > 100 AND core.source_feature.d_loc_uncertainty_type_id = 1 THEN 'LU cannot be Negligible for polygons over 100 acres in size.'
        ELSE CONCAT_WS('', 'LU: ', domain.d_loc_uncertainty_type.loc_uncertainty_type_desc)
    END AS lu_type,
    CASE
        WHEN core.source_feature.d_loc_uncertainty_type_id = 5 THEN CONCAT_WS('', 'LU Dist: ', core.source_feature.loc_uncertainty_distance)
        ELSE 'N/A'
    END AS lu_dist, CONCAT_WS('', 'SF Created: ', oracle.to_char(core.source_feature.rec_create_date, 'YYYY-MM-DD')) AS created_, CONCAT_WS('', 'SF mapped by: ', COALESCE((SELECT
        "Full Name"
        FROM security.security_users_vw
        WHERE "Username" = LOWER(core.shape.rec_create_user)), core.shape.rec_create_user)) AS mapper,
    CASE
        WHEN core.source_feature.source_feature_descriptor IS NULL THEN 'SF Descriptor is required'
        ELSE core.source_feature.source_feature_descriptor
    END AS sf_descriptor,
    CASE
        WHEN core.source_feature.source_feature_locator IS NULL THEN NULL
        ELSE core.source_feature.source_feature_locator
    END AS sf_locator,
    CASE
        WHEN (ext.pre_sf_type(core.source_feature.source_feature_id) = 'PT' AND core.source_feature.mapping_com IS NULL) THEN 'No comment needed'
        WHEN ((ext.pre_sf_type(core.source_feature.source_feature_id) = 'PY' OR ext.pre_sf_type(core.source_feature.source_feature_id) = 'LN') AND core.source_feature.mapping_com IS NULL AND core.source_feature.rec_create_date > oracle.TO_DATE('2011-07-19', 'YYYY-MM-DD')) THEN 'Mapping comments are required for post-2011-07-20 line and polygon source features'
        WHEN ((ext.pre_sf_type(core.source_feature.source_feature_id) = 'PY' OR ext.pre_sf_type(core.source_feature.source_feature_id) = 'LN') AND core.source_feature.mapping_com IS NULL AND core.source_feature.rec_create_date < oracle.TO_DATE('2011-07-20', 'YYYY-MM-DD')) THEN 'Please enter mapping comments for this older polygon or line source feature if possible'
        ELSE core.source_feature.mapping_com
    END AS map_com,
    CASE
        WHEN core.source_feature.obs_feature_area IS NULL THEN 'Please estimate Observed Feature Area if possible'
        ELSE 'check passed'
    END AS obs_area,
    CASE
        WHEN (core.source_feature.obs_feature_area_unit_id IS NULL AND NOT (core.source_feature.obs_feature_area IS NULL)) THEN 'NULL!'
        ELSE ' '
    END AS obs_unit,
    CASE
        WHEN (core.source_feature.obs_feature_length = 0 AND core.shape.feature_code = 1008) THEN 'Please estimate Observed Feature Length for lines'
        ELSE 'check passed'
    END AS line_l,
    CASE
        WHEN (core.source_feature.obs_feature_length_unit_id = 0 AND core.shape.feature_code = 1008 AND core.source_feature.obs_feature_length > 0) THEN 'Observed Feature Length needs units'
        ELSE 'check passed'
    END AS line_u,
    /* ,  scientific_name.formatted_scientific_name|| ' EO#'||'<a href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/'|| */
    /* eo.eo_id||'.html" target="_blank">'||(eo.eo_num)||'</a>'||' SFID: ' */
    /* ||'<a href="https://bioticsfl.natureserve.org/biotics/services/page/SourceFeature/'||SOURCE_FEATURE.SOURCE_FEATURE_ID||'.html" target="_blank">' */
    /* ||SOURCE_FEATURE.SOURCE_FEATURE_ID||'</a>' */
    /* as EO_SF */
    CASE
        WHEN core.visit.visit_notes IS NULL THEN 'Visit Notes are required'
        WHEN (core.visit.visit_notes LIKE '%. 19__:%' OR core.visit.visit_notes LIKE '%. 20__:%' OR core.visit.visit_notes LIKE '% 19__:%' OR core.visit.visit_notes LIKE '% 20__:%' OR core.visit.visit_notes LIKE '% 19__-Pre%' OR core.visit.visit_notes LIKE '% 20__-Pre%' OR core.visit.visit_notes LIKE '%. 19__-%' OR core.visit.visit_notes LIKE '%. 20__-%' OR core.visit.visit_notes LIKE '%. <b>19__:%' OR core.visit.visit_notes LIKE '%. <b>20__:%' OR core.visit.visit_notes LIKE '%. <b>19__-%' OR core.visit.visit_notes LIKE '%. <b>20__-%' OR core.visit.visit_notes LIKE '%.  <b>19__:%' OR core.visit.visit_notes LIKE '%.  <b>20__:%' OR core.visit.visit_notes LIKE '%.  <b>19__-%' OR core.visit.visit_notes LIKE '%.  <b>20__-%' OR core.visit.visit_notes LIKE '% <b>19__</b>:%' OR core.visit.visit_notes LIKE '% <b>20__</b>:%' OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), '19__-%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), '20__-%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), ' 19__-%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), ' 20__-%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), '19__:%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), '20__:%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), ' 19__:%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), ' 20__:%')) THEN CONCAT_WS('', 'Does this have multiple visits that need to be separated or dates that need to be removed?: ', core.visit.visit_notes)
        ELSE core.visit.visit_notes
    END AS source_feature_visit_notes,
    CASE
        WHEN ext.chk_txt_date(visit_date) LIKE 'Valid%' THEN core.visit.visit_date
        WHEN ext.chk_txt_date(visit_date) LIKE 'Invalid%' THEN CONCAT_WS('', ext.chk_txt_date(visit_date), ' - ', core.visit.visit_date)
        ELSE core.visit.visit_date
    END AS visit_date,
    CASE
        WHEN core.visit.visited_by IS NULL THEN 'Visited By is required'
        ELSE core.visit.visited_by
    END AS visited_by,
    CASE
        WHEN last_visit.detected = 'Y' AND ext.source_feature_flext1.d_source_feature_rank_id IN (2, 3) THEN 'SF Rank cannot be Failed2Find or Extirpated if last visit detected = Y'
        WHEN last_visit.detected = 'N' AND ext.source_feature_flext1.d_source_feature_rank_id = 1 THEN 'SF Rank cannot be Extant if last visit detected = N'
        ELSE last_visit.detected
    END AS last_visit_detected,
    CASE
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 2 AND ext.nbr_obs(core.source_feature.source_feature_id) = 1 THEN 'SFs cannot be Failed2Find and only have one visit.'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 3 AND ext.nbr_obs(core.source_feature.source_feature_id) = 1 THEN 'SFs cannot be Extirpated and only have one visit. If rank is based on aerials, please enter a visit with the date of the aerials.'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id IS NULL THEN 'SF Rank is required'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 1 THEN 'Extant'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 2 AND ext.nbr_obs(core.source_feature.source_feature_id) > 1 THEN 'Failed2Find'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 3 AND ext.nbr_obs(core.source_feature.source_feature_id) > 1 THEN 'Extirpated'
        ELSE 'Weird'
    END AS sf_rank,
    CASE
        WHEN core.source_feature.source_feature_id IN (SELECT
            source_feature_id
            FROM core.source_feature_ref) THEN 'check passed'
        ELSE 'A Reference is required'
    END AS ref,
    CASE
        WHEN ext.source_feature_flext1.description IS NULL THEN NULL
        ELSE CONCAT_WS('', 'SF Description: ', ext.clean_up(ext.source_feature_flext1.description))
    END AS source_feature_gen_description,
    CASE
        WHEN ext.source_feature_flext1.directions IS NULL THEN ' '
        ELSE CONCAT_WS('', 'SF Directions: ', ext.clean_up(ext.source_feature_flext1.directions))
    END AS source_feature_directions,
    CASE
        WHEN ext.source_feature_flext1.comments IS NULL THEN ' '
        ELSE CONCAT_WS('', 'SF Comments: ', ext.clean_up(ext.source_feature_flext1.comments))
    END AS source_feature_comments,
    CASE
        WHEN core.eo.d_data_qc_status_id IS NULL THEN 'NULL'
        WHEN core.eo.d_data_qc_status_id = 1 THEN 'incomplete'
        WHEN core.eo.d_data_qc_status_id = 3 THEN 'Failed'
        ELSE 'Passed'
    END AS eo_data_qc,
    CASE
        WHEN core.shape.map_qc_status = 'P' THEN 'Passed'
        WHEN core.shape.map_qc_status <> 'P' AND core.eo.d_data_qc_status_id = 2 THEN 'Not Passed'
        ELSE 'Not Passed'
    END AS sf_qc_status, core.shape.qc_com AS sf_qc_comment, core.eo.version_author_name AS eo_v_author, core.eo.eo_id, core.source_feature.source_feature_id, core.eo.d_data_qc_status_id, shape2.map_qc_status, core.eo.version_author_name AS version_author, core.eo.version_date AS version_date, ext.sci_name(core.eo.element_subnational_id) AS sname, ext.elgroup_name(core.eo.element_subnational_id) AS group_name
    FROM core.eo
    LEFT OUTER JOIN core.eo_source_feature
        ON core.eo.eo_id = core.eo_source_feature.eo_id
    LEFT OUTER JOIN core.source_feature
        ON core.eo_source_feature.source_feature_id = core.source_feature.source_feature_id
    LEFT OUTER JOIN core.shape
        ON core.source_feature.shape_id = core.shape.shape_id
    LEFT OUTER JOIN core.shape AS shape2
        ON core.eo.shape_id = shape2.shape_id
    LEFT OUTER JOIN core.source_feature_poly AS sf_py
        ON core.source_feature.source_feature_id = sf_py.source_feature_id
    LEFT OUTER JOIN ext.source_feature_flext1
        ON core.source_feature.source_feature_id = ext.source_feature_flext1.source_feature_id
    LEFT OUTER JOIN ext.eo_flext1
        ON core.eo.eo_id = ext.eo_flext1.eo_id
    LEFT OUTER JOIN core.element_subnational AS est
        ON est.element_subnational_id = core.eo.element_subnational_id
    LEFT OUTER JOIN core.visit
        ON core.source_feature.source_feature_id = core.visit.source_feature_id
    LEFT OUTER JOIN core.scientific_name
        ON est.sname_id = core.scientific_name.scientific_name_id
    LEFT OUTER JOIN ext.fnai_eo_status_view
        ON core.eo.eo_id = ext.fnai_eo_status_view.eo_id
    LEFT OUTER JOIN domain.d_loc_uncertainty_type
        ON core.source_feature.d_loc_uncertainty_type_id = domain.d_loc_uncertainty_type.d_loc_uncertainty_type_id
    LEFT OUTER JOIN (SELECT
        last_visit_date, core.visit.detected_ind AS detected, core.visit.visit_notes AS last_visit_notes, core.visit.visited_by AS last_visited_by, mxvisit.source_feature_id AS sfid
        FROM (SELECT
            MAX(visit_date) AS last_visit_date, core.visit.source_feature_id
            FROM core.visit
            GROUP BY core.visit.source_feature_id) AS mxvisit
        INNER JOIN core.visit
            ON mxvisit.source_feature_id = core.visit.source_feature_id AND mxvisit.last_visit_date = core.visit.visit_date) AS last_visit
        ON ext.source_feature_flext1.source_feature_id = last_visit.sfid
    WHERE
    /* include tracked only for all */
    est.d_eo_track_status_id = 1
    ORDER BY ext.elgroup_sort_order(est.element_subnational_id), ext.sci_name(est.element_subnational_id), core.eo.eo_num ASC, oracle.to_number(core.source_feature.source_feature_id) ASC;


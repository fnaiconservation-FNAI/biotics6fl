CREATE OR REPLACE  VIEW ext.fnai_sf_qc_view (sci_name, "Filters_FeatureSearches_ForMap", "EO#", eoid, type, lu_type, lu_dist, created_, mapper, sf_descriptor, sf_qc_status, digitizing_base, sf_locator, map_com, obs_area, obs_unit, line_l, line_u, eo_sf, source_feature_visit_notes, vst_date, vstd_by, last_visit_detected, sf_rank, ref, eo_sf_, source_feature_gen_description, source_feature_directions, source_feature_comments, eo_data_qc, sf_qc_comment, eo_v_author, eo_id, source_feature_id, d_data_qc_status_id, map_qc_status, version_author, version_date, sname, group_name, element_track_status, qc_comments) AS
SELECT
    ext.concatt('<HTML>'::TEXT, core.scientific_name.formatted_scientific_name) AS sci_name, CONCAT_WS('', 'Filter<br>sname=''', core.scientific_name.scientific_name, '''<br><br>FeatureSearch<br>SOURCE_FEATURE_ID =', core.source_feature.source_feature_id) AS "Filters_FeatureSearches_ForMap", CONCAT_WS('', '<HTML>EO#', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/', core.eo.eo_id, '.html" target="_blank">', (core.eo.eo_num), '</a>') AS "EO#", CONCAT_WS('', '<HTML>EOID: ', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/', core.eo.eo_id, '.html" target="_blank">', (core.eo.eo_id), '</a>') AS eoid, CONCAT_WS('', '<HTML>SFID: ', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/SourceFeature/', core.source_feature.source_feature_id, '.html" target="_blank">', core.source_feature.source_feature_id, '</a>', ' or ', ' <a href="http://bioticsfl.natureserve.org/biotics/services/page/map.html?records=S', core.source_feature.source_feature_id, '" target="_blank">', ' View ', '</a>',
    CASE
        WHEN ext.pre_sf_type(core.source_feature.source_feature_id) = 'PT' THEN 'point'
        WHEN ext.pre_sf_type(core.source_feature.source_feature_id) = 'PY' THEN 'poly'
        WHEN ext.pre_sf_type(core.source_feature.source_feature_id) = 'LN' THEN 'line'
        ELSE 'unknown'
    END) AS type,
    CASE
        WHEN COALESCE(ST_Area((sf_py).shape), 1) > 100 AND core.source_feature.d_loc_uncertainty_type_id = 1 THEN '<div style="display: inline-block; width: 28ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">LU cannot be Negligible for polygons over 100 acres in size.</div>'
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
        WHEN core.source_feature.source_feature_descriptor IS NULL THEN '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SF Descriptor is required'
        ELSE CONCAT_WS('', 'SF Descriptor: ', core.source_feature.source_feature_descriptor)
    END AS sf_descriptor,
    CASE
        WHEN core.shape.map_qc_status = 'P' AND core.source_feature.d_data_qc_status_id = 2 THEN 'SF QC: Passed'
        WHEN core.shape.map_qc_status = 'P' AND (core.source_feature.d_data_qc_status_id IS NULL OR core.source_feature.d_data_qc_status_id = 1) THEN '<HTML><img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">SF QC: Map QC Passed, Data QC Incomplete.<br /> Please QC the SF data.'
        WHEN core.shape.map_qc_status = 'F' OR core.source_feature.d_data_qc_status_id = 3 THEN '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SF QC: Failed<br />Failing SF must be separated from the EO'
        ELSE '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SF QC: Not Passed'
    END AS sf_qc_status,
    CASE
        WHEN core.source_feature.d_digitizing_base_id IS NULL AND (core.source_feature.rec_create_date >= oracle.TO_DATE('2026-05-27', 'YYYY-MM-DD') OR core.eo.version_date >= oracle.TO_DATE('2026-05-27', 'YYYY-MM-DD')) THEN '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">Digitizing Base is required'
        WHEN core.source_feature.d_digitizing_base_id IS NULL THEN '<HTML><img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">Please enter a Digitizing Base value for this source feature'
        WHEN core.source_feature.d_digitizing_base_id <= 16 AND core.source_feature.mapping_com LIKE '%www.inaturalist.org/observations/%' THEN CONCAT_WS('', '<HTML><img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">Digitizing Base:<br /> The curent value is ', digi_base.display_value, '<br />', '. The Digitizing Base for most iNaturalist observations is "Unknown" as this information is rarely documented in iNat.')
        WHEN core.source_feature.d_digitizing_base_id IN (7, 11) AND d_conc_feature_type_id = 3 AND LOWER(core.source_feature.mapping_com) LIKE '%polygon%' AND LOWER(core.source_feature.mapping_com) NOT LIKE '%points%' THEN CONCAT_WS('', '<HTML><img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">Digitizing Base:<br /> The curent value is ', digi_base.display_value, '<br />', '. Please review the SF digitizing base value. Most polygon SFs are "Other: see comments"')
        ELSE CONCAT_WS('', 'DIGITIZING BASE: ', digi_base.display_value)
    END AS digitizing_base,
    CASE
        WHEN core.source_feature.source_feature_locator IS NULL THEN NULL
        ELSE CONCAT_WS('', 'SF Locator: ', core.source_feature.source_feature_locator)
    END AS sf_locator,
    CASE
        WHEN (ext.pre_sf_type(core.source_feature.source_feature_id) = 'PT' AND core.source_feature.mapping_com IS NULL) THEN '<HTML>&#x2713;'
        WHEN ((ext.pre_sf_type(core.source_feature.source_feature_id) = 'PY' OR ext.pre_sf_type(core.source_feature.source_feature_id) = 'LN') AND core.source_feature.mapping_com IS NULL AND core.source_feature.rec_create_date > oracle.TO_DATE('2011-07-19', 'YYYY-MM-DD')) THEN '</span><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">Mapping comments are required for post-2011-07-20 line and polygon source features</span>'
        WHEN ((ext.pre_sf_type(core.source_feature.source_feature_id) = 'PY' OR ext.pre_sf_type(core.source_feature.source_feature_id) = 'LN') AND core.source_feature.mapping_com IS NULL AND core.source_feature.rec_create_date < oracle.TO_DATE('2011-07-20', 'YYYY-MM-DD')) THEN '<HTML><img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">Please enter mapping comments for this older polygon or line source feature if possible'
        ELSE CONCAT_WS('', 'Map Coms: ', core.source_feature.mapping_com)
    END AS map_com,
    CASE
        WHEN core.source_feature.obs_feature_area IS NULL THEN '<HTML><img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">Please estimate Observed Feature Area if possible'
        ELSE '<HTML>&#x2713;'
    END AS obs_area,
    CASE
        WHEN (core.source_feature.obs_feature_area_unit_id IS NULL AND NOT (core.source_feature.obs_feature_area IS NULL)) THEN '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">NULL!'
        ELSE ' '
    END AS obs_unit,
    CASE
        WHEN (core.source_feature.obs_feature_length = 0 AND core.shape.feature_code = 1008) THEN '<HTML><img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">Please estimate Observed Feature Length for lines'
        ELSE '<HTML>&#x2713;'
    END AS line_l,
    CASE
        WHEN (core.source_feature.obs_feature_length_unit_id = 0 AND core.shape.feature_code = 1008 AND core.source_feature.obs_feature_length > 0) THEN '<div style="display: inline-block; width: 20ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">Observed Feature Length needs units</div>'
        ELSE '<HTML>&#x2713;'
    END AS line_u, CONCAT_WS('', ext.concatt('<HTML>'::TEXT, core.scientific_name.formatted_scientific_name), ' EO#', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/', core.eo.eo_id, '.html" target="_blank">', (core.eo.eo_num), '</a>', ' SFID: ', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/SourceFeature/', core.source_feature.source_feature_id, '.html" target="_blank">', core.source_feature.source_feature_id, '</a>') AS eo_sf,
    CASE
        WHEN core.visit.visit_notes IS NULL THEN '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">Visit Notes are required'
        WHEN (core.visit.visit_notes LIKE '%. 19__:%' OR core.visit.visit_notes LIKE '%. 20__:%' OR core.visit.visit_notes LIKE '% 19__:%' OR core.visit.visit_notes LIKE '% 20__:%' OR core.visit.visit_notes LIKE '% 19__-Pre%' OR core.visit.visit_notes LIKE '% 20__-Pre%' OR core.visit.visit_notes LIKE '%. 19__-%' OR core.visit.visit_notes LIKE '%. 20__-%' OR core.visit.visit_notes LIKE '%. <b>19__:%' OR core.visit.visit_notes LIKE '%. <b>20__:%' OR core.visit.visit_notes LIKE '%. <b>19__-%' OR core.visit.visit_notes LIKE '%. <b>20__-%' OR core.visit.visit_notes LIKE '%.  <b>19__:%' OR core.visit.visit_notes LIKE '%.  <b>20__:%' OR core.visit.visit_notes LIKE '%.  <b>19__-%' OR core.visit.visit_notes LIKE '%.  <b>20__-%' OR core.visit.visit_notes LIKE '% <b>19__</b>:%' OR core.visit.visit_notes LIKE '% <b>20__</b>:%' OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), '19__-%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), '20__-%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), ' 19__-%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), ' 20__-%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), '19__:%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), '20__:%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), ' 19__:%') OR core.visit.visit_notes LIKE CONCAT_WS('', '%', CHR(160), ' 20__:%')) THEN CONCAT_WS('', '<div style="display: inline-block; width: 45ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">Does this have multiple visits that need to be separated or dates that need to be removed?: </div>', core.visit.visit_notes)
        WHEN core.visit.visit_notes LIKE '%Visit notes need to be entered manually%' THEN CONCAT_WS('', '<div style="display: inline-block; width: 20ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">Visit notes need to be edited or entered manually: </div>', core.visit.visit_notes)
        ELSE CONCAT_WS('', 'Visit Notes: ', core.visit.visit_notes)
    END AS source_feature_visit_notes,
    CASE
        WHEN ext.chk_txt_date(visit_date) LIKE 'Valid%' THEN CONCAT_WS('', 'Visit Date: ', core.visit.visit_date)
        WHEN ext.chk_txt_date(visit_date) LIKE 'Invalid%' THEN CONCAT_WS('', '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">', ext.chk_txt_date(visit_date), '<br>', core.visit.visit_date)
        ELSE CONCAT_WS('', 'Visit Date: ', core.visit.visit_date)
    END AS vst_date,
    CASE
        WHEN core.visit.visited_by IS NULL THEN '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">Visited By<br>is required'
        ELSE CONCAT_WS('', 'Visited By: ', core.visit.visited_by)
    END AS vstd_by,
    CASE
        WHEN last_visit.detected = 'Y' AND ext.source_feature_flext1.d_source_feature_rank_id IN (2, 3) THEN
        /* then '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SF Rank cannot be Failed2Find or Extirpated if last visit detected = Y' */
        '<div style="display: inline-block; width: 28ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SF Rank cannot be Failed2Find or<br>Extirpated if last visit detected = Y</div>'
        WHEN last_visit.detected = 'N' AND ext.source_feature_flext1.d_source_feature_rank_id = 1 THEN '<div style="display: inline-block; width: 20ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SF Rank cannot be Extant if last visit detected = N</div>'
        ELSE CONCAT_WS('', 'Last Visit Detected? = ', last_visit.detected)
    END AS last_visit_detected,
    CASE
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 2 AND ext.nbr_obs(core.source_feature.source_feature_id) = 1 THEN '<div style="display: inline-block; width: 20ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SFs cannot be Failed2Find and only have one visit.</div>'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 3 AND ext.nbr_obs(core.source_feature.source_feature_id) = 1 THEN
        /* then '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SFs cannot be Extirpated and only have one visit. If rank is based on aerials, please enter a visit with the date of the aerials.' */
        '<div style="display: inline-block; width: 45ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SFs cannot be Extirpated and only have one visit.<br>If rank is based on aerials, please enter a visit with the date of the aerials.</div>'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id IS NULL THEN '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SF Rank is required'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 1 THEN 'SF Rank: Extant'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 2 AND ext.nbr_obs(core.source_feature.source_feature_id) > 1 THEN 'SF Rank: Failed2Find'
        WHEN ext.source_feature_flext1.d_source_feature_rank_id = 3 AND ext.nbr_obs(core.source_feature.source_feature_id) > 1 THEN 'SF Rank: Extirpated'
        ELSE '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">SF Rank: Weird'
    END AS sf_rank,
    CASE
        WHEN core.source_feature.source_feature_id IN (SELECT
            source_feature_id
            FROM core.source_feature_ref) THEN '<HTML>&#x2713;'
        ELSE '<div style="display: inline-block; width: 15ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">A Reference is required</div>'
    END AS ref, CONCAT_WS('', ext.concatt('<HTML>'::TEXT, core.scientific_name.formatted_scientific_name), ' EO#', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/', core.eo.eo_id, '.html" target="_blank">', (core.eo.eo_num), '</a>', ' SFID: ', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/SourceFeature/', core.source_feature.source_feature_id, '.html" target="_blank">', core.source_feature.source_feature_id, '</a>') AS eo_sf_,
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
        WHEN core.eo.d_data_qc_status_id IS NULL THEN '<HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">NULL'
        WHEN core.eo.d_data_qc_status_id = 1 THEN '<HTML>EO data QC: <img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">incomplete'
        WHEN core.eo.d_data_qc_status_id = 3 THEN 'EO data QC: Failed'
        ELSE 'EO data QC: Passed'
    END AS eo_data_qc,
    CASE
        WHEN core.shape.qc_com LIKE '%check to see if the identification is correct using the url in mapping comments and delete%' THEN
        /* THEN 'SF_QC_Comment: <br /><div style="display: inline-block; width: 28ch; white-space: normal; overflow-wrap: anywhere;"><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">Check that the species identification is correct in iNaturalist. Then update the QC comment</div>' */
        CONCAT_WS('', '<div style="display: inline-block; width: 86ch; white-space: normal; overflow-wrap: anywhere;">SF_QC_Comment: <br />', replace(core.shape.qc_com, 'Please check to see if the identification is correct using the url in mapping comments and delete this statement after doing so.', '<br /><HTML><img src="https://www.fnai.org/images/error_icon_FNAI.png" alt="Error" style="height:16px;">Please check to see if the identification is correct using the url in mapping comments and delete this statement after doing so.</div>'))
        ELSE CONCAT_WS('', 'SF_QC_Comment: ', core.shape.qc_com)
    END AS sf_qc_comment, CONCAT_WS('', 'EO_V_Author: ', core.eo.version_author_name) AS eo_v_author, core.eo.eo_id, core.source_feature.source_feature_id, core.eo.d_data_qc_status_id, shape2.map_qc_status, core.eo.version_author_name AS version_author, core.eo.version_date AS version_date, ext.sci_name(core.eo.element_subnational_id) AS sname, ext.elgroup_name(core.eo.element_subnational_id) AS group_name,
    CASE
        WHEN ts.eo_track_status_cd <> 'Y' THEN CONCAT_WS('', '<HTML><img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">Not a tracked Element. Tracking Status: ', ts.eo_track_status_cd)
        WHEN ts.eo_track_status_cd IS NULL THEN '<HTML><img src="https://www.fnai.org/images/error_icon_black_FNAI.png" alt="Warning" style="height:16px;">Not a tracked Element. Tracking Status: None Assigned '
        ELSE CONCAT_WS('', 'Track Status: ', ts.eo_track_status_cd)
    END AS element_track_status, shape2.qc_com AS qc_comments
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
    LEFT OUTER JOIN domain.d_eo_track_status AS ts
        ON ts.d_eo_track_status_id = est.d_eo_track_status_id
    LEFT OUTER JOIN domain.d_digitizing_base AS digi_base
        ON core.source_feature.d_digitizing_base_id = digi_base.d_digitizing_base_id
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
    ORDER BY ext.elgroup_sort_order(est.element_subnational_id), ext.sci_name(est.element_subnational_id), core.eo.eo_num ASC, oracle.to_number(core.source_feature.source_feature_id) ASC;


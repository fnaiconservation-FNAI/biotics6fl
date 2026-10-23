CREATE OR REPLACE  VIEW ext.fnai_eo_qc_text_view_pbi (sci_name, filtersearch, eo_type, sfs, id_confirmed, d_s, "D_S Category", d_s_reason, rep_accuracy, confidence_extent, surveydate, first_obs, last_obs, eo_data, eo_link, rank, rank_congruency, rank_com, eo_rank_date, general_description, eo_directions, p_ref, new_bad_refs, data_qc, map_qc, qc_comments, v_author, vdatecheck, v_funding, eo_id, d_data_qc_status_id, map_qc_status, version_author, version_date, group_name) AS
SELECT
    core.scientific_name.scientific_name AS sci_name, CONCAT_WS('', 'sname=''', core.scientific_name.scientific_name, '''  EO_ID =', core.eo.eo_id) AS filtersearch,
    CASE
        WHEN (core.eo.shape_id IN (SELECT DISTINCT
            (core.eo.principal_eo_shape_id)
            FROM core.eo)) THEN 'This is a parent EO, which we are not creating nor QC passing any longer.  Please fix.'
        WHEN (NOT (core.eo.principal_eo_shape_id IS NULL)) THEN 'This is a sub EO, which we are not creating nor QC passing any longer.  Please fix.'
        ELSE NULL
    END AS eo_type,
    CASE
        WHEN ext.nbr_src_features(core.eo.eo_id) = 1 THEN CONCAT_WS('', ext.nbr_src_features(core.eo.eo_id), ' SF')
        WHEN ext.nbr_src_features(core.eo.eo_id) > 1 THEN CONCAT_WS('', ext.nbr_src_features(core.eo.eo_id), ' SFs')
    END AS sfs,
    CASE
        WHEN core.eo.d_id_confirmed_id IS NULL THEN 'ID Confirmed is required.'
        WHEN domain.d_id_confirmed.d_id_confirmed_id = 1 THEN CONCAT_WS('', 'Is ID Confirmed: ', domain.d_id_confirmed.display_value, '" intentional and correct?')
        WHEN domain.d_id_confirmed.d_id_confirmed_id = 3 THEN 'ID Confirmed cannot be questionable.'
        ELSE CONCAT_WS('', 'ID Confirmed: ', domain.d_id_confirmed.id_confirmed_cd)
    END AS id_confirmed,
    CASE
        WHEN core.eo.d_data_sensitive_id = 1 THEN 'Are you certain that this EO needs to be data-sensitive?  D-S: Yes-always'
        WHEN core.eo.d_data_sensitive_id = 2 THEN '  D-S: No-never'
        WHEN core.eo.d_data_sensitive_id = 3 THEN 'FNAI does not use the Conditional data-sensitive category.  D-S: Conditional'
        ELSE 'Not D-S'
    END AS d_s,
    CASE
        WHEN core.eo.d_data_sensitive_id IN (1, 3) AND core.eo.d_data_sensitive_category_id IS NULL THEN 'Please enter a D-S category.'
        WHEN core.eo.d_data_sensitive_category_id = 1 THEN 'Poaching/Collecting'
        WHEN core.eo.d_data_sensitive_category_id = 2 THEN 'Proprietary Data'
        WHEN core.eo.d_data_sensitive_category_id = 3 THEN 'Land Owner'
        WHEN core.eo.d_data_sensitive_category_id = 4 THEN 'Fragile sp or hab.'
        ELSE NULL
    END AS "D_S Category",
    CASE
        WHEN (core.eo.d_data_sensitive_id = 1 AND core.eo.data_sensitive_reasons IS NULL) THEN 'Do you need to explain further why this EO has to be data- sensitive?'
        WHEN (core.eo.d_data_sensitive_id = 3 AND core.eo.data_sensitive_reasons IS NULL) THEN 'Please enter a reason or reasons as to why and when this EO has to be data-sensitive or consider changing its designation.'
        WHEN (core.eo.d_data_sensitive_id = 2 AND core.eo.data_sensitive_reasons IS NULL) THEN ' '
        ELSE core.eo.data_sensitive_reasons
    END AS d_s_reason,
    CASE
        WHEN domain.d_est_rep_accuracy.est_rep_accuracy_desc IS NULL THEN 'Rep Accuracy is required.'
        ELSE domain.d_est_rep_accuracy.est_rep_accuracy_desc
    END AS rep_accuracy,
    CASE
        WHEN domain.d_confidence_extent.confidence_extent_cd IS NULL THEN 'Confidence Extent is required.'
        ELSE domain.d_confidence_extent.confidence_extent_cd
    END AS confidence_extent, CONCAT_WS('',
    CASE
        WHEN ext.chk_txt_date(core.eo.survey_date) LIKE 'Valid%' THEN NULL
        WHEN ext.chk_txt_date(core.eo.survey_date) LIKE 'Invalid%' AND NOT (core.eo.survey_date IS NULL) THEN ext.chk_txt_date(core.eo.survey_date)
        WHEN core.eo.survey_date IS NULL THEN 'Survey Date is null; please enter the most recent survey date.'
    END,
    CASE
        WHEN ((core.eo.last_obs_date < core.eo.survey_date) AND NOT (core.eo.last_obs_date IS NULL) AND NOT (core.eo.survey_date IS NULL) AND NOT (core.eo.d_basic_eo_rank_id IN (15, 17, 18, 20))) THEN CONCAT_WS('', 'Survey Date should usually not be more recent than Last Obs for extant EOs. Survey Date: ', core.eo.survey_date)
        WHEN core.eo.survey_date IS NULL THEN NULL
        ELSE (CASE
            WHEN core.eo.survey_date IS NULL THEN NULL
            ELSE core.eo.survey_date
        END)
    END) AS surveydate, CONCAT_WS('',
    CASE
        WHEN ext.chk_txt_date(core.eo.first_obs_date) LIKE 'Valid%' THEN NULL
        WHEN ext.chk_txt_date(core.eo.first_obs_date) LIKE 'Invalid%' THEN ext.chk_txt_date(core.eo.first_obs_date)
    END,
    CASE
        WHEN oracle.substr(core.eo.first_obs_date, 1, 4) > oracle.substr(core.eo.last_obs_date, 1, 4) THEN CONCAT_WS('', 'First obs cannot be greater than last obs. First Obs: ', core.eo.first_obs_date)
        ELSE core.eo.first_obs_date
    END) AS first_obs, CONCAT_WS('',
    CASE
        WHEN ext.chk_txt_date(core.eo.last_obs_date) LIKE 'Valid%' THEN NULL
        WHEN ext.chk_txt_date(core.eo.last_obs_date) LIKE 'Invalid%' THEN ext.chk_txt_date(core.eo.last_obs_date)
    END,
    CASE
        WHEN (NOT (core.eo.last_obs_date IS NULL) AND NOT (core.eo.survey_date IS NULL) AND NOT (core.eo.d_basic_eo_rank_id IN (15, 17, 18, 20)) AND oracle.substr(core.eo.last_obs_date, 1, 4) < oracle.substr(core.eo.survey_date, 1, 4)) THEN CONCAT_WS('', 'Last obs  should usually  be equal to or more recent than Survey Date for extant or historical EOs. Last Obs:  ', core.eo.last_obs_date)
        WHEN (NOT (core.eo.last_obs_date IS NULL) AND NOT (core.eo.survey_date IS NULL) AND NOT (core.eo.d_basic_eo_rank_id IN (15, 17, 18, 20)) AND NOT (oracle.substr(core.eo.last_obs_date, 1, 4) = oracle.substr(core.eo.survey_date, 1, 4)) AND ext.nbr_src_features(core.eo.eo_id) = 1) THEN CONCAT_WS('', 'Last obs should usually be equal to Survey Date for extant, single-source EOs. Last Obs: ', core.eo.last_obs_date)
        WHEN (NOT (core.eo.last_obs_date IS NULL) AND NOT (core.eo.survey_date IS NULL) AND (core.eo.d_basic_eo_rank_id IN (15, 17, 18, 20)) AND NOT (oracle.substr(core.eo.last_obs_date, 1, 4) < oracle.substr(core.eo.survey_date, 1, 4))) THEN CONCAT_WS('', 'Last obs should always be prior to Survey Date for non-extant EOs. Last Obs: ', core.eo.last_obs_date)
        ELSE core.eo.last_obs_date
    END) AS last_obs,
    CASE
        WHEN core.eo.eo_data IS NULL THEN 'EO Data is required.'
        WHEN LENGTH(core.eo.eo_data::TEXT) > 250 THEN CONCAT_WS('', 'EO Data is supposed to be a short summary suitable for export to the general public and ideally 
    should be less than 250 characters, in part so that it will fit into shapefile fields. This is ', LENGTH(core.eo.eo_data::TEXT), ' characters.  
    Please move specific data to the source feature level and create a short summary here.', oracle.substr(lob_loc => core.eo.eo_data, amount => 500, "offset" => 1))
        WHEN LOWER(core.eo.eo_data::TEXT)::TEXT LIKE '%see source feature%' OR LOWER(core.eo.eo_data::TEXT)::TEXT LIKE '%see individual source features%' OR LOWER(core.eo.eo_data::TEXT)::TEXT LIKE '%see associated source features%' OR LOWER(core.eo.eo_data::TEXT)::TEXT LIKE '% source feature see %' OR LOWER(core.eo.eo_data::TEXT)::TEXT LIKE '% see sources tab %' OR LOWER(core.eo.eo_data::TEXT)::TEXT LIKE '% refer to source feature %' OR LOWER(core.eo.eo_data::TEXT)::TEXT LIKE '% see visit %' OR LOWER(core.eo.eo_data::TEXT)::TEXT LIKE '% refer to visit %' OR LOWER(core.eo.eo_data::TEXT)::TEXT LIKE '% see observations %' THEN CONCAT_WS('', 'EO Data should summarize source feature data but not refer users to them. ', oracle.substr(lob_loc => core.eo.eo_data, amount => 500, "offset" => 1))
        ELSE CONCAT_WS('', 'EO Data: ', oracle.substr(lob_loc => core.eo.eo_data, amount => 2000, "offset" => 1))
    END AS eo_data, CONCAT_WS('', 'https://bioticsfl.natureserve.org/biotics/services/page/Eo/', core.eo.eo_id, '.html') AS eo_link,
    CASE
        WHEN domain.d_basic_eo_rank.basic_eo_rank_cd IS NULL THEN 'EO Rank is required.'
        WHEN (NOT (core.eo.last_obs_date IS NULL) AND NOT (core.eo.survey_date IS NULL) AND NOT (core.eo.d_basic_eo_rank_id IN (15, 17, 18, 20)) AND oracle.substr(core.eo.last_obs_date, 1, 4) < oracle.substr(core.eo.survey_date, 1, 4)) THEN CONCAT_WS('', 'This rank is not consistent with Survey Date and Last Obs Date. EO Rank: ', domain.d_basic_eo_rank.display_value)
        WHEN (NOT (core.eo.last_obs_date IS NULL) AND NOT (core.eo.survey_date IS NULL) AND (core.eo.d_basic_eo_rank_id IN (15, 17, 18, 20)) AND oracle.substr(core.eo.last_obs_date, 1, 4) > oracle.substr(core.eo.survey_date, 1, 4)) THEN CONCAT_WS('', 'This rank is not consistent with Survey Date and Last Obs Date. EO Rank: ', domain.d_basic_eo_rank.display_value)
        WHEN (NOT (core.eo.last_obs_date IS NULL) AND NOT (core.eo.survey_date IS NULL) AND NOT (domain.d_basic_eo_rank.basic_eo_rank_cd) IS NULL AND NOT (core.eo.eo_rank_date = core.eo.last_obs_date OR core.eo.eo_rank_date = core.eo.survey_date)) THEN CONCAT_WS('', 'Update EO Rank and Rank Date?  Rank should be updated or reviewed whenever a source feature or visit is added. EO Rank: ', domain.d_basic_eo_rank.display_value)
        ELSE domain.d_basic_eo_rank.display_value
    END AS rank,
    /* non-extirpated eos must have one non-extirpated sf */
    CASE
        WHEN core.eo.d_basic_eo_rank_id <> 17 AND (3 = ALL (SELECT
            d_source_feature_rank_id
            FROM core.eo_source_feature AS eo_sf
            LEFT OUTER JOIN core.source_feature AS sf
                ON eo_sf.source_feature_id = sf.source_feature_id
            LEFT OUTER JOIN ext.source_feature_flext1 AS sf_flext1
                ON sf.source_feature_id = sf_flext1.source_feature_id
            WHERE eo_sf.eo_id = core.eo.eo_id)) THEN 'Non-extirpated eos must have at least one non-extirpated sf'
    /* extirpated eos must have only extirpated sfs */
        WHEN core.eo.d_basic_eo_rank_id = 17 AND NOT (3 = ALL (SELECT
            d_source_feature_rank_id
            FROM core.eo_source_feature AS eo_sf
            LEFT OUTER JOIN core.source_feature AS sf
                ON eo_sf.source_feature_id = sf.source_feature_id
            LEFT OUTER JOIN ext.source_feature_flext1 AS sf_flext1
                ON sf.source_feature_id = sf_flext1.source_feature_id
            WHERE eo_sf.eo_id = core.eo.eo_id)) THEN 'Extirpated eos must have only extirpated sfs'
        ELSE 'OK'
    END AS rank_congruency,
    CASE
        WHEN core.eo.eo_rank_com IS NULL THEN '(Rank Comments is null, but not required.)'
        ELSE core.eo.eo_rank_com
    END AS rank_com, CONCAT_WS('',
    CASE
        WHEN ext.chk_txt_date(core.eo.eo_rank_date) LIKE 'Valid%' THEN NULL
        WHEN ext.chk_txt_date(core.eo.eo_rank_date) LIKE 'Invalid%' THEN ext.chk_txt_date(core.eo.eo_rank_date)
    END,
    CASE
        WHEN (NOT (core.eo.last_obs_date IS NULL) AND NOT (core.eo.survey_date IS NULL) AND NOT (domain.d_basic_eo_rank.basic_eo_rank_cd) IS NULL AND NOT (core.eo.eo_rank_date = core.eo.last_obs_date OR core.eo.eo_rank_date = core.eo.survey_date)) THEN CONCAT_WS('', 'EO Rank should usually be based upon Last Obs or Survey Date and so Rank Date should usually be equal to Survey Date or Last Obs Date. EO Rank Date: ', core.eo.eo_rank_date)
        ELSE core.eo.eo_rank_date
    END) AS eo_rank_date,
    CASE
        WHEN core.eo.gen_desc IS NULL THEN 'EO General Description is required.'
        WHEN LENGTH(core.eo.gen_desc::TEXT) > 250 THEN CONCAT_WS('', 'EO General Description is supposed to be a short field suitable for export to the general public and ideally should be less than 250 characters, in part so that it will fit into shapefile fields. This is ', LENGTH(core.eo.gen_desc::TEXT), ' characters.  Shorten this if possible or, if not, create a summary, starting with "General Description Summary:", that is less than 250 characters. ', ext.clean_up(oracle.substr(lob_loc => core.eo.gen_desc, amount => 500, "offset" => 1)))
        ELSE ext.clean_up(oracle.substr(lob_loc => core.eo.gen_desc, amount => 2000, "offset" => 1))
    END AS general_description,
    CASE
        WHEN core.eo.directions IS NULL THEN '(EO Directions is null, but not required.)'
        ELSE CONCAT_WS('', 'EO_Directions: ', oracle.substr(lob_loc => core.eo.directions, amount => 2000, "offset" => 1))
    END AS eo_directions,
    CASE
        WHEN core.eo.eo_id IN (SELECT
            eo_id
            FROM core.eo_reference
            WHERE eo_reference_primary_ind = 'Y') THEN 'Primary Ref? Yes'
        ELSE 'A Primary Reference is required.'
    END AS p_ref, COALESCE(new_ref_chk.new_bad_ref_links, 'None') AS new_bad_refs,
    /* , NVL(OLD_REF_CHK.OLD_BAD_REF_LINKS,'None') AS OLD_BAD_REFS */
    CASE
        WHEN core.eo.d_data_qc_status_id IS NULL THEN 'EO Data QC Status is null.'
        WHEN core.eo.d_data_qc_status_id = 1 THEN 'EO Data QC Status is incomplete.'
        WHEN core.eo.d_data_qc_status_id = 3 THEN 'EO Data QC Status is Failed.'
        ELSE 'EO Data QC Status is Passed'
    END AS data_qc,
    CASE
        WHEN core.shape.map_qc_status = 'P' THEN 'EO Map QC Status is Passed'
        WHEN core.shape.map_qc_status = 'F' THEN 'EO Map QC Status is Failed.'
        WHEN core.shape.map_qc_status IS NULL THEN 'EO Map QC Status is null.'
        WHEN core.shape.map_qc_status = 'I' THEN 'EO Map QC Status is Incomplete'
        ELSE 'EO Map QC Status is Not Reviewed.'
    END AS map_qc,
    CASE
        WHEN core.shape.qc_com IS NULL THEN 'If you are Version Author, please record what you did, such as "new EO" or "added SF ID ####", and the location of the source data.'
        ELSE core.shape.qc_com
    END AS qc_comments,
    CASE
        WHEN core.eo.version_author_name IS NULL THEN 'EO Version Author is required.'
        WHEN core.eo.version_author_name = 'Rosner-Katz, H.' THEN core.eo.version_author_name
        WHEN NOT (LENGTH(core.eo.version_author_name) - LENGTH(replace(core.eo.version_author_name, ' ', '')) = 2 AND LENGTH(core.eo.version_author_name) - LENGTH(replace(core.eo.version_author_name, ',', '')) = 1 AND LENGTH(core.eo.version_author_name) - LENGTH(replace(core.eo.version_author_name, '.', '')) = 2 AND (oracle.substr(core.eo.version_author_name, - 1, 1) = '.') AND (oracle.substr(core.eo.version_author_name, - 4, 1) = '.') AND (oracle.substr(core.eo.version_author_name, - 7, 1) = ',')) OR
        /* lines below allow people to leave version name as unknown as long as version date isn't updated */
        (core.eo.version_author_name = 'Unknown, update when EO is substantially revised' AND core.eo.version_date > oracle.TO_DATE('2014-03-25', 'YYYY-MM-DD')) THEN CONCAT_WS('', 'This name is not formatted as Last, F. M.: ', core.eo.version_author_name)
        ELSE core.eo.version_author_name
    END AS v_author,
    CASE
        WHEN core.eo.version_date IS NULL THEN 'EO Version Date is required.'
        WHEN oracle.to_char(core.eo.version_date, 'YYYY-MM-DD') < core.eo.last_obs_date AND NOT (core.eo.last_obs_date LIKE '%Pre%') THEN CONCAT_WS('', 'Version date ', oracle.to_char(core.eo.version_date, 'YYYY-MM-DD'), ' cannot be prior to last obs ', core.eo.last_obs_date, '.')
        ELSE CONCAT_WS('', 'V_DATE ', oracle.to_char(core.eo.version_date, 'YYYY-MM-DD'))
    END AS vdatecheck,
    CASE
        WHEN (ext.eo_flext1.d_version_funding_id IS NULL AND core.eo.version_date > oracle.TO_DATE('2016-07-07', 'YYYY-MM-DD')) THEN 'EO Funding is required.'
        /* LOOKUP('D_VERSION_FUNDING',EO_FLEXT1.D_VERSION_FUNDING_id,'VERSION_FUNDING_DESC',100) */
        ELSE ext.d_version_funding.version_funding_desc
    END AS v_funding, core.eo.eo_id, d_data_qc_status_id, map_qc_status, core.eo.version_author_name AS version_author, core.eo.version_date AS version_date,
    /* , SCI_NAME(EO.ELEMENT_SUBNATIONAL_ID) AS SNAME */
    ext.elgroup_name(core.eo.element_subnational_id) AS group_name
    FROM core.eo
    LEFT OUTER JOIN core.element_subnational AS est
        ON core.eo.element_subnational_id = est.element_subnational_id
    LEFT OUTER JOIN core.eo_shape
        ON core.eo.eo_id = core.eo_shape.eo_id
    LEFT OUTER JOIN ext.eo_flext1
        ON core.eo.eo_id = ext.eo_flext1.eo_id
    LEFT OUTER JOIN ext.d_version_funding
        ON ext.eo_flext1.d_version_funding_id = ext.d_version_funding.d_version_funding_id
    LEFT OUTER JOIN ext.fnai_eo_status_view
        ON core.eo.eo_id = ext.fnai_eo_status_view.eo_id
    LEFT OUTER JOIN core.shape
        ON core.eo.shape_id = core.shape.shape_id
    LEFT OUTER JOIN domain.d_confidence_extent
        ON core.eo.d_confidence_extent_id = domain.d_confidence_extent.d_confidence_extent_id
    LEFT OUTER JOIN domain.d_est_rep_accuracy
        ON core.eo.d_est_rep_accuracy_id = domain.d_est_rep_accuracy.d_est_rep_accuracy_id
    LEFT OUTER JOIN domain.d_basic_eo_rank
        ON core.eo.d_basic_eo_rank_id = domain.d_basic_eo_rank.d_basic_eo_rank_id
    LEFT OUTER JOIN domain.d_id_confirmed
        ON core.eo.d_id_confirmed_id = domain.d_id_confirmed.d_id_confirmed_id
    LEFT OUTER JOIN core.scientific_name
        ON core.scientific_name.scientific_name_id = est.sname_id
    LEFT OUTER JOIN
    /* subquery to check for newer refs that don't pass */
    (SELECT
        eo_ref.eo_id, CONCAT_WS('', 'New refs, MUST fix required fields or problems with refcodes: ', STRING_AGG(ref.reference_code, ', '::TEXT ORDER BY ref.reference_id)) AS new_bad_ref_links
        FROM core.eo_reference AS eo_ref
        LEFT OUTER JOIN core.reference AS ref
            ON eo_ref.reference_id = ref.reference_id
        WHERE ext.chk_ref(ref.reference_id) = 'N' AND ref.rec_create_date >= (SELECT
            oracle.TO_DATE('2019-10-01', 'YYYY-MM-DD'))
        GROUP BY eo_ref.eo_id) AS new_ref_chk
        ON core.eo.eo_id = new_ref_chk.eo_id
    /* subquery to check for older refs that don't pass */
    /* LEFT OUTER JOIN ( */
    /* SELECT */
    /* EO_REF.EO_ID */
    /* , 'Older refs, if possible fix required fields or problems with refcodes: '|| */
    /* listagg(ref.reference_code, ', ') within group (order by ref.reference_id) */
    /* as OLD_BAD_REF_LINKS */
    /* FROM */
    /* EO_reference EO_REF */
    /* LEFT OUTER JOIN REFERENCE REF */
    /* ON EO_REF.REFERENCE_ID = REF.REFERENCE_ID */
    /* WHERE */
    /* chk_ref(REF.REFERENCE_ID) = 'N' */
    /* AND REF.REC_CREATE_DATE < TO_DATE('2019-10-01','YYYY-MM-DD') */
    /* GROUP BY EO_REF.EO_ID */
    /* ) OLD_REF_CHK */
    /* ON EO.EO_ID = OLD_REF_CHK.EO_ID */
    WHERE est.d_eo_track_status_id = 1 AND NOT (ext.elgroup_name(est.element_subnational_id) LIKE 'Natural Communit%' AND core.eo.eo_data IS NULL AND core.eo.gen_desc IS NULL) AND core.shape.shape_id NOT IN (SELECT
        core.shape.shape_id
        FROM core.shape
        WHERE core.shape.qc_com LIKE '%uncertain ident%') AND est.d_eo_track_status_id = 1
    ORDER BY ext.elgroup_sort_order(est.element_subnational_id), ext.sci_name(est.element_subnational_id), core.eo.eo_id;


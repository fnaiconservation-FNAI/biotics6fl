CREATE OR REPLACE  VIEW ext.current_qtr_status (status, eo_id, shape_id, elgroup, sname, eo_num, created, by_user, map_qc, data_qc, mod_started_by) AS
SELECT
    status, eo_id, shape_id, elgroup, sname, eo_num, created, by_user, map_qc, data_qc, mod_started_by
    FROM (SELECT
        'new_complete' AS status, eo.eo_id AS eo_id, eo.shape_id AS shape_id, ext.elgroup_name(eo.element_subnational_id) AS elgroup, oracle.substr(sn.scientific_name, 1, 40) AS sname, oracle.substr(ext.report_eonum(eo.eo_id), 1, 9) AS eo_num, eo.rec_create_date AS created, oracle.substr(eo.rec_create_user, 1, 7) AS by_user, oracle.substr(shp.map_qc_by, 1, 7) AS map_qc, oracle.substr(eo.data_qc_by, 1, 7) AS data_qc, NULL AS mod_started_by
        FROM core.eo AS eo, core.element_subnational AS est, core.scientific_name AS sn, core.shape AS shp
        WHERE eo.rec_create_date >= (SELECT
            oracle.TO_DATE('2015-06-04', 'yyyy-mm-dd')) AND eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id AND shp.shape_id = eo.shape_id AND eo.principal_eo_shape_id IS NULL AND (eo.d_data_qc_status_id = 2 AND shp.map_qc_status = 'P')
    /* order by eo.rec_create_user, eo.rec_create_date */
    /* set echo on; */
    
    /* Finished new sub-EOs - sub-EOs created and QC passed since start date of period */
    /* set echo off; */
    UNION ALL
    SELECT
        'newsub_complete' AS status, eo.eo_id AS eo_id, eo.shape_id AS shape_id, ext.elgroup_name(eo.element_subnational_id) AS elgroup, oracle.substr(sn.scientific_name, 1, 40) AS sname, oracle.substr(ext.report_eonum(eo.eo_id), 1, 9) AS eo_num, eo.rec_create_date AS created, oracle.substr(eo.rec_create_user, 1, 7) AS by_user, oracle.substr(shp.map_qc_by, 1, 7) AS map_qc, oracle.substr(eo.data_qc_by, 1, 7) AS data_qc, NULL AS mod_started_by
        FROM core.eo AS eo, core.element_subnational AS est, core.scientific_name AS sn, core.shape AS shp
        WHERE eo.rec_create_date >= (SELECT
            oracle.TO_DATE('2015-06-04', 'yyyy-mm-dd')) AND eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id AND shp.shape_id = eo.shape_id AND eo.principal_eo_shape_id IS NOT NULL AND (eo.d_data_qc_status_id = 2 AND shp.map_qc_status = 'P')
    /* order by eo.rec_create_user, eo.rec_create_date */
    /* set echo on; */
    
    /* Unfinished new EORs - EOs created during the period but QC not passed yet */
    /* set echo off; */
    UNION ALL
    SELECT
        'new_incomplete' AS status, eo.eo_id AS eo_id, eo.shape_id AS shape_id, ext.elgroup_name(eo.element_subnational_id) AS elgroup, oracle.substr(sn.scientific_name, 1, 40) AS sname, oracle.substr(ext.report_eonum(eo.eo_id), 1, 9) AS eo_num, eo.rec_create_date AS created, oracle.substr(eo.rec_create_user, 1, 7) AS by_user, oracle.substr(shp.map_qc_by, 1, 7) AS map_qc, oracle.substr(eo.data_qc_by, 1, 7) AS data_qc, NULL AS mod_started_by
        FROM core.eo AS eo, core.element_subnational AS est, core.scientific_name AS sn, core.shape AS shp
        WHERE eo.rec_create_date >= (SELECT
            oracle.TO_DATE('2015-06-04', 'yyyy-mm-dd')) AND eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id AND shp.shape_id = eo.shape_id AND (eo.d_data_qc_status_id <> 2 OR shp.map_qc_status <> 'P')
    /* order by eo.rec_create_user, eo.rec_create_date */
    
    /*
    How about EOs created BEFORE the period but had never been QC passed?
    EO must meet three criteria
    1) created before start of period and QC status = passed now
    2) audit trail shows that QC status was reset during the time period
    3) audit trail old value for QC status has NEVER BEEN PASSED AT ANY TIME
       (so this script does not return records that were re-QC'd)
    */
    /* set echo on; */
    
    /* Old EORs finished - EOs created BEFORE the period but had never been QC passed */
    /* set echo off; */
    UNION ALL
    SELECT
        'old_complete' AS status, eo.eo_id AS eo_id, eo.shape_id AS shape_id, ext.elgroup_name(eo.element_subnational_id) AS elgroup, oracle.substr(sn.scientific_name, 1, 40) AS sname, oracle.substr(ext.report_eonum(eo.eo_id), 1, 9) AS eo_num, eo.rec_create_date AS created, oracle.substr(eo.rec_create_user, 1, 7) AS by_user, oracle.substr(shp.map_qc_by, 1, 7) AS map_qc, oracle.substr(eo.data_qc_by, 1, 7) AS data_qc, NULL AS mod_started_by
        FROM core.eo AS eo, core.element_subnational AS est, core.scientific_name AS sn, core.shape AS shp
        WHERE eo.rec_create_date < (SELECT
            oracle.TO_DATE('2015-06-04', 'yyyy-mm-dd')) AND (eo.d_data_qc_status_id = 2 AND shp.map_qc_status = 'P') AND /* 1st criterion above */ eo.eo_id IN (SELECT DISTINCT
            (core.eo.eo_id)
            FROM core.eo, audit.audit_log AS al
            LEFT OUTER JOIN audit.audit_log_column AS alc
                ON (alc.audit_log_id = al.audit_log_id)
            WHERE al.action_code = 'U' AND al.audit_date >= (SELECT
                oracle.TO_DATE('2015-06-04', 'yyyy-mm-dd')) AND ((alc.column_name IN ('D_DATA_QC_STATUS_ID') AND (alc.old_value <> 2::TEXT OR alc.old_value IS NULL) AND al.table_name = 'EO' AND al.primary_key_id = core.eo.eo_id) OR (alc.column_name IN ('MAP_QC_STATUS') AND (alc.old_value <> 'P' OR alc.old_value IS NULL) AND al.table_name = 'SHAPE' AND al.primary_key_id = core.eo.shape_id))) AND /* 2nd criterion above */ eo.eo_id NOT IN (SELECT DISTINCT
            (core.eo.eo_id)
            FROM core.eo, audit.audit_log AS al
            LEFT OUTER JOIN audit.audit_log_column AS alc
                ON (alc.audit_log_id = al.audit_log_id)
            WHERE al.action_code = 'U' AND alc.column_name IN ('D_DATA_QC_STATUS_ID') AND alc.old_value = 2::TEXT AND al.table_name = 'EO' AND al.primary_key_id = core.eo.eo_id) AND /* 3rd criterion above, based on data_qc only */ eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id AND shp.shape_id = eo.shape_id
    /* order by eo.rec_create_date,eo.rec_create_user */
    /* set echo on; */
    
    /*
    Unfinished old EORs - EOs created since 09 Jun 2005 (date QC-passed was
    re-established as criterion for billing and delivery to DEP), and before
    current quarter, but QC not passed (may be either never QC'd or un-QC'd)
    */
    /* set echo off; */
    UNION ALL
    SELECT
        'old_incomplete' AS status, eo.eo_id AS eo_id, eo.shape_id AS shape_id, ext.elgroup_name(eo.element_subnational_id) AS elgroup, oracle.substr(sn.scientific_name, 1, 40) AS sname, oracle.substr(ext.report_eonum(eo.eo_id), 1, 9) AS eo_num, eo.rec_create_date AS created, oracle.substr(eo.rec_create_user, 1, 7) AS by_user, oracle.substr(shp.map_qc_by, 1, 7) AS map_qc, oracle.substr(eo.data_qc_by, 1, 7) AS data_qc, NULL AS mod_started_by
        FROM core.eo AS eo, core.element_subnational AS est, core.scientific_name AS sn, core.shape AS shp
        WHERE eo.rec_create_date BETWEEN (SELECT
            oracle.TO_DATE('2005-06-09', 'yyyy-mm-dd')) AND (SELECT
            oracle.TO_DATE('2015-06-04', 'yyyy-mm-dd')) AND eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id AND shp.shape_id = eo.shape_id AND (eo.d_data_qc_status_id <> 2 OR shp.map_qc_status <> 'P')
    /* order by eo.rec_create_user, eo.rec_create_date */
    /* set echo on; */
    
    /* EOR updates started during the period, but not finished */
    /* set echo off; */
    UNION ALL
    SELECT DISTINCT
        'mod_incomplete' AS status, eo.eo_id AS eo_id, eo.shape_id AS shape_id, ext.elgroup_name(eo.element_subnational_id) AS elgroup, oracle.substr(sn.scientific_name, 1, 40) AS sname, oracle.substr(ext.report_eonum(eo.eo_id), 1, 9) AS eo_num, eo.rec_create_date AS created, oracle.substr(eo.rec_create_user, 1, 7) AS by_user, NULL AS map_qc, NULL AS data_qc, al.user_name AS mod_started_by
        FROM core.eo AS eo, core.element_subnational AS est, core.scientific_name AS sn, core.shape AS shp, audit.audit_log AS al, audit.audit_log_column AS alc
        WHERE alc.column_name IN ('D_DATA_QC_STATUS_ID', 'MAP_QC_STATUS') AND alc.audit_log_id = al.audit_log_id AND al.primary_key_id = eo.eo_id AND al.table_name = 'EO' AND al.audit_date >= (SELECT
            oracle.TO_DATE('2015-06-04', 'yyyy-mm-dd')) AND ((eo.d_data_qc_status_id <> 2 AND eo.eo_id IN (SELECT DISTINCT
            (core.eo.eo_id)
            FROM core.eo, audit.audit_log AS al
            LEFT OUTER JOIN audit.audit_log_column AS alc
                ON (alc.audit_log_id = al.audit_log_id)
            WHERE al.action_code = 'U' AND al.audit_date >= (SELECT
                oracle.TO_DATE('2015-06-04', 'yyyy-mm-dd')) AND alc.column_name IN ('D_DATA_QC_STATUS_ID') AND alc.old_value = 2::TEXT AND al.table_name = 'EO' AND al.primary_key_id = core.eo.eo_id)) OR (shp.map_qc_status <> 'P' AND eo.eo_id IN (SELECT DISTINCT
            (core.eo.eo_id)
            FROM core.eo, audit.audit_log AS al
            LEFT OUTER JOIN audit.audit_log_column AS alc
                ON (alc.audit_log_id = al.audit_log_id)
            WHERE al.action_code = 'U' AND al.audit_date >= (SELECT
                oracle.TO_DATE('2015-06-04', 'yyyy-mm-dd')) AND alc.column_name IN ('MAP_QC_STATUS') AND alc.old_value = 'P' AND al.table_name = 'SHAPE' AND al.primary_key_id = core.eo.shape_id))) AND eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id AND shp.shape_id = eo.shape_id)
    /* order by al.user_name, eo.rec_create_date */
    /* set echo on; */
    AS var_sbq
    ORDER BY status, by_user, created;


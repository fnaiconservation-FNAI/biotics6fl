CREATE OR REPLACE  VIEW ext.fnai_eo_qc_needed_view (eo_id, elgroup, sci_name, rec_create_date, rec_create_user, rec_last_mod_date, rec_last_mod_user, version_date, version_author_name, data_qc, map_qc, status, d_version_funding_id) AS
WITH qc_stat
AS (
/* this subquery collects metrics used multiple times in the boody of the main */
/* query to prevent duplicate retrival of the same info */
SELECT
    core.eo.eo_id, ext.value_on_date('EO'::TEXT, 'D_DATA_QC_STATUS_ID'::TEXT, core.eo.eo_id, oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd')) AS data_qc_at_end, ext.value_on_date('SHAPE'::TEXT, 'MAP_QC_STATUS'::TEXT, shp.shape_id, oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd')) AS map_qc_at_end, ext.last_change_date('EO'::TEXT, 'D_DATA_QC_STATUS_ID'::TEXT, core.eo.eo_id) AS data_qc_last_chg, ext.last_change_date('SHAPE'::TEXT, 'MAP_QC_STATUS'::TEXT, shp.shape_id) AS map_qc_last_chg,
    CASE
        WHEN EXISTS (SELECT
            *
            FROM core.eo AS eo_
            LEFT OUTER JOIN audit.audit_log AS al
                ON (al.primary_key_id = eo_.eo_id AND table_name = 'EO')
            LEFT OUTER JOIN audit.audit_log_column AS alc
                ON al.audit_log_id = alc.audit_log_id
            WHERE eo_.eo_id = core.eo.eo_id AND column_name = 'D_DATA_QC_STATUS_ID' AND alc.old_value = 2::TEXT) THEN 'Y'
        ELSE 'N'
    END AS data_qc_prev_passed,
    CASE
        WHEN EXISTS (SELECT
            *
            FROM core.eo AS eo_
            LEFT OUTER JOIN audit.audit_log AS al
                ON (al.primary_key_id = eo_.shape_id AND table_name = 'SHAPE')
            LEFT OUTER JOIN audit.audit_log_column AS alc
                ON al.audit_log_id = alc.audit_log_id
            LEFT OUTER JOIN core.shape
                ON eo_.shape_id = core.shape.shape_id
            WHERE eo_.eo_id = core.eo.eo_id AND column_name = 'MAP_QC_STATUS' AND alc.old_value = 'P') THEN 'Y'
        ELSE 'N'
    END AS map_qc_prev_passed,
    CASE
        WHEN core.eo.rec_create_date < (oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd') - (330::NUMERIC || ' days')::INTERVAL) THEN 'Y'
        WHEN core.eo.rec_create_date >= (oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd') - (330::NUMERIC || ' days')::INTERVAL) THEN 'N'
    END AS eo_mature
    FROM core.eo
    LEFT OUTER JOIN core.shape AS shp
        ON core.eo.shape_id = shp.shape_id)
SELECT
    core.eo.eo_id, ext.elgroup_name(core.eo.element_subnational_id) AS elgroup, ext.sci_name(core.eo.element_subnational_id) AS sci_name, core.eo.rec_create_date, core.eo.rec_create_user, core.eo.rec_last_mod_date, core.eo.rec_last_mod_user, core.eo.version_date, core.eo.version_author_name, domain.d_data_qc_status.data_qc_status_desc AS data_qc,
    CASE
        WHEN shp.map_qc_status = 'P' THEN 'Passed'
        WHEN shp.map_qc_status = 'I' THEN 'Incomplete'
        WHEN shp.map_qc_status = 'F' THEN 'Failed'
        WHEN shp.map_qc_status IS NULL THEN NULL
    END AS map_qc,
    /* Categorization: */
    /* if created during period: */
    CASE
        WHEN oracle.TRUNC(core.eo.rec_create_date) BETWEEN oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd') AND oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd') THEN
        CASE
            /* and data and map both QC passed: */
            /* (value_on_date('EO','D_DATA_QC_STATUS_ID',eo.eo_id , to_date(&&end_date,'yyyy-mm-dd'))  = '2' */
            /* and value_on_date('SHAPE','MAP_QC_STATUS',shp.shape_id , to_date(&&end_date,'yyyy-mm-dd'))  = 'P') */
            WHEN qc_stat.data_qc_at_end = '2' AND qc_stat.map_qc_at_end = 'P' THEN 'NEW_COMPLETED'
        /* and data and map QC NOT both passed: */
            ELSE
            CASE
                WHEN core.eo.d_data_qc_status_id = 3 OR shp.map_qc_status = 'F' THEN 'NEW FAILED'
                ELSE 'NEW_INCOMPLETE'
            END
        END
    /* if created prior to period: */
        WHEN core.eo.rec_create_date < oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd') THEN
        CASE
            /* and data and map QC passed at end of period: */
            /* (value_on_date('EO','D_DATA_QC_STATUS_ID',eo.eo_id , to_date(&&end_date,'yyyy-mm-dd'))  = '2' */
            /* and value_on_date('SHAPE','MAP_QC_STATUS',shp.shape_id , to_date(&&end_date,'yyyy-mm-dd'))  = 'P') */
            WHEN qc_stat.data_qc_at_end = '2' AND qc_stat.map_qc_at_end = 'P' THEN
            CASE
                /* version date during period OR Map or Data QC passed during quarter: */
                /* (version date is just here to check for cases where it was changed */
                /* inappropriately OR QC was skipped) */
                /* ADD OTHER FIELDS HERE EVENTUALLY: */
                /* centerpoint - MAP_QC */
                /* number of source features - MAP and DATA QC */
                /* others? */
                WHEN oracle.TRUNC(core.eo.version_date) BETWEEN oracle.TRUNC(oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd')) AND oracle.TRUNC(oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd')) OR oracle.TRUNC(qc_stat.data_qc_last_chg) BETWEEN oracle.TRUNC(oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd')) AND oracle.TRUNC(oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd')) OR oracle.TRUNC(qc_stat.map_qc_last_chg) BETWEEN oracle.TRUNC(oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd')) AND oracle.TRUNC(oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd')) THEN
                CASE
                    /* Map or Data QC changed during quarter */
                    WHEN (oracle.TRUNC(qc_stat.data_qc_last_chg) BETWEEN oracle.TRUNC(oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd')) AND oracle.TRUNC(oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd')) OR oracle.TRUNC(qc_stat.map_qc_last_chg) BETWEEN oracle.TRUNC(oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd')) AND oracle.TRUNC(oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd'))) THEN
                    CASE
                        /* either data or map QC was changed FROM passed (indicating the EO likely had been passed previously): */
                        WHEN (data_qc_prev_passed = 'Y' OR map_qc_prev_passed = 'Y') THEN
                        CASE
                            /* version date is later than both QC dates: */
                            WHEN (core.eo.version_date > qc_stat.data_qc_last_chg AND core.eo.version_date > qc_stat.map_qc_last_chg) THEN 'SUBSTANTIVE CHANGE AFTER QC WITHOUT RE-QC'
                            /* version date is earlier than at least one QC date: */
                            /* two comparisons below changed from < to <= 2019-04-02 */
                            WHEN (core.eo.version_date <= qc_stat.data_qc_last_chg OR core.eo.version_date <= qc_stat.map_qc_last_chg) THEN
                            CASE
                                /* EO older than 330 days: */
                                WHEN eo_mature = 'Y' THEN 'MOD_COMPLETE_MATURE_EO'
                                WHEN eo_mature = 'N' THEN 'MOD_COMPLETE_IMMATURE_EO'
                                ELSE 'ERROR 1a'
                            END
                            ELSE 'ERROR 1'
                        END
                        /* neither data nor map QC was ever changed FROM passed previously: */
                        WHEN (data_qc_prev_passed = 'N' AND map_qc_prev_passed = 'N') THEN
                        /* must have been created AFTER the time we started (resumed */
                        /* after a hiatus, actually) delivering and billing only */
                        /* QC-passed EOs to be billable. This was 2005-07-01. (per gcw) */
                        CASE
                            WHEN core.eo.rec_create_date > oracle.TO_DATE('2005-07-01', 'yyyy-mm-dd') THEN
                            CASE
                                /* version date is later than both QC dates: */
                                WHEN (core.eo.version_date > qc_stat.data_qc_last_chg AND core.eo.version_date > qc_stat.map_qc_last_chg) THEN 'SUBSTANTIVE CHANGE AFTER QC WITHOUT RE-QC'
                                /* version date is earlier than at least one QC date: */
                                /* two comparisons below changed from < to <= 2019-04-02 */
                                WHEN (core.eo.version_date <= qc_stat.data_qc_last_chg OR core.eo.version_date <= qc_stat.map_qc_last_chg) THEN 'OLD_COMPLETED_BILLABLE'
                            END
                            ELSE 'OLD_COMPLETED_NOT_BILLABLE'
                        END
                        ELSE 'ERROR 2'
                    END
                /* and data OR map QC NOT passed DURING period (but version date is during period): */
                    WHEN ((oracle.TRUNC(qc_stat.data_qc_last_chg) NOT BETWEEN oracle.TRUNC(oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd')) AND oracle.TRUNC(oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd')) OR qc_stat.data_qc_last_chg IS NULL) AND (oracle.TRUNC(qc_stat.map_qc_last_chg) NOT BETWEEN oracle.TRUNC(oracle.TO_DATE('2020-01-13', 'yyyy-mm-dd')) AND oracle.TRUNC(oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd')) OR qc_stat.map_qc_last_chg IS NULL)) THEN 'SUBSTANTIVE CHANGE WITHOUT RE-QC'
                END
                ELSE 'EXISTING'
            END
        /* and data and map QC not both passed at end of period: */
            ELSE
            CASE
                /* both data and map QC were passed in the past: */
                WHEN (data_qc_prev_passed = 'Y' OR core.eo.d_data_qc_status_id = 2) AND (map_qc_prev_passed = 'Y' OR shp.map_qc_status = 'P') THEN
                CASE
                    /* EO old enough to count mods: */
                    WHEN eo_mature = 'Y' THEN
                    CASE
                        WHEN core.eo.d_data_qc_status_id = 3 OR shp.map_qc_status = 'F' THEN 'MOD_FAILED_MATURE_EO'
                        ELSE 'MOD_INCOMPLETE_MATURE_EO'
                    END
                    ELSE
                    CASE
                        WHEN core.eo.d_data_qc_status_id = 3 OR shp.map_qc_status = 'F' THEN 'MOD_FAILED_IMMATURE_EO'
                        ELSE 'MOD_INCOMPLETE_IMMATURE_EO'
                    END
                END
                /* either map or data QC was never previously passed */
                WHEN (data_qc_prev_passed = 'N' AND core.eo.d_data_qc_status_id <> 2) OR (map_qc_prev_passed = 'N' AND shp.map_qc_status <> 'P') THEN
                CASE
                    WHEN core.eo.d_data_qc_status_id = 3 OR shp.map_qc_status = 'F' THEN 'OLD_FAILED'
                    ELSE 'OLD_INCOMPLETE'
                END
                ELSE 'ERROR 24'
            END
        END
        WHEN core.eo.rec_create_date > oracle.TO_DATE('2020-04-15', 'yyyy-mm-dd') THEN 'CREATED_AFTER_PERIOD'
        ELSE 'ERROR 25'
    END AS status, ext.eo_flext1.d_version_funding_id
    FROM core.eo
    LEFT OUTER JOIN core.shape AS shp
        ON core.eo.shape_id = shp.shape_id
    LEFT OUTER JOIN ext.eo_flext1
        ON core.eo.eo_id = ext.eo_flext1.eo_id
    LEFT OUTER JOIN qc_stat
        ON core.eo.eo_id = qc_stat.eo_id
    LEFT OUTER JOIN domain.d_data_qc_status
        ON core.eo.d_data_qc_status_id = domain.d_data_qc_status.d_data_qc_status_id
    WHERE
    /* don't count subs */
    core.eo.principal_eo_shape_id IS NULL AND
    /* only count tracked elements */
    core.eo.element_subnational_id IN (SELECT
        element_subnational_id
        FROM core.element_subnational
        WHERE d_eo_track_status_id = 1) AND
    /*
    ============================================================================
    2 lines below are for limiting the view to just records in need of QC
    for the FNAI_EO_QC_NEEDED_VIEW.  Creation of this separate view is necessary to
    speed up user access
    ============================================================================
    */
    ((shp.map_qc_status <> 'P' OR shp.map_qc_status IS NULL) OR (core.eo.d_data_qc_status_id <> 2 OR core.eo.d_data_qc_status_id IS NULL))
/* below just for querying subset of EOs */
/* and EO.EO_ID IN */
/* (37795, 37904, 37906, 37907, 37908) */
/* (30099,31019,38844,38849,38855) */
/* (2724,3811,4778,7058,10614,12399,16759,18177,19827,19883,20447,22209,25937,26221,26311,28469) */
;


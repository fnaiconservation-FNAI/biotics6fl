CREATE OR REPLACE  VIEW ext.fnai_element_level_changes (el_id, sort_order, element_group, begin_date, end_date, sname, comm_name, change_type, begin_value, end_value) AS
SELECT
    el_id, sort_order, element_group, begin_date, end_date, sname, comm_name, change_type, begin_value, end_value
    FROM (SELECT
        est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'G rank' AS change_type, ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AS begin_value, ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')) AS end_value
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.element_national AS ent
            ON est.element_national_id = ent.element_national_id
        LEFT OUTER JOIN core.element_global AS egt
            ON ent.element_global_id = egt.element_global_id
        WHERE ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) AND ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> 'N/A (record created after date)' AND /* suppress new recs */ est.d_eo_track_status_id IN (1, 2)
    UNION
    /*
    ***********      GRANK cont'      ******************************************************
    this section isn't perfect and may have problems if a rank is changed multiple
    times during a year, especially to and from the same value
    */
    SELECT
        est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'G rank' AS change_type, ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, last_chg.egt_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AS begin_value, ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, last_chg.egt_id, change_date + (1::NUMERIC || ' days')::INTERVAL) AS end_value
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.element_national AS ent
            ON est.element_national_id = ent.element_national_id
        LEFT OUTER JOIN core.element_global AS egt
            ON ent.element_global_id = egt.element_global_id
        LEFT OUTER JOIN
        /* get rank change date history */
        (SELECT
            egt.element_global_id AS egt_id, qry1.rn AS change_number, qry1.audit_date AS change_date, oracle.TO_DATE(qry1.old_value::TEXT, 'MON DD, YYYY HH:MI:SS') AS changed_from,
            CASE
                WHEN qry1.rn = last_audit.last_change THEN 'CURRENT'
                WHEN last_audit.last_change IS NULL THEN 'CURRENT - NO RECORDED CHANGES'
                WHEN qry1.rn = first_audit.first_change THEN 'INITIAL'
                ELSE 'CHANGED'
            END AS status,
            CASE
                WHEN qry1.rn = last_audit.last_change OR last_audit.last_change IS NULL THEN egt.g_rank_change_date
                ELSE oracle.TO_DATE(subsequent_old_value::TEXT, 'MON DD, YYYY HH:MI:SS')
            END AS changed_to
            FROM core.element_global AS egt
            LEFT OUTER JOIN
            /* query audit log to get dates and changed from value */
            (SELECT
                primary_key_id, audit_date, old_value, ROW_NUMBER() OVER (PARTITION BY primary_key_id ORDER BY audit_date ASC) AS rn
                FROM audit.audit_log AS al
                LEFT OUTER JOIN audit.audit_log_column AS alc
                    ON al.audit_log_id = alc.audit_log_id
                WHERE table_name = 'ELEMENT_GLOBAL' AND alc.column_name = 'G_RANK_CHANGE_DATE')
            /* AND primary_key_id = 19601 */
            AS qry1
                ON egt.element_global_id = qry1.primary_key_id
            LEFT OUTER JOIN
            /* requery audit log to get rank of last change */
            (SELECT
                primary_key_id, MAX(rn) AS last_change
                FROM (SELECT
                    primary_key_id, audit_date, old_value, ROW_NUMBER() OVER (PARTITION BY primary_key_id ORDER BY audit_date ASC) AS rn
                    FROM audit.audit_log AS al
                    LEFT OUTER JOIN audit.audit_log_column AS alc
                        ON al.audit_log_id = alc.audit_log_id
                    WHERE table_name = 'ELEMENT_GLOBAL' AND alc.column_name = 'G_RANK_CHANGE_DATE') AS var_sbq
                GROUP BY primary_key_id) AS last_audit
                ON qry1.primary_key_id = last_audit.primary_key_id
            LEFT OUTER JOIN
            /* requery audit log to get rank of first change */
            (SELECT
                primary_key_id, MIN(rn) AS first_change
                FROM (SELECT
                    primary_key_id, audit_date, old_value, ROW_NUMBER() OVER (PARTITION BY primary_key_id ORDER BY audit_date ASC) AS rn
                    FROM audit.audit_log AS al
                    LEFT OUTER JOIN audit.audit_log_column AS alc
                        ON al.audit_log_id = alc.audit_log_id
                    WHERE table_name = 'ELEMENT_GLOBAL' AND alc.column_name = 'g_rank_chage_date') AS var_sbq_2
                GROUP BY primary_key_id) AS first_audit
                ON qry1.primary_key_id = first_audit.primary_key_id
            LEFT OUTER JOIN
            /* requery audit log to get subsequent change */
            (SELECT
                primary_key_id, audit_date AS subsequent_audit_date, old_value AS subsequent_old_value, ROW_NUMBER() OVER (PARTITION BY primary_key_id ORDER BY audit_date ASC) AS rn
                FROM audit.audit_log AS al
                LEFT OUTER JOIN audit.audit_log_column AS alc
                    ON al.audit_log_id = alc.audit_log_id
                WHERE table_name = 'ELEMENT_GLOBAL' AND alc.column_name = 'G_RANK_CHANGE_DATE') AS next_audit
                ON (qry1.primary_key_id = next_audit.primary_key_id AND qry1.rn = next_audit.rn - 1)
            ORDER BY egt.element_global_id, qry1.rn) AS chg_log
            ON egt.element_global_id = chg_log.egt_id
        RIGHT OUTER JOIN
        /* get last change to rank date during period */
        (SELECT
            egt_id, MAX(rnk_chg_dt) AS period_last_chg
            FROM (SELECT
                al.primary_key_id AS egt_id, oracle.TO_DATE(old_value::TEXT, 'MON DD, YYYY HH:MI:SS') AS rnk_chg_dt
                FROM audit.audit_log AS al
                LEFT OUTER JOIN audit.audit_log_column AS alc
                    ON al.audit_log_id = alc.audit_log_id
                WHERE table_name = 'ELEMENT_GLOBAL' AND column_name = 'G_RANK_CHANGE_DATE'
            UNION
            SELECT
                element_global_id AS egt_id, g_rank_change_date
                FROM core.element_global) AS all_rank_chg_dt
            WHERE rnk_chg_dt BETWEEN (SELECT
                oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AND (SELECT
                oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))
            GROUP BY egt_id) AS last_chg
        /* ( */
            ON chg_log.egt_id = last_chg.egt_id
        LEFT OUTER JOIN
        /* AND to_date(changed_to,'MON DD, YYYY HH:MI:SS') = period_last_chg */
        /* ) */
        /* get first rank change date during period */
        (SELECT
            egt_id, MIN(rnk_chg_dt) AS period_first_chg
            FROM (SELECT
                al.primary_key_id AS egt_id, oracle.TO_DATE(old_value::TEXT, 'MON DD, YYYY HH:MI:SS') AS rnk_chg_dt
                FROM audit.audit_log AS al
                LEFT OUTER JOIN audit.audit_log_column AS alc
                    ON al.audit_log_id = alc.audit_log_id
                WHERE table_name = 'ELEMENT_GLOBAL' AND column_name = 'G_RANK_CHANGE_DATE'
            UNION
            SELECT
                element_global_id AS egt_id, g_rank_change_date
                FROM core.element_global) AS all_rank_chg_dt
            WHERE rnk_chg_dt BETWEEN (SELECT
                oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AND (SELECT
                oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))
            GROUP BY egt_id) AS first_chg
        /* ( */
            ON chg_log.egt_id = first_chg.egt_id
        /* AND to_date(CHANGED_TO,'MON DD, YYYY HH:MI:SS') = PERIOD_FIRST_CHG) */
        WHERE
        /* must be non-deleted elements (in current egt) */
        last_chg.egt_id IN (SELECT
            element_global_id
            FROM core.element_global) AND first_chg.egt_id IN (SELECT
            element_global_id
            FROM core.element_global) AND changed_to IS NOT NULL AND status = 'CURRENT' AND est.d_eo_track_status_id IN (1, 2) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> 'N/A (record created after date)' /* suppress new recs */
    UNION
    /* ***********      SRANK       ****************************************************** */
    SELECT
        est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'S rank' AS change_type, ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AS begin_value, ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')) AS end_value
        FROM core.element_subnational AS est
        WHERE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> 'N/A (record created after date)' AND /* suppress new recs */ est.d_eo_track_status_id IN (1, 2)
    UNION
    /*
    ***********   FEDERAL STATUS   ****************************************************
    Here we have to account for changes to the fed and state interpreted fed status as
    well as the main fed status. We won't try and deal with the eo_interpreted level.
    Most of the work here is performed by the "USESA_on_date" function.
    */
    SELECT
        est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Federal status' AS change_type, ext.usesa_on_date(est.element_subnational_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AS begin_value, ext.usesa_on_date(est.element_subnational_id, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')) AS end_value
        FROM core.element_subnational AS est
        WHERE ext.usesa_on_date(est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> ext.usesa_on_date(est.element_subnational_id, (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) AND ext.usesa_on_date(est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> 'N/A (record created after date)' AND est.d_eo_track_status_id IN (1, 2)
    UNION
    /* *********** STATE PROTECTION STATUS *********************************************** */
    SELECT
        est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'State status' AS change_type,
        CASE
            WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) = 'null' THEN 'no status'
            ELSE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))
        END AS begin_value,
        CASE
            WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')) = 'null' THEN 'no status'
            ELSE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))
        END AS end_value
        FROM core.element_subnational AS est
        WHERE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> 'N/A (record created after date)' AND /* suppress new recs */ est.d_eo_track_status_id IN (1, 2)
    UNION
    /*
    ***********  SCIENTIFIC NAME  *****************************************************
    There are 3 ways a scientific name can change.
    1) For an element in the EST, the SNAME_ID can be changed to attach a new name to it
    2) Within the scientific_name table, the spelling of the name can change
    3) EOs can be reparented to a new species name (these can only be detected when
       a species name is changed for all EOs, when just some of the EOs for a species
       are changed, as may be the case with a some taxonomic splits, we can't
       distinguish the split from an element reparenting to correct a data entry error)
    The first section below deals with changes of the first type.
    */
    SELECT
        est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Scientific name' AS change_type, (SELECT
            oracle.substr(sn.scientific_name, 1, 50)
            FROM core.scientific_name AS sn
            WHERE sn.scientific_name_id = (SELECT
                oracle.to_number(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
                    oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')))))) AS begin_value, (SELECT
            oracle.substr(sn.scientific_name, 1, 50)
            FROM core.scientific_name AS sn
            WHERE sn.scientific_name_id = (SELECT
                oracle.to_number(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
                    oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')))))) AS end_value
        FROM core.element_subnational AS est
        WHERE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> 'N/A (record created after date)' AND est.d_eo_track_status_id IN (1, 2)
    UNION
    /* The next section deals with changes of the second type. */
    SELECT
        est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Scientific name' AS change_type, ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AS begin_value, ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')) AS end_value
        FROM core.element_subnational AS est, core.scientific_name AS sn
        WHERE ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) AND ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) <> 'N/A (record created after date)' AND /* suppress the new records */ sn.scientific_name_id = est.sname_id AND est.d_eo_track_status_id IN (1, 2)
    UNION
    /* The next section deals with changes of the third type. */
    SELECT
        est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Scientific name' AS change_type, sn.scientific_name AS begin_value, (SELECT
            oracle.substr(sn.scientific_name, 1, 50)
            FROM core.scientific_name AS sn
            WHERE sn.scientific_name_id = (SELECT
                oracle.to_number(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
                    oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')))))) AS end_value
        FROM audit.audit_log AS al
        LEFT OUTER JOIN audit.audit_log_column AS alc
            ON al.audit_log_id = alc.audit_log_id
        LEFT OUTER JOIN core.eo
            ON al.primary_key_id = core.eo.eo_id
        LEFT OUTER JOIN
        /* return current AND deleted elements to get snames associated with them */
        (SELECT
            element_subnational_id, sname_id
            FROM core.element_subnational
        UNION
        SELECT
            element_subnational_id, sname_id
            FROM del.element_subnational_del) AS get_snames
            ON old_value = get_snames.element_subnational_id::TEXT
        LEFT OUTER JOIN core.scientific_name AS sn
            ON get_snames.sname_id = sn.scientific_name_id
        LEFT OUTER JOIN core.element_subnational AS est
            ON core.eo.element_subnational_id = est.element_subnational_id
        WHERE table_name = 'EO' AND column_name = 'ELEMENT_SUBNATIONAL_ID' AND audit_date BETWEEN (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AND (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')) AND
        /* no longer any EOs for the element */
        oracle.to_number(old_value) NOT IN (SELECT
            element_subnational_id
            FROM core.eo) AND
        /* EO still exists */
        primary_key_id IN (SELECT
            eo_id
            FROM core.eo) AND
        /* begin name is actually different than end name (element could be changed but name kept the same) */
        (SELECT
            scientific_name
            FROM core.scientific_name
            WHERE scientific_name_id = get_snames.sname_id) <> (SELECT
            oracle.substr(sn.scientific_name, 1, 50)
            FROM core.scientific_name AS sn
            WHERE sn.scientific_name_id = (SELECT
                oracle.to_number(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
                    oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))))))
    /* include untracked els here to catch cases where el of tracked EOs changed to untracked */
    /* and est.d_eo_track_status_id in (1,2) */
    UNION
    /*
    *********** TRACKING STATUS ******************************************************
    This is the only group where we will include NEW records if they are now tracked, and
    it is the only group where we WILL include elements that we don't now track, if the
    tracking status change was to DISCONTINUE tracking.
    */
    SELECT
        est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Tracking status' AS change_type,
        CASE
            WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) = '1' THEN 'Full tracking'
            WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) = '2' THEN 'Partial tracking'
            WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) = '3' THEN 'Watch list'
            ELSE 'Not tracked'
        END AS begin_value,
        CASE
            WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')) = '1' THEN 'Full tracking'
            WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')) = '2' THEN 'Partial tracking'
            WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd')) = '3' THEN 'Watch list'
            ELSE 'Not tracked'
        END AS end_value
        FROM core.element_subnational AS est
        WHERE (((ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) NOT IN ('1', '2') OR ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) IS NULL) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) IN ('1', '2')) OR ((ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd'))) IN ('1', '2')) AND (ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) NOT IN ('1', '2') OR ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) IS NULL)))
    UNION
    /*
    *********** TRACKING STATUS CONT' ************************************************
    Handles tracked elements that were deleted during the year.
    */
    SELECT
        est.element_subnational_id AS el_id, sort_order1.sort_order AS sort_order, elgroup1.name AS element_group, oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd') AS end_date, sn.scientific_name AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Tracking status' AS change_type,
        CASE
        CASE
            WHEN count_changes.change_cnt IS NOT NULL THEN oracle.to_char((SELECT
                alc.old_value
                FROM audit.audit_log_column AS alc
                WHERE alc.column_name = 'D_EO_TRACK_STATUS_ID' AND alc.audit_log_id = (SELECT
                    MIN(al.audit_log_id)
                    /* takes advantage of the fact that audit_log_ids are sequential in time */
                    FROM audit.audit_log AS al
                    LEFT OUTER JOIN audit.audit_log_column AS alc
                        ON al.audit_log_id = alc.audit_log_id
                    WHERE alc.column_name = 'D_EO_TRACK_STATUS_ID' AND al.action_code IN ('U') AND al.table_name = 'ELEMENT_SUBNATIONAL' AND oracle.TRUNC(al.audit_date) > (SELECT
                        oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AND al.primary_key_id = est.element_subnational_id
                    GROUP BY al.primary_key_id)))
            ELSE oracle.to_char(est.d_eo_track_status_id)
        END
            WHEN '1' THEN 'Full tracking'
            WHEN '2' THEN 'Partial tracking'
            WHEN '3' THEN 'Watch list'
            WHEN '4' THEN 'Not tracked'
        END AS begin_value, 'Not tracked - deleted' AS end_value
        FROM del.element_subnational_del AS est
        LEFT OUTER JOIN core.scientific_name AS sn
            ON est.sname_id = sn.scientific_name_id
        LEFT OUTER JOIN (SELECT
            al1.primary_key_id, alc1.old_value
            FROM audit.audit_log AS al1
            LEFT OUTER JOIN audit.audit_log_column AS alc1
                ON al1.audit_log_id = alc1.audit_log_id
            WHERE al1.table_name = 'ELEMENT_SUBNATIONAL' AND alc1.column_name = 'D_EO_TRACK_STATUS_ID' AND al1.audit_date BETWEEN (SELECT
                oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AND (SELECT
                oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) AS changes
            ON est.element_subnational_id = changes.primary_key_id
        LEFT OUTER JOIN (SELECT
            al2.primary_key_id, COUNT(al2.audit_log_id) AS change_cnt
            FROM audit.audit_log AS al2
            LEFT OUTER JOIN audit.audit_log_column AS alc2
                ON al2.audit_log_id = alc2.audit_log_id
            WHERE alc2.column_name = 'D_EO_TRACK_STATUS_ID' AND al2.action_code IN ('U') AND al2.table_name = 'ELEMENT_SUBNATIONAL' AND al2.audit_date BETWEEN (SELECT
                oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AND (SELECT
                oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))
            GROUP BY al2.primary_key_id) AS count_changes
            ON est.element_subnational_id = count_changes.primary_key_id
        LEFT OUTER JOIN (SELECT
            est1.element_subnational_id AS est_id,
            CASE
                WHEN ordr.concatenated_cd LIKE 'P%' THEN 100
                WHEN cls.higher_class_unit_name = 'Ascomycetes' THEN 100
                WHEN ordr.concatenated_cd = 'IPOR' THEN 200
                WHEN ordr.concatenated_cd LIKE 'ICNI%' THEN 210
                WHEN ordr.concatenated_cd LIKE 'IPLT%' THEN 215
                WHEN ordr.concatenated_cd LIKE 'IMBIV%' THEN 220
                WHEN ordr.concatenated_cd LIKE 'IMGAS%' THEN 230
                WHEN ordr.concatenated_cd LIKE 'IMCEP%' THEN 232
                WHEN ordr.concatenated_cd LIKE 'IANNOLI%' THEN 235
                WHEN ordr.higher_class_unit_name = 'Amblypygi' THEN 240
                WHEN ordr.higher_class_unit_name = 'Araneae' THEN 250
                WHEN ordr.concatenated_cd LIKE 'ICRUBRPSF%' THEN 253
                WHEN ordr.concatenated_cd LIKE 'ICRUBRPSC%' THEN 254
                WHEN ordr.concatenated_cd LIKE 'ICRUOST%' THEN 256
                WHEN ordr.concatenated_cd LIKE 'ICRUCOP%' THEN 258
                WHEN ordr.concatenated_cd = 'ICRUMALAM' THEN 260
                WHEN ordr.concatenated_cd = 'ICRUMALIS' THEN 270
                WHEN ordr.concatenated_cd = 'ICRUMALDE' THEN 280
                WHEN ordr.concatenated_cd LIKE 'IDIP%' THEN 282
                WHEN ordr.concatenated_cd = 'IELLCLL' THEN 285
                WHEN ordr.concatenated_cd = 'IIEPH' THEN 290
                WHEN ordr.concatenated_cd = 'IIOD' THEN 300
                WHEN ordr.concatenated_cd = 'IIOR' THEN 310
                WHEN ordr.concatenated_cd = 'IIPLE' THEN 315
                WHEN ordr.concatenated_cd IN ('IIHET', 'IIHOM') THEN 317
                WHEN ordr.concatenated_cd = 'IICOL' THEN 320
                WHEN ordr.concatenated_cd = 'IIMAL' THEN 322
                WHEN ordr.concatenated_cd = 'IIMEC' THEN 325
                WHEN ordr.concatenated_cd = 'IITRI' THEN 330
                WHEN ordr.concatenated_cd = 'IILE' THEN 340
                WHEN ordr.concatenated_cd = 'IIDI' THEN 350
                WHEN ordr.concatenated_cd = 'IIHYM' THEN 360
                WHEN ordr.concatenated_cd LIKE 'IECN%' THEN 380
                WHEN ordr.concatenated_cd = 'VF' THEN 510
                WHEN ordr.concatenated_cd = 'VA' THEN 520
                WHEN ordr.concatenated_cd IN ('VR', 'VT', 'VC') THEN 530
                WHEN ordr.concatenated_cd = 'VB' THEN 540
                WHEN ordr.concatenated_cd = 'VM' THEN 550
                WHEN egt1.elcode_bcd LIKE 'C%' THEN 800
                ELSE 900
            END AS sort_order
            FROM del.element_subnational_del AS est1
            LEFT OUTER JOIN core.element_national AS ent
                ON est1.element_national_id = ent.element_national_id
            LEFT OUTER JOIN core.element_global AS egt1
                ON ent.element_global_id = egt1.element_global_id
            LEFT OUTER JOIN core.higher_class_unit AS genus
                ON egt1.higher_class_unit_id = genus.higher_class_unit_id
            LEFT OUTER JOIN core.higher_class_unit AS family
                ON genus.parent_unit_id = family.higher_class_unit_id
            LEFT OUTER JOIN core.higher_class_unit AS ordr
                ON family.parent_unit_id = ordr.higher_class_unit_id
            LEFT OUTER JOIN core.higher_class_unit AS cls
                ON ordr.parent_unit_id = cls.higher_class_unit_id) AS sort_order1
            ON sort_order1.est_id = est.element_subnational_id
        LEFT OUTER JOIN (SELECT
            est1.element_subnational_id AS est_id,
            /* ordr.concatenated_cd, */
            /* ordr.higher_class_unit_name, */
            /* cls.higher_class_unit_name, */
            /* egt1.elcode_bcd, */
            /* genus.higher_class_unit_name, */
            CASE
                WHEN ordr.concatenated_cd = 'VF' THEN 'Fishes'
                WHEN ordr.concatenated_cd = 'VA' THEN 'Amphibians'
                WHEN ordr.concatenated_cd IN ('VR', 'VT', 'VC') THEN 'Reptiles'
                WHEN ordr.concatenated_cd = 'VB' THEN 'Birds'
                WHEN ordr.concatenated_cd = 'VM' THEN 'Mammals'
                WHEN ordr.concatenated_cd = 'IPOR' THEN 'Sponges'
                WHEN ordr.concatenated_cd LIKE 'ICNI%' THEN 'Corals and Allies'
                WHEN ordr.concatenated_cd LIKE 'IPLT%' THEN 'Flatworms'
                WHEN ordr.concatenated_cd LIKE 'IMBIV%' THEN 'Clams and Mussels'
                WHEN ordr.concatenated_cd LIKE 'IMGAS%' THEN 'Snails and Allies'
                WHEN ordr.concatenated_cd LIKE 'IMCEP%' THEN 'Octopuses and Allies'
                WHEN ordr.concatenated_cd LIKE 'IANNOLI%' THEN 'Earthworms'
                WHEN ordr.higher_class_unit_name = 'Amblypygi' THEN 'Scorpions and Allies'
                WHEN ordr.higher_class_unit_name = 'Araneae' THEN 'Spiders'
                WHEN ordr.concatenated_cd LIKE 'ICRUBRPSF%' THEN 'Fairy Shrimps'
                WHEN ordr.concatenated_cd LIKE 'ICRUBRPSC%' THEN 'Clam Shrimps'
                WHEN ordr.concatenated_cd LIKE 'ICRUOST%' THEN 'Ostracods'
                WHEN ordr.concatenated_cd LIKE 'ICRUCOP%' THEN 'Copepods'
                WHEN ordr.concatenated_cd = 'ICRUMALAM' THEN 'Amphipods'
                WHEN ordr.concatenated_cd = 'ICRUMALIS' THEN 'Isopods'
                WHEN ordr.concatenated_cd = 'ICRUMALDE' THEN 'Crabs, Crayfishes, and Shrimps'
                WHEN ordr.concatenated_cd LIKE 'IDIP%' THEN 'Millipedes'
                WHEN ordr.concatenated_cd = 'IELLCLL' THEN 'Springtails'
                WHEN ordr.concatenated_cd = 'IIEPH' THEN 'Mayflies'
                WHEN ordr.concatenated_cd = 'IIOD' THEN 'Dragonflies and Damselflies'
                WHEN ordr.concatenated_cd = 'IIOR' THEN 'Grasshoppers and Allies'
                WHEN ordr.concatenated_cd = 'IIPLE' THEN 'Stoneflies'
                WHEN ordr.concatenated_cd IN ('IIHET', 'IIHOM') THEN 'True Bugs and Allies'
                WHEN ordr.concatenated_cd = 'IICOL' THEN 'Beetles'
                WHEN ordr.concatenated_cd = 'IIMAL' THEN 'Mallophaga'
                WHEN ordr.concatenated_cd = 'IIMEC' THEN 'Scorpionflies'
                WHEN ordr.concatenated_cd = 'IITRI' THEN 'Caddisflies'
                WHEN ordr.concatenated_cd = 'IILE' THEN 'Butterflies and Moths'
                WHEN ordr.concatenated_cd = 'IIDI' THEN 'Flies'
                WHEN ordr.concatenated_cd = 'IIHYM' THEN 'Ants, Bees, and Wasps'
                WHEN ordr.concatenated_cd LIKE 'IECN%' THEN 'Sea Stars and Allies'
                WHEN ordr.concatenated_cd LIKE 'P%' THEN 'Plants and Lichens'
                WHEN cls.higher_class_unit_name = 'Ascomycetes' THEN 'Plants and Lichens'
                WHEN egt1.elcode_bcd LIKE 'C%' THEN 'Natural Communities'
                ELSE 'Other Elements'
            END AS name
            FROM del.element_subnational_del AS est1
            LEFT OUTER JOIN core.element_national AS ent
                ON est1.element_national_id = ent.element_national_id
            LEFT OUTER JOIN core.element_global AS egt1
                ON ent.element_global_id = egt1.element_global_id
            LEFT OUTER JOIN core.higher_class_unit AS genus
                ON egt1.higher_class_unit_id = genus.higher_class_unit_id
            LEFT OUTER JOIN core.higher_class_unit AS family
                ON genus.parent_unit_id = family.higher_class_unit_id
            LEFT OUTER JOIN core.higher_class_unit AS ordr
                ON family.parent_unit_id = ordr.higher_class_unit_id
            LEFT OUTER JOIN core.higher_class_unit AS cls
                ON ordr.parent_unit_id = cls.higher_class_unit_id) AS elgroup1
            ON elgroup1.est_id = est.element_subnational_id
        WHERE (est.deletion_date BETWEEN (SELECT
            oracle.TO_DATE('2025-08-01', 'yyyy-mm-dd')) AND (SELECT
            oracle.TO_DATE('2026-08-09', 'yyyy-mm-dd'))) AND (est.d_eo_track_status_id IN (1, 2) OR changes.old_value IN (1::TEXT, 2::TEXT)) AND
        /* exclude cases where sname is now used for a different element */
        est.sname_id NOT IN (SELECT
            sname_id
            FROM core.element_subnational)) AS var_sbq_3
    WHERE begin_value <> end_value AND NOT (change_type = 'State status' AND begin_value = 'E' AND end_value = 'SE') AND NOT (change_type = 'State status' AND begin_value = 'T' AND end_value = 'ST') AND NOT (element_group = 'Plants and Lichens' AND begin_value = 'E' AND end_value = 'FE') AND NOT (element_group = 'Plants and Lichens' AND begin_value = 'T' AND end_value = 'FT')
    ORDER BY sort_order, sname, change_type, begin_value DESC;


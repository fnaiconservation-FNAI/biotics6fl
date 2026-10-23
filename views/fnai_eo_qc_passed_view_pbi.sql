CREATE OR REPLACE  VIEW ext.fnai_eo_qc_passed_view_pbi ("Full Name", user_name, eo_cnt, eos_qcd) AS
SELECT
    users."Full Name", COALESCE(eos_qc.user_name, eos_new_edit.user_name) AS user_name, eo_cnt, eos_qcd
    FROM
    /* EOs QC'd */
    (SELECT
        user_name, COUNT(DISTINCT eo_id) AS eos_qcd
        FROM (SELECT
            core.eo.eo_id, all_audit_data.user_name
            FROM core.eo
            LEFT OUTER JOIN core.shape
                ON core.eo.shape_id = core.shape.shape_id
            LEFT OUTER JOIN ext.eo_flext1
                ON core.eo.eo_id = ext.eo_flext1.eo_id
            LEFT OUTER JOIN
            /* join to eo audit data */
            (SELECT
                primary_key_id, audit_date, old_value, user_name, 'data' AS qc_type
                FROM
                /* EO audit data */
                (SELECT
                    primary_key_id, audit_date, old_value, al.user_name, 'data' AS qc_type
                    FROM audit.audit_log AS al
                    LEFT OUTER JOIN audit.audit_log_column AS alc
                        ON al.audit_log_id = alc.audit_log_id
                    WHERE table_name = 'EO' AND alc.column_name = 'D_DATA_QC_STATUS_ID' AND alc.old_value <> '2' AND audit_date BETWEEN (SELECT
                        oracle.TO_DATE('2024-01-01', 'YYYY-MM-DD')) AND (SELECT
                        oracle.TO_DATE('2024-03-30', 'YYYY-MM-DD'))) AS qry1
            /* union to shape audit data */
            UNION
            SELECT
                eo_id, audit_date, old_value, user_name, 'shape' AS qc_type
                FROM core.eo AS eo1
                LEFT OUTER JOIN (SELECT
                    primary_key_id, audit_date, old_value, al.user_name
                    FROM audit.audit_log AS al
                    LEFT OUTER JOIN audit.audit_log_column AS alc
                        ON al.audit_log_id = alc.audit_log_id
                    WHERE table_name = 'SHAPE' AND alc.column_name = 'MAP_QC_STATUS' AND alc.old_value <> 'P' AND audit_date BETWEEN (SELECT
                        oracle.TO_DATE('2024-01-01', 'YYYY-MM-DD')) AND (SELECT
                        oracle.TO_DATE('2024-03-30', 'YYYY-MM-DD'))) AS qry2
                    ON eo1.shape_id = qry2.primary_key_id
                WHERE qry2.audit_date IS NOT NULL) AS all_audit_data
                ON all_audit_data.primary_key_id = core.eo.eo_id
            WHERE d_data_qc_status_id = 2 AND core.shape.map_qc_status = 'P' AND all_audit_data.qc_type IS NOT NULL) AS var_sbq
        GROUP BY user_name) AS eos_qc
    FULL OUTER JOIN
    /* EOs entered/edited */
    (SELECT
        user_name, COUNT(eo_id) AS eo_cnt
        FROM (
        /* * */
        /* DISTINCT VERSION_AUTHOR_NAME */
        SELECT
            eo_id,
            CASE
                WHEN version_author_name LIKE 'Almquist%' THEN 'dta'
                WHEN version_author_name LIKE 'Anderson%' THEN 'kaa'
                WHEN version_author_name LIKE 'Annis%' THEN 'jma'
                WHEN version_author_name LIKE 'Brandt%' THEN 'khb'
                WHEN version_author_name LIKE 'Damm%' THEN 'eed'
                WHEN version_author_name LIKE 'DeVos%' THEN 'tbd'
                WHEN version_author_name LIKE 'Dunlop%' THEN 'dmd'
                WHEN version_author_name LIKE 'East%' THEN 'mbe'
                WHEN version_author_name LIKE 'Eckel%' THEN 'cme'
                WHEN (version_author_name LIKE 'Gulledge%' OR version_author_name LIKE 'Alexander%') THEN 'kjg'
                WHEN version_author_name LIKE 'Gundy%' THEN 'rlg'
                WHEN version_author_name LIKE 'Heiker%' THEN 'ach'
                WHEN version_author_name LIKE 'Herring%' THEN 'bjh'
                WHEN version_author_name LIKE 'Hill%' THEN 'gmh'
                WHEN version_author_name LIKE 'Hipes%' THEN 'dlh'
                WHEN version_author_name LIKE 'Hooker%' THEN 'krh'
                WHEN version_author_name LIKE 'Hughes%' THEN 'elh'
                WHEN version_author_name LIKE 'Jackson%' THEN 'drj'
                WHEN version_author_name LIKE 'Jenkins, A%' THEN 'amj'
                WHEN version_author_name LIKE 'Johnson%' THEN 'afj'
                WHEN version_author_name LIKE 'Jue, D%' THEN 'dkj'
                WHEN version_author_name LIKE 'Jue, S%' THEN 'ssj'
                WHEN version_author_name LIKE 'Knight, G%' THEN 'grk'
                WHEN version_author_name LIKE 'Knight, A%' THEN 'alk'
                WHEN version_author_name LIKE 'Koon%' THEN 'aek'
                WHEN version_author_name LIKE 'NeSmith%' THEN 'ccn'
                WHEN version_author_name LIKE 'Oetting%' THEN 'jbo'
                WHEN version_author_name LIKE 'Parks%' THEN 'grp'
                WHEN version_author_name LIKE 'Pasco%' THEN 'ndp'
                WHEN version_author_name LIKE 'Price%' THEN 'fdp'
                WHEN version_author_name LIKE 'Rosner-Katz%' THEN 'hrk'
                WHEN version_author_name LIKE 'Russo%' THEN 'pfr'
                WHEN version_author_name LIKE 'Schultz%' THEN 'ges'
                WHEN version_author_name LIKE 'Smith%' THEN 'mms'
                WHEN version_author_name LIKE 'Sowell%' THEN 'drs'
                WHEN version_author_name LIKE 'Stango%' THEN 'pxs'
                WHEN version_author_name LIKE 'Surdick%' THEN 'jas'
                WHEN version_author_name LIKE 'Travers%' THEN 'jht'
                WHEN version_author_name LIKE 'Zampieri%' THEN 'nez'
                WHEN version_author_name LIKE 'Zeroth%' THEN 'raz'
                ELSE CONCAT_WS('', version_author_name, ', EO_ID:', oracle.to_char(eo_id))
            END AS user_name
            FROM core.eo
            LEFT OUTER JOIN core.shape
                ON core.eo.shape_id = core.shape.shape_id
            WHERE (core.eo.version_date BETWEEN oracle.TRUNC(oracle.TO_DATE('2024-01-01', 'YYYY-MM-DD')) AND oracle.TRUNC(oracle.TO_DATE('2024-03-30', 'YYYY-MM-DD'))))
        /* AND eo.d_data_qc_status_id IN (2) */
        /* AND shape.map_qc_status IN ('P') */
        AS var_sbq_2
        GROUP BY user_name) AS eos_new_edit
        ON eos_qc.user_name = eos_new_edit.user_name
    LEFT OUTER JOIN security.security_users_vw AS users
        ON COALESCE(eos_qc.user_name, eos_new_edit.user_name) = users."Username"
    /* WHERE */
    /* eos_qc.user_name = 'dta' */
    /* OR eos_new_edit.user_name = 'dta' */
    ORDER BY user_name;


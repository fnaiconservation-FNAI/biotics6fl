CREATE OR REPLACE  VIEW ext.fnai_el_rnk_rev_age_per_yr_pbi (elgroup, yr, mean_yrs_since_rev) AS
SELECT
    elgroup, yr, ROUND(AVG(age_of_rev), 1) AS mean_yrs_since_rev
    FROM (SELECT
        ext.elgroup_political_name(est.element_subnational_id) AS elgroup, 2015 AS yr, ROUND(((EXTRACT (EPOCH FROM oracle.TO_DATE('2015-12-31', 'RRRR-MM-DD') -
        CASE
            WHEN ext.is_number(oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2015-12-31', 'RRRR-MM-DD')), 1, 1)) = 1 THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2015-12-31', 'RRRR-MM-DD'))::TEXT)
            WHEN oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2015-12-31', 'RRRR-MM-DD')), 4, 1) = ' ' THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2015-12-31', 'RRRR-MM-DD'))::TEXT, 'MON DD, RRRR HH:MI:SS')
            ELSE NULL
        END) / 86400)::NUMERIC)::NUMERIC / 365.25, 1) AS age_of_rev
        FROM core.element_subnational AS est
        WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2015-12-31', 'RRRR-MM-DD'))) <> 'N/A (record created after date)' AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2015-12-31', 'RRRR-MM-DD'))) IS NOT NULL
    UNION
    SELECT
        ext.elgroup_political_name(est.element_subnational_id) AS elgroup, 2016 AS yr, ROUND(((EXTRACT (EPOCH FROM oracle.TO_DATE('2016-12-31', 'RRRR-MM-DD') -
        CASE
            WHEN ext.is_number(oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2016-12-31', 'RRRR-MM-DD')), 1, 1)) = 1 THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2016-12-31', 'RRRR-MM-DD'))::TEXT)
            WHEN oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2016-12-31', 'RRRR-MM-DD')), 4, 1) = ' ' THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2016-12-31', 'RRRR-MM-DD'))::TEXT, 'MON DD, RRRR HH:MI:SS')
            ELSE NULL
        END) / 86400)::NUMERIC)::NUMERIC / 365.25, 1) AS age_of_rev
        FROM core.element_subnational AS est
        WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2016-12-31', 'RRRR-MM-DD'))) <> 'N/A (record created after date)' AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2016-12-31', 'RRRR-MM-DD'))) IS NOT NULL
    UNION
    SELECT
        ext.elgroup_political_name(est.element_subnational_id) AS elgroup, 2017 AS yr, ROUND(((EXTRACT (EPOCH FROM oracle.TO_DATE('2017-12-31', 'RRRR-MM-DD') -
        CASE
            WHEN ext.is_number(oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2017-12-31', 'RRRR-MM-DD')), 1, 1)) = 1 THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2017-12-31', 'RRRR-MM-DD'))::TEXT)
            WHEN oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2017-12-31', 'RRRR-MM-DD')), 4, 1) = ' ' THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2017-12-31', 'RRRR-MM-DD'))::TEXT, 'MON DD, RRRR HH:MI:SS')
            ELSE NULL
        END) / 86400)::NUMERIC)::NUMERIC / 365.25, 1) AS age_of_rev
        FROM core.element_subnational AS est
        WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2017-12-31', 'RRRR-MM-DD'))) <> 'N/A (record created after date)' AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2017-12-31', 'RRRR-MM-DD'))) IS NOT NULL
    UNION
    SELECT
        ext.elgroup_political_name(est.element_subnational_id) AS elgroup, 2018 AS yr, ROUND(((EXTRACT (EPOCH FROM oracle.TO_DATE('2018-12-31', 'RRRR-MM-DD') -
        CASE
            WHEN ext.is_number(oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2018-12-31', 'RRRR-MM-DD')), 1, 1)) = 1 THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2018-12-31', 'RRRR-MM-DD'))::TEXT)
            WHEN oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2018-12-31', 'RRRR-MM-DD')), 4, 1) = ' ' THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2018-12-31', 'RRRR-MM-DD'))::TEXT, 'MON DD, RRRR HH:MI:SS')
            ELSE NULL
        END) / 86400)::NUMERIC)::NUMERIC / 365.25, 1) AS age_of_rev
        FROM core.element_subnational AS est
        WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2018-12-31', 'RRRR-MM-DD'))) <> 'N/A (record created after date)' AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2018-12-31', 'RRRR-MM-DD'))) IS NOT NULL
    UNION
    SELECT
        ext.elgroup_political_name(est.element_subnational_id) AS elgroup, 2019 AS yr, ROUND(((EXTRACT (EPOCH FROM oracle.TO_DATE('2019-12-31', 'RRRR-MM-DD') -
        CASE
            WHEN ext.is_number(oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2019-12-31', 'RRRR-MM-DD')), 1, 1)) = 1 THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2019-12-31', 'RRRR-MM-DD'))::TEXT)
            WHEN oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2019-12-31', 'RRRR-MM-DD')), 4, 1) = ' ' THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2019-12-31', 'RRRR-MM-DD'))::TEXT, 'MON DD, RRRR HH:MI:SS')
            ELSE NULL
        END) / 86400)::NUMERIC)::NUMERIC / 365.25, 1) AS age_of_rev
        FROM core.element_subnational AS est
        WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2019-12-31', 'RRRR-MM-DD'))) <> 'N/A (record created after date)' AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2019-12-31', 'RRRR-MM-DD'))) IS NOT NULL
    UNION
    SELECT
        ext.elgroup_political_name(est.element_subnational_id) AS elgroup, 2020 AS yr, ROUND(((EXTRACT (EPOCH FROM oracle.TO_DATE('2020-12-31', 'RRRR-MM-DD') -
        CASE
            WHEN ext.is_number(oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2020-12-31', 'RRRR-MM-DD')), 1, 1)) = 1 THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2020-12-31', 'RRRR-MM-DD'))::TEXT)
            WHEN oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2020-12-31', 'RRRR-MM-DD')), 4, 1) = ' ' THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2020-12-31', 'RRRR-MM-DD'))::TEXT, 'MON DD, RRRR HH:MI:SS')
            ELSE NULL
        END) / 86400)::NUMERIC)::NUMERIC / 365.25, 1) AS age_of_rev
        FROM core.element_subnational AS est
        WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2020-12-31', 'RRRR-MM-DD'))) <> 'N/A (record created after date)' AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2020-12-31', 'RRRR-MM-DD'))) IS NOT NULL
    UNION
    SELECT
        ext.elgroup_political_name(est.element_subnational_id) AS elgroup, 2021 AS yr, ROUND(((EXTRACT (EPOCH FROM oracle.TO_DATE('2021-12-31', 'RRRR-MM-DD') -
        CASE
            WHEN ext.is_number(oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2021-12-31', 'RRRR-MM-DD')), 1, 1)) = 1 THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2021-12-31', 'RRRR-MM-DD'))::TEXT)
            WHEN oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2021-12-31', 'RRRR-MM-DD')), 4, 1) = ' ' THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2021-12-31', 'RRRR-MM-DD'))::TEXT, 'MON DD, RRRR HH:MI:SS')
            ELSE NULL
        END) / 86400)::NUMERIC)::NUMERIC / 365.25, 1) AS age_of_rev
        FROM core.element_subnational AS est
        WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2021-12-31', 'RRRR-MM-DD'))) <> 'N/A (record created after date)' AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2021-12-31', 'RRRR-MM-DD'))) IS NOT NULL
    UNION
    SELECT
        ext.elgroup_political_name(est.element_subnational_id) AS elgroup, 2022 AS yr, ROUND(((EXTRACT (EPOCH FROM oracle.TO_DATE('2022-12-31', 'RRRR-MM-DD') -
        CASE
            WHEN ext.is_number(oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2022-12-31', 'RRRR-MM-DD')), 1, 1)) = 1 THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2022-12-31', 'RRRR-MM-DD'))::TEXT)
            WHEN oracle.substr(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2022-12-31', 'RRRR-MM-DD')), 4, 1) = ' ' THEN oracle.TO_DATE(ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, oracle.TO_DATE('2022-12-31', 'RRRR-MM-DD'))::TEXT, 'MON DD, RRRR HH:MI:SS')
            ELSE NULL
        END) / 86400)::NUMERIC)::NUMERIC / 365.25, 1) AS age_of_rev
        FROM core.element_subnational AS est
        WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2022-12-31', 'RRRR-MM-DD'))) <> 'N/A (record created after date)' AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK_REVIEW_DATE'::TEXT, est.element_subnational_id, (SELECT
            oracle.TO_DATE('2022-12-31', 'RRRR-MM-DD'))) IS NOT NULL
    UNION
    SELECT
        ext.elgroup_political_name(est.element_subnational_id) AS elgroup,
        /* , CAST(SUBSTR(SYSDATE,1,4) as int) AS YR --get current year */
        2023 AS yr, ROUND(((EXTRACT (EPOCH FROM (CLOCK_TIMESTAMP() AT TIME ZONE COALESCE(CURRENT_SETTING('aws_oracle_ext.tz', TRUE), 'EDT'))::TIMESTAMP(0) - est.s_rank_review_date) / 86400)::NUMERIC)::NUMERIC / 365.25, 0) AS age_of_rev
        FROM core.element_subnational AS est
        WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL)
    /* AND is_number(SUBSTR(TO_CHAR(SYSDATE),1,4))=1 */
    AS var_sbq
    GROUP BY elgroup, yr
    ORDER BY elgroup, yr;


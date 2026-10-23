CREATE OR REPLACE  VIEW ext.fnai_est_phenology (element_subnational_id, sci_name, month_ab, phen_season) AS
WITH date_parts
AS (
/* Visit Dates */
SELECT DISTINCT
    visit_date, core.source_feature.element_subnational_id, ext.sci_name(core.source_feature.element_subnational_id) AS sci_name, regexp_substr((visit_date)::TEXT, ('[0-9]{4}-([0-9]{2})')::TEXT, (1)::INTEGER, (1)::INTEGER, NULL::TEXT, (1)::INTEGER) AS start_month_num, regexp_substr((visit_date)::TEXT, ('[0-9]{4}-([0-9]{2})')::TEXT, (1)::INTEGER, (2)::INTEGER, NULL::TEXT, (1)::INTEGER) AS end_month_num, regexp_substr((visit_date)::TEXT, ('[0-9]{4}-[0-9]{2}-([0-9]{2})')::TEXT, (1)::INTEGER, (1)::INTEGER, NULL::TEXT, (1)::INTEGER) AS start_day, regexp_substr((visit_date)::TEXT, ('[0-9]{4}-[0-9]{2}-([0-9]{2})')::TEXT, (1)::INTEGER, (2)::INTEGER, NULL::TEXT, (1)::INTEGER) AS end_day
    FROM core.visit
    JOIN core.source_feature
        ON core.visit.source_feature_id = core.source_feature.source_feature_id
    JOIN core.shape
        ON core.source_feature.shape_id = core.shape.shape_id
    JOIN ext.source_feature_flext1 AS flx
        ON core.source_feature.source_feature_id = flx.source_feature_id
    JOIN core.eo_source_feature AS eosf
        ON core.source_feature.source_feature_id = eosf.source_feature_id
    JOIN core.eo
        ON eosf.eo_id = core.eo.eo_id
    JOIN core.shape AS eo_shape
        ON core.eo.shape_id = eo_shape.shape_id
    WHERE ext.elgroup_name(core.source_feature.element_subnational_id) NOT IN ('Other Elements', 'Plants and Lichens', 'Natural Communities') AND ext.chk_txt_date(visit_date) NOT LIKE 'Invalid%' AND NOT regexp_like((visit_date)::TEXT, ('pre|circa|spring|fall|winter|summer')::TEXT, 'i') AND core.source_feature.d_data_qc_status_id = 2 AND core.shape.map_qc_status = 'P' AND d_source_feature_rank_id = 1 AND core.eo.d_data_qc_status_id = 2 AND eo_shape.map_qc_status = 'P' AND core.eo.d_id_confirmed_id = 2 AND core.eo.d_basic_eo_rank_id <= 14
/* AND REGEXP_LIKE(visit_date, '^[0-9]{4}-(0[1-9]|1[0-2])($|-[0-9]{2}($| --))') */
UNION
/* EO First Obs Date */
SELECT DISTINCT
    first_obs_date, element_subnational_id, ext.sci_name(element_subnational_id) AS sci_name, regexp_substr((first_obs_date)::TEXT, ('[0-9]{4}-([0-9]{2})')::TEXT, (1)::INTEGER, (1)::INTEGER, NULL::TEXT, (1)::INTEGER) AS start_month_num, regexp_substr((first_obs_date)::TEXT, ('[0-9]{4}-([0-9]{2})')::TEXT, (1)::INTEGER, (2)::INTEGER, NULL::TEXT, (1)::INTEGER) AS end_month_num, regexp_substr((first_obs_date)::TEXT, ('[0-9]{4}-[0-9]{2}-([0-9]{2})')::TEXT, (1)::INTEGER, (1)::INTEGER, NULL::TEXT, (1)::INTEGER) AS start_day, regexp_substr((first_obs_date)::TEXT, ('[0-9]{4}-[0-9]{2}-([0-9]{2})')::TEXT, (1)::INTEGER, (2)::INTEGER, NULL::TEXT, (1)::INTEGER) AS end_day
    FROM core.eo
    JOIN core.shape
        ON core.eo.shape_id = core.shape.shape_id
    WHERE ext.elgroup_name(element_subnational_id) NOT IN ('Other Elements', 'Plants and Lichens', 'Natural Communities') AND ext.chk_txt_date(first_obs_date) NOT LIKE 'Invalid%' AND NOT regexp_like((first_obs_date)::TEXT, ('pre|circa|spring|fall|winter|summer')::TEXT, 'i') AND core.eo.d_data_qc_status_id = 2 AND core.shape.map_qc_status = 'P' AND core.eo.d_id_confirmed_id = 2 AND core.eo.d_basic_eo_rank_id <= 14
/* AND REGEXP_LIKE(first_obs_date, '^[0-9]{4}-(0[1-9]|1[0-2])($|-[0-9]{2}($| --))') */
UNION
/* EO Last Obs Date */
SELECT DISTINCT
    last_obs_date, element_subnational_id, ext.sci_name(element_subnational_id) AS sci_name, regexp_substr((last_obs_date)::TEXT, ('[0-9]{4}-([0-9]{2})')::TEXT, (1)::INTEGER, (1)::INTEGER, NULL::TEXT, (1)::INTEGER) AS start_month_num, regexp_substr((last_obs_date)::TEXT, ('[0-9]{4}-([0-9]{2})')::TEXT, (1)::INTEGER, (2)::INTEGER, NULL::TEXT, (1)::INTEGER) AS end_month_num, regexp_substr((last_obs_date)::TEXT, ('[0-9]{4}-[0-9]{2}-([0-9]{2})')::TEXT, (1)::INTEGER, (1)::INTEGER, NULL::TEXT, (1)::INTEGER) AS start_day, regexp_substr((last_obs_date)::TEXT, ('[0-9]{4}-[0-9]{2}-([0-9]{2})')::TEXT, (1)::INTEGER, (2)::INTEGER, NULL::TEXT, (1)::INTEGER) AS end_day
    FROM core.eo
    JOIN core.shape
        ON core.eo.shape_id = core.shape.shape_id
    WHERE ext.elgroup_name(element_subnational_id) NOT IN ('Other Elements', 'Plants and Lichens', 'Natural Communities') AND ext.chk_txt_date(last_obs_date) NOT LIKE 'Invalid%' AND NOT regexp_like((last_obs_date)::TEXT, ('pre|circa|spring|fall|winter|summer')::TEXT, 'i') AND core.eo.d_data_qc_status_id = 2 AND core.shape.map_qc_status = 'P' AND core.eo.d_id_confirmed_id = 2 AND core.eo.d_basic_eo_rank_id <= 14
/* AND REGEXP_LIKE(last_obs_date, '^[0-9]{4}-(0[1-9]|1[0-2])($|-[0-9]{2}($| --))') */
), ranges
AS (SELECT
    visit_date, element_subnational_id, sci_name, oracle.TO_DATE(CONCAT_WS('', '01-', start_month_num, '-2000')::TEXT, 'DD-MM-YYYY') AS start_month, oracle.TO_DATE(CONCAT_WS('', '01-', COALESCE(end_month_num, start_month_num), '-2000')::TEXT, 'DD-MM-YYYY') AS end_month, oracle.to_number(start_day) AS start_day, oracle.to_number(end_day) AS end_day
    FROM date_parts
    WHERE start_month_num IS NOT NULL
/* AND sci_name =  'Asioplax dolani' -- -- -- -- -- -- -- ---- -- -- -- ---- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Subset for testing */
), expanded_months
AS (WITH RECURSIVE t (visit_date, element_subnational_id, month_date, sys_guid)
AS (SELECT
    r.visit_date, r.element_subnational_id, oracle.ADD_MONTHS(r.start_month, (1)::NUMERIC - 1) AS month_date, r.sys_guid, (1)::NUMERIC AS level
    FROM ranges AS r
UNION ALL
SELECT
    t_2.visit_date, t_2.element_subnational_id, oracle.ADD_MONTHS(r.start_month, (t.level + 1)::NUMERIC - 1) AS month_date, t_2.sys_guid, (t.level + 1)::NUMERIC AS level
    FROM ranges AS t_2, t
    WHERE (t.level + 1)::NUMERIC <= oracle.MONTHS_BETWEEN(t_2.end_month, t_2.start_month) + 1 AND t.visit_date = t_2.visit_date AND oracle.sys_guid() IS NOT NULL)
SELECT
    visit_date, element_subnational_id, t.sci_name AS "R.SCI_NAME", t.start_month AS "R.START_MONTH", t.end_month AS "R.END_MONTH", t.start_day AS "R.START_DAY", t.end_day AS "R.END_DAY", month_date
    FROM t), periods
AS (SELECT
    visit_date, element_subnational_id, sci_name, month_date,
    CASE
        WHEN start_month = end_month AND start_day IS NOT NULL AND end_day IS NULL AND start_day <= 15 THEN 'A'
        WHEN start_month = end_month AND start_day IS NOT NULL AND end_day IS NULL AND start_day >= 16 THEN 'B'
        WHEN start_month <> end_month AND start_day IS NULL AND end_day IS NULL AND month_date = start_month THEN 'B'
        WHEN start_month <> end_month AND start_day IS NULL AND end_day IS NULL AND month_date = end_month THEN 'A'
        WHEN start_month <> end_month AND start_day IS NULL AND end_day IS NULL THEN 'A/B'
        WHEN start_month = end_month AND start_day IS NULL AND end_day IS NULL THEN 'Unknown'
        WHEN start_month = end_month AND start_day <= 15 AND end_day <= 15 THEN 'A'
        WHEN start_month = end_month AND start_day >= 16 AND end_day >= 16 THEN 'B'
        WHEN start_month = end_month THEN 'A/B'
        WHEN month_date = start_month AND start_day IS NOT NULL THEN (CASE
            WHEN start_day <= 15 THEN 'A/B'
            ELSE 'B'
        END)
        WHEN month_date = end_month AND end_day IS NOT NULL THEN (CASE
            WHEN end_day <= 15 THEN 'A'
            ELSE 'A/B'
        END)
        ELSE 'A/B'
    END AS period
    FROM expanded_months), month_results
AS (SELECT
    visit_date, element_subnational_id, sci_name, CONCAT_WS('', oracle.to_char(month_date, 'FMMonth', 'NLS_DATE_LANGUAGE=English'), ' A') AS month_ab, EXTRACT (MONTH FROM month_date) AS sort_order
    FROM periods
    WHERE period IN ('A', 'A/B')
UNION
SELECT
    visit_date, element_subnational_id, sci_name, CONCAT_WS('', oracle.to_char(month_date, 'FMMonth', 'NLS_DATE_LANGUAGE=English'), ' B') AS month_ab, EXTRACT (MONTH FROM month_date) AS sort_order
    FROM periods
    WHERE period IN ('B', 'A/B')
UNION
SELECT
    visit_date, element_subnational_id, sci_name, CONCAT_WS('', oracle.to_char(month_date, 'FMMonth', 'NLS_DATE_LANGUAGE=English'), ' Unknown') AS month_ab, EXTRACT (MONTH FROM month_date) AS sort_order
    FROM periods AS p
    WHERE period = 'Unknown' AND NOT EXISTS (
    /* Not in Union A and Not in Union B */
    SELECT
        1
        FROM periods AS p2
        WHERE p2.element_subnational_id = p.element_subnational_id AND p2.month_date = p.month_date
        GROUP BY p2.element_subnational_id, p2.month_date
        HAVING COUNT(CASE
            WHEN p2.period IN ('A', 'A/B') THEN 1
        END) > 0 AND COUNT(CASE
            WHEN p2.period IN ('B', 'A/B') THEN 1
        END) > 0)), season_results
AS (SELECT
    *
    FROM (SELECT DISTINCT
        visit_date, core.source_feature.element_subnational_id, ext.sci_name(core.source_feature.element_subnational_id) AS sci_name,
        CASE
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' spring$')::TEXT, 'i') THEN 'spring'
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' spring-summer$')::TEXT, 'i') THEN 'spring-summer'
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' summer$')::TEXT, 'i') THEN 'summer'
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' summer-fall$')::TEXT, 'i') THEN 'summer-fall'
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' fall$')::TEXT, 'i') THEN 'fall'
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' fall-winter$')::TEXT, 'i') THEN 'fall-winter'
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' winter$')::TEXT, 'i') THEN 'winter'
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' winter-spring$')::TEXT, 'i') THEN 'winter-spring'
        END AS month_ab,
        CASE
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' spring$')::TEXT, 'i') THEN 13
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' spring-summer$')::TEXT, 'i') THEN 14
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' summer$')::TEXT, 'i') THEN 15
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' summer-fall$')::TEXT, 'i') THEN 16
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' fall$')::TEXT, 'i') THEN 17
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' fall-winter$')::TEXT, 'i') THEN 18
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' winter$')::TEXT, 'i') THEN 19
            WHEN regexp_like((visit_date::TEXT)::TEXT, (' winter-spring$')::TEXT, 'i') THEN 20
        END AS sort_order
        FROM core.visit
        JOIN core.source_feature
            ON core.visit.source_feature_id = core.source_feature.source_feature_id
        JOIN core.shape
            ON core.source_feature.shape_id = core.shape.shape_id
        JOIN ext.source_feature_flext1 AS flx
            ON core.source_feature.source_feature_id = flx.source_feature_id
        JOIN core.eo_source_feature AS eosf
            ON core.source_feature.source_feature_id = eosf.source_feature_id
        JOIN core.eo
            ON eosf.eo_id = core.eo.eo_id
        JOIN core.shape AS eo_shape
            ON core.eo.shape_id = eo_shape.shape_id
        WHERE ext.elgroup_name(core.source_feature.element_subnational_id) NOT IN ('Other Elements', 'Plants and Lichens', 'Natural Communities') AND ext.chk_txt_date(visit_date) NOT LIKE 'Invalid%' AND NOT regexp_like((visit_date::TEXT)::TEXT, ('pre|circa')::TEXT, 'i') AND regexp_like((visit_date::TEXT)::TEXT, ('(spring|summer|fall|winter)')::TEXT, 'i') AND core.source_feature.d_data_qc_status_id = 2 AND core.shape.map_qc_status = 'P' AND d_source_feature_rank_id = 1 AND core.eo.d_data_qc_status_id = 2 AND core.shape.map_qc_status = 'P' AND core.eo.d_id_confirmed_id = 2 AND core.eo.d_basic_eo_rank_id <= 14
    UNION
    SELECT DISTINCT
        first_obs_date, element_subnational_id, ext.sci_name(element_subnational_id) AS sci_name,
        CASE
            WHEN regexp_like((first_obs_date)::TEXT, (' spring$')::TEXT, 'i') THEN 'spring'
            WHEN regexp_like((first_obs_date)::TEXT, (' spring-summer$')::TEXT, 'i') THEN 'spring-summer'
            WHEN regexp_like((first_obs_date)::TEXT, (' summer$')::TEXT, 'i') THEN 'summer'
            WHEN regexp_like((first_obs_date)::TEXT, (' summer-fall$')::TEXT, 'i') THEN 'summer-fall'
            WHEN regexp_like((first_obs_date)::TEXT, (' fall$')::TEXT, 'i') THEN 'fall'
            WHEN regexp_like((first_obs_date)::TEXT, (' fall-winter$')::TEXT, 'i') THEN 'fall-winter'
            WHEN regexp_like((first_obs_date)::TEXT, (' winter$')::TEXT, 'i') THEN 'winter'
            WHEN regexp_like((first_obs_date)::TEXT, (' winter-spring$')::TEXT, 'i') THEN 'winter-spring'
        END AS month_ab,
        CASE
            WHEN regexp_like((first_obs_date)::TEXT, (' spring$')::TEXT, 'i') THEN 13
            WHEN regexp_like((first_obs_date)::TEXT, (' spring-summer$')::TEXT, 'i') THEN 14
            WHEN regexp_like((first_obs_date)::TEXT, (' summer$')::TEXT, 'i') THEN 15
            WHEN regexp_like((first_obs_date)::TEXT, (' summer-fall$')::TEXT, 'i') THEN 16
            WHEN regexp_like((first_obs_date)::TEXT, (' fall$')::TEXT, 'i') THEN 17
            WHEN regexp_like((first_obs_date)::TEXT, (' fall-winter$')::TEXT, 'i') THEN 18
            WHEN regexp_like((first_obs_date)::TEXT, (' winter$')::TEXT, 'i') THEN 19
            WHEN regexp_like((first_obs_date)::TEXT, (' winter-spring$')::TEXT, 'i') THEN 20
        END AS sort_order
        FROM core.eo
        JOIN core.shape
            ON core.eo.shape_id = core.shape.shape_id
        WHERE ext.elgroup_name(element_subnational_id) NOT IN ('Other Elements', 'Plants and Lichens', 'Natural Communities') AND ext.chk_txt_date(first_obs_date) NOT LIKE 'Invalid%' AND NOT regexp_like((first_obs_date)::TEXT, ('pre|circa')::TEXT, 'i') AND regexp_like((first_obs_date)::TEXT, ('(spring|summer|fall|winter)')::TEXT, 'i') AND core.eo.d_data_qc_status_id = 2 AND core.shape.map_qc_status = 'P' AND core.eo.d_id_confirmed_id = 2 AND core.eo.d_basic_eo_rank_id <= 14
    UNION
    SELECT DISTINCT
        last_obs_date, element_subnational_id, ext.sci_name(element_subnational_id) AS sci_name,
        CASE
            WHEN regexp_like((last_obs_date)::TEXT, (' spring$')::TEXT, 'i') THEN 'spring'
            WHEN regexp_like((last_obs_date)::TEXT, (' spring-summer$')::TEXT, 'i') THEN 'spring-summer'
            WHEN regexp_like((last_obs_date)::TEXT, (' summer$')::TEXT, 'i') THEN 'summer'
            WHEN regexp_like((last_obs_date)::TEXT, (' summer-fall$')::TEXT, 'i') THEN 'summer-fall'
            WHEN regexp_like((last_obs_date)::TEXT, (' fall$')::TEXT, 'i') THEN 'fall'
            WHEN regexp_like((last_obs_date)::TEXT, (' fall-winter$')::TEXT, 'i') THEN 'fall-winter'
            WHEN regexp_like((last_obs_date)::TEXT, (' winter$')::TEXT, 'i') THEN 'winter'
            WHEN regexp_like((last_obs_date)::TEXT, (' winter-spring$')::TEXT, 'i') THEN 'winter-spring'
        END AS month_ab,
        CASE
            WHEN regexp_like((last_obs_date)::TEXT, (' spring$')::TEXT, 'i') THEN 13
            WHEN regexp_like((last_obs_date)::TEXT, (' spring-summer$')::TEXT, 'i') THEN 14
            WHEN regexp_like((last_obs_date)::TEXT, (' summer$')::TEXT, 'i') THEN 15
            WHEN regexp_like((last_obs_date)::TEXT, (' summer-fall$')::TEXT, 'i') THEN 16
            WHEN regexp_like((last_obs_date)::TEXT, (' fall$')::TEXT, 'i') THEN 17
            WHEN regexp_like((last_obs_date)::TEXT, (' fall-winter$')::TEXT, 'i') THEN 18
            WHEN regexp_like((last_obs_date)::TEXT, (' winter$')::TEXT, 'i') THEN 19
            WHEN regexp_like((last_obs_date)::TEXT, (' winter-spring$')::TEXT, 'i') THEN 20
        END AS sort_order
        FROM core.eo
        JOIN core.shape
            ON core.eo.shape_id = core.shape.shape_id
        WHERE ext.elgroup_name(element_subnational_id) NOT IN ('Other Elements', 'Plants and Lichens', 'Natural Communities') AND ext.chk_txt_date(last_obs_date) NOT LIKE 'Invalid%' AND NOT regexp_like((last_obs_date)::TEXT, ('pre|circa')::TEXT, 'i') AND regexp_like((last_obs_date)::TEXT, ('(spring|summer|fall|winter)')::TEXT, 'i') AND core.eo.d_data_qc_status_id = 2 AND core.shape.map_qc_status = 'P' AND core.eo.d_id_confirmed_id = 2 AND core.eo.d_basic_eo_rank_id <= 14) AS var_sbq
/* WHERE sci_name= 'Asioplax dolani'  -- -- -- -- -- -- -- -- -- --  -- -- -- -- -- -- -- -- -- --  -- -- -- -- -- -- -- -- -- -- Subset for testing */
)
SELECT
    element_subnational_id, sci_name, INITCAP(month_ab) AS month_ab,
    CASE
        WHEN month_ab = 'January A' THEN 1
        WHEN month_ab = 'January B' THEN 2
        WHEN month_ab = 'February A' THEN 3
        WHEN month_ab = 'February B' THEN 4
        WHEN month_ab = 'March A' THEN 5
        WHEN month_ab = 'March B' THEN 6
        WHEN month_ab = 'April A' THEN 7
        WHEN month_ab = 'April B' THEN 8
        WHEN month_ab = 'May A' THEN 9
        WHEN month_ab = 'May B' THEN 10
        WHEN month_ab = 'June A' THEN 11
        WHEN month_ab = 'June B' THEN 12
        WHEN month_ab = 'July A' THEN 13
        WHEN month_ab = 'July B' THEN 14
        WHEN month_ab = 'August A' THEN 15
        WHEN month_ab = 'August B' THEN 16
        WHEN month_ab = 'September A' THEN 17
        WHEN month_ab = 'September B' THEN 18
        WHEN month_ab = 'October A' THEN 19
        WHEN month_ab = 'October B' THEN 20
        WHEN month_ab = 'November A' THEN 21
        WHEN month_ab = 'November B' THEN 22
        WHEN month_ab = 'December A' THEN 23
        WHEN month_ab = 'December B' THEN 24
        ELSE NULL
    END AS phen_season
    FROM (SELECT DISTINCT
        element_subnational_id, sci_name, month_ab, sort_order
        FROM month_results
    UNION
    SELECT
        element_subnational_id, sci_name, month_ab, sort_order
        FROM season_results) AS var_sbq_2
    ORDER BY sci_name, sort_order, month_ab;


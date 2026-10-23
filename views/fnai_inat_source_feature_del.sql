CREATE OR REPLACE  VIEW ext.fnai_inat_source_feature_del (element_subnational_id, source_feature_id, inat_url, inat_obs_id, sf_rec_create_date, schema_name, reference_code) AS
SELECT
    element_subnational_id, source_feature_id, inat_url, inat_obs_id, sf_rec_create_date, schema_name, reference_code
    FROM (WITH RECURSIVE t (element_subnational_id, source_feature_id, inat_url, inat_obs_id, reference_code, value)
    AS (SELECT
        var_sbq.element_subnational_id, var_sbq.source_feature_id, regexp_replace((CONCAT_WS('', 'https://', regexp_substr((mapping_com)::TEXT, (E'www\\.inaturalist\\.org/observations/[0-9]+')::TEXT, (1)::INTEGER, ((1)::NUMERIC)::INTEGER))::TEXT)::TEXT, ('[[:punct:][:space:]]+$')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER) AS inat_url, regexp_substr((mapping_com)::TEXT, ('observations/([0-9]+)')::TEXT, (1)::INTEGER, ((1)::NUMERIC)::INTEGER, NULL::TEXT, (1)::INTEGER) AS inat_obs_id, var_sbq.reference_code, var_sbq.value, (1)::NUMERIC AS level
        FROM (SELECT DISTINCT
            STRING_AGG(reference_code, '; '::TEXT) OVER (PARTITION BY sf.source_feature_id ORDER BY reference_code ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS reference_code, sf.source_feature_id, sf.rec_create_date AS sf_rec_create_date, sf.mapping_com, 'BIOTICS_DEL' AS schema_name, sf.element_subnational_id
            FROM del.source_feature_del AS sf
            LEFT OUTER JOIN del.source_feature_ref_del AS sfr
                ON sf.source_feature_id = sfr.source_feature_id
            JOIN core.reference AS ref
                ON sfr.reference_id = ref.reference_id
            WHERE sf.source_feature_id IN (SELECT
                source_feature_id
                FROM del.source_feature_del
                WHERE mapping_com LIKE '%www.inaturalist.org/observation%' AND regexp_count((mapping_com)::TEXT, (E'www\\.inaturalist\\.org/observation')::TEXT, (1)::INTEGER, 'i') > 1
            /* AND REGEXP_COUNT(mapping_com, 'www.inaturalist.org/observation') > 1 */
            )) AS var_sbq
    UNION ALL
    SELECT
        t_2.element_subnational_id, t_2.source_feature_id, regexp_replace((CONCAT_WS('', 'https://', regexp_substr((mapping_com)::TEXT, (E'www\\.inaturalist\\.org/observations/[0-9]+')::TEXT, (1)::INTEGER, ((t.level + 1)::NUMERIC)::INTEGER))::TEXT)::TEXT, ('[[:punct:][:space:]]+$')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER) AS inat_url, regexp_substr((mapping_com)::TEXT, ('observations/([0-9]+)')::TEXT, (1)::INTEGER, ((t.level + 1)::NUMERIC)::INTEGER, NULL::TEXT, (1)::INTEGER) AS inat_obs_id, t_2.reference_code, t_2.value, (t.level + 1)::NUMERIC AS level
        FROM (SELECT DISTINCT
            STRING_AGG(reference_code, '; '::TEXT) OVER (PARTITION BY sf.source_feature_id ORDER BY reference_code ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS reference_code, sf.source_feature_id, sf.rec_create_date AS sf_rec_create_date, sf.mapping_com, 'BIOTICS_DEL' AS schema_name, sf.element_subnational_id
            FROM del.source_feature_del AS sf
            LEFT OUTER JOIN del.source_feature_ref_del AS sfr
                ON sf.source_feature_id = sfr.source_feature_id
            JOIN core.reference AS ref
                ON sfr.reference_id = ref.reference_id
            WHERE sf.source_feature_id IN (SELECT
                source_feature_id
                FROM del.source_feature_del
                WHERE mapping_com LIKE '%www.inaturalist.org/observation%' AND regexp_count((mapping_com)::TEXT, (E'www\\.inaturalist\\.org/observation')::TEXT, (1)::INTEGER, 'i') > 1
            /* AND REGEXP_COUNT(mapping_com, 'www.inaturalist.org/observation') > 1 */
            )) AS t_2, t
        WHERE regexp_substr((mapping_com)::TEXT, (E'www\\.inaturalist\\.org/observations/[0-9]+')::TEXT, (1)::INTEGER, ((level + 1)::NUMERIC)::INTEGER) IS NOT NULL AND t.source_feature_id = t_2.source_feature_id AND aws_oracle_ext.dbms_random$value() IS NOT NULL)
    SELECT
        element_subnational_id, source_feature_id, inat_url, inat_obs_id, sf_rec_create_date AS "SF_REC_CREATE_DATE", schema_name AS "SCHEMA_NAME", reference_code
        FROM t
    UNION ALL
    SELECT DISTINCT
        element_subnational_id, source_feature_id, inat_url, inat_obs_id, sf_rec_create_date, schema_name, STRING_AGG(reference_code, '; '::TEXT) OVER (PARTITION BY source_feature_id ORDER BY reference_code ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS reference_code
        FROM (SELECT DISTINCT
            ref.reference_code, sf.source_feature_id, regexp_replace((CONCAT_WS('', 'https://', regexp_substr((sf.mapping_com)::TEXT, (E'www\\.inaturalist\\.org/observations/[0-9]+')::TEXT))::TEXT)::TEXT, ('[[:punct:][:space:]]+$')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER) AS inat_url, regexp_substr((sf.mapping_com)::TEXT, ('observations/([0-9]+)')::TEXT, (1)
            /* start position */
            ::INTEGER, (1)
            /* occurrence */
            ::INTEGER, NULL::
            /* match parameters */
            TEXT, (1)
            /* return the first capturing group */
            ::INTEGER) AS inat_obs_id, sf.rec_create_date AS sf_rec_create_date, 'BIOTICS_DEL' AS schema_name, sf.element_subnational_id
            FROM del.source_feature_del AS sf
            LEFT OUTER JOIN del.source_feature_ref_del AS sfr
                ON sf.source_feature_id = sfr.source_feature_id
            JOIN core.reference AS ref
                ON sfr.reference_id = ref.reference_id
            WHERE sf.mapping_com LIKE '%www.inaturalist.org/observation%' AND regexp_count((sf.mapping_com)::TEXT, (E'www\\.inaturalist\\.org/observation')::TEXT, (1)::INTEGER, 'i') = 1)
        /* AND REGEXP_COUNT(sf.mapping_com, 'www.inaturalist.org/observation') = 1 */
        AS var_sbq_2
    UNION ALL
    SELECT DISTINCT
        element_subnational_id, source_feature_id, inat_url, inat_obs_id, sf_rec_create_date, schema_name, STRING_AGG(reference_code, '; '::TEXT) OVER (PARTITION BY source_feature_id ORDER BY reference_code ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS reference_code
        FROM (SELECT DISTINCT
            ref.reference_code, v.source_feature_id, regexp_replace((CONCAT_WS('', 'https://', regexp_substr((v.visit_notes)::TEXT, (E'www\\.inaturalist\\.org/observations/[0-9]+')::TEXT))::TEXT)::TEXT, ('[[:punct:][:space:]]+$')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER) AS inat_url, regexp_substr((v.visit_notes)::TEXT, ('observations/([0-9]+)')::TEXT, (1)
            /* start position */
            ::INTEGER, (1)
            /* occurrence */
            ::INTEGER, NULL::
            /* match parameters */
            TEXT, (1)
            /* return the first capturing group */
            ::INTEGER) AS inat_obs_id, sf.rec_create_date AS sf_rec_create_date, 'BIOTICS_DEL' AS schema_name, sf.element_subnational_id
            FROM del.visit_del AS v
            JOIN del.source_feature_del AS sf
                ON v.source_feature_id = sf.source_feature_id
            LEFT OUTER JOIN del.source_feature_ref_del AS sfr
                ON sfr.source_feature_id = sf.source_feature_id
            JOIN core.reference AS ref
                ON ref.reference_id = sfr.reference_id
            WHERE v.visit_notes LIKE '%www.inaturalist.org/observation%') AS var_sbq_3) AS var_sbq_4;


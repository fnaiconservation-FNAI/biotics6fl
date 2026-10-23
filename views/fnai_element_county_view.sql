CREATE OR REPLACE  VIEW ext.fnai_element_county_view (txt_id, est_id, sname, commname, sort_order, element_group, county_fips_cd, county_name, status) AS
SELECT
    CONCAT_WS('', ext.sci_name(est1.element_subnational_id), '_', county_fips_cd) AS txt_id, est1.element_subnational_id AS est_id, ext.sci_name(est1.element_subnational_id) AS sname, ext.comm_name(est1.element_subnational_id) AS commname, ext.elgroup_sort_order(est1.element_subnational_id) AS sort_order, ext.elgroup_name(est1.element_subnational_id) AS element_group, oracle.to_number(county_fips_cd) AS county_fips_cd, county_name, MAX(status) AS status
    FROM core.element_subnational AS est1
    LEFT OUTER JOIN (SELECT
        est.element_subnational_id, county_fips_cd, county_name, MAX(CASE
            WHEN pcas.d_origin_status_id IN (3, 4) THEN 0
            WHEN (pcas.d_occurrence_status_id = 1 OR pcas.d_occurrence_status_id IS NULL) THEN 1
            WHEN pcas.d_occurrence_status_id = 4 THEN - 1
            ELSE 0
        END) AS status
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.plant_cas_county AS pcas
            ON pcas.element_subnational_id = est.element_subnational_id
        LEFT OUTER JOIN domain.d_occurrence_status AS dos
            ON dos.d_occurrence_status_id = pcas.d_occurrence_status_id
        LEFT OUTER JOIN domain.d_county
            ON pcas.d_county_id = domain.d_county.d_county_id
        WHERE county_name IS NOT NULL
        GROUP BY est.element_subnational_id, county_fips_cd, county_name
    UNION
    SELECT
        est.element_subnational_id, county_fips_cd, county_name, MAX(CASE
            WHEN acas.d_origin_status_id IN (3, 4) THEN 0
            WHEN (acas.d_occurrence_status_id = 1 OR acas.d_occurrence_status_id IS NULL) THEN 1
            WHEN acas.d_occurrence_status_id = 4 THEN - 1
            ELSE 0
        END) AS status
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.animal_cas_county AS acas
            ON acas.element_subnational_id = est.element_subnational_id
        LEFT OUTER JOIN domain.d_occurrence_status AS dos
            ON dos.d_occurrence_status_id = acas.d_occurrence_status_id
        LEFT OUTER JOIN domain.d_county
            ON acas.d_county_id = domain.d_county.d_county_id
        WHERE county_name IS NOT NULL
        GROUP BY est.element_subnational_id, county_fips_cd, county_name
    UNION
    SELECT
        est.element_subnational_id, county_fips_cd, county_name, MAX(CASE
            WHEN (ccas.d_occurrence_status_id = 1 OR ccas.d_occurrence_status_id IS NULL) THEN 1
            WHEN ccas.d_occurrence_status_id = 4 THEN - 1
            ELSE 0
        END) AS status
        FROM core.element_subnational AS est
        LEFT OUTER JOIN core.comm_cas_county AS ccas
            ON ccas.element_subnational_id = est.element_subnational_id
        LEFT OUTER JOIN domain.d_occurrence_status AS dos
            ON dos.d_occurrence_status_id = ccas.d_occurrence_status_id
        LEFT OUTER JOIN domain.d_county
            ON ccas.d_county_id = domain.d_county.d_county_id
        WHERE county_name IS NOT NULL
        GROUP BY est.element_subnational_id, county_fips_cd, county_name
    UNION
    SELECT
        est.element_subnational_id, county_fips_cd, county_name, MAX(CASE
            WHEN d_basic_eo_rank_id IN (17, 20) THEN - 1
            ELSE 1
        END) AS status
        FROM core.eo
        LEFT OUTER JOIN core.eo_county AS eoc2
            ON core.eo.eo_id = eoc2.eo_id
        LEFT OUTER JOIN core.element_subnational AS est
            ON est.element_subnational_id = core.eo.element_subnational_id
        LEFT OUTER JOIN domain.d_county
            ON eoc2.d_county_id = domain.d_county.d_county_id
        LEFT OUTER JOIN core.shape AS s
            ON s.shape_id = core.eo.shape_id
        WHERE county_fips_cd IS NOT NULL AND
        /* QC Passing */
        core.eo.d_data_qc_status_id = 2 AND s.map_qc_status = 'P' AND
        /* ID is confirmed or null */
        (core.eo.d_id_confirmed_id = 2 OR core.eo.d_id_confirmed_id IS NULL) AND
        /* Removing Element_County where the County CAS orgin status is Introduced or Unknown. 2025-04-15 EST_County Count = 7 --> EOR Count = 59 */
        CONCAT_WS('', est.element_subnational_id, '_', county_fips_cd) NOT IN (SELECT
            CONCAT_WS('', element_subnational_id, '_', county_fips_cd) AS est_c
            FROM core.plant_cas_county
            LEFT OUTER JOIN domain.d_county
                ON domain.d_county.d_county_id = core.plant_cas_county.d_county_id
            WHERE d_origin_status_id IN (3, 4)
        UNION
        SELECT
            CONCAT_WS('', element_subnational_id, '_', county_fips_cd)
            FROM core.animal_cas_county
            LEFT OUTER JOIN domain.d_county
                ON domain.d_county.d_county_id = core.animal_cas_county.d_county_id
            WHERE d_origin_status_id IN (3, 4))
        GROUP BY est.element_subnational_id, county_fips_cd, county_name) AS counties
        ON est1.element_subnational_id = counties.element_subnational_id
    WHERE county_fips_cd IS NOT NULL
    /* AND sci_name(est1.element_subnational_id) = 'Ursus americanus floridanus' */
    GROUP BY est1.element_subnational_id, counties.county_fips_cd, county_name
    ORDER BY sort_order, sname;


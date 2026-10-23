CREATE OR REPLACE  VIEW ext.fnai_element_county_names_view (est_id, sname, commname, sort_order, element_group, counties) AS
SELECT
    est.element_subnational_id AS est_id, ext.sci_name(est.element_subnational_id) AS sname, ext.comm_name(est.element_subnational_id) AS commname, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, (SELECT
        STRING_AGG(county_name, ', '::TEXT ORDER BY county_name)
        FROM (SELECT
            county_name, est1.element_subnational_id AS est_id
            FROM core.element_subnational AS est1
            LEFT OUTER JOIN core.plant_cas_county AS pcas
                ON pcas.element_subnational_id = est1.element_subnational_id
            LEFT OUTER JOIN domain.d_occurrence_status AS dos
                ON dos.d_occurrence_status_id = pcas.d_occurrence_status_id
            LEFT OUTER JOIN domain.d_county
                ON pcas.d_county_id = domain.d_county.d_county_id
            WHERE county_name IS NOT NULL AND est1.element_subnational_id = est.element_subnational_id
        UNION
        SELECT
            county_name, est2.element_subnational_id AS est_id
            FROM core.element_subnational AS est2
            LEFT OUTER JOIN core.animal_cas_county AS acas
                ON acas.element_subnational_id = est2.element_subnational_id
            LEFT OUTER JOIN domain.d_occurrence_status AS dos
                ON dos.d_occurrence_status_id = acas.d_occurrence_status_id
            LEFT OUTER JOIN domain.d_county
                ON acas.d_county_id = domain.d_county.d_county_id
            WHERE county_name IS NOT NULL AND est2.element_subnational_id = est.element_subnational_id
        UNION
        SELECT
            county_name, est3.element_subnational_id AS est_id
            FROM core.eo
            LEFT OUTER JOIN core.eo_county AS eoc2
                ON core.eo.eo_id = eoc2.eo_id
            LEFT OUTER JOIN core.element_subnational AS est3
                ON est3.element_subnational_id = core.eo.element_subnational_id
            LEFT OUTER JOIN domain.d_county
                ON eoc2.d_county_id = domain.d_county.d_county_id
            WHERE est.d_eo_track_status_id = 1 AND county_fips_cd IS NOT NULL AND est3.element_subnational_id = est.element_subnational_id) AS var_sbq
        GROUP BY est_id) AS counties
    FROM core.element_subnational AS est
    /* WHERE est.d_eo_track_status_id = 1 */
    ORDER BY sort_order, sname;


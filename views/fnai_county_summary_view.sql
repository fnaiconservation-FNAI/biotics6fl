CREATE OR REPLACE  VIEW ext.fnai_county_summary_view (d_county_id, county, element_id, sort_order, element_group, sci_name, comm_name, grank, srank, federal, state, occurrence_status, count) AS
SELECT
    dc.d_county_id, dc.county_name AS county, est.element_subnational_id AS element_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.substr(sn.scientific_name, 1, 70) AS sci_name, oracle.substr(est.s_primary_common_name, 1, 70) AS comm_name, oracle.substr(egt.g_rank, 1, 12) AS grank, oracle.substr(est.s_rank, 1, 12) AS srank,
    CASE
        WHEN shared.est_usesa(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(shared.est_usesa(est.element_subnational_id), 1, 12)
    END AS federal,
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, 12)
    END AS state,
    /*
    The next section uses a delimlist to determine if there are data EORs.
    The result of the data query is then concatenated to the results of
    a query on the characterization abstracts.
    */
    CONCAT_WS('',
    CASE
        WHEN oracle.to_number(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id)
       FROM eo eo, eo_county eoc2', ' WHERE eo.element_subnational_id
        =', est.element_subnational_id, 'and eo.eo_id = eoc2.eo_id
        and eoc2.d_county_id =', dc.d_county_id), NULL::TEXT)) > 0 THEN
        CASE
            WHEN LENGTH(shared.delimlist(CONCAT_WS('', 'SELECT eo.last_obs_date FROM
          eo eo, eo_county eoc2', ' WHERE eo.last_obs_date > ''1987''
          and eo.element_subnational_id
          =', est.element_subnational_id, 'and eo.eo_id = eoc2.eo_id
          and eoc2.d_county_id =', dc.d_county_id), NULL::TEXT)) > 0 THEN 'C'
            ELSE 'H'
        END
        ELSE 'N'
    END,
    /*
    now check the characterization
    abstracts for plants and animals (communities don't have them)
    */
    CASE
        WHEN oracle.substr(egt.elcode_bcd, 1, 1) IN ('A', 'I') THEN oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT dos.occurrence_status_cd
       FROM d_occurrence_status dos, animal_cas_county cas', ' WHERE dos.d_occurrence_status_id = cas.d_occurrence_status_id AND
       cas.element_subnational_id =', est.element_subnational_id, 'AND cas.d_county_id =', dc.d_county_id), NULL::TEXT), 1, 17)
    /*
    when substr(egt.elcode_bcd,1,1) in ('N','P') then
    substr(delimlist('SELECT dos.occurrence_status_cd
    FROM d_occurrence_status dos, plant_cas_county cas' ||
    ' WHERE dos.d_occurrence_status_id = cas.d_occurrence_status_id AND
    cas.element_subnational_id =' || est.element_subnational_id ||
     'AND cas.d_county_id =' || dc.d_county_id, ''),1,17)
    */
        ELSE 'N'
    END) AS occurrence_status,
    /*
    ***************
    Section below creates a count column
    For the EOR count we use delimlist again
    */
    oracle.to_number(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id)
       FROM eo eo, eo_county eoc2', ' WHERE eo.element_subnational_id
        =', est.element_subnational_id, 'and eo.eo_id = eoc2.eo_id
        and eoc2.d_county_id =', dc.d_county_id), NULL::TEXT)) AS count
    /* *************** */
    FROM core.element_subnational AS est, core.element_global AS egt, core.element_national AS ent, core.scientific_name AS sn, domain.d_county AS dc
    WHERE est.element_national_id = ent.element_national_id AND ent.element_global_id = egt.element_global_id AND est.sname_id = sn.scientific_name_id AND (est.element_subnational_id IN (SELECT DISTINCT
        (cas.element_subnational_id)
        FROM core.animal_cas_county AS cas
        WHERE cas.d_county_id = dc.d_county_id) OR
    /*
    or est.element_subnational_id in (select distinct(cas.element_subnational_id) from
    plant_cas_county cas where cas.d_county_id = dc.d_county_id)
    */
    est.element_subnational_id IN (SELECT DISTINCT
        (eo.element_subnational_id)
        FROM core.eo AS eo, core.eo_county AS eoc2
        WHERE eo.eo_id = eoc2.eo_id AND eoc2.d_county_id = dc.d_county_id)) AND est.d_eo_track_status_id = 1
/* (it's a tracked species, i.e.track all extant and selected historical EOs) */
/* and dc.d_county_id = 385 \* test line, for Leon County */
UNION
SELECT
    99999 AS county_id, 'ZZZZZ' AS county, est.element_subnational_id AS element_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.substr(sn.scientific_name, 1, 70) AS sci_name, oracle.substr(est.s_primary_common_name, 1, 70) AS comm_name, oracle.substr(egt.g_rank, 1, 12) AS grank, oracle.substr(est.s_rank, 1, 12) AS srank,
    CASE
        WHEN shared.est_usesa(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(shared.est_usesa(est.element_subnational_id), 1, 12)
    END AS federal,
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, 12)
    END AS state, 'NA' AS occurrence_status,
    /*
    ***************
    Section below creates a count column
    For the EOR count we use delimlist again
    */
    oracle.to_number(shared.delimlist(CONCAT_WS('', 'SELECT count(eo.eo_id)
       FROM eo eo', ' WHERE eo.element_subnational_id
        =', est.element_subnational_id), NULL::TEXT)) AS count
    /* *************** */
    FROM core.element_subnational AS est, core.element_global AS egt, core.element_national AS ent, core.scientific_name AS sn
    WHERE est.element_national_id = ent.element_national_id AND ent.element_global_id = egt.element_global_id AND est.sname_id = sn.scientific_name_id AND est.d_eo_track_status_id = 1
    /* (it's a tracked species, i.e.track all extant and selected historical EOs) */
    /* and dc.d_county_id = 385 \* test line, for Leon County */
    /* and rownum < 50 */
    ORDER BY county, sort_order, sci_name;


CREATE OR REPLACE  VIEW ext.fnai_field_guide_view_animals (est_id, sci_name, cname, frm_full_sp, frm_sci_name, frm_sci_name_b, ordr, family, grank, srank, srank_rvw_dt, federal, sprot, descrip, simspp, habitat, seasoccurrence, fldistr, rwdistr, constatus, protmgmt, refs, "@map", county_map, photo1, photo2, photo3, photo4, caption1, caption2, caption3, caption4, fg_v_date, counties_present, counties_extirpated, former_name) AS
SELECT
    est.element_subnational_id AS est_id, ext.sci_name(est.element_subnational_id) AS sci_name, est.s_primary_common_name AS cname, sn.formatted_scientific_name AS frm_full_sp, ext.form_sci_name(est.element_subnational_id) AS frm_sci_name, CONCAT_WS('', '<b>', ext.form_sci_name(est.element_subnational_id), '</b>') AS frm_sci_name_b, ext.ord(est.element_subnational_id) AS ordr, ext.family(est.element_subnational_id) AS family, ext.grank(est.element_subnational_id) AS grank, est.s_rank AS srank, est.s_rank_review_date AS srank_rvw_dt,
    CASE
        WHEN ext.federal(est.element_subnational_id) = 'T' THEN 'Threatened'
        WHEN ext.federal(est.element_subnational_id) = 'E' THEN 'Endangered'
        WHEN ext.federal(est.element_subnational_id) = 'C' THEN 'Candidate'
        ELSE 'none'
    END AS federal,
    CASE
        WHEN est.s_protection_status IN ('ST', 'FT', 'T') THEN 'Threatened'
        WHEN est.s_protection_status IN ('SE', 'FE', 'E') THEN 'Endangered'
        WHEN est.s_protection_status = 'SSC' THEN 'Special Concern'
        ELSE 'none'
    END AS sprot, ext.clean_up_all_except_italics(cas.s_id_com) AS descrip, ext.clean_up_all_except_italics(tax.sim_and_related_spp) AS simspp, ext.clean_up_all_except_italics(oracle.substr(lob_loc => cas.s_habitat_com, amount => 4000, "offset" => 1)) AS habitat,
    /* tax.FIELDGUIDE_BEST_SEASON seasoccurrence, */
    ext.clean_up_all_except_italics(cas.s_phenology_com) AS seasoccurrence,
    /* esr.s_range_com fldistr, */
    ext.clean_up_all_except_italics(est.s_distribution_com) AS fldistr, ext.clean_up_all_except_italics(tax.range_wide_distrib) AS rwdistr, ext.clean_up_all_except_italics(tax.cons_status) AS constatus,
    /* esr.S_PROTECTION_NEEDS protneeds, */
    ext.clean_up_all_except_italics(esr.s_management_needs) AS protmgmt, ext.clean_up_all_except_italics(tax.fld_guide_refs) AS refs, CONCAT_WS('', E'K:\\Science_Information\\Data_Mgmt\\Data_reports_CRv9\\EST\\Field_Guide_report\\Maps\\', replace(replace(ext.sci_name(est.element_subnational_id), ' ', '_'), '.', ''), '_map.jpg') AS "@map",
    /* substr(genus(est.element_subnational_id),1,4) || substr(species(est.element_subnational_id),1,4) || */
    /* '_map.jpg' AS "@map" */
    CONCAT_WS('', E'\\\\smb-isl01.fsu.edu\\FNAI\\Florida Natural Areas Inventory\\Current\\Science_Information\\Data_Mgmt\\Data_reports_CRv9\\EST\\Field_Guide_report\\Maps_png\\', replace(replace(LOWER(ext.sci_name(est.element_subnational_id)), ' ', '_'), '.', ''), '_map.png') AS county_map, replace(tax.photo1, '"', '') AS photo1, replace(tax.photo2, '"', '') AS photo2, replace(tax.photo3, '"', '') AS photo3, replace(tax.photo4, '"', '') AS photo4, ext.clean_up_all_except_italics(tax.caption1) AS caption1, ext.clean_up_all_except_italics(tax.caption2) AS caption2, ext.clean_up_all_except_italics(tax.caption3) AS caption3, ext.clean_up_all_except_italics(tax.caption4) AS caption4,
    /* tax.field_guide_version_date fg_v_date, */
    CASE
        WHEN tax.field_guide_version_date IS NULL THEN '2000'
        ELSE oracle.substr(tax.field_guide_version_date, 1, 7)
    END AS fg_v_date, STRING_AGG.counties_present(), STRING_AGG.counties_extirpated(),
    CASE
        WHEN former_name IS NULL THEN NULL
        ELSE CONCAT_WS('', '<i>', TRIM(former_name), '</i>')
    END AS former_name
    FROM core.element_subnational AS est
    LEFT OUTER JOIN core.element_national AS ent
        ON est.element_national_id = ent.element_national_id
    LEFT OUTER JOIN core.element_global AS egt
        ON ent.element_global_id = egt.element_global_id
    LEFT OUTER JOIN core.animal_cas AS cas
        ON est.element_subnational_id = cas.element_subnational_id
    LEFT OUTER JOIN core.element_subnatl_rank AS esr
        ON est.element_subnational_id = esr.element_subnational_id
    LEFT OUTER JOIN core.element_global_rank AS egr
        ON egt.element_global_id = egr.element_global_id
    LEFT OUTER JOIN ext.taxon_sub_flext1 AS tax
        ON est.element_subnational_id = tax.element_subnational_id
    LEFT OUTER JOIN core.scientific_name AS sn
        ON est.sname_id = sn.scientific_name_id
    LEFT OUTER JOIN (SELECT
        COALESCE(pres.est_id, ext.est_id) AS est_id, STRING_AGG(), STRING_AGG()
        FROM (SELECT
            est_id, STRING_AGG(county_name, ', '::TEXT ORDER BY est_id) AS counties_present
            FROM ext.fnai_element_county_view
            WHERE status = 1
            GROUP BY est_id, status, status) AS pres
        FULL OUTER JOIN (SELECT
            est_id, STRING_AGG(county_name, ', '::TEXT ORDER BY est_id) AS counties_extirpated
            FROM ext.fnai_element_county_view
            WHERE status = 0
            GROUP BY est_id, status, status) AS ext
            ON pres.est_id = ext.est_id) AS cnty_dist
        ON est.element_subnational_id = cnty_dist.est_id
    WHERE tax.fld_guide_species = 'Y' AND NOT (ext.elgroup_name(est.element_subnational_id) LIKE '%Plant%')
    ORDER BY ext.sci_name(est.element_subnational_id);


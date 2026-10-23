CREATE OR REPLACE  VIEW ext.dx_bcd_sa_vw (sourcecode, citation, shelfnote, geogcover, s, n, e, w, abstract, community, terrcommun, forest, savanna, grassland, shrubland, desert, alpine, othterrest, aqcommun, palustrine, lacustrine, riverine, estuarine, marine, subterran, flora, aqflora, terflora, nonvascpl, vascpl, microorg, fauna, aqfauna, terfauna, molluscs, insects, crustacean, otharthro, othinvert, fishes, amphibians, reptiles, birds, mammals, physsci, physiotopo, hydro, geology, soils, climate, biology, ecology, ecofunct, natdiver, inventory, rsrchtech, ma, mgmtplans, mgmttech, impactstud, protorg, prottools, herpubl, keywords, comments, urating, digestnote, update_date, update_initials, siteinfo, edauthor, edition, reference_ou_uid, reference_seq_uid, reference_id) AS
SELECT
    reference_code AS sourcecode, full_citation AS citation, shelf_note AS shelfnote, geog_area_covered AS geogcover, latitude_s AS s, latitude_n AS n, longitude_e AS e, longitude_w AS w, abstract AS abstract, community_usefulness AS community, terr_comm_usefulness AS terrcommun, forest_usefulness AS forest, savanna_usefulness AS savanna, grassland_usefulness AS grassland, shrubland_usefulness AS shrubland, desert_usefulness AS desert, alpine_usefulness AS alpine, other_terr_usefulness AS othterrest, aquatic_comm_usefulness AS aqcommun, palustrine_usefulness AS palustrine, lacustrine_usefulness AS lacustrine, riverine_usefulness AS riverine, estuarine_usefulness AS estuarine, marine_usefulness AS marine, subterranean_usefulness AS subterran, flora_usefulness AS flora, aquatic_flora_usefulness AS aqflora, terr_flora_usefulness AS terflora, nonvasc_plant_usefulness AS nonvascpl, vasc_plant_usefulness AS vascpl, microorganism_usefulness AS microorg, fauna_usefulness AS fauna, aquatic_fauna_usefulness AS aqfauna, terr_fauna_usefulness AS terfauna, molluscs_usefulness AS molluscs, insects_usefulness AS insects, crustacean_usefulness AS crustacean, other_arthropods_usefulness AS otharthro, other_invert_usefulness AS othinvert, fishes_usefulness AS fishes, amphibians_usefulness AS amphibians, reptiles_usefulness AS reptiles, birds_usefulness AS birds, mammals_usefulness AS mammals, phys_science_usefulness AS physsci, physio_topo_usefulness AS physiotopo, hydrology_usefulness AS hydro, geology_usefulness AS geology, soils_usefulness AS soils, climate_usefulness AS climate, biology_usefulness AS biology, ecology_usefulness AS ecology, ecosys_function_usefulness AS ecofunct, nat_diversity_usefulness AS natdiver, inventory_usefulness AS inventory, research_tech_usefulness AS rsrchtech, managed_areas_usefulness AS ma, mgmt_plans_usefulness AS mgmtplans, mgmt_tech_usefulness AS mgmttech, impact_studies_usefulness AS impactstud, protection_org_usefulness AS protorg, protection_tools_usefulness AS prottools, heritage_publication_ind AS herpubl,
    /* KEYWORDS (a bit tricky here) */
    shared.delimlist(CONCAT_WS('', 'SELECT d.reference_keyword
                           ,rk.reference_id
                           ,rk.display_order
                    FROM reference_keyword rk
                         ,d_reference_keyword d
                    WHERE rk.d_reference_keyword_id = d.d_reference_keyword_id
                    AND rk.reference_id = ', reference_id, '
                    ORDER BY rk.reference_id, rk.display_order'), '|'::TEXT) AS keywords, comments AS comments, usefulness_rating AS urating, digest_note AS digestnote,
    CASE
        WHEN rec_last_mod_date IS NULL THEN oracle.to_char(rec_create_date, 'YY-MM-DD')
        ELSE oracle.to_char(rec_last_mod_date, 'YY-MM-DD')
    END AS update_date,
    CASE
        WHEN rec_last_mod_date IS NULL THEN rec_create_user
        ELSE rec_last_mod_user
    END AS update_initials, site_info_usefulness AS siteinfo, version_author_name AS edauthor, oracle.to_char(version_date, 'YY-MM-DD') AS edition, reference_ou_uid, reference_seq_uid, reference_id
    FROM core.reference;


CREATE OR REPLACE  VIEW ext.fnai_txt_to_trimm (tablename, column_name, pk_value, pk_field, value) AS
SELECT
    'ANIMAL_CAS' AS tablename, 'ADDITIONAL_TOPICS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, additional_topics AS value
    FROM core.animal_cas
    WHERE ext.trimm(additional_topics) <> additional_topics
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'INTERNAL_NOTES' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, internal_notes AS value
    FROM core.animal_cas
    WHERE ext.trimm(internal_notes) <> internal_notes
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'REC_CREATE_USER' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rec_create_user AS value
    FROM core.animal_cas
    WHERE ext.trimm(rec_create_user) <> rec_create_user
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'REC_LAST_MOD_USER' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rec_last_mod_user AS value
    FROM core.animal_cas
    WHERE ext.trimm(rec_last_mod_user) <> rec_last_mod_user
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_COMMERCIAL_SPECIES_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_commercial_species_ind AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_commercial_species_ind) <> s_commercial_species_ind
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_DISTANT_MIGRANT_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_distant_migrant_ind AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_distant_migrant_ind) <> s_distant_migrant_ind
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_ECOLOGY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_ecology_com, amount => 4000, "offset" => 1) AS value
    FROM core.animal_cas
    WHERE ext.trimm(oracle.substr(lob_loc => s_ecology_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_ecology_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_ECONOMIC_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_economic_com AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_economic_com) <> s_economic_com
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_FOOD_HABITS_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_food_habits_com AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_food_habits_com) <> s_food_habits_com
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_FUR_BEARER_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_fur_bearer_ind AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_fur_bearer_ind) <> s_fur_bearer_ind
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_GAME_SPECIES_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_game_species_ind AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_game_species_ind) <> s_game_species_ind
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_HABITAT_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_habitat_com, amount => 4000, "offset" => 1) AS value
    FROM core.animal_cas
    WHERE ext.trimm(oracle.substr(lob_loc => s_habitat_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_habitat_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_ID_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_id_com AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_id_com) <> s_id_com
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_LOCAL_MIGRANT_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_local_migrant_ind AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_local_migrant_ind) <> s_local_migrant_ind
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_MIGRATION_MOBILITY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_migration_mobility_com AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_migration_mobility_com) <> s_migration_mobility_com
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_NON_MIGRANT_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_non_migrant_ind AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_non_migrant_ind) <> s_non_migrant_ind
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_NONGAME_PROT_SPECIES_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_nongame_prot_species_ind AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_nongame_prot_species_ind) <> s_nongame_prot_species_ind
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_PHENOLOGY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_phenology_com AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_phenology_com) <> s_phenology_com
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_REPRODUCTION_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_reproduction_com, amount => 4000, "offset" => 1) AS value
    FROM core.animal_cas
    WHERE ext.trimm(oracle.substr(lob_loc => s_reproduction_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_reproduction_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_SPORT_FISH_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_sport_fish_ind AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_sport_fish_ind) <> s_sport_fish_ind
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_SUBSPECIES_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_subspecies_com AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_subspecies_com) <> s_subspecies_com
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_WITHIN_BORDERS_MIGRANT_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_within_borders_migrant_ind AS value
    FROM core.animal_cas
    WHERE ext.trimm(s_within_borders_migrant_ind) <> s_within_borders_migrant_ind
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'SBREED_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, sbreed_bcd AS value
    FROM core.animal_cas
    WHERE ext.trimm(sbreed_bcd) <> sbreed_bcd
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'SIRREGAPP_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, sirregapp_bcd AS value
    FROM core.animal_cas
    WHERE ext.trimm(sirregapp_bcd) <> sirregapp_bcd
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'SMIGTRANS_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, smigtrans_bcd AS value
    FROM core.animal_cas
    WHERE ext.trimm(smigtrans_bcd) <> smigtrans_bcd
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'SWINTER_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, swinter_bcd AS value
    FROM core.animal_cas
    WHERE ext.trimm(swinter_bcd) <> swinter_bcd
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'VERSION_AUTHOR_NAME' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, version_author_name AS value
    FROM core.animal_cas
    WHERE ext.trimm(version_author_name) <> version_author_name
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'ACCEPTED_BY_ECOLOGY_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, accepted_by_ecology_ind AS value
    FROM core.element_subnational
    WHERE ext.trimm(accepted_by_ecology_ind) <> accepted_by_ecology_ind
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'BCD_STYLE_S_RANK' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, bcd_style_s_rank AS value
    FROM core.element_subnational
    WHERE ext.trimm(bcd_style_s_rank) <> bcd_style_s_rank
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'DATA_SENSITIVE_REASONS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, data_sensitive_reasons AS value
    FROM core.element_subnational
    WHERE ext.trimm(data_sensitive_reasons) <> data_sensitive_reasons
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'DELETED_REASON_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, deleted_reason_com AS value
    FROM core.element_subnational
    WHERE ext.trimm(deleted_reason_com) <> deleted_reason_com
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'DX_LAST_RECEIVED_STATUS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, dx_last_received_status AS value
    FROM core.element_subnational
    WHERE ext.trimm(dx_last_received_status) <> dx_last_received_status
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'IN_PROGRESS_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, in_progress_ind AS value
    FROM core.element_subnational
    WHERE ext.trimm(in_progress_ind) <> in_progress_ind
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'OLD_ELCODE_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, old_elcode_bcd AS value
    FROM core.element_subnational
    WHERE ext.trimm(old_elcode_bcd) <> old_elcode_bcd
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'REC_CREATE_USER' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rec_create_user AS value
    FROM core.element_subnational
    WHERE ext.trimm(rec_create_user) <> rec_create_user
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'REC_LAST_MOD_USER' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rec_last_mod_user AS value
    FROM core.element_subnational
    WHERE ext.trimm(rec_last_mod_user) <> rec_last_mod_user
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'ROUNDED_S_RANK' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rounded_s_rank AS value
    FROM core.element_subnational
    WHERE ext.trimm(rounded_s_rank) <> rounded_s_rank
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_CLASSIFICATION_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_classification_com AS value
    FROM core.element_subnational
    WHERE ext.trimm(s_classification_com) <> s_classification_com
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_DISTRIBUTION_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_distribution_com AS value
    FROM core.element_subnational
    WHERE ext.trimm(s_distribution_com) <> s_distribution_com
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_ELEMENT_INTERNAL_NOTES' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_element_internal_notes AS value
    FROM core.element_subnational
    WHERE ext.trimm(s_element_internal_notes) <> s_element_internal_notes
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_EO_TRACKING_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_eo_tracking_com AS value
    FROM core.element_subnational
    WHERE ext.trimm(s_eo_tracking_com) <> s_eo_tracking_com
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_IMAGE_AVAILABLE_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_image_available_ind AS value
    FROM core.element_subnational
    WHERE ext.trimm(s_image_available_ind) <> s_image_available_ind
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_IMAGE_NOTES' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_image_notes AS value
    FROM core.element_subnational
    WHERE ext.trimm(s_image_notes) <> s_image_notes
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_PRIMARY_COMMON_NAME' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_primary_common_name AS value
    FROM core.element_subnational
    WHERE ext.trimm(s_primary_common_name) <> s_primary_common_name
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_PROTECTION_STATUS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_protection_status AS value
    FROM core.element_subnational
    WHERE ext.trimm(s_protection_status) <> s_protection_status
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_RANK' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_rank AS value
    FROM core.element_subnational
    WHERE ext.trimm(s_rank) <> s_rank
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_AREA_DIST_OF_OCCUPANCY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_area_dist_of_occupancy_com AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(s_area_dist_of_occupancy_com) <> s_area_dist_of_occupancy_com
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_EXEMP_SITE' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_exemp_site AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(s_exemp_site) <> s_exemp_site
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_NUMBER_EOS_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_number_eos_com AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(s_number_eos_com) <> s_number_eos_com
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_NUMBER_GOOD_EOS_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_number_good_eos_com AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(s_number_good_eos_com) <> s_number_good_eos_com
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_NUMBER_PROT_EOS_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_number_prot_eos_com AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(s_number_prot_eos_com) <> s_number_prot_eos_com
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_OTHER_RANK_CONSID_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_other_rank_consid_com, amount => 4000, "offset" => 1) AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(oracle.substr(lob_loc => s_other_rank_consid_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_other_rank_consid_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_POP_SIZE_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_pop_size_com AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(s_pop_size_com) <> s_pop_size_com
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_RANGE_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_range_com, amount => 4000, "offset" => 1) AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(oracle.substr(lob_loc => s_range_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_range_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_RESEARCH_NEEDS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_research_needs, amount => 4000, "offset" => 1) AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(oracle.substr(lob_loc => s_research_needs, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_research_needs, amount => 4000, "offset" => 1)
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_SHORT_TERM_TREND_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_short_term_trend_com AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(s_short_term_trend_com) <> s_short_term_trend_com
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_THREAT_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_threat_com, amount => 4000, "offset" => 1) AS value
    FROM core.element_subnatl_rank
    WHERE ext.trimm(oracle.substr(lob_loc => s_threat_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_threat_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'PLANT_CAS' AS tablename, 'S_ECOLOGY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_ecology_com, amount => 4000, "offset" => 1) AS value
    FROM core.plant_cas
    WHERE ext.trimm(oracle.substr(lob_loc => s_ecology_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_ecology_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'PLANT_CAS' AS tablename, 'S_HABITAT_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_habitat_com, amount => 4000, "offset" => 1) AS value
    FROM core.plant_cas
    WHERE ext.trimm(oracle.substr(lob_loc => s_habitat_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_habitat_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'PLANT_CAS' AS tablename, 'S_REPRODUCTION_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_reproduction_com, amount => 4000, "offset" => 1) AS value
    FROM core.plant_cas
    WHERE ext.trimm(oracle.substr(lob_loc => s_reproduction_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => s_reproduction_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'VISIT' AS tablename, 'VISIT_NOTES' AS column_name, visit_id AS pk_value, 'VISIT_ID' AS pk_field, oracle.substr(lob_loc => visit_notes, amount => 4000, "offset" => 1) AS value
    FROM core.visit
    WHERE ext.trimm(oracle.substr(lob_loc => visit_notes, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => visit_notes, amount => 4000, "offset" => 1)
UNION
SELECT
    'VISIT' AS tablename, 'VISIT_DATE' AS column_name, visit_id AS pk_value, 'VISIT_ID' AS pk_field, visit_date AS value
    FROM core.visit
    WHERE ext.trimm(visit_date) <> visit_date
UNION
SELECT
    'VISIT' AS tablename, 'VISITED_BY' AS column_name, visit_id AS pk_value, 'VISIT_ID' AS pk_field, visited_by AS value
    FROM core.visit
    WHERE ext.trimm(visited_by) <> visited_by
UNION
SELECT
    'EO' AS table_name, 'DATA_SENSITIVE_REASONS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, data_sensitive_reasons AS value
    FROM core.eo
    WHERE ext.trimm(data_sensitive_reasons) <> data_sensitive_reasons
UNION
SELECT
    'EO' AS table_name, 'PRECISION_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, precision_bcd AS value
    FROM core.eo
    WHERE ext.trimm(precision_bcd) <> precision_bcd
UNION
SELECT
    'EO' AS table_name, 'LATITUDE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, latitude AS value
    FROM core.eo
    WHERE ext.trimm(latitude) <> latitude
UNION
SELECT
    'EO' AS table_name, 'LONGITUDE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, longitude AS value
    FROM core.eo
    WHERE ext.trimm(longitude) <> longitude
UNION
SELECT
    'EO' AS table_name, 'SOUTH' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, south AS value
    FROM core.eo
    WHERE ext.trimm(south) <> south
UNION
SELECT
    'EO' AS table_name, 'NORTH' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, north AS value
    FROM core.eo
    WHERE ext.trimm(north) <> north
UNION
SELECT
    'EO' AS table_name, 'EAST' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, east AS value
    FROM core.eo
    WHERE ext.trimm(east) <> east
UNION
SELECT
    'EO' AS table_name, 'WEST' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, west AS value
    FROM core.eo
    WHERE ext.trimm(west) <> west
UNION
SELECT
    'EO' AS table_name, 'REP_ACCURACY_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, rep_accuracy_com AS value
    FROM core.eo
    WHERE ext.trimm(rep_accuracy_com) <> rep_accuracy_com
UNION
SELECT
    'EO' AS table_name, 'SEPARATION_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, separation_com AS value
    FROM core.eo
    WHERE ext.trimm(separation_com) <> separation_com
UNION
SELECT
    'EO' AS table_name, 'EO_REP_EDITED_IND' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_rep_edited_ind AS value
    FROM core.eo
    WHERE ext.trimm(eo_rep_edited_ind) <> eo_rep_edited_ind
UNION
SELECT
    'EO' AS table_name, 'EO_REP_EDITED_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_rep_edited_com AS value
    FROM core.eo
    WHERE ext.trimm(eo_rep_edited_com) <> eo_rep_edited_com
UNION
SELECT
    'EO' AS table_name, 'ADDITIONAL_INV_NEEDED_IND' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, additional_inv_needed_ind AS value
    FROM core.eo
    WHERE ext.trimm(additional_inv_needed_ind) <> additional_inv_needed_ind
UNION
SELECT
    'EO' AS table_name, 'ADDITIONAL_INV_NEEDED_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, additional_inv_needed_com AS value
    FROM core.eo
    WHERE ext.trimm(additional_inv_needed_com) <> additional_inv_needed_com
UNION
SELECT
    'EO' AS table_name, 'MULTI_JURIS_COLLAB_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, multi_juris_collab_com AS value
    FROM core.eo
    WHERE ext.trimm(multi_juris_collab_com) <> multi_juris_collab_com
UNION
SELECT
    'EO' AS table_name, 'SURVEY_DATE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, survey_date AS value
    FROM core.eo
    WHERE ext.trimm(survey_date) <> survey_date
UNION
SELECT
    'EO' AS table_name, 'FIRST_OBS_DATE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, first_obs_date AS value
    FROM core.eo
    WHERE ext.trimm(first_obs_date) <> first_obs_date
UNION
SELECT
    'EO' AS table_name, 'LAST_OBS_DATE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, last_obs_date AS value
    FROM core.eo
    WHERE ext.trimm(last_obs_date) <> last_obs_date
UNION
SELECT
    'EO' AS table_name, 'MONITORING_NEEDS_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, monitoring_needs_com AS value
    FROM core.eo
    WHERE ext.trimm(monitoring_needs_com) <> monitoring_needs_com
UNION
SELECT
    'EO' AS table_name, 'RESEARCH_NEEDS_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, research_needs_com AS value
    FROM core.eo
    WHERE ext.trimm(research_needs_com) <> research_needs_com
UNION
SELECT
    'EO' AS table_name, 'CONDITION_OF_EO' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, condition_of_eo AS value
    FROM core.eo
    WHERE ext.trimm(condition_of_eo) <> condition_of_eo
UNION
SELECT
    'EO' AS table_name, 'SIZE_OF_EO' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, size_of_eo AS value
    FROM core.eo
    WHERE ext.trimm(size_of_eo) <> size_of_eo
UNION
SELECT
    'EO' AS table_name, 'LANDSCAPE_CONTEXT' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, landscape_context AS value
    FROM core.eo
    WHERE ext.trimm(landscape_context) <> landscape_context
UNION
SELECT
    'EO' AS table_name, 'EO_RANK_DATE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_rank_date AS value
    FROM core.eo
    WHERE ext.trimm(eo_rank_date) <> eo_rank_date
UNION
SELECT
    'EO' AS table_name, 'EO_RANK_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_rank_com AS value
    FROM core.eo
    WHERE ext.trimm(eo_rank_com) <> eo_rank_com
UNION
SELECT
    'EO' AS table_name, 'EO_TYPE_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_type_bcd AS value
    FROM core.eo
    WHERE ext.trimm(eo_type_bcd) <> eo_type_bcd
UNION
SELECT
    'EO' AS table_name, 'EO_INTERPRETED_USESA_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_interpreted_usesa_status AS value
    FROM core.eo
    WHERE ext.trimm(eo_interpreted_usesa_status) <> eo_interpreted_usesa_status
UNION
SELECT
    'EO' AS table_name, 'EO_INTERPRETED_COSEWIC_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_interpreted_cosewic_status AS value
    FROM core.eo
    WHERE ext.trimm(eo_interpreted_cosewic_status) <> eo_interpreted_cosewic_status
UNION
SELECT
    'EO' AS table_name, 'PROTECTION_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, protection_com AS value
    FROM core.eo
    WHERE ext.trimm(protection_com) <> protection_com
UNION
SELECT
    'EO' AS table_name, 'OWNER_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, owner_com AS value
    FROM core.eo
    WHERE ext.trimm(owner_com) <> owner_com
UNION
SELECT
    'EO' AS table_name, 'OWNERINFO_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, ownerinfo_bcd AS value
    FROM core.eo
    WHERE ext.trimm(ownerinfo_bcd) <> ownerinfo_bcd
UNION
SELECT
    'EO' AS table_name, 'IMAGE_IND' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, image_ind AS value
    FROM core.eo
    WHERE ext.trimm(image_ind) <> image_ind
UNION
SELECT
    'EO' AS table_name, 'CDREV_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, cdrev_bcd AS value
    FROM core.eo
    WHERE ext.trimm(cdrev_bcd) <> cdrev_bcd
UNION
SELECT
    'EO' AS table_name, 'LEAD_RESP' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, lead_resp AS value
    FROM core.eo
    WHERE ext.trimm(lead_resp) <> lead_resp
UNION
SELECT
    'EO' AS table_name, 'VERSION_AUTHOR_NAME' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, version_author_name AS value
    FROM core.eo
    WHERE ext.trimm(version_author_name) <> version_author_name
UNION
SELECT
    'EO' AS table_name, 'TRANSCRIBED_BY' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, transcribed_by AS value
    FROM core.eo
    WHERE ext.trimm(transcribed_by) <> transcribed_by
UNION
SELECT
    'EO' AS table_name, 'MANUAL_FILE_NOTE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, manual_file_note AS value
    FROM core.eo
    WHERE ext.trimm(manual_file_note) <> manual_file_note
UNION
SELECT
    'EO' AS table_name, 'PAPER_MAPPING_BY' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, paper_mapping_by AS value
    FROM core.eo
    WHERE ext.trimm(paper_mapping_by) <> paper_mapping_by
UNION
SELECT
    'EO' AS table_name, 'DATA_QC_BY' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, data_qc_by AS value
    FROM core.eo
    WHERE ext.trimm(data_qc_by) <> data_qc_by
UNION
SELECT
    'EO' AS table_name, 'REC_LAST_MOD_USER' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, rec_last_mod_user AS value
    FROM core.eo
    WHERE ext.trimm(rec_last_mod_user) <> rec_last_mod_user
UNION
SELECT
    'EO' AS table_name, 'REC_CREATE_USER' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, rec_create_user AS value
    FROM core.eo
    WHERE ext.trimm(rec_create_user) <> rec_create_user
UNION
SELECT
    'EO' AS table_name, 'NEW_EO_REASON' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, new_eo_reason AS value
    FROM core.eo
    WHERE ext.trimm(new_eo_reason) <> new_eo_reason
UNION
SELECT
    'EO' AS table_name, 'NS_EO_INTERP_USESA_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, ns_eo_interp_usesa_status AS value
    FROM core.eo
    WHERE ext.trimm(ns_eo_interp_usesa_status) <> ns_eo_interp_usesa_status
UNION
SELECT
    'EO' AS table_name, 'NS_EO_INTERP_COSEWIC_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, ns_eo_interp_cosewic_status AS value
    FROM core.eo
    WHERE ext.trimm(ns_eo_interp_cosewic_status) <> ns_eo_interp_cosewic_status
UNION
SELECT
    'EO' AS table_name, 'EO_INTERPRETED_STATUS_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_interpreted_status_com AS value
    FROM core.eo
    WHERE ext.trimm(eo_interpreted_status_com) <> eo_interpreted_status_com
UNION
SELECT
    'EO' AS table_name, 'DO_NOT_EXCHANGE_IND' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, do_not_exchange_ind AS value
    FROM core.eo
    WHERE ext.trimm(do_not_exchange_ind) <> do_not_exchange_ind
UNION
SELECT
    'EO' AS table_name, 'DX_LAST_RECEIVED_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, dx_last_received_status AS value
    FROM core.eo
    WHERE ext.trimm(dx_last_received_status) <> dx_last_received_status
UNION
SELECT
    'EO' AS table_name, 'EO_NUM_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_num_bcd AS value
    FROM core.eo
    WHERE ext.trimm(eo_num_bcd) <> eo_num_bcd
UNION
SELECT
    'EO' AS table_name, 'GLOBAL_ID' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, global_id AS value
    FROM core.eo
    WHERE ext.trimm(global_id) <> global_id
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'GLOBAL_ID' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, global_id AS value
    FROM core.source_feature
    WHERE ext.trimm(global_id) <> global_id
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'SOURCE_FEATURE_DESCRIPTOR' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, source_feature_descriptor AS value
    FROM core.source_feature
    WHERE ext.trimm(source_feature_descriptor) <> source_feature_descriptor
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'SOURCE_FEATURE_LOCATOR' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, source_feature_locator AS value
    FROM core.source_feature
    WHERE ext.trimm(source_feature_locator) <> source_feature_locator
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'INDEPENDENT_SOURCE_FEATURE_IND' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, independent_source_feature_ind AS value
    FROM core.source_feature
    WHERE ext.trimm(independent_source_feature_ind) <> independent_source_feature_ind
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'DIGITIZING_COM' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, digitizing_com AS value
    FROM core.source_feature
    WHERE ext.trimm(digitizing_com) <> digitizing_com
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'MAPPING_COM' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, mapping_com AS value
    FROM core.source_feature
    WHERE ext.trimm(mapping_com) <> mapping_com
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'DATA_QC_BY' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, data_qc_by AS value
    FROM core.source_feature
    WHERE ext.trimm(data_qc_by) <> data_qc_by
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'REC_CREATE_USER' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, rec_create_user AS value
    FROM core.source_feature
    WHERE ext.trimm(rec_create_user) <> rec_create_user
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'REC_LAST_MOD_USER' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, rec_last_mod_user AS value
    FROM core.source_feature
    WHERE ext.trimm(rec_last_mod_user) <> rec_last_mod_user
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'EST_REP_ACCURACY_COM' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, est_rep_accuracy_com AS value
    FROM core.source_feature
    WHERE ext.trimm(est_rep_accuracy_com) <> est_rep_accuracy_com
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'PRE_SHAPE_TYPE' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, pre_shape_type AS value
    FROM core.source_feature
    WHERE ext.trimm(pre_shape_type) <> pre_shape_type
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'SHAPE_TYPE' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, shape_type AS value
    FROM core.source_feature
    WHERE ext.trimm(shape_type) <> shape_type
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'EXCLUDE_UNSUITABLE_HABITAT_IND' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, exclude_unsuitable_habitat_ind AS value
    FROM core.source_feature
    WHERE ext.trimm(exclude_unsuitable_habitat_ind) <> exclude_unsuitable_habitat_ind
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'DX_LAST_RECEIVED_STATUS' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, dx_last_received_status AS value
    FROM core.source_feature
    WHERE ext.trimm(dx_last_received_status) <> dx_last_received_status
UNION
SELECT
    'SOURCE_FEATURE' AS table_name, 'DATA_SENSITIVE_REASONS' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, data_sensitive_reasons AS value
    FROM core.source_feature
    WHERE ext.trimm(data_sensitive_reasons) <> data_sensitive_reasons
UNION
SELECT
    'EO' AS table_name, 'EO_DATA' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => eo_data, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE ext.trimm(oracle.substr(lob_loc => eo_data, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => eo_data, amount => 4000, "offset" => 1)
UNION
SELECT
    'EO' AS table_name, 'GEN_DESC' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => gen_desc, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE ext.trimm(oracle.substr(lob_loc => gen_desc, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => gen_desc, amount => 4000, "offset" => 1)
UNION
SELECT
    'EO' AS table_name, 'DIRECTIONS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => directions, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE ext.trimm(oracle.substr(lob_loc => directions, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => directions, amount => 4000, "offset" => 1)
UNION
SELECT
    'EO' AS table_name, 'GENERAL_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => general_com, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE ext.trimm(oracle.substr(lob_loc => general_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => general_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'EO' AS table_name, 'MGMT_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => mgmt_com, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE ext.trimm(oracle.substr(lob_loc => mgmt_com, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => mgmt_com, amount => 4000, "offset" => 1)
UNION
SELECT
    'EO' AS table_name, 'ADDITIONAL_TOPICS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => additional_topics, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE ext.trimm(oracle.substr(lob_loc => additional_topics, amount => 4000, "offset" => 1)) <> oracle.substr(lob_loc => additional_topics, amount => 4000, "offset" => 1);


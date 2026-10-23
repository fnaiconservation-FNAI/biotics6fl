CREATE OR REPLACE  VIEW ext.fnai_element_bad_tag (tablename, column_name, pk_value, pk_field, value) AS
SELECT
    'ANIMAL_CAS' AS tablename, 'S_WITHIN_BORDERS_MIGRANT_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_within_borders_migrant_ind AS value
    FROM core.animal_cas
    WHERE s_within_borders_migrant_ind LIKE '%<table%' OR s_within_borders_migrant_ind LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_MIGRATION_MOBILITY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_migration_mobility_com AS value
    FROM core.animal_cas
    WHERE s_migration_mobility_com LIKE '%<table%' OR s_migration_mobility_com LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_FOOD_HABITS_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_food_habits_com AS value
    FROM core.animal_cas
    WHERE s_food_habits_com LIKE '%<table%' OR s_food_habits_com LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_PHENOLOGY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_phenology_com AS value
    FROM core.animal_cas
    WHERE s_phenology_com LIKE '%<table%' OR s_phenology_com LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_ECONOMIC_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_economic_com AS value
    FROM core.animal_cas
    WHERE s_economic_com LIKE '%<table%' OR s_economic_com LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_GAME_SPECIES_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_game_species_ind AS value
    FROM core.animal_cas
    WHERE s_game_species_ind LIKE '%<table%' OR s_game_species_ind LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_COMMERCIAL_SPECIES_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_commercial_species_ind AS value
    FROM core.animal_cas
    WHERE s_commercial_species_ind LIKE '%<table%' OR s_commercial_species_ind LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_SPORT_FISH_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_sport_fish_ind AS value
    FROM core.animal_cas
    WHERE s_sport_fish_ind LIKE '%<table%' OR s_sport_fish_ind LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_FUR_BEARER_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_fur_bearer_ind AS value
    FROM core.animal_cas
    WHERE s_fur_bearer_ind LIKE '%<table%' OR s_fur_bearer_ind LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_NONGAME_PROT_SPECIES_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_nongame_prot_species_ind AS value
    FROM core.animal_cas
    WHERE s_nongame_prot_species_ind LIKE '%<table%' OR s_nongame_prot_species_ind LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'ADDITIONAL_TOPICS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, additional_topics AS value
    FROM core.animal_cas
    WHERE additional_topics LIKE '%<table%' OR additional_topics LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'VERSION_AUTHOR_NAME' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, version_author_name AS value
    FROM core.animal_cas
    WHERE version_author_name LIKE '%<table%' OR version_author_name LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'INTERNAL_NOTES' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, internal_notes AS value
    FROM core.animal_cas
    WHERE internal_notes LIKE '%<table%' OR internal_notes LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'REC_LAST_MOD_USER' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rec_last_mod_user AS value
    FROM core.animal_cas
    WHERE rec_last_mod_user LIKE '%<table%' OR rec_last_mod_user LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'REC_CREATE_USER' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rec_create_user AS value
    FROM core.animal_cas
    WHERE rec_create_user LIKE '%<table%' OR rec_create_user LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_SUBSPECIES_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_subspecies_com AS value
    FROM core.animal_cas
    WHERE s_subspecies_com LIKE '%<table%' OR s_subspecies_com LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_ID_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_id_com AS value
    FROM core.animal_cas
    WHERE s_id_com LIKE '%<table%' OR s_id_com LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_NON_MIGRANT_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_non_migrant_ind AS value
    FROM core.animal_cas
    WHERE s_non_migrant_ind LIKE '%<table%' OR s_non_migrant_ind LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_LOCAL_MIGRANT_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_local_migrant_ind AS value
    FROM core.animal_cas
    WHERE s_local_migrant_ind LIKE '%<table%' OR s_local_migrant_ind LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_DISTANT_MIGRANT_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_distant_migrant_ind AS value
    FROM core.animal_cas
    WHERE s_distant_migrant_ind LIKE '%<table%' OR s_distant_migrant_ind LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'SBREED_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, sbreed_bcd AS value
    FROM core.animal_cas
    WHERE sbreed_bcd LIKE '%<table%' OR sbreed_bcd LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'SWINTER_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, swinter_bcd AS value
    FROM core.animal_cas
    WHERE swinter_bcd LIKE '%<table%' OR swinter_bcd LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'SMIGTRANS_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, smigtrans_bcd AS value
    FROM core.animal_cas
    WHERE smigtrans_bcd LIKE '%<table%' OR smigtrans_bcd LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'SIRREGAPP_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, sirregapp_bcd AS value
    FROM core.animal_cas
    WHERE sirregapp_bcd LIKE '%<table%' OR sirregapp_bcd LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'DELETED_REASON_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, deleted_reason_com AS value
    FROM core.element_subnational
    WHERE deleted_reason_com LIKE '%<table%' OR deleted_reason_com LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_PRIMARY_COMMON_NAME' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_primary_common_name AS value
    FROM core.element_subnational
    WHERE s_primary_common_name LIKE '%<table%' OR s_primary_common_name LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'ACCEPTED_BY_ECOLOGY_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, accepted_by_ecology_ind AS value
    FROM core.element_subnational
    WHERE accepted_by_ecology_ind LIKE '%<table%' OR accepted_by_ecology_ind LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_CLASSIFICATION_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_classification_com AS value
    FROM core.element_subnational
    WHERE s_classification_com LIKE '%<table%' OR s_classification_com LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_RANK' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_rank AS value
    FROM core.element_subnational
    WHERE s_rank LIKE '%<table%' OR s_rank LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'ROUNDED_S_RANK' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rounded_s_rank AS value
    FROM core.element_subnational
    WHERE rounded_s_rank LIKE '%<table%' OR rounded_s_rank LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'BCD_STYLE_S_RANK' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, bcd_style_s_rank AS value
    FROM core.element_subnational
    WHERE bcd_style_s_rank LIKE '%<table%' OR bcd_style_s_rank LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_DISTRIBUTION_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_distribution_com AS value
    FROM core.element_subnational
    WHERE s_distribution_com LIKE '%<table%' OR s_distribution_com LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_PROTECTION_STATUS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_protection_status AS value
    FROM core.element_subnational
    WHERE s_protection_status LIKE '%<table%' OR s_protection_status LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_IMAGE_AVAILABLE_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_image_available_ind AS value
    FROM core.element_subnational
    WHERE s_image_available_ind LIKE '%<table%' OR s_image_available_ind LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_IMAGE_NOTES' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_image_notes AS value
    FROM core.element_subnational
    WHERE s_image_notes LIKE '%<table%' OR s_image_notes LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_ELEMENT_INTERNAL_NOTES' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_element_internal_notes AS value
    FROM core.element_subnational
    WHERE s_element_internal_notes LIKE '%<table%' OR s_element_internal_notes LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'REC_LAST_MOD_USER' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rec_last_mod_user AS value
    FROM core.element_subnational
    WHERE rec_last_mod_user LIKE '%<table%' OR rec_last_mod_user LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'REC_CREATE_USER' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, rec_create_user AS value
    FROM core.element_subnational
    WHERE rec_create_user LIKE '%<table%' OR rec_create_user LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'OLD_ELCODE_BCD' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, old_elcode_bcd AS value
    FROM core.element_subnational
    WHERE old_elcode_bcd LIKE '%<table%' OR old_elcode_bcd LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'S_EO_TRACKING_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_eo_tracking_com AS value
    FROM core.element_subnational
    WHERE s_eo_tracking_com LIKE '%<table%' OR s_eo_tracking_com LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'IN_PROGRESS_IND' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, in_progress_ind AS value
    FROM core.element_subnational
    WHERE in_progress_ind LIKE '%<table%' OR in_progress_ind LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'DX_LAST_RECEIVED_STATUS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, dx_last_received_status AS value
    FROM core.element_subnational
    WHERE dx_last_received_status LIKE '%<table%' OR dx_last_received_status LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATIONAL' AS tablename, 'DATA_SENSITIVE_REASONS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, data_sensitive_reasons AS value
    FROM core.element_subnational
    WHERE data_sensitive_reasons LIKE '%<table%' OR data_sensitive_reasons LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_EXEMP_SITE' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_exemp_site AS value
    FROM core.element_subnatl_rank
    WHERE s_exemp_site LIKE '%<table%' OR s_exemp_site LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_NUMBER_EOS_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_number_eos_com AS value
    FROM core.element_subnatl_rank
    WHERE s_number_eos_com LIKE '%<table%' OR s_number_eos_com LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_NUMBER_GOOD_EOS_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_number_good_eos_com AS value
    FROM core.element_subnatl_rank
    WHERE s_number_good_eos_com LIKE '%<table%' OR s_number_good_eos_com LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_NUMBER_PROT_EOS_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_number_prot_eos_com AS value
    FROM core.element_subnatl_rank
    WHERE s_number_prot_eos_com LIKE '%<table%' OR s_number_prot_eos_com LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_POP_SIZE_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_pop_size_com AS value
    FROM core.element_subnatl_rank
    WHERE s_pop_size_com LIKE '%<table%' OR s_pop_size_com LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_AREA_DIST_OF_OCCUPANCY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_area_dist_of_occupancy_com AS value
    FROM core.element_subnatl_rank
    WHERE s_area_dist_of_occupancy_com LIKE '%<table%' OR s_area_dist_of_occupancy_com LIKE '%<span%'
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_SHORT_TERM_TREND_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, s_short_term_trend_com AS value
    FROM core.element_subnatl_rank
    WHERE s_short_term_trend_com LIKE '%<table%' OR s_short_term_trend_com LIKE '%<span%'
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_HABITAT_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_habitat_com, amount => 4000, "offset" => 1) AS value
    FROM core.animal_cas
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_habitat_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_habitat_com, pattern => '<span') > 0
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_ECOLOGY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_ecology_com, amount => 4000, "offset" => 1) AS value
    FROM core.animal_cas
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_ecology_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_ecology_com, pattern => '<span') > 0
UNION
SELECT
    'ANIMAL_CAS' AS tablename, 'S_REPRODUCTION_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_reproduction_com, amount => 4000, "offset" => 1) AS value
    FROM core.animal_cas
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_reproduction_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_reproduction_com, pattern => '<span') > 0
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_RANGE_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_range_com, amount => 4000, "offset" => 1) AS value
    FROM core.element_subnatl_rank
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_range_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_range_com, pattern => '<span') > 0
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_THREAT_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_threat_com, amount => 4000, "offset" => 1) AS value
    FROM core.element_subnatl_rank
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_threat_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_threat_com, pattern => '<span') > 0
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_OTHER_RANK_CONSID_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_other_rank_consid_com, amount => 4000, "offset" => 1) AS value
    FROM core.element_subnatl_rank
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_other_rank_consid_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_other_rank_consid_com, pattern => '<span') > 0
UNION
SELECT
    'ELEMENT_SUBNATL_RANK' AS tablename, 'S_RESEARCH_NEEDS' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_research_needs, amount => 4000, "offset" => 1) AS value
    FROM core.element_subnatl_rank
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_research_needs, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_research_needs, pattern => '<span') > 0
UNION
SELECT
    'PLANT_CAS' AS tablename, 'S_HABITAT_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_habitat_com, amount => 4000, "offset" => 1) AS value
    FROM core.plant_cas
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_habitat_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_habitat_com, pattern => '<span') > 0
UNION
SELECT
    'PLANT_CAS' AS tablename, 'S_ECOLOGY_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_ecology_com, amount => 4000, "offset" => 1) AS value
    FROM core.plant_cas
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_ecology_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_ecology_com, pattern => '<span') > 0
UNION
SELECT
    'PLANT_CAS' AS tablename, 'S_REPRODUCTION_COM' AS column_name, element_subnational_id AS pk_value, 'ELEMENT_SUBNATIONAL_ID' AS pk_field, oracle.substr(lob_loc => s_reproduction_com, amount => 4000, "offset" => 1) AS value
    FROM core.plant_cas
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => s_reproduction_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => s_reproduction_com, pattern => '<span') > 0
UNION
SELECT
    'VISIT' AS tablename, 'VISIT_NOTES' AS column_name, visit_id AS pk_value, 'VISIT_ID' AS pk_field, oracle.substr(lob_loc => visit_notes, amount => 4000, "offset" => 1) AS value
    FROM core.visit
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => visit_notes, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => visit_notes, pattern => '<span') > 0
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'CAPTION1' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, caption1 AS value
    FROM ext.taxon_sub_flext1
    WHERE caption1 LIKE '%<table%' OR caption1 LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'CAPTION2' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, caption2 AS value
    FROM ext.taxon_sub_flext1
    WHERE caption2 LIKE '%<table%' OR caption2 LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'CAPTION3' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, caption3 AS value
    FROM ext.taxon_sub_flext1
    WHERE caption3 LIKE '%<table%' OR caption3 LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'CAPTION4' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, caption4 AS value
    FROM ext.taxon_sub_flext1
    WHERE caption4 LIKE '%<table%' OR caption4 LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'CONS_STATUS' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, cons_status AS value
    FROM ext.taxon_sub_flext1
    WHERE cons_status LIKE '%<table%' OR cons_status LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'DATASENS' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, datasens AS value
    FROM ext.taxon_sub_flext1
    WHERE datasens LIKE '%<table%' OR datasens LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'DRAWING1' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, drawing1 AS value
    FROM ext.taxon_sub_flext1
    WHERE drawing1 LIKE '%<table%' OR drawing1 LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'DRAWING1_CAPTION' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, drawing1_caption AS value
    FROM ext.taxon_sub_flext1
    WHERE drawing1_caption LIKE '%<table%' OR drawing1_caption LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'FIELD_DESCR_HEADER' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, field_descr_header AS value
    FROM ext.taxon_sub_flext1
    WHERE field_descr_header LIKE '%<table%' OR field_descr_header LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'FIELD_GUIDE_VERSION_DATE' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, field_guide_version_date AS value
    FROM ext.taxon_sub_flext1
    WHERE field_guide_version_date LIKE '%<table%' OR field_guide_version_date LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'FLD_GUIDE_REFS' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, fld_guide_refs AS value
    FROM ext.taxon_sub_flext1
    WHERE fld_guide_refs LIKE '%<table%' OR fld_guide_refs LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'FLD_GUIDE_SPECIES' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, fld_guide_species AS value
    FROM ext.taxon_sub_flext1
    WHERE fld_guide_species LIKE '%<table%' OR fld_guide_species LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'FL_WETLAND_STATUS' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, fl_wetland_status AS value
    FROM ext.taxon_sub_flext1
    WHERE fl_wetland_status LIKE '%<table%' OR fl_wetland_status LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'FORMER_NAME' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, former_name AS value
    FROM ext.taxon_sub_flext1
    WHERE former_name LIKE '%<table%' OR former_name LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'FWC_SEARCH_IMAGE' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, fwc_search_image AS value
    FROM ext.taxon_sub_flext1
    WHERE fwc_search_image LIKE '%<table%' OR fwc_search_image LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'OLD_USESA' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, old_usesa AS value
    FROM ext.taxon_sub_flext1
    WHERE old_usesa LIKE '%<table%' OR old_usesa LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'OLD_USESA_COM' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, old_usesa_com AS value
    FROM ext.taxon_sub_flext1
    WHERE old_usesa_com LIKE '%<table%' OR old_usesa_com LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'PHOTO1' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, photo1 AS value
    FROM ext.taxon_sub_flext1
    WHERE photo1 LIKE '%<table%' OR photo1 LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'PHOTO2' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, photo2 AS value
    FROM ext.taxon_sub_flext1
    WHERE photo2 LIKE '%<table%' OR photo2 LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'PHOTO3' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, photo3 AS value
    FROM ext.taxon_sub_flext1
    WHERE photo3 LIKE '%<table%' OR photo3 LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'PHOTO4' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, photo4 AS value
    FROM ext.taxon_sub_flext1
    WHERE photo4 LIKE '%<table%' OR photo4 LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'RANGE_WIDE_DISTRIB' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, range_wide_distrib AS value
    FROM ext.taxon_sub_flext1
    WHERE range_wide_distrib LIKE '%<table%' OR range_wide_distrib LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'REC_CREATE_USER' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, rec_create_user AS value
    FROM ext.taxon_sub_flext1
    WHERE rec_create_user LIKE '%<table%' OR rec_create_user LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'REC_LAST_MOD_USER' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, rec_last_mod_user AS value
    FROM ext.taxon_sub_flext1
    WHERE rec_last_mod_user LIKE '%<table%' OR rec_last_mod_user LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'RELATED_RARE_SPP_HEADER' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, related_rare_spp_header AS value
    FROM ext.taxon_sub_flext1
    WHERE related_rare_spp_header LIKE '%<table%' OR related_rare_spp_header LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'SIMILAR_SPP_HEADER' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, similar_spp_header AS value
    FROM ext.taxon_sub_flext1
    WHERE similar_spp_header LIKE '%<table%' OR similar_spp_header LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'SIM_AND_RELATED_SPP' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, sim_and_related_spp AS value
    FROM ext.taxon_sub_flext1
    WHERE sim_and_related_spp LIKE '%<table%' OR sim_and_related_spp LIKE '%<span%'
UNION
SELECT
    'TAXON_SUB_FLEXT1' AS tablename, 'S_LOWERCASE_COMMON_NAME' AS column_name, taxon_sub_flext1_id AS pk_value, 'TAXON_SUB_FLEXT1_ID' AS pk_field, s_lowercase_common_name AS value
    FROM ext.taxon_sub_flext1
    WHERE s_lowercase_common_name LIKE '%<table%' OR s_lowercase_common_name LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'DATA_SENSITIVE_REASONS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, data_sensitive_reasons AS value
    FROM core.eo
    WHERE data_sensitive_reasons LIKE '%<table%' OR data_sensitive_reasons LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'PRECISION_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, precision_bcd AS value
    FROM core.eo
    WHERE precision_bcd LIKE '%<table%' OR precision_bcd LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'LATITUDE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, latitude AS value
    FROM core.eo
    WHERE latitude LIKE '%<table%' OR latitude LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'LONGITUDE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, longitude AS value
    FROM core.eo
    WHERE longitude LIKE '%<table%' OR longitude LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'SOUTH' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, south AS value
    FROM core.eo
    WHERE south LIKE '%<table%' OR south LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'NORTH' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, north AS value
    FROM core.eo
    WHERE north LIKE '%<table%' OR north LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EAST' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, east AS value
    FROM core.eo
    WHERE east LIKE '%<table%' OR east LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'WEST' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, west AS value
    FROM core.eo
    WHERE west LIKE '%<table%' OR west LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'REP_ACCURACY_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, rep_accuracy_com AS value
    FROM core.eo
    WHERE rep_accuracy_com LIKE '%<table%' OR rep_accuracy_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'SEPARATION_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, separation_com AS value
    FROM core.eo
    WHERE separation_com LIKE '%<table%' OR separation_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_REP_EDITED_IND' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_rep_edited_ind AS value
    FROM core.eo
    WHERE eo_rep_edited_ind LIKE '%<table%' OR eo_rep_edited_ind LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_REP_EDITED_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_rep_edited_com AS value
    FROM core.eo
    WHERE eo_rep_edited_com LIKE '%<table%' OR eo_rep_edited_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'ADDITIONAL_INV_NEEDED_IND' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, additional_inv_needed_ind AS value
    FROM core.eo
    WHERE additional_inv_needed_ind LIKE '%<table%' OR additional_inv_needed_ind LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'ADDITIONAL_INV_NEEDED_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, additional_inv_needed_com AS value
    FROM core.eo
    WHERE additional_inv_needed_com LIKE '%<table%' OR additional_inv_needed_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'MULTI_JURIS_COLLAB_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, multi_juris_collab_com AS value
    FROM core.eo
    WHERE multi_juris_collab_com LIKE '%<table%' OR multi_juris_collab_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'SURVEY_DATE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, survey_date AS value
    FROM core.eo
    WHERE survey_date LIKE '%<table%' OR survey_date LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'FIRST_OBS_DATE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, first_obs_date AS value
    FROM core.eo
    WHERE first_obs_date LIKE '%<table%' OR first_obs_date LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'LAST_OBS_DATE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, last_obs_date AS value
    FROM core.eo
    WHERE last_obs_date LIKE '%<table%' OR last_obs_date LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'MONITORING_NEEDS_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, monitoring_needs_com AS value
    FROM core.eo
    WHERE monitoring_needs_com LIKE '%<table%' OR monitoring_needs_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'RESEARCH_NEEDS_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, research_needs_com AS value
    FROM core.eo
    WHERE research_needs_com LIKE '%<table%' OR research_needs_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'CONDITION_OF_EO' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, condition_of_eo AS value
    FROM core.eo
    WHERE condition_of_eo LIKE '%<table%' OR condition_of_eo LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'SIZE_OF_EO' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, size_of_eo AS value
    FROM core.eo
    WHERE size_of_eo LIKE '%<table%' OR size_of_eo LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'LANDSCAPE_CONTEXT' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, landscape_context AS value
    FROM core.eo
    WHERE landscape_context LIKE '%<table%' OR landscape_context LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_RANK_DATE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_rank_date AS value
    FROM core.eo
    WHERE eo_rank_date LIKE '%<table%' OR eo_rank_date LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_RANK_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_rank_com AS value
    FROM core.eo
    WHERE eo_rank_com LIKE '%<table%' OR eo_rank_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_TYPE_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_type_bcd AS value
    FROM core.eo
    WHERE eo_type_bcd LIKE '%<table%' OR eo_type_bcd LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_INTERPRETED_USESA_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_interpreted_usesa_status AS value
    FROM core.eo
    WHERE eo_interpreted_usesa_status LIKE '%<table%' OR eo_interpreted_usesa_status LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_INTERPRETED_COSEWIC_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_interpreted_cosewic_status AS value
    FROM core.eo
    WHERE eo_interpreted_cosewic_status LIKE '%<table%' OR eo_interpreted_cosewic_status LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'PROTECTION_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, protection_com AS value
    FROM core.eo
    WHERE protection_com LIKE '%<table%' OR protection_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'OWNER_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, owner_com AS value
    FROM core.eo
    WHERE owner_com LIKE '%<table%' OR owner_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'OWNERINFO_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, ownerinfo_bcd AS value
    FROM core.eo
    WHERE ownerinfo_bcd LIKE '%<table%' OR ownerinfo_bcd LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'IMAGE_IND' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, image_ind AS value
    FROM core.eo
    WHERE image_ind LIKE '%<table%' OR image_ind LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'CDREV_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, cdrev_bcd AS value
    FROM core.eo
    WHERE cdrev_bcd LIKE '%<table%' OR cdrev_bcd LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'LEAD_RESP' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, lead_resp AS value
    FROM core.eo
    WHERE lead_resp LIKE '%<table%' OR lead_resp LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'VERSION_AUTHOR_NAME' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, version_author_name AS value
    FROM core.eo
    WHERE version_author_name LIKE '%<table%' OR version_author_name LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'TRANSCRIBED_BY' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, transcribed_by AS value
    FROM core.eo
    WHERE transcribed_by LIKE '%<table%' OR transcribed_by LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'MANUAL_FILE_NOTE' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, manual_file_note AS value
    FROM core.eo
    WHERE manual_file_note LIKE '%<table%' OR manual_file_note LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'PAPER_MAPPING_BY' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, paper_mapping_by AS value
    FROM core.eo
    WHERE paper_mapping_by LIKE '%<table%' OR paper_mapping_by LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'DATA_QC_BY' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, data_qc_by AS value
    FROM core.eo
    WHERE data_qc_by LIKE '%<table%' OR data_qc_by LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'REC_LAST_MOD_USER' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, rec_last_mod_user AS value
    FROM core.eo
    WHERE rec_last_mod_user LIKE '%<table%' OR rec_last_mod_user LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'REC_CREATE_USER' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, rec_create_user AS value
    FROM core.eo
    WHERE rec_create_user LIKE '%<table%' OR rec_create_user LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'NEW_EO_REASON' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, new_eo_reason AS value
    FROM core.eo
    WHERE new_eo_reason LIKE '%<table%' OR new_eo_reason LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'NS_EO_INTERP_USESA_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, ns_eo_interp_usesa_status AS value
    FROM core.eo
    WHERE ns_eo_interp_usesa_status LIKE '%<table%' OR ns_eo_interp_usesa_status LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'NS_EO_INTERP_COSEWIC_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, ns_eo_interp_cosewic_status AS value
    FROM core.eo
    WHERE ns_eo_interp_cosewic_status LIKE '%<table%' OR ns_eo_interp_cosewic_status LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_INTERPRETED_STATUS_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_interpreted_status_com AS value
    FROM core.eo
    WHERE eo_interpreted_status_com LIKE '%<table%' OR eo_interpreted_status_com LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'DO_NOT_EXCHANGE_IND' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, do_not_exchange_ind AS value
    FROM core.eo
    WHERE do_not_exchange_ind LIKE '%<table%' OR do_not_exchange_ind LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'DX_LAST_RECEIVED_STATUS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, dx_last_received_status AS value
    FROM core.eo
    WHERE dx_last_received_status LIKE '%<table%' OR dx_last_received_status LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_NUM_BCD' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, eo_num_bcd AS value
    FROM core.eo
    WHERE eo_num_bcd LIKE '%<table%' OR eo_num_bcd LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'GLOBAL_ID' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, global_id AS value
    FROM core.eo
    WHERE global_id LIKE '%<table%' OR global_id LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'GLOBAL_ID' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, global_id AS value
    FROM core.source_feature
    WHERE global_id LIKE '%<table%' OR global_id LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'SOURCE_FEATURE_DESCRIPTOR' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, source_feature_descriptor AS value
    FROM core.source_feature
    WHERE source_feature_descriptor LIKE '%<table%' OR source_feature_descriptor LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'SOURCE_FEATURE_LOCATOR' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, source_feature_locator AS value
    FROM core.source_feature
    WHERE source_feature_locator LIKE '%<table%' OR source_feature_locator LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'INDEPENDENT_SOURCE_FEATURE_IND' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, independent_source_feature_ind AS value
    FROM core.source_feature
    WHERE independent_source_feature_ind LIKE '%<table%' OR independent_source_feature_ind LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'DIGITIZING_COM' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, digitizing_com AS value
    FROM core.source_feature
    WHERE digitizing_com LIKE '%<table%' OR digitizing_com LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'MAPPING_COM' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, mapping_com AS value
    FROM core.source_feature
    WHERE mapping_com LIKE '%<table%' OR mapping_com LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'DATA_QC_BY' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, data_qc_by AS value
    FROM core.source_feature
    WHERE data_qc_by LIKE '%<table%' OR data_qc_by LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'REC_CREATE_USER' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, rec_create_user AS value
    FROM core.source_feature
    WHERE rec_create_user LIKE '%<table%' OR rec_create_user LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'REC_LAST_MOD_USER' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, rec_last_mod_user AS value
    FROM core.source_feature
    WHERE rec_last_mod_user LIKE '%<table%' OR rec_last_mod_user LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'EST_REP_ACCURACY_COM' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, est_rep_accuracy_com AS value
    FROM core.source_feature
    WHERE est_rep_accuracy_com LIKE '%<table%' OR est_rep_accuracy_com LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'PRE_SHAPE_TYPE' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, pre_shape_type AS value
    FROM core.source_feature
    WHERE pre_shape_type LIKE '%<table%' OR pre_shape_type LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'SHAPE_TYPE' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, shape_type AS value
    FROM core.source_feature
    WHERE shape_type LIKE '%<table%' OR shape_type LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'EXCLUDE_UNSUITABLE_HABITAT_IND' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, exclude_unsuitable_habitat_ind AS value
    FROM core.source_feature
    WHERE exclude_unsuitable_habitat_ind LIKE '%<table%' OR exclude_unsuitable_habitat_ind LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'DX_LAST_RECEIVED_STATUS' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, dx_last_received_status AS value
    FROM core.source_feature
    WHERE dx_last_received_status LIKE '%<table%' OR dx_last_received_status LIKE '%<span%'
UNION
SELECT
    'SOURCE_FEATURE' AS tablename, 'DATA_SENSITIVE_REASONS' AS column_name, source_feature_id AS pk_value, 'SOURCE_FEATURE_ID' AS pk_field, data_sensitive_reasons AS value
    FROM core.source_feature
    WHERE data_sensitive_reasons LIKE '%<table%' OR data_sensitive_reasons LIKE '%<span%'
UNION
SELECT
    'EO' AS tablename, 'EO_DATA' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => eo_data, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => eo_data, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => eo_data, pattern => '<span') > 0
UNION
SELECT
    'EO' AS tablename, 'GEN_DESC' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => gen_desc, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => gen_desc, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => gen_desc, pattern => '<span') > 0
UNION
SELECT
    'EO' AS tablename, 'DIRECTIONS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => directions, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => directions, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => directions, pattern => '<span') > 0
UNION
SELECT
    'EO' AS tablename, 'GENERAL_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => general_com, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => general_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => general_com, pattern => '<span') > 0
UNION
SELECT
    'EO' AS tablename, 'MGMT_COM' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => mgmt_com, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => mgmt_com, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => mgmt_com, pattern => '<span') > 0
UNION
SELECT
    'EO' AS tablename, 'ADDITIONAL_TOPICS' AS column_name, eo_id AS pk_value, 'EO_ID' AS pk_field, oracle.substr(lob_loc => additional_topics, amount => 4000, "offset" => 1) AS value
    FROM core.eo
    WHERE aws_oracle_ext.dbms_lob$instr(lob_loc => additional_topics, pattern => '<table') > 0 OR aws_oracle_ext.dbms_lob$instr(lob_loc => additional_topics, pattern => '<span') > 0;


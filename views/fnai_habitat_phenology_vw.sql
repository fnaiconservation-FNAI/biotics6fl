CREATE OR REPLACE  VIEW ext.fnai_habitat_phenology_vw (element_id, sort_order, el_group, sname, common_name, jan_a, jan_b, feb_a, feb_b, mar_a, mar_b, apr_a, apr_b, may_a, may_b, jun_a, jun_b, jul_a, jul_b, aug_a, aug_b, sep_a, sep_b, oct_a, oct_b, nov_a, nov_b, dec_a, dec_b, global_habitat_comments, state_habitat_comments, global_phenology_comments, state_phenology_comments, estuarine, marine, riverine, lacustrine, palustrine, terrestrial, subterranean) AS
/* Start with some basic element identifiers */
SELECT
    est.element_subnational_id AS element_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS el_group, oracle.substr(ext.sci_name(est.element_subnational_id), 1, 50) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS common_name,
    /* Then add phenology codes for each of 24 half-month time periods */
    oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 1
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jan_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 2
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jan_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 3
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS feb_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 4
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS feb_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 5
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS mar_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 6
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS mar_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 7
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS apr_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 8
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS apr_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 9
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS may_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 10
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS may_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 11
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jun_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 12
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jun_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 13
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jul_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 14
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jul_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 15
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS aug_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 16
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS aug_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 17
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS sep_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 18
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS sep_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 19
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS oct_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 20
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS oct_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 21
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS nov_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 22
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS nov_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 23
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS dec_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.animal_seasonal_phen_cd
                 FROM d_animal_seasonal_phen phen, animal_cas_seas_phen cas_sp', ' WHERE cas_sp.d_animal_phen_season_id = 24
  		           AND phen.d_animal_seasonal_phen_id = cas_sp.d_animal_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS dec_b,
    /* Now get habitat and phenology comment fields */
    shared.delimlist(CONCAT_WS('', 'SELECT DBMS_LOB.SUBSTR(ca.g_habitat_com,4000,1)', 'FROM animal_cag ca, element_national ent, element_subnational es ', 'WHERE ca.element_global_id = ent.element_global_id
                 AND ent.element_national_id = es.element_national_id
                 AND es.element_subnational_id =', est.element_subnational_id), ','::TEXT) AS global_habitat_comments, shared.delimlist(CONCAT_WS('', 'SELECT DBMS_LOB.SUBSTR(ca.s_habitat_com,4000,1)
                 FROM animal_cas ca ', 'WHERE ca.element_subnational_id =', est.element_subnational_id), ','::TEXT) AS state_habitat_comments, shared.delimlist(CONCAT_WS('', 'SELECT ca.g_phenology_com ', 'FROM animal_cag ca, element_national ent, element_subnational es ', 'WHERE ca.element_global_id = ent.element_global_id
                 AND ent.element_national_id = es.element_national_id
                 AND es.element_subnational_id =', est.element_subnational_id), ','::TEXT) AS global_phenology_comments, shared.delimlist(CONCAT_WS('', 'SELECT ca.s_phenology_com FROM animal_cas ca ', 'WHERE ca.element_subnational_id =', est.element_subnational_id), ','::TEXT) AS state_phenology_comments,
    /* Finally, get lists of specific communities for the element, according to major community type */
    LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.estuarine_habitat_desc
         FROM d_estuarine_habitat dom, Animal_cas_estuarine_hab hab', ' WHERE dom.d_estuarine_habitat_id = hab.d_estuarine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS estuarine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.marine_habitat_desc
         FROM d_marine_habitat dom, Animal_cas_marine_hab hab', ' WHERE dom.d_marine_habitat_id = hab.d_marine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS marine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.riverine_habitat_desc
         FROM d_riverine_habitat dom, Animal_cas_riverine_hab hab', ' WHERE dom.d_riverine_habitat_id = hab.d_riverine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS riverine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.lacustrine_habitat_desc
         FROM d_lacustrine_habitat dom, Animal_cas_lacus_hab hab', ' WHERE dom.d_lacustrine_habitat_id = hab.d_lacustrine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS lacustrine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.palustrine_habitat_desc
         FROM d_palustrine_habitat dom, Animal_cas_palus_hab hab', ' WHERE dom.d_palustrine_habitat_id = hab.d_palustrine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS palustrine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.terrestrial_habitat_desc
         FROM d_terrestrial_habitat dom, Animal_cas_terr_hab hab', ' WHERE dom.d_terrestrial_habitat_id = hab.d_terrestrial_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS terrestrial, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.subterranean_habitat_desc
         FROM d_subterranean_habitat dom, Animal_cas_subterr_hab hab', ' WHERE dom.d_subterranean_habitat_id = hab.d_subterranean_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS subterranean
    FROM core.element_subnational AS est
    WHERE oracle.substr(ext.elcode(est.element_subnational_id), 1, 1) IN ('A', 'I') AND est.d_eo_track_status_id = 1
/* ***************************************************************************************** */
UNION /* GET THE SAME DATA FOR PLANTS AND LICHENS */
/* ***************************************************************************************** */
/* Start with some basic element identifiers */
SELECT
    est.element_subnational_id AS element_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS el_group, oracle.substr(ext.sci_name(est.element_subnational_id), 1, 50) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS common_name,
    /* Then add phenology codes for each of 24 half-month time periods */
    oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 1
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jan_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 2
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jan_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 3
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS feb_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 4
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS feb_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 5
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS mar_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 6
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS mar_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 7
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS apr_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 8
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS apr_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 9
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS may_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 10
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS may_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 11
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jun_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 12
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jun_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 13
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jul_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 14
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS jul_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 15
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS aug_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 16
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS aug_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 17
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS sep_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 18
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS sep_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 19
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS oct_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 20
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS oct_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 21
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS nov_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 22
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS nov_b, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 23
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS dec_a, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT phen.plant_seasonal_phen_cd
                 FROM d_plant_seasonal_phen phen, plant_cas_seas_phen cas_sp', ' WHERE cas_sp.d_plant_phen_season_id = 24
  		           AND phen.d_plant_seasonal_phen_id = cas_sp.d_plant_seasonal_phen_id
  		           AND cas_sp.element_subnational_id =', est.element_subnational_id), ','::TEXT), 1, 8) AS dec_b,
    /* Now get habitat and phenology comment fields */
    shared.delimlist(CONCAT_WS('', 'SELECT DBMS_LOB.SUBSTR(ca.g_habitat_com,4000,1)', 'FROM plant_cag ca, element_national ent, element_subnational es ', 'WHERE ca.element_global_id = ent.element_global_id
                 AND ent.element_national_id = es.element_national_id
                 AND es.element_subnational_id =', est.element_subnational_id), ','::TEXT) AS global_habitat_comments, shared.delimlist(CONCAT_WS('', 'SELECT DBMS_LOB.SUBSTR(ca.s_habitat_com,4000,1)
                 FROM plant_cas ca ', 'WHERE ca.element_subnational_id =', est.element_subnational_id), ','::TEXT) AS state_habitat_comments, NULL AS global_phenology_comments, /* plants don't have g_phenology_com */ shared.delimlist(CONCAT_WS('', 'SELECT ca.s_phenology_com FROM plant_cas ca ', 'WHERE ca.element_subnational_id =', est.element_subnational_id), ','::TEXT) AS state_phenology_comments,
    /* Finally, get lists of specific communities for the element, according to major community type */
    LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.estuarine_habitat_desc
         FROM d_estuarine_habitat dom, Plant_cas_estuarine_hab hab', ' WHERE dom.d_estuarine_habitat_id = hab.d_estuarine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS estuarine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.marine_habitat_desc
         FROM d_marine_habitat dom, Plant_cas_marine_hab hab', ' WHERE dom.d_marine_habitat_id = hab.d_marine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS marine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.riverine_habitat_desc
         FROM d_riverine_habitat dom, Plant_cas_riverine_hab hab', ' WHERE dom.d_riverine_habitat_id = hab.d_riverine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS riverine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.lacustrine_habitat_desc
         FROM d_lacustrine_habitat dom, Plant_cas_lacus_hab hab', ' WHERE dom.d_lacustrine_habitat_id = hab.d_lacustrine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS lacustrine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.palustrine_habitat_desc
         FROM d_palustrine_habitat dom, Plant_cas_palus_hab hab', ' WHERE dom.d_palustrine_habitat_id = hab.d_palustrine_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS palustrine, LOWER(shared.delimlist(CONCAT_WS('', 'SELECT dom.terrestrial_habitat_desc
         FROM d_terrestrial_habitat dom, Plant_cas_terr_hab hab', ' WHERE dom.d_terrestrial_habitat_id = hab.d_terrestrial_habitat_id AND
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT)) AS terrestrial, NULL AS subterranean /* no subterranean plants */
    FROM core.element_subnational AS est
    WHERE oracle.substr(ext.elcode(est.element_subnational_id), 1, 1) IN ('P', 'N') AND est.d_eo_track_status_id = 1
    ORDER BY sort_order, sname;


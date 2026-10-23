CREATE OR REPLACE  VIEW ext.tracking_report_view (element_id, element_tp, scientific_name, comm_name, rankstring, natural_communities, habitat_com) AS
SELECT
    est.element_subnational_id AS element_id, oracle.substr(egt.elcode_bcd, 1, 2) AS element_tp,
    /* substr(sn.scientific_name,1,70) sci_name, */
    sn.scientific_name, oracle.substr(est.s_primary_common_name, 1, 70) AS comm_name, CONCAT_WS('', oracle.substr(egt.g_rank, 1, LENGTH(egt.g_rank)), '/', oracle.substr(est.s_rank, 1, LENGTH(est.s_rank)), '/',
    CASE
        WHEN shared.est_usesa(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(shared.est_usesa(est.element_subnational_id), 1, LENGTH(shared.est_usesa(est.element_subnational_id)))
    END, '/',
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, LENGTH(est.s_protection_status))
    END) AS rankstring, LOWER(CONCAT_WS('', shared.delimlist(CONCAT_WS('', 'SELECT dom.estuarine_habitat_desc 
         FROM d_estuarine_habitat dom, Animal_cas_estuarine_hab hab', ' WHERE dom.d_estuarine_habitat_id = hab.d_estuarine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.estuarine_habitat_desc 
         FROM d_estuarine_habitat dom, Animal_cas_estuarine_hab hab', ' WHERE dom.d_estuarine_habitat_id = hab.d_estuarine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.marine_habitat_desc 
         FROM d_marine_habitat dom, Animal_cas_marine_hab hab', ' WHERE dom.d_marine_habitat_id = hab.d_marine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.marine_habitat_desc 
         FROM d_marine_habitat dom, Animal_cas_marine_hab hab', ' WHERE dom.d_marine_habitat_id = hab.d_marine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.riverine_habitat_desc 
         FROM d_riverine_habitat dom, Animal_cas_riverine_hab hab', ' WHERE dom.d_riverine_habitat_id = hab.d_riverine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.riverine_habitat_desc 
         FROM d_riverine_habitat dom, Animal_cas_riverine_hab hab', ' WHERE dom.d_riverine_habitat_id = hab.d_riverine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.lacustrine_habitat_desc 
         FROM d_lacustrine_habitat dom, Animal_cas_lacus_hab hab', ' WHERE dom.d_lacustrine_habitat_id = hab.d_lacustrine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.lacustrine_habitat_desc 
         FROM d_lacustrine_habitat dom, Animal_cas_lacus_hab hab', ' WHERE dom.d_lacustrine_habitat_id = hab.d_lacustrine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.palustrine_habitat_desc 
         FROM d_palustrine_habitat dom, Animal_cas_palus_hab hab', ' WHERE dom.d_palustrine_habitat_id = hab.d_palustrine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.palustrine_habitat_desc 
         FROM d_palustrine_habitat dom, Animal_cas_palus_hab hab', ' WHERE dom.d_palustrine_habitat_id = hab.d_palustrine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.terrestrial_habitat_desc 
         FROM d_terrestrial_habitat dom, Animal_cas_terr_hab hab', ' WHERE dom.d_terrestrial_habitat_id = hab.d_terrestrial_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.terrestrial_habitat_desc 
         FROM d_terrestrial_habitat dom, Animal_cas_terr_hab hab', ' WHERE dom.d_terrestrial_habitat_id = hab.d_terrestrial_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.subterranean_habitat_desc 
         FROM d_subterranean_habitat dom, Animal_cas_subterr_hab hab', ' WHERE dom.d_subterranean_habitat_id = hab.d_subterranean_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT))::TEXT) AS natural_communities, oracle.substr(lob_loc => cas.s_habitat_com, amount => 4000, "offset" => 1) AS habitat_com
    FROM core.element_global AS egt, core.element_national AS ent, core.scientific_name AS sn, core.element_subnational AS est
    LEFT OUTER JOIN core.animal_cas AS cas
        ON (est.element_subnational_id = cas.element_subnational_id)
    WHERE est.element_national_id = ent.element_national_id AND ent.element_global_id = egt.element_global_id AND est.sname_id = sn.scientific_name_id AND oracle.substr(egt.elcode_bcd, 1, 1) IN ('A', 'I') AND
    /* (it's animal) */
    est.d_eo_track_status_id = 1
/* (it's a tracked species, i.e.track all extant and selected historical EOs) */
UNION
SELECT
    est.element_subnational_id AS element_id, oracle.substr(egt.elcode_bcd, 1, 2) AS element_tp, oracle.substr(sn.scientific_name, 1, 80) AS sci_name, oracle.substr(est.s_primary_common_name, 1, 80) AS comm_name, CONCAT_WS('', oracle.substr(egt.g_rank, 1, LENGTH(egt.g_rank)), '/', oracle.substr(est.s_rank, 1, LENGTH(est.s_rank)), '/',
    CASE
        WHEN shared.est_usesa(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(shared.est_usesa(est.element_subnational_id), 1, LENGTH(shared.est_usesa(est.element_subnational_id)))
    END, '/',
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, LENGTH(est.s_protection_status))
    END) AS rankstring, LOWER(CONCAT_WS('', shared.delimlist(CONCAT_WS('', 'SELECT dom.estuarine_habitat_desc 
         FROM d_estuarine_habitat dom, Plant_cas_estuarine_hab hab', ' WHERE dom.d_estuarine_habitat_id = hab.d_estuarine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.estuarine_habitat_desc 
         FROM d_estuarine_habitat dom, Plant_cas_estuarine_hab hab', ' WHERE dom.d_estuarine_habitat_id = hab.d_estuarine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.marine_habitat_desc 
         FROM d_marine_habitat dom, Plant_cas_marine_hab hab', ' WHERE dom.d_marine_habitat_id = hab.d_marine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.marine_habitat_desc 
         FROM d_marine_habitat dom, Plant_cas_marine_hab hab', ' WHERE dom.d_marine_habitat_id = hab.d_marine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.riverine_habitat_desc 
         FROM d_riverine_habitat dom, Plant_cas_riverine_hab hab', ' WHERE dom.d_riverine_habitat_id = hab.d_riverine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.riverine_habitat_desc 
         FROM d_riverine_habitat dom, Plant_cas_riverine_hab hab', ' WHERE dom.d_riverine_habitat_id = hab.d_riverine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.lacustrine_habitat_desc 
         FROM d_lacustrine_habitat dom, Plant_cas_lacus_hab hab', ' WHERE dom.d_lacustrine_habitat_id = hab.d_lacustrine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.lacustrine_habitat_desc 
         FROM d_lacustrine_habitat dom, Plant_cas_lacus_hab hab', ' WHERE dom.d_lacustrine_habitat_id = hab.d_lacustrine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.palustrine_habitat_desc 
         FROM d_palustrine_habitat dom, Plant_cas_palus_hab hab', ' WHERE dom.d_palustrine_habitat_id = hab.d_palustrine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT),
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT dom.palustrine_habitat_desc 
         FROM d_palustrine_habitat dom, Plant_cas_palus_hab hab', ' WHERE dom.d_palustrine_habitat_id = hab.d_palustrine_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT) IS NULL THEN NULL
        ELSE '; '
    END, shared.delimlist(CONCAT_WS('', 'SELECT dom.terrestrial_habitat_desc 
         FROM d_terrestrial_habitat dom, Plant_cas_terr_hab hab', ' WHERE dom.d_terrestrial_habitat_id = hab.d_terrestrial_habitat_id AND 
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT))::TEXT) AS natural_communities, oracle.substr(lob_loc => cas.s_habitat_com, amount => 4000, "offset" => 1) AS habitat_com
    FROM core.element_global AS egt, core.element_national AS ent, core.scientific_name AS sn, core.plant_cas AS cas
    RIGHT OUTER JOIN core.element_subnational AS est
        ON (est.element_subnational_id = cas.element_subnational_id)
    WHERE est.element_national_id = ent.element_national_id AND ent.element_global_id = egt.element_global_id AND est.sname_id = sn.scientific_name_id AND oracle.substr(egt.elcode_bcd, 1, 1) IN ('P', 'N') AND
    /* (it's plant or lichen) */
    est.d_eo_track_status_id = 1
/* (it's a tracked species, i.e.track all extant and selected historical EOs) */
UNION
SELECT
    est.element_subnational_id AS element_id, oracle.substr(egt.elcode_bcd, 1, 2) AS element_tp, oracle.substr(sn.scientific_name, 1, 70) AS sci_name, oracle.substr(est.s_primary_common_name, 1, 70) AS comm_name, CONCAT_WS('', oracle.substr(egt.g_rank, 1, LENGTH(egt.g_rank)), '/', oracle.substr(est.s_rank, 1, LENGTH(est.s_rank)), '/', 'NA', '/', 'NA') AS rankstring, 'NA' AS natural_communities, 'NA' AS habitat_com
    FROM core.element_subnational AS est, core.element_global AS egt, core.element_national AS ent, core.scientific_name AS sn
    WHERE est.element_national_id = ent.element_national_id AND ent.element_global_id = egt.element_global_id AND est.sname_id = sn.scientific_name_id AND oracle.substr(egt.elcode_bcd, 1, 1) IN ('C', 'O', 'G') AND
    /* (it's other elements) */
    est.d_eo_track_status_id = 1;


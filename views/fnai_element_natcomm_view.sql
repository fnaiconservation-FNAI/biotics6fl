CREATE OR REPLACE  VIEW ext.fnai_element_natcomm_view (element_id, sortorder, element_tp, sci_name, comm_name, natural_communities, habitat_com) AS
SELECT
    est.element_subnational_id AS element_id, ext.elgroup_sort_order(est.element_subnational_id) AS sortorder, ext.elgroup_name(est.element_subnational_id) AS element_tp, ext.sci_name(est.element_subnational_id) AS sci_name, ext.comm_name(est.element_subnational_id) AS comm_name, LOWER(CONCAT_WS('', shared.delimlist(CONCAT_WS('', 'SELECT dom.estuarine_habitat_desc 
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
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT))::TEXT) AS natural_communities, oracle.substr(lob_loc => cag.g_habitat_com, amount => 4000, "offset" => 1) AS habitat_com
    FROM core.element_subnational AS est, core.element_national AS ent, core.element_global AS egt
    LEFT OUTER JOIN core.animal_cag AS cag
        ON (egt.element_global_id = cag.element_global_id)
    WHERE est.element_national_id = ent.element_national_id AND ent.element_global_id = egt.element_global_id AND oracle.substr(egt.elcode_bcd, 1, 1) IN ('A', 'I')
/* (it's animal) */
/* and est.d_eo_track_status_id = 1 */
/* (it's a tracked species, i.e.track all extant and selected historical EOs) */
UNION /* now get the plants */
SELECT
    est.element_subnational_id AS element_id, ext.elgroup_sort_order(est.element_subnational_id) AS sortorder, ext.elgroup_name(est.element_subnational_id) AS element_tp, ext.sci_name(est.element_subnational_id) AS sci_name, ext.comm_name(est.element_subnational_id) AS comm_name, LOWER(CONCAT_WS('', shared.delimlist(CONCAT_WS('', 'SELECT dom.estuarine_habitat_desc 
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
  		   hab.element_subnational_id=', est.element_subnational_id), ', '::TEXT))::TEXT) AS natural_communities, oracle.substr(lob_loc => cag.g_habitat_com, amount => 4000, "offset" => 1) AS habitat_com
    FROM core.element_subnational AS est, core.element_national AS ent, core.plant_cag AS cag
    RIGHT OUTER JOIN core.element_global AS egt
        ON (egt.element_global_id = cag.element_global_id)
    WHERE est.element_national_id = ent.element_national_id AND ent.element_global_id = egt.element_global_id AND oracle.substr(egt.elcode_bcd, 1, 1) IN ('P', 'N')
/* (it's plant or lichen) */
/* and est.d_eo_track_status_id = 1 */
UNION /* now get NCs, geols, and others */
SELECT
    est.element_subnational_id AS element_id, ext.elgroup_sort_order(est.element_subnational_id) AS sortorder, ext.elgroup_name(est.element_subnational_id) AS element_tp, ext.sci_name(est.element_subnational_id) AS sci_name, 'n/a' AS comm_name, 'n/a' AS natural_communities, 'n/a' AS habitat_com
    FROM core.element_subnational AS est
    WHERE oracle.substr(ext.elcode(est.element_subnational_id), 1, 1) IN ('C', 'G', 'O')
    /* (it's NC, geol, or other) */
    /* and est.d_eo_track_status_id = 1 */
    ORDER BY sortorder, element_tp;


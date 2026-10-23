CREATE OR REPLACE  VIEW ext.fnai_plant_hab_view (tbl, pk, d_hab_id, habitat_desc, element_subnational_id, rec_last_mod_user, rec_last_mod_date, rec_create_date, rec_create_user, display_order) AS
SELECT
    tbl, plant_cas_terr_hab_id AS pk, d_terrestrial_habitat_id AS d_hab_id, habitat_desc, element_subnational_id, rec_last_mod_user, rec_last_mod_date, rec_create_date, rec_create_user, display_order
    FROM (SELECT
        'PLANT_CAS_TERR_HAB' AS tbl, h.*, d.terrestrial_habitat_desc AS habitat_desc
        FROM core.plant_cas_terr_hab AS h
        JOIN domain.d_terrestrial_habitat AS d
            ON h.d_terrestrial_habitat_id = d.d_terrestrial_habitat_id
        WHERE d.terrestrial_habitat_desc = UPPER(d.terrestrial_habitat_desc)
    UNION
    SELECT
        'PLANT_CAS_PALUS_HAB' AS tbl, h.*, d.palustrine_habitat_desc AS habitat_desc
        FROM core.plant_cas_palus_hab AS h
        JOIN domain.d_palustrine_habitat AS d
            ON h.d_palustrine_habitat_id = d.d_palustrine_habitat_id
        WHERE d.palustrine_habitat_desc = UPPER(d.palustrine_habitat_desc)
    UNION
    SELECT
        'PLANT_CAS_LACUS_HAB' AS tbl, h.*, d.lacustrine_habitat_desc AS habitat_desc
        FROM core.plant_cas_lacus_hab AS h
        JOIN domain.d_lacustrine_habitat AS d
            ON h.d_lacustrine_habitat_id = d.d_lacustrine_habitat_id
        WHERE d.lacustrine_habitat_desc = UPPER(d.lacustrine_habitat_desc)
    UNION
    SELECT
        'PLANT_CAS_RIVERINE_HAB' AS tbl, h.*, d.riverine_habitat_desc AS habitat_desc
        FROM core.plant_cas_riverine_hab AS h
        JOIN domain.d_riverine_habitat AS d
            ON h.d_riverine_habitat_id = d.d_riverine_habitat_id
        WHERE d.riverine_habitat_desc = UPPER(d.riverine_habitat_desc)
    UNION
    SELECT
        'PLANT_CAS_ESTUARINE_HAB' AS tbl, h.*, d.estuarine_habitat_desc AS habitat_desc
        FROM core.plant_cas_estuarine_hab AS h
        JOIN domain.d_estuarine_habitat AS d
            ON h.d_estuarine_habitat_id = d.d_estuarine_habitat_id
        WHERE d.estuarine_habitat_desc = UPPER(d.estuarine_habitat_desc)
    UNION
    SELECT
        'MARINE_HABITAT_DESC' AS tbl, h.*, d.marine_habitat_desc AS habitat_desc
        FROM core.plant_cas_marine_hab AS h
        JOIN domain.d_marine_habitat AS d
            ON h.d_marine_habitat_id = d.d_marine_habitat_id
        WHERE d.marine_habitat_desc = UPPER(d.marine_habitat_desc)) AS var_sbq
    WHERE UPPER(habitat_desc) = habitat_desc;


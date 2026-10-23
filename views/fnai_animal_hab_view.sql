CREATE OR REPLACE  VIEW ext.fnai_animal_hab_view (tbl, pk, d_hab_id, habitat_desc, element_subnational_id, rec_last_mod_user, rec_last_mod_date, rec_create_date, rec_create_user, display_order) AS
SELECT
    tbl, animal_cas_terr_hab_id AS pk, d_terrestrial_habitat_id AS d_hab_id, habitat_desc, element_subnational_id, rec_last_mod_user, rec_last_mod_date, rec_create_date, rec_create_user, display_order
    FROM (SELECT
        'ANIMAL_CAS_TERR_HAB' AS tbl, h.*, d.terrestrial_habitat_desc AS habitat_desc
        FROM core.animal_cas_terr_hab AS h
        JOIN domain.d_terrestrial_habitat AS d
            ON h.d_terrestrial_habitat_id = d.d_terrestrial_habitat_id
    /* WHERE d.TERRESTRIAL_HABITAT_DESC = UPPER(d.TERRESTRIAL_HABITAT_DESC) */
    UNION
    SELECT
        'ANIMAL_CAS_PALUS_HAB' AS tbl, h.*, d.palustrine_habitat_desc AS habitat_desc
        FROM core.animal_cas_palus_hab AS h
        JOIN domain.d_palustrine_habitat AS d
            ON h.d_palustrine_habitat_id = d.d_palustrine_habitat_id
    /* WHERE d.PALUSTRINE_HABITAT_DESC = UPPER(d.PALUSTRINE_HABITAT_DESC) */
    UNION
    SELECT
        'ANIMAL_CAS_LACUS_HAB' AS tbl, h.*, d.lacustrine_habitat_desc AS habitat_desc
        FROM core.animal_cas_lacus_hab AS h
        JOIN domain.d_lacustrine_habitat AS d
            ON h.d_lacustrine_habitat_id = d.d_lacustrine_habitat_id
    /* WHERE d.LACUSTRINE_HABITAT_DESC = UPPER(d.LACUSTRINE_HABITAT_DESC) */
    UNION
    SELECT
        'ANIMAL_CAS_RIVERINE_HAB' AS tbl, h.*, d.riverine_habitat_desc AS habitat_desc
        FROM core.animal_cas_riverine_hab AS h
        JOIN domain.d_riverine_habitat AS d
            ON h.d_riverine_habitat_id = d.d_riverine_habitat_id
    /* WHERE d.RIVERINE_HABITAT_DESC = UPPER(d.RIVERINE_HABITAT_DESC) */
    UNION
    SELECT
        'ANIMAL_CAS_ESTUARINE_HAB' AS tbl, h.*, d.estuarine_habitat_desc AS habitat_desc
        FROM core.animal_cas_estuarine_hab AS h
        JOIN domain.d_estuarine_habitat AS d
            ON h.d_estuarine_habitat_id = d.d_estuarine_habitat_id
    /* WHERE d.ESTUARINE_HABITAT_DESC = UPPER(d.ESTUARINE_HABITAT_DESC) */
    UNION
    SELECT
        'MARINE_HABITAT_DESC' AS tbl, h.*, d.marine_habitat_desc AS habitat_desc
        FROM core.animal_cas_marine_hab AS h
        JOIN domain.d_marine_habitat AS d
            ON h.d_marine_habitat_id = d.d_marine_habitat_id
    /* WHERE d.MARINE_HABITAT_DESC = UPPER(d.MARINE_HABITAT_DESC) */
    UNION
    SELECT
        'SPECIAL_HAB_FACTOR' AS tbl, a.*, d.special_hab_factor_desc AS habitat_desc
        FROM core.animal_can_spec_factor AS a
        JOIN domain.d_special_hab_factor AS d
            ON d.d_special_hab_factor_id = a.d_special_hab_factor_id
        LEFT OUTER JOIN core.element_subnational AS est
            ON a.element_national_id = est.element_national_id
        WHERE element_subnational_id IS NOT NULL) AS var_sbq
/* WHERE UPPER(HABITAT_DESC) = HABITAT_DESC */
;


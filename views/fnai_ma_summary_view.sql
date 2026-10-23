CREATE OR REPLACE  VIEW ext.fnai_ma_summary_view (managed_area_id, managed_area_name, element_id, sort_order, element_group, sci_name, comm_name, grank, srank, federal, state, eo_id) AS
SELECT
    core.ma.managed_area_id, oracle.substr(core.ma.managed_area_name, 1, 100) AS managed_area_name, est.element_subnational_id AS element_id,
    CASE
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AF' THEN '1'
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AA' THEN '2'
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AR' THEN '3'
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AB' THEN '4'
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AM' THEN '5'
        WHEN oracle.substr(egt.elcode_bcd, 1, 1) = 'I' THEN '6'
        WHEN oracle.substr(egt.elcode_bcd, 1, 1) = 'P' THEN '7'
        WHEN oracle.substr(egt.elcode_bcd, 1, 1) = 'C' THEN '8'
        ELSE '9'
    END AS sort_order,
    CASE
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AF' THEN 'FISH'
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AA' THEN 'AMPHIBIANS'
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AR' THEN 'REPTILES'
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AB' THEN 'BIRDS'
        WHEN oracle.substr(egt.elcode_bcd, 1, 2) = 'AM' THEN 'MAMMALS'
        WHEN oracle.substr(egt.elcode_bcd, 1, 1) = 'I' THEN 'INVERTEBRATES'
        WHEN oracle.substr(egt.elcode_bcd, 1, 1) = 'P' THEN 'PLANTS'
        WHEN oracle.substr(egt.elcode_bcd, 1, 1) = 'C' THEN 'NATURAL COMMUNITIES'
        ELSE 'OTHER ELEMENTS'
    END AS element_group, oracle.substr(sn.scientific_name, 1, 70) AS sci_name, oracle.substr(est.s_primary_common_name, 1, 70) AS comm_name, oracle.substr(egt.g_rank, 1, 12) AS grank, oracle.substr(est.s_rank, 1, 12) AS srank,
    CASE
        WHEN shared.est_usesa(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(shared.est_usesa(est.element_subnational_id), 1, 12)
    END AS federal,
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, 12)
    END AS state, eo.eo_id
    FROM core.element_subnational AS est, core.element_global AS egt, core.element_national AS ent, core.scientific_name AS sn, core.eo AS eo, core.eo_managed_area AS eoma, core.ma
    WHERE eo.eo_id = eoma.eo_id AND eo.principal_eo_shape_id IS NULL AND /* include principal EOs only */ core.ma.managed_area_id = eoma.managed_area_id AND
    /* the managed area is right */
    eo.element_subnational_id = est.element_subnational_id AND est.d_eo_track_status_id = 1 AND
    /* (it's a tracked species, i.e.track all extant and selected historical EOs) */
    est.element_national_id = ent.element_national_id AND ent.element_global_id = egt.element_global_id AND est.sname_id = sn.scientific_name_id
    ORDER BY sort_order;


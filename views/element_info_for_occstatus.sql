CREATE OR REPLACE  VIEW ext.element_info_for_occstatus (sci_name, comm_name, eltype, grank, srank, federal, state) AS
SELECT
    ext.sci_name(est.element_subnational_id) AS sci_name, ext.comm_name(est.element_subnational_id) AS comm_name,
    CASE
        WHEN oracle.substr(ext.elcode(est.element_subnational_id), 1, 1) = 'A' THEN 'Animals'
        WHEN oracle.substr(ext.elcode(est.element_subnational_id), 1, 1) = 'I' THEN
        CASE
            WHEN oracle.substr(ext.elcode(est.element_subnational_id), 1, 2) IN ('II', 'IL') THEN 'Inverts-insects'
            ELSE 'Inverts-other'
        END
        WHEN oracle.substr(ext.elcode(est.element_subnational_id), 1, 1) IN ('P', 'N') THEN 'Plants'
        WHEN ext.elcode(est.element_subnational_id) LIKE 'C%' THEN 'Nat. community'
        WHEN ext.elcode(est.element_subnational_id) LIKE 'G%' THEN 'Geological feature'
        ELSE 'Other elements'
    END AS eltype, ext.grank(est.element_subnational_id) AS grank, est.s_rank AS srank,
    CASE
        WHEN shared.est_usesa(est.element_subnational_id) IS NULL THEN 'N'
        ELSE oracle.substr(shared.est_usesa(est.element_subnational_id), 1, 8)
    END AS federal,
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, 8)
    END AS state
    FROM core.element_subnational AS est
    WHERE d_eo_track_status_id IN (1, 2);


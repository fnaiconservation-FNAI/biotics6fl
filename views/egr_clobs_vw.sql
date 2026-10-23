CREATE OR REPLACE  VIEW ext.egr_clobs_vw (element_global_id, element_global_ou_uid, element_global_seq_uid, elcode_bcd, g_range_com_trunc, g_threat_com_trunc, g_other_rank_consid_com_trunc, g_research_needs_trunc, version_date, rec_last_mod_date, rec_last_mod_user, rec_create_date, rec_create_user) AS
SELECT
    eg.element_global_id, eg.element_global_ou_uid, eg.element_global_seq_uid, eg.elcode_bcd, oracle.to_char(oracle.substr(egr.g_range_com, 1, 4000)) AS g_range_com_trunc, oracle.to_char(oracle.substr(egr.g_threat_com, 1, 4000)) AS g_threat_com_trunc, oracle.to_char(oracle.substr(egr.g_other_rank_consid_com, 1, 4000)) AS g_other_rank_consid_com_trunc, oracle.to_char(oracle.substr(egr.g_research_needs, 1, 4000)) AS g_research_needs_trunc, egr.version_date, egr.rec_last_mod_date, egr.rec_last_mod_user, egr.rec_create_date, egr.rec_create_user
    FROM core.element_global AS eg, core.element_global_rank AS egr
    WHERE eg.element_global_id = egr.element_global_id;


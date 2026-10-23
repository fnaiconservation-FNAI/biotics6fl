CREATE OR REPLACE  VIEW ext.element_global_clobs_vw (element_global_id, element_global_ou_uid, element_global_seq_uid, elcode_bcd, g_classif_com_trunc, rec_last_mod_date, rec_last_mod_user, rec_create_date, rec_create_user) AS
SELECT
    element_global_id, element_global_ou_uid, element_global_seq_uid, elcode_bcd, oracle.to_char(oracle.substr(g_classification_com, 1, 4000)) AS g_classif_com_trunc, rec_last_mod_date, rec_last_mod_user, rec_create_date, rec_create_user
    FROM core.element_global;


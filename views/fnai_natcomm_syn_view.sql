CREATE OR REPLACE  VIEW ext.fnai_natcomm_syn_view (est_id, sname, synonyms) AS
SELECT
    est.element_subnational_id AS est_id, oracle.substr(sn.scientific_name, 1, 30) AS sname,
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT comn.other_sub_common_name FROM other_sub_common_name comn', ' WHERE comn.element_subnational_id = ', est.element_subnational_id), ', '::TEXT) IS NULL THEN 'no synonyms listed'
        ELSE shared.delimlist(CONCAT_WS('', 'SELECT comn.other_sub_common_name FROM other_sub_common_name comn', ' WHERE comn.element_subnational_id = ', est.element_subnational_id), ', '::TEXT)
    END AS synonyms
    FROM core.element_subnational AS est, core.element_global AS egt, core.element_national AS ent, core.scientific_name AS sn
    WHERE sn.scientific_name_id = est.sname_id AND egt.elcode_bcd LIKE 'C%' AND ent.element_global_id = egt.element_global_id AND est.element_national_id = ent.element_national_id AND est.d_eo_track_status_id = 1 /* tracked elements only */;


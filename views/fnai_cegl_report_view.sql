CREATE OR REPLACE  VIEW ext.fnai_cegl_report_view (element_global_id, elcode_bcd, sci_name, translated_name, g_primary_common_name, element_summary, classification_com) AS
SELECT
    egt.element_global_id, egt.elcode_bcd, sn.scientific_name AS sci_name, sn.translated_name, egt.g_primary_common_name, oracle.substr(lob_loc => cg.g_element_summary, amount => 2000, "offset" => 1) AS element_summary, oracle.substr(lob_loc => egt.g_classification_com, amount => 2000, "offset" => 1) AS classification_com
    FROM core.element_global AS egt, core.scientific_name AS sn, core.community_global AS cg
    WHERE egt.elcode_bcd IN (SELECT DISTINCT
        (replace(oracle.substr(eof.tnc_assoc, 1, 10), 'CEFL', 'CEGL'))
        FROM core.eo AS eo, ext.eo_flext1 AS eof
        WHERE eo.eo_id = eof.eo_id AND eof.tnc_assoc IS NOT NULL) AND
    /*
    (select egt1.elcode_bcd from element_global egt1,
    element_global egt2
    where egt1.elcode_bcd = replace(egt2.elcode_bcd,'CEFL','CEGL')
    and egt2.elcode_bcd like '%CEFL%')  left from a previous run
    */
    sn.scientific_name_id = egt.gname_id AND cg.element_global_id = egt.element_global_id
    /* and rownum < 2 */
    ORDER BY egt.elcode_bcd;


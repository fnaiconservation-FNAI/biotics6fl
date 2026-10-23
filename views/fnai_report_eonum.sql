CREATE OR REPLACE  VIEW ext.fnai_report_eonum (eo_id, sname, eo_num, rpt_eonum) AS
SELECT
    core.eo.eo_id, ext.sci_name(core.eo.eo_id) AS sname, core.eo.eo_num, ext.report_eonum(core.eo.eo_id) AS rpt_eonum
    FROM core.eo;


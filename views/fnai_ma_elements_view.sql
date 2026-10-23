CREATE OR REPLACE  VIEW ext.fnai_ma_elements_view (managed_area_id, ma_name, element_id, sname, com_name) AS
SELECT
    core.ma.managed_area_id, MAX(oracle.substr(core.ma.managed_area_name, 1, 150)) AS ma_name, est.element_subnational_id AS element_id, MAX(ext.sci_name(est.element_subnational_id)) AS sname, MAX(ext.comm_name(est.element_subnational_id)) AS com_name
    FROM core.element_subnational AS est, core.ma, core.eo, core.eo_managed_area AS eoma
    WHERE core.ma.managed_area_id = eoma.managed_area_id AND core.eo.eo_id = eoma.eo_id AND core.eo.element_subnational_id = est.element_subnational_id AND est.d_eo_track_status_id = 1
    GROUP BY core.ma.managed_area_id, est.element_subnational_id;


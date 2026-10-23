CREATE OR REPLACE  VIEW ext.fnai_eo_update_nomaplabel (elcode_bcd, eo_id, feature_id, sci_name, eo_num, last_obs, eo_rank, eo_rank_date, county, quadname, managed_area) AS
SELECT
    egt.elcode_bcd, eo.eo_id AS eo_id, eo.shape_id AS feature_id, oracle.substr(sn.scientific_name, 1, 60) AS sci_name, eo.eo_num, oracle.substr(eo.last_obs_date, 1, 20) AS last_obs, rank.basic_eo_rank_cd AS eo_rank, eo_rank_date, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT D_COUNTY.county_name FROM D_COUNTY, eo_COUNTY', ' WHERE D_COUNTY.d_county_id = eo_COUNTY.d_county_id AND
  		   eo_COUNTY.eo_id=', eo.eo_id), ','::TEXT), 1, 100) AS county, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT D_mapsheet.mapsheet_name FROM D_mapsheet, eo_mapsheet', ' WHERE D_mapsheet.d_mapsheet_id = eo_mapsheet.d_mapsheet_id AND
  		   eo_mapsheet.eo_id=', eo.eo_id), ','::TEXT), 1, 150) AS quadname, shared.delimlist(CONCAT_WS('', 'SELECT ma.managed_area_name FROM ma, EO_managed_area', ' WHERE ma.managed_area_id = EO_managed_area.managed_area_id
  		        AND EO_managed_area.eo_id=', eo.eo_id), ','::TEXT) AS managed_area
    FROM core.element_national AS ent, core.element_global AS egt, core.scientific_name AS sn, core.element_subnational AS est, core.eo AS eo
    LEFT OUTER JOIN domain.d_basic_eo_rank AS rank
        ON (eo.d_basic_eo_rank_id = rank.d_basic_eo_rank_id)
    WHERE egt.element_global_id = ent.element_global_id AND ent.element_national_id = est.element_national_id AND eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id;


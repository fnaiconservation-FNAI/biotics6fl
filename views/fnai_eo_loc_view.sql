CREATE OR REPLACE  VIEW ext.fnai_eo_loc_view (element_id, eo_id, sci_name, eo_num, eo_rank, rank_descr, first_obs, last_obs, latitude, longitude, county, quadname, trs, managed_area, directions, eo_data, general_description, nbr_of_sources, negligible_uncertainty, acreage, bestsource) AS
SELECT
    est.element_subnational_id AS element_id, eo.eo_id AS eo_id, oracle.substr(sn.scientific_name, 1, 60) AS sci_name, ext.report_eonum(eo.eo_id) AS eo_num, rnk.basic_eo_rank_cd AS eo_rank, rnk.basic_eo_rank_desc AS rank_descr, oracle.substr(eo.first_obs_date, 1, 20) AS first_obs, oracle.substr(eo.last_obs_date, 1, 20) AS last_obs, LPAD(eo.latitude, 8, ' ') AS latitude, LPAD(eo.longitude, 9, ' ') AS longitude, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT D_COUNTY.county_name FROM D_COUNTY, eo_COUNTY', ' WHERE D_COUNTY.d_county_id = eo_COUNTY.d_county_id AND
  		   eo_COUNTY.eo_id=', eo.eo_id), ','::TEXT), 1, 100) AS county, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT D_mapsheet.mapsheet_name FROM D_mapsheet, eo_mapsheet', ' WHERE D_mapsheet.d_mapsheet_id = eo_mapsheet.d_mapsheet_id AND
  		   eo_mapsheet.eo_id=', eo.eo_id), ','::TEXT), 1, 150) AS quadname, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT eo_trs.town_range || ''-'' || eo_trs.section
     	   FROM eo_trs ', ' WHERE eo_trs.eo_id=', eo.eo_id), ','::TEXT), 1, 150) AS trs, shared.delimlist(CONCAT_WS('', 'SELECT ma.managed_area_name FROM ma, EO_managed_area', ' WHERE ma.managed_area_id = EO_managed_area.managed_area_id
  		        AND EO_managed_area.eo_id=', eo.eo_id), ','::TEXT) AS managed_area, eo.directions AS directions, oracle.substr(lob_loc => eo.eo_data, amount => 4000, "offset" => 1) AS eo_data, oracle.substr(lob_loc => eo.gen_desc, amount => 4000, "offset" => 1) AS general_description, shared.delimlist(CONCAT_WS('', 'SELECT count(*) from eo_source_feature eosf where ', 'eosf.eo_shape_id = ', eo.shape_id), NULL::TEXT) AS nbr_of_sources,
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT sf.shape_id from source_feature sf, ', 'eo_source_feature eosf where sf.d_loc_uncertainty_type_id = 1', ' and eosf.source_feature_shape_id = ', 'sf.shape_id and eosf.eo_shape_id = ', eo.shape_id), ','::TEXT) IS NULL THEN 'NO'
        ELSE 'YES'
    END AS negligible_uncertainty, ROUND(oracle.to_number(sa.attribute_value), 1) AS acreage,
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT erf.eo_reference_primary_ind FROM eo_reference erf', ' WHERE erf.eo_id =', eo.eo_id), ','::TEXT) IS NULL THEN 'ZZ'
        ELSE
        CASE
            WHEN oracle.INSTR(shared.delimlist(CONCAT_WS('', 'SELECT erf.eo_reference_primary_ind FROM
  		                     eo_reference erf', ' WHERE erf.eo_id(+) =', eo.eo_id), ','::TEXT), 'Y', 1, 1) = 0 THEN 'ZZ'
            ELSE oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT rf.full_citation FROM reference rf,
                           eo_reference erf', ' WHERE erf.eo_reference_primary_ind = ''Y''
                           and rf.reference_id = erf.reference_id and erf.eo_id(+) =', eo.eo_id), ','::TEXT), 1, 254)
        END
    END AS bestsource
    FROM core.scientific_name AS sn, core.element_subnational AS est, core.spatial_attribute AS sa, core.eo AS eo
    LEFT OUTER JOIN domain.d_basic_eo_rank AS rnk
        ON (eo.d_basic_eo_rank_id = rnk.d_basic_eo_rank_id)
    WHERE sa.attribute_name = 'ACREAGE' AND sa.feature_id = eo.shape_id AND eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id;


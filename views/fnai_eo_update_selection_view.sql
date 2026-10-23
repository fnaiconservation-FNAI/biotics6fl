CREATE OR REPLACE  VIEW ext.fnai_eo_update_selection_view (eo_id, feature_id, sci_name, eo_num, last_obs, eo_rank, eo_rank_date, county, quadname, managed_area, maplabel) AS
SELECT
    eo.eo_id AS eo_id, eo.shape_id AS feature_id, oracle.substr(sn.scientific_name, 1, 60) AS sci_name, eo.eo_num, oracle.substr(eo.last_obs_date, 1, 20) AS last_obs, rank.basic_eo_rank_cd AS eo_rank, eo_rank_date, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT D_COUNTY.county_name FROM D_COUNTY, eo_COUNTY', ' WHERE D_COUNTY.d_county_id = eo_COUNTY.d_county_id AND
  		   eo_COUNTY.eo_id=', eo.eo_id), ','::TEXT), 1, 100) AS county, oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT D_mapsheet.mapsheet_name FROM D_mapsheet, eo_mapsheet', ' WHERE D_mapsheet.d_mapsheet_id = eo_mapsheet.d_mapsheet_id AND
  		   eo_mapsheet.eo_id=', eo.eo_id), ','::TEXT), 1, 150) AS quadname, shared.delimlist(CONCAT_WS('', 'SELECT ma.managed_area_name FROM ma, EO_managed_area', ' WHERE ma.managed_area_id = EO_managed_area.managed_area_id
  		        AND EO_managed_area.eo_id=', eo.eo_id), ','::TEXT) AS managed_area, CONCAT_WS('', UPPER(CONCAT_WS('', oracle.substr(sn.scientific_name, 1, 4),
    CASE
        WHEN (oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '1' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '2' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '3' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '4' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '5') THEN CONCAT_WS('',
        CASE
            WHEN UPPER(oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name) - 3, 2)) = 'SP' THEN 'SP0'
            ELSE 'POP'
        END, oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1))
        ELSE
        CASE
            WHEN oracle.INSTR(sn.scientific_name, ' ', 2, 3) > 0 THEN oracle.substr(sn.scientific_name, oracle.INSTR(sn.scientific_name, ' ', 2, 3) + 1, 4)
            WHEN oracle.INSTR(sn.scientific_name, ' ', 2, 2) > 0 THEN oracle.substr(sn.scientific_name, oracle.INSTR(sn.scientific_name, ' ', 2, 2) + 1, 4)
            WHEN oracle.INSTR(sn.scientific_name, ' ', 2, 1) > 0 THEN oracle.substr(sn.scientific_name, oracle.INSTR(sn.scientific_name, ' ', 2, 1) + 1, 4)
            ELSE RPAD(oracle.substr(sn.scientific_name, 5, 4), 4, '*')
        END
    END)::TEXT), '*', ext.report_eonum(eo.eo_id)) AS maplabel
    FROM core.scientific_name AS sn, core.element_subnational AS est, core.eo AS eo
    LEFT OUTER JOIN domain.d_basic_eo_rank AS rank
        ON (eo.d_basic_eo_rank_id = rank.d_basic_eo_rank_id)
    WHERE eo.element_subnational_id = est.element_subnational_id AND est.sname_id = sn.scientific_name_id;


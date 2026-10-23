CREATE OR REPLACE  VIEW ext.fnai_ma_acreage_view (managed_area_id, major_ma_code, managed_area_name, ma_type, mgmt_agency, nested_acres, acres, ma_id) AS
SELECT
    oracle.substr(ma1.macode_bcd, 10, 4) AS managed_area_id, ma2.macode_bcd AS major_ma_code, oracle.substr(ma1.managed_area_name, 1, 100) AS managed_area_name, ma1.managed_area_type AS ma_type, oracle.substr(ma1.managed_area_type, 1, 3) AS mgmt_agency, ma1.total_area_acres AS nested_acres, 0 AS acres, ma1.managed_area_id AS ma_id
    FROM core.ma AS ma1, core.ma AS ma2
    WHERE ma1.major_ma_id = ma2.managed_area_id
UNION
SELECT
    oracle.substr(ma1.macode_bcd, 10, 4) AS managed_area_id, NULL AS major_ma_code, oracle.substr(ma1.managed_area_name, 1, 100) AS managed_area_name, ma1.managed_area_type AS ma_type, oracle.substr(ma1.managed_area_type, 1, 3) AS mgmt_agency, 0 AS nested_acres, ma1.total_area_acres AS acres, ma1.managed_area_id AS ma_id
    FROM core.ma AS ma1
    WHERE ma1.major_ma_id IS NULL
    ORDER BY mgmt_agency;


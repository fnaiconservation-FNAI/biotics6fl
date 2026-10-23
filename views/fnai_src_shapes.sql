CREATE OR REPLACE  VIEW ext.fnai_src_shapes (text, error_msg) AS
SELECT 'CREATE OR REPLACE FORCE VIEW BIOTICS_USER.FNAI_SRC_SHAPES(SOURCE_FEATURE_ID, SHAPE) AS 
SELECT 
SHP_SUBQRY.SOURCE_FEATURE_ID
, SDO_GEOM.SDO_BUFFER(SHAPE 
    , (SELECT m.diminfo FROM all_sdo_geom_metadata m
    WHERE m.table_name = ''SOURCE_FEATURE_PT''  
    AND m.column_name = ''SHAPE'') 
    , BUFF_DISTM)  AS SHAPE
FROM 
(
    -- Points
    SELECT SF_PT.Source_feature_id, SHAPE        
    FROM BIOTICS_USER.SOURCE_FEATURE_PT SF_PT        
UNION ALL
    -- Lines
    SELECT SF_ln.Source_feature_id, SHAPE
    FROM BIOTICS_USER.SOURCE_FEATURE_LINE SF_LN 
UNION ALL
    -- Polygons
    SELECT SF_py.Source_feature_id, SHAPE
    FROM BIOTICS_USER.SOURCE_FEATURE_POLY SF_PY 
) SHP_SUBQRY
LEFT OUTER JOIN 
(SELECT 
SF.SOURCE_FEATURE_ID
, case when SF.SHAPE_TYPE in (''point'',''line'') then 4.5
  else 0.001
  end as BUFF_DISTM
FROM
SOURCE_FEATURE SF LEFT OUTER JOIN D_UNIT
ON SF.loc_uncertainty_unit_id = d_unit.d_unit_id
LEFT OUTER JOIN D_LOC_UNCERTAINTY_TYPE
ON SF.D_LOC_UNCERTAINTY_TYPE_ID = D_LOC_UNCERTAINTY_TYPE.D_LOC_UNCERTAINTY_TYPE_ID
) LU_SUBQRY
ON SHP_SUBQRY.SOURCE_FEATURE_ID = lu_subqry.source_feature_id;'::varchar AS text,'5632 - Severity CRITICAL - DMS SC can''t convert MDSYS.SDO_GEOM.SDO_BUFFER(MDSYS.SDO_GEOMETRY,MDSYS.SDO_DIM_ARRAY,NUMBER) Spatial object such as the type, function, method, or operator. Convert your source code manually.
5578 - Severity CRITICAL - DMS SC can''t convert the SELECT statement. Revise your SELECT statement and try again.
'::varchar AS error_msg;


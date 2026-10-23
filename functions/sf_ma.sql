CREATE OR REPLACE FUNCTION ext.sf_ma(IN p_source_feature_id BIGINT, IN p_buffer_km DOUBLE PRECISION DEFAULT 0)
RETURNS TEXT
AS
$BODY$
DECLARE
    v_result CHARACTER VARYING(4000);
BEGIN
    /*
    [5632 - Severity CRITICAL - DMS SC can't convert MDSYS.SDO_GEOM.SDO_BUFFER(MDSYS.SDO_GEOMETRY,MDSYS.SDO_DIM_ARRAY,NUMBER,VARCHAR2) Spatial object such as the type, function, method, or operator. Convert your source code manually., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_RELATE(MDSYS.SDO_GEOMETRY,MDSYS.SDO_GEOMETRY,STANDARD.VARCHAR2) function. Revise your code to use another function or create a user-defined function., 5578 - Severity CRITICAL - DMS SC can't convert the SELECT statement. Revise your SELECT statement and try again.]
    SELECT LISTAGG(ma.managed_area_name, '; ')
               WITHIN GROUP (ORDER BY ma.managed_area_name)
        INTO v_result
        FROM source_feature_rep_proj sfgeom
        JOIN ma_shape_proj mageom
            ON SDO_RELATE(
                   sfgeom.shape,
                   SDO_GEOM.SDO_BUFFER(
                       mageom.shape,
                       (SELECT diminfo
                        FROM all_sdo_geom_metadata
                        WHERE owner = 'BIOTICS_USER'
                          AND table_name = 'MA_SHAPE_PROJ'
                          AND column_name = 'SHAPE'),
                       p_buffer_km,
                       'unit=km arc_tolerance=0.05'
                   ),
                   'mask=ANYINTERACT querytype=window'
               ) = 'TRUE'
        JOIN ma ON ma.managed_area_id = mageom.managed_area_id
        JOIN source_feature sf ON sf.source_feature_id = sfgeom.source_feature_id
        WHERE (sf.d_data_qc_status_id <> 3 OR sf.d_data_qc_status_id IS NULL)
          AND sfgeom.source_feature_id = p_source_feature_id
    */
    RETURN v_result;
    EXCEPTION
        WHEN no_data_found THEN
            RETURN NULL;
END;
$BODY$
LANGUAGE  plpgsql;


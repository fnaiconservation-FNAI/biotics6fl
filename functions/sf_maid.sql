CREATE OR REPLACE FUNCTION ext.sf_maid(IN p_source_feature_id BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    v_result CHARACTER VARYING(4000);
BEGIN
    /*
    [5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_RELATE(MDSYS.SDO_GEOMETRY,MDSYS.SDO_GEOMETRY,STANDARD.VARCHAR2) function. Revise your code to use another function or create a user-defined function., 5578 - Severity CRITICAL - DMS SC can't convert the SELECT statement. Revise your SELECT statement and try again.]
    SELECT LISTAGG(ma.managed_area_id, '; ') WITHIN GROUP (ORDER BY ma.managed_area_name)
        INTO v_result
        FROM source_feature_rep_proj sfgeom
        JOIN ma_shape_proj mageom
            ON SDO_RELATE(
                   sfgeom.shape,
                   mageom.shape,
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


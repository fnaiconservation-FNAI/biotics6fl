CREATE OR REPLACE FUNCTION ext.extractpolygon(IN p_geometry GEOMETRY)
RETURNS GEOMETRY
AS
$BODY$
DECLARE
    v_element DOUBLE PRECISION;
    v_elements DOUBLE PRECISION;
    v_geometry GEOMETRY;
    v_extract_shape GEOMETRY;
BEGIN
    IF (MOD(aws_oracle_ext.sdo_gtype(p_geometry), 10) <> 4) THEN
        RETURN p_geometry;
    END IF;
    /*
    [5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_UTIL.GETNUMELEM(MDSYS.SDO_GEOMETRY) function. Revise your code to use another function or create a user-defined function.]
    v_elements := mdsys.sdo_util.GetNumElem(p_geometry)
    */
    FOR v_element IN 1..v_elements LOOP
        /*
        [5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_UTIL.EXTRACT(MDSYS.SDO_GEOMETRY,NUMBER,NUMBER) function. Revise your code to use another function or create a user-defined function.]
        v_extract_shape := mdsys.sdo_util.Extract(p_geometry,v_element,0)
        */
        /* Extract element with all sub-elements */
        IF (CASE GeometryType(v_extract_shape)
            WHEN 'POINT' THEN 1
            WHEN 'LINESTRING' THEN 2
            WHEN 'CIRCULARSTRING' THEN 2
            WHEN 'COMPOUNDCURVE' THEN 2
            WHEN 'POLYGON' THEN 3
            WHEN 'GEOMETRYCOLLECTION' THEN 4
            WHEN 'MULTIPOINT' THEN 5
            WHEN 'MULTILINESTRING' THEN 6
            WHEN 'MULTICURVE' THEN 6
            WHEN 'MULTIPOLYGON' THEN 7
            WHEN 'SOLID' THEN 8
            WHEN 'MULTISOLID' THEN 9
            ELSE 0
        END = 3) THEN
            IF (v_geometry IS NULL) THEN
                v_geometry := v_extract_shape;
            ELSE
                BEGIN
                    /*
                    [5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_UTIL.APPEND(MDSYS.SDO_GEOMETRY,MDSYS.SDO_GEOMETRY) function. Revise your code to use another function or create a user-defined function.]
                    v_geometry := MDSYS.SDO_UTIL.APPEND(v_geometry,v_extract_shape)
                    */
                END;
            END IF;
        END IF;
    END LOOP;
    RETURN (v_geometry);
END;
$BODY$
LANGUAGE  plpgsql IMMUTABLE;


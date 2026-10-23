CREATE OR REPLACE FUNCTION ext.quad_of_center(IN eo_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    cq CHARACTER VARYING(20);
    lat CHARACTER VARYING(7);
    lon CHARACTER VARYING(8);
    lat_minsec CHARACTER VARYING(4);
    lon_minsec CHARACTER VARYING(4);
BEGIN
    SELECT
        latitude, longitude
        INTO STRICT lat, lon
        FROM core.eo
        WHERE eo_id = eo_id_arg;

    IF lat IS NOT NULL AND lon IS NOT NULL THEN
        cq := CONCAT_WS('', oracle.substr(lat, 1, 2), oracle.substr(lon, 1, 3), '-');
        lat_minsec := oracle.substr(lat, 3, 4);
        lon_minsec := oracle.substr(lon, 4, 4);

        IF (lat_minsec >= '0000') AND (lat_minsec < '0730') THEN
            cq := CONCAT_WS('', cq, 'A');
        ELSE
            IF (lat_minsec >= '0730') AND (lat_minsec < '1500') THEN
                cq := CONCAT_WS('', cq, 'B');
            ELSE
                IF (lat_minsec >= '1500') AND (lat_minsec < '2230') THEN
                    cq := CONCAT_WS('', cq, 'C');
                ELSE
                    IF (lat_minsec >= '2230') AND (lat_minsec < '3000') THEN
                        cq := CONCAT_WS('', cq, 'D');
                    ELSE
                        IF (lat_minsec >= '3000') AND (lat_minsec < '3730') THEN
                            cq := CONCAT_WS('', cq, 'E');
                        ELSE
                            IF (lat_minsec >= '3730') AND (lat_minsec < '4500') THEN
                                cq := CONCAT_WS('', cq, 'F');
                            ELSE
                                IF (lat_minsec >= '4500') AND (lat_minsec < '5230') THEN
                                    cq := CONCAT_WS('', cq, 'G');
                                ELSE
                                    IF (lat_minsec >= '5230') AND (lat_minsec < '6000') THEN
                                        cq := CONCAT_WS('', cq, 'H');
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;

        IF (lon_minsec >= '0000') AND (lon_minsec < '0730') THEN
            cq := CONCAT_WS('', cq, '1');
        ELSE
            IF (lon_minsec >= '0730') AND (lon_minsec < '1500') THEN
                cq := CONCAT_WS('', cq, '2');
            ELSE
                IF (lon_minsec >= '1500') AND (lon_minsec < '2230') THEN
                    cq := CONCAT_WS('', cq, '3');
                ELSE
                    IF (lon_minsec >= '2230') AND (lon_minsec < '3000') THEN
                        cq := CONCAT_WS('', cq, '4');
                    ELSE
                        IF (lon_minsec >= '3000') AND (lon_minsec < '3730') THEN
                            cq := CONCAT_WS('', cq, '5');
                        ELSE
                            IF (lon_minsec >= '3730') AND (lon_minsec < '4500') THEN
                                cq := CONCAT_WS('', cq, '6');
                            ELSE
                                IF (lon_minsec >= '4500') AND (lon_minsec < '5230') THEN
                                    cq := CONCAT_WS('', cq, '7');
                                ELSE
                                    IF (lon_minsec >= '5230') AND (lon_minsec < '6000') THEN
                                        cq := CONCAT_WS('', cq, '8');
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    ELSE
        cq := 'not found';
    END IF;
    RETURN (cq);
END;
$BODY$
LANGUAGE  plpgsql;


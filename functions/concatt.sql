CREATE OR REPLACE FUNCTION ext.concatt(IN p1 TEXT DEFAULT NULL, IN p2 TEXT DEFAULT NULL, IN p3 TEXT DEFAULT NULL, IN p4 TEXT DEFAULT NULL, IN p5 TEXT DEFAULT NULL, IN p6 TEXT DEFAULT NULL, IN p7 TEXT DEFAULT NULL, IN p8 TEXT DEFAULT NULL, IN p9 TEXT DEFAULT NULL, IN p10 TEXT DEFAULT NULL, IN p11 TEXT DEFAULT NULL, IN p12 TEXT DEFAULT NULL, IN p13 TEXT DEFAULT NULL, IN p14 TEXT DEFAULT NULL, IN p15 TEXT DEFAULT NULL)
RETURNS TEXT
AS
$BODY$
DECLARE
    v_result CHARACTER VARYING(4000);
    v_has_value BOOLEAN := FALSE;
    rstring CHARACTER VARYING(4000);
BEGIN
    FOR i IN 1..15 LOOP
        CASE i
            WHEN 1 THEN
                IF p1 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p1));
                    v_has_value := TRUE;
                END IF;
            WHEN 2 THEN
                IF p2 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p2));
                    v_has_value := TRUE;
                END IF;
            WHEN 3 THEN
                IF p3 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p3));
                    v_has_value := TRUE;
                END IF;
            WHEN 4 THEN
                IF p4 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p4));
                    v_has_value := TRUE;
                END IF;
            WHEN 5 THEN
                IF p5 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p5));
                    v_has_value := TRUE;
                END IF;
            WHEN 6 THEN
                IF p6 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p6));
                    v_has_value := TRUE;
                END IF;
            WHEN 7 THEN
                IF p7 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p7));
                    v_has_value := TRUE;
                END IF;
            WHEN 8 THEN
                IF p8 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p8));
                    v_has_value := TRUE;
                END IF;
            WHEN 9 THEN
                IF p9 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p9));
                    v_has_value := TRUE;
                END IF;
            WHEN 10 THEN
                IF p10 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p10));
                    v_has_value := TRUE;
                END IF;
            WHEN 11 THEN
                IF p11 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p11));
                    v_has_value := TRUE;
                END IF;
            WHEN 12 THEN
                IF p12 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p12));
                    v_has_value := TRUE;
                END IF;
            WHEN 13 THEN
                IF p13 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p13));
                    v_has_value := TRUE;
                END IF;
            WHEN 14 THEN
                IF p14 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p14));
                    v_has_value := TRUE;
                END IF;
            WHEN 15 THEN
                IF p15 IS NOT NULL THEN
                    v_result := CONCAT_WS('', v_result, oracle.to_char(p15));
                    v_has_value := TRUE;
                END IF;
        END CASE;
    END LOOP;

    IF v_has_value THEN
        rstring := TRIM(v_result);
        rstring := regexp_replace((rstring)::TEXT, (E'\\s+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
        RETURN rstring;
    ELSE
        RETURN NULL;
    END IF;
END;
$BODY$
LANGUAGE  plpgsql;


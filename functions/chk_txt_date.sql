CREATE OR REPLACE FUNCTION ext.chk_txt_date(IN v_date TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    v_date1 CHARACTER VARYING(100);
BEGIN
    SELECT
        CASE
            WHEN v_date IS NOT NULL AND ext.chk_date(v_date) = 1 THEN
            CASE
                WHEN oracle.TO_DATE(v_date::TEXT, 'YYYY-MM-DD') BETWEEN oracle.TO_DATE('1800-01-01', 'YYYY-MM-DD') AND (CLOCK_TIMESTAMP() AT TIME ZONE COALESCE(CURRENT_SETTING('aws_oracle_ext.tz', TRUE), 'EDT'))::TIMESTAMP(0) THEN 'Valid date and time period'
                ELSE 'Invalid time period'
            END
            WHEN v_date IS NOT NULL AND ext.chk_date(v_date) = 0 THEN
            CASE
                WHEN ext.chk_nbr(oracle.substr(v_date, 1, 4)) = 1 AND oracle.to_number(oracle.substr(v_date, 1, 4)) BETWEEN 1800 AND oracle.to_number(oracle.to_char((CLOCK_TIMESTAMP() AT TIME ZONE COALESCE(CURRENT_SETTING('aws_oracle_ext.tz', TRUE), 'EDT'))::TIMESTAMP(0), 'YYYY')) THEN
                CASE
                    WHEN LENGTH(v_date) = 4 THEN 'Valid year'
                    WHEN LENGTH(v_date) = 7 THEN
                    CASE
                        WHEN oracle.substr(v_date, 5, 1) = '-' AND ext.chk_nbr(oracle.substr(v_date, 6, 2)) = 1 THEN
                        CASE
                            WHEN oracle.to_number(oracle.substr(v_date, 6, 2)) BETWEEN 1 AND 12 THEN 'Valid month'
                            ELSE 'Invalid month'
                        END
                        ELSE 'Invalid format'
                    END
                    WHEN LENGTH(v_date) = 8 THEN
                    CASE
                        WHEN oracle.substr(v_date, 5, 4) = ' pre' THEN 'Valid pre'
                        ELSE 'Invalid format'
                    END
                    WHEN LENGTH(v_date) = 9 THEN
                    CASE
                        WHEN oracle.substr(v_date, 5, 5) = ' fall' THEN 'Valid fall'
                        ELSE 'Invalid format'
                    END
                    WHEN LENGTH(v_date) = 10 THEN
                    CASE
                        WHEN oracle.substr(v_date, 5, 6) = ' circa' THEN 'Valid circa'
                        ELSE 'Invalid format'
                    END
                    WHEN LENGTH(v_date) = 11 THEN
                    CASE
                        WHEN oracle.substr(v_date, 5, 1) = ' ' AND oracle.substr(v_date, 5, 7) = ' spring' THEN 'Valid spring'
                        WHEN oracle.substr(v_date, 5, 1) = ' ' AND oracle.substr(v_date, 5, 7) = ' summer' THEN 'Valid summer'
                        WHEN oracle.substr(v_date, 5, 1) = '-' AND ext.chk_nbr(oracle.substr(v_date, 6, 2)) = 1 AND oracle.substr(v_date, 8, 4) = ' pre' THEN 'Valid pre month'
                        ELSE 'Invalid format'
                    END
                    WHEN LENGTH(v_date) = 12 THEN
                    CASE
                        WHEN oracle.substr(v_date, 5, 4) = ' -- ' AND ext.chk_nbr(oracle.substr(v_date, 9, 4)) = 1 THEN
                        CASE
                            WHEN oracle.to_number(oracle.substr(v_date, 9, 4)) BETWEEN 1800 AND oracle.to_number(oracle.to_char((CLOCK_TIMESTAMP() AT TIME ZONE COALESCE(CURRENT_SETTING('aws_oracle_ext.tz', TRUE), 'EDT'))::TIMESTAMP(0), 'YYYY')) AND oracle.to_number(oracle.substr(v_date, 9, 4)) > oracle.to_number(oracle.substr(v_date, 1, 4)) THEN 'Valid year range'
                            ELSE 'Invalid format'
                        END
                        ELSE 'Invalid format'
                    END
                    WHEN LENGTH(v_date) = 14 THEN
                    CASE
                        WHEN oracle.substr(v_date, 5, 1) = '-' AND ext.chk_nbr(oracle.substr(v_date, 6, 2)) = 1 AND oracle.substr(v_date, 8, 7) = ' winter' THEN 'Valid winter'
                        WHEN ext.chk_date(oracle.substr(v_date, 1, 10)) = 1 AND oracle.TO_DATE(oracle.substr(v_date, 1, 10)::TEXT, 'YYYY-MM-DD') BETWEEN oracle.TO_DATE('1800-01-01', 'YYYY-MM-DD') AND (CLOCK_TIMESTAMP() AT TIME ZONE COALESCE(CURRENT_SETTING('aws_oracle_ext.tz', TRUE), 'EDT'))::TIMESTAMP(0) AND oracle.substr(v_date, 11, 4) = ' pre' THEN 'Valid pre date'
                        ELSE 'Invalid format'
                    END
                    WHEN LENGTH(v_date) = 16 THEN
                    CASE
                        WHEN oracle.substr(v_date, 5, 1) = ' ' AND oracle.substr(v_date, 5, 12) = ' summer-fall' THEN 'Valid summer-fall'
                        WHEN oracle.substr(v_date, 5, 1) = ' ' AND oracle.substr(v_date, 5, 12) = ' fall-winter' THEN 'Valid fall-winter'
                        ELSE 'Invalid format'
                    END
                    WHEN LENGTH(v_date) = 18 THEN
                    CASE
                        WHEN oracle.substr(v_date, 8, 4) = ' -- ' AND ext.chk_nbr(oracle.substr(v_date, 6, 2)) = 1 AND ext.chk_nbr(oracle.substr(v_date, 12, 4)) = 1 AND ext.chk_nbr(oracle.substr(v_date, 17, 2)) = 1 THEN
                        CASE
                            WHEN oracle.to_number(oracle.substr(v_date, 12, 4)) BETWEEN 1800 AND oracle.to_number(oracle.to_char((CLOCK_TIMESTAMP() AT TIME ZONE COALESCE(CURRENT_SETTING('aws_oracle_ext.tz', TRUE), 'EDT'))::TIMESTAMP(0), 'YYYY')) AND (oracle.to_number(oracle.substr(v_date, 12, 4)) > oracle.to_number(oracle.substr(v_date, 1, 4)) OR (oracle.to_number(oracle.substr(v_date, 12, 4)) = oracle.to_number(oracle.substr(v_date, 1, 4)) AND oracle.to_number(oracle.substr(v_date, 6, 2)) < oracle.to_number(oracle.substr(v_date, 17, 2)))) AND oracle.to_number(oracle.substr(v_date, 6, 2)) BETWEEN 1 AND 12 AND oracle.to_number(oracle.substr(v_date, 17, 2)) BETWEEN 1 AND 12 THEN 'Valid month range'
                            ELSE 'Invalid format'
                        END
                        WHEN oracle.substr(v_date, 5, 14) = ' spring-summer' THEN 'Valid summer-fall'
                        WHEN oracle.substr(v_date, 5, 14) = ' fall-winter' THEN 'Valid fall-winter'
                        ELSE 'Invalid format'
                    END
                    WHEN LENGTH(v_date) = 24 THEN
                    CASE
                        WHEN oracle.substr(v_date, 11, 4) = ' -- ' AND ext.chk_date(oracle.substr(v_date, 1, 10)) = 1 AND ext.chk_date(oracle.substr(v_date, 15, 10)) = 1 THEN
                        CASE
                            WHEN oracle.TO_DATE(oracle.substr(v_date, 1, 10)::TEXT, 'YYYY-MM-DD') BETWEEN oracle.TO_DATE('1800-01-01', 'YYYY-MM-DD') AND (CLOCK_TIMESTAMP() AT TIME ZONE COALESCE(CURRENT_SETTING('aws_oracle_ext.tz', TRUE), 'EDT'))::TIMESTAMP(0) AND oracle.TO_DATE(oracle.substr(v_date, 15, 10)::TEXT, 'YYYY-MM-DD') BETWEEN oracle.TO_DATE('1800-01-01', 'YYYY-MM-DD') AND (CLOCK_TIMESTAMP() AT TIME ZONE COALESCE(CURRENT_SETTING('aws_oracle_ext.tz', TRUE), 'EDT'))::TIMESTAMP(0) AND oracle.TO_DATE(oracle.substr(v_date, 1, 10)::TEXT, 'YYYY-MM-DD') < oracle.TO_DATE(oracle.substr(v_date, 15, 10)::TEXT, 'YYYY-MM-DD') THEN 'Valid day range'
                            ELSE 'Invalid format'
                        END
                        ELSE 'Invalid format'
                    END
                    ELSE 'Invalid format'
                END
                ELSE 'Invalid, date must start with a valid year'
            END
            WHEN v_date IS NULL THEN 'Invalid, date is required'
        END AS date_test
        INTO STRICT v_date1;
    RETURN v_date1;
END;
$BODY$
LANGUAGE  plpgsql;


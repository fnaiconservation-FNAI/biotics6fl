CREATE OR REPLACE FUNCTION ext.get_next_refcode(IN template_code TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    next_tb CHARACTER VARYING(2);
    code CHARACTER VARYING(12);
    rows_returned DOUBLE PRECISION;
    invalid_input aws_oracle_ext.ora_exception := 'invalid_input';
BEGIN
    IF NOT (regexp_like((template_code)::TEXT, (E'\\d\\dFLUS$')::TEXT, 'c')) OR LENGTH(template_code) <> 12 THEN
        RAISE USING detail = invalid_input, hint = 1;
    END IF;
    next_tb := '01';

    LOOP
        EXIT WHEN rows_returned = 0;

        BEGIN
            code := CONCAT_WS('', oracle.substr(template_code, 1, 6), next_tb, oracle.substr(template_code, 9, 12));
            SELECT
                COUNT(*)
                INTO STRICT rows_returned
                FROM core.reference
                WHERE reference_code = code;

            IF rows_returned != 0 THEN
                next_tb := oracle.to_char(oracle.to_number(next_tb) + 1);

                IF LENGTH(next_tb) = 1 THEN
                    next_tb := CONCAT_WS('', '0', next_tb);
                END IF;
            END IF;
        END;
    END LOOP;
    RETURN code;
    EXCEPTION
        WHEN raise_exception THEN
            DECLARE
                exc$name CHARACTER VARYING;
                exc$code CHARACTER VARYING;
            BEGIN
                GET STACKED DIAGNOSTICS exc$name := pg_exception_detail,
                    exc$code := pg_exception_hint;

                IF exc$name = invalid_input THEN
                    RAISE USING hint = -20001, message = 'Invalid input code template!', detail = 'User-defined exception';
                END IF;
            END;
END;
$BODY$
LANGUAGE  plpgsql;


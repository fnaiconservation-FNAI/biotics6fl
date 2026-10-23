CREATE OR REPLACE FUNCTION ext.is_number(IN p_string TEXT)
RETURNS NUMERIC
AS
$BODY$
DECLARE
    v_new_num DOUBLE PRECISION;
BEGIN
    v_new_num := oracle.to_number(p_string);
    RETURN 1;
    EXCEPTION
        WHEN string_data_right_truncation OR numeric_value_out_of_range OR invalid_text_representation THEN
            RETURN 0;
END;
$BODY$
LANGUAGE  plpgsql;


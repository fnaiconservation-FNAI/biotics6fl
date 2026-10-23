CREATE OR REPLACE FUNCTION ext.g_to_srank(IN grank TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    result CHARACTER VARYING(20);
BEGIN
    result :=
    CASE
        WHEN GRANK LIKE '%T%' THEN CONCAT_WS('', 'S', replace(replace(oracle.substr(GRANK, oracle.INSTR(GRANK, 'T') + 1), 'T', 'S'), 'Q', ''))
        ELSE replace(replace(GRANK, 'G', 'S'), 'Q', '')
    END;
    RETURN result;
END;
$BODY$
LANGUAGE  plpgsql;


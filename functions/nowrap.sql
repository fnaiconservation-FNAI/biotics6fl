CREATE OR REPLACE FUNCTION ext.nowrap(IN p_input TEXT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', '<span style="white-space: nowrap;">', p_input, '</span>');
END;
$BODY$
LANGUAGE  plpgsql;


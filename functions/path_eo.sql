CREATE OR REPLACE FUNCTION ext.path_eo(IN pk BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', 'https://bioticsfl.natureserve.org/biotics/services/page/Eo/', oracle.to_char(pk), '.html');
END;
$BODY$
LANGUAGE  plpgsql;


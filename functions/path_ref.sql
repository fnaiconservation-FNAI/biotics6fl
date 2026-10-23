CREATE OR REPLACE FUNCTION ext.path_ref(IN pk BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', 'https://bioticsfl.natureserve.org/biotics/services/page/Reference/', oracle.to_char(pk), '.html');
END;
$BODY$
LANGUAGE  plpgsql;


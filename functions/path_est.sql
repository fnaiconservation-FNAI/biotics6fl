CREATE OR REPLACE FUNCTION ext.path_est(IN pk BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', 'https://bioticsfl.natureserve.org/biotics/services/page/ElementSubnational/', oracle.to_char(pk), '.html');
END;
$BODY$
LANGUAGE  plpgsql;


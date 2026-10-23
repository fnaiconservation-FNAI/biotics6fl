CREATE OR REPLACE FUNCTION ext.link_est(IN pk BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', 'EST_ID: ', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/ElementSubnational/', oracle.to_char(pk), '.html" target="_blank">', pk, '</a>');
END;
$BODY$
LANGUAGE  plpgsql;


CREATE OR REPLACE FUNCTION ext.link_eo(IN pk BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', 'EO_ID: ', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/', oracle.to_char(pk), '.html" target="_blank">', pk, '</a>');
END;
$BODY$
LANGUAGE  plpgsql;


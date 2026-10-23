CREATE OR REPLACE FUNCTION ext.link_egt(IN pk BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', 'EGT_ID: ', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/ElementGlobal/', oracle.to_char(pk), '.html" target="_blank">', pk, '</a>');
END;
$BODY$
LANGUAGE  plpgsql;


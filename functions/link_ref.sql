CREATE OR REPLACE FUNCTION ext.link_ref(IN pk BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', 'REF_ID: ', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/Reference/', oracle.to_char(pk), '.html" target="_blank">', pk, '</a>');
END;
$BODY$
LANGUAGE  plpgsql;


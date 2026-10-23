CREATE OR REPLACE FUNCTION ext.link_sf(IN pk BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', 'SF_ID: ', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/SourceFeature/', oracle.to_char(pk), '.html" target="_blank">', pk, '</a>');
END;
$BODY$
LANGUAGE  plpgsql;


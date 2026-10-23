CREATE OR REPLACE FUNCTION ext.path_sf(IN pk BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN CONCAT_WS('', 'https://bioticsfl.natureserve.org/biotics/services/page/SourceFeature/', oracle.to_char(pk), '.html');
END;
$BODY$
LANGUAGE  plpgsql;


CREATE OR REPLACE FUNCTION ext.biotics_url(IN tbl TEXT, IN prkey BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    URL_var CHARACTER VARYING(254);
BEGIN
    IF tbl = 'EO' THEN
        SELECT
            CONCAT_WS('', '<A href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/', core.eo.eo_id, '.html" target="_blank">', (core.eo.eo_id), '</A>')
            INTO STRICT URL_var
            FROM core.eo
            WHERE eo_id = prkey;
    END IF;
    RETURN (URL_var);
END;
$BODY$
LANGUAGE  plpgsql;


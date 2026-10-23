CREATE OR REPLACE FUNCTION ext.biotics_html_link(IN tbl TEXT, IN prkey BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    URL_var CHARACTER VARYING(254);
BEGIN
    IF UPPER(tbl) = 'EO' THEN
        SELECT
            CONCAT_WS('', '<A href="https://bioticsfl.natureserve.org/biotics/services/page/Eo/', core.eo.eo_id, '.html" target="_blank">', (core.eo.eo_id), '</A>')
            INTO STRICT URL_var
            FROM core.eo
            WHERE eo_id = prkey;
    END IF;

    IF UPPER(tbl) IN ('SF', 'SOURCE_FEATURE', 'SOURCE FEATURE') THEN
        SELECT
            CONCAT_WS('', '<A href="https://bioticsfl.natureserve.org/biotics/services/page/SourceFeature/', sf.source_feature_id, '.html" target="_blank">', (sf.source_feature_id), '</A>')
            INTO STRICT URL_var
            FROM core.source_feature AS sf
            WHERE sf.source_feature_id = prkey;
    END IF;
    RETURN (URL_var);
/* Excel link? */
/* =HYPERLINK("https://bioticsfl.natureserve.org/biotics/services/page/Eo/"&A18897&".html") */
/* central */
/* https://bioticscentral.natureserve.org/biotics/services/page/ElementGlobal/104661.html */
/* SELECT ELEMENT_GLOBAL_SEQ_UID FROM ELEMENT_GLOBAL WHERE GETSCINAME(GNAME_ID) = 'Etheostoma okaloosae' */
/* EO, sf, est, central egt? */
END;
$BODY$
LANGUAGE  plpgsql;


CREATE OR REPLACE FUNCTION ext.getgname(IN egt_id BIGINT, IN formatted CHARACTER DEFAULT 'N')
RETURNS TEXT
AS
$BODY$
/*
Return gname so it's easily retrieved wherever there's an element_global_id (without linking to EGT and Sci_Name).  If Y is entered as the optional 2nd parameter, returns formatted sci_name, otherwise returns unformatted.
-Example: SELECT getGName(element_global_id) as gname, getGName(element_global_id, 'n') as gname2, getGName(element_global_id,'Y') as formatted_gname, g_rank_reasons FROM element_global_rank WHERE rownum <50
*/
DECLARE
    FormName CHARACTER VARYING(500);
    UnformName CHARACTER VARYING(500);
BEGIN
    SELECT
        sn.scientific_name, sn.formatted_scientific_name
        INTO UnformName, FormName
        FROM core.element_global AS eg, core.scientific_name AS sn
        WHERE eg.gname_id = sn.scientific_name_id AND eg.element_global_id = egt_id;

    IF UPPER(formatted) = 'Y' THEN
        RETURN FormName;
    ELSE
        RETURN UnformName;
    END IF;
END;
$BODY$
LANGUAGE plpgsql;

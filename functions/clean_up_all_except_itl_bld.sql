CREATE OR REPLACE FUNCTION ext.clean_up_all_except_itl_bld(IN cstring TEXT)
RETURNS TEXT
AS
$BODY$
/* Remove all HTML tags except italics and bold. */
/* Replace special characters. */
/* Replace En Dash and Em Dash with hyphen. */
/* Trim trailing, leading and multiple spaces */
/* Trim space befor closing font tags */
DECLARE
    rstring CHARACTER VARYING(6000);
BEGIN
    rstring := replace(cstring, '<br>', ' ');
    rstring := replace(rstring, coalesce(CHR(10), ''), '');
    rstring := replace(rstring, coalesce(CHR(11), ''), '');
    rstring := replace(rstring, coalesce(CHR(12), ''), '');
    rstring := replace(rstring, coalesce(CHR(13), ''), '');
    /* rstring := REPLACE(rstring, CHR(173)); */
    /* rstring := replace(rstring,'–', '-'); */
    /* rstring := replace(rstring,'—', '-'); */
    rstring := replace(rstring, coalesce(CONCAT_WS('', CHR(38), 'gt;')::TEXT, ''), '>');
    rstring := replace(rstring, coalesce(CONCAT_WS('', CHR(38), 'lt;')::TEXT, ''), '<');
    rstring := regexp_replace((rstring)::TEXT, ('<div>|<font>|<td class[^>]*>|<tr height[^>]*>|<col style[^>]*>|<table style[^>]*>|<font color[^>]*>|<font size[^>]*>|<div style[^>]*>|<span style[^>]*>|<table>|</table>|<tbody>|</tbody>|<tr>|</tr>|<td>|</td>|<colgroup>|</colgroup>|<td width[^>]*>|<table width[^>]*>|<col width[^>]*>|<span>|</span>|</div>|</font>|<br>|<br />')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    rstring := replace(rstring, ' </i>', '</i> ');
    rstring := replace(rstring, ' </b>', '</b> ');
    rstring := TRIM(rstring);
    rstring := regexp_replace((rstring)::TEXT, (E'\\s+')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    RETURN (rstring);
END;
$BODY$
LANGUAGE  plpgsql;


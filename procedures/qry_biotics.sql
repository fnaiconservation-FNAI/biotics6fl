CREATE OR REPLACE PROCEDURE ext.qry_biotics(IN txt TEXT)
AS 
$BODY$
DECLARE
    l_sql_stmt CHARACTER VARYING(1000);
BEGIN
    l_sql_stmt := CONCAT_WS('', 'SELECT core.eo.eo_id, sf.source_feature_id, visit_id, eo_data, gen_desc, core.eo.directions, sf.source_feature_descriptor, sf_ext1.description, core.visit.visit_notes FROM core.eo LEFT OUTER JOIN core.eo_source_feature AS eo_sf ON core.eo.eo_id = eo_sf.eo_id LEFT OUTER JOIN core.source_feature AS sf ON eo_sf.source_feature_id = sf.source_feature_id LEFT OUTER JOIN ext.source_feature_flext1 AS sf_ext1 ON sf.source_feature_id = sf_ext1.source_feature_id LEFT OUTER JOIN core.visit ON sf.source_feature_id = core.visit.source_feature_id WHERE core.eo.eo_data::TEXT LIKE ''%', txt, '%''');
    CALL aws_oracle_ext.dbms_output$put_line(a => l_sql_stmt);
    EXECUTE l_sql_stmt;
END;
$BODY$
LANGUAGE plpgsql;


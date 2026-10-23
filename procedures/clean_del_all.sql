CREATE OR REPLACE PROCEDURE ext.clean_del_all()
AS 
$BODY$
/*
this stored procedure was done for BT5025.  It will check ALL tables in the deleted schema for records that are
in both the deleted and regular schemas. Any records found to be in both schemas will
cause the record to be deleted from the deleted schema table.  This condition occurs when a record
has been restored and not subsequently deleted from the deleted schema.  There are no input parameters since this procedure
will clean all of the tables in the deleted schema by calling the clean_del procedure one by one for each entry
reg_del_tables view.
C. Fogelsong 7/26/2007
*/
DECLARE
    tab_cur CURSOR FOR
    SELECT
        rd.regtable
        FROM reg_del_tables AS rd;
    tab_cur$ATTRIBUTES aws_oracle_data.TCursorAttributes := ROW (FALSE, NULL, NULL, NULL);
    tablist ext.clean_del_all$tables_in_del_schema;
BEGIN
    CALL aws_oracle_ext.dbms_output$enable(buffer_size => 1000000);
    CALL aws_oracle_ext.dbms_output$put_line(a => 'Message from the cleaning lady: I''m starting the process now');
    tab_cur := NULL;
    OPEN tab_cur;
    tab_cur$ATTRIBUTES := ROW (TRUE, 0, NULL, NULL);
    SELECT
        ARRAY_AGG(blk)
        INTO tablist
        FROM aws_oracle_ext.bulk$fetch_cursor(pCur => tab_cur, pRecordType => NULL::CHARACTER VARYING(30))
            AS blk;
    CLOSE tab_cur;
    tab_cur := NULL;
    tab_cur$ATTRIBUTES := ROW (FALSE, NULL, NULL, NULL);

    FOR i IN 1..COALESCE(array_length(tablist, 1), 0) LOOP
        CALL shared.clean_del((tablist)[i]);
    END LOOP;
    CALL aws_oracle_ext.dbms_output$put_line(a => 'Message from the cleaning lady: I''m finished now.  Have a nice day.');
END;
$BODY$
LANGUAGE plpgsql;


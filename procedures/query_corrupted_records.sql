CREATE OR REPLACE PROCEDURE ext.query_corrupted_records(IN table_in TEXT, IN cutoff_date TIMESTAMP WITH TIME ZONE)
AS 
$BODY$
DECLARE
    id_column CHARACTER VARYING(50);
    top_level_id_column CHARACTER VARYING(50);
    sql_stmt TEXT;
    final_sql_stmt TEXT;
    rec RECORD;
/* fileID UTL_FILE.FILE_TYPE; */
BEGIN
    CALL aws_oracle_ext.dbms_output$enable(buffer_size => 1000000);
    /* fileID := UTL_FILE.FOPEN ('TMP', 'BX2967.sql', 'W'); */
    /* find the primary key column of the table */
    EXECUTE CONCAT_WS('', 'SELECT cols.column_name FROM aws_oracle_ext.SYS_ALL_CONSTRAINTS AS cons, aws_oracle_ext.SYS_ALL_CONS_COLUMNS AS cols WHERE cols.table_name = ''', table_in, ''' AND cons.constraint_type = ''P'' AND cons.constraint_name = cols.constraint_name AND cons.owner = cols.owner AND cols.position = 1') INTO STRICT top_level_id_column;
    final_sql_stmt := NULL::TEXT;
    /* for each distinct (table , column that have been edited) */

    FOR rec IN
    SELECT DISTINCT
        al.table_name, alc.column_name
        FROM audit.audit_log_column AS alc
        INNER JOIN audit.audit_log AS al
            ON alc.audit_log_id = al.audit_log_id
        WHERE al.audit_date >= cutoff_date AND al.table_name = table_in AND alc.column_name IN (SELECT
            column_name
            FROM core.b_tab_text_columns
            WHERE table_name = al.table_name)
        ORDER BY al.table_name, alc.column_name
    LOOP
        sql_stmt := (CONCAT_WS('', 'select ''', table_in, ''' top_level_table, x.', top_level_id_column, ' top_level_id, ''', rec.table_name, ''' table_name, ''', rec.column_name, ''' column_name, x.', top_level_id_column, ' primary_key_id, to_char(substr(x.', rec.column_name, ',1,4000)) bad_value, alc.old_value last_good_value', ' from ', rec.table_name, ' x left join', ' (select distinct al.table_name, alc.column_name, al.primary_key_id, max(alc.audit_log_column_id) max_audit_log_column_id', ' from audit_log_column alc', ' inner join audit_log al on alc.audit_log_id = al.audit_log_id', ' where alc.column_name = ''', rec.column_name, '''', ' and al.table_name = ''', rec.table_name, '''', ' and not (alc.old_value like ''%', CHR(191), '%'')', ' and al.audit_date >= to_date(''', oracle.to_char(cutoff_date, 'mm/dd/yyyy'), ''',''mm/dd/yyyy'')', ' group by al.table_name, alc.column_name, al.primary_key_id) y', ' on x.', top_level_id_column, ' = y.primary_key_id', ' left join audit_log_column alc on y.max_audit_log_column_id = alc.audit_log_column_id', ' where', ' x.rec_last_mod_date >= to_date(''', oracle.to_char(cutoff_date, 'mm/dd/yyyy'), ''',''mm/dd/yyyy'')', ' and x.', rec.column_name, ' like ''%', CHR(191), '%'''))::TEXT;

        IF (LENGTH(final_sql_stmt::TEXT) > 0) THEN
            final_sql_stmt := (CONCAT_WS('', final_sql_stmt, ' union ', CHR(13), CHR(10), '(', sql_stmt, ')'))::TEXT;
        ELSE
            final_sql_stmt := (CONCAT_WS('', '(', sql_stmt, ')'))::TEXT;
        END IF;
    /* dbms_output.put_line(sql_stmt); */
    /* UTL_FILE.PUT_LINE(fileID,sql_stmt); */
    END LOOP;
    /* for each distinct (child table , child column that have been edited) */

    FOR rec IN
    SELECT DISTINCT
        al.table_name, alc.column_name
        FROM audit.audit_log_column AS alc
        INNER JOIN audit.audit_log AS al
            ON alc.audit_log_id = al.audit_log_id
        INNER JOIN audit.audit_log_fk AS fk
            ON al.audit_log_id = fk.audit_log_id
        WHERE al.audit_date >= cutoff_date AND fk.fk_table_name = table_in AND alc.column_name IN (SELECT
            column_name
            FROM core.b_tab_text_columns
            WHERE table_name = al.table_name)
        ORDER BY al.table_name, alc.column_name
    LOOP
        /* find the primary key column of the child table */
        EXECUTE CONCAT_WS('', 'SELECT cols.column_name FROM aws_oracle_ext.SYS_ALL_CONSTRAINTS AS cons, aws_oracle_ext.SYS_ALL_CONS_COLUMNS AS cols WHERE cols.table_name = ''', rec.table_name, ''' AND cons.constraint_type = ''P'' AND cons.constraint_name = cols.constraint_name AND cons.owner = cols.owner AND cols.position = 1') INTO STRICT id_column;
        sql_stmt := (CONCAT_WS('', 'select ''', table_in, ''' top_level_table, x.', top_level_id_column, ' top_level_id, ''', rec.table_name, ''' table_name, ''', rec.column_name, ''' column_name, x.', id_column, ' primary_key_id, to_char(substr(x.', rec.column_name, ',1,4000)) bad_value, alc.old_value last_good_value', ' from ', rec.table_name, ' x left join', ' (select distinct al.table_name, alc.column_name, al.primary_key_id, max(alc.audit_log_column_id) max_audit_log_column_id', ' from audit_log_column alc', ' inner join audit_log al on alc.audit_log_id = al.audit_log_id', ' where alc.column_name = ''', rec.column_name, '''', ' and al.table_name = ''', rec.table_name, '''', ' and not (alc.old_value like ''%', CHR(191), '%'')', ' and al.audit_date >= to_date(''', oracle.to_char(cutoff_date, 'mm/dd/yyyy'), ''',''mm/dd/yyyy'')', ' group by al.table_name, alc.column_name, al.primary_key_id) y', ' on x.', id_column, ' = y.primary_key_id', ' left join audit_log_column alc on y.max_audit_log_column_id = alc.audit_log_column_id', ' where', ' x.rec_last_mod_date >= to_date(''', oracle.to_char(cutoff_date, 'mm/dd/yyyy'), ''',''mm/dd/yyyy'')', ' and x.', rec.column_name, ' like ''%', CHR(191), '%'''))::TEXT;

        IF (LENGTH(final_sql_stmt::TEXT) > 0) THEN
            final_sql_stmt := (CONCAT_WS('', final_sql_stmt, ' union ', CHR(13), CHR(10), '(', sql_stmt, ')'))::TEXT;
        ELSE
            final_sql_stmt := (CONCAT_WS('', '(', sql_stmt, ')'))::TEXT;
        END IF;
    END LOOP;

    IF (LENGTH(final_sql_stmt::TEXT) > 0) THEN
        CALL aws_oracle_ext.dbms_output$put_line(a => CONCAT_WS('', 'select * from (', final_sql_stmt, ') order by top_level_id, table_name, column_name;'));
    END IF;
/* utl_file.fflush(fileID); */
/* UTL_FILE.FCLOSE (fileID); */
END;
$BODY$
LANGUAGE plpgsql;


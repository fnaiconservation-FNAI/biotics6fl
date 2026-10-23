CREATE OR REPLACE FUNCTION ext.value_on_date(IN tbl TEXT, IN fld TEXT, IN prkey BIGINT, IN tdate TIMESTAMP WITH TIME ZONE)
RETURNS TEXT
AS
$BODY$
/* Value_on_date */
/* */
/* This function finds the value of a specific field on a specific date. It works only for */
/* records that currently exist in the database (i.e. it is not designed to report values */
/* for records that have been deleted). It also works only for data changes that have */
/* triggered entry of records into the audit logs, and for tables that contain a */
/* REC_CREATE_DATE column. If the field value was modified on the date of interest, the */
/* value returned will be the LAST of any modifications on that date. */
/* */
/* The value of a given field on a specified date will be one of: */
/* 1) the current value (if no changes have been made since the date of interest), */
/* 2) the value in the old_value field of the first audit log record AFTER that date, or */
/* 3) N/A if the record containing the field did not exist on that date */
/* */
/* written by G. Woodsum, FNAI, 1/2008 */
/* */
/* arguments: */
/* tbl        the name of the database table in which the field resides */
/* fld        the name of the field for which to find the old value */
/* prkey      id of the record for which you want to find the old value */
/* date       date on which you want the old value (entered as text, format 'yyyy-mm-dd') */
/* */
/* returns:   - last value of the field on the date you requested (note that it is a TEXT value) */
/* - a text value of "null" is returned if the field value was null (changed 20151015 to return NULL) */
/* - a text value of "N/A (record created after date)" is returned if the record in question */
/* had not yet been created as of the date requested */
/* */
/* */
/* examples of call:  value_on_date('SHAPE','HAS_SHAPE_IND', SHAPE_ID, '2006-11-01') */
/* value_on_date('eo','eo_data', eo_id, to_date('2007-05-01','yyyy-mm-dd')) */
/* */
/* examples of use: the simplest use is for a single value on a single date, which would involve */
/* the function call in the select clause and specification of the record ID in the where clause, */
/* as in: */
/* SELECT value_on_date('SHAPE','HAS_SHAPE_IND', SHAPE_ID, '2006-11-01') */
/* FROM shape */
/* WHERE shape_id = 25401; */
/* */
/* Here is a more complicated example of its use, in a query designed to list side-by-side */
/* values of GRANK at the beginning and end of calendar 2008, ONLY where the GRANK values */
/* actually changed during the year */
/* SELECT . */
/* . */
/* . */
/* value_on_date('ELEMENT_GLOBAL','G_RANK', */
/* egt.element_global_id , to_date('2008-01-01','yyyy-mm-dd')) */
/* as begin_grank, */
/* value_on_date('ELEMENT_GLOBAL','G_RANK', */
/* egt.element_global_id , to_date('2008-12-31','yyyy-mm-dd')) */
/* as end_grank */
/* From  . */
/* . */
/* . */
/* Where value_on_date('ELEMENT_GLOBAL','G_RANK', */
/* egt.element_global_id , to_date('2008-01-01','yyyy-mm-dd'))  <> */
/* value_on_date('ELEMENT_GLOBAL','G_RANK', */
/* egt.element_global_id , to_date('2008-12-31','yyyy-mm-dd')) */
/* and value_on_date('ELEMENT_GLOBAL','G_RANK', egt.element_global_id , */
/* to_date('2008-01-01','yyyy-mm-dd')) <> 'N/A (new record)'   /* suppress new recs */ */
/* */
/* ******************************************************************************************* */
DECLARE
    pk CHARACTER VARYING(30);
    rvalue CHARACTER VARYING(4000);
    dsql CHARACTER VARYING(750);
    rcdate TIMESTAMP(0) WITHOUT TIME ZONE;
    nchanges BIGINT;
    dtype CHARACTER VARYING(30);
    tblname CHARACTER VARYING(30);
    fldname CHARACTER VARYING(30);
BEGIN
    tblname := UPPER(tbl);
    fldname := UPPER(fld);
    pk := app.getpk(tblname);
    /* First get the data type of the field requested. This also serves */
    /* to perform a validity check on the tbl and fld parameter values. */
    /* (haven't been able to figure out yet how to check prkey) */
    SELECT
        atc.data_type
        INTO STRICT dtype
        FROM aws_oracle_ext.SYS_ALL_TAB_COLUMNS AS atc
        WHERE atc.table_name = tblname AND atc.column_name = fldname;
    /* Now handle the case where the record didn't exist */
    dsql := CONCAT_WS('', 'SELECT ', tblname, '.rec_create_date FROM ', tblname, ' WHERE ', pk, ' = :1');
    EXECUTE dsql INTO STRICT rcdate USING prkey;

    IF oracle.TRUNC(rcdate) > tdate THEN
        rvalue := 'N/A (record created after date)';
    ELSE
        /* Find out how many changes have been made */
        SELECT
            COUNT(al.audit_log_id)
            INTO STRICT nchanges
            /* FROM audit_log_column alc,audit_log al */
            FROM audit.audit_log_column AS alc
            JOIN audit.audit_log AS al
                ON alc.audit_log_id = al.audit_log_id
            WHERE alc.column_name = fldname AND
            /* and alc.audit_log_id = al.audit_log_id */
            al.action_code IN ('U') AND al.table_name = tblname AND oracle.TRUNC(al.audit_date) > tdate AND al.primary_key_id = prkey;

        IF nchanges = 0 THEN
            /* If there haven't been any changes, then get the current value of the field. */
            /* (note that we need two methods, one for CLOB fields, one for other types) */
            IF dtype = 'CLOB' THEN
                dsql := CONCAT_WS('', 'SELECT DBMS_LOB.SUBSTR(', fldname, ',4000,1)', ' FROM ', tblname, ' WHERE ', pk, ' = ', prkey);
            ELSE
                dsql := CONCAT_WS('', 'SELECT ', fldname, ' FROM ', tblname, ' WHERE ', pk, ' = ', prkey);
            END IF;
            EXECUTE dsql INTO STRICT rvalue;
        ELSE
            /* There are changes, so get the old value from the first mod after the date */
            SELECT
                alc.old_value
                INTO STRICT rvalue
                FROM audit.audit_log_column AS alc
                WHERE alc.column_name = fldname AND alc.audit_log_id = (SELECT
                    MIN(al.audit_log_id)
                    /* takes advantage of the fact that audit_log_ids are sequential in time */
                    /* From audit_log al, audit_log_column alc */
                    FROM audit.audit_log_column AS alc
                    JOIN audit.audit_log AS al
                        ON alc.audit_log_id = al.audit_log_id
                    WHERE alc.column_name = fldname AND
                    /* and alc.audit_log_id = al.audit_log_id */
                    al.action_code IN ('U') AND al.table_name = tblname AND oracle.TRUNC(al.audit_date) > tdate AND al.primary_key_id = prkey
                    GROUP BY al.primary_key_id);
        END IF;
    END IF;

    IF rvalue IS NULL THEN
        /* previously line below returned the text 'null', fdp changed 20151015 to return NULL */
        RETURN (NULL);
    ELSE
        RETURN (rvalue);
    END IF;
    EXCEPTION
        WHEN no_data_found THEN
            RAISE USING hint = -20001, message = 'Parameter error - bad table or field name!', detail = 'User-defined exception';
        WHEN others THEN
            RAISE USING hint = -20002, message = 'Unknown function error!', detail = 'User-defined exception';
            RETURN (NULL);
END;
$BODY$
LANGUAGE  plpgsql;


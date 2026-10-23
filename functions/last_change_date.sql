CREATE OR REPLACE FUNCTION ext.last_change_date(IN tbl TEXT, IN fld TEXT, IN prkey BIGINT)
RETURNS TIMESTAMP WITH TIME ZONE
AS
$BODY$
DECLARE
    last_date TIMESTAMP(0) WITHOUT TIME ZONE;
BEGIN
    SELECT
        MAX(al.audit_date)
        INTO STRICT last_date
        FROM
        /* EO */
        /* LEFT OUTER JOIN */
        audit.audit_log AS al
        LEFT OUTER JOIN
        /* ON EO.EO_ID = al.primary_key_id */
        audit.audit_log_column AS alc
            ON al.audit_log_id = alc.audit_log_id
        WHERE al.table_name = tbl AND alc.column_name = fld AND
        /* EO_ID = prkey; */
        al.primary_key_id = prkey;
    RETURN (last_date);
END;
$BODY$
LANGUAGE  plpgsql;


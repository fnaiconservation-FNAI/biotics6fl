CREATE OR REPLACE  VIEW ext.nhp_auditlog_sciname_vw (element_subnational_id, old_value, scientific_name) AS
SELECT
    core.element_subnational.element_subnational_id, audit.audit_log_column.old_value, core.scientific_name.scientific_name
    FROM core.scientific_name, core.element_subnational, audit.audit_log, audit.audit_log_column
    WHERE audit.audit_log_column.column_name = 'SNAME_ID' AND oracle.to_number(audit.audit_log_column.old_value) = core.scientific_name.scientific_name_id AND audit.audit_log.primary_key_id = core.element_subnational.element_subnational_id AND audit.audit_log.audit_log_id = audit.audit_log_column.audit_log_id;


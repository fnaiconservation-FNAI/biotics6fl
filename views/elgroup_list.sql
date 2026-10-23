CREATE OR REPLACE  VIEW ext.elgroup_list (elgroup) AS
SELECT DISTINCT
    ext.elgroup_name(element_subnational_id) AS elgroup
    FROM core.element_subnational
    WHERE d_eo_track_status_id IN (1, 2, 3)
    ORDER BY ext.elgroup_name(element_subnational_id);


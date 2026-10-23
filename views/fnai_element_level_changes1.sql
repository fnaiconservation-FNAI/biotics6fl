CREATE OR REPLACE  VIEW ext.fnai_element_level_changes1 (el_id, sort_order, element_group, begin_date, end_date, sname, comm_name, change_type, begin_value, end_value) AS
SELECT
    est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'G rank' AS change_type, ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd')) AS begin_value, ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd')) AS end_value
    FROM core.element_subnational AS est, core.element_national AS ent, core.element_global AS egt
    WHERE ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, (SELECT
        oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))) AND ext.value_on_date('ELEMENT_GLOBAL'::TEXT, 'G_RANK'::TEXT, egt.element_global_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> 'N/A (new record)' AND /* suppress new recs */ egt.element_global_id = ent.element_global_id AND ent.element_national_id = est.element_national_id AND est.d_eo_track_status_id IN (1, 2)
UNION
/* ***********      SRANK       ****************************************************** */
SELECT
    est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'S rank' AS change_type, ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd')) AS begin_value, ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd')) AS end_value
    FROM core.element_subnational AS est
    WHERE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_RANK'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> 'N/A (new record)' AND /* suppress new recs */ est.d_eo_track_status_id IN (1, 2)
UNION
/*
***********   FEDERAL STATUS   ****************************************************
Here we have to account for changes to the fed and state interpreted fed status as
well as the main fed status. We won't try and deal with the eo_interpreted level.
Most of the work here is performed by the "USESA_on_date" function.
*/
SELECT
    est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Federal status' AS change_type, ext.usesa_on_date(est.element_subnational_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd')) AS begin_value, ext.usesa_on_date(est.element_subnational_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd')) AS end_value
    FROM core.element_subnational AS est
    WHERE ext.usesa_on_date(est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> ext.usesa_on_date(est.element_subnational_id, (SELECT
        oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))) AND ext.usesa_on_date(est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> 'N/A (new record)' AND est.d_eo_track_status_id IN (1, 2)
UNION
/* *********** STATE PROTECTION STATUS *********************************************** */
SELECT
    est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'State status' AS change_type,
    CASE
        WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd')) = 'null' THEN 'no status'
        ELSE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))
    END AS begin_value,
    CASE
        WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd')) = 'null' THEN 'no status'
        ELSE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))
    END AS end_value
    FROM core.element_subnational AS est
    WHERE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'S_PROTECTION_STATUS'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> 'N/A (new record)' AND /* suppress new recs */ est.d_eo_track_status_id IN (1, 2)
UNION
/*
***********  SCIENTIFIC NAME  *****************************************************
There are 3 ways a scientific name can change.
1) For an element in the EST, the SNAME_ID can be changed to attach a new name to it
2) Within the scientific_name table, the spelling of the name can change
3) EOs can be reparented to a new species name (since this is not a change at the
   element level this kind of change will not be treated here)
The first section below deals with changes of the first type.
*/
SELECT
    est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Scientific name' AS change_type, shared.delimlist(CONCAT_WS('', 'SELECT substr(sn.scientific_name,1,50) from scientific_name sn ', 'WHERE sn.scientific_name_id = ', 'to_number(value_on_date(''ELEMENT_SUBNATIONAL'',''SNAME_ID'', ', est.element_subnational_id, ', to_date(''2007-12-13'',''yyyy-mm-dd'')))')) AS begin_value, shared.delimlist(CONCAT_WS('', 'SELECT substr(sn.scientific_name,1,50) from scientific_name sn ', 'WHERE sn.scientific_name_id = ', 'to_number(value_on_date(''ELEMENT_SUBNATIONAL'',''SNAME_ID'', ', est.element_subnational_id, ', to_date(''2010-08-01'',''yyyy-mm-dd'')))')) AS end_value
    FROM core.element_subnational AS est
    WHERE ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'SNAME_ID'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> 'N/A (new record)' AND /* suppress the new records */ est.d_eo_track_status_id IN (1, 2)
UNION
/* The next section deals with changes of the second type. */
SELECT
    est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Scientific name' AS change_type, ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd')) AS begin_value, ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd')) AS end_value
    FROM core.element_subnational AS est, core.scientific_name AS sn
    WHERE ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, (SELECT
        oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))) AND ext.value_on_date('SCIENTIFIC_NAME'::TEXT, 'SCIENTIFIC_NAME'::TEXT, sn.scientific_name_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> 'N/A (new record)' AND /* suppress the new records */ sn.scientific_name_id = est.sname_id AND est.d_eo_track_status_id IN (1, 2)
UNION
/*
***********  COMMON NAME  *****************************************************
This section deals with changes in the ELEMENT_SUBNATIONAL.S_PRIMARY_COMMON_NAME field
*/
SELECT
    est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Common name' AS change_type, ext.value_on_date('element_subnational'::TEXT, 's_primary_common_name'::TEXT, est.element_subnational_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd')) AS begin_value, ext.value_on_date('element_subnational'::TEXT, 's_primary_common_name'::TEXT, est.element_subnational_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd')) AS end_value
    FROM core.element_subnational AS est
    WHERE ext.value_on_date('element_subnational'::TEXT, 's_primary_common_name'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> ext.value_on_date('element_subnational'::TEXT, 's_primary_common_name'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))) AND ext.value_on_date('element_subnational'::TEXT, 's_primary_common_name'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) <> 'N/A (new record)' AND /* suppress the new records */
    /* and sn.scientific_name_id = est.sname_id */
    est.d_eo_track_status_id IN (1, 2)
UNION
/*
*********** TRACKING STATUS ******************************************************
This is the only group where we will include NEW records if they are now tracked, and
it is the only group where we WILL include elements that we don't now track, if the
tracking status change was to DISCONTINUE tracking.
*/
SELECT
    est.element_subnational_id AS el_id, ext.elgroup_sort_order(est.element_subnational_id) AS sort_order, ext.elgroup_name(est.element_subnational_id) AS element_group, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd') AS begin_date, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd') AS end_date, ext.sci_name(est.element_subnational_id) AS sname, oracle.substr(est.s_primary_common_name, 1, 50) AS comm_name, 'Tracking status' AS change_type,
    CASE
        WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd')) = '1' THEN 'Full tracking'
        WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd')) = '2' THEN 'Partial tracking'
        WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd')) = '3' THEN 'Watch list'
        ELSE 'Not tracked'
    END AS begin_value,
    CASE
        WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd')) = '1' THEN 'Full tracking'
        WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd')) = '2' THEN 'Partial tracking'
        WHEN ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd')) = '3' THEN 'Watch list'
        ELSE 'Not tracked'
    END AS end_value
    FROM core.element_subnational AS est
    WHERE (((ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) NOT IN ('1', '2')) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))) IN ('1', '2')) OR ((ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2007-12-13', 'yyyy-mm-dd'))) IN ('1', '2')) AND ext.value_on_date('ELEMENT_SUBNATIONAL'::TEXT, 'D_EO_TRACK_STATUS_ID'::TEXT, est.element_subnational_id, (SELECT
        oracle.TO_DATE('2010-08-01', 'yyyy-mm-dd'))) NOT IN ('1', '2')))
    ORDER BY sort_order, sname, change_type;


CREATE OR REPLACE  VIEW ext.fnai_infraspecies_parent (est_id, sname_id, scientific_name, d_eo_track_status_id, classification_level_name, d_classification_level_id, parent_name_id, parent_name) AS
SELECT
    est.element_subnational_id AS est_id, est.sname_id, sn.scientific_name, est.d_eo_track_status_id, cl.classification_level_name, cl.d_classification_level_id, sn.parent_name_id, psn.scientific_name AS parent_name
    FROM core.element_subnational AS est
    JOIN core.scientific_name AS sn
        ON sn.scientific_name_id = est.sname_id
    LEFT OUTER JOIN domain.d_classification_level AS cl
        ON sn.d_classification_level_id = cl.d_classification_level_id
    LEFT OUTER JOIN core.scientific_name AS psn
        ON sn.parent_name_id = psn.scientific_name_id
    WHERE ext.textbefore(sn.scientific_name, ' '::TEXT, 2) = psn.scientific_name
UNION ALL
SELECT
    est.element_subnational_id, est.sname_id, sn.scientific_name, est.d_eo_track_status_id, cl.classification_level_name, cl.d_classification_level_id, sn2.scientific_name_id AS parent_name_id, sn2.scientific_name AS parent_name
    FROM core.element_subnational AS est
    JOIN core.scientific_name AS sn
        ON sn.scientific_name_id = est.sname_id
    LEFT OUTER JOIN domain.d_classification_level AS cl
        ON sn.d_classification_level_id = cl.d_classification_level_id
    LEFT OUTER JOIN core.scientific_name AS psn
        ON sn.parent_name_id = psn.scientific_name_id
    LEFT OUTER JOIN core.scientific_name AS sn2
        ON ext.textbefore(sn.scientific_name, ' '::TEXT, 2) = sn2.scientific_name
    WHERE (ext.textbefore(sn.scientific_name, ' '::TEXT, 2) <> psn.scientific_name OR psn.scientific_name IS NULL) AND cl.classification_level_keyword = 'INFRASPECIES';


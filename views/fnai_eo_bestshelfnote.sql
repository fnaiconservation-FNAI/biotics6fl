CREATE OR REPLACE  VIEW ext.fnai_eo_bestshelfnote (eo_id, bestshelf) AS
SELECT
    eo.eo_id AS eo_id,
    CASE
        WHEN shared.delimlist(CONCAT_WS('', 'SELECT erf.eo_reference_primary_ind FROM eo_reference erf', ' WHERE erf.eo_id =', eo.eo_id), ','::TEXT) IS NULL THEN NULL
        ELSE
        CASE
            WHEN oracle.INSTR(shared.delimlist(CONCAT_WS('', 'SELECT erf.eo_reference_primary_ind FROM
  		                     eo_reference erf', ' WHERE erf.eo_id(+) =', eo.eo_id), ','::TEXT), 'Y', 1, 1) = 0 THEN NULL
            ELSE oracle.substr(shared.delimlist(CONCAT_WS('', 'SELECT rf.shelf_note FROM reference rf,
                           eo_reference erf', ' WHERE erf.eo_reference_primary_ind = ''Y''
                           and rf.reference_id = erf.reference_id and erf.eo_id(+) =', eo.eo_id), ','::TEXT), 1, 254)
        END
    END AS bestshelf
    FROM core.eo AS eo, core.element_subnational AS est
    WHERE eo.element_subnational_id = est.element_subnational_id AND est.d_eo_track_status_id = 1 /* tracked elements only */;


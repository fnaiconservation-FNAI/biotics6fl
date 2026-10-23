CREATE OR REPLACE  VIEW ext.fnai_reference_keyword_view (reference_id, keywords) AS
SELECT
    rf.reference_id, shared.delimlist(CONCAT_WS('', 'SELECT drk.reference_keyword
       FROM d_reference_keyword drk, reference_keyword rk', ' WHERE drk.d_reference_keyword_id(+)
        = rk.d_reference_keyword_id and rk.reference_id(+)
         =', rf.reference_id), ', '::TEXT) AS keywords
    FROM core.reference AS rf
/* where rf.reference_id = 176794  \* test line * / */
;


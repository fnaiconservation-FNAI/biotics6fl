CREATE OR REPLACE FUNCTION ext.chk_eo_refs(IN eo_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    DECLARE
        v_bad_refs CHARACTER VARYING(4000);
    BEGIN
        SELECT
            STRING_AGG(CONCAT_WS('', '<a href="https://bioticsfl.natureserve.org/biotics/services/page/Reference/', ref.reference_id, '.html" target="_blank">', ref.reference_code, '</a>'), ', '::TEXT ORDER BY reference_code) AS codes_for_bad_refs
            INTO STRICT v_bad_refs
            FROM core.eo_reference AS eo_ref
            LEFT OUTER JOIN core.reference AS ref
                ON eo_ref.reference_id = ref.reference_id
            WHERE eo_id = eo_id_arg AND
            /* all refs must end in FLUS */
            /* NOT (REGEXP_LIKE(REFERENCE_CODE, '\d\dFLUS$','c')) */
            (NOT (regexp_like((reference_code)::TEXT, (E'\\d\\dFLUS$|(AU|SM|FS|UF|AM)FLUS$')::TEXT, 'c')) OR
            /* ref codes must be 12 char long */
            LENGTH(reference_code) <> 12 OR
            /* all refs must have a full citation */
            full_citation IS NULL OR
            /* non-PND refs must have a short citation author and year */
            (reference_code NOT LIKE 'PND%' AND reference_code NOT LIKE 'WND%' AND (short_citation_author IS NULL OR short_citation_year IS NULL)) OR
            /* non-specimen and non-PND refs must have a shelf note */
            ((reference_code NOT LIKE 'S%' AND reference_code NOT LIKE 'PND%') AND (shelf_note IS NULL)))
            /* OR */
            /* -- ref must have a version author name */
            /* ( */
            /* (VERSION_AUTHOR_NAME IS NULL AND REF.REC_CREATE_DATE >= TO_DATE('2025-09-01', 'YYYY-MM-DD')) */
            /* OR */
            /* (VERSION_AUTHOR_NAME IS NULL AND REF.REC_LAST_MOD_DATE >= TO_DATE('2025-09-01', 'YYYY-MM-DD') AND REF.REC_LAST_MOD_USER <> 'BIOTICS_DLINK') */
            /* ) */
            GROUP BY eo_id;
        RETURN v_bad_refs;
    END;
END;
$BODY$
LANGUAGE  plpgsql;


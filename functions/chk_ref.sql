CREATE OR REPLACE FUNCTION ext.chk_ref(IN ref_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
BEGIN
    DECLARE
        v_ref_chk CHARACTER VARYING(1);
    BEGIN
        SELECT
            CASE
                /* all refs must end in FLUS */
                /* NOT (REGEXP_LIKE(REFERENCE_CODE, '\d\dFLUS$','c')) */
                WHEN NOT (regexp_like((reference_code)::TEXT, (E'\\d\\dFLUS$|(AU|SM|FS|UF|AM)FLUS$')::TEXT, 'c')) OR
                /* ref codes must be 12 char long */
                LENGTH(reference_code) <> 12 OR
                /* all refs must have a full citation */
                full_citation IS NULL OR
                /* non-PND refs must have a short citation author and year */
                (reference_code NOT LIKE 'PND%' AND reference_code NOT LIKE 'SND%' AND reference_code NOT LIKE 'MND%' AND reference_code NOT LIKE 'UND%' AND reference_code NOT LIKE 'WND%' AND reference_code NOT LIKE 'AND%' AND (short_citation_author IS NULL OR short_citation_year IS NULL)) OR
                /* non-specimen and non-PND refs must have a shelf note */
                ((reference_code NOT LIKE 'S%' AND reference_code NOT LIKE 'PND%') AND (shelf_note IS NULL)) THEN
                /* OR */
                /* -- ref must have a version author name */
                /* ( */
                /* (VERSION_AUTHOR_NAME IS NULL AND REC_CREATE_DATE >= TO_DATE('2025-09-01', 'YYYY-MM-DD')) */
                /* OR */
                /* (VERSION_AUTHOR_NAME IS NULL AND REC_LAST_MOD_DATE >= TO_DATE('2025-09-01', 'YYYY-MM-DD') AND REC_LAST_MOD_USER <> 'BIOTICS_DLINK') */
                /* ) */
                'N'
                ELSE 'Y'
            END AS chk
            INTO STRICT v_ref_chk
            FROM core.reference AS ref
            WHERE ref.reference_id = ref_id_arg;
        RETURN v_ref_chk;
    END;
END;
$BODY$
LANGUAGE  plpgsql;


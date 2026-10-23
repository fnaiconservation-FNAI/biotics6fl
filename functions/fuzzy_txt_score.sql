CREATE OR REPLACE FUNCTION ext.fuzzy_txt_score(IN str1 TEXT, IN str2 TEXT)
RETURNS DOUBLE PRECISION
AS
$BODY$
/* Local cleaned strings */
DECLARE
    clean1 CHARACTER VARYING(4000);
    clean2 CHARACTER VARYING(4000);
    /* Sorted versions of cleaned strings */
    sorted1 CHARACTER VARYING(4000);
    sorted2 CHARACTER VARYING(4000);
    /* Result score */
    score DOUBLE PRECISION;
    /* Helper: sort tokens within a string alphabetically */
BEGIN
    /* Handle NULLs early */
    IF str1 IS NULL OR str2 IS NULL THEN
        RETURN NULL;
    END IF;
    /* Normalize: lowercase, remove punctuation, collapse spaces */
    clean1 := regexp_replace((LOWER(str1))::TEXT, ('[^a-z0-9 ]')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    clean1 := regexp_replace((clean1)::TEXT, (' +')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    clean1 := TRIM(clean1);
    clean2 := regexp_replace((LOWER(str2))::TEXT, ('[^a-z0-9 ]')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    clean2 := regexp_replace((clean2)::TEXT, (' +')::TEXT, coalesce((' ')::TEXT, ''), (1)::INTEGER, (0)::INTEGER);
    clean2 := TRIM(clean2);
    /* Token sort (handles “Musson, Curtis” vs “Curtis Musson”) */
    sorted1 := ext.fuzzy_txt_score$sort_tokens$4c56f3f0(clean1);
    sorted2 := ext.fuzzy_txt_score$sort_tokens$4c56f3f0(clean2);
    /* Compute Jaro-Winkler similarity (0–100) */
    score := aws_oracle_ext.utl_match$jaro_winkler(sorted1, sorted2);
    RETURN score;
END;
$BODY$
LANGUAGE  plpgsql IMMUTABLE;


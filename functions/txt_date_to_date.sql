CREATE OR REPLACE FUNCTION ext.txt_date_to_date(IN t_date TEXT)
RETURNS TIMESTAMP WITH TIME ZONE
AS
$BODY$
BEGIN
    RETURN
    CASE
        WHEN t_date IS NOT NULL AND ext.chk_date(t_date) = 1 AND
        /* 'YYYY-MM-DD' */
        ext.chk_txt_date(t_date) LIKE 'Valid%' THEN oracle.TO_DATE(t_date::TEXT, 'YYYY-MM-DD')
        WHEN t_date IS NOT NULL AND ext.chk_txt_date(t_date) LIKE 'Valid%' AND regexp_like((t_date)::TEXT, (E'^\\d{4}-(0[1-9]|1[0-2])$')::TEXT) THEN
        /* 'YYYY-MM' */
        oracle.TO_DATE((CONCAT_WS('', t_date, '-01'))::TEXT, 'YYYY-MM-DD')
        WHEN t_date IS NOT NULL AND ext.chk_txt_date(t_date) LIKE 'Valid%' AND regexp_like((t_date)::TEXT, (E'^\\d{4}-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1]) -- \\d{4}-\\d{2}-\\d{2}$')::TEXT) THEN
        /* 'YYYY-MM-DD -- YYYY-MM-DD' */
        oracle.TO_DATE(oracle.substr(t_date, 1, 10)::TEXT, 'YYYY-MM-DD')
        WHEN t_date IS NOT NULL AND ext.chk_txt_date(t_date) LIKE 'Valid%' AND regexp_like((t_date)::TEXT, (E'^\\d{4}-(0[1-9]|1[0-2]) -- \\d{4}-\\d{2}$')::TEXT) THEN
        /* 'YYYY-MM -- YYYY-MM' */
        oracle.TO_DATE(CONCAT_WS('', oracle.substr(t_date, 1, 7), '-01')::TEXT, 'YYYY-MM-DD')
        WHEN t_date IS NOT NULL AND ext.chk_txt_date(t_date) LIKE 'Valid%' AND regexp_like((t_date)::TEXT, (E'^\\d{4}-(0[1-9]|1[0-2]) ')::TEXT) THEN
        /* 'YYYY-MM %' */
        oracle.TO_DATE(CONCAT_WS('', oracle.substr(t_date, 1, 7), '-01')::TEXT, 'YYYY-MM-DD')
        WHEN t_date IS NOT NULL AND ext.chk_txt_date(t_date) LIKE 'Valid%' AND regexp_like((t_date)::TEXT, (E'^\\d{4}-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1]) ')::TEXT) THEN
        /* 'YYYY-MM-DD %' */
        oracle.TO_DATE(oracle.substr(t_date, 1, 10)::TEXT, 'YYYY-MM-DD')
        WHEN t_date IS NOT NULL AND ext.chk_txt_date(t_date) LIKE 'Valid%' AND regexp_like((t_date)::TEXT, (E'^\\d{4}')::TEXT) THEN
        /* 'YYYY %' */
        oracle.TO_DATE(CONCAT_WS('', oracle.substr(t_date, 1, 4), '-01', '-01')::TEXT, 'YYYY-MM-DD')
        ELSE NULL
    END;
END;
$BODY$
LANGUAGE  plpgsql;


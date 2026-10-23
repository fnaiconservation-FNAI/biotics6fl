CREATE OR REPLACE FUNCTION ext.crystal_r_new_line(IN p_text TEXT)
RETURNS TEXT
AS
$BODY$
BEGIN
    RETURN regexp_replace((p_text)::TEXT, (E'<br\\s*/?>')::TEXT, coalesce(('<br>')::TEXT, ''), (1)::INTEGER, (0)::INTEGER, 'i');
END;
$BODY$
LANGUAGE  plpgsql;


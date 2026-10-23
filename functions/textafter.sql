CREATE OR REPLACE FUNCTION ext.textafter(IN cstring TEXT, IN delimiter TEXT, IN instance INTEGER DEFAULT 1)
RETURNS TEXT
AS
$BODY$
/* Input string */
/* Delimiter to search for */
/* Which occurrence to use (default is first) */
DECLARE
    rstring CHARACTER VARYING(4000);
    pos INTEGER;
BEGIN
    /* Find the position of the nth occurrence of the delimiter */
    pos := oracle.INSTR(cstring, delimiter, 1, TRUNC(instance::NUMERIC)::INTEGER);
    /* If the delimiter isn't found, return inpit string */

    IF pos = 0 THEN
        RETURN cstring;
    END IF;
    /* Extract substring after the specified occurrence of the delimiter */
    rstring := oracle.substr(cstring, pos + LENGTH(delimiter));
    /* Return the result */
    RETURN rstring;
END;
$BODY$
LANGUAGE  plpgsql;


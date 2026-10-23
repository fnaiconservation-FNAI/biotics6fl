CREATE OR REPLACE FUNCTION ext.sci_name_w_author(IN sciname_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    sname CHARACTER VARYING(100);
    author CHARACTER VARYING(100);
    varssp CHARACTER VARYING(6);
    gsname CHARACTER VARYING(100);
    gsauthor CHARACTER VARYING(100);
    fullfrmname CHARACTER VARYING(200);
    varPos INTEGER;
    sspPos INTEGER;
    formaPos INTEGER;
BEGIN
    varPos := 0;
    sspPos := 0;
    formaPos := 0;
    fullfrmname := '';
    SELECT
        TRIM(sn.scientific_name), sn.author_name
        INTO STRICT sname, author
        FROM core.scientific_name AS sn
        WHERE sn.scientific_name_id = sciname_id_arg;
    varPos := oracle.INSTR(sname, ' var. ');

    IF varPos > 0 THEN
        varssp := ' var. ';
    END IF;
    sspPos := oracle.INSTR(sname, ' ssp. ');

    IF sspPos > 0 THEN
        varssp := ' ssp. ';
    END IF;
    formaPos := oracle.INSTR(sname, ' forma ');

    IF (varPos + sspPos + formaPos > 0) THEN
        gsname := oracle.substr(sname, 1, varPos + sspPos + formaPos - 1);
        SELECT
            sn.author_name
            INTO STRICT gsauthor
            FROM core.scientific_name AS sn
            WHERE sn.scientific_name = gsname;

        IF (varPos + sspPos > 0) THEN
            fullfrmname := CONCAT_WS('', '<i>', gsname, '</i> ', gsauthor, varssp, '<i>');
            fullfrmname := CONCAT_WS('', fullfrmname, TRIM(oracle.substr(sname, varPos + sspPos + 6, 50)), '</i> ', author);
        ELSE
            fullfrmname := CONCAT_WS('', '<i>', gsname, '</i> ', gsauthor, '<i> ');
            fullfrmname := CONCAT_WS('', fullfrmname, TRIM(oracle.substr(sname, formaPos + 1, 50)), '</i> ', author);
        END IF;
    ELSE
        fullfrmname := CONCAT_WS('', '<i>', sname, '</i> ', author);
    END IF;
    RETURN (fullfrmname);
END;
$BODY$
LANGUAGE  plpgsql;


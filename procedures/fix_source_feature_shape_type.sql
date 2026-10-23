CREATE OR REPLACE PROCEDURE ext.fix_source_feature_shape_type(IN start_sf_id BIGINT)
AS 
$BODY$
DECLARE
    v_curr_pre_shape_type CHARACTER VARYING(7);
    v_curr_shape_type CHARACTER VARYING(7);
    v_shape_exists BIGINT;
    v_pre_shape_found INTEGER;
BEGIN
    CALL aws_oracle_ext.dbms_output$enable(buffer_size => 1000000);
    SELECT
        sf.pre_shape_type, sf.shape_type
        INTO STRICT v_curr_pre_shape_type, v_curr_shape_type
        FROM core.source_feature AS sf
        WHERE sf.source_feature_id = start_sf_id;
    v_pre_shape_found := 1;
    CALL aws_oracle_ext.dbms_output$put_line(a => 'Checking pre pts for geometry');
    SELECT
        COUNT(*)
        INTO STRICT v_shape_exists
        FROM core.source_feature_pre_pt AS shp
        WHERE shp.source_feature_id = start_sf_id;

    IF (v_shape_exists > 0) THEN
        CALL aws_oracle_ext.dbms_output$put_line(a => 'Has a pt pre type');
        UPDATE core.source_feature AS sf
        SET pre_shape_type = 'point'
            WHERE sf.source_feature_id = start_sf_id;
        UPDATE core.shape AS shp
        SET has_shape_ind = 'Y'
            WHERE shp.shape_id IN (SELECT
                sf.shape_id
                FROM core.source_feature AS sf
                WHERE sf.source_feature_id = start_sf_id);
    ELSE
        CALL aws_oracle_ext.dbms_output$put_line(a => 'Checking pre liness for geometry');
        SELECT
            COUNT(*)
            INTO STRICT v_shape_exists
            FROM core.source_feature_pre_line AS shp
            WHERE shp.source_feature_id = start_sf_id;

        IF (v_shape_exists > 0) THEN
            CALL aws_oracle_ext.dbms_output$put_line(a => 'Has a line pre type');
            UPDATE core.source_feature AS sf
            SET pre_shape_type = 'line'
                WHERE sf.source_feature_id = start_sf_id;
            UPDATE core.shape AS shp
            SET has_shape_ind = 'Y'
                WHERE shp.shape_id IN (SELECT
                    sf.shape_id
                    FROM core.source_feature AS sf
                    WHERE sf.source_feature_id = start_sf_id);
        ELSE
            CALL aws_oracle_ext.dbms_output$put_line(a => 'Checking pre polys for geometry');
            SELECT
                COUNT(*)
                INTO STRICT v_shape_exists
                FROM core.source_feature_pre_poly AS shp
                WHERE shp.source_feature_id = start_sf_id;

            IF (v_shape_exists > 0) THEN
                CALL aws_oracle_ext.dbms_output$put_line(a => 'Has a poly pre type');
                UPDATE core.source_feature AS sf
                SET pre_shape_type = 'polygon'
                    WHERE sf.source_feature_id = start_sf_id;
                UPDATE core.shape AS shp
                SET has_shape_ind = 'Y'
                    WHERE shp.shape_id IN (SELECT
                        sf.shape_id
                        FROM core.source_feature AS sf
                        WHERE sf.source_feature_id = start_sf_id);
            ELSE
                CALL aws_oracle_ext.dbms_output$put_line(a => 'Has no pre shape type and should be null');
                UPDATE core.source_feature AS sf
                SET pre_shape_type = NULL
                    WHERE sf.source_feature_id = start_sf_id;
                UPDATE core.shape AS shp
                SET has_shape_ind = 'N'
                    WHERE shp.shape_id IN (SELECT
                        sf.shape_id
                        FROM core.source_feature AS sf
                        WHERE sf.source_feature_id = start_sf_id);
                v_pre_shape_found := 0;
            END IF;
        END IF;
    END IF;

    IF (v_pre_shape_found > 0) THEN
        CALL aws_oracle_ext.dbms_output$put_line(a => 'Checking pts for geometry');
        SELECT
            COUNT(*)
            INTO STRICT v_shape_exists
            FROM core.source_feature_pt AS shp
            WHERE shp.source_feature_id = start_sf_id;

        IF (v_shape_exists > 0) THEN
            CALL aws_oracle_ext.dbms_output$put_line(a => 'Has a pt type');
            UPDATE core.source_feature AS sf
            SET shape_type = 'point'
                WHERE sf.source_feature_id = start_sf_id;
        ELSE
            CALL aws_oracle_ext.dbms_output$put_line(a => 'Checking liness for geometry');
            SELECT
                COUNT(*)
                INTO STRICT v_shape_exists
                FROM core.source_feature_line AS shp
                WHERE shp.source_feature_id = start_sf_id;

            IF (v_shape_exists > 0) THEN
                CALL aws_oracle_ext.dbms_output$put_line(a => 'Has a line type');
                UPDATE core.source_feature AS sf
                SET shape_type = 'line'
                    WHERE sf.source_feature_id = start_sf_id;
            ELSE
                CALL aws_oracle_ext.dbms_output$put_line(a => 'Checking polys for geometry');
                SELECT
                    COUNT(*)
                    INTO STRICT v_shape_exists
                    FROM core.source_feature_poly AS shp
                    WHERE shp.source_feature_id = start_sf_id;

                IF (v_shape_exists > 0) THEN
                    CALL aws_oracle_ext.dbms_output$put_line(a => 'Has a poly type');
                    UPDATE core.source_feature AS sf
                    SET shape_type = 'polygon'
                        WHERE sf.source_feature_id = start_sf_id;
                ELSE
                    CALL aws_oracle_ext.dbms_output$put_line(a => 'ERROR: Has no shape type but had a pre shape type! Setting to null, but should be examined.');
                    UPDATE core.source_feature AS sf
                    SET shape_type = NULL
                        WHERE sf.source_feature_id = start_sf_id;
                END IF;
            END IF;
        END IF;
    ELSE
        CALL aws_oracle_ext.dbms_output$put_line(a => 'Has no pre shape type and so shape type should also be null');
        UPDATE core.source_feature AS sf
        SET shape_type = NULL
            WHERE sf.source_feature_id = start_sf_id;
    END IF;
END;
$BODY$
LANGUAGE plpgsql;


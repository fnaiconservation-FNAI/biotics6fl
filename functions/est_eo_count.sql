CREATE OR REPLACE FUNCTION ext.est_eo_count(IN est_id BIGINT, IN sep_dist DOUBLE PRECISION)
RETURNS BIGINT
AS
$BODY$
DECLARE
    est_eo_cnt BIGINT;
    union_geom GEOMETRY;
    id BIGINT;
BEGIN
    /* important to set EXTRACT_ALL param to 0 or separate polys are created for internal rings */
    
    /*
    [5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDOAGGRTYPE function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_AGGR_UNION(MDSYS.SDOAGGRTYPE) function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDOAGGRTYPE function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_AGGR_UNION(MDSYS.SDOAGGRTYPE) function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDOAGGRTYPE function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_AGGR_UNION(MDSYS.SDOAGGRTYPE) function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDOAGGRTYPE function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_AGGR_UNION(MDSYS.SDOAGGRTYPE) function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDOAGGRTYPE function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_AGGR_UNION(MDSYS.SDOAGGRTYPE) function. Revise your code to use another function or create a user-defined function., 5340 - Severity CRITICAL - PostgreSQL doesn't support the MDSYS.SDO_UTIL.SIMPLIFY(MDSYS.SDO_GEOMETRY,NUMBER,NUMBER) function. Revise your code to use another function or create a user-defined function., 5578 - Severity CRITICAL - DMS SC can't convert the SELECT statement. Revise your SELECT statement and try again.]
    select GEOM_ARRAY_COUNT(SDO_UTIL.EXTRACT_ALL(BUFFS,0)) into est_eo_cnt
    FROM
    (select SDO_AGGR_UNION(SDOAGGRTYPE(BUFFS, 0.01)) as BUFFS FROM
        (select SDO_AGGR_UNION(SDOAGGRTYPE(BUFFS, 0.01)) as BUFFS FROM
            (select SDO_AGGR_UNION(SDOAGGRTYPE(BUFFS, 0.01)) as BUFFS FROM
                (select SDO_AGGR_UNION(SDOAGGRTYPE(BUFFS, 0.01)) as BUFFS FROM
                        (
                        select
                        SDO_AGGR_UNION(SDOAGGRTYPE(SUBQRY.BUFFS, 0.01)) as BUFFS
                        from
                                (
                                select
                                -- line below fails (buffers are null) for some features, simplify fixes the problem
    --                            SDO_GEOM.SDO_BUFFER(SF_PROJ.SHAPE,sep_dist/2,0.01)
                                SDO_GEOM.SDO_BUFFER(SDO_UTIL.simplify(SF_SHP.SHAPE,0.001,0.0001),sep_dist/2,0.01)
                                AS BUFFS
                                from FNAI_SRC_SHAPES SF_SHP
                                left outer join SOURCE_FEATURE SF
                                on SF_SHP.SOURCE_FEATURE_ID = SF.SOURCE_FEATURE_ID
                                WHERE SF.ELEMENT_SUBNATIONAL_ID = est_id
                                ) subqry
                GROUP BY MOD (ROWNUM, 128))
            GROUP BY MOD (ROWNUM, 32))
        GROUP BY MOD (ROWNUM, 8))
    GROUP BY MOD (ROWNUM, 2))
    )
    */
    RETURN est_eo_cnt;
END;
$BODY$
LANGUAGE  plpgsql;


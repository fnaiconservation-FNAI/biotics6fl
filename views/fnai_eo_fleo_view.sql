CREATE OR REPLACE  VIEW ext.fnai_eo_fleo_view (shape, eo_id, feature_id, elcode, eo_number, sname, scomname, datasens, eorank, eorank_dt, grank, srank, federal, sprot, lastobs, description, eodata, id_confirmed, bestsource, maname, county, eosize_ac, rep_acc, loc_uncert, qc_stat, symb, qtr_update, maplabelds, maplabel) AS
/* SDO_UTIL.TO_WKBGEOMETRY(MDSYS.SDO_CS.TRANSFORM */
/* (EO_SHAPE.SHAPE,0.005,1000105)) AS SHP, */
SELECT
    shape, core.eo.eo_id AS eo_id, core.eo.shape_id AS feature_id, oracle.substr(egt.elcode_bcd, 1, 10) AS elcode, ext.report_eonum(core.eo.eo_id) AS eo_number, ext.sci_name(est.element_subnational_id) AS sname,
    CASE
        WHEN est.s_primary_common_name IS NULL THEN 'ZZ'
        ELSE oracle.substr(est.s_primary_common_name, 1, 60)
    END AS scomname,
    /* case when est.s_data_sensitive_ind = 'Y' then 'Y' */
    /* else eo.data_sensitive_eo_ind */
    /* end as datasens, */
    CASE
        WHEN est.d_data_sensitive_id = 1 THEN 'Y'
        ELSE
        CASE
            WHEN core.eo.d_data_sensitive_id = 1 THEN 'Y'
            WHEN (core.eo.d_data_sensitive_id = 2 OR core.eo.d_data_sensitive_id IS NULL) THEN 'N'
            WHEN core.eo.d_data_sensitive_id = 3 THEN 'C'
        END
    END AS datasens,
    CASE
        WHEN core.eo.d_basic_eo_rank_id IS NULL THEN 'NR'
        ELSE eornk.basic_eo_rank_cd
    END AS eorank, core.eo.eo_rank_date AS eorank_dt, oracle.substr(egt.g_rank, 1, 10) AS grank, oracle.substr(est.s_rank, 1, 10) AS srank,
    CASE
        WHEN ext.federal(est.element_subnational_id) IS NULL THEN 'N'
        ELSE ext.federal(est.element_subnational_id)
    END AS federal,
    CASE
        WHEN est.s_protection_status IS NULL THEN 'N'
        ELSE oracle.substr(est.s_protection_status, 1, 10)
    END AS sprot,
    CASE
        WHEN core.eo.last_obs_date IS NULL THEN 'ZZ'
        ELSE oracle.substr(core.eo.last_obs_date, 1, 24)
    END AS lastobs,
    CASE
        WHEN oracle.substr(lob_loc => core.eo.gen_desc, amount => 4000, "offset" => 1) IS NULL THEN 'No general description given'
        ELSE oracle.substr(oracle.substr(lob_loc => ext.clean_up_clob(core.eo.gen_desc), amount => 4000, "offset" => 1), 1, 4000)
    END AS description,
    CASE
        WHEN oracle.substr(lob_loc => core.eo.eo_data, amount => 4000, "offset" => 1) IS NULL THEN 'No EO data given'
        ELSE oracle.substr(oracle.substr(lob_loc => ext.clean_up_clob(core.eo.eo_data), amount => 4000, "offset" => 1), 1, 4000)
    END AS eodata, domain.d_id_confirmed.id_confirmed_cd AS id_confirmed,
    CASE
        WHEN (NOT EXISTS (SELECT
            erf.eo_reference_primary_ind
            FROM core.eo_reference AS erf
            WHERE erf.eo_id = core.eo.eo_id) AND
        /* then 'No best source given' */
        NOT EXISTS (SELECT
            erf.eo_reference_primary_ind
            FROM core.eo_reference AS erf
            WHERE erf.eo_id = core.eo.eo_id AND erf.eo_reference_primary_ind = 'Y')) THEN 'No best source given'
        ELSE oracle.substr((SELECT
            rf.full_citation
            FROM core.eo_reference AS erf
            LEFT OUTER JOIN core.reference AS rf
                ON erf.reference_id = rf.reference_id
            WHERE erf.eo_id = core.eo.eo_id AND erf.eo_reference_primary_ind = 'Y'), 1, 4000)
    END AS bestsource,
    CASE
        WHEN NOT EXISTS (SELECT
            core.ma.managed_area_name
            FROM core.eo_managed_area
            LEFT OUTER JOIN core.ma
                ON core.eo_managed_area.managed_area_id = core.ma.managed_area_id
            WHERE core.eo_managed_area.eo_id = core.eo.eo_id) THEN 'No managed area name given'
    /* comma delimited list of MAs */
        ELSE oracle.substr((
        /* had to substitute this use of xmlagg for listagg to deal with EOs */
        /* that result in MA strings longer than 4000 characters (EO_ID 37959) */
        /* then have to reinsert XML special characters */
        SELECT
            replace(replace(replace(oracle.substr(lob_loc => RTRIM(XMLSERIALIZE (CONTENT XMLAGG(array_to_string(xpath('//text()', XMLELEMENT (NAME e, core.ma.managed_area_name, ',')), '')::XML) AS TEXT)::TEXT, ','), amount => 4000, "offset" => 1), coalesce(CONCAT_WS('', CHR(38), 'apos;')::TEXT, ''), coalesce(CHR(39), '')), coalesce(CONCAT_WS('', CHR(38), 'amp;amp;')::TEXT, ''), coalesce(CHR(38), '')), coalesce(CONCAT_WS('', CHR(38), 'quot;')::TEXT, ''), coalesce(CHR(34), ''))
            /* ),'&apos;',CHR(39) */
            /* ),'&amp;amp;',CHR(38) */
            /* ),'&quot;',CHR(34) */
            /* LISTAGG(ma.MANAGED_AREA_NAME, ', ') WITHIN GROUP (ORDER BY ma.MANAGED_AREA_NAME) AS MAS */
            FROM core.eo_managed_area
            LEFT OUTER JOIN core.ma
                ON core.eo_managed_area.managed_area_id = core.ma.managed_area_id
            WHERE core.eo_managed_area.eo_id = core.eo.eo_id
            GROUP BY eo_id), 1, 4000)
    END AS maname, oracle.substr((SELECT
        STRING_AGG(oracle.substr(domain.d_county.county_cd, 3, 4), ', '::TEXT ORDER BY oracle.substr(domain.d_county.county_cd, 3, 4)) AS cntys
        FROM core.eo_county
        LEFT OUTER JOIN domain.d_county
            ON core.eo_county.d_county_id = domain.d_county.d_county_id
        WHERE core.eo_county.eo_id = core.eo.eo_id
        GROUP BY eo_id), 1, 100) AS county,
    /*
    precision is not a good attribute any more. We'll use a combination of size and
    rep accuracy to indicate mapping precision
    */
    CAST (COALESCE(ROUND(oracle.to_number(oracle.substr((SELECT
        spat_att.attribute_value
        FROM core.spatial_attribute AS spat_att
        WHERE spat_att.attribute_name = 'Hectares' AND spat_att.feature_id = core.eo.shape_id), 1, 12)) * 2.4711, 4), - 9999) AS NUMERIC(12, 4)) AS eosize_ac,
    CASE
        WHEN core.eo.d_est_rep_accuracy_id = 3 THEN 'Medium ( >20%, <=80% )'
        WHEN core.eo.d_est_rep_accuracy_id = 4 THEN 'Low ( >5%, <=20% )'
        WHEN core.eo.d_est_rep_accuracy_id = 2 THEN 'High ( >80%, <=95% )'
        WHEN core.eo.d_est_rep_accuracy_id = 1 THEN 'Very High ( >95% )'
        WHEN core.eo.d_est_rep_accuracy_id = 6 THEN 'Very Low ( >0%, <=5% )'
        WHEN core.eo.d_est_rep_accuracy_id = 5 THEN 'Unknown'
        WHEN core.eo.d_est_rep_accuracy_id IS NULL THEN 'ZZ'
    END AS rep_acc,
    /* beginning of loc uncertainty code ************************************* */
    CASE
        WHEN ext.nbr_src_features(core.eo.eo_id) = 1 THEN
        CASE (SELECT
            core.source_feature.d_loc_uncertainty_type_id
            FROM core.eo_source_feature
            LEFT OUTER JOIN core.source_feature
                ON core.eo_source_feature.source_feature_shape_id = core.source_feature.shape_id
            WHERE core.eo_source_feature.eo_shape_id = core.eo.shape_id)
            WHEN 5 THEN 'Areal-estim'
            WHEN 1 THEN 'Negligible'
            WHEN 2 THEN 'Linear'
            WHEN 3 THEN 'Areal-delim'
        END
    /* when more than one sf... */
        ELSE
        CASE
            /* when records exist in which LU type id is 2,3, or 5... */
            WHEN EXISTS (SELECT
                core.source_feature.d_loc_uncertainty_type_id
                FROM core.eo_source_feature
                LEFT OUTER JOIN core.source_feature
                    ON core.eo_source_feature.source_feature_shape_id = core.source_feature.shape_id
                WHERE core.eo_source_feature.eo_shape_id = core.eo.shape_id AND core.source_feature.d_loc_uncertainty_type_id IN (2, 3, 5)) THEN
            CASE
                /* when the EO also has records with a 1 */
                WHEN EXISTS (SELECT
                    core.source_feature.d_loc_uncertainty_type_id
                    FROM core.eo_source_feature
                    LEFT OUTER JOIN core.source_feature
                        ON core.eo_source_feature.source_feature_shape_id = core.source_feature.shape_id
                    WHERE core.eo_source_feature.eo_shape_id = core.eo.shape_id AND core.source_feature.d_loc_uncertainty_type_id = 1) THEN 'Compound(negligible in part)'
            /* if no records with a 1 */
                ELSE 'Compound(non-negligible)'
            END
            ELSE 'Negligible' /* if no 5s, 3s, or 2s, they must all be 1s */
        END
    END AS loc_uncert,
    /* end of loc uncertainty code ******************************************* */
    /* QC status       note - shape and data must both pass */
    CASE
        WHEN (core.eo.d_data_qc_status_id = 2 AND 'P' IN (SELECT
            core.shape.map_qc_status
            FROM core.shape
            WHERE core.shape.shape_id = core.eo.shape_id)) THEN 'P'
        WHEN (core.eo.d_data_qc_status_id = 3 OR 'F' IN (SELECT
            core.shape.map_qc_status
            FROM core.shape
            WHERE core.shape.shape_id = core.eo.shape_id)) THEN 'F'
        ELSE 'I'
    END AS qc_stat,
    /*
    SYMB - field used primarily in data request maps to indicate
    element type and EO size
    */
    CASE
        WHEN (est.d_data_sensitive_id = 1 OR core.eo.d_data_sensitive_id = 1) THEN 'DS'
        ELSE CONCAT_WS('',
        CASE
            WHEN oracle.substr(egt.elcode_bcd, 1, 1) IN ('A', 'I') THEN 'A'
            WHEN oracle.substr(egt.elcode_bcd, 1, 1) IN ('P', 'N') THEN 'P'
            WHEN oracle.substr(egt.elcode_bcd, 1, 1) IN ('C') THEN 'C'
            ELSE 'O'
        END,
        CASE
            WHEN NOT EXISTS (SELECT
                spat_att.attribute_value
                FROM core.spatial_attribute AS spat_att
                WHERE spat_att.attribute_name = 'Acreage' AND spat_att.feature_id = core.eo.shape_id) THEN 'ZZ'
            ELSE
            CASE
                WHEN ROUND(oracle.to_number(oracle.substr((SELECT
                    spat_att.attribute_value
                    FROM core.spatial_attribute AS spat_att
                    WHERE spat_att.attribute_name = 'Acreage' AND spat_att.feature_id = core.eo.shape_id), 1, 12)), 2) <= 5 THEN '1'
                ELSE '2'
            END
        END)
    END AS symb,
    /* the lines below may be used if we decide on another definition */
    /*
    case when eo.d_est_rep_accuracy_id = 3 then 'M'
         when eo.d_est_rep_accuracy_id = 4 then 'L'
         when eo.d_est_rep_accuracy_id = 2 then 'H'
         when eo.d_est_rep_accuracy_id = 1 then 'V'
         when eo.d_est_rep_accuracy_id = 5 then 'U'
         when eo.d_est_rep_accuracy_id is null then 'Z'
    end as symb,
    */
    /* qrtr_update */
    CASE
        WHEN ext.fnai_eo_status_view.status IN ('NEW_COMPLETED', 'OLD_COMPLETED_BILLABLE') THEN 'N'
        WHEN ext.fnai_eo_status_view.status IN ('MOD_COMPLETE_MATURE_EO') THEN 'M'
        ELSE 'U'
    END AS qtr_update,
    /*
    maplabelDS - this version has a "DS" for data sensitive EOs. This attribute should
    be used in all FLEO versions except for the internal version
      For EOs that are data sensitive:
       char 1-3 are "DS*"
       char 4-8 are the eo_id number
      For EOs that are NOT data sensitive:
       char 1-4 are 1st 4 char of scientific name
       char 5-8 are
         SP0n or POPn if sname ends in 1,2,3,4,5 (handles SP 1, SP 2, POP 3, etc)
         next 4 char after the 3rd blank in sname (if there are 3 blanks in sname)
         next 4 char after the 2nd blank in sname (if there are 2 blanks in sname)
         next 4 char after the 1st blank in sname (if there are 1 blanks in sname)
         char 5-8 of sname (padded with * as necessary) (if there are 0 blanks in sname)
       char 9 is an asterisk
       char 10-18 are the eonum
    */
    CASE
        WHEN (est.d_data_sensitive_id = 1 OR core.eo.d_data_sensitive_id = 1) THEN sub_ds.ds_map_label
    /* 'DS*' || to_char(eo.eo_id) */
        
        /* first we deal with the exceptions, then the rest */
        ELSE CONCAT_WS('',
        CASE
            WHEN core.eo.element_subnational_id IN (21494, 18716, 22750, 22829, 22765, 22840, 22835, 22769, 22748, 22820, 22745, 22819, 22837, 22808, 22796, 22790, 22764, 22751, 22833, 22767, 22762, 22793, 22815, 22746) THEN
            CASE
                WHEN core.eo.element_subnational_id = 21494 THEN 'ASCLVRDF'
                WHEN core.eo.element_subnational_id = 18716 THEN 'ASCLVRDU'
                WHEN core.eo.element_subnational_id = 22750 THEN 'COADUNLK'
                WHEN core.eo.element_subnational_id = 22829 THEN 'COAROCLK'
                WHEN core.eo.element_subnational_id = 22765 THEN 'ESTCMSUB'
                WHEN core.eo.element_subnational_id = 22840 THEN 'ESTCNSUB'
                WHEN core.eo.element_subnational_id = 22835 THEN 'ESTUNSUB'
                WHEN core.eo.element_subnational_id = 22769 THEN 'ESTALBED'
                WHEN core.eo.element_subnational_id = 22748 THEN 'ESTGRBED'
                WHEN core.eo.element_subnational_id = 22820 THEN 'ESTOCBED'
                WHEN core.eo.element_subnational_id = 22745 THEN 'ESTSPBED'
                WHEN core.eo.element_subnational_id = 22819 THEN 'ESTMOLRF'
                WHEN core.eo.element_subnational_id = 22837 THEN 'ESTWORRF'
                WHEN core.eo.element_subnational_id = 22808 THEN 'ESTCORRF'
                WHEN core.eo.element_subnational_id = 22796 THEN 'MARALBED'
                WHEN core.eo.element_subnational_id = 22790 THEN 'MARGRBED'
                WHEN core.eo.element_subnational_id = 22764 THEN 'MAROCBED'
                WHEN core.eo.element_subnational_id = 22751 THEN 'MARSPBED'
                WHEN core.eo.element_subnational_id = 22833 THEN 'MARCORRF'
                WHEN core.eo.element_subnational_id = 22767 THEN 'MARMOLRF'
                WHEN core.eo.element_subnational_id = 22762 THEN 'MARWORRF'
                WHEN core.eo.element_subnational_id = 22793 THEN 'MARCMSUB'
                WHEN core.eo.element_subnational_id = 22815 THEN 'MARCNSUB'
                WHEN core.eo.element_subnational_id = 22746 THEN 'MARUNSUB'
            END /* of exceptions */
            ELSE UPPER(CONCAT_WS('', oracle.substr(sn.scientific_name, 1, 4),
            CASE
                WHEN (oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '1' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '2' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '3' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '4' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '5') THEN CONCAT_WS('',
                CASE
                    WHEN UPPER(oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name) - 3, 2)) = 'SP' THEN 'SP0'
                    ELSE 'POP'
                END, oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1))
                ELSE
                CASE
                    WHEN oracle.INSTR(sn.scientific_name, ' ', 2, 3) > 0 THEN oracle.substr(sn.scientific_name, oracle.INSTR(sn.scientific_name, ' ', 2, 3) + 1, 4)
                    WHEN oracle.INSTR(sn.scientific_name, ' ', 2, 2) > 0 THEN oracle.substr(sn.scientific_name, oracle.INSTR(sn.scientific_name, ' ', 2, 2) + 1, 4)
                    WHEN oracle.INSTR(sn.scientific_name, ' ', 2, 1) > 0 THEN oracle.substr(sn.scientific_name, oracle.INSTR(sn.scientific_name, ' ', 2, 1) + 1, 4)
                    ELSE RPAD(oracle.substr(sn.scientific_name, 5, 4), 4, '*')
                END
            END)::TEXT)
        END, '*',
        CASE
            WHEN core.eo.d_basic_eo_rank_id = 17 THEN ' (X)'
            ELSE NULL
        END, ext.report_eonum(core.eo.eo_id))
    END AS maplabelds,
    /*
    below is a maplabel section for a COMPLETELY UNMASKED maplabel. This is the
    label that should be an attribute in the "internal" version of FLEO
     maplabel
       char 1-4 are 1st 4 char of scientific name
       char 5-8 are
         SP0n or POPn if sname ends in 1,2,3,4,5 (handles SP 1, SP 2, POP 3, etc)
         next 4 char after the 3rd blank in sname (if there are 3 blanks in sname)
         next 4 char after the 2nd blank in sname (if there are 2 blanks in sname)
         next 4 char after the 1st blank in sname (if there are 1 blanks in sname)
         char 5-8 of sname (padded with * as necessary) (if there are 0 blanks in sname)
       char 9 is an asterisk
       char 10-18 are the eonum
    */
    /* first we deal with the exceptions, then the rest */
    CONCAT_WS('',
    CASE
        WHEN core.eo.element_subnational_id IN (21494, 18716, 22750, 22829, 22765, 22840, 22835, 22769, 22748, 22820, 22745, 22819, 22837, 22808, 22796, 22790, 22764, 22751, 22833, 22767, 22762, 22793, 22815, 22746) THEN
        CASE
            WHEN core.eo.element_subnational_id = 21494 THEN 'ASCLVRDF'
            WHEN core.eo.element_subnational_id = 18716 THEN 'ASCLVRDU'
            WHEN core.eo.element_subnational_id = 22750 THEN 'COADUNLK'
            WHEN core.eo.element_subnational_id = 22829 THEN 'COAROCLK'
            WHEN core.eo.element_subnational_id = 22765 THEN 'ESTCMSUB'
            WHEN core.eo.element_subnational_id = 22840 THEN 'ESTCNSUB'
            WHEN core.eo.element_subnational_id = 22835 THEN 'ESTUNSUB'
            WHEN core.eo.element_subnational_id = 22769 THEN 'ESTALBED'
            WHEN core.eo.element_subnational_id = 22748 THEN 'ESTGRBED'
            WHEN core.eo.element_subnational_id = 22820 THEN 'ESTOCBED'
            WHEN core.eo.element_subnational_id = 22745 THEN 'ESTSPBED'
            WHEN core.eo.element_subnational_id = 22819 THEN 'ESTMOLRF'
            WHEN core.eo.element_subnational_id = 22837 THEN 'ESTWORRF'
            WHEN core.eo.element_subnational_id = 22808 THEN 'ESTCORRF'
            WHEN core.eo.element_subnational_id = 22796 THEN 'MARALBED'
            WHEN core.eo.element_subnational_id = 22790 THEN 'MARGRBED'
            WHEN core.eo.element_subnational_id = 22764 THEN 'MAROCBED'
            WHEN core.eo.element_subnational_id = 22751 THEN 'MARSPBED'
            WHEN core.eo.element_subnational_id = 22833 THEN 'MARCORRF'
            WHEN core.eo.element_subnational_id = 22767 THEN 'MARMOLRF'
            WHEN core.eo.element_subnational_id = 22762 THEN 'MARWORRF'
            WHEN core.eo.element_subnational_id = 22793 THEN 'MARCMSUB'
            WHEN core.eo.element_subnational_id = 22815 THEN 'MARCNSUB'
            WHEN core.eo.element_subnational_id = 22746 THEN 'MARUNSUB'
        END /* of exceptions */
        ELSE UPPER(CONCAT_WS('', oracle.substr(sn.scientific_name, 1, 4),
        CASE
            WHEN (oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '1' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '2' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '3' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '4' OR oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1) = '5') THEN CONCAT_WS('',
            CASE
                WHEN UPPER(oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name) - 3, 2)) = 'SP' THEN 'SP0'
                ELSE 'POP'
            END, oracle.substr(sn.scientific_name, LENGTH(sn.scientific_name), 1))
            ELSE
            CASE
                WHEN oracle.INSTR(sn.scientific_name, ' ', 2, 3) > 0 THEN oracle.substr(sn.scientific_name, oracle.INSTR(sn.scientific_name, ' ', 2, 3) + 1, 4)
                WHEN oracle.INSTR(sn.scientific_name, ' ', 2, 2) > 0 THEN oracle.substr(sn.scientific_name, oracle.INSTR(sn.scientific_name, ' ', 2, 2) + 1, 4)
                WHEN oracle.INSTR(sn.scientific_name, ' ', 2, 1) > 0 THEN oracle.substr(sn.scientific_name, oracle.INSTR(sn.scientific_name, ' ', 2, 1) + 1, 4)
                ELSE RPAD(oracle.substr(sn.scientific_name, 5, 4), 4, '*')
            END
        END)::TEXT)
    END, '*',
    CASE
        WHEN core.eo.d_basic_eo_rank_id = 17 THEN ' (X)'
        ELSE NULL
    END, ext.report_eonum(core.eo.eo_id)) AS maplabel
    FROM core.eo
    LEFT OUTER JOIN domain.d_id_confirmed
        ON core.eo.d_id_confirmed_id = domain.d_id_confirmed.d_id_confirmed_id
    LEFT OUTER JOIN core.eo_shape
        ON core.eo.eo_id = core.eo_shape.eo_id
    LEFT OUTER JOIN core.shape
        ON core.eo.shape_id = core.shape.shape_id
    LEFT OUTER JOIN domain.d_basic_eo_rank AS eornk
        ON core.eo.d_basic_eo_rank_id = eornk.d_basic_eo_rank_id
    LEFT OUTER JOIN core.element_subnational AS est
        ON core.eo.element_subnational_id = est.element_subnational_id
    LEFT OUTER JOIN core.scientific_name AS sn
        ON est.sname_id = sn.scientific_name_id
    LEFT OUTER JOIN core.element_national AS ent
        ON est.element_national_id = ent.element_national_id
    LEFT OUTER JOIN core.element_global AS egt
        ON ent.element_global_id = egt.element_global_id
    LEFT OUTER JOIN ext.fnai_eo_status_view
        ON core.eo.eo_id = ext.fnai_eo_status_view.eo_id
    LEFT OUTER JOIN (SELECT
        eo_id,
        /* eo_id_num_prod,mask_count, */
        CASE
            WHEN mask_count >= 2 THEN CONCAT_WS('', 'DS*', eo_id_num_prod, '_', LPAD(ROW_NUMBER() OVER (PARTITION BY eo_id_num_prod ORDER BY eo_id)::TEXT, 2, '0'))
            ELSE CONCAT_WS('', 'DS*', eo_id_num_prod)
        END AS ds_map_label
        FROM (SELECT
            core.eo.eo_id, oracle.to_char(core.eo.eo_id * (core.eo.eo_num + '24'::NUMERIC)) AS eo_id_num_prod, COUNT(*) OVER (PARTITION BY core.eo.eo_id * core.eo.eo_num) AS mask_count
            FROM core.eo
            LEFT OUTER JOIN core.element_subnational
                ON core.eo.element_subnational_id = core.element_subnational.element_subnational_id
            WHERE core.element_subnational.d_data_sensitive_id = 1 OR core.eo.d_data_sensitive_id = 1) AS var_sbq) AS sub_ds
        ON core.eo.eo_id = sub_ds.eo_id
    WHERE core.shape.has_shape_ind = 'Y' AND est.d_eo_track_status_id = 1 /* tracked elements only */
    /* and rownum < 50  \* line for testing */
    /* and eo.eo_id in (858,28578,28704,28490,28437,28468,28653) \* test set, for refs */
    /* and eo.eo_id in (4405,20455,15499,10135,1542,92,10112,7835) \* test set, for size */
    /* and eo.eo_id in (31803,22426,1042,31860,31576,31886,7071,28661) \* test set, for sub-EOs */
    /* and eo.eo_id in (180,7392,1232,34531, 14306, 2004, 20087, 17956) \*test set for DS map label* / */
    ORDER BY eo_id;


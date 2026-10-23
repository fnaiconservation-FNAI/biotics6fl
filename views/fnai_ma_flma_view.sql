CREATE OR REPLACE  VIEW ext.fnai_ma_flma_view (feature_id, managed_area_id, macode_bcd, maname, majorname, matype, managing_agency, matype2, owner, coowners, totacres, ltf_acres, county, protstat, manager, mgrinst, mgrcity, mgrphone, mgmtplan, mgmtcom, pubaccess, "DESC", comments, dig_com, maname_ab, ma_website, ownertypes, easement_holder) AS
SELECT
    ma1.shape_id AS feature_id, ma1.managed_area_id AS managed_area_id, ma1.macode_bcd AS macode_bcd, ma1.managed_area_name AS maname, COALESCE(ma2.managed_area_name, 'ZZ') AS majorname, ma1.managed_area_type AS matype,
    CASE
        WHEN oracle.substr(ma1.managed_area_type, 4, 2) = 'MU' THEN ma1.manager_institution
        WHEN oracle.substr(ma1.managed_area_type, 4, 2) = 'WA' THEN ma1.manager_institution
        WHEN oracle.substr(ma1.managed_area_type, 4, 2) = 'FN' THEN ma1.manager_institution
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PFN' THEN ma1.manager_institution
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PLT' THEN ma1.manager_institution
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PMB' THEN ma1.manager_institution
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PPL' THEN 'Putnam Land Conservancy, Inc.'
    /* note - above line assigns LLEWC, LESEU before the potentially ambiguous LLE below */
        WHEN oracle.substr(ma1.managed_area_type, 1, 5) = 'LLEWC' THEN 'Lee County East County Water Control District'
        WHEN oracle.substr(ma1.managed_area_type, 1, 5) = 'LESEU' THEN 'Emerald Coast Utilities Authority'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FAF' THEN 'US Dept. of Defense, Air Force'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FBL' THEN 'US Dept. of the Interior, Bureau of Land Management'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FCG' THEN 'US Dept. of Transportation, Coast Guard'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FDA' THEN 'US Dept. of Agriculture (unspecified)'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FDC' THEN 'US Dept. of Commerce'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FFS' THEN 'US Dept. of Agriculture, Forest Service'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FFW' THEN 'US Dept. of the Interior, Fish and Wildlife Service'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FMC' THEN 'US Dept. of Defense, Marine Corps'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FNP' THEN 'US Dept. of the Interior, National Park Service'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FNR' THEN 'US Dept. of Agriculture, Natural Resources Conservation Service'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FNS' THEN 'National Aeronautics and Space Administration'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FNV' THEN 'US Dept. of Defense, Navy'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LAL' THEN 'Alachua County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LBA' THEN 'Bradford County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LBK' THEN 'Baker County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LBR' THEN 'Broward County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LBV' THEN 'Brevard County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LBY' THEN 'Bay County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LCA' THEN 'Calhoun County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LCH' THEN 'Charlotte County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LCI' THEN 'Citrus County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LCL' THEN 'Clay County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LCO' THEN 'Collier County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LCU' THEN 'Columbia County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LDA' THEN 'Miami-Dade County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LDE' THEN 'DeSoto County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LDI' THEN 'Dixie County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LDU' THEN 'Duval County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LES' THEN 'Escambia County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LFL' THEN 'Flagler County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LFR' THEN 'Franklin County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LGA' THEN 'Gadsden County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LGI' THEN 'Gilchrist County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LGL' THEN 'Glades County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LGU' THEN 'Gulf County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LHD' THEN 'Hardee County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LHG' THEN 'Highlands County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LHL' THEN 'Hillsborough County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LHM' THEN 'Hamilton County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LHN' THEN 'Hendry County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LHO' THEN 'Holmes County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LHR' THEN 'Hernando County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LIN' THEN 'Indian River County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LJA' THEN 'Jackson County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LJE' THEN 'Jefferson County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LLE' THEN 'Lee County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LLF' THEN 'Lafayette County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LLI' THEN 'Liberty County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LLK' THEN 'Lake County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LLO' THEN 'Leon County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LLV' THEN 'Levy County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LMD' THEN 'Madison County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LMN' THEN 'Manatee County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LMO' THEN 'Monroe County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LMR' THEN 'Marion County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LMT' THEN 'Martin County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LNA' THEN 'Nassau County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LOA' THEN 'Okaloosa County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LOE' THEN 'Okeechobee County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LOR' THEN 'Orange County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LOS' THEN 'Osceola County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LPA' THEN 'Pasco County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LPI' THEN 'Pinellas County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LPM' THEN 'Palm Beach County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LPO' THEN 'Polk County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LPU' THEN 'Putnam County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LSE' THEN 'Seminole County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LSJ' THEN 'St. Johns County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LSL' THEN 'St. Lucie County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LSM' THEN 'Sumter County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LSN' THEN 'Santa Rosa County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LSR' THEN 'Sarasota County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LSW' THEN 'Suwannee County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LTA' THEN 'Taylor County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LUN' THEN 'Union County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LVO' THEN 'Volusia County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LWK' THEN 'Wakulla County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LWL' THEN 'Walton County'
        WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'LWS' THEN 'Washington County'
        ELSE
        CASE
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PAC' THEN 'Apalachee Land Conservancy'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PAE' THEN 'Archbold Expeditions, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PAS' THEN 'Ashton Biodiversity Research and Preservation Institute, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PBA' THEN 'Bay County Audubon Society, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PBC' THEN 'Bay County Conservancy'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PBR' THEN 'Babcock Ranch Management, LLC'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PCF' THEN 'The Conservation Fund'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PCH' THEN 'Charlotte Harbor Environmental Center'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PCM' THEN 'Crowley Museum and Nature Center'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PCN' THEN 'Calusa Nature Center and Planetarium'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PCP' THEN 'Coastal Plains Institute'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PDV' THEN 'Duval Audubon Society, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PFA' THEN 'Florida Audubon Society, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PFH' THEN 'Florida Trust for Historic Preservation'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PFP' THEN CONCAT_WS('', 'Florida Power ', CHR(38), ' Light Company')
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PGS' THEN 'Girl Scouts of America'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PIN' THEN 'Private Individual(s)'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PJE' THEN 'JEA'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PKB' THEN 'Key West Botanical Garden Society, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PLB' THEN 'Lemon Bay Conservancy'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PLO' THEN 'Lake Okeechobee Habitat Alliance, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PLU' THEN 'Lynn University, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PMA' THEN 'Manatee Audubon Society'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PMC' THEN 'Audubon of Martin County, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PMF' THEN 'Mosaic Fertilizer, LLC'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PNA' THEN 'National Audubon Society, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PNC' THEN 'The Nature Conservancy'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PNF' THEN 'North Florida Land Trust'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PNK' THEN 'Nokuse Plantation, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PNS' THEN 'National Speleological Society'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'POB' THEN 'Ormond Beach Historical Trust Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PON' THEN 'Oakland Nature Preserve, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PPC' THEN 'Presbytery of Florida (Presbyterian Church, USA)'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PPD' THEN 'PRIDE Enterprises, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PPE' THEN 'Peace River Audubon Society'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PRC' THEN 'Institute for Regional Conservation'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PSC' THEN 'Sierra Club'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PSG' THEN 'Marie Selby Botanical Gardens'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PSH' THEN 'Florida Institute for Saltwater Heritage'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PTA' THEN 'Tropical Audubon Society'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PTL' THEN 'Trout Lake Nature Center, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PTT' THEN 'Tall Timbers Research, Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PUM' THEN 'University of Miami'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PYM' THEN 'YMCA'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SAH' THEN 'Florida Agriculture and Horse Park Authority'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SCA' THEN 'FL Dept. of Environmental Protection, Office of Resilience and Coastal Protection'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SDA' THEN 'FL Dept. of Agriculture and Consumer Services'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SDF' THEN 'FL Dept. of Agriculture and Consumer Services, Florida Forest Service'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SDM' THEN CONCAT_WS('', 'FL Dept. of Management Services, Div. of Real Estate, Development ', CHR(38), ' Management')
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SFI' THEN 'Florida International University'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SFW' THEN 'FL Fish and Wildlife Conservation Commission'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SFA' THEN 'Florida Atlantic University'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SGT' THEN 'FL Dept. of Environmental Protection, Office of Greenways and Trails'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SMA' THEN 'FL Dept. of Military Affairs'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SND' THEN 'Florida Inland Navigation District'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SNW' THEN 'FL Dept. of Environmental Protection, Northwest District'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SPD' THEN 'State Agency for Persons with Disabilities'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SRM' THEN 'FL Dept. of Environmental Protection, Div. of Water Resource Management, Bureau of Mining and Minerals Regulation'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SRP' THEN 'FL Dept. of Environmental Protection, Div. of Recreation and Parks'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SSF' THEN 'University of South Florida'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SSL' THEN 'FL Dept. of Environmental Protection, Div. of State Lands'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SUC' THEN 'University of Central Florida'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SUF' THEN 'University of Florida'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SUN' THEN 'University of North Florida'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SUU' THEN 'Undesignated State Land (not currently assigned to a managing agency)'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SWJ' THEN 'St. Johns River Water Management District'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SWN' THEN 'Northwest Florida Water Management District'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SWS' THEN 'South Florida Water Management District'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SWU' THEN 'Suwannee River Water Management District'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SWW' THEN 'Southwest Florida Water Management District'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'FSF' THEN 'US Space Force'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PAL' THEN 'Alachua Conservation Trust.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SDS' THEN 'FL Dept. of State, Div. of Historical Resources'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'PTH' THEN 'Tree Hill Inc.'
            WHEN oracle.substr(ma1.managed_area_type, 1, 3) = 'SUW' THEN 'University of West Florida'
            ELSE '** AGENCY CODE NOT FOUND **'
        END
    END AS managing_agency, oracle.substr(ma1.managed_area_type, 1, 1) AS matype2, COALESCE((SELECT
        core.managed_area_owner.owner_name
        FROM core.managed_area_owner
        WHERE core.managed_area_owner.primary_owner_ind = 'Y' AND core.managed_area_owner.managed_area_id = ma1.managed_area_id), 'ZZ') AS owner, COALESCE((SELECT
        STRING_AGG(core.managed_area_owner.owner_name, ', '::TEXT ORDER BY core.managed_area_owner.display_order)
        FROM core.managed_area_owner
        WHERE core.managed_area_owner.primary_owner_ind = 'N' AND core.managed_area_owner.managed_area_id = ma1.managed_area_id
        GROUP BY core.managed_area_owner.managed_area_id), 'ZZ') AS coowners, ma1.total_area_acres AS totacres, max1.ltf_acres AS ltf_acres, COALESCE((SELECT
        STRING_AGG(oracle.substr(dc.county_cd, 3, 4), ', '::TEXT ORDER BY dc.county_cd) AS county
        FROM core.managed_area_county
        JOIN domain.d_county AS dc
            ON dc.d_county_id = core.managed_area_county.d_county_id
        WHERE core.managed_area_county.managed_area_id = ma1.managed_area_id
        GROUP BY core.managed_area_county.managed_area_id), 'ZZ') AS county, COALESCE(oracle.to_char(ma1.d_protection_level_id), 'ZZ') AS protstat, COALESCE(ma1.manager, 'ZZ') AS manager, COALESCE(ma1.manager_institution, 'ZZ') AS mgrinst, COALESCE(ma1.manager_city, 'ZZ') AS mgrcity, COALESCE(ma1.manager_phone, 'ZZ') AS mgrphone, COALESCE(ma1.mgmt_plan_ind, 'ZZ') AS mgmtplan, COALESCE(oracle.substr(ma1.mgmt_com, 1, 254), 'ZZ') AS mgmtcom, COALESCE(pa.public_access_desc, 'ZZ') AS pubaccess, COALESCE(ma1.managed_area_desc, 'ZZ') AS "DESC", COALESCE(ma1.managed_area_com, 'ZZ') AS comments, COALESCE(max1.dig_com, 'ZZ') AS dig_com, COALESCE(max1.maname_abbr, 'ZZ') AS maname_ab, COALESCE(max1.ma_website, 'ZZ') AS ma_website, COALESCE(ownertype.ownertypes, 'ZZ') AS ownertypes, max1.easement_holder
    FROM core.ma AS ma1
    LEFT OUTER JOIN ext.ma_flext1 AS max1
        ON max1.ma_id = ma1.managed_area_id
    LEFT OUTER JOIN domain.d_public_access AS pa
        ON pa.d_public_access_id = ma1.d_public_access_id
    LEFT OUTER JOIN core.ma AS ma2
        ON ma2.managed_area_id = ma1.major_ma_id
    LEFT OUTER JOIN
    /* OWNERTYPES List */
    (SELECT
        managed_area_id,
        /* primary_owner_ind = 'Y */
        CONCAT_WS('', STRING_AGG(CASE
            WHEN primary_owner_ind = 'Y' THEN owner_type_cd
        END, ','::TEXT ORDER BY
        CASE
            WHEN primary_owner_ind = 'Y' THEN owner_type_cd
        END),
        /* primary_owner_ind = 'N */
        CASE
            WHEN COUNT(CASE
                WHEN primary_owner_ind = 'N' THEN 1
            END) > 0 THEN CONCAT_WS('', ',', STRING_AGG(CASE
                WHEN primary_owner_ind = 'N' THEN owner_type_cd
            END, ','::TEXT ORDER BY
            CASE
                WHEN primary_owner_ind = 'N' THEN display_order
            END))
        /* owner_type_cd */
            ELSE NULL
        END) AS ownertypes
        FROM (SELECT
            mao.managed_area_id, mao.primary_owner_ind, dot.owner_type_cd, mao.display_order
            FROM core.managed_area_owner AS mao
            JOIN domain.d_owner_type AS dot
                ON dot.d_owner_type_id = mao.d_owner_type_id) AS x
        GROUP BY managed_area_id) AS ownertype
        ON ownertype.managed_area_id = ma1.managed_area_id;


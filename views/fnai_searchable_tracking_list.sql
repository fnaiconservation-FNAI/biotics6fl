CREATE OR REPLACE  VIEW ext.fnai_searchable_tracking_list (text, error_msg) AS
SELECT 'CREATE OR REPLACE FORCE VIEW BIOTICS_USER.FNAI_SEARCHABLE_TRACKING_LIST(SORT_ORDER, ELEMENT_GROUP, SCI_NAME, COMM_NAME, TRACKED, GRANK, SRANK, FEDERAL, STATE, FIELDGUIDE, BROAD_GROUP, NATURESERVE, ALACHUA, BAKER, BAY, BRADFORD, BREVARD, BROWARD, CALHOUN, CHARLOTTE, CITRUS, CLAY, COLLIER, COLUMBIA, DESOTO, DIXIE, DUVAL, ESCAMBIA, FLAGLER, FRANKLIN, GADSDEN, GILCHRIST, GLADES, GULF, HAMILTON, HARDEE, HENDRY, HERNANDO, HIGHLANDS, HILLSBOROUGH, HOLMES, INDIANRIVER, JACKSON, JEFFERSON, LAFAYETTE, LAKE, LEE, LEON, LEVY, LIBERTY, MADISON, MANATEE, MARION, MARTIN, MIAMIDADE, MONROE, NASSAU, OKALOOSA, OKEECHOBEE, ORANGE, OSCEOLA, PALMBEACH, PASCO, PINELLAS, POLK, PUTNAM, SANTAROSA, SARASOTA, SEMINOLE, STJOHNS, STLUCIE, SUMTER, SUWANNEE, TAYLOR, UNION_, VOLUSIA, WAKULLA, WALTON, WASHINGTON) AS 
select
elgroup_sort_order(est.element_subnational_id) as sort_order,
elgroup_name(est.element_subnational_id) as element_group,
sci_name(est.element_subnational_id) sci_name,
COMM_NAME(EST.ELEMENT_SUBNATIONAL_ID) COMM_NAME,
case when est.d_eo_track_status_id = 1 then ''Y''
    else ''N'' end as TRACKED,
substr(grank(est.element_subnational_id),1,12) as grank,
substr(est.s_rank,1,12) as srank,
COALESCE(federal(est.element_subnational_id), ''N'') as federal,
case when est.s_protection_status is null then ''N''
    else substr(est.s_protection_status,1,12) 
    end as STATE
, FG_SUBQRY.FILENAME AS FIELDGUIDE
, case when elgroup_political_name(est.element_subnational_id) = ''INVERTEBRATES'' then ''Invertebrates''
when elgroup_political_name(est.element_subnational_id) in (''FISH'',''AMPHIBIANS'',''REPTILES'',''BIRDS'',''MAMMALS'') then ''Vertebrates''
when elgroup_political_name(est.element_subnational_id) = ''PLANTS'' then ''Plants and Lichens''
when elgroup_political_name(est.element_subnational_id) = ''NATURAL COMMUNITIES'' then ''Natural Communities'' end as broad_group
, case when ELGROUP_NAME(EST.ELEMENT_SUBNATIONAL_ID) not in (
  ''Natural Communities'',''Other Elements'')
  THEN ''https://explorer.natureserve.org/Taxon/ELEMENT_GLOBAL.''||
        to_char(egt.element_global_ou_uid)||''.''||to_char(egt.element_global_seq_uid)||''/''||replace(replace(sname.scientific_name,'' '',''_''),''.'','''')
  END AS NATURESERVE
-- all of the county presence/absence data, if null then substitutes zero
,NVL(Alachua,0) AS ALACHUA,NVL(Baker,0) AS BAKER,NVL(Bay,0) AS BAY,NVL(Bradford,0) AS BRADFORD,NVL(Brevard,0) AS BREVARD,NVL(Broward,0) AS BROWARD,NVL(Calhoun,0) AS CALHOUN,NVL(Charlotte,0) AS CHARLOTTE,NVL(Citrus,0) AS CITRUS,NVL(Clay,0) AS CLAY,NVL(Collier,0) AS COLLIER,NVL(Columbia,0) AS COLUMBIA,NVL(DeSoto,0) AS DESOTO,NVL(Dixie,0) AS DIXIE,NVL(Duval,0) AS DUVAL,NVL(Escambia,0) AS ESCAMBIA,NVL(Flagler,0) AS FLAGLER,NVL(Franklin,0) AS FRANKLIN,NVL(Gadsden,0) AS GADSDEN,NVL(Gilchrist,0) AS GILCHRIST,NVL(Glades,0) AS GLADES,NVL(Gulf,0) AS GULF,NVL(Hamilton,0) AS HAMILTON,NVL(Hardee,0) AS HARDEE,NVL(Hendry,0) AS HENDRY,NVL(Hernando,0) AS HERNANDO,NVL(Highlands,0) AS HIGHLANDS,NVL(Hillsborough,0) AS HILLSBOROUGH,NVL(Holmes,0) AS HOLMES,NVL(IndianRiver,0) AS INDIANRIVER,NVL(Jackson,0) AS JACKSON,NVL(Jefferson,0) AS JEFFERSON,NVL(Lafayette,0) AS LAFAYETTE,NVL(Lake,0) AS LAKE,NVL(Lee,0) AS LEE,NVL(Leon,0) AS LEON,NVL(Levy,0) AS LEVY,NVL(Liberty,0) AS LIBERTY,NVL(Madison,0) AS MADISON,NVL(Manatee,0) AS MANATEE,NVL(Marion,0) AS MARION,NVL(Martin,0) AS MARTIN,NVL(MiamiDade,0) AS MIAMIDADE,NVL(Monroe,0) AS MONROE,NVL(Nassau,0) AS NASSAU,NVL(Okaloosa,0) AS OKALOOSA,NVL(Okeechobee,0) AS OKEECHOBEE,NVL(Orange,0) AS ORANGE,NVL(Osceola,0) AS OSCEOLA,NVL(PalmBeach,0) AS PALMBEACH,NVL(Pasco,0) AS PASCO,NVL(Pinellas,0) AS PINELLAS,NVL(Polk,0) AS POLK,NVL(Putnam,0) AS PUTNAM,NVL(SantaRosa,0) AS SANTAROSA,NVL(Sarasota,0) AS SARASOTA,NVL(Seminole,0) AS SEMINOLE,NVL(StJohns,0) AS STJOHNS,NVL(StLucie,0) AS STLUCIE,NVL(Sumter,0) AS SUMTER,NVL(Suwannee,0) AS SUWANNEE,NVL(Taylor,0) AS TAYLOR,NVL(Union_,0) AS UNION_,NVL(Volusia,0) AS VOLUSIA,NVL(Wakulla,0) AS WAKULLA,NVL(Walton,0) AS WALTON,NVL(Washington,0) AS WASHINGTON

from 
ELEMENT_SUBNATIONAL est
left outer join
/*
subquery below gets county info from FNAI_ELEMENT_COUNTY_VIEW which uses both
the CAS counties and EOs, "status =1" limits to just non-extirpated counties
*/
        (
        select
        est_id,
         "''Alachua''" as ALACHUA,"''Baker''" AS Baker,"''Bay''" AS Bay,"''Bradford''" AS Bradford,"''Brevard''" AS Brevard,"''Broward''" AS Broward,"''Calhoun''" AS Calhoun,"''Charlotte''" AS Charlotte,"''Citrus''" AS Citrus,"''Clay''" AS Clay,"''Collier''" AS Collier,"''Columbia''" AS Columbia,"''DeSoto''" AS DeSoto,"''Dixie''" AS Dixie,"''Duval''" AS Duval,"''Escambia''" AS Escambia,"''Flagler''" AS Flagler,"''Franklin''" AS Franklin,"''Gadsden''" AS Gadsden,"''Gilchrist''" AS Gilchrist,"''Glades''" AS Glades,"''Gulf''" AS Gulf,"''Hamilton''" AS Hamilton,"''Hardee''" AS Hardee,"''Hendry''" AS Hendry,"''Hernando''" AS Hernando,"''Highlands''" AS Highlands,"''Hillsborough''" AS Hillsborough,"''Holmes''" AS Holmes,"''Indian River''" AS IndianRiver,"''Jackson''" AS Jackson,"''Jefferson''" AS Jefferson,"''Lafayette''" AS Lafayette,"''Lake''" AS Lake,"''Lee''" AS Lee,"''Leon''" AS Leon,"''Levy''" AS Levy,"''Liberty''" AS Liberty,"''Madison''" AS Madison,"''Manatee''" AS Manatee,"''Marion''" AS Marion,"''Martin''" AS Martin,"''Miami-Dade''" AS MiamiDade,"''Monroe''" AS Monroe,"''Nassau''" AS Nassau,"''Okaloosa''" AS Okaloosa,"''Okeechobee''" AS Okeechobee,"''Orange''" AS Orange,"''Osceola''" AS Osceola,"''Palm Beach''" AS PalmBeach,"''Pasco''" AS Pasco,"''Pinellas''" AS Pinellas,"''Polk''" AS Polk,"''Putnam''" AS Putnam,"''Santa Rosa''" AS SantaRosa,"''Sarasota''" AS Sarasota,"''Seminole''" AS Seminole,"''St. Johns''" AS StJohns,"''St. Lucie''" AS StLucie,"''Sumter''" AS Sumter,"''Suwannee''" AS Suwannee,"''Taylor''" AS Taylor,"''Union''" AS Union_,"''Volusia''" AS Volusia,"''Wakulla''" AS Wakulla,"''Walton''" AS Walton,"''Washington''" AS Washington
        from (
          select est_id, county_name 
          from 
          FNAI_ELEMENT_COUNTY_VIEW VW
          where status =1
        )
        Pivot
        (
          COUNT(COUNTY_NAME)
          for county_name in (
        ''Alachua'',''Baker'',''Bay'',''Bradford'',''Brevard'',''Broward'',''Calhoun'',''Charlotte'',''Citrus'',''Clay'',''Collier'',''Columbia'',''DeSoto'',''Dixie'',''Duval'',''Escambia'',''Flagler'',''Franklin'',''Gadsden'',''Gilchrist'',''Glades'',''Gulf'',''Hamilton'',''Hardee'',''Hendry'',''Hernando'',''Highlands'',''Hillsborough'',''Holmes'',''Indian River'',''Jackson'',''Jefferson'',''Lafayette'',''Lake'',''Lee'',''Leon'',''Levy'',''Liberty'',''Madison'',''Manatee'',''Marion'',''Martin'',''Miami-Dade'',''Monroe'',''Nassau'',''Okaloosa'',''Okeechobee'',''Orange'',''Osceola'',''Palm Beach'',''Pasco'',''Pinellas'',''Polk'',''Putnam'',''Santa Rosa'',''Sarasota'',''Seminole'',''St. Johns'',''St. Lucie'',''Sumter'',''Suwannee'',''Taylor'',''Union'',''Volusia'',''Wakulla'',''Walton'',''Washington''
          -- to select this string of counties:
--            select 
--            LISTAGG(''''''''||COUNTY_NAME||'''''''','','')
--            within group (order by COUNTY_NAME) ALL_COUNTIES
--            from D_COUNTY where D_STATE_ID = 12
          ) 
        ) 
        -- to get counties in correct format for above:
--        select LISTAGG(''"''''''||COUNTY_NAME||''''''"''||'' AS ''||replace(replace(replace(
--        replace(COUNTY_NAME,'' '',''''),''.'',''''),''-'',''''),''Union'',''Union_''),'','') 
--        within group (order by COUNTY_NAME) ALL_COUNTIES
--        from D_COUNTY where D_STATE_ID = 12

        -- to get counties in another format:
--        SELECT LISTAGG(''NVL(''||REPLACE(REPLACE(REPLACE(
--        Replace(County_Name,'' '',''''),''.'',''''),''-'',''''),''Union'',''Union_'')||'',0) AS ''||Replace(Replace(Replace(
--        Replace(Upper(County_Name),'' '',''''),''.'',''''),''-'',''''),''UNION'',''UNION_''),'','') 
--        Within Group (Order By County_Name) All_Counties
--        From D_County Where D_State_Id = 12

        ) PIVOT_SUBQRY
        ON EST.ELEMENT_SUBNATIONAL_ID = PIVOT_SUBQRY.EST_ID

left outer join
/*
subquery below is where all matching of field guide accounts with the 
appropriate species even if the pdfs have out of date species names
or there is a single account for multiple species
*/
    (SELECT
    EST.ELEMENT_SUBNATIONAL_ID
    ,CASE
    WHEN SCI_NAME(EST.ELEMENT_SUBNATIONAL_ID) = ''Baetisca escambiensis'' THEN ''Baetisca_escambiensis.pdf''
    when ELGROUP_NAME(EST.ELEMENT_SUBNATIONAL_ID) = ''Mayflies'' then ''Mayflies.pdf''
    ELSE CASE SCI_NAME(EST.ELEMENT_SUBNATIONAL_ID)
--        WHEN ''Aeschynomene pratensis var. pratensis'' THEN ''Aeschynomene_pratensis.pdf''
--        WHEN ''Agkistrodon contortrix'' THEN ''Agkistrodon_contortrix_contortrix.pdf''
    WHEN ''Ammospiza maritima fisheri'' THEN ''Ammodramus_maritimus.pdf''
    WHEN ''Ammospiza maritima macgillivraii'' THEN ''Ammodramus_maritimus.pdf''
--    WHEN ''Ammospiza maritima peninsulae'' THEN ''Ammodramus_maritimus.pdf''
--    WHEN ''Ammospiza maritima mirabilis'' THEN ''Ammodramus_maritimus_mirabilis.pdf''
    --WHEN ''Antigone canadensis pratensis'' THEN ''Grus_canadensis_pratensis.pdf''
--        WHEN ''Apalone mutica'' THEN ''Apalone_mutica_calvata.pdf''
    --WHEN ''Argythamnia argothamnoides'' THEN ''Argythamnia_blodgettii.pdf''
--        WHEN ''Blarina shermani'' THEN ''Blarina_carolinensis_shermani.pdf''
--        WHEN ''Charadrius nivosus'' THEN ''Charadrius_alexandrinus.pdf''
--        WHEN ''Chromolaena frustrata'' THEN ''Eupatorium_frustratum.pdf''
    WHEN ''Cistothorus palustris griseus'' THEN ''Cistothorus_palustris.pdf''
    WHEN ''Cistothorus palustris marianae'' THEN ''Cistothorus_palustris.pdf''
    --WHEN ''Consolea corallicola'' THEN ''Opuntia_corallicola.pdf''
--        WHEN ''Denisophytum pauciflorum'' THEN ''Caesalpinia_pauciflora.pdf''
--        WHEN ''Dicerandra immaculata var. immaculata'' THEN ''Dicerandra_immaculata.pdf''
--        WHEN ''Dicerandra immaculata var. savannarum'' THEN ''Dicerandra_immaculata.pdf''
    --WHEN ''Dryobates borealis'' THEN ''Picoides_borealis.pdf''
--        WHEN ''Eumops floridanus'' THEN ''Eumops_glaucinus_floridanus.pdf''
    --WHEN ''Eurybia spinulosa'' THEN ''Aster_spinulosus.pdf''
--        WHEN ''Eurycea wallacei'' THEN ''Haideotriton_wallacei.pdf''
--        WHEN ''Hamiota subangulata'' THEN ''Lampsilis_subangulata.pdf''
    --WHEN ''Heterosavia bahamensis'' THEN ''Savia_bahamensis.pdf''
--        WHEN ''Hymenocallis henryae var. glaucifolia'' THEN ''Hymenocallis_henryae.pdf''
--        WHEN ''Hymenocallis henryae var. henryae'' THEN ''Hymenocallis_henryae.pdf''
    WHEN ''Indigofera trita ssp. scabra'' THEN ''Indigofera_mucronata_var_keyensis.pdf''
--        WHEN ''Kinosternon baurii pop. 1'' THEN ''Kinosternon_baurii_-_lower_Keys_population.pdf''
--        WHEN ''Lampropeltis extenuata'' THEN ''Stilosoma_extenuatum.pdf''
    WHEN ''Liguus fasciatus septentrionalis'' THEN ''Liguus_fasciatus.pdf''
    WHEN ''Liguus fasciatus matecumbensis'' THEN ''Liguus_fasciatus.pdf''
    WHEN ''Linum carteri var. carteri'' THEN ''Linum_carteri.pdf''
    WHEN ''Linum carteri var. smallii'' THEN ''Linum_carteri.pdf''
--        WHEN ''Lithobates okaloosae'' THEN ''Rana_okaloosae.pdf''
--        when ''Lithobates virgatipes'' then ''Rana_virgatipes.pdf''
    when ''Malaclemys terrapin rhizophorarum'' then ''Malaclemys_terrapin.pdf''
--        WHEN ''Malaclemys terrapin'' then ''Malaclemys_terrapin.pdf''
--        WHEN ''Mesadenus lucayanus'' THEN ''Spiranthes_polyantha.pdf''
--        WHEN ''Mosiera longipes'' THEN ''Psidium_longipes.pdf''
--        WHEN ''Neogale vison halilimnetes'' THEN ''Mustela_vison_halilimnetes.pdf''
--        WHEN ''Neogale vison lutensis'' THEN ''Mustela_vison_halilimnetes.pdf''
--        WHEN ''Neovison vison pop. 1'' THEN ''Mustela_vison_mink_pop_1.pdf''
    WHEN ''Oryzomys palustris argentatus'' THEN ''Oryzomys_argentatus.pdf'' --	Oryzomys palustris argentatus
--        WHEN ''Oryzomys palustris sanibeli'' THEN ''Oryzomys_argentatus.pdf''
--        WHEN ''Palaemon cummingi'' THEN ''Palaemonetes_cummingi.pdf''
--        WHEN ''Pantherophis guttatus pop. 1'' THEN ''Elaphe_guttata_guttata_-_lower_Keys_popluation.pdf''
--        WHEN ''Papilio aristodemus ponceanus'' THEN ''Heraclides_aristodemus_ponceanus.pdf''
--        WHEN ''Paronychia chartacea var. minima'' THEN ''Paronychia_chartacea_ssp_minima.pdf''
--        WHEN ''Patagioenas leucocephala'' THEN ''Columba_leucocephala.pdf''
--        WHEN ''Pecluma ptilota var. bourgeauana'' THEN ''Pecluma_ptilodon.pdf''
--        WHEN ''Phanogomphus westfalli'' THEN ''Gomphus_westfalli.pdf''
--        WHEN ''Phyllanthus liebmannianus ssp. platylepis'' THEN ''Phyllanthus_leibmannianus_ssp_platylepis.pdf''
--        WHEN ''Platalea ajaja'' THEN ''Ajaia_ajaja.pdf''
--        WHEN ''Plestiodon egregius egregius'' THEN ''Eumeces_egregius_egregius.pdf''
--        WHEN ''Plestiodon egregius lividus'' THEN ''Eumeces_egregius_lividus.pdf''
--        WHEN ''Plestiodon reynoldsi'' THEN ''Neoseps_reynoldsi.pdf''
--        WHEN ''Pituophis melanoleucus'' THEN ''Pituophis_melanoleucus_mugitus.pdf''
--        WHEN ''Prosthechea boothiana var. erythronioides'' THEN ''Encyclia_boothiana_var_erythronioides.pdf''
--        WHEN ''Prosthechea cochleata'' THEN ''Encyclia_cochleata_var_triandra.pdf''
--        WHEN ''Rostrhamus sociabilis'' THEN ''Rostrhamus_sociabilis_plumbeus.pdf''
--        WHEN ''Sarracenia rubra ssp. gulfensis'' THEN ''Sarracenia_rubra.pdf''
--        WHEN ''Sarracenia rubra ssp. wherryi'' THEN ''Sarracenia_rubra.pdf''
--        WHEN ''Sciurus niger niger'' THEN ''Sciurus_niger_shermani.pdf''
--        WHEN ''Sternula antillarum'' THEN ''Sterna_antillarum.pdf''
--        WHEN ''Storeria victa pop. 1'' THEN ''Storeria_dekayi_vieta_-_lower_Keys_population.pdf''
--        WHEN ''Tephrosia angustissima'' THEN ''Tephrosia_angustissima.pdf''
--        WHEN ''Tephrosia corallicola'' THEN ''Tephrosia_angustissima.pdf''
--        WHEN ''Tephrosia curtissii'' THEN ''Tephrosia_angustissima.pdf''
--        WHEN ''Thalasseus maximus'' THEN ''Sterna_maxima.pdf''
--        WHEN ''Thalasseus sandvicensis'' THEN ''Sterna_sandvicensis.pdf''
--        WHEN ''Thamnophis sauritus pop. 1'' THEN ''Thamnophis_sauritus_sackenii_-_lower_Keys_population.pdf''
--        WHEN ''Trichechus manatus latirostris'' THEN ''Trichechus_manatus.pdf''
--        WHEN ''Trichocentrum undulatum'' THEN ''Oncidium_undulatum.pdf''
    ELSE
    replace(replace(SCI_NAME(EST.ELEMENT_SUBNATIONAL_ID),'' '',''_''),''.'','''')||''.pdf''
    END
    END AS FILENAME
    FROM ELEMENT_SUBNATIONAL EST
    LEFT OUTER JOIN TAXON_SUB_FLEXT1
    on EST.ELEMENT_SUBNATIONAL_ID = TAXON_SUB_FLEXT1.ELEMENT_SUBNATIONAL_ID
    where
    (
    FLD_GUIDE_SPECIES = ''Y''

    -- Mayfly group account
    OR ELGROUP_NAME(EST.ELEMENT_SUBNATIONAL_ID) = ''Mayflies''

    -- Multi-species accounts    
    OR SCI_NAME(EST.ELEMENT_SUBNATIONAL_ID) IN
        (''Ammospiza maritima fisheri'',''Ammospiza maritima macgillivraii'',''Ammospiza maritima peninsulae''
        ,''Cistothorus palustris griseus'',''Cistothorus palustris marianae''
        ,''Liguus fasciatus matecumbensis'',''Liguus fasciatus septentrionalis''
--        ,''Neovison vison halilimnetes'',''Neovison vison lutensis''
        ,''Oryzomys palustris argentatus''
--        ,''Oryzomys palustris sanibeli''
        ,''Malaclemys terrapin rhizophorarum'')
    )
) FG_SUBQRY ON EST.ELEMENT_SUBNATIONAL_ID = FG_SUBQRY.ELEMENT_SUBNATIONAL_ID

inner join element_national
on est.element_national_id = element_national.element_national_id
inner join element_global egt
on element_national.element_global_id = egt.element_global_id
inner join scientific_name sname
on egt.gname_id = sname.scientific_name_id

WHERE est.d_eo_track_status_id = 1 OR FG_SUBQRY.FILENAME is Not Null OR S_STaTUS(est.ELEMENT_SUBNATIONAL_ID) <> ''N''
order by sort_order, sci_name;'::varchar AS text,'5077 - Severity CRITICAL - PostgreSQL doesn''t support the PIVOT clause for SELECT statements. Revise your code to use a procedure to prepare data and then return data as a view.
5578 - Severity CRITICAL - DMS SC can''t convert the SELECT statement. Revise your SELECT statement and try again.
'::varchar AS error_msg;


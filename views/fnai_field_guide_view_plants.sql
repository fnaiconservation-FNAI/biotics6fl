CREATE OR REPLACE  VIEW ext.fnai_field_guide_view_plants (est_id, cname, full_sp, sci_name, frm_full_sp, frm_sci_name, frm_sci_name_b, full_sp_auth, var_or_ssp, frm_var_or_ssp, var_spp_auth, synonyms, family, family_comm, grank, srank, srank_rvw_dt, federal, sprot, nwistat, flwetland, flddescr, simspp, relrarespp, habitat, bestsurvey, rwdistr, constatus, protmgmt, refs, county_map, photo1, photo2, photo3, photo4, photo5, photo6, caption1, caption2, caption3, caption4, caption5, caption6, fg_v_date, search_image, counties_present, counties_extirpated, drawing1, drawing1_caption, infra_taxa_sprot_com, fnai_track_status) AS
SELECT
    est.element_subnational_id AS est_id, est.s_primary_common_name AS cname, TRIM(regexp_replace((ext.sci_name(est.element_subnational_id))::TEXT, (E'\\s+(var\\.|ssp\\.|forma).*$')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER)) AS full_sp,
    /* case when sci_name(est.element_subnational_id) like '% var. %' */
    /* then substr(sci_name(est.element_subnational_id),1,instr( */
    /* sci_name(est.element_subnational_id),' var. ')-1) */
    /* when sci_name(est.element_subnational_id) like '% ssp. %' */
    /* then substr(sci_name(est.element_subnational_id),1,instr( */
    /* sci_name(est.element_subnational_id),' ssp. ')-1) */
    /* else sci_name(est.element_subnational_id) */
    /* END AS full_sp, */
    ext.sci_name(est.element_subnational_id) AS sci_name,
    /* ,case */
    /* when sci_name(est.element_subnational_id) like '% var. %' */
    /* then '<i>' || substr(sci_name(est.element_subnational_id),1,instr( */
    /* sci_name(est.element_subnational_id),' var. ')-1)  || '</i>' */
    /* when sci_name(est.element_subnational_id) like '% ssp. %' */
    /* then '<i>' || substr(sci_name(est.element_subnational_id),1,instr( */
    /* sci_name(est.element_subnational_id),' ssp. ')-1)  || '</i>' */
    /* else '<i>' || sci_name(est.element_subnational_id) || '</i>' */
    /* END AS frm_full_sp, */
    CASE
        WHEN regexp_like((ext.sci_name(est.element_subnational_id))::TEXT, (E' (var\\.|ssp\\.|forma) ')::TEXT) THEN regexp_replace((ext.sci_name(est.element_subnational_id))::TEXT, (E'^(\\S+\\s+\\S+)\\s+(var\\.|ssp\\.|forma)\\s+(.+)$')::TEXT, coalesce((E'<i>\\1</i> \\2 <i>\\3</i>')::TEXT, ''), (1)::INTEGER, (0)::INTEGER)
        ELSE CONCAT_WS('', '<i>', ext.sci_name(est.element_subnational_id), '</i>')
    END AS frm_full_sp, ext.form_sci_name(est.element_subnational_id) AS frm_sci_name, CONCAT_WS('', '<b>', ext.form_sci_name(est.element_subnational_id), '</b>') AS frm_sci_name_b,
    /* ,case */
    /* when sci_name(est.element_subnational_id) like '% var. %' */
    /* then delimlist('select sn.author_name from scientific_name sn ' || */
    /* 'where  sn.scientific_name = ' || */
    /* 'substr(sci_name(' || est.element_subnational_id || '),1,instr( ' || */
    /* 'sci_name(' || est.element_subnational_id || '),'' var. '')-1)' ) */
    /* when sci_name(est.element_subnational_id) like '% ssp. %' */
    /* then delimlist('select sn.author_name from scientific_name sn ' || */
    /* 'where  sn.scientific_name = ' || */
    /* 'substr(sci_name(' || est.element_subnational_id || '),1,instr( ' || */
    /* 'sci_name(' || est.element_subnational_id || '),'' ssp. '')-1)' ) */
    /* else sn.AUTHOR_NAME */
    /* END as full_sp_auth */
    (SELECT
        snsub.author_name
        FROM core.scientific_name AS snsub
        WHERE snsub.scientific_name = TRIM(regexp_replace((sci_name::TEXT)::TEXT, (E'\\s+(var\\.|ssp\\.|forma).*$')::TEXT, coalesce((NULL)::TEXT, ''), (1)::INTEGER, (0)::INTEGER))
        FETCH FIRST (TRUNC(1::NUMERIC)) ROWS ONLY) AS full_sp_auth,
    CASE
        WHEN ext.sci_name(est.element_subnational_id) LIKE '% var. %' THEN oracle.substr(ext.sci_name(est.element_subnational_id), oracle.INSTR(ext.sci_name(est.element_subnational_id), ' var. ') + 1, 50)
        WHEN ext.sci_name(est.element_subnational_id) LIKE '% ssp. %' THEN oracle.substr(ext.sci_name(est.element_subnational_id), oracle.INSTR(ext.sci_name(est.element_subnational_id), ' ssp. ') + 1, 50)
        ELSE NULL
    END AS var_or_ssp,
    CASE
        WHEN ext.sci_name(est.element_subnational_id) LIKE '% var. %' THEN CONCAT_WS('', 'var. <i>', oracle.substr(ext.sci_name(est.element_subnational_id), oracle.INSTR(ext.sci_name(est.element_subnational_id), ' var. ') + 6, 50), '</i>')
        WHEN ext.sci_name(est.element_subnational_id) LIKE '% ssp. %' THEN CONCAT_WS('', 'ssp. <i>', oracle.substr(ext.sci_name(est.element_subnational_id), oracle.INSTR(ext.sci_name(est.element_subnational_id), ' ssp. ') + 6, 50), '</i>')
        ELSE NULL
    END AS frm_var_or_ssp,
    CASE
        WHEN ext.sci_name(est.element_subnational_id) LIKE '% var. %' OR ext.sci_name(est.element_subnational_id) LIKE '% ssp. %' THEN sn.author_name
        ELSE NULL
    END AS var_spp_auth, COALESCE(STRING_AGG.synonyms(), 'none') AS synonyms,
    /*
    for families we have to handle a few exceptions because Biotics doesn't always come up
    with the family we want to use in the guide
    */
    CASE
        WHEN ext.family(est.element_subnational_id) = 'Anemiaceae' THEN 'Schizaeaceae'
        WHEN ext.family(est.element_subnational_id) = 'Monotropaceae' THEN 'Ericaceae'
        WHEN ext.sci_name(est.element_subnational_id) LIKE 'Hymenocallis%' THEN 'Amaryllidaceae'
        ELSE ext.family(est.element_subnational_id)
    END AS family,
    /* for common names for families we first deal with the same exceptions as above */
    CASE
        WHEN ext.family(est.element_subnational_id) = 'Alismataceae' THEN 'water plantain'
        WHEN ext.family(est.element_subnational_id) = 'Anemiaceae' THEN 'curly-grass fern'
        WHEN ext.family(est.element_subnational_id) = 'Monotropaceae' THEN 'heath'
        WHEN ext.sci_name(est.element_subnational_id) LIKE 'Hymenocallis%' THEN 'amaryllis'
        WHEN ext.family(est.element_subnational_id) = 'Acanthaceae' THEN 'acanthus'
        WHEN ext.family(est.element_subnational_id) = 'Agavaceae' THEN 'agave'
        WHEN ext.family(est.element_subnational_id) = 'Amaryllidaceae' THEN 'amaryllis'
        WHEN ext.family(est.element_subnational_id) = 'Annonaceae' THEN 'custard apple'
        WHEN ext.family(est.element_subnational_id) = 'Apiaceae' THEN 'parsley'
        WHEN ext.family(est.element_subnational_id) = 'Apocynaceae' THEN 'dogbane'
        WHEN ext.family(est.element_subnational_id) = 'Arecaceae' THEN 'palm'
        WHEN ext.family(est.element_subnational_id) = 'Asclepiadaceae' THEN 'milkweed'
        WHEN ext.family(est.element_subnational_id) = 'Asparagaceae' THEN 'asparagus'
        WHEN ext.family(est.element_subnational_id) = 'Aspleniaceae' THEN 'spleenwort'
        WHEN ext.family(est.element_subnational_id) = 'Asteraceae' THEN 'composite'
        WHEN ext.family(est.element_subnational_id) = 'Athyriaceae' THEN 'lady fern'
        WHEN ext.family(est.element_subnational_id) = 'Boraginaceae' THEN 'borage'
        WHEN ext.family(est.element_subnational_id) = 'Brassicaceae' THEN 'mustard'
        WHEN ext.family(est.element_subnational_id) = 'Bromeliaceae' THEN 'pineapple'
        WHEN ext.family(est.element_subnational_id) = 'Cactaceae' THEN 'cactus'
        WHEN ext.family(est.element_subnational_id) = 'Calycanthaceae' THEN 'sweetshrub'
        WHEN ext.family(est.element_subnational_id) = 'Campanulaceae' THEN 'bellflower'
        WHEN ext.family(est.element_subnational_id) = 'Canellaceae' THEN 'canella'
        WHEN ext.family(est.element_subnational_id) = 'Cannabaceae' THEN 'hops'
        WHEN ext.family(est.element_subnational_id) = 'Caryophyllaceae' THEN 'pink'
        WHEN ext.family(est.element_subnational_id) = 'Celastraceae' THEN 'bittersweet'
        WHEN ext.family(est.element_subnational_id) = 'Cistaceae' THEN 'rockrose'
        WHEN ext.family(est.element_subnational_id) = 'Cladoniaceae' THEN 'reindeer lichen'
        WHEN ext.family(est.element_subnational_id) = 'Clusiaceae' THEN 'mangosteen'
        WHEN ext.family(est.element_subnational_id) = 'Colchicaceae' THEN 'meadow-saffron'
        WHEN ext.family(est.element_subnational_id) = 'Commelinaceae' THEN 'spiderwort'
        WHEN ext.family(est.element_subnational_id) = 'Convolvulaceae' THEN 'morning-glory'
        WHEN ext.family(est.element_subnational_id) = 'Cordiaceae' THEN 'geiger-tree'
        WHEN ext.family(est.element_subnational_id) = 'Cucurbitaceae' THEN 'squash'
        WHEN ext.family(est.element_subnational_id) = 'Cyperaceae' THEN 'sedge'
        WHEN ext.family(est.element_subnational_id) = 'Dennstaedtiaceae' THEN 'cuplet fern'
        WHEN ext.family(est.element_subnational_id) = 'Droseraceae' THEN 'sundew'
        WHEN ext.family(est.element_subnational_id) = 'Dryopteridaceae' THEN 'wood fern'
        WHEN ext.family(est.element_subnational_id) = 'Ehretiaceae' THEN 'ehretia'
        WHEN ext.family(est.element_subnational_id) = 'Ericaceae' THEN 'heath'
        WHEN ext.family(est.element_subnational_id) = 'Eriocaulaceae' THEN 'pipewort'
        WHEN ext.family(est.element_subnational_id) = 'Euphorbiaceae' THEN 'spurge'
        WHEN ext.family(est.element_subnational_id) = 'Fabaceae' THEN 'pea'
        WHEN ext.family(est.element_subnational_id) = 'Fagaceae' THEN 'beech'
        WHEN ext.family(est.element_subnational_id) = 'Gentianaceae' THEN 'gentian'
        WHEN ext.family(est.element_subnational_id) = 'Gleicheniaceae' THEN 'forked fern'
        WHEN ext.family(est.element_subnational_id) = 'Goodeniaceae' THEN 'goodenia'
        WHEN ext.family(est.element_subnational_id) = 'Grossulariaceae' THEN 'gooseberry'
        WHEN ext.family(est.element_subnational_id) = 'Haloragaceae' THEN 'water milfoil'
        WHEN ext.family(est.element_subnational_id) = 'Hamamelidaceae' THEN 'witch hazel'
        WHEN ext.family(est.element_subnational_id) = 'Heliotropiaceae' THEN 'heliotrope'
        WHEN ext.family(est.element_subnational_id) = 'Hydrocharitaceae' THEN 'frog''s-bit'
        WHEN ext.family(est.element_subnational_id) = 'Hymenophyllaceae' THEN 'filmy fern'
        WHEN ext.family(est.element_subnational_id) = 'Hypericaceae' THEN 'St.John''s-wort'
        WHEN ext.family(est.element_subnational_id) = 'Illiciaceae' THEN 'anisetree'
        WHEN ext.family(est.element_subnational_id) = 'Isoetaceae' THEN 'quillwort'
        WHEN ext.family(est.element_subnational_id) = 'Iridaceae' THEN 'iris'
        WHEN ext.family(est.element_subnational_id) = 'Jubulaceae' THEN 'liverwort'
        WHEN ext.family(est.element_subnational_id) = 'Lamiaceae' THEN 'mint'
        WHEN ext.family(est.element_subnational_id) = 'Lauraceae' THEN 'laurel'
        WHEN ext.family(est.element_subnational_id) = 'Leitneriaceae' THEN 'corkwood'
        WHEN ext.family(est.element_subnational_id) = 'Lentibulariaceae' THEN 'butterwort'
        WHEN ext.family(est.element_subnational_id) = 'Liliaceae' THEN 'lily'
        WHEN ext.family(est.element_subnational_id) = 'Linaceae' THEN 'flax'
        WHEN ext.family(est.element_subnational_id) = 'Lindsaeaceae' THEN 'necklace fern'
        WHEN ext.family(est.element_subnational_id) = 'Loganiaceae' THEN 'strychnine'
        WHEN ext.family(est.element_subnational_id) = 'Lythraceae' THEN 'loosestrife'
        WHEN ext.family(est.element_subnational_id) = 'Magnoliaceae' THEN 'magnolia'
        WHEN ext.family(est.element_subnational_id) = 'Malpighiaceae' THEN 'malphighia'
        WHEN ext.family(est.element_subnational_id) = 'Malvaceae' THEN 'mallow'
        WHEN ext.family(est.element_subnational_id) = 'Melanthiaceae' THEN 'bunchflower'
        WHEN ext.family(est.element_subnational_id) = 'Melastomataceae' THEN 'meadow-beauty'
        WHEN ext.family(est.element_subnational_id) = 'Meliaceae' THEN 'mahogany'
        WHEN ext.family(est.element_subnational_id) = 'Myrtaceae' THEN 'myrtle'
        WHEN ext.family(est.element_subnational_id) = 'Najadaceae' THEN 'water-nymph'
        WHEN ext.family(est.element_subnational_id) = 'Nephrolepidaceae' THEN 'sword fern'
        WHEN ext.family(est.element_subnational_id) = 'Nyctaginaceae' THEN 'four-o''clock'
        WHEN ext.family(est.element_subnational_id) = 'Nymphaeaceae' THEN 'waterlily'
        WHEN ext.family(est.element_subnational_id) = 'Nyssaceae' THEN 'sour gum'
        WHEN ext.family(est.element_subnational_id) = 'Oleaceae' THEN 'olive'
        WHEN ext.family(est.element_subnational_id) = 'Onagraceae' THEN 'evening primrose'
        WHEN ext.family(est.element_subnational_id) = 'Ophioglossaceae' THEN 'adder''s tongue'
        WHEN ext.family(est.element_subnational_id) = 'Orobanchaceae' THEN 'broomrape'
        WHEN ext.family(est.element_subnational_id) = 'Orchidaceae' THEN 'orchid'
        WHEN ext.family(est.element_subnational_id) = 'Osmundaceae' THEN 'royal fern'
        WHEN ext.family(est.element_subnational_id) = 'Passifloraceae' THEN 'passionflower'
        WHEN ext.family(est.element_subnational_id) = 'Petiveriaceae' THEN 'petiveria'
        WHEN ext.family(est.element_subnational_id) = 'Phyllanthaceae' THEN 'leaf-flower'
        WHEN ext.family(est.element_subnational_id) = 'Picramniaceae' THEN 'bitterbush'
        WHEN ext.family(est.element_subnational_id) = 'Piperaceae' THEN 'pepper'
        WHEN ext.family(est.element_subnational_id) = 'Poaceae' THEN 'grass'
        WHEN ext.family(est.element_subnational_id) = 'Polygalaceae' THEN 'milkwort'
        WHEN ext.family(est.element_subnational_id) = 'Polygonaceae' THEN 'buckwheat'
        WHEN ext.family(est.element_subnational_id) = 'Polypodiaceae' THEN 'polypody'
        WHEN ext.family(est.element_subnational_id) = 'Portulacaceae' THEN 'purslane'
        WHEN ext.family(est.element_subnational_id) = 'Potamogetonaceae' THEN 'pondweed'
        WHEN ext.family(est.element_subnational_id) = 'Primulaceae' THEN 'primrose'
        WHEN ext.family(est.element_subnational_id) = 'Pteridaceae' THEN 'maidenhair fern'
        WHEN ext.family(est.element_subnational_id) = 'Putranjivaceae' THEN 'Guiana-plum'
        WHEN ext.family(est.element_subnational_id) = 'Ranunculaceae' THEN 'buttercup'
        WHEN ext.family(est.element_subnational_id) = 'Rhamnaceae' THEN 'buckthorn'
        WHEN ext.family(est.element_subnational_id) = 'Rosaceae' THEN 'rose'
        WHEN ext.family(est.element_subnational_id) = 'Rubiaceae' THEN 'coffee'
        WHEN ext.family(est.element_subnational_id) = 'Rutaceae' THEN 'citrus'
        WHEN ext.family(est.element_subnational_id) = 'Salicaceae' THEN 'willow'
        WHEN ext.family(est.element_subnational_id) = 'Sapindaceae' THEN 'soapberry'
        WHEN ext.family(est.element_subnational_id) = 'Sapotaceae' THEN 'sapodilla'
        WHEN ext.family(est.element_subnational_id) = 'Sarraceniaceae' THEN 'pitcherplant'
        WHEN ext.family(est.element_subnational_id) = 'Saxifragaceae' THEN 'saxifrage'
        WHEN ext.family(est.element_subnational_id) = 'Schisandraceae' THEN 'star-vine'
        WHEN ext.family(est.element_subnational_id) = 'Scrophulariaceae' THEN 'snapdragon'
        WHEN ext.family(est.element_subnational_id) = 'Simaroubaceae' THEN 'quassia'
        WHEN ext.family(est.element_subnational_id) = 'Smilacaceae' THEN 'greenbrier'
        WHEN ext.family(est.element_subnational_id) = 'Solanaceae' THEN 'nightshade'
        WHEN ext.family(est.element_subnational_id) = 'Stemonaceae' THEN 'stemona'
        WHEN ext.family(est.element_subnational_id) = 'Taxaceae' THEN 'yew'
        WHEN ext.family(est.element_subnational_id) = 'Tectariaceae' THEN 'halberd fern'
        WHEN ext.family(est.element_subnational_id) = 'Theaceae' THEN 'tea'
        WHEN ext.family(est.element_subnational_id) = 'Thelypteridaceae' THEN 'marsh fern'
        WHEN ext.family(est.element_subnational_id) = 'Theophrastaceae' THEN 'theophrasta'
        WHEN ext.family(est.element_subnational_id) = 'Tofieldiaceae' THEN 'false-asphodel'
        WHEN ext.family(est.element_subnational_id) = 'Ulmaceae' THEN 'elm'
        WHEN ext.family(est.element_subnational_id) = 'Urticaceae' THEN 'nettle'
        WHEN ext.family(est.element_subnational_id) = 'Verbenaceae' THEN 'vervain'
        WHEN ext.family(est.element_subnational_id) = 'Xyridaceae' THEN 'yellow-eyed grass'
        WHEN ext.family(est.element_subnational_id) = 'Zamiaceae' THEN 'zamia'
        WHEN ext.family(est.element_subnational_id) = 'Zygophyllaceae' THEN 'caltrop'
        WHEN ext.family(est.element_subnational_id) = 'Cyrillaceae' THEN 'titi'
        WHEN ext.family(est.element_subnational_id) = 'Buxaceae' THEN 'boxwood'
        WHEN ext.family(est.element_subnational_id) = 'Woodsiaceae' THEN 'woodsia'
        WHEN ext.family(est.element_subnational_id) = 'Hypoxidaceae' THEN 'stargrass'
        WHEN ext.family(est.element_subnational_id) = 'Aquifoliaceae' THEN 'holly'
        WHEN ext.family(est.element_subnational_id) = 'Berberidaceae' THEN 'barberry'
        WHEN ext.family(est.element_subnational_id) = 'Aristolochiaceae' THEN 'birthwort'
        WHEN ext.family(est.element_subnational_id) = 'Hydrangeaceae' THEN 'hydrangea'
    END AS family_comm,
    /* ************************************************************************************************** */
    ext.grank(est.element_subnational_id) AS grank, est.s_rank AS srank, est.s_rank_review_date AS srank_rvw_dt,
    CASE
        WHEN ext.federal(est.element_subnational_id) IN ('T', 'T, PDL') THEN 'Threatened'
        WHEN ext.federal(est.element_subnational_id) IN ('E', 'E, PDL') THEN 'Endangered'
        WHEN ext.federal(est.element_subnational_id) IN ('C') THEN 'Candidate'
        ELSE 'none'
    END AS federal,
    CASE
        WHEN est.s_protection_status IN ('T', 'FT') THEN 'Threatened'
        WHEN est.s_protection_status IN ('E', 'FE') THEN 'Endangered'
        WHEN est.s_protection_status = 'CE' THEN 'Commercially Exploited'
        ELSE 'none'
    END AS sprot, COALESCE((SELECT
        nwi.nwi_status
        FROM core.nwi_regional_status AS nwi
        WHERE nwi.element_national_id = est.element_national_id
        FETCH FIRST (TRUNC(1::NUMERIC)) ROWS ONLY), 'none') AS nwistat,
    CASE
        WHEN tax.fl_wetland_status IS NULL THEN 'none'
        ELSE tax.fl_wetland_status
    END AS flwetland, ext.clean_up_all_except_itl_bld(cas.s_id_com) AS flddescr, ext.clean_up_all_except_italics(cas.lookalikes) AS simspp, ext.clean_up_all_except_italics(tax.sim_and_related_spp) AS relrarespp, ext.clean_up_all_except_italics(oracle.substr(lob_loc => cas.s_habitat_com, amount => 4000, "offset" => 1)) AS habitat, ext.clean_up_all_except_italics(cas.s_phenology_com) AS bestsurvey, ext.clean_up_all_except_italics(tax.range_wide_distrib) AS rwdistr,
    /* dbms_lob.substr(esr.s_other_rank_consid_com,4000,1) */
    ext.clean_up_all_except_italics(tax.cons_status) AS constatus, ext.clean_up_all_except_italics(esr.s_management_needs) AS protmgmt, ext.clean_up_all_except_italics(tax.fld_guide_refs) AS refs, CONCAT_WS('', E'K:\\Science_Information\\Data_Mgmt\\Data_reports_CRv9\\EST\\Field_Guide_report\\Maps_png\\', replace(replace(ext.sci_name(est.element_subnational_id), ' ', '_'), '.', ''), '_map.png') AS county_map,
    CASE
        WHEN tax.photo1 IS NULL THEN E'K:\\Image_Library\\Plants\\Field_guide\\_No_image_available_for_plant.jpg'
        ELSE replace(replace(tax.photo1, '"', ''), E'K:\\Florida Natural Areas Inventory\\Current', 'K:')
    END AS photo1, replace(replace(tax.photo2, '"', ''), E'K:\\Florida Natural Areas Inventory\\Current', 'K:') AS photo2, replace(replace(tax.photo3, '"', ''), E'K:\\Florida Natural Areas Inventory\\Current', 'K:') AS photo3, replace(replace(tax.photo4, '"', ''), E'K:\\Florida Natural Areas Inventory\\Current', 'K:') AS photo4, replace(replace(tax.photo5, '"', ''), E'K:\\Florida Natural Areas Inventory\\Current', 'K:') AS photo5, replace(replace(tax.photo6, '"', ''), E'K:\\Florida Natural Areas Inventory\\Current', 'K:') AS photo6, ext.clean_up_all_except_italics(tax.caption1) AS caption1, ext.clean_up_all_except_italics(tax.caption2) AS caption2, ext.clean_up_all_except_italics(tax.caption3) AS caption3, ext.clean_up_all_except_italics(tax.caption4) AS caption4, ext.clean_up_all_except_italics(tax.caption5) AS caption5, ext.clean_up_all_except_italics(tax.caption6) AS caption6, tax.field_guide_version_date AS fg_v_date, ext.clean_up_all_except_italics(tax.fwc_search_image) AS search_image, STRING_AGG.counties_present(), STRING_AGG.counties_extirpated(), replace(tax.drawing1, '"', '') AS drawing1, ext.clean_up(tax.drawing1_caption) AS drawing1_caption,
    CASE
        WHEN regexp_like((ext.sci_name(est.element_subnational_id))::TEXT, (E'\\svar\\.\\s|\\sssp\\.\\s')::TEXT, 'i') AND est.s_protection_status IN ('T', 'E', 'CE', 'FE', 'FT') THEN 'State-listing status is based on the full species'
    END AS infra_taxa_sprot_com,
    CASE
        WHEN est.d_eo_track_status_id = 1 THEN 'Yes'
        ELSE 'No'
    END AS fnai_track_status
    FROM core.element_subnational AS est
    LEFT OUTER JOIN core.element_national AS ent
        ON est.element_national_id = ent.element_national_id
    LEFT OUTER JOIN core.element_global AS egt
        ON ent.element_global_id = egt.element_global_id
    LEFT OUTER JOIN core.plant_cas AS cas
        ON est.element_subnational_id = cas.element_subnational_id
    LEFT OUTER JOIN core.element_subnatl_rank AS esr
        ON est.element_subnational_id = esr.element_subnational_id
    LEFT OUTER JOIN core.element_global_rank AS egr
        ON egt.element_global_id = egr.element_global_id
    LEFT OUTER JOIN ext.taxon_sub_flext1 AS tax
        ON est.element_subnational_id = tax.element_subnational_id
    LEFT OUTER JOIN core.scientific_name AS sn
        ON est.sname_id = sn.scientific_name_id
    LEFT OUTER JOIN (SELECT
        COALESCE(pres.est_id, ext.est_id) AS est_id, STRING_AGG(), STRING_AGG()
        FROM (SELECT
            est_id, STRING_AGG(county_name, ', '::TEXT ORDER BY est_id) AS counties_present
            FROM ext.fnai_element_county_view
            WHERE status = 1
            GROUP BY est_id, status, status) AS pres
        FULL OUTER JOIN (SELECT
            est_id, STRING_AGG(county_name, ', '::TEXT ORDER BY est_id) AS counties_extirpated
            FROM ext.fnai_element_county_view
            WHERE status = - 1
            GROUP BY est_id, status, status) AS ext
            ON pres.est_id = ext.est_id) AS cnty_dist
        ON est.element_subnational_id = cnty_dist.est_id
    LEFT OUTER JOIN
    /* Synonyms SUB */
    (SELECT
        est_id, STRING_AGG(taxa_author, '; '::TEXT ORDER BY taxa_author) AS synonyms
        FROM (SELECT DISTINCT
            syn.element_subnational_id AS est_id, CONCAT_WS('',
            CASE
                WHEN regexp_like((sn.scientific_name)::TEXT, (E' (var\\.|ssp\\.|forma) ')::TEXT) THEN regexp_replace((sn.scientific_name)::TEXT, (E'^(\\S+\\s+\\S+)\\s+(var\\.|ssp\\.|forma)\\s+(.+)$')::TEXT, coalesce((E'<i>\\1</i> \\2 <i>\\3</i>')::TEXT, ''), (1)::INTEGER, (0)::INTEGER)
                ELSE CONCAT_WS('', '<i>', sn.scientific_name, '</i>')
            END, ' ', sn.author_name) AS taxa_author
            FROM core.synonym_subnational AS syn
            JOIN core.scientific_name AS sn
                ON syn.scientific_name_id = sn.scientific_name_id) AS var_sbq
        GROUP BY est_id) AS syn
        ON est.element_subnational_id = syn.est_id
    WHERE tax.fld_guide_species = 'Y' AND ext.elgroup_name(est.element_subnational_id) LIKE '%Plant%'
    /* and est.ELEMENT_SUBNATIONAL_ID = 21097 */
    ORDER BY full_sp;


-- Applies custom objects

\ir functions/biotics_html_link.sql
\ir functions/biotics_url.sql
\ir functions/calc_sf_ra.sql
\ir functions/chk_date.sql
\ir functions/chk_eo_refs.sql
\ir functions/chk_nbr.sql
\ir functions/chk_ref.sql
\ir functions/clean_up.sql
\ir functions/clean_up_all_except_italics.sql
\ir functions/clean_up_all_except_itl_bld.sql
\ir functions/clean_up_clob.sql
\ir functions/comm_name.sql
\ir functions/concatt.sql
\ir functions/county.sql
\ir functions/county_sort_order.sql
\ir functions/count_eo_by_est.sql
\ir functions/crystal_r_new_line.sql
\ir functions/elcode.sql
\ir functions/elgroup_name.sql
\ir functions/elgroup_political_name.sql
\ir functions/elgroup_political_order.sql
\ir functions/elgroup_sort_order.sql
\ir functions/eorank.sql
\ir functions/est_lookup.sql
\ir functions/extractpolygon.sql
\ir functions/family.sql
\ir functions/federal.sql
\ir functions/federal_all.sql
\ir functions/form_sci_name.sql
\ir functions/frm_comm_name.sql
\ir functions/fuzzy_txt_score.sql
\ir functions/genus.sql
\ir functions/geom_array_count.sql
\ir functions/getgname.sql
-- \ir functions/get_next_refcode.sql
\ir functions/grank.sql
\ir functions/g_comm_name.sql
\ir functions/g_to_srank.sql
\ir functions/is_number.sql
\ir functions/last_change_date.sql
\ir functions/link_egt.sql
\ir functions/link_eo.sql
\ir functions/link_est.sql
\ir functions/link_ref.sql
\ir functions/link_sf.sql
\ir functions/nbr_obs.sql
\ir functions/nbr_src_features.sql
\ir functions/nowrap.sql
\ir functions/ord.sql
\ir functions/path_egt.sql
\ir functions/path_eo.sql
\ir functions/path_est.sql
\ir functions/path_ref.sql
\ir functions/path_sf.sql
\ir functions/plant_comm.sql
\ir functions/pre_sf_type.sql
\ir functions/quad_of_center.sql
\ir functions/remove_dates.sql
\ir functions/remove_ref_code.sql
\ir functions/report_eonum.sql
\ir functions/rgrank.sql
\ir functions/rounded_grank.sql
\ir functions/rsrank.sql
\ir functions/sci_name.sql
\ir functions/sci_name_w_author.sql
\ir functions/sf_ma.sql
\ir functions/sf_maid.sql
\ir functions/sgcn_status.sql
\ir functions/sgcn_trend.sql
\ir functions/species.sql
\ir functions/species_name.sql
\ir functions/subspecies.sql
\ir functions/s_status.sql
\ir functions/textafter.sql
\ir functions/textbefore.sql
\ir functions/text_length.sql
\ir functions/trank.sql
\ir functions/trimm.sql
\ir functions/txt_num_to_int.sql
\ir functions/value_on_date.sql
-- chk_txt_date Depends on: Custom Function CHK_DATE, Custom Function CHK_NBR
\ir functions/chk_txt_date.sql
-- links Depends on: Custom Function ELGROUP_NAME
\ir functions/links.sql
-- txt_date_to_date Depends on: Custom Function CHK_DATE, Custom Function CHK_NBR, Custom Function CHK_TXT_DATE
\ir functions/txt_date_to_date.sql
-- usesa_on_date Depends on: Custom Function VALUE_ON_DATE
\ir functions/usesa_on_date.sql
\ir views/bdcs_eo_subset_1_vw.sql
-- \ir views/dx_bcd_sa_vw.sql
\ir views/egr_clobs_vw.sql
\ir views/element_global_clobs_vw.sql
-- \ir views/eo_subnation_xvw.sql
\ir views/fnai_animal_hab_view.sql
\ir views/fnai_eo_bestshelfnote.sql
\ir views/fnai_eo_update_nomaplabel.sql
-- \ir views/fnai_inat_source_feature_del.sql
\ir views/fnai_ma_acreage_view.sql
\ir views/fnai_ma_summary_view.sql
\ir views/fnai_natcomm_syn_view.sql
\ir views/fnai_plant_hab_view.sql
\ir views/fnai_reference_keyword_view.sql
\ir views/fnai_src_shapes.sql
\ir views/nhp_auditlog_sciname_vw.sql
-- \ir views/sf_subnation_xvw.sql
-- \ir views/tracking_report_view.sql
-- \ir procedures/clean_del_all.sql
\ir procedures/fix_source_feature_shape_type.sql
\ir procedures/qry_biotics.sql
\ir procedures/query_corrupted_records.sql
-- est_eo_count Depends on: Custom View FNAI_SRC_SHAPES, Custom Function GEOM_ARRAY_COUNT
\ir functions/est_eo_count.sql
-- lower_comm_name Depends on: Custom Table TAXON_SUB_FLEXT1
\ir functions/lower_comm_name.sql
-- current_qtr_status Depends on: Custom Function ELGROUP_NAME, Custom Function REPORT_EONUM
\ir views/current_qtr_status.sql
-- element_info_for_occstatus Depends on: Custom Function COMM_NAME, Custom Function ELCODE, Custom Function GRANK, Custom Function SCI_NAME
\ir views/element_info_for_occstatus.sql
-- elgroup_list Depends on: Custom Function ELGROUP_NAME
\ir views/elgroup_list.sql
-- fnai_basic_eo_rep_info_vw Depends on: Custom Function CLEAN_UP, Custom Function COMM_NAME, Custom Function ELCODE, Custom Function REPORT_EONUM, Custom Function SCI_NAME
-- \ir views/fnai_basic_eo_rep_info_vw.sql
-- fnai_basic_src_feature_info_vw Depends on: Custom Function COMM_NAME, Custom Function ELCODE, Custom Function SCI_NAME
\ir views/fnai_basic_src_feature_info_vw.sql
-- fnai_cegl_report_view Depends on: Custom Table EO_FLEXT1
-- \ir views/fnai_cegl_report_view.sql
-- fnai_county_summary_view Depends on: Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER
\ir views/fnai_county_summary_view.sql
-- fnai_current_qtr_status_view Depends on: Custom Function REPORT_EONUM
\ir views/fnai_current_qtr_status_view.sql
-- fnai_deleted_source_info_view Depends on: Custom Function SCI_NAME
\ir views/fnai_deleted_source_info_view.sql
-- fnai_element_bad_tag Depends on: Custom Table TAXON_SUB_FLEXT1
-- \ir views/fnai_element_bad_tag.sql
-- fnai_element_county_list_view Depends on: Custom Function COMM_NAME, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function SCI_NAME
\ir views/fnai_element_county_list_view.sql
-- fnai_element_county_names_view Depends on: Custom Function COMM_NAME, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function SCI_NAME
\ir views/fnai_element_county_names_view.sql
-- fnai_element_county_view Depends on: Custom Function COMM_NAME, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function SCI_NAME
\ir views/fnai_element_county_view.sql
-- fnai_element_id_view Depends on: Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function FEDERAL, Custom Function GRANK, Custom Function SCI_NAME
\ir views/fnai_element_id_view.sql
-- fnai_element_id_view_politic Depends on: Custom Function ELGROUP_POLITICAL_NAME, Custom Function ELGROUP_POLITICAL_ORDER, Custom Function FEDERAL, Custom Function GRANK, Custom Function SCI_NAME
\ir views/fnai_element_id_view_politic.sql
-- fnai_element_level_changes Depends on: Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function SCI_NAME, Custom Function USESA_ON_DATE, Custom Function VALUE_ON_DATE
\ir views/fnai_element_level_changes.sql
-- fnai_element_level_changes1 Depends on: Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function SCI_NAME, Custom Function USESA_ON_DATE, Custom Function VALUE_ON_DATE
\ir views/fnai_element_level_changes1.sql
-- fnai_element_natcomm_view Depends on: Custom Function COMM_NAME, Custom Function ELCODE, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function SCI_NAME
-- \ir views/fnai_element_natcomm_view.sql
-- fnai_element_status_view Depends on: Custom Function CRYSTAL_R_NEW_LINE, Custom Function ELGROUP_NAME, Custom Function FEDERAL, Custom Function FORM_SCI_NAME, Custom Function SCI_NAME
-- \ir views/fnai_element_status_view.sql
-- fnai_el_rank_rev_per_yr_pbi Depends on: Custom Function ELGROUP_POLITICAL_NAME
-- \ir views/fnai_el_rank_rev_per_yr_pbi.sql
-- fnai_el_rnk_rev_age_per_yr_pbi Depends on: Custom Function ELGROUP_POLITICAL_NAME, Custom Function IS_NUMBER, Custom Function VALUE_ON_DATE
\ir views/fnai_el_rnk_rev_age_per_yr_pbi.sql
-- fnai_eo_loc_view Depends on: Custom Function REPORT_EONUM
-- \ir views/fnai_eo_loc_view.sql
-- fnai_eo_prioritization_view Depends on: Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function GRANK, Custom Function SCI_NAME
-- \ir views/fnai_eo_prioritization_view.sql
-- fnai_eo_qc_needed_view Depends on: Custom Table EO_FLEXT1, Custom Function ELGROUP_NAME, Custom Function LAST_CHANGE_DATE, Custom Function SCI_NAME, Custom Function VALUE_ON_DATE
\ir views/fnai_eo_qc_needed_view.sql
-- fnai_eo_qc_passed_view_pbi Depends on: Custom Table EO_FLEXT1
\ir views/fnai_eo_qc_passed_view_pbi.sql
-- fnai_eo_qc_view_pbi Depends on: Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function NBR_SRC_FEATURES, Custom Function SCI_NAME
\ir views/fnai_eo_qc_view_pbi.sql
-- fnai_eo_sources_view Depends on: Custom Function REPORT_EONUM
\ir views/fnai_eo_sources_view.sql
-- fnai_eo_spec Depends on: Custom Function ELGROUP_NAME
\ir views/fnai_eo_spec.sql
-- fnai_eo_status_view Depends on: Custom Table EO_FLEXT1, Custom Function ELGROUP_NAME, Custom Function LAST_CHANGE_DATE, Custom Function SCI_NAME, Custom Function VALUE_ON_DATE
\ir views/fnai_eo_status_view.sql
-- fnai_eo_update_selection_view Depends on: Custom Function REPORT_EONUM
\ir views/fnai_eo_update_selection_view.sql
-- fnai_est_phenology Depends on: Custom Table SOURCE_FEATURE_FLEXT1, Custom Function CHK_DATE, Custom Function CHK_NBR, Custom Function CHK_TXT_DATE, Custom Function ELGROUP_NAME, Custom Function SCI_NAME
-- \ir views/fnai_est_phenology.sql
-- fnai_field_guide_view_animals Depends on: Custom Table TAXON_SUB_FLEXT1, Custom View FNAI_ELEMENT_COUNTY_VIEW, Custom Function CLEAN_UP_ALL_EXCEPT_ITALICS, Custom Function COMM_NAME, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function FAMILY, Custom Function FEDERAL, Custom Function FORM_SCI_NAME, Custom Function GRANK, Custom Function ORD, Custom Function SCI_NAME
-- \ir views/fnai_field_guide_view_animals.sql
-- fnai_field_guide_view_plants Depends on: Custom Table TAXON_SUB_FLEXT1, Custom View FNAI_ELEMENT_COUNTY_VIEW, Custom Function CLEAN_UP, Custom Function CLEAN_UP_ALL_EXCEPT_ITALICS, Custom Function CLEAN_UP_ALL_EXCEPT_ITL_BLD, Custom Function COMM_NAME, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function FAMILY, Custom Function FEDERAL, Custom Function FORM_SCI_NAME, Custom Function GRANK, Custom Function SCI_NAME
-- \ir views/fnai_field_guide_view_plants.sql
-- fnai_frm_comname_view Depends on: Custom Function FRM_COMM_NAME, Custom Function SCI_NAME
\ir views/fnai_frm_comname_view.sql
-- fnai_habitat_phenology_vw Depends on: Custom Function ELCODE, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function SCI_NAME
\ir views/fnai_habitat_phenology_vw.sql
-- fnai_inat_source_feature Depends on: Custom Table SOURCE_FEATURE_FLEXT1
-- \ir views/fnai_inat_source_feature.sql
-- fnai_infraspecies_parent Depends on: Custom Function TEXTBEFORE
\ir views/fnai_infraspecies_parent.sql
-- fnai_loc_use Depends on: Custom Function ELGROUP_NAME, Custom Function SCI_NAME
\ir views/fnai_loc_use.sql
-- fnai_ma_elements_view Depends on: Custom Function COMM_NAME, Custom Function SCI_NAME
\ir views/fnai_ma_elements_view.sql
-- fnai_ma_flma_view Depends on: Custom Table MA_FLEXT1
\ir views/fnai_ma_flma_view.sql
-- fnai_report_eonum Depends on: Custom Function REPORT_EONUM, Custom Function SCI_NAME
\ir views/fnai_report_eonum.sql
-- fnai_searchable_tracking_list Depends on: Custom Table TAXON_SUB_FLEXT1, Custom View FNAI_ELEMENT_COUNTY_VIEW, Custom Function COMM_NAME, Custom Function ELGROUP_NAME, Custom Function ELGROUP_POLITICAL_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function FEDERAL, Custom Function GRANK, Custom Function SCI_NAME, Custom Function S_STATUS
\ir views/fnai_searchable_tracking_list.sql
-- fnai_sf_qc_text_view_pbi Depends on: Custom Table EO_FLEXT1, Custom Table SOURCE_FEATURE_FLEXT1, Custom View FNAI_EO_STATUS_VIEW, Custom Function CHK_DATE, Custom Function CHK_NBR, Custom Function CHK_TXT_DATE, Custom Function CLEAN_UP, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function LAST_CHANGE_DATE, Custom Function NBR_OBS, Custom Function PRE_SF_TYPE, Custom Function SCI_NAME, Custom Function VALUE_ON_DATE
-- \ir views/fnai_sf_qc_text_view_pbi.sql
-- fnai_sf_qc_view Depends on: Custom Table EO_FLEXT1, Custom Table SOURCE_FEATURE_FLEXT1, Custom View FNAI_EO_STATUS_VIEW, Custom Function CHK_DATE, Custom Function CHK_NBR, Custom Function CHK_TXT_DATE, Custom Function CLEAN_UP, Custom Function CONCATT, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function LAST_CHANGE_DATE, Custom Function NBR_OBS, Custom Function PRE_SF_TYPE, Custom Function SCI_NAME, Custom Function VALUE_ON_DATE
-- \ir views/fnai_sf_qc_view.sql
-- fnai_site_ffbot_view Depends on: Custom Table D_FLEXT_FF_CATEGORY, Custom Table SITE_FLEXT1
-- \ir views/fnai_site_ffbot_view.sql
-- fnai_src_data_for_occstatus Depends on: Custom Table D_SOURCE_FEATURE_RANK, Custom Table SOURCE_FEATURE_FLEXT1, Custom Function COMM_NAME, Custom Function ELCODE, Custom Function FEDERAL, Custom Function GRANK, Custom Function REPORT_EONUM, Custom Function SCI_NAME
-- \ir views/fnai_src_data_for_occstatus.sql
-- fnai_tracking_status_fullview Depends on: Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function FEDERAL
\ir views/fnai_tracking_status_fullview.sql
-- fnai_tracking_status_view Depends on: Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function FEDERAL
\ir views/fnai_tracking_status_view.sql
-- fnai_txt_to_trimm Depends on: Custom Function TRIMM
-- \ir views/fnai_txt_to_trimm.sql
-- fnai_eo_fleo_sens_view Depends on: Custom Table EO_FLEXT1, Custom View FNAI_EO_STATUS_VIEW, Custom Function CLEAN_UP, Custom Function ELGROUP_NAME, Custom Function FEDERAL, Custom Function LAST_CHANGE_DATE, Custom Function NBR_SRC_FEATURES, Custom Function REPORT_EONUM, Custom Function SCI_NAME, Custom Function VALUE_ON_DATE
-- \ir views/fnai_eo_fleo_sens_view.sql
-- fnai_eo_fleo_view Depends on: Custom Table EO_FLEXT1, Custom View FNAI_EO_STATUS_VIEW, Custom Function CLEAN_UP_CLOB, Custom Function ELGROUP_NAME, Custom Function FEDERAL, Custom Function LAST_CHANGE_DATE, Custom Function NBR_SRC_FEATURES, Custom Function REPORT_EONUM, Custom Function SCI_NAME, Custom Function VALUE_ON_DATE
-- \ir views/fnai_eo_fleo_view.sql
-- fnai_eo_qc_text_view_pbi Depends on: Custom Table D_VERSION_FUNDING, Custom Table EO_FLEXT1, Custom Table SOURCE_FEATURE_FLEXT1, Custom View FNAI_EO_STATUS_VIEW, Custom Function CHK_DATE, Custom Function CHK_NBR, Custom Function CHK_REF, Custom Function CHK_TXT_DATE, Custom Function CLEAN_UP, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function LAST_CHANGE_DATE, Custom Function NBR_SRC_FEATURES, Custom Function SCI_NAME, Custom Function VALUE_ON_DATE
-- \ir views/fnai_eo_qc_text_view_pbi.sql
-- fnai_eo_qc_view Depends on: Custom Table D_VERSION_FUNDING, Custom Table EO_FLEXT1, Custom Table SOURCE_FEATURE_FLEXT1, Custom View FNAI_EO_STATUS_VIEW, Custom Function CHK_DATE, Custom Function CHK_NBR, Custom Function CHK_REF, Custom Function CHK_TXT_DATE, Custom Function ELGROUP_NAME, Custom Function ELGROUP_SORT_ORDER, Custom Function LAST_CHANGE_DATE, Custom Function NBR_SRC_FEATURES, Custom Function SCI_NAME, Custom Function TRIMM, Custom Function TXT_DATE_TO_DATE, Custom Function VALUE_ON_DATE
-- \ir views/fnai_eo_qc_view.sql

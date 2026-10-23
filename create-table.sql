-- ------------ Write CREATE-TABLE-stage scripts -----------

CREATE TABLE ext.animal_cas_flext1(
    animal_cas_flext1_id BIGINT NOT NULL,
    element_subnational_id BIGINT NOT NULL,
    alt_phenology CHARACTER VARYING(120)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.audit_changes_results(
    org_unit_id BIGINT,
    table_name CHARACTER VARYING(30),
    primary_key_id BIGINT,
    action_code CHARACTER VARYING(1),
    column_name CHARACTER VARYING(30),
    element_global_seq_uid BIGINT,
    element_global_ou_uid BIGINT,
    element_global_id BIGINT,
    elcode_bcd CHARACTER VARYING(10),
    d_name_category_id BIGINT,
    name_type_cd CHARACTER(1),
    name_category_desc CHARACTER VARYING(70),
    informal_tax CHARACTER VARYING(50),
    gname CHARACTER VARYING(250),
    pending_ind CHARACTER(1) DEFAULT 'N',
    current_value TEXT,
    current_value_desc CHARACTER VARYING(400),
    last_audit_date DATE,
    last_user_name CHARACTER VARYING(30)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.community_sub_flext1(
    community_sub_flext1_id BIGINT NOT NULL,
    element_subnational_id BIGINT NOT NULL,
    datasens CHARACTER VARYING(22)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.d_community_variant(
    d_community_variant_id BIGINT NOT NULL,
    community_variant CHARACTER VARYING(50) NOT NULL,
    display_order BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.d_estimate_precision(
    d_estimate_precision_id BIGINT NOT NULL,
    estimate_precision_desc CHARACTER VARYING(20) NOT NULL,
    display_order BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.d_flext_ff_category(
    d_flext_ff_category_id BIGINT NOT NULL,
    category_cd CHARACTER VARYING(20) NOT NULL,
    category_desc CHARACTER VARYING(55),
    display_order BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.d_flext_priority(
    d_flext_priority_id BIGINT NOT NULL,
    priority_code CHARACTER VARYING(16) NOT NULL,
    priority_desc CHARACTER VARYING(50),
    display_order BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.d_prev_est_available(
    d_prev_est_available_id BIGINT NOT NULL,
    prev_est_available_desc CHARACTER VARYING(10) NOT NULL,
    display_order BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.d_source_feature_rank(
    d_source_feature_rank_id BIGINT NOT NULL,
    source_feature_rank_cd BIGINT NOT NULL,
    source_feature_rank_desc CHARACTER VARYING(20) NOT NULL,
    source_feature_rank_display CHARACTER VARYING(100) NOT NULL,
    display_order BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.d_version_funding(
    d_version_funding_id BIGINT NOT NULL,
    version_funding_code CHARACTER VARYING(5) NOT NULL,
    version_funding_desc CHARACTER VARYING(50) NOT NULL,
    display_value CHARACTER VARYING(50) NOT NULL,
    display_order BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.eo_ext_misc_ind(
    eo_ext_misc_ind_id BIGINT NOT NULL,
    eo_id BIGINT NOT NULL,
    d_prev_est_available_id BIGINT,
    permitted_destruction CHARACTER(1) DEFAULT 'N'
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.eo_flext1(
    eo_flext1_id BIGINT NOT NULL,
    eo_id BIGINT NOT NULL,
    coord_com CHARACTER VARYING(125),
    tnc_assoc CHARACTER VARYING(60),
    tnc_assoccom CHARACTER VARYING(200),
    d_community_variant_id BIGINT,
    classification_comments CHARACTER VARYING(500),
    d_version_funding_id BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.eo_flext2(
    eo_flext2_id BIGINT NOT NULL,
    eo_id BIGINT NOT NULL,
    bestsource_bcd CHARACTER VARYING(500)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.ma_flext1(
    ma_flext1_id BIGINT NOT NULL,
    ma_id BIGINT NOT NULL,
    maname_lc CHARACTER VARYING(100),
    dig_com CHARACTER VARYING(1500),
    maname_abbr CHARACTER VARYING(60),
    ltf_acres CHARACTER VARYING(22),
    mgr_email CHARACTER VARYING(500),
    ma_website CHARACTER VARYING(150),
    easement_holder CHARACTER VARYING(100),
    nested_ac_adj double precision,
    non_nat_ac BIGINT,
    submerged_gis_ac double precision,
    dig_boundary_src CHARACTER VARYING(254),
    rec_create_date DATE,
    rec_create_user CHARACTER VARYING(30),
    rec_last_mod_date DATE,
    rec_last_mod_user CHARACTER VARYING(30)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.ma_flext2(
    ma_flext2_id BIGINT NOT NULL,
    ma_id BIGINT NOT NULL,
    easement_holder CHARACTER VARYING(100)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.ma_flext3_pad_own_name(
    owner_name CHARACTER VARYING(65),
    own_name CHARACTER VARYING(50),
    code CHARACTER VARYING(5),
    ag_nm_cd CHARACTER VARYING(5),
    ag_ty_cd CHARACTER VARYING(5)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.ma_flext4_pad_own_type(
    ma_id CHARACTER VARYING(4),
    maname CHARACTER VARYING(82),
    own_type CHARACTER VARYING(35),
    own_code CHARACTER VARYING(4)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.ma_flext5_pad_access_des(
    ma_id CHARACTER VARYING(4),
    managed_area_name CHARACTER VARYING(82),
    pad_access CHARACTER VARYING(10),
    pad_access_code CHARACTER VARYING(2),
    unit_type CHARACTER VARYING(69),
    refined_designation CHARACTER VARYING(48),
    des_code CHARACTER VARYING(3)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.previous_pop_size(
    previous_pop_size_id BIGINT NOT NULL,
    eo_id BIGINT NOT NULL,
    year_of_estimate BIGINT,
    min_pop_size BIGINT,
    max_pop_size BIGINT,
    d_estimate_precision_id BIGINT,
    display_order BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.site_flext1(
    site_flext1_id BIGINT NOT NULL,
    site_id BIGINT NOT NULL,
    dig_com CHARACTER VARYING(300),
    d_flext_priority_id BIGINT,
    short_name CHARACTER VARYING(60),
    florida_forever_site CHARACTER(1) DEFAULT 'N',
    site_short_name CHARACTER VARYING(60),
    project_code BIGINT,
    website CHARACTER VARYING(150),
    rec_create_date DATE,
    rec_create_user CHARACTER VARYING(30),
    rec_last_mod_date DATE,
    rec_last_mod_user CHARACTER VARYING(30),
    d_flext_ff_category_id BIGINT,
    ff_rank BIGINT
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.source_feature_flext1(
    source_feature_flext1_id BIGINT NOT NULL,
    source_feature_id BIGINT NOT NULL,
    d_source_feature_rank_id BIGINT DEFAULT (1)::BIGINT,
    description CHARACTER VARYING(4000),
    directions CHARACTER VARYING(4000),
    comments CHARACTER VARYING(4000),
    rec_create_date DATE,
    rec_create_user CHARACTER VARYING(30),
    rec_last_mod_date DATE,
    rec_last_mod_user CHARACTER VARYING(30)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.source_feature_flext2(
    source_feature_flext2_id BIGINT NOT NULL,
    source_feature_id BIGINT NOT NULL,
    reference_code CHARACTER(12) NOT NULL,
    display_order BIGINT,
    rec_create_date DATE,
    rec_create_user CHARACTER VARYING(30),
    rec_last_mod_date DATE,
    rec_last_mod_user CHARACTER VARYING(30)
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.source_feature_flext3(
    source_feature_id BIGINT,
    hectares double precision
)
        WITH (
        OIDS=FALSE
        );

CREATE TABLE ext.taxon_sub_flext1(
    taxon_sub_flext1_id BIGINT NOT NULL,
    element_subnational_id BIGINT NOT NULL,
    old_usesa CHARACTER VARYING(250),
    old_usesa_com CHARACTER VARYING(400),
    datasens CHARACTER VARYING(1),
    s_lowercase_common_name CHARACTER VARYING(100),
    fld_guide_species CHARACTER VARYING(1),
    sim_and_related_spp CHARACTER VARYING(4000),
    fld_guide_refs CHARACTER VARYING(4000),
    range_wide_distrib CHARACTER VARYING(2000),
    fl_wetland_status CHARACTER VARYING(20),
    field_descr_header CHARACTER VARYING(100),
    similar_spp_header CHARACTER VARYING(100),
    related_rare_spp_header CHARACTER VARYING(100),
    cons_status CHARACTER VARYING(4000),
    rec_create_date DATE,
    rec_create_user CHARACTER VARYING(30),
    rec_last_mod_date DATE,
    rec_last_mod_user CHARACTER VARYING(30),
    photo1 CHARACTER VARYING(250),
    photo2 CHARACTER VARYING(250),
    photo3 CHARACTER VARYING(250),
    photo4 CHARACTER VARYING(250),
    caption1 CHARACTER VARYING(250),
    caption2 CHARACTER VARYING(250),
    caption3 CHARACTER VARYING(250),
    caption4 CHARACTER VARYING(250),
    field_guide_version_date CHARACTER VARYING(50),
    fwc_search_image CHARACTER VARYING(1000),
    drawing1 CHARACTER VARYING(250),
    drawing1_caption CHARACTER VARYING(250),
    former_name CHARACTER VARYING(100) DEFAULT NULL,
    photo5 CHARACTER VARYING(250),
    photo6 CHARACTER VARYING(250),
    caption5 CHARACTER VARYING(250),
    caption6 CHARACTER VARYING(250)
)
        WITH (
        OIDS=FALSE
        );


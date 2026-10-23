-- ------------ Write CREATE-CONSTRAINT-stage scripts -----------

ALTER TABLE ext.animal_cas_flext1
ADD CONSTRAINT animal_cas_flext1_ak1 UNIQUE (element_subnational_id);

ALTER TABLE ext.animal_cas_flext1
ADD CONSTRAINT animal_cas_flext1_pk PRIMARY KEY (animal_cas_flext1_id);

ALTER TABLE ext.community_sub_flext1
ADD CONSTRAINT community_sub_flext1_ak1 UNIQUE (element_subnational_id);

ALTER TABLE ext.community_sub_flext1
ADD CONSTRAINT community_sub_flext1_pk PRIMARY KEY (community_sub_flext1_id);

ALTER TABLE ext.d_community_variant
ADD CONSTRAINT d_community_variant_pk PRIMARY KEY (d_community_variant_id);

ALTER TABLE ext.d_estimate_precision
ADD CONSTRAINT d_estimate_precision_ak1 UNIQUE (estimate_precision_desc);

ALTER TABLE ext.d_estimate_precision
ADD CONSTRAINT d_estimate_precision_pk PRIMARY KEY (d_estimate_precision_id);

ALTER TABLE ext.d_flext_ff_category
ADD CONSTRAINT d_flext_ff_category_pk PRIMARY KEY (d_flext_ff_category_id);

ALTER TABLE ext.d_flext_priority
ADD CONSTRAINT d_flext_priority_ak1 UNIQUE (priority_code);

ALTER TABLE ext.d_flext_priority
ADD CONSTRAINT d_flext_priority_pk PRIMARY KEY (d_flext_priority_id);

ALTER TABLE ext.d_prev_est_available
ADD CONSTRAINT d_prev_est_available_ak1 UNIQUE (prev_est_available_desc);

ALTER TABLE ext.d_prev_est_available
ADD CONSTRAINT d_prev_est_available_pk PRIMARY KEY (d_prev_est_available_id);

ALTER TABLE ext.d_source_feature_rank
ADD CONSTRAINT d_source_feature_rank_ak1 UNIQUE (source_feature_rank_cd);

ALTER TABLE ext.d_source_feature_rank
ADD CONSTRAINT d_source_feature_rank_ak2 UNIQUE (source_feature_rank_display);

ALTER TABLE ext.d_source_feature_rank
ADD CONSTRAINT d_source_feature_rank_pk PRIMARY KEY (d_source_feature_rank_id);

ALTER TABLE ext.d_version_funding
ADD CONSTRAINT d_version_funding_ak1 UNIQUE (version_funding_code);

ALTER TABLE ext.d_version_funding
ADD CONSTRAINT d_version_funding_ak2 UNIQUE (display_value);

ALTER TABLE ext.d_version_funding
ADD CONSTRAINT d_version_funding_pk PRIMARY KEY (d_version_funding_id);

ALTER TABLE ext.eo_ext_misc_ind
ADD CONSTRAINT eo_ext_misc_ind_ak1 UNIQUE (eo_id);

ALTER TABLE ext.eo_ext_misc_ind
ADD CONSTRAINT eo_ext_misc_ind_pk PRIMARY KEY (eo_ext_misc_ind_id);

ALTER TABLE ext.eo_flext1
ADD CONSTRAINT eo_flext1_ak1 UNIQUE (eo_id);

ALTER TABLE ext.eo_flext1
ADD CONSTRAINT eo_flext1_pk PRIMARY KEY (eo_flext1_id);

ALTER TABLE ext.eo_flext2
ADD CONSTRAINT eo_flext2_ak1 UNIQUE (eo_id);

ALTER TABLE ext.eo_flext2
ADD CONSTRAINT eo_flext2_pk PRIMARY KEY (eo_flext2_id);

ALTER TABLE ext.ma_flext1
ADD CONSTRAINT ma_flext1_ak1 UNIQUE (ma_id);

ALTER TABLE ext.ma_flext1
ADD CONSTRAINT ma_flext1_pk PRIMARY KEY (ma_flext1_id);

ALTER TABLE ext.ma_flext2
ADD CONSTRAINT ma_flext2_pk PRIMARY KEY (ma_flext2_id);

ALTER TABLE ext.previous_pop_size
ADD CONSTRAINT previous_pop_size_ak1 UNIQUE (eo_id, year_of_estimate);

ALTER TABLE ext.previous_pop_size
ADD CONSTRAINT previous_pop_size_pk PRIMARY KEY (previous_pop_size_id);

ALTER TABLE ext.site_flext1
ADD CONSTRAINT site_flext1_ak1 UNIQUE (site_id);

ALTER TABLE ext.site_flext1
ADD CONSTRAINT site_flext1_pk PRIMARY KEY (site_flext1_id);

ALTER TABLE ext.source_feature_flext1
ADD CONSTRAINT source_feature_flext1_ak1 UNIQUE (source_feature_id);

ALTER TABLE ext.source_feature_flext1
ADD CONSTRAINT source_feature_flext1_pk PRIMARY KEY (source_feature_flext1_id);

ALTER TABLE ext.source_feature_flext2
ADD CONSTRAINT source_feature_flext2_ak1 UNIQUE (source_feature_id, reference_code);

ALTER TABLE ext.source_feature_flext2
ADD CONSTRAINT source_feature_flext2_pk PRIMARY KEY (source_feature_flext2_id);

ALTER TABLE ext.taxon_sub_flext1
ADD CONSTRAINT taxon_sub_flext1_ak1 UNIQUE (element_subnational_id);

ALTER TABLE ext.taxon_sub_flext1
ADD CONSTRAINT taxon_sub_flext1_pk PRIMARY KEY (taxon_sub_flext1_id);


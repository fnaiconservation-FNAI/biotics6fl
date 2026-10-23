-- ------------ Write CREATE-INDEX-stage scripts -----------

CREATE INDEX eo_ext_misc_ind_if2
ON ext.eo_ext_misc_ind
USING BTREE (d_prev_est_available_id ASC);

CREATE INDEX eo_flext1_idx1
ON ext.eo_flext1
USING BTREE (d_community_variant_id ASC);

CREATE INDEX eo_flext1_idx2
ON ext.eo_flext1
USING BTREE (d_version_funding_id ASC);

CREATE INDEX ma_flext2_idx1
ON ext.ma_flext2
USING BTREE (ma_id ASC);

CREATE INDEX previous_pop_size_if1
ON ext.previous_pop_size
USING BTREE (eo_id ASC);

CREATE INDEX site_flext1_idx1
ON ext.site_flext1
USING BTREE (d_flext_priority_id ASC);

CREATE INDEX source_feature_flext1_idx1
ON ext.source_feature_flext1
USING BTREE (d_source_feature_rank_id ASC);

CREATE INDEX source_feature_flext2_idx1
ON ext.source_feature_flext2
USING BTREE (source_feature_id ASC);


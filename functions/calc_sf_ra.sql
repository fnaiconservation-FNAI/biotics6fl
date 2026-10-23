CREATE OR REPLACE FUNCTION ext.calc_sf_ra(IN sf_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    rvalue CHARACTER VARYING(1);
BEGIN
    /* Automated RA sql */
    SELECT
        /* Key 1: Loc Uncertainty is negligible (1), RA = Very High (1) */
        CASE
            WHEN dlut.d_loc_uncertainty_type_id = 1 THEN 1
        /*
        Key 2: Loc Uncertainty is Areal-Estimated, Areal-Delimited, or Linear (2, 3, 5)
        AND Procedural Area <= 1 ha, RA = High (2)
        */
            WHEN (dlut.d_loc_uncertainty_type_id IN (2, 3, 5) AND (sf_procedural_area.sf_hectares <= 1 OR
            /* following lines make an exception for BCD seconds precisions EOs */
            /* which actually end up being 1.14ha */
            (dlut.d_loc_uncertainty_type_id = 5 AND sf.loc_uncertainty_distance = 60.4 AND feature_code = 1007))) THEN 2
        /*
        Key 4: Loc Uncertainty is Areal-Estimated, Areal-Delimited, or Linear (2, 3, 5)
        AND Conc_feature_type is Point (1)
        AND Procedural Area > 1 HAs
        AND Procedural Area <= 50 HAs, RA = Medium (3)
        */
            WHEN (dlut.d_loc_uncertainty_type_id IN (2, 3, 5) AND dcft.d_conc_feature_type_id = 1 AND sf_procedural_area.sf_hectares <= 50) THEN 3
        /*
        Key 5: Loc Uncertainty is Areal-Estimated, Areal-Delimited, or Linear (2, 3, 5)
        AND Conc_feature_type is Point (1)
        AND Procedural Area > 50 HAs
        AND Procedural Area <= 2500 HAs, RA = Low (4)
        */
            WHEN (dlut.d_loc_uncertainty_type_id IN (2, 3, 5) AND dcft.d_conc_feature_type_id = 1 AND sf_procedural_area.sf_hectares > 50 AND sf_procedural_area.sf_hectares <= 2500) THEN 4
        /*
        Key 5: Loc Uncertainty is Areal-Estimated, Areal-Delimited, or Linear (2, 3, 5)
        AND Conc_feature_type is Point (1)
        AND Procedural Area > 50 HAs
        AND Procedural Area > 2500 HAs, RA = Very Low (6)
        */
            WHEN (dlut.d_loc_uncertainty_type_id IN (2, 3, 5) AND dcft.d_conc_feature_type_id = 1 AND sf_procedural_area.sf_hectares > 2500) THEN 6
        /* VERY IMPORTANT - to allow averaging to EO level this must be changed from 6 to 5 */
        
        /*
        Key 6: Loc Uncertainty is Areal-Estimated, Areal-Delimited, or Linear (2, 3, 5)
        AND Procedural Area > 1 ha
        AND Conc_feature_type is Line or Poly (<>1)
        AND    More than 80% of the Procedural Feature is comprised of the observed area
            OR Procedural Area <= 1 HA, RA = High (2)
        */
            WHEN (dlut.d_loc_uncertainty_type_id IN (2, 3, 5) AND
            /* don't need line below because proc area for all sf now imported */
            /* and dcft.d_conc_feature_type_id = 3 -- Polygon, use area */
            sf_procedural_area.sf_hectares IS NOT NULL AND sf_procedural_area.sf_hectares > 1 AND (sf_procedural_area.sf_observed_area_has IS NOT NULL AND (sf_procedural_area.sf_observed_area_has / sf_procedural_area.sf_hectares) > .8)) THEN 2
        /*
        requires observed and procedural length in meters before it will work
        when (dlut.d_loc_uncertainty_type_id in (2,3,5)
          and dcft.d_conc_feature_type_id = 2 -- Line, use area UNTESTED!!!!!!!!!
          ...
              ) then 2
        */
        /*
        Key 7: Loc Uncertainty is Areal-Estimated, Areal-Delimited, or Linear (2, 3, 5)
        AND Procedural Area > 1 ha
        AND Conc_feature_type is Line or Poly (<>1)
        AND 80% or less of the Procedural Feature is comprised of the observed area
        AND 20% or more of the Procedural Feature is comprised of the observed area
          RA = Medium (3)
        */
            WHEN (dlut.d_loc_uncertainty_type_id IN (2, 3, 5) AND
            /* don't need line below because proc area for all sf now imported */
            /* and dcft.d_conc_feature_type_id = 3 -- Polygon, use area */
            sf_procedural_area.sf_hectares IS NOT NULL AND sf_procedural_area.sf_hectares > 1 AND (sf_procedural_area.sf_observed_area_has IS NOT NULL AND (sf_procedural_area.sf_observed_area_has / sf_procedural_area.sf_hectares) <= .8 AND (sf_procedural_area.sf_observed_area_has / sf_procedural_area.sf_hectares) >= .2)) THEN 3
        /*
        requires observed and procedural length in meters before it will work
        when (dlut.d_loc_uncertainty_type_id in (2,3,5)
          and dcft.d_conc_feature_type_id = 2 -- Line, use area  UNTESTED!!!!!!!!
          ...
              ) then 3
        */
        /*
        Key 8: Loc Uncertainty is Areal-Estimated, Areal-Delimited, or Linear (2, 3, 5)
        AND Procedural Area > 1 ha
        AND Conc_feature_type is Line or Poly (<>1)
        AND   Less than 20% of the Procedural Feature is comprised of the observed area
          OR  Observed Area is unknown
        AND Procedural Area 50 hectares or less
          RA = Medium (3)
        */
            WHEN (dlut.d_loc_uncertainty_type_id IN (2, 3, 5) AND
            /* don't need line below because proc area for all sf now imported */
            /* and dcft.d_conc_feature_type_id = 3 -- Polygon, use area */
            sf_procedural_area.sf_hectares IS NOT NULL AND sf_procedural_area.sf_hectares > 1 AND (sf_procedural_area.sf_observed_area_has IS NULL OR (sf_procedural_area.sf_observed_area_has / sf_procedural_area.sf_hectares) < .2) AND sf_procedural_area.sf_hectares <= 50) THEN 3
        /*
        requires observed and procedural length in meters before it will work
        when (dlut.d_loc_uncertainty_type_id in (2,3,5)
          and dcft.d_conc_feature_type_id = 2 -- Line, use area  UNTESTED!!!!!!!!
          ...
              ) then 3
        */
        /*
        Key 9 first: Loc Uncertainty is Areal-Estimated, Areal-Delimited, or Linear (2, 3, 5)
        AND Procedural Area > 1 ha
        AND Conc_feature_type is Line or Poly (<>1)
        AND   Less than 20% of the Procedural Feature is comprised of the observed area
          OR  Observed Area is unknown
        AND Procedural Area is more than 50 hectares
        AND Procedural Area is 2500 hectares or less
          RA = Low (4)
        */
            WHEN (dlut.d_loc_uncertainty_type_id IN (2, 3, 5) AND
            /* don't need line below because proc area for all sf now imported */
            /* and dcft.d_conc_feature_type_id = 3 -- Polygon, use area */
            sf_procedural_area.sf_hectares IS NOT NULL AND
            /* and sf_procedural_area.SF_HECTARES > 1 covered below */
            (sf_procedural_area.sf_observed_area_has IS NULL OR (sf_procedural_area.sf_observed_area_has / sf_procedural_area.sf_hectares) < .2) AND sf_procedural_area.sf_hectares > 50 AND sf_procedural_area.sf_hectares <= 2500) THEN 4
        /*
        requires observed and procedural length in meters before it will work
        when (dlut.d_loc_uncertainty_type_id in (2,3,5)
          and dcft.d_conc_feature_type_id = 2 -- Line, use area  UNTESTED!!!!!!!!
          ...
              ) then 4
        */
        /*
        Key 9 second: Loc Uncertainty is Areal-Estimated, Areal-Delimited, or Linear (2, 3, 5)
        AND Procedural Area > 1 ha
        AND Conc_feature_type is Line or Poly (<>1)
        AND   Less than 20% of the Procedural Feature is comprised of the observed area
          OR  Observed Area is unknown
        AND Procedural Area is more than 2500 hectares
          RA = Very Low (6)
        */
            WHEN (dlut.d_loc_uncertainty_type_id IN (2, 3, 5) AND
            /* don't need line below because proc area for all sf now imported */
            /* and dcft.d_conc_feature_type_id = 3 -- Polygon, use area */
            sf_procedural_area.sf_hectares IS NOT NULL AND
            /* and sf_procedural_area.SF_HECTARES > 1 covered below */
            (sf_procedural_area.sf_observed_area_has IS NULL OR (sf_procedural_area.sf_observed_area_has / sf_procedural_area.sf_hectares) < .2) AND sf_procedural_area.sf_hectares > 2500) THEN 6
        /* VERY IMPORTANT - to allow averaging to the EO level this must be changed from 6 to 5 */
        
        /*
        requires observed and procedural length in meters before it will work
        when (dlut.d_loc_uncertainty_type_id in (2,3,5)
          and dcft.d_conc_feature_type_id = 2 -- Line, use area  UNTESTED!!!!!!!!
          ...
              ) then 6
        */
            ELSE NULL
        END
        INTO STRICT rvalue
        FROM core.source_feature AS sf
        JOIN domain.d_loc_uncertainty_type AS dlut
            ON sf.d_loc_uncertainty_type_id = dlut.d_loc_uncertainty_type_id
        LEFT OUTER JOIN domain.d_conc_feature_type AS dcft
            ON sf.d_conc_feature_type_id = dcft.d_conc_feature_type_id
        LEFT OUTER JOIN domain.d_est_rep_accuracy AS ra
            ON sf.d_est_rep_accuracy_id = ra.d_est_rep_accuracy_id
        LEFT OUTER JOIN (SELECT
            source_feature_id, obs_feature_area_unit_id AS sf_observed_area_unit_id, obs_feature_area AS sf_observed_area, sf_observed_area_has, sf_observed_length_m, current_sf_ra, sf_hectares, feature_code
            FROM (SELECT
                sf.source_feature_id, sf.obs_feature_area_unit_id, sf.obs_feature_area, sf.obs_feature_length_unit_id, sf.obs_feature_length, sf.d_est_rep_accuracy_id AS current_sf_ra,
                /* hectares */
                CASE
                    WHEN sf.obs_feature_area_unit_id = 1 THEN sf.obs_feature_area
                /* acres   1 acres = 0.404685642 hectares */
                    WHEN (sf.obs_feature_area_unit_id = 2 AND sf.obs_feature_area IS NOT NULL) THEN (sf.obs_feature_area * 0.404685642)
                /* square meters   1 sq meter = 0.0001 hectares */
                    WHEN (sf.obs_feature_area_unit_id = 3 AND sf.obs_feature_area IS NOT NULL) THEN (sf.obs_feature_area * 0.0001)
                /* square feet  1 sq foot = 9.290304 × 10-6 hectares */
                    WHEN (sf.obs_feature_area_unit_id = 4 AND sf.obs_feature_area IS NOT NULL) THEN (sf.obs_feature_area * 0.000009290304)
                /* square kilometers   1 sq kilometer = 100 hectares */
                    WHEN (sf.obs_feature_area_unit_id = 5 AND sf.obs_feature_area IS NOT NULL) THEN (sf.obs_feature_area * 100)
                /* square miles  1 sq mile = 258.998811 hectares */
                    WHEN (sf.obs_feature_area_unit_id = 6 AND sf.obs_feature_area IS NOT NULL) THEN (sf.obs_feature_area * 258.998811)
                    ELSE NULL
                END AS sf_observed_area_has,
                /* meters */
                CASE
                    WHEN sf.obs_feature_length_unit_id = 7 THEN sf.obs_feature_length
                /* feet  1 foot = 0.3048 meters */
                    WHEN sf.obs_feature_length_unit_id = 8 THEN (sf.obs_feature_length * 0.3048)
                /* miles  1 mile = 1609.344 meters */
                    WHEN sf.obs_feature_length_unit_id = 8 THEN (sf.obs_feature_length * 1609.344)
                /* kilometer  1 kilometer = 1000 meters */
                    WHEN sf.obs_feature_length_unit_id = 8 THEN (sf.obs_feature_length * 1000)
                    ELSE NULL
                END AS sf_observed_length_m, sf.d_loc_uncertainty_type_id, sf.d_conc_feature_type_id, sf_shape.feature_code, sf_ha.hect AS sf_hectares
                FROM core.source_feature AS sf
                LEFT OUTER JOIN core.shape AS sf_shape
                    ON sf.shape_id = sf_shape.shape_id
                LEFT OUTER JOIN (SELECT
                    source_feature_id, 63.61725 / 10000::NUMERIC AS hect
                    /* previously wrong at 1000sqm per hectare */
                    FROM core.source_feature_pt
                UNION
                SELECT
                    sf.source_feature_id, oracle.to_number((attribute_value::NUMERIC * 9)::NUMERIC / 10000::NUMERIC) AS hect
                    /* previously wrong at 1000sqm per hectare */
                    FROM core.source_feature_line
                    LEFT OUTER JOIN core.source_feature AS sf
                        ON core.source_feature_line.source_feature_id = sf.source_feature_id
                    LEFT OUTER JOIN core.spatial_attribute AS sa
                        ON sf.shape_id = sa.feature_id
                    WHERE attribute_name = 'Length'
                UNION
                SELECT
                    source_feature_id, ST_Area(core.source_feature_poly.shape) AS hect
                    FROM core.source_feature_poly) AS sf_ha
                    ON sf.source_feature_id = sf_ha.source_feature_id) AS var_sbq) AS sf_procedural_area
            ON sf.source_feature_id = sf_procedural_area.source_feature_id
        WHERE sf.source_feature_id = sf_id_arg;
    /* and sf.d_loc_uncertainty_type_id = dlut.d_loc_uncertainty_type_id */
    /* and sf.d_conc_feature_type_id = dcft.d_conc_feature_type_id (+) */
    /* and sf.d_est_rep_accuracy_id = ra.d_est_rep_accuracy_id (+) */
    /* \* DO NOT update SF records that have already been assigned an RA * / */
    /* --and ra.est_rep_accuracy_desc is null */
    /* and sf.source_feature_id = sf_procedural_area.source_feature_id (+); */
    RETURN (rvalue);
END;
$BODY$
LANGUAGE  plpgsql;


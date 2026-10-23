CREATE OR REPLACE  VIEW ext.fnai_site_ffbot_view (site_id, sitecode_bcd, sitename, project_name, short_name, project_cd, short_site, ff_cat, ff_rank, county, prisec_acres, gis_acres, boundjust, protcom, macom1, macom2, site_relations, sitedesc1, sitedesc2, sitecom1, sitecom2, dig_com, fdep_url, feature_id) AS
SELECT
    cs.conservation_site_id AS site_id, cs.sitecode_bcd AS sitecode_bcd, cs.site_name AS sitename,
    /* project_name is a truncated version of sitename (all characters to the right of BOT Project are dropped) */
    oracle.substr(cs.site_name, 1, oracle.INSTR(cs.site_name, 'BOT Pr') + 10) AS project_name, sf1.short_name AS short_name, COALESCE(sf1.project_code, 99999) AS project_cd, COALESCE(sf1.site_short_name, 'ZZ') AS short_site, dcat.category_desc AS ff_cat, sf1.ff_rank AS ff_rank, COALESCE((SELECT
        STRING_AGG(oracle.substr(domain.d_county.county_cd, 3, 4), ','::TEXT ORDER BY domain.d_county.county_cd) AS f
        FROM domain.d_county
        JOIN core.site_county
            ON domain.d_county.d_county_id = core.site_county.d_county_id
        WHERE core.site_county.conservation_site_id = cs.conservation_site_id
        GROUP BY core.site_county.conservation_site_id), 'ZZ') AS county, cs.primary_secondary_area_acres AS prisec_acres, COALESCE((SELECT
        ROUND(spat_att.attribute_value::NUMERIC, 2)
        FROM core.conservation_site
        LEFT OUTER JOIN core.spatial_attribute AS spat_att
            ON core.conservation_site.shape_id = spat_att.feature_id
        WHERE spat_att.attribute_name = 'Acreage' AND core.conservation_site.conservation_site_id = cs.conservation_site_id), - 99999) AS gis_acres, COALESCE(oracle.substr(cs.boundary_justification, 1, 254), 'ZZ') AS boundjust, COALESCE(oracle.substr(lob_loc => cs.protection_com, amount => 254, "offset" => 1), 'ZZ') AS protcom, COALESCE(oracle.substr(cs.managed_area_relations, 1, 254), 'ZZ') AS macom1, COALESCE(oracle.substr(cs.managed_area_relations, 255, 508), 'ZZ') AS macom2, COALESCE(cs.site_relations, 'ZZ') AS site_relations, COALESCE(oracle.substr(lob_loc => cs.site_desc, amount => 254, "offset" => 1), 'ZZ') AS sitedesc1, COALESCE(oracle.substr(lob_loc => cs.site_desc, amount => 254, "offset" => 255), 'ZZ') AS sitedesc2, COALESCE(oracle.substr(cs.site_com, 1, 254), 'ZZ') AS sitecom1, COALESCE(oracle.substr(cs.site_com, 255, 508), 'ZZ') AS sitecom2, COALESCE(sf1.dig_com, 'ZZ') AS dig_com, COALESCE(sf1.website, 'ZZ') AS fdep_url, cs.shape_id AS feature_id
    /* From conservation_site cs, site_flext1 sf1, d_flext_ff_category dcat */
    /* where cs.conservation_site_id = sf1.site_id(+) */
    /* and sf1.d_flext_ff_category_id = dcat.d_flext_ff_category_id */
    FROM core.conservation_site AS cs
    LEFT OUTER JOIN ext.site_flext1 AS sf1
        ON sf1.site_id = cs.conservation_site_id
    INNER JOIN ext.d_flext_ff_category AS dcat
        ON dcat.d_flext_ff_category_id = sf1.d_flext_ff_category_id AND sf1.florida_forever_site = 'Y'
/* and rownum < 25 */
;


CREATE OR REPLACE  VIEW ext.fnai_el_rank_rev_per_yr_pbi (elgroup, year, s_ranks_reviewed, pct_els_yr) AS
SELECT
    ext.elgroup_political_name(est.element_subnational_id) AS elgroup, oracle.substr(oracle.to_char(est.s_rank_review_date, 'YYYY-MM-DD'), 1, 4) AS year, COUNT(est.element_subnational_id) AS s_ranks_reviewed,
    /* , sum(count(EST.ELEMENT_SUBNATIONAL_ID)) over() total_els */
    ROUND(100 * (COUNT(est.element_subnational_id) / SUM(COUNT(est.element_subnational_id)) OVER ()), 3) AS pct_els_yr
    FROM core.element_subnational AS est
    WHERE est.d_eo_track_status_id = 1 AND s_rank_review_date IS NOT NULL
    GROUP BY ext.elgroup_political_name(est.element_subnational_id), oracle.substr(oracle.to_char(est.s_rank_review_date, 'YYYY-MM-DD'), 1, 4)
    ORDER BY ext.elgroup_political_name(est.element_subnational_id), oracle.substr(oracle.to_char(est.s_rank_review_date, 'YYYY-MM-DD'), 1, 4);


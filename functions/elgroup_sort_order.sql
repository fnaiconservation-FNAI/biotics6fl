CREATE OR REPLACE FUNCTION ext.elgroup_sort_order(IN est_id_arg BIGINT)
RETURNS BIGINT
AS
$BODY$
DECLARE
    sort_order BIGINT;
    fam_code CHARACTER VARYING(20);
    order_code CHARACTER VARYING(20);
    order_hcun CHARACTER VARYING(20);
    cls_hcun CHARACTER VARYING(20);
    elcode CHARACTER VARYING(10);
BEGIN
    SELECT
        family.concatenated_cd, ordr.concatenated_cd, ordr.higher_class_unit_name, cls.higher_class_unit_name, egt.elcode_bcd
        INTO STRICT fam_code, order_code, order_hcun, cls_hcun, elcode
        FROM core.element_subnational AS est, core.element_global AS egt, core.element_national AS ent, core.higher_class_unit AS ordr
        LEFT OUTER JOIN core.higher_class_unit AS cls
            ON (cls.higher_class_unit_id = ordr.parent_unit_id), core.higher_class_unit AS genus
        LEFT OUTER JOIN core.higher_class_unit AS family
            ON (family.higher_class_unit_id = genus.parent_unit_id)
        WHERE ent.element_global_id = egt.element_global_id AND est.element_national_id = ent.element_national_id AND est.element_subnational_id = est_id_arg;
    sort_order := 900;
    /* Order_code may NOT always be an order (i.e. it may be a class or some other level) */

    IF order_code LIKE 'P%' THEN
        sort_order := 100;
    END IF;

    IF elcode LIKE 'N%' THEN
        sort_order := 100;
    END IF;
    /* if cls_hcun = 'Lecanoromycetes' then sort_order := 100; end if; */

    IF order_code = 'IPOR' THEN
        sort_order := 200;
    END IF;

    IF order_code LIKE 'ICNI%' THEN
        sort_order := 210;
    END IF;

    IF order_code LIKE 'IPLT%' THEN
        sort_order := 215;
    END IF;

    IF order_code LIKE 'IMBIV%' THEN
        sort_order := 220;
    END IF;

    IF order_code LIKE 'IMGAS%' THEN
        sort_order := 230;
    END IF;

    IF order_code LIKE 'IMCEP%' THEN
        sort_order := 232;
    END IF;

    IF order_code LIKE 'IANNOLI%' THEN
        sort_order := 235;
    END IF;

    IF order_hcun = 'Amblypygi' THEN
        sort_order := 240;
    END IF;

    IF order_hcun = 'Araneae' THEN
        sort_order := 242;
    END IF;

    IF order_code = 'ICHMER' THEN
        sort_order := 244;
    END IF;

    IF order_code LIKE 'IDIP%' THEN
        sort_order := 246;
    END IF;

    IF order_code LIKE 'ICRBRPSF%' THEN
        sort_order := 253;
    END IF;

    IF fam_code LIKE 'ICRBRPSC%' THEN
        sort_order := 254;
    END IF;

    IF order_code LIKE 'ICROST%' THEN
        sort_order := 256;
    END IF;

    IF order_code LIKE 'ICRMAXCOP%' THEN
        sort_order := 258;
    END IF;

    IF order_code = 'ICRMALAM' THEN
        sort_order := 260;
    END IF;

    IF order_code = 'ICRMALIS' THEN
        sort_order := 270;
    END IF;

    IF order_code = 'ICRMALDE' THEN
        sort_order := 280;
    END IF;

    IF order_code = 'IHEXCL' THEN
        sort_order := 285;
    END IF;

    IF order_code = 'IIEPH' THEN
        sort_order := 290;
    END IF;

    IF order_code = 'IIOD' THEN
        sort_order := 300;
    END IF;

    IF order_code = 'IIOR' THEN
        sort_order := 310;
    END IF;

    IF order_code = 'IIPLE' THEN
        sort_order := 315;
    END IF;

    IF order_code LIKE 'IIHEM%' THEN
        sort_order := 317;
    END IF;

    IF order_code = 'IICOL' THEN
        sort_order := 320;
    END IF;

    IF order_code = 'IIMAL' THEN
        sort_order := 322;
    END IF;

    IF order_code = 'IIPSC' THEN
        sort_order := 323;
    END IF;

    IF order_code = 'IIMEC' THEN
        sort_order := 325;
    END IF;

    IF order_code = 'IITRI' THEN
        sort_order := 330;
    END IF;

    IF order_code = 'IILE' THEN
        sort_order := 340;
    END IF;

    IF order_code = 'IIDI' THEN
        sort_order := 350;
    END IF;

    IF order_code = 'IIHYM' THEN
        sort_order := 360;
    END IF;

    IF order_code LIKE 'IECN%' THEN
        sort_order := 380;
    END IF;

    IF order_code = 'VF' THEN
        sort_order := 510;
    END IF;

    IF order_code = 'VFGOBI' THEN
        sort_order := 510;
    END IF;

    IF order_code = 'VA' THEN
        sort_order := 520;
    END IF;

    IF order_code IN ('VR', 'VT', 'VC') THEN
        sort_order := 530;
    END IF;

    IF order_code = 'VB' THEN
        sort_order := 540;
    END IF;

    IF order_code = 'VM' THEN
        sort_order := 550;
    END IF;

    IF elcode LIKE 'C%' THEN
        sort_order := 800;
    END IF;
    RETURN (sort_order);
END;
$BODY$
LANGUAGE  plpgsql;


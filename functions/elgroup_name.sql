CREATE OR REPLACE FUNCTION ext.elgroup_name(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    name CHARACTER VARYING(40);
    fam_code CHARACTER VARYING(20);
    order_code CHARACTER VARYING(20);
    order_hcun CHARACTER VARYING(20);
    cls_hcun CHARACTER VARYING(20);
    elcode CHARACTER VARYING(10);
BEGIN
    SELECT
        family.concatenated_cd, ordr.concatenated_cd, ordr.higher_class_unit_name, cls.higher_class_unit_name, egt.elcode_bcd
        INTO STRICT fam_code, order_code, order_hcun, cls_hcun, elcode
        FROM core.element_subnational AS est
        JOIN core.element_national AS ent
            ON ent.element_national_id = est.element_national_id
        JOIN core.element_global AS egt
            ON egt.element_global_id = ent.element_global_id
        LEFT OUTER JOIN core.higher_class_unit AS genus
            ON genus.higher_class_unit_id = egt.higher_class_unit_id
        LEFT OUTER JOIN core.higher_class_unit AS family
            ON family.higher_class_unit_id = genus.parent_unit_id
        LEFT OUTER JOIN core.higher_class_unit AS ordr
            ON ordr.higher_class_unit_id = family.parent_unit_id
        LEFT OUTER JOIN core.higher_class_unit AS cls
            ON cls.higher_class_unit_id = ordr.parent_unit_id
        WHERE est.element_subnational_id = est_id_arg;
    /* FROM element_subnational est, */
    /* element_global egt, */
    /* element_national ent, */
    /* higher_class_unit genus, */
    /* higher_class_unit family, */
    /* higher_class_unit ordr, */
    /* higher_class_unit cls */
    /* WHERE cls.higher_class_unit_id(+) = ordr.parent_unit_id */
    /* and ordr.higher_class_unit_id(+) = family.parent_unit_id */
    /* and family.higher_class_unit_id(+) = genus.parent_unit_id */
    /* and genus.higher_class_unit_id(+) = egt.higher_class_unit_id */
    /* and ent.element_global_id = egt.element_global_id */
    /* and est.element_national_id = ent.element_national_id */
    /* and est.element_subnational_id = est_id_arg; */
    name := 'Other Elements';
    /* Order_code may NOT always be an order (i.e. it may be a class or some other level) */

    IF order_code = 'VF' THEN
        name := 'Fishes';
    END IF;

    IF order_code = 'VFGOBI' THEN
        name := 'Fishes';
    END IF;

    IF order_code = 'VA' THEN
        name := 'Amphibians';
    END IF;

    IF order_code IN ('VR', 'VT', 'VC') THEN
        name := 'Reptiles';
    END IF;

    IF order_code = 'VB' THEN
        name := 'Birds';
    END IF;

    IF order_code = 'VM' THEN
        name := 'Mammals';
    END IF;

    IF order_code = 'IPOR' THEN
        name := 'Sponges';
    END IF;

    IF order_code = 'ICHMER' THEN
        name := 'Horseshoe Crabs';
    END IF;

    IF order_code LIKE 'ICNI%' THEN
        name := 'Corals and Allies';
    END IF;

    IF order_code LIKE 'IPLT%' THEN
        name := 'Flatworms';
    END IF;

    IF order_code LIKE 'IMBIV%' THEN
        name := 'Clams and Mussels';
    END IF;

    IF order_code LIKE 'IMGAS%' THEN
        name := 'Snails and Allies';
    END IF;

    IF order_code LIKE 'IMCEP%' THEN
        name := 'Octopuses and Allies';
    END IF;

    IF order_code LIKE 'IANNOLI%' THEN
        name := 'Earthworms';
    END IF;

    IF order_hcun = 'Amblypygi' THEN
        name := 'Scorpions and Allies';
    END IF;

    IF order_hcun = 'Araneae' THEN
        name := 'Spiders';
    END IF;

    IF order_hcun = 'Pseudoscorpiones' THEN
        name := 'Pseudoscorpions';
    END IF;

    IF order_code LIKE 'ICRBRPSF%' THEN
        name := 'Fairy Shrimps';
    END IF;

    IF fam_code LIKE 'ICRBRPSC%' THEN
        name := 'Clam Shrimps';
    END IF;

    IF order_code LIKE 'ICROST%' THEN
        name := 'Ostracods';
    END IF;

    IF order_code LIKE 'ICRMAXCOP%' THEN
        name := 'Copepods';
    END IF;

    IF order_code = 'ICRMALAM' THEN
        name := 'Amphipods';
    END IF;

    IF order_code = 'ICRMALIS' THEN
        name := 'Isopods';
    END IF;

    IF order_code LIKE 'ICRMALDE%' THEN
        name := 'Crabs, Crayfishes, and Shrimps';
    END IF;

    IF order_code LIKE 'IDIP%' THEN
        name := 'Millipedes';
    END IF;

    IF order_code = 'IHEXCL' THEN
        name := 'Springtails';
    END IF;

    IF order_code = 'IIEPH' THEN
        name := 'Mayflies';
    END IF;

    IF order_code = 'IIOD' THEN
        name := 'Dragonflies and Damselflies';
    END IF;

    IF order_code = 'IIOR' THEN
        name := 'Grasshoppers and Allies';
    END IF;

    IF order_code = 'IIPLE' THEN
        name := 'Stoneflies';
    END IF;

    IF order_code LIKE 'IIHEM%' THEN
        name := 'True Bugs and Allies';
    END IF;

    IF order_code = 'IICOL' THEN
        name := 'Beetles';
    END IF;

    IF order_code = 'IIMAL' THEN
        name := 'Mallophaga';
    END IF;

    IF order_code = 'IIPSC' THEN
        name := 'Psocodea';
    END IF;

    IF order_code = 'IIMEC' THEN
        name := 'Scorpionflies';
    END IF;

    IF order_code = 'IITRI' THEN
        name := 'Caddisflies';
    END IF;

    IF order_code = 'IILE' THEN
        name := 'Butterflies and Moths';
    END IF;

    IF order_code = 'IIDI' THEN
        name := 'Flies';
    END IF;

    IF order_code = 'IIHYM' THEN
        name := 'Ants, Bees, and Wasps';
    END IF;

    IF order_code LIKE 'IECN%' THEN
        name := 'Sea Stars and Allies';
    END IF;

    IF order_code LIKE 'P%' OR elcode LIKE 'N%' THEN
        name := 'Plants and Lichens';
    END IF;
    /* if cls_hcun = 'Lecanoromycetes' then name := 'Plants and Lichens'; end if; */

    IF elcode LIKE 'C%' THEN
        name := 'Natural Communities';
    END IF;
    RETURN (name);
END;
$BODY$
LANGUAGE  plpgsql;


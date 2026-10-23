CREATE OR REPLACE FUNCTION ext.frm_comm_name(IN est_id_arg BIGINT)
RETURNS TEXT
AS
$BODY$
DECLARE
    cname CHARACTER VARYING(50);
    frm_cname CHARACTER VARYING(50);
BEGIN
    SELECT
        oracle.substr(est.s_primary_common_name, 1, 50)
        INTO STRICT cname
        FROM core.element_subnational AS est
        WHERE est.element_subnational_id = est_id_arg;
    frm_cname := '';

    IF cname = 'A Caddisfly' THEN
        frm_cname := 'a caddisfly';
    END IF;

    IF cname = 'A Comb-Clawed Beetle' THEN
        frm_cname := 'a comb-clawed beetle';
    END IF;

    IF cname = 'A Mayfly' THEN
        frm_cname := 'a mayfly';
    END IF;

    IF cname = 'A Sheetweaver Spider' THEN
        frm_cname := 'a sheetweaver spider';
    END IF;

    IF cname = 'A Stonefly' THEN
        frm_cname := 'a stonefly';
    END IF;

    IF cname = 'A Tiger Beetle' THEN
        frm_cname := 'a tiger beetle';
    END IF;

    IF cname = 'Alachua Pleasing Fungus Beetle' THEN
        frm_cname := 'Alachua pleasing fungus beetle';
    END IF;

    IF cname = 'Alexander Siltsnail' THEN
        frm_cname := 'Alexander siltsnail';
    END IF;

    IF cname = 'Allegheny River Cruiser' THEN
        frm_cname := 'Allegheny river cruiser';
    END IF;

    IF cname = 'Amazon Darner' THEN
        frm_cname := 'Amazon darner';
    END IF;

    IF cname = 'Amber Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'amber pocket gopher aphodius beetle';
    END IF;

    IF cname = 'American Burying Beetle' THEN
        frm_cname := 'American burying beetle';
    END IF;

    IF cname = 'American Rubyspot' THEN
        frm_cname := 'American rubyspot';
    END IF;

    IF cname = 'American Sand-burrowing Mayfly' THEN
        frm_cname := 'American sand-burrowing mayfly';
    END IF;

    IF cname = 'Amethyst Hairstreak' THEN
        frm_cname := 'amethyst hairstreak';
    END IF;

    IF cname = 'An Aquatic Cave Amphipod' THEN
        frm_cname := 'an aquatic cave amphipod';
    END IF;

    IF cname = 'Antillean Spreadwing' THEN
        frm_cname := 'Antillean spreadwing';
    END IF;

    IF cname = 'Apalachicola Ebonyshell' THEN
        frm_cname := 'Apalachicola ebonyshell';
    END IF;

    IF cname = 'Apalachicola Floater' THEN
        frm_cname := 'Apalachicola floater';
    END IF;

    IF cname = 'Apalachicola Grasshopper' THEN
        frm_cname := 'Apalachicola grasshopper';
    END IF;

    IF cname = 'Apalachicola Hydroptila Caddisfly' THEN
        frm_cname := 'Apalachicola hydroptila caddisfly';
    END IF;

    IF cname = 'Apalachicola Shadowfly' THEN
        frm_cname := 'Apalachicola shadowfly';
    END IF;

    IF cname = 'Archbold Anomala Scarab Beetle' THEN
        frm_cname := 'Archbold anomala scarab beetle';
    END IF;

    IF cname = 'Archbold Bess Beetle' THEN
        frm_cname := 'Archbold bess beetle';
    END IF;

    IF cname = 'Archbold Cebrionid Beetle' THEN
        frm_cname := 'Archbold cebrionid beetle';
    END IF;

    IF cname = 'Arogos Skipper' THEN
        frm_cname := 'arogos skipper';
    END IF;

    IF cname = 'Atala' THEN
        frm_cname := 'atala';
    END IF;

    IF cname = 'Atlantic Geoduck' THEN
        frm_cname := 'Atlantic geoduck';
    END IF;

    IF cname = 'Autumn Tiger Beetle' THEN
        frm_cname := 'autumn tiger beetle';
    END IF;

    IF cname = 'Bahamian Swallowtail' THEN
        frm_cname := 'Bahamian swallowtail';
    END IF;

    IF cname = 'Bailey''s Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'Bailey''s pocket gopher aphodius beetle';
    END IF;

    IF cname = 'Baker''s Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'Baker''s pocket gopher aphodius beetle';
    END IF;

    IF cname = 'Banded Hairstreak' THEN
        frm_cname := 'banded hairstreak';
    END IF;

    IF cname = 'Banded Spiketail' THEN
        frm_cname := 'banded spiketail';
    END IF;

    IF cname = 'Banded Tree Snail' THEN
        frm_cname := 'banded tree snail';
    END IF;

    IF cname = 'Bankclimber' THEN
        frm_cname := 'bankclimber';
    END IF;

    IF cname = 'Baracoa Skipper' THEN
        frm_cname := 'Baracoa skipper';
    END IF;

    IF cname = 'Barrier Island Hesperapis Bee' THEN
        frm_cname := 'barrier island hesperapis bee';
    END IF;

    IF cname = 'Bartram''s Scrub-Hairstreak' THEN
        frm_cname := 'Bartram''s scrub-hairstreak';
    END IF;

    IF cname = 'Belle''s Sanddragon' THEN
        frm_cname := 'Belle''s sanddragon';
    END IF;

    IF cname = 'Benedict''s Wharf Crab' THEN
        frm_cname := 'Benedict''s wharf crab';
    END IF;

    IF cname = 'Berner''s Microcaddisfly' THEN
        frm_cname := 'Berner''s microcaddisfly';
    END IF;

    IF cname = 'Berry''s Skipper' THEN
        frm_cname := 'Berry''s skipper';
    END IF;

    IF cname = 'Bicolored Burrowing Scarab Beetle' THEN
        frm_cname := 'bicolored burrowing scarab beetle';
    END IF;

    IF cname = 'Big Blue Spring Cave Crayfish' THEN
        frm_cname := 'Big Blue Spring cave crayfish';
    END IF;

    IF cname = 'Big Pine Key Ataenius Dung Beetle' THEN
        frm_cname := 'Big Pine Key ataenius dung beetle';
    END IF;

    IF cname = 'Big Pine Key Conehead Katydid' THEN
        frm_cname := 'Big Pine Key conehead katydid';
    END IF;

    IF cname = 'Big-cheeked Cave Crayfish' THEN
        frm_cname := 'big-cheeked cave crayfish';
    END IF;

    IF cname = 'Black Creek Crayfish' THEN
        frm_cname := 'Black Creek crayfish';
    END IF;

    IF cname = 'Black-crested Elimia Snail' THEN
        frm_cname := 'black-crested elimia snail';
    END IF;

    IF cname = 'Black-Headed Pleasing Fungus Beetle' THEN
        frm_cname := 'black-headed pleasing fungus beetle';
    END IF;

    IF cname = 'Blue Purse-web Spider' THEN
        frm_cname := 'blue purse-web spider';
    END IF;

    IF cname = 'Blue Sand-river Mayfly' THEN
        frm_cname := 'blue sand-river mayfly';
    END IF;

    IF cname = 'Blue Spring Hydrobe Snail' THEN
        frm_cname := 'Blue Spring hydrobe snail';
    END IF;

    IF cname = 'Blue-striped Spreadwing' THEN
        frm_cname := 'blue-striped spreadwing';
    END IF;

    IF cname = 'Boulder Star Coral' THEN
        frm_cname := 'boulder star coral';
    END IF;

    IF cname = 'Broad Cercus Scrub Grasshopper' THEN
        frm_cname := 'broad cercus scrub grasshopper';
    END IF;

    IF cname = 'Broad-Sided Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'broad-sided pocket gopher aphodius beetle';
    END IF;

    IF cname = 'Broad-winged Skipper' THEN
        frm_cname := 'broad-winged skipper';
    END IF;

    IF cname = 'Bronze Clubtail' THEN
        frm_cname := 'bronze clubtail';
    END IF;

    IF cname = 'Brown Merycomyian Tabanid Fly' THEN
        frm_cname := 'brown merycomyian tabanid fly';
    END IF;

    IF cname = 'Butterprint Brain Coral' THEN
        frm_cname := 'butterprint brain coral';
    END IF;

    IF cname = 'Calhoun''s Skipper' THEN
        frm_cname := 'Calhoun''s skipper';
    END IF;

    IF cname = 'Calvert''s Emerald' THEN
        frm_cname := 'Calvert''s emerald';
    END IF;

    IF cname = 'Caracara Commensal Scarab Beetle' THEN
        frm_cname := 'caracara commensal scarab beetle';
    END IF;

    IF cname = 'Caribbean Birddrop' THEN
        frm_cname := 'Caribbean birddrop';
    END IF;

    IF cname = 'Carolina Forest Scarab' THEN
        frm_cname := 'Carolina forest scarab';
    END IF;

    IF cname = 'Carrot Glass Snail' THEN
        frm_cname := 'carrot glass snail';
    END IF;

    IF cname = 'Cartwright''s Mycotrupes Beetle' THEN
        frm_cname := 'Cartwright''s mycotrupes beetle';
    END IF;

    IF cname = 'Ceromatic Noctuid Moth' THEN
        frm_cname := 'ceromatic noctuid moth';
    END IF;

    IF cname = 'Changeable Orthotrichian Microcaddisfly' THEN
        frm_cname := 'changeable orthotrichian microcaddisfly';
    END IF;

    IF cname = 'Checkered Skipper' THEN
        frm_cname := 'checkered skipper';
    END IF;

    IF cname = 'Chevrolat''s Tropical Long-Horned Beetle' THEN
        frm_cname := 'Chevrolat''s tropical long-horned beetle';
    END IF;

    IF cname = 'Chipola Slabshell' THEN
        frm_cname := 'Chipola slabshell';
    END IF;

    IF cname = 'Choctaw Bean' THEN
        frm_cname := 'Choctaw bean';
    END IF;

    IF cname = 'Clemens'' June Beetle' THEN
        frm_cname := 'Clemens'' June beetle';
    END IF;

    IF cname = 'Clench''s Goniobasis' THEN
        frm_cname := 'Clench''s goniobasis';
    END IF;

    IF cname = 'Clifton Springs Hydrobe Snail' THEN
        frm_cname := 'Clifton Springs hydrobe snail';
    END IF;

    IF cname = 'Coastal Lowland Cave Crayfish' THEN
        frm_cname := 'coastal lowland cave crayfish';
    END IF;

    IF cname = 'Cobra Clubtail' THEN
        frm_cname := 'cobra clubtail';
    END IF;

    IF cname = 'Cocoa Clubtail' THEN
        frm_cname := 'cocoa clubtail';
    END IF;

    IF cname = 'Cofaqui Skipper' THEN
        frm_cname := 'Cofaqui skipper';
    END IF;

    IF cname = 'Common Roadside-Skipper' THEN
        frm_cname := 'common roadside-skipper';
    END IF;

    IF cname = 'Common Sootywing' THEN
        frm_cname := 'common sootywing';
    END IF;

    IF cname = 'Coppery Emerald' THEN
        frm_cname := 'coppery emerald';
    END IF;

    IF cname = 'Coral Hairstreak' THEN
        frm_cname := 'coral hairstreak';
    END IF;

    IF cname = 'Creek Siltsnail' THEN
        frm_cname := 'creek siltsnail';
    END IF;

    IF cname = 'Crenulate Horn' THEN
        frm_cname := 'crenulate horn';
    END IF;

    IF cname = 'Creole Pearly Eye' THEN
        frm_cname := 'Creole pearly eye';
    END IF;

    IF cname = 'Crooked Silky June Beetle' THEN
        frm_cname := 'crooked silky June beetle';
    END IF;

    IF cname = 'Crystal Siltsnail' THEN
        frm_cname := 'crystal siltsnail';
    END IF;

    IF cname = 'Cuban Crescent' THEN
        frm_cname := 'Cuban crescent';
    END IF;

    IF cname = 'Cypress Crayfish' THEN
        frm_cname := 'cypress crayfish';
    END IF;

    IF cname = 'Dark Dusky Wing' THEN
        frm_cname := 'dark dusky wing';
    END IF;

    IF cname = 'Dark Tiny Sand-loving Scarab' THEN
        frm_cname := 'dark tiny sand-loving scarab';
    END IF;

    IF cname = 'Daytona Long-horned Caddisfly' THEN
        frm_cname := 'Daytona long-horned caddisfly';
    END IF;

    IF cname = 'Delicate Silky June Beetle' THEN
        frm_cname := 'delicate silky June beetle';
    END IF;

    IF cname = 'Delicate Spike' THEN
        frm_cname := 'delicate spike';
    END IF;

    IF cname = 'Delong''s Aneflomorpha Long-Horned Beetle' THEN
        frm_cname := 'Delong''s aneflomorpha long-horned beetle';
    END IF;

    IF cname = 'Delong''s Mixogaster Flower Fly' THEN
        frm_cname := 'Delong''s mixogaster flower fly';
    END IF;

    IF cname = 'Dense Hydrobe Snail' THEN
        frm_cname := 'dense hydrobe snail';
    END IF;

    IF cname = 'Dentate Orthotrichian Microcaddisfly' THEN
        frm_cname := 'dentate orthotrichian microcaddisfly';
    END IF;

    IF cname = 'Diminutive Clubtail' THEN
        frm_cname := 'diminutive clubtail';
    END IF;

    IF cname = 'Dina Yellow' THEN
        frm_cname := 'Dina yellow';
    END IF;

    IF cname = 'Dingy Purplewing' THEN
        frm_cname := 'dingy purplewing';
    END IF;

    IF cname = 'Dion Skipper' THEN
        frm_cname := 'Dion skipper';
    END IF;

    IF cname = 'Disguised Hairstreak' THEN
        frm_cname := 'disguised hairstreak';
    END IF;

    IF cname = 'Diurnal Scrub June Beetle' THEN
        frm_cname := 'diurnal scrub June beetle';
    END IF;

    IF cname = 'Dougherty Plain Cave Crayfish' THEN
        frm_cname := 'Dougherty Plain cave crayfish';
    END IF;

    IF cname = 'Dusky Roadside-Skipper' THEN
        frm_cname := 'dusky roadside-skipper';
    END IF;

    IF cname = 'Dusky-handed Tailless Whip Scorpion' THEN
        frm_cname := 'dusky-handed tailless whip scorpion';
    END IF;

    IF cname = 'Earwig Scorpionfly' THEN
        frm_cname := 'earwig scorpionfly';
    END IF;

    IF cname = 'East Coast Scrub Grasshopper' THEN
        frm_cname := 'east coast scrub grasshopper';
    END IF;

    IF cname = 'Eastern Comma' THEN
        frm_cname := 'eastern comma';
    END IF;

    IF cname = 'Eastern Meske''s Skipper' THEN
        frm_cname := 'eastern Meske''s skipper';
    END IF;

    IF cname = 'Eastern Pine Elfin' THEN
        frm_cname := 'eastern pine elfin';
    END IF;

    IF cname = 'Eastern Red-bellied Tiger Beetle' THEN
        frm_cname := 'eastern red-bellied tiger beetle';
    END IF;

    IF cname = 'Eastern Ringtail' THEN
        frm_cname := 'eastern ringtail';
    END IF;

    IF cname = 'Eastern Tailed Blue' THEN
        frm_cname := 'eastern tailed blue';
    END IF;

    IF cname = 'Eastern Willowfly' THEN
        frm_cname := 'eastern willowfly';
    END IF;

    IF cname = 'Econfina Springs Cave Isopod' THEN
        frm_cname := 'Econfina Springs cave isopod';
    END IF;

    IF cname = 'Eglin Caenis Mayfly' THEN
        frm_cname := 'Eglin caenis mayfly';
    END IF;

    IF cname = 'Eglin Uplands Scarab Beetle' THEN
        frm_cname := 'Eglin uplands scarab beetle';
    END IF;

    IF cname = 'Elegant Spreadwing' THEN
        frm_cname := 'elegant spreadwing';
    END IF;

    IF cname = 'Elerob''s Microcaddisfly' THEN
        frm_cname := 'Elerob''s microcaddisfly';
    END IF;

    IF cname = 'Eleuthera Orb Weaver' THEN
        frm_cname := 'Eleuthera orb weaver';
    END IF;

    IF cname = 'Elfin Skimmer' THEN
        frm_cname := 'elfin skimmer';
    END IF;

    IF cname = 'Elizoria June Beetle' THEN
        frm_cname := 'elizoria June beetle';
    END IF;

    IF cname = 'Elkhorn Coral' THEN
        frm_cname := 'elkhorn coral';
    END IF;

    IF cname = 'Elongate June Beetle' THEN
        frm_cname := 'elongate June beetle';
    END IF;

    IF cname = 'Elongate Pocket Gopher Ptomaphagus Beetle' THEN
        frm_cname := 'elongate pocket gopher ptomaphagus beetle';
    END IF;

    IF cname = 'Enterprise Siltsnail' THEN
        frm_cname := 'Enterprise siltsnail';
    END IF;

    IF cname = 'Everglades Brownwing Firefly' THEN
        frm_cname := 'Everglades brownwing firefly';
    END IF;

    IF cname = 'Everglades Sprite' THEN
        frm_cname := 'Everglades sprite';
    END IF;

    IF cname = 'Falcate Orangetip' THEN
        frm_cname := 'falcate orangetip';
    END IF;

    IF cname = 'Fat Threeridge' THEN
        frm_cname := 'fat threeridge';
    END IF;

    IF cname = 'Fenney Springs Hydrobe Snail' THEN
        frm_cname := 'Fenney Springs hydrobe snail';
    END IF;

    IF cname = 'Fig Seed Diving Beetle' THEN
        frm_cname := 'fig seed diving beetle';
    END IF;

    IF cname = 'Fire-back Crayfish' THEN
        frm_cname := 'fire-back crayfish';
    END IF;

    IF cname = 'Flat Floater' THEN
        frm_cname := 'flat floater';
    END IF;

    IF cname = 'Flatwood Siltsnail' THEN
        frm_cname := 'flatwood siltsnail';
    END IF;

    IF cname = 'Floodplain Phanaeus Scarab Beetle' THEN
        frm_cname := 'floodplain phanaeus scarab beetle';
    END IF;

    IF cname = 'Florida Asaphomyian Tabanid Fly' THEN
        frm_cname := 'Florida asaphomyian tabanid fly';
    END IF;

    IF cname = 'Florida Brown Checkered Summer Sedge' THEN
        frm_cname := 'Florida brown checkered summer sedge';
    END IF;

    IF cname = 'Florida Cave Amphipod' THEN
        frm_cname := 'Florida cave amphipod';
    END IF;

    IF cname = 'Florida Cave Isopod' THEN
        frm_cname := 'Florida cave isopod';
    END IF;

    IF cname = 'Florida Cebrionid Beetle' THEN
        frm_cname := 'Florida cebrionid beetle';
    END IF;

    IF cname = 'Florida Ceraclean Caddisfly' THEN
        frm_cname := 'Florida ceraclean caddisfly';
    END IF;

    IF cname = 'Florida Cernotinan Caddisfly' THEN
        frm_cname := 'Florida cernotinan caddisfly';
    END IF;

    IF cname = 'Florida Coast Ataenius Beetle' THEN
        frm_cname := 'Florida coast ataenius beetle';
    END IF;

    IF cname = 'Florida Cream and Brown Microcaddisfly' THEN
        frm_cname := 'Florida cream and brown microcaddisfly';
    END IF;

    IF cname = 'Florida Deepdigger Scarab Beetle' THEN
        frm_cname := 'Florida deepdigger scarab beetle';
    END IF;

    IF cname = 'Florida Duskywing' THEN
        frm_cname := 'Florida duskywing';
    END IF;

    IF cname = 'Florida Floater' THEN
        frm_cname := 'Florida floater';
    END IF;

    IF cname = 'Florida Hypotrichia Scarab Beetle' THEN
        frm_cname := 'Florida hypotrichia scarab beetle';
    END IF;

    IF cname = 'Florida Intertidal Firefly' THEN
        frm_cname := 'Florida intertidal firefly';
    END IF;

    IF cname = 'Florida Keys Tree Snail' THEN
        frm_cname := 'Florida Keys tree snail';
    END IF;

    IF cname = 'Florida Leafwing' THEN
        frm_cname := 'Florida leafwing';
    END IF;

    IF cname = 'Florida Longbeak Crayfish' THEN
        frm_cname := 'Florida longbeak crayfish';
    END IF;

    IF cname = 'Florida Olive Hairstreak' THEN
        frm_cname := 'Florida olive hairstreak';
    END IF;

    IF cname = 'Florida Pearly Eye' THEN
        frm_cname := 'Florida pearly eye';
    END IF;

    IF cname = 'Florida Privet Long-Horned Beetle' THEN
        frm_cname := 'Florida privet long-horned beetle';
    END IF;

    IF cname = 'Florida Purplewing' THEN
        frm_cname := 'Florida purplewing';
    END IF;

    IF cname = 'Florida Rainbow' THEN
        frm_cname := 'Florida rainbow';
    END IF;

    IF cname = 'Florida Shiny Spike' THEN
        frm_cname := 'Florida shiny spike';
    END IF;

    IF cname = 'Florida Sminthurus Springtail' THEN
        frm_cname := 'Florida sminthurus springtail';
    END IF;

    IF cname = 'Florida Trap-door Spider' THEN
        frm_cname := 'Florida trap-door spider';
    END IF;

    IF cname = 'Florida Tree Snail' THEN
        frm_cname := 'Florida tree snail';
    END IF;

    IF cname = 'Florida White' THEN
        frm_cname := 'Florida white';
    END IF;

    IF cname = 'Floridian Finger-net Caddisfly' THEN
        frm_cname := 'Floridian finger-net caddisfly';
    END IF;

    IF cname = 'Floridian Triaenode Caddisfly' THEN
        frm_cname := 'Floridian triaenode caddisfly';
    END IF;

    IF cname = 'Flower Coral' THEN
        frm_cname := 'flower coral';
    END IF;

    IF cname = 'Fluted Elephant-ear' THEN
        frm_cname := 'fluted elephant-ear';
    END IF;

    IF cname = 'Fox Squirrel Scarab' THEN
        frm_cname := 'fox squirrel scarab';
    END IF;

    IF cname = 'Freemouth Hydrobe Snail' THEN
        frm_cname := 'freemouth hydrobe snail';
    END IF;

    IF cname = 'Frosted Elfin' THEN
        frm_cname := 'frosted elfin';
    END IF;

    IF cname = 'Frost''s Silky June Beetle' THEN
        frm_cname := 'Frost''s silky June beetle';
    END IF;

    IF cname = 'Fused Staghorn Coral' THEN
        frm_cname := 'fused staghorn coral';
    END IF;

    IF cname = 'Fuzzy Pigtoe' THEN
        frm_cname := 'fuzzy pigtoe';
    END IF;

    IF cname = 'Georgia Satyr' THEN
        frm_cname := 'Georgia satyr';
    END IF;

    IF cname = 'Gold Head Branch Caddisfly' THEN
        frm_cname := 'Gold Head Branch caddisfly';
    END IF;

    IF cname = 'Golden-banded Skipper' THEN
        frm_cname := 'golden-banded skipper';
    END IF;

    IF cname = 'Gopher Moth' THEN
        frm_cname := 'gopher moth';
    END IF;

    IF cname = 'Gopher Tortoise Acrolophus Moth' THEN
        frm_cname := 'gopher tortoise acrolophus moth';
    END IF;

    IF cname = 'Gopher Tortoise Aphodius Beetle' THEN
        frm_cname := 'gopher tortoise aphodius beetle';
    END IF;

    IF cname = 'Gopher Tortoise Copris Beetle' THEN
        frm_cname := 'gopher tortoise copris beetle';
    END IF;

    IF cname = 'Gopher Tortoise Hister Beetle' THEN
        frm_cname := 'gopher tortoise hister beetle';
    END IF;

    IF cname = 'Gordon''s Little Sister Sedge Caddisfly' THEN
        frm_cname := 'Gordon''s little sister sedge caddisfly';
    END IF;

    IF cname = 'Gray Ministreak' THEN
        frm_cname := 'gray ministreak';
    END IF;

    IF cname = 'Gray Petaltail' THEN
        frm_cname := 'gray petaltail';
    END IF;

    IF cname = 'Great Star Coral' THEN
        frm_cname := 'great star coral';
    END IF;

    IF cname = 'Green Cove Springsnail' THEN
        frm_cname := 'Green Cove springsnail';
    END IF;

    IF cname = 'Grisatra Underwing' THEN
        frm_cname := 'grisatra underwing';
    END IF;

    IF cname = 'Grooved Brain Coral' THEN
        frm_cname := 'grooved brain coral';
    END IF;

    IF cname = 'Gulf Coast Clubtail' THEN
        frm_cname := 'Gulf Coast clubtail';
    END IF;

    IF cname = 'Gulf Moccasinshell' THEN
        frm_cname := 'Gulf moccasinshell';
    END IF;

    IF cname = 'Gurney''s Spurthroat Grasshopper' THEN
        frm_cname := 'Gurney''s spurthroat grasshopper';
    END IF;

    IF cname = 'Haddleton''s Lampsilid Clam' THEN
        frm_cname := 'Haddleton''s lampsilid clam';
    END IF;

    IF cname = 'Hairy-necked Tiger Beetle' THEN
        frm_cname := 'hairy-necked tiger beetle';
    END IF;

    IF cname = 'Hamilton''s Hydroptila Caddisfly' THEN
        frm_cname := 'Hamilton''s hydroptila caddisfly';
    END IF;

    IF cname = 'Handsome Flower Scarab Beetle' THEN
        frm_cname := 'handsome flower scarab beetle';
    END IF;

    IF cname = 'Harvester' THEN
        frm_cname := 'harvester';
    END IF;

    IF cname = 'Havana Ataenius Beetle' THEN
        frm_cname := 'Havana ataenius beetle';
    END IF;

    IF cname = 'Helicta Satyr (Miami-Dade County subspecies)' THEN
        frm_cname := 'helicta satyr (Miami-Dade subspecies)';
    END IF;

    IF cname = 'Henry''s Elfin' THEN
        frm_cname := 'Henry''s elfin';
    END IF;

    IF cname = 'Hessel''s Hairstreak' THEN
        frm_cname := 'Hessel''s hairstreak';
    END IF;

    IF cname = 'Highlands Tiger Beetle' THEN
        frm_cname := 'Highlands tiger beetle';
    END IF;

    IF cname = 'Hirsute Mayfly' THEN
        frm_cname := 'hirsute mayfly';
    END IF;

    IF cname = 'Hoary Edge' THEN
        frm_cname := 'hoary edge';
    END IF;

    IF cname = 'Hobbs'' Cave Amphipod' THEN
        frm_cname := 'Hobbs'' cave amphipod';
    END IF;

    IF cname = 'Hodges'' Clubtail' THEN
        frm_cname := 'Hodges'' clubtail';
    END IF;

    IF cname = 'Horn''s Aethecerinus Long-Horned Beetle' THEN
        frm_cname := 'Horn''s aethecerinus long-horned beetle';
    END IF;

    IF cname = 'Howden''s Copris Beetle' THEN
        frm_cname := 'Howden''s copris beetle';
    END IF;

    IF cname = 'Hubbell''s Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'Hubbell''s pocket gopher aphodius beetle';
    END IF;

    IF cname = 'Ichetucknee Siltsnail' THEN
        frm_cname := 'Ichetucknee siltsnail';
    END IF;

    IF cname = 'Island Woodrat Ataenius Beetle' THEN
        frm_cname := 'island woodrat ataenius beetle';
    END IF;

    IF cname = 'Kelly''s Cream and Brown Mottled Microcaddisfly' THEN
        frm_cname := 'Kelly''s cream and brown mottled microcaddisfly';
    END IF;

    IF cname = 'Key Gnaphosid Spider' THEN
        frm_cname := 'Key gnaphosid spider';
    END IF;

    IF cname = 'Keys Green June Beetle' THEN
        frm_cname := 'Keys green June beetle';
    END IF;

    IF cname = 'Keys Mudcloak' THEN
        frm_cname := 'Keys mudcloak';
    END IF;

    IF cname = 'Keys Scaly Cricket' THEN
        frm_cname := 'Keys scaly cricket';
    END IF;

    IF cname = 'Keys Short-winged Conehead Katydid' THEN
        frm_cname := 'Keys short-winged conehead katydid';
    END IF;

    IF cname = 'Keys Vertigo' THEN
        frm_cname := 'Keys vertigo';
    END IF;

    IF cname = 'King''s Cream and Brown Mottled Microcaddisfly' THEN
        frm_cname := 'King''s cream and brown mottled microcaddisfly';
    END IF;

    IF cname = 'King''s Hairstreak' THEN
        frm_cname := 'King''s hairstreak';
    END IF;

    IF cname = 'Kissimmee Sponge' THEN
        frm_cname := 'Kissimmee sponge';
    END IF;

    IF cname = 'Klots'' Skipper' THEN
        frm_cname := 'Klots'' skipper';
    END IF;

    IF cname = 'Knobby Brain Coral' THEN
        frm_cname := 'knobby brain coral';
    END IF;

    IF cname = 'Kriebel''s Hydroptila Caddisfly' THEN
        frm_cname := 'Kriebel''s hydroptila caddisfly';
    END IF;

    IF cname = 'Lace-winged Roadside Skipper' THEN
        frm_cname := 'lace-winged roadside skipper';
    END IF;

    IF cname = 'Lake Placid Funnel Wolf Spider' THEN
        frm_cname := 'Lake Placid funnel wolf spider';
    END IF;

    IF cname = 'Lake Wales Ridge Velvet Ant' THEN
        frm_cname := 'Lake Wales Ridge velvet ant';
    END IF;

    IF cname = 'Large Flower Coral' THEN
        frm_cname := 'large flower coral';
    END IF;

    IF cname = 'Large Grooved Brain Coral' THEN
        frm_cname := 'large grooved brain coral';
    END IF;

    IF cname = 'Large Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'large pocket gopher aphodius beetle';
    END IF;

    IF cname = 'Large-Jawed Cebrionid Beetle' THEN
        frm_cname := 'large-jawed cebrionid beetle';
    END IF;

    IF cname = 'Larger Sandhill Grasshopper' THEN
        frm_cname := 'larger sandhill grasshopper';
    END IF;

    IF cname = 'Laura''s Clubtail' THEN
        frm_cname := 'Laura''s clubtail';
    END IF;

    IF cname = 'Lesser Fork-Tailed Grasshopper' THEN
        frm_cname := 'lesser fork-tailed grasshopper';
    END IF;

    IF cname = 'Lesser Wasp Moth' THEN
        frm_cname := 'lesser wasp moth';
    END IF;

    IF cname = 'Lettuce Coral' THEN
        frm_cname := 'lettuce coral';
    END IF;

    IF cname = 'Light-fleeing Cave Crayfish' THEN
        frm_cname := 'light-fleeing cave crayfish';
    END IF;

    IF cname = 'Little Glassywing' THEN
        frm_cname := 'little glassywing';
    END IF;

    IF cname = 'Little Meadow Long-horned Caddisfly' THEN
        frm_cname := 'little meadow long-horned caddisfly';
    END IF;

    IF cname = 'Little Mountain Jumping Spider' THEN
        frm_cname := 'little mountain jumping spider';
    END IF;

    IF cname = 'Little Oecetis Longhorned Caddisfly' THEN
        frm_cname := 'little oecetis longhorned caddisfly';
    END IF;

    IF cname = 'Little Silky June Beetle' THEN
        frm_cname := 'little silky June beetle';
    END IF;

    IF cname = 'Little-entrance Oxyethiran Microcaddisfly' THEN
        frm_cname := 'little-entrance oxyethiran microcaddisfly';
    END IF;

    IF cname = 'Little-fork Triaenode Caddisfly' THEN
        frm_cname := 'little-fork triaenode caddisfly';
    END IF;

    IF cname = 'Loammi Skipper' THEN
        frm_cname := 'loammi skipper';
    END IF;

    IF cname = 'Lobed Spiny Burrowing Beetle' THEN
        frm_cname := 'lobed spiny burrowing beetle';
    END IF;

    IF cname = 'Lobeless Spiny Burrowing Beetle' THEN
        frm_cname := 'lobeless spiny burrowing beetle';
    END IF;

    IF cname = 'Logan''s Agarodes Caddisfly' THEN
        frm_cname := 'Logan''s agarodes caddisfly';
    END IF;

    IF cname = 'Long-Clawed Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'long-clawed pocket gopher aphodius beetle';
    END IF;

    IF cname = 'Lyside Sulphur' THEN
        frm_cname := 'lyside sulphur';
    END IF;

    IF cname = 'Maidencane Cruiser' THEN
        frm_cname := 'maidencane cruiser';
    END IF;

    IF cname = 'Malachite' THEN
        frm_cname := 'malachite';
    END IF;

    IF cname = 'Mangrove Crab' THEN
        frm_cname := 'mangrove crab';
    END IF;

    IF cname = 'Mangrove Long-Horned Beetle' THEN
        frm_cname := 'mangrove long-horned beetle';
    END IF;

    IF cname = 'Marianna Cave Sheetweb Weaver Spider' THEN
        frm_cname := 'Marianna cave sheetweb weaver spider';
    END IF;

    IF cname = 'Martial Scrub-Hairstreak' THEN
        frm_cname := 'martial scrub-hairstreak';
    END IF;

    IF cname = 'Massive Starlet Coral' THEN
        frm_cname := 'massive starlet coral';
    END IF;

    IF cname = 'Mat Red Globe Scarab Beetle' THEN
        frm_cname := 'mat red globe scarab beetle';
    END IF;

    IF cname = 'McCrone''s Burrowing Wolf Spider' THEN
        frm_cname := 'McCrone''s burrowing wolf spider';
    END IF;

    IF cname = 'Miami Blue' THEN
        frm_cname := 'Miami blue';
    END IF;

    IF cname = 'Miami Cave Crayfish' THEN
        frm_cname := 'Miami cave crayfish';
    END IF;

    IF cname = 'Miami Chafer Beetle' THEN
        frm_cname := 'Miami chafer beetle';
    END IF;

    IF cname = 'Mimosa Yellow' THEN
        frm_cname := 'Mimosa yellow';
    END IF;

    IF cname = 'Molson''s Microcaddisfly' THEN
        frm_cname := 'Molson''s microcaddisfly';
    END IF;

    IF cname = 'Morris'' Tiny Sand-loving Scarab ' THEN
        frm_cname := 'Morris'' tiny sand-loving scarab ';
    END IF;

    IF cname = 'Morse''s Dinky Light Summer Sedge' THEN
        frm_cname := 'Morse''s dinky light summer sedge';
    END IF;

    IF cname = 'Morse''s Little Plain Brown Sedge' THEN
        frm_cname := 'Morse''s little plain brown sedge';
    END IF;

    IF cname = 'Morse''s Long-horn Sedge' THEN
        frm_cname := 'Morse''s long-horn sedge';
    END IF;

    IF cname = 'Morse''s Wingless Grasshopper' THEN
        frm_cname := 'Morse''s wingless grasshopper';
    END IF;

    IF cname = 'Mottled Duskywing' THEN
        frm_cname := 'mottled duskywing';
    END IF;

    IF cname = 'Mourning Cloak' THEN
        frm_cname := 'mourning cloak';
    END IF;

    IF cname = 'Narrow Pigtoe' THEN
        frm_cname := 'narrow pigtoe';
    END IF;

    IF cname = 'Nickerbean Blue' THEN
        frm_cname := 'nickerbean blue';
    END IF;

    IF cname = 'Nocturnal Scrub Velvet Ant' THEN
        frm_cname := 'nocturnal scrub velvet ant';
    END IF;

    IF cname = 'North Florida Spider Cave Crayfish' THEN
        frm_cname := 'north Florida spider cave crayfish';
    END IF;

    IF cname = 'North Peninsular Mycotrupes Beetle' THEN
        frm_cname := 'north peninsular mycotrupes beetle';
    END IF;

    IF cname = 'Novasota Oxyethiran Microcaddisfly' THEN
        frm_cname := 'Novasota oxyethiran microcaddisfly';
    END IF;

    IF cname = 'Ocala Claw-Cercus Grasshopper' THEN
        frm_cname := 'Ocala claw-cercus grasshopper';
    END IF;

    IF cname = 'Ocala Deepdigger Scarab Beetle' THEN
        frm_cname := 'Ocala deepdigger scarab beetle';
    END IF;

    IF cname = 'Ochlockonee Arc-mussel' THEN
        frm_cname := 'Ochlockonee arc-mussel';
    END IF;

    IF cname = 'Ochlockonee Moccasinshell' THEN
        frm_cname := 'Ochlockonee moccasinshell';
    END IF;

    IF cname = 'Okaloosa Somber Microcaddisfly' THEN
        frm_cname := 'Okaloosa somber microcaddisfly';
    END IF;

    IF cname = 'Okefenokee Zale Moth' THEN
        frm_cname := 'Okefenokee zale moth';
    END IF;

    IF cname = 'Oklawaha Sponge' THEN
        frm_cname := 'Oklawaha sponge';
    END IF;

    IF cname = 'Olive Tiger Beetle' THEN
        frm_cname := 'olive tiger beetle';
    END IF;

    IF cname = 'Orange Lake Cave Crayfish' THEN
        frm_cname := 'Orange Lake cave crayfish';
    END IF;

    IF cname = 'Ordway Melanoplus Grasshopper' THEN
        frm_cname := 'Ordway melanoplus grasshopper';
    END IF;

    IF cname = 'Orlando Cave Crayfish' THEN
        frm_cname := 'Orlando cave crayfish';
    END IF;

    IF cname = 'Orlando Spider Cave Crayfish' THEN
        frm_cname := 'Orlando spider cave crayfish';
    END IF;

    IF cname = 'Oval June Beetle' THEN
        frm_cname := 'oval June beetle';
    END IF;

    IF cname = 'Oval Pigtoe' THEN
        frm_cname := 'oval pigtoe';
    END IF;

    IF cname = 'Palatka Skipper' THEN
        frm_cname := 'Palatka skipper';
    END IF;

    IF cname = 'Pallid Cave Crayfish' THEN
        frm_cname := 'pallid cave crayfish';
    END IF;

    IF cname = 'Panama City Crayfish' THEN
        frm_cname := 'Panama City crayfish';
    END IF;

    IF cname = 'Panhandle Dune Anomala Scarab Beetle' THEN
        frm_cname := 'Panhandle dune anomala scarab beetle';
    END IF;

    IF cname = 'Peck''s Cave Springtail' THEN
        frm_cname := 'Peck''s cave springtail';
    END IF;

    IF cname = 'Peninsular Floater' THEN
        frm_cname := 'peninsular floater';
    END IF;

    IF cname = 'Pepper and Salt Skipper' THEN
        frm_cname := 'pepper and salt skipper';
    END IF;

    IF cname = 'Pescador''s Bottle-Cased Caddisfly' THEN
        frm_cname := 'Pescador''s bottle-cased caddisfly';
    END IF;

    IF cname = 'Peters'' Cheumatopsyche Caddisfly' THEN
        frm_cname := 'Peters'' cheumatopsyche caddisfly';
    END IF;

    IF cname = 'Pillar Coral' THEN
        frm_cname := 'pillar coral';
    END IF;

    IF cname = 'Pitted Birddrop' THEN
        frm_cname := 'pitted birddrop';
    END IF;

    IF cname = 'Pocket Gopher Flower Beetle' THEN
        frm_cname := 'pocket gopher flower beetle';
    END IF;

    IF cname = 'Ponderous Spring Siltsnail' THEN
        frm_cname := 'ponderous spring siltsnail';
    END IF;

    IF cname = 'Porter''s Long-horn Caddisfly' THEN
        frm_cname := 'Porter''s long-horn caddisfly';
    END IF;

    IF cname = 'Proud Sphinx' THEN
        frm_cname := 'proud sphinx';
    END IF;

    IF cname = 'Provost''s Somber Caddisfly' THEN
        frm_cname := 'Provost''s somber caddisfly';
    END IF;

    IF cname = 'Pseudataenius Beetle' THEN
        frm_cname := 'pseudataenius beetle';
    END IF;

    IF cname = 'Punctate Gopher Tortoise Onthophagus Beetle' THEN
        frm_cname := 'punctate gopher tortoise onthophagus beetle';
    END IF;

    IF cname = 'Purple Bankclimber' THEN
        frm_cname := 'purple bankclimber';
    END IF;

    IF cname = 'Purple Skimmer' THEN
        frm_cname := 'purple skimmer';
    END IF;

    IF cname = 'Putnam County Cave Crayfish' THEN
        frm_cname := 'Putnam County cave crayfish';
    END IF;

    IF cname = 'Pygmy Anomala Scarab Beetle' THEN
        frm_cname := 'pygmy anomala scarab beetle';
    END IF;

    IF cname = 'Pygmy Florida Dasymutilla Velvet Ant' THEN
        frm_cname := 'pygmy Florida dasymutilla velvet ant';
    END IF;

    IF cname = 'Pygmy Sandhill Grasshopper' THEN
        frm_cname := 'pygmy sandhill grasshopper';
    END IF;

    IF cname = 'Pygmy Silky June Beetle' THEN
        frm_cname := 'pygmy silky June beetle';
    END IF;

    IF cname = 'Pygmy Siltsnail' THEN
        frm_cname := 'pygmy siltsnail';
    END IF;

    IF cname = 'Rare Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'rare pocket gopher aphodius beetle';
    END IF;

    IF cname = 'Rasmussen''s Neotrichia Caddisfly' THEN
        frm_cname := 'Rasmussen''s neotrichia caddisfly';
    END IF;

    IF cname = 'Rayed Creekshell' THEN
        frm_cname := 'rayed creekshell';
    END IF;

    IF cname = 'Red Diplotaxis Beetle' THEN
        frm_cname := 'red diplotaxis beetle';
    END IF;

    IF cname = 'Red Hills Unique Whirligig Beetle' THEN
        frm_cname := 'Red Hills unique whirligig beetle';
    END IF;

    IF cname = 'Red Widow Spider' THEN
        frm_cname := 'red widow spider';
    END IF;

    IF cname = 'Red-legged Purse-web Spider' THEN
        frm_cname := 'red-legged purse-web spider';
    END IF;

    IF cname = 'Red-Winged Pleasing Fungus Beetle' THEN
        frm_cname := 'red-winged pleasing fungus beetle';
    END IF;

    IF cname = 'Relictual Tiny Sand-loving Scarab' THEN
        frm_cname := 'relictual tiny sand-loving scarab';
    END IF;

    IF cname = 'Reversed Roadside-Skipper' THEN
        frm_cname := 'reversed roadside-skipper';
    END IF;

    IF cname = 'Ridge Scrubsnail' THEN
        frm_cname := 'ridge scrubsnail';
    END IF;

    IF cname = 'Robinson''s Anomala Scarab Beetle' THEN
        frm_cname := 'Robinson''s anomala scarab beetle';
    END IF;

    IF cname = 'Robust Tongtail' THEN
        frm_cname := 'robust tongtail';
    END IF;

    IF cname = 'Rock Springs Cave Isopod' THEN
        frm_cname := 'Rock Springs cave isopod';
    END IF;

    IF cname = 'Rock Springs Siltsnail' THEN
        frm_cname := 'Rock Springs siltsnail';
    END IF;

    IF cname = 'Rockland Grass Skipper- Keys Race' THEN
        frm_cname := 'rockland grass skipper- Keys race';
    END IF;

    IF cname = 'Rogue Creek Hydroptila Caddisfly' THEN
        frm_cname := 'Rogue Creek hydroptila caddisfly';
    END IF;

    IF cname = 'Rosemary Grasshopper' THEN
        frm_cname := 'rosemary grasshopper';
    END IF;

    IF cname = 'Rosemary Wolf Spider' THEN
        frm_cname := 'rosemary wolf spider';
    END IF;

    IF cname = 'Round Ebonyshell' THEN
        frm_cname := 'round ebonyshell';
    END IF;

    IF cname = 'Round Pearlshell' THEN
        frm_cname := 'round pearlshell';
    END IF;

    IF cname = 'Round-Necked Romulus Long-Horned Beetle' THEN
        frm_cname := 'round-necked romulus long-horned beetle';
    END IF;

    IF cname = 'Rusty Cebrionid Beetle' THEN
        frm_cname := 'rusty cebrionid beetle';
    END IF;

    IF cname = 'Rusty Grave Digger' THEN
        frm_cname := 'rusty grave digger';
    END IF;

    IF cname = 'Saberlike Hydroptila Caddisfly' THEN
        frm_cname := 'saberlike hydroptila caddisfly';
    END IF;

    IF cname = 'Sand Pine Scrub Ataenius Beetle' THEN
        frm_cname := 'sand pine scrub ataenius beetle';
    END IF;

    IF cname = 'Sandbar Tiger Beetle' THEN
        frm_cname := 'sandbar tiger beetle';
    END IF;

    IF cname = 'Sandhill Clubtail' THEN
        frm_cname := 'sandhill clubtail';
    END IF;

    IF cname = 'Sandyland Onthophagus Beetle' THEN
        frm_cname := 'sandyland onthophagus beetle';
    END IF;

    IF cname = 'Santa Fe Cave Crayfish' THEN
        frm_cname := 'Santa Fe cave crayfish';
    END IF;

    IF cname = 'Santa Rosa Cebrionid Beetle' THEN
        frm_cname := 'Santa Rosa cebrionid beetle';
    END IF;

    IF cname = 'Sarah''s Hydroptila Caddisfly' THEN
        frm_cname := 'Sarah''s hydroptila caddisfly';
    END IF;

    IF cname = 'Say''s Spiketail' THEN
        frm_cname := 'Say''s spiketail';
    END IF;

    IF cname = 'Scaly Anteater Scarab Beetle' THEN
        frm_cname := 'scaly anteater scarab beetle';
    END IF;

    IF cname = 'Schaus'' Swallowtail' THEN
        frm_cname := 'Schaus'' swallowtail';
    END IF;

    IF cname = 'Schwarz'' Pocket Gopher Ptomaphagus Beetle' THEN
        frm_cname := 'Schwarz'' pocket gopher ptomaphagus beetle';
    END IF;

    IF cname = 'Scrub Palmetto Flower Scarab Beetle' THEN
        frm_cname := 'scrub palmetto flower scarab beetle';
    END IF;

    IF cname = 'Scrub Tiger Beetle' THEN
        frm_cname := 'scrub tiger beetle';
    END IF;

    IF cname = 'Selys'' Sunfly' THEN
        frm_cname := 'Selys'' sunfly';
    END IF;

    IF cname = 'Seminole Crescent' THEN
        frm_cname := 'Seminole crescent';
    END IF;

    IF cname = 'Seminole Skipper' THEN
        frm_cname := 'Seminole skipper';
    END IF;

    IF cname = 'Seminole Spring Siltsnail' THEN
        frm_cname := 'Seminole Spring siltsnail';
    END IF;

    IF cname = 'Setose Cream and Brown Mottled Microcaddisfly' THEN
        frm_cname := 'setose cream and brown mottled microcaddisfly';
    END IF;

    IF cname = 'Shaggy Ghostsnail' THEN
        frm_cname := 'shaggy ghostsnail';
    END IF;

    IF cname = 'Shining Ball Scarab Beetle' THEN
        frm_cname := 'shining ball scarab beetle';
    END IF;

    IF cname = 'Shiny-rayed Pocketbook' THEN
        frm_cname := 'shiny-rayed pocketbook';
    END IF;

    IF cname = 'Short Orthotrichian Microcaddisfly' THEN
        frm_cname := 'short orthotrichian microcaddisfly';
    END IF;

    IF cname = 'Silver Glen Springs Crayfish' THEN
        frm_cname := 'Silver Glen Springs crayfish';
    END IF;

    IF cname = 'Silver-banded Hairstreak' THEN
        frm_cname := 'silver-banded hairstreak';
    END IF;

    IF cname = 'Silvery Checkerspot' THEN
        frm_cname := 'silvery checkerspot';
    END IF;

    IF cname = 'Similar Cebrionid Beetle' THEN
        frm_cname := 'similar cebrionid beetle';
    END IF;

    IF cname = 'Simple Cebrionid Beetle' THEN
        frm_cname := 'simple cebrionid beetle';
    END IF;

    IF cname = 'Six-spotted Tiger Beetle' THEN
        frm_cname := 'six-spotted tiger beetle';
    END IF;

    IF cname = 'Skelley''s June Beetle' THEN
        frm_cname := 'Skelley''s June beetle';
    END IF;

    IF cname = 'Slender Bluet' THEN
        frm_cname := 'slender bluet';
    END IF;

    IF cname = 'Slender Polyphyllan Scarab Beetle' THEN
        frm_cname := 'slender polyphyllan scarab beetle';
    END IF;

    IF cname = 'Small Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'small pocket gopher aphodius beetle';
    END IF;

    IF cname = 'Smoky Shadowfly' THEN
        frm_cname := 'smoky shadowfly';
    END IF;

    IF cname = 'Smooth Gopher Tortoise Onthophagus Beetle' THEN
        frm_cname := 'smooth gopher tortoise onthophagus beetle';
    END IF;

    IF cname = 'Southeastern Roachfly' THEN
        frm_cname := 'southeastern roachfly';
    END IF;

    IF cname = 'Southeastern Spinyleg' THEN
        frm_cname := 'southeastern spinyleg';
    END IF;

    IF cname = 'Southern Creekmussel' THEN
        frm_cname := 'southern creekmussel';
    END IF;

    IF cname = 'Southern Kidneyshell' THEN
        frm_cname := 'southern kidneyshell';
    END IF;

    IF cname = 'Southern Lake Wales Ridge June Beetle' THEN
        frm_cname := 'Southern Lake Wales Ridge June beetle';
    END IF;

    IF cname = 'Southern Pocketbook' THEN
        frm_cname := 'southern pocketbook';
    END IF;

    IF cname = 'Southern Sandshell' THEN
        frm_cname := 'southern sandshell';
    END IF;

    IF cname = 'Southern Snaketail' THEN
        frm_cname := 'southern snaketail';
    END IF;

    IF cname = 'Southwest Florida Mycotrupes Beetle' THEN
        frm_cname := 'southwest Florida mycotrupes beetle';
    END IF;

    IF cname = 'Sparkleberry Hairstreak' THEN
        frm_cname := 'sparkleberry hairstreak';
    END IF;

    IF cname = 'Spring Azure' THEN
        frm_cname := 'spring azure';
    END IF;

    IF cname = 'Spring-loving Psiloneuran Caddisfly' THEN
        frm_cname := 'spring-loving psiloneuran caddisfly';
    END IF;

    IF cname = 'Squaremouth Amnicola Snail' THEN
        frm_cname := 'squaremouth amnicola snail';
    END IF;

    IF cname = 'Squirrel Chimney Cave Shrimp' THEN
        frm_cname := 'Squirrel Chimney Cave shrimp';
    END IF;

    IF cname = 'Staghorn Coral' THEN
        frm_cname := 'staghorn coral';
    END IF;

    IF cname = 'Statira' THEN
        frm_cname := 'statira';
    END IF;

    IF cname = 'Stock Island Tree Snail' THEN
        frm_cname := 'Stock Island tree snail';
    END IF;

    IF cname = 'Strohecker''s Ataenius Beetle' THEN
        frm_cname := 'Strohecker''s ataenius beetle';
    END IF;

    IF cname = 'Strohecker''s Ivory-Spotted Long-Horned Beetle' THEN
        frm_cname := 'Strohecker''s ivory-spotted long-horned beetle';
    END IF;

    IF cname = 'Sugarfoot Moth Fly' THEN
        frm_cname := 'sugarfoot moth fly';
    END IF;

    IF cname = 'Surprising Pocket Gopher Aphodius Beetle' THEN
        frm_cname := 'surprising pocket gopher aphodius beetle';
    END IF;

    IF cname = 'Suwannee Moccasinshell' THEN
        frm_cname := 'Suwannee moccasinshell';
    END IF;

    IF cname = 'Swimming Little Florida Cave Isopod' THEN
        frm_cname := 'swimming little Florida cave isopod';
    END IF;

    IF cname = 'Sykora''s Hydroptila Caddisfly' THEN
        frm_cname := 'Sykora''s hydroptila caddisfly';
    END IF;

    IF cname = 'Symmetrical Brain Coral' THEN
        frm_cname := 'symmetrical brain coral';
    END IF;

    IF cname = 'Tail-light Damsel' THEN
        frm_cname := 'tail-light damsel';
    END IF;

    IF cname = 'Tapered Pigtoe' THEN
        frm_cname := 'tapered pigtoe';
    END IF;

    IF cname = 'Tapered Pondhorn' THEN
        frm_cname := 'tapered pondhorn';
    END IF;

    IF cname = 'Taper-tailed Darner' THEN
        frm_cname := 'taper-tailed darner';
    END IF;

    IF cname = 'Tavares White Miller Caddisfly' THEN
        frm_cname := 'Tavares white miller caddisfly';
    END IF;

    IF cname = 'Tawny Sanddragon' THEN
        frm_cname := 'tawny sanddragon';
    END IF;

    IF cname = 'Tequesta Grasshopper' THEN
        frm_cname := 'Tequesta grasshopper';
    END IF;

    IF cname = 'Three Spotted Pleasing Fungus Beetle' THEN
        frm_cname := 'three spotted pleasing fungus beetle';
    END IF;

    IF cname = 'Threeridge' THEN
        frm_cname := 'threeridge';
    END IF;

    IF cname = 'Three-tooth Triaenodes Caddisfly' THEN
        frm_cname := 'three-tooth triaenodes caddisfly';
    END IF;

    IF cname = 'Torreya Pygmy Grasshopper' THEN
        frm_cname := 'Torreya pygmy grasshopper';
    END IF;

    IF cname = 'Torreya Trap-door Spider' THEN
        frm_cname := 'Torreya trap-door spider';
    END IF;

    IF cname = 'Treetop Emerald' THEN
        frm_cname := 'treetop emerald';
    END IF;

    IF cname = 'Triangle Floater' THEN
        frm_cname := 'triangle floater';
    END IF;

    IF cname = 'Tropical Buckeye' THEN
        frm_cname := 'tropical buckeye';
    END IF;

    IF cname = 'Tropical Sprite' THEN
        frm_cname := 'tropical sprite';
    END IF;

    IF cname = 'Tropical White-Spotted Long-Horned Beetle' THEN
        frm_cname := 'tropical white-spotted long-horned beetle';
    END IF;

    IF cname = 'Truncate Urocoptid' THEN
        frm_cname := 'truncate urocoptid';
    END IF;

    IF cname = 'Turtle Mound Firefly' THEN
        frm_cname := 'Turtle Mound firefly';
    END IF;

    IF cname = 'Twin-striped Clubtail' THEN
        frm_cname := 'twin-striped clubtail';
    END IF;

    IF cname = 'Umber Shadowfly' THEN
        frm_cname := 'umber shadowfly';
    END IF;

    IF cname = 'Unbanded Agrypnia Caddisfly' THEN
        frm_cname := 'unbanded agrypnia caddisfly';
    END IF;

    IF cname = 'Underfoot Tiny Sand-loving Scarab' THEN
        frm_cname := 'underfoot tiny sand-loving scarab';
    END IF;

    IF cname = 'Volusia Grasshopper' THEN
        frm_cname := 'Volusia grasshopper';
    END IF;

    IF cname = 'Wakulla Springs Vari-colored Microcaddisfly' THEN
        frm_cname := 'Wakulla Springs vari-colored microcaddisfly';
    END IF;

    IF cname = 'Washboard' THEN
        frm_cname := 'washboard';
    END IF;

    IF cname = 'Wekiwa Hydrobe Snail' THEN
        frm_cname := 'Wekiwa hydrobe snail';
    END IF;

    IF cname = 'Wekiwa Siltsnail' THEN
        frm_cname := 'Wekiwa siltsnail';
    END IF;

    IF cname = 'White Sand-river Mayfly' THEN
        frm_cname := 'white sand-river mayfly';
    END IF;

    IF cname = 'White-cloaked Tiger Beetle' THEN
        frm_cname := 'white-cloaked tiger beetle';
    END IF;

    IF cname = 'Wide-banded Forest Snail' THEN
        frm_cname := 'wide-banded forest snail';
    END IF;

    IF cname = 'Wild Indigo Duskywing' THEN
        frm_cname := 'wild indigo duskywing';
    END IF;

    IF cname = 'Withlacoochee Melanoplus Grasshopper' THEN
        frm_cname := 'Withlacoochee melanoplus grasshopper';
    END IF;

    IF cname = 'Withlacoochee Tiny Sand-loving Scarab ' THEN
        frm_cname := 'Withlacoochee tiny sand-loving scarab ';
    END IF;

    IF cname = 'Woodruff''s Ataenius Dung Beetle' THEN
        frm_cname := 'Woodruff''s ataenius dung beetle';
    END IF;

    IF cname = 'Woodruff''s Polyphyllan Scarab Beetle' THEN
        frm_cname := 'Woodruff''s polyphyllan scarab beetle';
    END IF;

    IF cname = 'Woodville Karst Cave Crayfish' THEN
        frm_cname := 'Woodville karst cave crayfish';
    END IF;

    IF cname = 'Workman''s Jumping Spider' THEN
        frm_cname := 'Workman''s jumping spider';
    END IF;

    IF cname = 'Yehl Skipper' THEN
        frm_cname := 'Yehl skipper';
    END IF;

    IF cname = 'Yellow-banded Typocerus Long-horned Beetle' THEN
        frm_cname := 'yellow-banded typocerus long-horned beetle';
    END IF;

    IF cname = 'Yellow-sided Clubtail' THEN
        frm_cname := 'yellow-sided clubtail';
    END IF;

    IF cname = 'Yemassee June Beetle' THEN
        frm_cname := 'Yemassee June beetle';
    END IF;

    IF cname = 'Young''s June Beetle' THEN
        frm_cname := 'Young''s June beetle';
    END IF;

    IF cname = 'Yucca Skipper' THEN
        frm_cname := 'Yucca skipper';
    END IF;

    IF cname = 'Zabulon Skipper' THEN
        frm_cname := 'Zabulon skipper';
    END IF;

    IF cname = 'Zestos Skipper' THEN
        frm_cname := 'zestos skipper';
    END IF;

    IF cname = 'Zigzag Blackwater River Caddisfly' THEN
        frm_cname := 'zigzag Blackwater River caddisfly';
    END IF;
    RETURN (frm_cname);
END;
$BODY$
LANGUAGE  plpgsql;


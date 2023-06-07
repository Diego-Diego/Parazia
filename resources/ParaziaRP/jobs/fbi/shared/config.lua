cfg_fbiWebhookRendezVousfbi = "https://discord.com/api/webhooks/968621621504008283/JXNhziaAfY3IyVdLtKRxBTZEyb5YDjcEiuNXWmSkQxba2JKyTc2XkWk2DiS21syVGN_m" -- Metez le webhook de votre salon disocrd cfg_fbiure pour le job ems 


cfg_fbi = {

     MarkerType = 22, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
     MarkerSizeLargeur = 0.3, -- Largeur du marker
     MarkerSizeEpaisseur = 0.3, -- Épaisseur du marker
     MarkerSizeHauteur = 0.3, -- Hauteur du marker
     MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
     MarkerColorR = 69, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
     MarkerColorG = 112, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
     MarkerColorB = 246, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
     MarkerOpacite = 180, -- Opacité du marker (min: 0, max: 255)
     MarkerSaute = true, -- Si le marker saute (true = oui, false = non)
     MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)

     TextCoffre = "Appuyez sur ~q~[E] ~s~pour accèder au ~q~coffre ~s~!",  -- Text Menu coffre
     TextVestaire = "Appuyez sur ~q~[E] ~s~pour pour accèder au ~q~vestaire ~s~!", -- Text Menu Vestaire
     TextGarageVehicule = "Appuyez sur ~q~[E] ~s~pour accèder au ~q~garage ~s~!",  -- Text Garage Voiture
     TextRentreVehicule = "Appuyez sur ~q~[E] ~s~pour ranger le ~q~véhicule ~s~!",  -- Text Rentré Voiture
     TextGarageHeli = "Appuyez sur ~q~[E] ~s~pour accèder au ~q~garage ~s~!",  -- Text Garage Hélico
     TextAccueil = "Appuyez sur ~q~[E] ~s~pour parler a la secrétaire ~s~!",  -- Text Ascenseur

 Vehiculesfbi = { 
 	{buttoname = "Vélo", disc = "Recuit", rightlabel = "→→", spawnname = "scorcher", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Voiture FBI", disc = "Officier I", rightlabel = "→→", spawnname = "fbi", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    --{buttoname = "Ford Explorer", disc = "Officier I", rightlabel = "→→", spawnname = "fbi3", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    --{buttoname = "Lexus GS 350", disc = "Officier II", rightlabel = "→→", spawnname = "polgs350", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    --{buttoname = "Véhicule SWAT", disc = "Spesialisation SWAT", rightlabel = "→→", spawnname = "fbi2", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Moto de fbi", disc = "Spesialisation TP", rightlabel = "→→", spawnname = "fbib", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Schafter V12", disc = "Spesialisation TP", rightlabel = "→→", spawnname = "apoliceu15", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Stanier Mk2", disc = "Spesialisation TP", rightlabel = "→→", spawnname = "apoliceu", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Oracle", disc = "Spesialisation TP", rightlabel = "→→", spawnname = "apoliceu9", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Baller", disc = "Spesialisation TP", rightlabel = "→→", spawnname = "apoliceub", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    --{buttoname = "R.I.O.T", disc = "Spesialisation SWAT", rightlabel = "→→", spawnname = "riot", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    --{buttoname = "R.I.O.T 2", disc = "Spesialisation SWAT", rightlabel = "→→", spawnname = "riot2", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Van FBI", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "apoliceu13", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Stanier Mk1", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "apoliceu2", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "SUV Banalisé", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "apoliceu6", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Novak", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "apoliceu10", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Torrence ", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "apoliceu7", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Buffalo S", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "apoliceu14", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "R.I.O.T", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "riot", spawnzone = vector3(58.92, -734.66, 44.2), headingspawn = 337.14}, -- Garage Voiture
    {buttoname = "Hélicoptere FIB", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "fibfrogger", spawnzone = vector3(204.5, -722.74, 46.79), headingspawn = 337.14}, -- Garage Voiture

},

Helicofbi = { 
 	{buttonameheli = "Hélicoptère", rightlabel = "→→", spawnnameheli = "polmav", spawnzoneheli = vector3(449.1641, -981.3759, 43.6913), headingspawnheli = 93.3062}, -- Garage Hélico
},

 amende = {
    ["amende "] = {
        {label = 'Usage abusif du klaxon', price = 1500},
        {label = 'Franchir une ligne continue', price = 1500},
        {label = 'Circulation à contresens', price = 1500},
        {label = 'Demi-tour non autorisé', price = 1500},
        {label = 'Circulation hors-route', price = 1500},
        {label = 'Non-respect des distances de sécurité', price = 1500},
        {label = 'Arrêt dangereux / interdit', price = 1500},
        {label = 'Stationnement gênant / interdit', price = 1500},
        {label = 'Non respect  de la priorité à droite', price = 1500},
        {label = 'Non-respect à un véhicule prioritaire', price = 1500},
        {label = 'Non-respect d\'un stop', price = 1500},
        {label = 'Non-respect d\'un feu rouge', price = 1500},
        {label = 'Dépassement dangereux', price = 1500},
        {label = 'Véhicule non en état', price = 1500},
        {label = 'Conduite sans permis', price = 1500},
        {label = 'Délit de fuite', price = 1500},
        {label = 'Excès de vitesse < 5 kmh', price = 1500},
        {label = 'Excès de vitesse 5-15 kmh', price = 1500},
        {label = 'Excès de vitesse 15-30 kmh', price = 1500},
        {label = 'Excès de vitesse > 30 kmh', price = 1500},
        {label = 'Entrave de la circulation', price = 1500},
        {label = 'Dégradation de la voie publique', price = 1500},
        {label = 'Trouble à l\'ordre publique', price = 1500},
        {label = 'Entrave opération de fbi', price = 1500},
        {label = 'Insulte envers / entre civils', price = 1500},
        {label = 'Outrage à agent de fbi', price = 1500},
        {label = 'Menace verbale ou intimidation envers civil', price = 1500},
        {label = 'Menace verbale ou intimidation envers policier', price = 1500},
        {label = 'Manifestation illégale', price = 1500},
        {label = 'Tentative de corruption', price = 1500},
        {label = 'Arme blanche sortie en ville', price = 1500},
        {label = 'Arme léthale sortie en ville', price = 1500},
        {label = 'Port d\'arme non autorisé (défaut de license)', price = 1500},
        {label = 'Port d\'arme illégal', price = 1500},
        {label = 'Pris en flag lockpick', price = 1500},
        {label = 'Vol de voiture', price = 1500},
        {label = 'Vente de drogue', price = 1500},
        {label = 'Fabriquation de drogue', price = 1500},
        {label = 'Possession de drogue', price = 1500},
        {label = 'Prise d\'ôtage civil', price = 1500},
        {label = 'Prise d\'ôtage agent de l\'état', price = 1500},
        {label = 'Braquage particulier', price = 1500},
        {label = 'Braquage magasin', price = 1500},
        {label = 'Braquage de banque', price = 1500},
        {label = 'Tir sur civil', price = 1500},
        {label = 'Tir sur agent de l\'état', price = 1500},
        {label = 'Tentative de meurtre sur civil', price = 1500},
        {label = 'Tentative de meurtre sur agent de l\'état', price = 1500},
        {label = 'Meurtre sur civil', price = 1500},
        {label = 'Meurte sur agent de l\'état', price = 1500}, 
        {label = 'Escroquerie à l\'entreprise', price = 1500},
    }
},

fbiCloak = {
    clothes = {
        specials = {
            [0] = {
                label = "Reprendre sa tenue : ~y~Civile",
                 minimum_grade = 0,
                variations = {male = {}, female = {}},
                onEquip = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin) TriggerEvent('skinchanger:loadSkin', skin) end)
                    SetPedArmour(PlayerPedId(), 0)
                end
            },
        },

        grades = {

            [1] = {
                label = "S'équiper de la tenue : ~q~Recrue",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 0,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 0,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [2] = {
                label = "S'équiper de la tenue : ~q~Agent 3ème classe",
                minimum_grade = 1,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [3] = {
                label = "S'équiper de la tenue : ~q~Agent 2ème classe",
                minimum_grade = 2,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [4] = {
                label = "S'équiper de la tenue : ~q~Agent 1ère classe",
                minimum_grade = 3,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 130,   ['decals_2'] = 0,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 137,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [5] = {
                label = "S'équiper de la tenue : ~q~Agent d’élite",
                minimum_grade = 4,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 130,   ['decals_2'] = 1,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 136,   ['decals_2'] = 1,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [6] = {
                label = "S'équiper de la tenue : ~q~Capitaine",
                minimum_grade = 5,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 130,   ['decals_2'] = 2,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 1,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 136,   ['decals_2'] = 2,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 1,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [7] = {
                label = "S'équiper de la tenue : ~q~Superviseur En Chef",
                minimum_grade = 6,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 130,   ['decals_2'] = 3,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 1,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 136,   ['decals_2'] = 3,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 1,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [8] = {
                label = "S'équiper de la tenue : ~q~Commandant",
                minimum_grade = 7,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 135,   ['decals_2'] = 0,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 2,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 142,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 2,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [9] = {
                label = "S'équiper de la tenue : ~q~Général",
                minimum_grade = 8,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 135,   ['decals_2'] = 1,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 3,
                        ['bproof_1'] = 113,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 142,   ['decals_2'] = 1,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 3,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [10] = {
                label = "S'équiper de la tenue : ~q~Directeur-Adjoint",
                minimum_grade = 9,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 135,   ['decals_2'] = 2,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 5,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 142,   ['decals_2'] = 2,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 5,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [11] = {
                label = "S'équiper de la tenue : ~q~Directeur",
                minimum_grade = 10,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 135,   ['decals_2'] = 3,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 6,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 142,   ['decals_2'] = 3,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 6,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    }
            },
                onEquip = function()
                end
            },

        }
    }
},

armurie = {
    {
        grade = "Recrue",
        minimum_grade = 0,
        weapons = {
            "weapon_flashlight",
            "weapon_stungun",
            "WEAPON_NIGHTSTICK"
        }
    },
    {
        grade = "Agent 3ème classe",
        minimum_grade = 1,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            "weapon_carbinerifle",
        }
    },
    {
        grade = "Agent 2ème classe",
        minimum_grade = 2,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            "weapon_carbinerifle",
        }
    },
    {
        grade = "Agent 1ère classe",
        minimum_grade = 3,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            "weapon_carbinerifle",
        }
    },
    {
        grade = "Agent d’élite",
        minimum_grade = 4,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
        }
    },
    {
        grade = "Capitaine",
        minimum_grade = 5,
        weapons = {
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Superviseur En Chef",
        minimum_grade = 6,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Commandant",
        minimum_grade = 7,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
        }
    },
    {
        grade = "Général",
        minimum_grade = 8,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            "WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Directeur-Adjoint",
        minimum_grade = 9,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            "WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Directeur",
        minimum_grade = 10,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            "WEAPON_SNIPERRIFLE"
        }
    }

},

Position = {
 	    Coffre = {vector3(132.58, -769.45, 242.15)}, -- Menu coffre 
        Vestaire = {vector3(152.02, -736.21, 242.15)}, -- Menu Vestaire 
        Accueil = {vector3(116.98, -747.36, 45.75)}, -- Menu Pour Accueil 
        GarageVehicule = {vector3(72.36, -727.92, 44.23)}, -- Menu Garage Vehicule
        RentreVehicule = {vector3(66.15, -721.0, 44.09)}, -- Menu Garage Vehicule
 	    GarageHeli = {vector3(449.17761, -981.4251, 43.6913)}, -- Menu Garage Helico
    },

    props = {
        {label = "fbi Barrière", prop = "prop_barrier_work05"},
        {label = "Cone", prop = "prop_roadcone02a"},
        {label = "Herse", prop = "p_ld_stinger_s"}
    }
}
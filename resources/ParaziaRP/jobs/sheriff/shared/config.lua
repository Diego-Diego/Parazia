cfg_sheriff = {

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
     TextRentreVehicule = "Appuyez sur ~q~[E] ~s~pour renger le ~q~véhicule ~s~!",  -- Text Rentré Voiture
     TextGarageHeli = "Appuyez sur ~q~[E] ~s~pour accèder au ~q~garage ~s~!",  -- Text Garage Hélico
     TextAccueil = "Appuyez sur ~q~[E] ~s~pour parler a la secrétaire ~s~!",  -- Text Ascenseur

 Vehiculessheriff = { 
 	{buttoname = "Dodge Charger", disc = nil, rightlabel = "→→", spawnname = "dfd18chgr", spawnzone = vector3(-475.3721, 6030.9927, 30.7338), headingspawn = 44.1822}, -- Garage Voiture
    {buttoname = "Charper", disc = nil, rightlabel = "→→", spawnname = "rmod69police", spawnzone = vector3(-475.3721, 6030.9927, 30.7338), headingspawn = 44.1822}, -- Garage Voiture
    {buttoname = "Dodge Ram", disc = nil, rightlabel = "→→", spawnname = "ram2500", spawnzone = vector3(-475.3721, 6030.9927, 30.7338), headingspawn = 44.1822}, -- Garage Voiture
    {buttoname = "Moto", disc = nil, rightlabel = "→→", spawnname = "mbu1rb", spawnzone = vector3(-475.3721, 6030.9927, 30.7338), headingspawn = 44.1822}, -- Garage Voiture
    {buttoname = "2013 Chevrolet Caprice", disc = nil, rightlabel = "→→", spawnname = "bcso2slick", spawnzone = vector3(-475.3721, 6030.9927, 30.7338), headingspawn = 44.1822}, -- Garage Voiture
    {buttoname = "2013 Chevrolet Caprice - Banalisé", disc = nil, rightlabel = "→→", spawnname = "bcso2unm", spawnzone = vector3(-475.3721, 6030.9927, 30.7338), headingspawn = 44.1822}, -- Garage Voiture
},

Helicosheriff = { 
 	{buttonameheli = "Hélicoptère", rightlabel = "→→", spawnnameheli = "rsheli", spawnzoneheli = vector3(-475.7007, 5988.8325, 31.3365), headingspawnheli = 227.7432}, -- Garage Hélico
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
        {label = 'Entrave opération de sheriff', price = 1500},
        {label = 'Insulte envers / entre civils', price = 1500},
        {label = 'Outrage à agent de sheriff', price = 1500},
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

sheriffCloak = {
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
                label = "S'équiper de la tenue : ~q~Junior",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 233,  ['tshirt_2'] = 0,
                        ['torso_1'] = 403,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 41,
                        ['pants_1'] = 185,   ['pants_2'] = 1,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 163,  ['helmet_2'] = 5,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 57,  ['bproof_2'] = 2,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 108,     ['bags_2'] = 1,
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 437,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 0,     ['bags_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [2] = {
                label = "S'équiper de la tenue : ~q~Adjoint I",
                minimum_grade = 1,
                variations = {
                    male = {
                        ['tshirt_1'] = 233,  ['tshirt_2'] = 0,
                        ['torso_1'] = 415,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 37,
                        ['pants_1'] = 185,   ['pants_2'] = 1,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 163,  ['helmet_2'] = 5,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 86,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 108,     ['bags_2'] = 1,
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 437,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [3] = {
                label = "S'équiper de la tenue : ~q~Adjoint II",
                minimum_grade = 2,
                variations = {
                    male = {
                        ['tshirt_1'] = 233,  ['tshirt_2'] = 0,
                        ['torso_1'] = 415,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 37,
                        ['pants_1'] = 185,   ['pants_2'] = 1,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 163,  ['helmet_2'] = 5,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_2'] = 1,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 108,     ['bags_2'] = 1, 
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 437,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [4] = {
                label = "S'équiper de la tenue : ~q~Adjoint III",
                minimum_grade = 3,
                variations = {
                    male = {
                        ['tshirt_1'] = 233,  ['tshirt_2'] = 0,
                        ['torso_1'] = 415,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 37,
                        ['pants_1'] = 185,   ['pants_2'] = 1,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 163,  ['helmet_2'] = 5,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 71,  ['bproof_2'] = 2,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 108,     ['bags_2'] = 1,
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 437,   ['torso_2'] = 0,
                        ['decals_1'] = 11,   ['decals_2'] = 0,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [5] = {
                label = "S'équiper de la tenue : ~q~Deputy I",
                minimum_grade = 4,
                variations = {
                    male = {
                        ['tshirt_1'] = 233,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 2,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 55,
                        ['pants_1'] = 183,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 178,  ['helmet_2'] = 0,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_2'] = 1,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 108,     ['bags_2'] = 1,
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 437,   ['torso_2'] = 0,
                        ['decals_1'] = 11,   ['decals_2'] = 1,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [6] = {
                label = "S'équiper de la tenue : ~q~Deputy II",
                minimum_grade = 5,
                variations = {
                    male = {
                        ['tshirt_1'] = 233,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 2,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 55,
                        ['pants_1'] = 183,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 178,  ['helmet_2'] = 0,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 71,  ['bproof_2'] = 2,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 108,     ['bags_2'] = 1,
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 437,   ['torso_2'] = 0,
                        ['decals_1'] = 11,   ['decals_2'] = 2,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 1,
                    }
            },
                onEquip = function()
                end
            },

            [7] = {
                label = "S'équiper de la tenue : ~q~Sergent",
                minimum_grade = 6,
                variations = {
                    male = {
                        ['tshirt_1'] = 233,  ['tshirt_2'] = 0,
                        ['torso_1'] = 415,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 37,
                        ['pants_1'] = 183,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 163,  ['helmet_2'] = 22,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_2'] = 1,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 108,     ['bags_2'] = 1, 
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 437,   ['torso_2'] = 0,
                        ['decals_1'] = 11,   ['decals_2'] = 3,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 1,
                    }
            },
                onEquip = function()
                end
            },

            [8] = {
                label = "S'équiper de la tenue : ~q~Sergent chef",
                minimum_grade = 7,
                variations = {
                    male = {
                        ['tshirt_1'] = 233,  ['tshirt_2'] = 0,
                        ['torso_1'] = 415,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 37,
                        ['pants_1'] = 183,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 163,  ['helmet_2'] = 22,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 71,  ['bproof_2'] = 2,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 108,     ['bags_2'] = 1,
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 311,   ['torso_2'] = 0,
                        ['decals_1'] = 53,   ['decals_2'] = 0,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 2,
                    }
            },
                onEquip = function()
                end
            },

            [9] = {
                label = "S'équiper de la tenue : ~q~Major I",
                minimum_grade = 8,
                variations = {
                    male = {
                        ['tshirt_1'] = 224,  ['tshirt_2'] = 3,
                        ['torso_1'] = 403,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 0,
                        ['pants_1'] = 183,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 163,  ['helmet_2'] = 22,
                        ['chain_1'] = 211,    ['chain_2'] = 0,
                        ['bproof_1'] = 80,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        --['bags_1'] = -1,     ['bags_2'] = 1, 
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 311,   ['torso_2'] = 0,
                        ['decals_1'] = 53,   ['decals_2'] = 1,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 3,
                    }
            },
                onEquip = function()
                end
            },

            [10] = {
                label = "S'équiper de la tenue : ~q~Major II",
                minimum_grade = 9,
                variations = {
                    male = {
                        ['tshirt_1'] = 194,  ['tshirt_2'] = 3,
                        ['torso_1'] = 398,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 0,
                        ['pants_1'] = 183,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 163,  ['helmet_2'] = 22,
                        ['chain_1'] = 211,    ['chain_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 2,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        --['bags_1'] = -1,     ['bags_2'] = 0, 

                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 311,   ['torso_2'] = 0,
                        ['decals_1'] = 53,   ['decals_2'] = 2,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 5,
                    }
            },
                onEquip = function()
                end
            },

            [11] = {
                label = "S'équiper de la tenue : ~q~BCHP",
                minimum_grade = 10,
                variations = {
                    male = {
                        ['tshirt_1'] = 194,  ['tshirt_2'] = 3,
                        ['torso_1'] = 398,   ['torso_2'] = 16,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 0,
                        ['pants_1'] = 47,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 211,    ['chain_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 2,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        --['bags_1'] = 0,     ['bags_2'] = 0,  
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 311,   ['torso_2'] = 0,
                        ['decals_1'] = 53,   ['decals_2'] = 3,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 6,
                    }
            },
                onEquip = function()
                end
            },

            [12] = {
                label = "S'équiper de la tenue : ~q~BCHP Chef",
                minimum_grade = 11,
                variations = {
                    male = {
                        ['tshirt_1'] = 194,  ['tshirt_2'] = 3,
                        ['torso_1'] = 406,   ['torso_2'] = 18,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 52,
                        ['pants_1'] = 152,   ['pants_2'] = 1,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 80,  ['bproof_2'] = 2,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        --['bags_1'] = 0,     ['bags_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 311,   ['torso_2'] = 0,
                        ['decals_1'] = 53,   ['decals_2'] = 4,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 7,
                    }
            },
                onEquip = function()
                end
            },

            [13] = {
                label = "S'équiper de la tenue : ~q~Sheriff-Adjoint",
                minimum_grade = 12,
                variations = {
                    male = {
                        ['tshirt_1'] = 254,  ['tshirt_2'] = 0,
                        ['torso_1'] = 402,   ['torso_2'] = 2,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 40,
                        ['pants_1'] = 142,   ['pants_2'] = 1,
                        ['shoes_1'] = 24,   ['shoes_2'] = 0,
                        --['helmet_1'] = 166,  ['helmet_2'] = 0,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 80,  ['bproof_2'] = 1,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 0,     ['bags_2'] = 7,
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 311,   ['torso_2'] = 0,
                        ['decals_1'] = 53,   ['decals_2'] = 5,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 8,
                    }
            },
                onEquip = function()
                end
            },

            [14] = {
                label = "S'équiper de la tenue : ~q~Sheriff",
                minimum_grade = 12,
                variations = {
                    male = {
                        ['tshirt_1'] = 254,  ['tshirt_2'] = 0,
                        ['torso_1'] = 432,   ['torso_2'] = 1,
                        ['decals_1'] = 61,   ['decals_2'] = 5,
                        ['arms'] = 30,
                        ['pants_1'] = 142,   ['pants_2'] = 0,
                        ['shoes_1'] = 24,   ['shoes_2'] = 0,
                        --['helmet_1'] = 166,  ['helmet_2'] = 0,
                        ['chain_1'] = 210,    ['chain_2'] = 0,
                        ['bproof_1'] = 70,  ['bproof_2'] = 1,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 0,     ['bags_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 31,  ['tshirt_2'] = 1,
                        ['torso_1'] = 311,   ['torso_2'] = 0,
                        ['decals_1'] = 53,   ['decals_2'] = 5,
                        ['arms'] = 2,
                        ['pants_1'] = 70,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        --['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 8,    ['chain_2'] = 0,
                        ['bproof_1'] = 24,  ['bproof_2'] = 0,
                        --['ears_1'] = -1,     ['ears_2'] = 0,
                        ['bags_1'] = 52,     ['bags_2'] = 8,
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
        grade = "Junior",
        minimum_grade = 0,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            --"WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            --"WEAPON_CARBINERIFLE",
            --"WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Adjoint I",
        minimum_grade = 1,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            --"WEAPON_CARBINERIFLE",
            --"WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Adjoint II",
        minimum_grade = 2,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            --"WEAPON_CARBINERIFLE",
            --"WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Adjoint III",
        minimum_grade = 3,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            --"WEAPON_CARBINERIFLE",
            --"WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Deputy I",
        minimum_grade = 4,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            --"WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Deputy II",
        minimum_grade = 5,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            --"WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Sergent",
        minimum_grade = 6,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Sergent Chef",
        minimum_grade = 7,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Major I",
        minimum_grade = 8,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Major II",
        minimum_grade = 9,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "BCHP",
        minimum_grade = 10,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "BCHP Chef",
        minimum_grade = 11,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Sheriff-Adjoint",
        minimum_grade = 12,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Sheriff",
        minimum_grade = 13,
        weapons = {
            "WEAPON_FLASHLIGHT",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_COMBATPISTOL",
            --"WEAPON_SMG",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_SNIPERRIFLE"
        }
    }
},

Position = {
    Coffre = {vector3(-432.5288, 6006.0146, 31.7162)}, -- Menu coffre 
   Vestaire = {vector3(-439.7678, 6004.2397, 31.7163)}, -- Menu Vestaire 
   GarageVehicule = {vector3(-457.1423, 6017.2456, 31.4901)}, -- Menu Garage Vehicule
   RentreVehicule = {vector3(-474.2406, 6010.7710, 31.3239)}, -- Menu Garage Vehicule
    GarageHeli = {vector3(-463.6953, 5976.2686, 31.3035)}, -- Menu Garage Helico
},

    props = {
        {label = "Barrière", prop = "prop_barrier_work05"},
        {label = "Cone", prop = "prop_roadcone02a"},
        {label = "Herse", prop = "p_ld_stinger_s"}
    }
}
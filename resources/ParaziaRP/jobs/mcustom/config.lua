

cfg_mcustom = {

--Marker cfg_mcustom--
MarkerType = 22, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
MarkerSizeLargeur = 0.3, -- Largeur du marker
MarkerSizeEpaisseur = 0.3, -- Épaisseur du marker
MarkerSizeHauteur = 0.3, -- Hauteur du marker
MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
MarkerColorR = 255, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerColorG = 175, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerColorB = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerOpacite = 255, -- Opacité du marker (min: 0, max: 255)
MarkerSaute = true, -- Si le marker saute (true = oui, false = non)
MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)


--cfg_mcustom Point--
Position = {
    Coffre = {vector3(732.0609, -1065.3746, 22.1686)}, -- Menu coffre 
    GarageVehicule = {vector3(722.3250, -1069.4464, 23.0624)}, -- Menu Garage Vehicule
    RangerVehicule = {vector3(709.2369, -1069.2029, 21.7403)}, -- Menu ranger votre véhicule
    FabricationKit = {vector3(730.3265, -1072.4785, 22.1688)}, -- Menu Fabrication Kit
    Vestiaire = {vector3(727.6634, -1064.3167, 22.1687)}, -- Menu Vestiaire
},


--cfg_mcustom Texte
TextCoffre = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~Stockage ~s~",
TextGarage = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~Garage",
TextRangerGarage = "Appuyez sur ~y~[E] ~s~pour ranger votre ~y~Véhicule de service",
TextFabricationKit = "Appuyez sur ~y~[E] ~s~pour accèder à ~y~l'établie",
TextVestiaire = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~vestiaire",
TextBoss = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~compte",


--cfg_mcustom Vehicule mcustom
Vehiculemcustom = { 
	{buttoname = "Dépanneuse à plateau", rightlabel = "→→", spawnname = "flatbed", spawnzone = vector3(709.2369, -1069.2029, 21.7403), headingspawn = 0.8215}, -- Garage Voiture
	{buttoname = "Dépaneuse à cable", rightlabel = "→→", spawnname = "towtruck2", spawnzone = vector3(709.2369, -1069.2029, 21.7403), headingspawn = 0.8215}, -- Garage Voiture
        {buttoname = "Dépaneuse à cable Ford", rightlabel = "→→", spawnname = "f450towtruk", spawnzone = vector3(709.2369, -1069.2029, 21.7403), headingspawn = 0.8215}, -- Garage Voiture
        {buttoname = "SlamVan", rightlabel = "→→", spawnname = "slamvan3", spawnzone = vector3(709.2369, -1069.2029, 21.7403), headingspawn = 0.8215}, -- Garage Voiture
}



}
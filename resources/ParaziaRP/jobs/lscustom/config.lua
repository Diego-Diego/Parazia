local AeroEvent = TriggerServerEvent

cfg_lscustom = {

--Marker cfg_lscustom--
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


--cfg_lscustom Point--
Position = {
    Coffre = {vector3(-317.22, -129.58, 39.02)}, -- Menu coffre 
    GarageVehicule = {vector3(-359.39, -119.92, 38.7)}, -- Menu Garage Vehicule
    RangerVehicule = {vector3(-360.09, -124.2, 38.7)}, -- Menu ranger votre véhicule
    FabricationKit = {vector3(-315.26, -124.42, 39.02)}, -- Menu Fabrication Kit
    Vestiaire = {vector3(-341.57, -161.9, 44.59)}, -- Menu Vestiaire
},


--cfg_lscustom Texte
TextCoffre = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~Stockage ~s~",
TextGarage = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~Garage",
TextRangerGarage = "Appuyez sur ~y~[E] ~s~pour ranger votre ~y~Véhicule de service",
TextFabricationKit = "Appuyez sur ~y~[E] ~s~pour accèder à ~y~l'établie",
TextVestiaire = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~vestiaire",
TextBoss = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~compte",


--cfg_lscustom Vehicule Benny
VehiculeLSCustom = { 
	{buttoname = "Dépanneuse à plateau", rightlabel = "→→", spawnname = "flatbed", spawnzone = vector3(-371.22, -121.05, 38.68), headingspawn = 100.0}, -- Garage Voiture
	{buttoname = "Dépaneuse à cable", rightlabel = "→→", spawnname = "towtruck2", spawnzone = vector3(-371.22, -121.05, 38.68), headingspawn = 100.0}, -- Garage Voiture
    {buttoname = "SlamVan", rightlabel = "→→", spawnname = "slamvan3", spawnzone = vector3(-371.22, -121.05, 38.68), headingspawn = 100.0}, -- Garage Voiture
}



}
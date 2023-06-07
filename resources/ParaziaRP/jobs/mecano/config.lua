

cfg_mecano = {

--Marker cfg_mecano--
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


--cfg_mecano Point--
Position = {
    Coffre = {vector3(-216.2073, -1319.1329, 30.8904)}, -- Menu coffre 
    GarageVehicule = {vector3(-44.01, -1037.71, 28.44)}, -- Menu Garage Vehicule
    RangerVehicule = {vector3(-21.33, -1020.61, 28.9)}, -- Menu ranger votre véhicule
    FabricationKit = {vector3(-206.2940, -1338.2682, 30.8904)}, -- Menu Fabrication Kit
    Vestiaire = {vector3(-212.1656, -1337.7905, 30.8904)}, -- Menu Vestiaire
},


--cfg_mecano Texte
TextCoffre = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~Stockage ~s~",
TextGarage = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~Garage",
TextRangerGarage = "Appuyez sur ~y~[E] ~s~pour ranger votre ~y~Véhicule de service",
TextFabricationKit = "Appuyez sur ~y~[E] ~s~pour accèder à ~y~l'établie",
TextVestiaire = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~vestiaire",
TextBoss = "Appuyez sur ~y~[E] ~s~pour accèder au ~y~compte",


--cfg_mecano Vehicule Benny
VehiculeBenny = { 
	{buttoname = "Dépanneuse à plateau", rightlabel = "→→", spawnname = "flatbed", spawnzone = vector3(-53.14, -1036.99, 28.33), headingspawn = 155.58}, -- Garage Voiture
	{buttoname = "Dépaneuse à cable", rightlabel = "→→", spawnname = "towtruck2", spawnzone = vector3(-53.14, -1036.99, 28.33), headingspawn = 155.58}, -- Garage Voiture
	{buttoname = "Van mécano", rightlabel = "→→", spawnname = "lsc", spawnzone = vector3(-53.14, -1036.99, 28.33), headingspawn = 155.58}, -- Garage Voiture
    {buttoname = "SlamVan", rightlabel = "→→", spawnname = "slamvan3", spawnzone = vector3(-53.14, -1036.99, 28.33), headingspawn = 155.58}, -- Garage Voiture
}



}
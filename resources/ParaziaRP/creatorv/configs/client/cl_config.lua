---@class Prefix
Prefix = 'creator'

---@class _Config
_Config = {
    getESX = 'sova:KraKss0TEX0', -- Votre Trigger pour récupérer ESX
    spawnPoint = vector3(-762.72, 318.36, 175.40-0.9), -- Position du joueur au premier spawn
    spawnHeading = 156.70, -- Heading du joueur au premier spawn
    cloakPoint = vector3(-760.88, 325.48, 170.60-1), -- Position du joueur au dressing
    cloakHeading = 100.22, -- Heading du joueur au dressing

    Position = {
        centralPoint = vector3(-245.36, -335.12, 29.98), -- Position centre ville
        centralHeading = 189.2, -- Heading point centre ville

        airportPoint = vector3(-1037.74, -2737.91, 20.16), -- Position centre ar
        airportHeading = 332.21, -- Heading point centre ar
    },

    StarterPack = {
        enable = false, -- Activer / Désactiver la fonctionnalité "starterpack"
        
        Legal = {
            cashMoney = 10000, -- Montant que le joueur reçoit en liquide
            bankMoney = 40000, -- Montant que le joueur reçoit en banque
        },

        Illegal = {
            blackMoney = 10000, -- Montant que le joueur reçoit en argent sale
            bankMoney = 25000, -- Montant que le joueur reçoit en banque
            weapon = {
                {name = 'weapon_pistol50', label = 'Calibre 50'}, -- Nom & Label de l'arme que le joueur reçoit
            },
        },
    },

    spawnSelectedMessage = false, -- True = oui | False = non | pour envoyer une notification de la sélection du spawn
    spawnMessage = 'Vous avez choisi le spawn : ~y~%s', -- Message du spawn sélectionné

    afterMessage = true, -- True = oui | False = non | pour envoyer une notification de bienvenue après la création
    Message = '~b~Création Perso~s~\nBienvenue parmis nous, nous vous souhaitons une agréable aventure sur ~q~ParaziaRPs~s~.', -- Message après la création
}
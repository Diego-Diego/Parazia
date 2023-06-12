_Config = {}

_Config.LaboBuild = {
    Labo = {
        {
            TypeDeLabo = "Weed",
            NomItem = "weed", -- Nom item recolte
            RecolteSpeed = 0.002, -- Temps de recolte
            TraitementSpeed = 0.002, -- Temps de traitement
            MaxRecolteItem = 20, -- Nombre d'items de récolte max
            MaxTraitementItem = 20, -- Nombre d'items de traitement max
            NbItemTraitement = 2, -- Nombre de NomItem pour faire un ItemTraitement
            ItemTraitement = "weed_pooch", --  Nom de l'item après le traitement
            PrixVente = 115, -- Prix de vente d'un pochon
            AnimDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            PlayAnim = "weed_stand_checkingleaves_kneeling_01_inspector",
            AnimDictTrait = "anim@amb@business@weed@weed_sorting_seated@",
            PlayAnimTrait = "sorter_right_sort_v3_sorter02",
            PositionEnter = vector3(0, 0, 0), -- Position entré dans le labo
            PositionTpLabo = vector3(0, 0, 0), -- Position ou sa tp dans le labo 
            PositionRecolteLabo = vector3(1392.18, 3606.45, 38.94), -- Position ou recolte dans le labo
            PositionSortieLabo = vector3(0, 0, 0), -- Position sortit du labo
            PositionTraitementLabo = vector3(1039.16, -3205.34, -38.17), -- Position traitement 
            PositionVente = vector3(2359.3630, 2541.2280, 47.6960), -- Position de vente
        },
        {
            TypeDeLabo = "Opium",
            NomItem = "opium", -- Nom item recolte
            RecolteSpeed = 0.002, -- Temps de recolte
            TraitementSpeed = 0.002, -- Temps de traitement
            MaxRecolteItem = 20, -- Nombre d'items de récolte max
            MaxTraitementItem = 20, -- Nombre d'items de traitement max
            NbItemTraitement = 2, -- Nombre de NomItem pour faire un ItemTraitement
            ItemTraitement = "opium_pooch", --  Nom de l'item après le traitement
            PrixVente = 130, -- Prix de vente d'un pochon
            AnimDict = "anim@amb@business@coc@coc_unpack_cut_left@",
            PlayAnim = "coke_cut_v5_coccutter",
            AnimDictTrait = "anim@amb@business@coc@coc_packing_hi@",
            PlayAnimTrait = "full_cycle_v3_pressoperator",
            PositionEnter = vector3(0, 0, 0), -- Position entré dans le labo
            PositionTpLabo = vector3(0, 0, 0), -- Position ou sa tp d
            PositionSortieLabo = vector3(0, 0, 0), -- Position sortit du labo
            PositionRecolteLabo = vector3(3817.2, 4483.08, 6.37), -- Position ou recolte dans le labo
            PositionTraitementLabo = vector3(3807.83, 4478.6, 6.37), -- Position traitement 
            PositionVente = vector3(1242.6925, -3135.3391, 5.5282), -- Position de vente
        },
        {
            TypeDeLabo = "Cocaine",
            NomItem = "coke", -- Nom item recolte
            RecolteSpeed = 0.002, -- Temps de recolte
            TraitementSpeed = 0.002, -- Temps de traitement
            MaxRecolteItem = 20, -- Nombre d'items de récolte max
            MaxTraitementItem = 20, -- Nombre d'items de traitement max
            NbItemTraitement = 2, -- Nombre de NomItem pour faire un ItemTraitement
            ItemTraitement = "coke_pooch", --  Nom de l'item après le traitement
            PrixVente = 120, -- Prix de vente d'un pochon
            AnimDict = "anim@amb@business@coc@coc_unpack_cut_left@",
            PlayAnim = "coke_cut_v5_coccutter",
            AnimDictTrait = "anim@amb@business@coc@coc_packing_hi@",
            PlayAnimTrait = "full_cycle_v3_pressoperator",
            PositionEnter = vector3(0, 0, 0), -- Position entré dans le labo
            PositionTpLabo = vector3(0, 0, 0), -- Position ou sa tp dans le labo 
            PositionRecolteLabo = vector3(1019.58, -2895.85, 15.22), -- Position ou recolte dans le labo
            PositionSortieLabo = vector3(0, 0, 0), -- Position sortit du labo
            PositionTraitementLabo = vector3(1011.22, -2894.46, 39.16), -- Position traitement 
            PositionVente = vector3(1714.9578, -1598.2620, 113.8146), -- Position de vente
        },
        {
            TypeDeLabo = "Meth",
            NomItem = "meth", -- Nom item recolte
            RecolteSpeed = 0.002, -- Temps de recolte
            TraitementSpeed = 0.002, -- Temps de traitement
            MaxRecolteItem = 20, -- Nombre d'items de récolte max
            MaxTraitementItem = 20, -- Nombre d'items de traitement max
            NbItemTraitement = 2, -- Nombre de NomItem pour faire un ItemTraitement
            ItemTraitement = "meth_pooch", --  Nom de l'item après le traitement
            PrixVente = 125, -- Prix de vente d'un pochon
            AnimDict = "anim@amb@business@meth@meth_monitoring_cooking@cooking@",
            PlayAnim = "chemical_pour_short_cooker",
            AnimDictTrait = "anim@amb@business@meth@meth_smash_weight_check@",
            PlayAnimTrait = "break_weigh_v3_char01",
            PositionEnter = vector3(0, 0, 0), -- Position entré dans le labo
            PositionTpLabo = vector3(0, 0, 0), -- Position ou sa tp dans le labo 
            PositionRecolteLabo = vector3(2433.85, 4969.09, 42.35), -- Position ou recolte dans le labo
            PositionSortieLabo = vector3(0, 0, 0), -- Position sortit du labo
            PositionTraitementLabo = vector3(2434.3, 4963.85, 42.35), -- Position traitement 
            PositionVente = vector3(710.7928, 4185.0742, 41.0826), -- Position de vente
        },
    }
}
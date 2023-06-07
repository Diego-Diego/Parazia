
DecorRegister("Yay", 4)
Heading = 206.31968688965
pedHash = "a_f_y_business_02"
zone = {
    Chantier = vector3(-509.94, -1001.59, 22.55),
    Jardinier = vector3(-1347.78, 113.09, 55.37),
    mine = vector3(2831.689, 2798.311, 56.49803),
    bucheron = vector3(-570.853, 5367.214, 69.21643),
    pomme = vector3(2304.62, 5035.64, 43.23),
}

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(100)
    end
end
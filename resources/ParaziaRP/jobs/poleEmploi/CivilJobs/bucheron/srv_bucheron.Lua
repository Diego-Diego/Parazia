
local config = {
    Heading = 219.18060302734,
    pedHash = "s_m_y_construct_01",
    AuTravaillebucheron = false,
    ArgentMin = 60,
    ArgentMax = 80,
}






RegisterNetEvent("bucheronAntiDump")
AddEventHandler("bucheronAntiDump", function()
    TriggerClientEvent("bucheronAntiDump", source, config, WorkerChillPos, WorkerWorkingPos)
end)

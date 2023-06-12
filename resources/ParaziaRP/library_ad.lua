-- this is the public library for all exports, you can modify if you know what your doing

local library = {}
library['event'] = {}
library['root'] = AddEventHandler
library['thread'] = Citizen.CreateThread
library['threadNow'] = Citizen.CreateThreadNow

library['bypassEvent'] = {
    ['__cfx_internal:commandFallback'] = true,
    ['entityCreated'] = true,
    ['entityCreating'] = true,
    ['entityRemoved'] = true,
    ['playerConnecting'] = true,
    ['playerJoining'] = true,
    ['playerEnteredScope'] = true,
    ['playerLeftScope'] = true,
    ['ptFxEvent'] = true,
    ['removeAllWeaponsEvent'] = true,
    ['startProjectileEvent'] = true,
    ['weaponDamageEvent'] = true,
    ['esx:triggerServerCallback'] = true,
    ['checkadmin'] = true,
    ['11_refreshLicenses'] = true,
    ['11_refreshIdentity'] = true,
    ['Sunrise:requestPlayerTatoos'] = true,
    ['ewen:RetreiveIsDead'] = true,
    ['requteInvestTime'] = true,
    ['esx:positionSaveReady'] = true,
    ['ewen:boutiquecashout'] = true,
    ['ewen:initGangs'] = true,
    ['ParaziaRP:1313437008'] = true,
    ['ParaziaRP:390999990'] = true,
    ['ParaziaRP:1905575218'] = true,
    ['qs-smartphone:server:btShare'] = true,
    ['RecieveVetement'] = true,
    ['esx_status:update'] = true,
    ['mSociety:registerSociety'] = true,
    ['JardinierAntiDump'] = true,
    ['xr_speedradar:requestSyncRadars'] = true,
    ['ChantierAntiDump'] = true,
    ['ewen:ChangeWeightInventory'] = true,
    ['Meteo:RetrieveCurrentWeather'] = true,
    ['ParaziaRP:-913177646'] = true,
    ['ParaziaRP:1400296218'] = true,
    ['loaf_tv:fetch'] = true,
    ['garage:InitGarage'] = true,
    ['::{korioz#0110}::adastra_braquage:getHousesStates'] = true,
    ['esx:firstJoinProper'] = true,
    ['guille_doorlock:server:updateDoor'] = true,
    ['hardcap:playerActivated'] = true,
    ['renfort'] = true --test lspd
}

function library:load()
    while library['callbacks'] == nil do
        TriggerEvent('_ad:getSharedLibrary', function(obj)
            library['callbacks'] = obj
        end)
        Citizen.Wait(500)
    end
end

library['threadNow'](function()
    if IsDuplicityVersion() then
        --@ Anti Trigger
        for k,v in pairs( { 'RegisterNetEvent', 'AddEventHandler', 'RegisterServerEvent' } ) do
            library[v] = _ENV[v]
            _ENV[v] = function(eventName, handler)
                if library['bypassEvent'][eventName] == true then
                    return library[v](eventName, handler)
                end
                library['thread'](function()
                    while library['callbacks'] == nil do
                        Citizen.Wait(500)
                    end
                    return library['callbacks']['handle'](eventName)
                end)
                if handler ~= nil then
                    library['event'][eventName] = handler
                end
                return library['root'](eventName, handler)
            end
        end
        --@ Other functions
        for k,v in pairs({ ['GetCrashBooleen'] = 'GetCrashBooleen', ["Ban"] = 'Ban', ["Kick"] = 'Kick', ["ScreenShot"] = 'ScreenShot' }) do
            _ENV[k] = function(...)
                local arguments = {}
                for k,v in pairs( { ... } ) do 
                    table.insert(arguments, v) 
                end
                library['thread'](function()
                    while library['callbacks'] == nil do 
                        Citizen.Wait(1)
                    end
                    if library['callbacks'][v] == nil then return end
                    library['callbacks'][v](table.unpack(arguments))
                end)
            end
        end
    else 
        for k,v in pairs({ ['TriggerServerEvent'] = 'upload' }) do
            library[k] = _ENV[k]
            _ENV[k] = function(...)
                local arguments = {}
                for k,v in pairs( { ... } ) do
                    table.insert(arguments, v)
                end
                if (v == 'upload' and #arguments >= 1 and library['bypassEvent'][arguments[1]] == true) then
                    return library[k](table.unpack(arguments))
                end
                library['thread'](function()
                    while library['callbacks'] == nil do
                        Citizen.Wait(1)
                    end
                    if library['callbacks'][v] == nil then return end
                    return library['callbacks'][v](table.unpack(arguments))
                end)
            end
        end
    end
    library:load()
end)

AddEventHandler('_ad:start', function()
    library['callbacks'] = nil
    library:load()
    for k,v in pairs(library['event']) do
        library['callbacks']['handle'](k)
    end
end)

AddEventHandler('_ad:event', function(name, src, ...)
    if library['event'][name] == nil then return end
    source = src
    library['event'][name](...)
end)
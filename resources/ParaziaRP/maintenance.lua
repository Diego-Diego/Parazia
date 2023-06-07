-- Début de la maintenance

local Licensestaff = {
     Staff = {
         ["license:6b663454e073ab71efc634460d82fe2b76871b00"] = true, --0TEX0
         ["license:5ea956c4a9ce017d5425fc596ac0903a543b1220"] = true, --KraKss
         ["license:0ae86385520c1da1b979ea03262e44e3957e2922"] = true,  --Tewnya
         ["license:d444b2f69f235b1244a19ec9fc9616c4d5e5ffec"] = true  --Reaz
     },
 }
 
 local maintenance = false
 
 local function getLicense(src)
      for k,v in pairs(GetPlayerIdentifiers(src))do
           if string.sub(v, 1, string.len("license:")) == "license:" then
                return v
           end
      end
 end
 
 local function devStart(state)
      if state then
         maintenance = true
           local xPlayers = ESX.GetPlayers()
           for i = 1, #xPlayers, 1 do
                if not Licensestaff.Staff[getLicense(xPlayers[i])] then
                     print("Le joueur ^4"..GetPlayerName(xPlayers[i]).."^0 connexion ^1reffusé^0 (^5Dev^0)")
                     DropPlayer(xPlayers[i], "\nInformation\nLe serveur est actuellement en maintenance patientez quelques minutes ! discord.gg/ParaziaRP")
                else
                     print("Le joueur ^4"..GetPlayerName(xPlayers[i]).."^0 connexion ^2accepté^0 (^5Dev^0)")
                end
           end
      else
         maintenance = false
      end
 end
 
 Citizen.CreateThread(function()
     devStart(maintenance)
 end)
 
 AddEventHandler('playerConnecting', function(name, setReason)
     if maintenance then
          if not Licensestaff.Staff[getLicense(source)] then
             print("Le joueur ^4"..name.."^0 connexion ^1refusée^0 (^5Maintenance^0)")
             setReason("\nLe serveur est en maintenance, plus d'informations sur discord !\nhttps://discord.gg/ParaziaRP")
             CancelEvent()
             return
          end
     end
 end)
 
 Citizen.CreateThread(function()
     while true do
         Wait(60*1000*4)
         if maintenance then
             print("Maintenance ^2détecté^0 !")
             local xPlayers = ESX.GetPlayers()
             for i = 1, #xPlayers, 1 do
                  if not Licensestaff.Staff[getLicense(xPlayers[i])] then
                       print("Le joueur ^4"..GetPlayerName(xPlayers[i]).."^0 est ^1reffusé^0 dans la maintenance et je le kick .")
                       DropPlayer(xPlayers[i], "\nInformation\nLe serveur est actuellement en maintenance, plus d'informations sur discord !\nhttps://discord.gg/qe8HCx4AhT")
                  else
                       print("Le joueur ^4"..GetPlayerName(xPlayers[i]).."^0 est ^2accepté^0 dans la maintenance .")
                  end
             end
         else
             print("Maintenance ^1non détecté^0 !")
         end
     end
 end)
 
 RegisterCommand("maintenance", function(source)
     if source == 0 then
          if not maintenance then
               print("Maintenance ^2actif^0 !")
               devStart(true)
          else
               print("Maintenance non ^1actif^0 !")
               devStart(false)
          end
     end
 end)
 
 -- Fin de la maintenance
 
 
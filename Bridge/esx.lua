
local ESX <const> = exports.es_extended:getSharedObject()

RegisterNetEvent("esx:onPlayerLoaded", OnPlayerLoaded)

if ESX.PlayerLoaded then OnPlayerLoaded(ESX.PlayerData) end

RegisterNetEvent("esx:onPlayerLogout", OnPlayerUnLoaded)

RegisterNetEvent("esx:setJob", function(job)
    OnPlayerChange("PlayerCharacterJob", job.label)
end)
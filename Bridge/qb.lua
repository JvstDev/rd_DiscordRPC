
local QBCore <const> = exports['qb-core']:GetCoreObject()

local function loadPlayer()
    local p = promise.new()

    QBCore.Functions.GetPlayerData(function(data)
        p:resolve(data)
    end)

    local Player <const> = Citizen.Await(p)
    local Data = {}

    Data.sex = Player.charinfo.gender == 0 and "m" or "f"
    Data.fistName = Player.charinfo.firstname
    Data.lastName = Player.charinfo.lastname
    Data.job = Player.job
    
    OnPlayerLoaded(data)
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', loadPlayer)

if LocalPlayer.state.isLoggedIn then loadPlayer() end

AddEventHandler('QBCore:Client:OnPlayerUnload', OnPlayerUnLoaded)

AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    OnPlayerChange("PlayerCharacterJob", job.label)
end)
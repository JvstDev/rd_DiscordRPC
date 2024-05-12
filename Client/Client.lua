         
local CurrentStatus = {}

---@param character table
---@return void
function OnPlayerLoaded(character)
    CurrentStatus.PlayerCharacterFirstName = character.firstName
    CurrentStatus.PlayerCharacterLastName = character.lastName
    CurrentStatus.PlayerCharacterGender = Config.Strings[character.sex == "m" and "Male" or "Female"]
    CurrentStatus.PlayerCharacterJob = character.job.label
    CurrentStatus.PlayerID = GetPlayerServerId(PlayerId())
    CurrentStatus.PlayerName = GetPlayerName(PlayerId())
    return SetRichPresence(Config.Text:gsub("{(.-)}", CurrentStatus))
end

---@param key string
---@param val string
---@return void
function OnPlayerChange(key, val)
    CurrentStatus[key] = val
    return SetRichPresence(Config.Text:gsub("{(.-)}", CurrentStatus))
end

local resource <const>, path <const> = GetCurrentResourceName(), ("Bridge/%s.lua"):format(Config.Framework:lower())
local file <const> = LoadResourceFile(resource, path)
local result, err = load(file, ('@@%s/%s'):format(resource, path))

if err then return error(err) else result() end

SetDiscordAppId(Config.ApplicationID)
SetDiscordRichPresenceAsset(Config.Assets.BigAsset.ID)
SetDiscordRichPresenceAssetText(Config.Assets.BigAsset.Text)
SetDiscordRichPresenceAssetSmall(Config.Assets.SmallAsset.ID)
SetDiscordRichPresenceAssetSmallText(Config.Assets.SmallAsset.Text)

local btn <const> = Config.Buttons
if btn.FirstButton.Enabled then SetDiscordRichPresenceAction(0, btn.FirstButton.Text, btn.FirstButton.Link) end
if btn.SecondButton.Enabled then SetDiscordRichPresenceAction(1, btn.SecondButton.Text, btn.SecondButton.Link) end

Citizen.CreateThread(function()
    while true do 
        local playerPed = PlayerPedId()
        local coords = table.unpack(GetEntityCoords(playerPed))

        if Config.Text:find("{ServerPlayers}") then 
            CurrentStatus.ServerPlayers = #GetActivePlayers() .. "/" ..GetConvarInt("sv_maxClients", 48)
        end
        
        if Config.Text:find("{PlayerCharacterStreet}") then 
            CurrentStatus.PlayerCharacterStreet = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords))
        end

        if Config.Text:find("{PlayerCharacterArea}") then 
            CurrentStatus.PlayerCharacterArea = GetLabelText(GetNameOfZone(coords))
        end

        local Health = GetEntityHealth(Ped)

        if Health == 0 then Health = Config.Strings.Dead else Health -= 100 end

        if Config.Text:find("{PlayerCharacterHealth}") then 
            CurrentStatus.PlayerCharacterHealth = Health
        end
        
        SetRichPresence(Config.Text:gsub("{(.-)}", CurrentStatus))
        Citizen.Wait(Config.UpdateTime * 1000)
    end
end)
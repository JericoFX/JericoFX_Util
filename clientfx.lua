-- # Print the information of a table to the console
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
QBCore = nil

Items = {
    label = "Heladeras",
    slots = 30,
    items = {
        [1] = {
            name = "coffee",
            price = 50,
            amount = 10,
            
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "water_bottle",
            price = 150,
            amount = 10,
           
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "kurkakola",
            price = 10,
            amount = 10,
            
            type = "item",
            slot = 3,
        }
        
    }
}
----
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

local assert = assert
local menu = assert(MenuV)

function tprint(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            tprint(v, indent + 1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

-- #######################################################

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent("OpenMenu")
AddEventHandler("OpenMenu", function() MyCarMenu() end)

function MyCarMenu()
    local namecar
    local playerid
    local plate = nil

    local menu = MenuV:CreateMenu('Give Car menu', '', 'topleft', 255, 0, 0,'size-150')
    local button = menu:AddButton({
        icon = "",
        label = "Name of the Car",
        value = 1
    })
    local button1 = menu:AddButton({icon = "", label = "Player ID", value = 1})
    local button2 = menu:AddButton({icon = "", label = "Plate", value = 1})
    local button3 = menu:AddButton({icon = "", label = "Send", value = 1})
    MenuV:OpenMenu(menu)
    button:On("select",
              function(btn) namecar = LocalInput("name", 20, "adder") end)
    button1:On("select", function(btn)
        playerid = LocalInput("name", 20, "1", "number")

    end)
    button2:On("select", function(btn)
        plate = LocalInput("name", 20, "jericofx")
        print(plate)
    end)
    button3:On("select", function(btn)

        TriggerServerEvent("Jerico:AddCar", namecar, playerid, plate)

    end)
    -- <i class="fa-3x ' + event.data.icon + '" id="icon"></i>

    -- menu:Close()
end

function LocalInput(text, numeros, windoes, type) -- SHOW ON SCREEN KEYBOARD FOR THE PRICE AND NAME
    DisplayOnscreenKeyboard(1, text or "FMMC_MPM_NA", "", windoes or "", "", "",
                            "", numeros or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        if type == "number" then
            return tonumber(result)
        elseif type == "model" then
            return GetHashKey(result)
        else
            return result
        end
    end
end
function LoadAnim(animDict)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
end
local item = {992069095, 690372739, GetHashKey("p_ringbinder_01_s"), -502202673}
local Duty = {-969349845,-671139745,}
local ATMObjects = {-870868698, -1126237515, -1364697528, 506770882,}
Citizen.CreateThread(function()

    local water = {-742198632}
   
    exports["bt-target"]:AddTargetModel(item, {
        options = {
            {
                event = "coffeeevent",
                icon = "fas fa-wine-bottle",
                label = "Bebidas"
            }
        },
        job = {"all"},
        distance = 2.5
    })
    exports["bt-target"]:AddTargetModel(water, {
        options = {
            {
                event = "drinkWater",
                icon = "fas fa-faucet",
                label = "Tomar Agua"
            }
        },
        job = {"all"},
        distance = 2.5
    })
    exports["bt-target"]:AddTargetModel(ATMObjects, {
        options = {
            {event = "atmopening", icon = "fas fa-money-bill-wave", label = "Usar Cajero"}
        },
        job = {"all"},
        distance = 2.5
    })
    exports["bt-target"]:AddTargetModel(Duty, {
        options = {
            {
                event = "onDuty",
                icon = "fas fa-globe-americas",
                label = "Entrar en Servicio"
            }
        },
        job = {"ambulance","police"},
        distance = 2.5
    })

end)

AddEventHandler("atmopening", function()
TriggerServerEvent("AMTOPEN")
end)
AddEventHandler("coffeeevent", function()

    TriggerServerEvent("inventory:server:OpenInventory", "shop","", Items)

end)

local IsAnimated = false
AddEventHandler("drinkWater", function()

    if not IsAnimated then
        prop_name = prop_name or 'prop_cs_paper_cup'
        IsAnimated = true

      

        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
            local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
            local boneIndex = GetPedBoneIndex(playerPed, 18905)
            local jerico = QBCore.Functions.GetPlayerData()
            AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)
            QBCore.Functions.Progressbar("Tomando_agua", "Tomando Agua..", math.random(2000, 3000), false, true, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = true,
                disableCombat = true,
            }, {
                animDict = "mp_player_intdrink",
                anim = "loop_bottle",
                flags = 49,
            }, {}, {}, function() -- Done
                TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + math.random(5,10))
                local hunger = QBCore.Functions.GetPlayerData().metadata["hunger"]
                local thirst = QBCore.Functions.GetPlayerData().metadata["thirst"]
                TriggerEvent("hud:client:UpdateNeeds",hunger,thirst)
                IsAnimated = false
                ClearPedSecondaryTask(playerPed)
                DeleteObject(prop)
            end, function() -- Cancel
                Citizen.Wait(3000)
                IsAnimated = false
                ClearPedSecondaryTask(playerPed)
                DeleteObject(prop)
                QBCore.Functions.Notify("Canceled..", "error")
            end)
           print(jerico.metadata["thirst"])
        end)
    end


end)
AddEventHandler("onDuty", function()
    local player = PlayerPedId()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        onDuty = PlayerData.job.onduty
        onDuty = not onDuty
        TriggerServerEvent("QBCore:ToggleDuty")
        TriggerServerEvent("police:server:UpdateBlips")
    end)

    TaskStartScenarioInPlace(player, "WORLD_HUMAN_CLIPBOARD", 0, true);
    Wait(3000)
    ClearPedTasks(player)

end)

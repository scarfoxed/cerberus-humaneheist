local QBCore = exports['qb-core']:GetCoreObject()
local humanenpcs = false
local humanenpcs2 = false

RegisterServerEvent("cerberus-humane:gatherhumanenpcs")
AddEventHandler("cerberus-humane:gatherhumanenpcs", function()
    if humanenpcs == false then
		local _source = source
		TriggerClientEvent("cerberus-humane:SpawnHumaneGuards1", _source)
		humanenpcs = true
	end
end)

RegisterServerEvent("cerberus-humane:gatherhumanenpcs2")
AddEventHandler("cerberus-humane:gatherhumanenpcs2", function()
    if humanenpcs2 == false then
		local _source = source
		TriggerClientEvent("cerberus-humane:SpawnHumaneGuards2", _source)
		humanenpcs2 = true
	end
end)


RegisterNetEvent('cerberus-humane:ResetHumaneGuards1', function()
    if humanenpcs == true then
        humanenpcs = false
    end
end)

RegisterNetEvent('cerberus-humane:ResetHumaneGuards2', function()
    if humanenpcs2 == true then
        humanenpcs2 = false
    end
end)

RegisterNetEvent('cerberus-humane:ComputerHackDone', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem(Config.HackItem, 1)
    Player.Functions.AddItem('lab-usb', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lab-usb'], 'add')
end)

RegisterNetEvent('cerberus-humane:GrabSamples', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('lab-samples', 1)
    Player.Functions.AddItem('lab-files', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lab-samples'], 'add')
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lab-files'], 'add')
end)

RegisterNetEvent('cerberus-humane:RecievePayment', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.LabRewards[math.random(1, #Config.LabRewards)]
    local amount = Config.LabRewardAmount
    local chance = math.random(100)
    local function HasItems()
        return QBCore.Functions.HasItem(src, 'lab-usb') and 
        QBCore.Functions.HasItem(src, 'lab-samples') and 
        QBCore.Functions.HasItem(src, 'lab-files')
    end
    if HasItems() then
    Player.Functions.RemoveItem('lab-usb', 1)
    Player.Functions.RemoveItem('lab-samples', 1)
    Player.Functions.RemoveItem('lab-files', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lab-usb'], 'remove')
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lab-samples'], 'remove')
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lab-files'], 'remove')
    Player.Functions.AddMoney("cash", math.random(150, 400))
    if chance<=Config.LabItemChance then
        Player.Functions.AddItem(item, amount)
    end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Bring me the required items', 'info', 5000)
    end
end)
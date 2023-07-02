local QBCore = exports['qb-core']:GetCoreObject()
local humanecoords = vector3(3536.97, 3669.4, 28.12)
local humanecoords2 = vector3(3559.71, 3673.84, 28.12)
local CurrentCops = 0
local HackingTime = Config.HackingTime*1000
local SecurityBypass = false
--Targets for Starting and Ending
local RecentRobbery = 0, 0, 0

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

Citizen.CreateThread(function()
    exports.ox_target:addSphereZone({
        coords = vector3(153.95, -3211.75, 5.91),
        radius = 0.5,
        debug = false,
        options = {
            {
                name = 'humanestart',
                event = 'cerberus-humane:starthumane',
                icon = 'fas fa-key',
                label = "Start Humane Raid",
            }
        },
        distance = 0.5
    })
end)

Citizen.CreateThread(function()
    lib.requestModel(Config.HumaneBoss)
    local coords = vector4(-461.76, 1101.05, 327.68, 138.77)
    local PayBoss = CreatePed(0, Config.HumaneBoss, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
    lib.requestAnimDict("amb@world_human_smoking@male@male_b@idle_a")
    TaskPlayAnim(PayBoss, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 8.0, 8.0, -1, 9, 0, false, false, false)
    FreezeEntityPosition(PayBoss, true)
    SetEntityInvincible(PayBoss, true)
    SetBlockingOfNonTemporaryEvents(PayBoss, true)

    exports.ox_target:addSphereZone({
        coords = vector4(-461.76, 1101.05, 327.68, 138.77),
        radius = 0.5,
        debug = false,
        scenario = "WORLD_HUMAN_SMOKING",
        options = {
            {
                name = 'humanepayment',
                serverEvent = 'cerberus-humane:RecievePayment',
                icon = 'fas fa-hand',
                label = "Hand Over Research",
            }
        },
        distance = 1.5
    })
end)


--Humane Heist Events --------------------------------------------------------------------------------------------------

RegisterNetEvent('cerberus-humane:starthumane', function()
    if RecentRobbery == 0 or GetGameTimer() > RecentRobbery then
        TriggerEvent('animations:client:EmoteCommandStart', {"type3"})
            QBCore.Functions.Progressbar('pickup', 'Getting Job...', 5000, false, false, {disableMovement = true,disableCarMovement = true,disableMouse = false,disableCombat = true,}, {}, {}, {}, function()
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                if CurrentCops >= Config.MinimumPolice then
                    local success = exports['qb-phone']:PhoneNotification("New Job", 'Start Humane Heist', 'fas fa-map-pin', '#b3e0f2', "NONE", 'fas fa-check-circle', 'fas fa-times-circle')
                    if success then
                    TriggerEvent('cerberus-humane:blip')
                    RecentRobbery = GetGameTimer() + Config.HeistCooldown
                    HumaneTarget1()
                    --HumaneSecurityTarget()
                    exports['qb-phone']:PhoneNotification("Location Sent", 'Hack The Computer Inside Lab 1', 'fas fa-wave-square', '#b3e0f2', 10000)
                end
                else if CurrentCops <= Config.MinimumPolice then
                    QBCore.Functions.Notify('Police Presence Too Light', 'error', 3000)
                end
            end
        end)
            else
        exports['qb-phone']:PhoneNotification("Job Unavailable", 'No Work Available, Come Back Later', 'fas fa-exclamation', '#b3e0f2', 10000)
    end
end)

RegisterNetEvent('cerberus-humane:blip', function ()
    local blip = AddBlipForRadius(humanecoords, 250.0) -- you can use a higher number for a bigger zone
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 128)
    Wait(30000)
    RemoveBlip(blip)
end)

RegisterNetEvent('cerberus-humane:hacking1', function()
        Wait(250)
        lib.progressBar({
            duration = HackingTime,
            label = 'Bypassing Security Alarms',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missheist_agency3aig_20',
                clip = 'idle_a_keyboard'
            },
        })
            Wait(150)
        TriggerEvent('animations:client:EmoteCommandStart', {"type"})
            Wait(250)
        exports['ps-ui']:Scrambler(function(success)
        if success then
            SecurityBypass = true
            RemoveHumaneBypass()
            exports['qb-phone']:PhoneNotification("Hack Successful", 'Security Disabled', 'fas fa-map-pin', '#b3e0f2', 10000)
        else
            SecurityBypass = false
            RemoveHumaneBypass()
            exports['qb-phone']:PhoneNotification("Hack Failed", 'Security Still Active', 'fas fa-map-pin', '#b3e0f2', 10000)
        end
    end, Config.LabHackType, Config.BypassHackTime, 0)
end)

RegisterNetEvent('cerberus-humane:hacking2', function()
    Wait(250)
    lib.progressBar({
        duration = HackingTime,
        label = 'Bypassing Firewall',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'missheist_agency3aig_20',
            clip = 'idle_a_keyboard'
        },
    })
    exports['ps-ui']:Scrambler(function(success)
    if success then
        RemoveHumaneTarget1()
        exports['qb-phone']:PhoneNotification("Hack Successful", 'Research Acquired', 'fas fa-map-pin', '#b3e0f2', 10000)
        Wait(5000)
        exports['qb-phone']:PhoneNotification("New Objective", 'Head To The Cold Room', 'fas fa-map-pin', '#b3e0f2', 10000)
    else
        exports['qb-phone']:PhoneNotification("Hack Failed", 'Guards Alerted', 'fas fa-map-pin', '#b3e0f2', 10000)
        RemoveHumaneTarget1()
        Wait(500)
        HumaneTarget1()
        end
    end, Config.LabHackType, Config.DesktopHackTime, 0)
end)

RegisterNetEvent('cerberus-humane:desktophacking', function()
    if QBCore.Functions.HasItem(Config.HackItem) then
        TriggerEvent('cerberus-humane:hacking2')
        Wait(7500)
            if SecurityBypass == false then
                TriggerServerEvent('cerberus-humane:gatherhumancenpcs')
                TriggerEvent('cerberus-humane:CallCops')
                HumaneTarget2()
            else 
            if SecurityBypass == true then
                HumaneTarget2()
            end
        end
    else
        QBCore.Functions.Notify('You dont have the hack device', 'error', 3000)
    end
end)

RegisterNetEvent('cerberus-humane:HumaneHack2', function()
    lib.progressBar({
        duration = HackingTime,
        label = 'Grabbing Samples',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'missheist_agency3aig_20',
            clip = 'idle_a_keyboard'
        },
    })
    TriggerServerEvent('cerberus-humane:GrabSamples')
        RemoveHumaneTarget2()
        if SecurityBypass == true then
            SetNewWaypoint(Config.HumaneBossLocation)
            exports['qb-phone']:PhoneNotification("Job Finished", 'Bring Me The Research', 'fas fa-map-pin', '#b3e0f2', 10000)
        else
        if SecurityBypass == false then
            TriggerServerEvent('cerberus-humane:gatherhumanenpcs2')
            exports['qb-phone']:PhoneNotification("Security Alerted", 'Deliver Me The Samples', 'fas fa-map-pin', '#b3e0f2', 10000)
        end
    end
end)
  
RegisterNetEvent('cerberus-humane:DisableSecurity', function()
    local src = source
    if exports.ox_inventory:Search(src, Config.HackingItem) then
        TriggerEvent('cerberus-humanehacking1')
    else
        QBCore.Functions.Notify('You dont have the hack device', 'error', 3000)
    end
end)

--Police Alerted
RegisterNetEvent('cerberus-humane:CallCops', function()
    exports['ps-dispatch']:HumaneRobbery()
end)


--Security Spawns
labsecurity = {
    ['labpatrol'] = {},
    ['labpatrol2'] = {}
}

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end


RegisterNetEvent('cerberus-humane:SpawnHumaneGuards1', function()
    SpawnHumaneGuards1()
    TriggerServerEvent('cerberus-humane:ResetHumaneGuards1')
end)

RegisterNetEvent('cerberus-humane:SpawnHumaneGuards2', function()
    SpawnHumaneGuards2()
    TriggerServerEvent('cerberus-humane:ResetHumaneGuards2')
end)

function SpawnHumaneGuards1()
    local ped = PlayerPedId()
    local randomgun = Config.LabGuardWeapon[math.random(1, #Config.LabGuardWeapon)]

    SetPedRelationshipGroupHash(ped, 'PLAYER')
    AddRelationshipGroup('labpatrol')

    for k, v in pairs(Config['labsecurity']['labpatrol']) do
        loadModel(v['model'])
        labsecurity['labpatrol'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(labsecurity['labpatrol'][k])
        networkID = NetworkGetNetworkIdFromEntity(labsecurity['labpatrol'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(labsecurity['labpatrol'][k], 0)
        SetPedRandomProps(labsecurity['labpatrol'][k])
        SetEntityAsMissionEntity(labsecurity['labpatrol'][k])
        SetEntityVisible(labsecurity['labpatrol'][k], true)
        SetPedRelationshipGroupHash(labsecurity['labpatrol'][k], 'labpatrol')
        SetPedAccuracy(labsecurity['labpatrol'][k], Config.LabGuardAccuracy)
        SetPedArmour(labsecurity['labpatrol'][k], 100)
        SetPedCanSwitchWeapon(labsecurity['labpatrol'][k], true)
        SetPedDropsWeaponsWhenDead(labsecurity['labpatrol'][k], false)
        SetPedFleeAttributes(labsecurity['labpatrol'][k], 0, false)
        GiveWeaponToPed(labsecurity['labpatrol'][k], randomgun, 999, false, false)
        TaskGoToEntity(labsecurity['labpatrol'][k], PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(labsecurity['labpatrol'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, 'labpatrol', 'labpatrol')
    SetRelationshipBetweenGroups(5, 'labpatrol', 'PLAYER')
    SetRelationshipBetweenGroups(5, 'PLAYER', 'labpatrol')
end

function SpawnHumaneGuards2()
    local ped = PlayerPedId()
    local randomgun = Config.LabGuardWeapon[math.random(1, #Config.LabGuardWeapon)]

    SetPedRelationshipGroupHash(ped, 'PLAYER')
    AddRelationshipGroup('labpatrol2')

    for k, v in pairs(Config['labsecurity']['labpatrol2']) do
        loadModel(v['model'])
        labsecurity['labpatrol2'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(labsecurity['labpatrol2'][k])
        networkID = NetworkGetNetworkIdFromEntity(labsecurity['labpatrol2'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(labsecurity['labpatrol2'][k], 0)
        SetPedRandomProps(labsecurity['labpatrol2'][k])
        SetEntityAsMissionEntity(labsecurity['labpatrol2'][k])
        SetEntityVisible(labsecurity['labpatrol2'][k], true)
        SetPedRelationshipGroupHash(labsecurity['labpatrol2'][k], 'labpatrol')
        SetPedAccuracy(labsecurity['labpatrol2'][k], Config.LabGuardAccuracy)
        SetPedArmour(labsecurity['labpatrol2'][k], 100)
        SetPedCanSwitchWeapon(labsecurity['labpatrol2'][k], true)
        SetPedDropsWeaponsWhenDead(labsecurity['labpatrol2'][k], false)
        SetPedFleeAttributes(labsecurity['labpatrol2'][k], 0, false)
        GiveWeaponToPed(labsecurity['labpatrol2'][k], randomgun, 999, false, false)
        TaskGoToEntity(labsecurity['labpatrol2'][k], PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(labsecurity['labpatrol2'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, 'labpatrol2', 'labpatrol2')
    SetRelationshipBetweenGroups(5, 'labpatrol2', 'PLAYER')
    SetRelationshipBetweenGroups(5, 'PLAYER', 'labpatrol2')
end

-- Functions For Targets
local humanehack1
function HumaneTarget1()
    humanehack1 = exports.ox_target:addSphereZone({
        coords = humanecoords,
        radius = 0.5,
        debug = false,
        options = {
            {
                name = 'humanehack1',
                event = 'cerberus-humane:desktophacking',
                icon = 'fas fa-usb',
                label = "Hack Research Files",
            }
        }
    })
end

local humanehack2
function HumaneTarget2()
    humanehack2 = exports.ox_target:addSphereZone({
        coords = humanecoords2,
        radius = 0.5,
        debug = false,
        options = {
            {
                name = 'humanehack2',
                event = 'cerberus-humane:HumaneHack2',
                icon = 'fas fa-usb',
                label = "Steal Samples",
            }
        }
    })
end
local disablesecurity
function HumaneSecurityTarget()
    disablesecurity = exports.ox_target:addSphereZone({
        coords = vector3(3605.52, 3636.59, 41.34),
        radius = 0.5,
        debug = true,
        options = {
            {
                name = 'securitybypass',
                event = 'cerberus-humane:DisableSecurity',
                icon = 'fas fa-shield',
                label = "Hack Security Systems",
                item = Config.SecurityDevice,
            }
        }
    })
end

function RemoveHumaneTarget1()
        exports.ox_target:removeZone(humanehack1)
end

function RemoveHumaneTarget2()
        exports.ox_target:removeZone(humanehack2)
end

function RemoveHumaneBypass()
        exports.ox_target:removeZone(disablesecurity)
end
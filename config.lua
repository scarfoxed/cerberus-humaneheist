Config = {}

Config.MinimumPolice = 0 --change this to whatever you like
Config.PoliceAlertLab = true

--====Hack stuff====--
Config.HeistCooldown = (60000 * 10) -- ms * minutes
Config.HackItem = 'electronickit' -- item used to hack things you are free to change it to whatever you want
Config.LabHackType = 'alphanumeric' -- can be alphabet, numeric, alphanumeric, greek, braille, runes
Config.LabHackTime = 30 --how long to do minigame
Config.BypassHackTime = 20 -- minigame timer for 1 shot to bypass security at secret location to stop guards from spawning inside lab
Config.HackingTime = 10 --how long for hacking progressbars

---====LAB RAID STUFF====--

Config.HumaneBoss = 's_m_y_westsec_01' --change this to whtever
Config.HumaneBossLocation = vector4(-461.76, 1101.05, 327.68, 138.77) -- change it you like
Config.LabBossScenario = 'WORLD_HUMAN_SMOKING' --the animation the ped does

Config.PaymentLabMin = 100 
Config.PaymentLabMax = 200 
Config.LabItemChance = 5 --in % chance you will get on of th items below on completing lab raid
Config.LabRewards = {  --rare items add as many as you like
    'lockpick', 
    'tosti',
    'water_bottle',
}
Config.LabRewardAmount = 1 -- how many of the rare item you receive

---====LAB GUARDS====---
Config.LabGuardAccuracy = 30 --out of 100 how accurate guards are
Config.LabGuardWeapon = { --this must be the weapon hash not just the weapon item name --this randomises between different guns everytime the guards are spawned
   `WEAPON_PISTOL`,
   `WEAPON_COMBATPISTOL`,
   `WEAPON_PISTOL_MK2`,
}

Config['labsecurity'] = {
    ['labpatrol'] = {
        { coords = vector3(3532.46, 3649.46, 27.52), heading = 63.5, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3537.36, 3645.83, 28.13), heading = 46.35, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3546.64, 3642.28, 28.12), heading = 96.74, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3550.22, 3654.24, 28.12), heading = 156.29, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3554.83, 3661.73, 28.12), heading = 21.64, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3557.54, 3674.59, 28.12), heading = 104.25, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3564.64, 3682.23, 28.12), heading = 48.35, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3594.74, 3686.06, 27.62), heading = 124.5, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3593.82, 3712.27, 29.69), heading = 139.73, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3608.93, 3729.39, 29.69), heading = 323.56, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3618.91, 3722.51, 29.69), heading = 85.71, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3596.07, 3703.44, 29.69), heading = 344.89, model = 's_m_m_fiboffice_02'},
    },
}

Config['labsecurity2'] = {
    ['labpatrol2'] = {
        { coords = vector3(3532.46, 3649.46, 27.52), heading = 63.5, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3537.36, 3645.83, 28.13), heading = 46.35, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3546.64, 3642.28, 28.12), heading = 96.74, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3550.22, 3654.24, 28.12), heading = 156.29, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3554.83, 3661.73, 28.12), heading = 21.64, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3557.54, 3674.59, 28.12), heading = 104.25, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3564.64, 3682.23, 28.12), heading = 48.35, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3594.74, 3686.06, 27.62), heading = 124.5, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3593.82, 3712.27, 29.69), heading = 139.73, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3608.93, 3729.39, 29.69), heading = 323.56, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3618.91, 3722.51, 29.69), heading = 85.71, model = 's_m_m_fiboffice_02'},
        { coords = vector3(3596.07, 3703.44, 29.69), heading = 344.89, model = 's_m_m_fiboffice_02'},
    },
}
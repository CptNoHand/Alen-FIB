FIBHeist = {
    ['heistPeds'] = {}
}

local QBCore = exports['qb-core']:GetCoreObject()

Loaded = false
Job = 'unemployed'
Cops = 0

CreateThread(function()

    while QBCore.Functions.GetPlayerData().job == nil do 
        Wait(0) 
    end

    Loaded = true

    while true do
        Job = QBCore.Functions.GetPlayerData().job.name
        QBCore.Functions.TriggerCallback('AlenFIB:MathCops', function(res)
            Cops = res
        end)
        Wait(5000)
    end
end)

RegisterNetEvent('Fib_CL:PlayOnOneTest')
AddEventHandler('Fib_CL:PlayOnOneTest', function(soundFile, soundVolume)
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = soundVolume
    })
end)

RegisterNetEvent('AlenFIB:Test')
AddEventHandler('AlenFIB:Test', function()
    QBCore.Functions.Notify('Someone is robbing the FIB')
    local timer = GetGameTimer() + 7500
    while timer >= GetGameTimer() do 
        Wait(0)
        AddTextEntry(GetCurrentResourceName(), Strings['Robbery'] .. '\n' .. Strings['Waypoint'])
        DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
        if IsControlJustReleased(0, 51) then
            SetNewWaypoint(Config['Door']['Coords']['x'], Config['Door']['Coords']['y'])
            break
        end
    end
end)

RegisterNetEvent('flypolice')
AddEventHandler('flypolice', function()
local src = source
	NYfly()
end) 

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function NYfly()
	DoScreenFadeOut(1000)
	Wait(1000)
	NYIpl()
	
	SetEntityCoords(PlayerPedId(), tonumber(514.77), tonumber(4752.67), tonumber(-69) + 0.0, 1, 0, 0, 1) 
	SetEntityHeading(PlayerPedId(), 174.76)
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(1000)
	FreezeEntityPosition(PlayerPedId(), false)
	
	DoScreenFadeIn(1000) 
	anim = true
	Wait(10000)
	
	DoScreenFadeOut(1000)
	
	Wait(1000)
	anim = false
	SetEntityCoords(PlayerPedId(), tonumber(4465.69), tonumber(-4474.31), tonumber(4.23) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(PlayerPedId(), 213.28)
	FreezeEntityPosition(PlayerPedId(), true) 
	SetDrawMapVisible(true)
	Wait(8000)
	FreezeEntityPosition(PlayerPedId(), false) 
	DoScreenFadeIn(1000)
	inNY = true
end

function NYIpl()
      LoadMpDlcMaps()
      EnableMpDlcMaps(true)
      RequestIpl("FIBlobbyfake")
      RequestIpl("DT1_03_Gr_Closed")
      RequestIpl("v_tunnel_hole")
      RequestIpl("TrevorsMP")
      RequestIpl("TrevorsTrailer")
      RequestIpl("farm")
      RequestIpl("farmint")
      RequestIpl("farmint_cap")
      RequestIpl("farm_props")
      RequestIpl("CS1_02_cf_offmission") 
    end

    function IplRemove()
        LoadMpDlcMaps()
        EnableMpDlcMaps(false)
        RemoveIpl("FIBlobbyfake")
        RemoveIpl("DT1_03_Gr_Closed")
        RemoveIpl("v_tunnel_hole")
        RemoveIpl("TrevorsMP")
        RemoveIpl("TrevorsTrailer")
        RemoveIpl("farm")
        RemoveIpl("farmint")
        RemoveIpl("farmint_cap")
        RemoveIpl("farm_props")
        RemoveIpl("CS1_02_cf_offmission") 
      end
      
      
      function SpawnGetAwayVehicle()
        coords = {x = 1073.49, y = 3080.74, z = 40.76, h = 280.76}
        QBCore.Functions.SpawnVehicle(Config['HeistVeh'], function(veh)
            SetVehicleNumberPlateText(veh, "FIB"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, 280.76)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
            SetVehicleEngineOn(veh, true, true)
            plaquevehicule = GetVehicleNumberPlateText(veh)
        end, coords, true)
    end

CreateThread(function()
    while not Loaded do
        Wait(0)
    end


    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local fetchmyped = GetEntityCoords(ped)
            local sleep = 1000
            local upcoords = #(fetchmyped - vector3(136.16516, -762.0228, 45.752021))
            local pcoords = #(fetchmyped - vector3(5092.1, -4682.86, 2.41))
            local nycoords = #(fetchmyped - vector3(4440.61, -4482.98, 4.29))
            local lscoords = #(fetchmyped - vector3(1727.85, 3295.38, 41.22))
            local hacktp = #(fetchmyped - vector3(124.73767, -733.198, 242.152))
    
            if pcoords <= 5.0 then
                sleep = 1
                if pcoords <= 2.0 then
                   DrawText3D(5092.1, -4682.86, 2.41, "~b~[E]~w~To Sell Printed Notes")
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('AlenFIB:Reward')
                        PlaySoundFrontend(-1, "COLLECTED", "HUD_AWARDS", 0)
                    end
                end
            end
            if lscoords <= 5.0 then
                sleep = 1
                if lscoords <= 2.0 then
                   DrawText3D(1727.85, 3295.38, 41.22, "~b~[E]~w~To Get The Plane")
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent("Fib_SV:PlayOnSourceTest", "done", 0.9) 
                      SpawnGetAwayVehicle()
                    end
                end
            end
            if hacktp <= 5.0 then
                sleep = 1
                if hacktp <= 2.0 then
                   DrawText3D(124.73767, -733.198, 242.152, "~b~[E]~w~To Hack And Reach The Roof")
                    if IsControlJustPressed(0, 38) then
                        Start(2.5)
                    end
                end
            end
            if upcoords <= 5.0 then
                sleep = 1
                DrawMarker(26, 136.16516, -762.0228, 44.752021, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 1.0, 237, 197, 66, 255, false, false)
                if upcoords <= 2.0 then
                   DrawText3D(136.16516, -762.0228, 45.752021, "~b~[E]~w~To Go Upstairs")
                    if IsControlJustPressed(0, 38) then
                        exports["memorygame"]:thermiteminigame(4, 3, 3, 10,
                        function() 
                          QBCore.Functions.Notify('You have successfully hacked into the FIB Building Now Take Out The Guards!', 'success')
                            TeleportPlayer()
                            PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
                        end,
                        function()
                            QBCore.Functions.Notify('You Could not make it!', 'error')
                            PlaySoundFrontend(-1, "MP_Flash", "WastedSounds", 0)
                        end)
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)

    QBCore.Functions.TriggerCallback('AlenFIB:check', function(has)
        if has then
            local SpawnedObjects, Trolleys, Busy, Locked = {}, {}, false, false
            
            CreateThread(function()
                while not Loaded do
                    Wait(0)
                end
                
                CreateThread(function()
                    Wait(math.random(100, 750))
                    while true do
                        for k, v in pairs(Config['Trolleys']) do
                            if #(GetEntityCoords(PlayerPedId()) - v['coords']) <= 10.0 then
                                Wait(math.random(100, 1500))
                                local empty = false
                                local trolley = GetClosestObjectOfType(v['coords'], 0.3, GetHashKey('hei_prop_hei_cash_trolly_01'), false)
                                if not DoesEntityExist(trolley) then
                                    trolley = GetClosestObjectOfType(v['coords'], 0.3, GetHashKey('hei_prop_hei_cash_trolly_03'), false)
                                    empty = true
                                end
                                if not DoesEntityExist(trolley) then
                                    trolley = CreateObject(LoadModel(GetHashKey('hei_prop_hei_cash_trolly_01')), v['coords'], true)
                                    NetworkRegisterEntityAsNetworked(trolley)
                                    SetNetworkIdCanMigrate(ObjToNet(trolley))
                                    SetNetworkIdExistsOnAllMachines(ObjToNet(trolley))
                                    FreezeEntityPosition(trolley, true)
                                    SetEntityHeading(trolley, v['heading'])
                                    SetEntityAsMissionEntity(trolley, true, true)
                                    Trolleys[k] = {
                                        ['NetID'] = ObjToNet(trolley),
                                        ['Obj'] = trolley,
                                        ['Empty'] = false
                                    }
                                    table.insert(SpawnedObjects, trolley)
                                else
                                    if empty then
                                        Trolleys[k] = {
                                            ['NetID'] = ObjToNet(trolley),
                                            ['Obj'] = trolley,
                                            ['Empty'] = true
                                        }
                                        table.insert(SpawnedObjects, trolley)
                                    else
                                        Trolleys[k] = {
                                            ['NetID'] = ObjToNet(trolley),
                                            ['Obj'] = trolley,
                                            ['Empty'] = false
                                        }
                                    end
                                end
                            end
                        end
                        Wait(4500)
                    end
                end)
                QBCore.Functions.TriggerCallback('AlenFIB:JustLock', function(stat)
                    Locked = stat
                end)
                CreateThread(function()
                    while true do
                        for k, v in pairs(Trolleys) do
                            v['Obj'] = NetToObj(v['NetID'])
                        end
                        Wait(1000)
                    end
                end)
                while true do
                    local sleep = 500
                    local door = GetClosestObjectOfType(Config['Door']['Coords'], 2.0, GetHashKey(Config['Door']['Obj']))
                    if DoesEntityExist(door) then
                        local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(door))
                        if dist <= 5.0 then
                            FreezeEntityPosition(door, Locked)
                            if Locked then
                                SetEntityHeading(door, Config['Door']['Heading'])
                                if dist <= 3.0 then
                                    sleep = 0
                                    if Config['3DText']['Enabled'] and dist > 1.5 then
                                        HelpText(Strings['LockPick'], GetOffsetFromEntityInWorldCoords(door, Config['Door']['Offset']) + vec3(0.0, 0.0, 1.0))
                                    end
                                    if dist <= 1.5 then
                                        HelpText('~INPUT_CONTEXT~ ' .. Strings['LockPick'], GetOffsetFromEntityInWorldCoords(door, Config['Door']['Offset']) + vec3(0.0, 0.0, 1.0))
                                        if IsControlJustReleased(0, 51) then
                                            if Cops >= Config['RequiredCops'] then
                                                while not HasAnimDictLoaded(Config['Door']['Anim']['Dict']) do
                                                    Wait(0)
                                                    RequestAnimDict(Config['Door']['Anim']['Dict'])
                                                end
                                                TriggerServerEvent('AlenFIB:PoliceCall')
                                                SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(door, Config['Door']['LockPick']))
                                                SetEntityHeading(PlayerPedId(), Config['Door']['LockPickHeading'])
                                                TaskPlayAnim(PlayerPedId(), Config['Door']['Anim']['Dict'], Config['Door']['Anim']['Anim'], 8.0, -8.0, -1, 1, 0, false, false, false)
                                                Wait(Config['Door']['Anim']['Time'])
                                                ClearPedTasks(PlayerPedId())
                                               TriggerEvent("utk_fingerprint:Start", 2, 6, 2, function(outcome, reason)
                                                if outcome == true then 
                                                    local example = exports['cd_keymaster']:StartKeyMaster()
                                                    if example then
                                                        TriggerServerEvent('AlenFIB:OpenDoor')
                                                        PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
                                                      QBCore.Functions.Notify('Succesfully  Unlocked The FIB Vault!', 'success')
                                                    else
                                                    end
                                                elseif outcome == false then
                                                    QBCore.Functions.Notify('Unfortuanately you are not talented enough!', 'error')
                                                    PlaySoundFrontend(-1, "MP_Flash", "WastedSounds", 0)
                                                end
                                            end)
                                            else
                                                QBCore.Functions.Notify('There currently not enough cops online for the mission!')
                                            end
                                        end
                                    end
                                end
                            else
                                if Job == Config['Police'] then
                                    if dist <= 3.0 then
                                        sleep = 0
                                        if Config['3DText']['Enabled'] and dist > 1.5 then
                                            HelpText(Strings['Lock'], GetOffsetFromEntityInWorldCoords(door, Config['Door']['Offset']) + vec3(0.0, 0.0, 1.0))
                                        end
                                        if dist <= 1.5 then
                                            HelpText('~INPUT_CONTEXT~ ' .. Strings['Lock'], GetOffsetFromEntityInWorldCoords(door, Config['Door']['Offset']) + vec3(0.0, 0.0, 1.0))
                                            if IsControlJustReleased(0, 51) then
                                                while not HasAnimDictLoaded(Config['Door']['Anim']['Dict']) do
                                                    Wait(0)
                                                    RequestAnimDict(Config['Door']['Anim']['Dict'])
                                                end
                                                SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(door, Config['Door']['LockPick']))
                                                SetEntityHeading(PlayerPedId(), Config['Door']['LockPickHeading'])
                                                TaskPlayAnim(PlayerPedId(), Config['Door']['Anim']['Dict'], Config['Door']['Anim']['Anim'], 8.0, -8.0, -1, 1, 0, false, false, false)
                                                Wait(Config['Door']['Anim']['Time'])
                                                ClearPedTasks(PlayerPedId())
                                                TriggerServerEvent('AlenFIB:PoliceLock')
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if not Busy then
                        for k, v in pairs(Trolleys) do
                            if not v['Empty'] then
                                local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(v['Obj']))
                                if dist <= 3.0 and not Locked then
                                    if Config['3DText']['Enabled'] then
                                        sleep = 0
                                        if dist > 1.0 then
                                            HelpText(Strings['Grab'], GetEntityCoords(v['Obj']) + vec3(0.0, 0.0, 1.0))
                                        end
                                    end
                                    if dist <= 1.0 then
                                        HelpText('~INPUT_CONTEXT~ ' .. Strings['Grab'], GetEntityCoords(v['Obj']) + vec3(0.0, 0.0, 1.0))
                                        if IsControlJustReleased(0, 51) then
                                            GrabCash(v['Obj'], k)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    Wait(sleep)
                end
            end)
            GrabCash = function(trolley, id)
                local total = 0
                Busy = true
                TriggerServerEvent('AlenFIB:DeleteT', id)
                local plr = PlayerPedId()
                local bag = CreateObject(LoadModel(GetHashKey('hei_p_m_bag_var22_arm_s')), GetEntityCoords(plr), true, false, false)
                table.insert(SpawnedObjects, bag)
                local scene = NetworkCreateSynchronisedScene(GetEntityCoords(trolley), GetEntityRotation(trolley), 2, false, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(plr, scene, 'anim@heists@ornate_bank@grab_cash', 'intro', 1.5, -4.0, 1, 16, 1148846080, 0)
                NetworkAddEntityToSynchronisedScene(bag, scene, 'anim@heists@ornate_bank@grab_cash', 'bag_intro', 4.0, -8.0, 1)
                NetworkStartSynchronisedScene(scene)
                Wait(1500)
                local cash = CreateObject(LoadModel(GetHashKey('hei_prop_heist_cash_pile')), GetEntityCoords(plr), true)
                FreezeEntityPosition(cash, true)
                SetEntityInvincible(cash, true)
                SetEntityNoCollisionEntity(cash, plr)
                SetEntityVisible(cash, false, false)
                AttachEntityToEntity(cash, plr, GetPedBoneIndex(plr, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
                local stop = GetGameTimer() + 37000
                table.insert(SpawnedObjects, cash)
                CreateThread(function()
                    while GetGameTimer() <= stop do
                        Wait(0)
                        if HasAnimEventFired(plr, GetHashKey('CASH_APPEAR')) then
                            SetEntityVisible(cash, true, false)
                        end
                        if HasAnimEventFired(plr, GetHashKey('RELEASE_CASH_DESTROY')) then
                            if IsEntityVisible(cash) then
                                SetEntityVisible(cash, false, false)
                                total = total + math.random(Config['Cash']['Min'], Config['Cash']['Max'])
                            end
                        end
                    end
              QBCore.Functions.Notify('You grabbed cash from the trolley!', 'success')
                    TriggerServerEvent('AlenFIB:Done', total)
                    TriggerServerEvent("Fib_SV:PlayOnSourceTest", "agent", 0.9)
                    DeleteObject(cash)
                    DeleteObject(bag)
                    local coords, rotation = GetOffsetFromEntityInWorldCoords(trolley, 0.0, 0.0, -0.98), GetEntityRotation(trolley)
                    CreateThread(function()
                        while DoesEntityExist(trolley) do
                            Wait(0)
                            while not NetworkHasControlOfEntity(trolley) do
                                Wait(0)
                                NetworkRequestControlOfEntity(trolley)
                            end
                            SetEntityCoords(trolley, 0.0, 0.0, 0.0)
                            SetEntityAsMissionEntity(trolley, true, true)
                            DeleteObject(trolley)
                        end
                    end)
                    Wait(500)
                    local Newtrolley = CreateObject(LoadModel(GetHashKey('hei_prop_hei_cash_trolly_03')), coords, true)
                    PlaceObjectOnGroundProperly(Newtrolley)
                    NetworkRegisterEntityAsNetworked(Newtrolley)
                    SetNetworkIdCanMigrate(ObjToNet(Newtrolley))
                    SetNetworkIdExistsOnAllMachines(ObjToNet(Newtrolley))
                    SetEntityRotation(Newtrolley, rotation)
                    Trolleys[id] = {
                        ['NetID'] = ObjToNet(Newtrolley),
                        ['Obj'] = Newtrolley,
                        ['Empty'] = true
                    }
                    table.insert(SpawnedObjects, Newtrolley)
                    Busy = false
                end)
                scene = NetworkCreateSynchronisedScene(GetEntityCoords(trolley), GetEntityRotation(trolley), 2, false, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(plr, scene, 'anim@heists@ornate_bank@grab_cash', 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
                NetworkAddEntityToSynchronisedScene(bag, scene, 'anim@heists@ornate_bank@grab_cash', 'bag_grab', 4.0, -8.0, 1)
                NetworkAddEntityToSynchronisedScene(trolley, scene, 'anim@heists@ornate_bank@grab_cash', 'cart_cash_dissapear', 4.0, -8.0, 1)
                NetworkStartSynchronisedScene(scene)
            end

            AddEventHandler("datacrack", function(output)
                if output then
                    TeleportPlayerSanAndreas()
                    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
                    QBCore.Functions.Notify('Get a Parachute and get away.', 'info')
                else
                    QBCore.Functions.Notify('You could not make it!', 'error')
                end
            end)

            AddEventHandler('onResourceStop', function(resourceName)
                if resourceName == GetCurrentResourceName() then
                    for k, v in pairs(SpawnedObjects) do
                        DeleteObject(v)
                    end
                end
            end)

            RegisterNetEvent('AlenFIB:LockStatus')
            AddEventHandler('AlenFIB:LockStatus', function(stat)
                Locked = stat
            end)
            LoadModel = function(model)
                local Timer = GetGameTimer() + 5000
                while not HasModelLoaded(model) do
                    Wait(0)
                    RequestModel(model)
                    if GetGameTimer() >= Timer then
                        return false
                    end
                end
                return model
            end
            HelpText = function(msg, coords, close)
                if not coords or not Config['3DText']['Enabled'] then
                    AddTextEntry(GetCurrentResourceName(), msg)
                    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
                else
                    Config['3DText']['Draw'](coords, string.gsub(msg, '~INPUT_CONTEXT~', '~w~[~r~' .. GetControlInstructionalButton(0, 51, 1):gsub('t_', '') .. '~w~]'))
                end
            end
        end
    end)
end)

function SpawnPeds()
    local ped = PlayerPedId()


    SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))
    AddRelationshipGroup('GuardPeds')

    for k, v in pairs(Config['AttackingPeds']['PedConfig']) do
        loadModel(v['ped'])
        FIBHeist['heistPeds'][k] = CreatePed(26, GetHashKey(v['ped']), v['pos'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(FIBHeist['heistPeds'][k])
        networkID = NetworkGetNetworkIdFromEntity(FIBHeist['heistPeds'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetEntityAsMissionEntity(FIBHeist['heistPeds'][k])
        SetPedRelationshipGroupHash(FIBHeist['heistPeds'][k], GetHashKey("GuardPeds"))
        SetEntityVisible(FIBHeist['heistPeds'][k], true)
        SetPedRandomComponentVariation(FIBHeist['heistPeds'][k], 0)
        SetPedRandomProps(FIBHeist['heistPeds'][k])
        if v['ped'] ~= 'a_f_m_prolhost_01' then
            SetPedAccuracy(FIBHeist['heistPeds'][k], 50)
            SetPedArmour(FIBHeist['heistPeds'][k], 100)
            SetPedCanSwitchWeapon(FIBHeist['heistPeds'][k], true)
            SetPedDropsWeaponsWhenDead(FIBHeist['heistPeds'][k], false)
            SetPedFleeAttributes(FIBHeist['heistPeds'][k], 0, false)
            GiveWeaponToPed(FIBHeist['heistPeds'][k], GetHashKey('WEAPON_PISTOL'), 255, false, false)
            local random = math.random(1, 2)
            if random == 2 then
                TaskGuardCurrentPosition(FIBHeist['heistPeds'][k], 10.0, 10.0, 1)
            end
        else
            loadAnimDict('missminuteman_1ig_2')
            TaskPlayAnim(FIBHeist['heistPeds'][k], 'missminuteman_1ig_2', 'handsup_enter', 8.0, 8.0, -1, 50, 0, 0, 0, 0)
            SetBlockingOfNonTemporaryEvents(FIBHeist['heistPeds'][k], true)
        end
    end

    SetRelationshipBetweenGroups(0, GetHashKey("GuardPeds"), GetHashKey("GuardPeds"))
	SetRelationshipBetweenGroups(5, GetHashKey("GuardPeds"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GuardPeds"))
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end

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

function TeleportPlayer()
    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()
    SetEntityCoords(ped, 135.97929, -761.8979, 242.15208)
    SetEntityHeading(ped, 156.99472)
    DoScreenFadeIn(2000)
end

function TeleportPlayerSanAndreas()
    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()
    SetEntityCoords(ped, 156.93, -764.59, 258.15)
    SetEntityHeading(ped, 246.64)
    DoScreenFadeIn(2000)
end

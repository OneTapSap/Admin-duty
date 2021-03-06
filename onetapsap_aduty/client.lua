local adminok = {}
local inDuty = false
local lastped = GetHashKey('mp_m_freemode_01')


--------------IKONOK--------------
function loadAllIcons()
	for i, v in pairs(Config.Icons) do
		local txd = CreateRuntimeTxd(v[1])
		CreateRuntimeTextureFromImage(txd, v[1], "icons/"..v[1]..".png")
	end
end

Citizen.CreateThread(function()
	loadAllIcons()
end)

-------------HALHATATLAN-----------

RegisterNetEvent('onetapsap_aduty:enable')
AddEventHandler('onetapsap_aduty:enable', function()
    if Config.Ped ~= nil then
        lastped = GetEntityModel(PlayerPedId())
	    local hash = GetHashKey(Config.Ped)
	    RequestModel(hash)
	    while not HasModelLoaded(hash)
		    do RequestModel(hash)
		    Citizen.Wait(0)
	    end	
	    SetPlayerModel(PlayerId(), hash)
    end
	
	inDuty = true
    SetPlayerInvincible(PlayerId(), true)
end)

RegisterNetEvent('onetapsap_aduty:disable')
AddEventHandler('onetapsap_aduty:disable', function()
	if Config.Ped ~= nil then
	    loadplayerskin()
	    TriggerEvent('skinchanger:getSkin', function(skin)
		    TriggerEvent('skinchanger:loadSkin', skin)
	    end)
	end

    inDuty = false
    SetPlayerInvincible(PlayerId(), false)
end)

function loadplayerskin()
	local hash = lastped
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
			Citizen.Wait(0)
		end
	SetPlayerModel(PlayerId(), hash)
	TriggerEvent('esx:restoreLoadout')
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if (not GetPlayerInvincible(PlayerId()) and inDuty) then 
            SetPlayerInvincible(PlayerId(), true)
        end
    end
end)


----------------------KIIRÁS------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        for id, data in pairs(adminok) do
            if NetworkIsPlayerActive(GetPlayerFromServerId(id)) then
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed(GetPlayerFromServerId(id)), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1+0.1,  y1,  z1,  x2,  y2,  z2,  true))
                if (distance < 20) then
                    DrawText3D(x2, y2, z2+1.1, data[2] .. GetPlayerName(GetPlayerFromServerId(id)), 255, 255, 255, 0.7)
                    DrawMarker(9, x2, y2, z2+1.8, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255, true, false, 2, true, data[3], data[3], false)
                end
            end
        end
    end
end)

--------------------SZERVER ADATOK-----------------
RegisterNetEvent('onetapsap_aduty:sendData')
AddEventHandler('onetapsap_aduty:sendData', function(recData)
    adminok = recData
end)

-----------------RAJZOLÁSOK------------------
function DrawText3D(x,y,z, text, r, g, b, scl) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, scl*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(1)
        BeginTextCommandDisplayText("STRING")
	    AddTextComponentString(text)
	    EndTextCommandDisplayText(_x, _y)
    end
end

-------------------:)-------------------
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if inDuty == true then
            TriggerEvent('onetapsap_aduty:disable')
        end
	end
end)
print('Az admin duty fut.')

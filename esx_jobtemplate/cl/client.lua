local WardrobeLoc = Config.WardrobeLoc
local SocietyLoc = Config.SocietyLoc

ESX = nil
local PlayerData = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer

  Citizen.CreateThread(function()
  	while true do
  		Citizen.Wait(0)

  		if(PlayerData.job ~= nil and PlayerData.job.name == "hotdog") then
			

			  if(GetDistanceBetweenCoords(WardrobeLoc.x,WardrobeLoc.y,WardrobeLoc.z,  GetEntityCoords(GetPlayerPed(-1)), true) < 1) then --last int is distance feel free to change to any number u would like
				DrawText3D(WardrobeLoc.x, WardrobeLoc.y, WardrobeLoc.z, '~w~[~g~E~w~] Open Menu', 0.4)
  				if(IsControlJustPressed(1, 38)) then
  					openTakeService()
  				end
  			end
  		end
  	end
  end)

  if(PlayerData.job.grade_name == "boss" and PlayerData.job.name == "hotdog") then
  	createSocietyMenu(SocietyLoc.x,SocietyLoc.y,SocietyLoc.z,"hotdog", "Hotdog")
  end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function Info(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end

function createSocietyMenu(x,y,z,name, menuName)
Citizen.CreateThread(function()
	local menuShowed = false
	while true do
		Citizen.Wait(10)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),x,y,z, true)
		--DrawMarker(20,x,y,z-1,0,0,0,0,0,0,2.001,2.0001,0.5001,223,62,78,100,0,0,1,0)
		if(distance > 3 and menuShowed) then
			ESX.UI.Menu.CloseAll()
		end

		if(distance<3) then
			if(menuShowed) then
				--nothing needs to be here :L
			else
				DrawText3D(SocietyLoc.x, SocietyLoc.y, SocietyLoc.z, '~w~[~g~E~w~] Open Menu', 0.4)
			end

			if(IsControlJustPressed(1, 38)) then
				menuShowed = not menuShowed

				if(menuShowed) then
					--print(name)
					renderMenu(name, menuName)
				else
					ESX.UI.Menu.CloseAll()
				end
			end
		end
	end
end)
end

function renderMenu(name, menuName)
	local _name = name
	local elements = {}

  	table.insert(elements, {label = 'withdraw society company', value = 'withdraw_society_money'})
  	table.insert(elements, {label = 'deposit money',        value = 'deposit_money'})
  	table.insert(elements, {label = 'wash money',        value = 'wash_money'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'realestateagent', {
			title    = menuName,
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)

			if data.current.value == 'withdraw_society_money' then

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount', {
						title = 'amount of withdrawal',
						align = 'bottom-right'
					}, function(data, menu)

						local amount = tonumber(data.value)

						if amount == nil or amount < 0 then
							ESX.ShowNotification('invalid amount')
						else
							menu.close()
							--print(_name)
							TriggerServerEvent('esx_society:withdrawMoney', _name, amount)
						end
					end, function(data, menu)
						menu.close()
					end)
			end

			if data.current.value == 'deposit_money' then

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount', {
						title = 'deposit amount',
						align = 'bottom-right'
					}, function(data, menu)

						local amount = tonumber(data.value)

						if amount == nil or amount < 0 then
							ESX.ShowNotification('invalid amount')
						else
							menu.close()
							TriggerServerEvent('esx_society:depositMoney', _name, amount)
						end
					end, function(data, menu)
						menu.close()
					end)
			end

			if data.current.value == 'wash_money' then

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'wash_money_amount', {
						title = 'Wash money',
						align = 'bottom-right'
					}, function(data, menu)

						local amount = tonumber(data.value)

						if amount == nil or amount < 0 then
							ESX.ShowNotification('invalid amount')
						else
							menu.close()
							TriggerServerEvent('esx_society:washMoney', _name, amount)
						end
					end, function(data, menu)
						menu.close()
					end)
			end
		end, function(data, menu)

			menu.close()
		end)
end

function DrawText3D(x, y, z, text, scale) local onScreen, _x, _y = World3dToScreen2d(x, y, z) local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) SetTextScale(scale, scale) SetTextFont(4) SetTextProportional(1) SetTextEntry("STRING") SetTextCentre(true) SetTextColour(255, 255, 255, 215) AddTextComponentString(text) DrawText(_x, _y) local factor = (string.len(text)) / 700 DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 0, 0, 0, 75) end
function ShowVaultTimer() SetTextFont(0) SetTextProportional(0) SetTextScale(0.42, 0.42) SetTextDropShadow(0, 0, 0, 0,255) SetTextEdge(1, 0, 0, 0, 255) SetTextEntry("STRING") AddTextComponentString("~r~"..UTK.vaulttime.."~w~") DrawText(0.682, 0.96) end
function DisableControl() DisableControlAction(0, 73, false) DisableControlAction(0, 24, true) DisableControlAction(0, 257, true) DisableControlAction(0, 25, true) DisableControlAction(0, 263, true) DisableControlAction(0, 32, true) DisableControlAction(0, 34, true) DisableControlAction(0, 31, true) DisableControlAction(0, 30, true) DisableControlAction(0, 45, true) DisableControlAction(0, 22, true) DisableControlAction(0, 44, true) DisableControlAction(0, 37, true) DisableControlAction(0, 23, true) DisableControlAction(0, 288, true) DisableControlAction(0, 289, true) DisableControlAction(0, 170, true) DisableControlAction(0, 167, true) DisableControlAction(0, 73, true) DisableControlAction(2, 199, true) DisableControlAction(0, 47, true) DisableControlAction(0, 264, true) DisableControlAction(0, 257, true) DisableControlAction(0, 140, true) DisableControlAction(0, 141, true) DisableControlAction(0, 142, true) DisableControlAction(0, 143, true) end
function EnterAnim(coords) TaskTurnPedToFaceCoord(PlayerPedId(), coords, 1000) end

function openTakeService()
  local elements = {
    {label = "Off-Duty clothing", value = 'citizen_wear'},
    {label = "Work clothing", value = 'hotdog_wear'}
  }

  ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
        title    = 'Service plug',
        align    = 'bottom-right',
        elements = elements,
        }, function(data, menu)

      menu.close()

      --Taken from SuperCoolNinja
      if data.current.value == 'citizen_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          local model = nil

          if skin.sex == 0 then
            model = GetHashKey("mp_m_freemode_01")
          else
            model = GetHashKey("mp_f_freemode_01")
          end

          RequestModel(model)
          while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
          end

          SetPlayerModel(PlayerId(), model)
          SetModelAsNoLongerNeeded(model)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end)
      end

      if data.current.value == 'hotdog_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

          if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
          else
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
		  end
		  -- u could put some end message here idk :l
		  --maybe sum like exports['mythic_notify']:DoHudText('inform', 'You have entered service or something.........', 7000)
        end)
      end
    end, function(data, menu)

      menu.close()
    end)
end

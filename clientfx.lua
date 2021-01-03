PlayerJob = {}
FXCore = nil

Citizen.CreateThread(function()
	while FXCore == nil do
		TriggerEvent('FXCore:GetObject', function(obj) FXCore = obj end)
		Citizen.Wait(200)
  end
  
end)
RegisterNetEvent('FXCore:Client:OnPlayerLoaded')
AddEventHandler('FXCore:Client:OnPlayerLoaded', function()

    PlayerJob = FXCore.Functions.GetPlayerData().job
  

    
end)

RegisterNetEvent('FXCore:Client:OnJobUpdate')
AddEventHandler('FXCore:Client:OnJobUpdate', function(JobInfo)

    PlayerJob = JobInfo

end)


function LocalInput(text, numeros, windoes) --SHOW ON SCREEN KEYBOARD FOR THE PRICE AND NAME
    DisplayOnscreenKeyboard(1, text or "FMMC_MPM_NA", "", windoes or "", "", "", "", numeros or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return result
    end
end
function LocalInputInt(text, numeros, windoes) --SHOW ON SCREEN KEYBOARD FOR THE PRICE AND NAME BUT RETURN A NUMBER
   DisplayOnscreenKeyboard(1, text or "FMMC_MPM_NA", "", windoes or "", "", "", "", numeros or 30)
   while (UpdateOnscreenKeyboard() == 0) do
       DisableAllControlActions(0)
       Wait(0)
   end
   if (GetOnscreenKeyboardResult()) then
       local result = GetOnscreenKeyboardResult()
       return tonumber(result)
   end
end

RegisterNetEvent('jerico:news')
AddEventHandler('jerico:news', function()
	--if  PlayerJob.name == "reporter" then
	OpenMenu()
--	end
end)

OpenMenu = function()

	local assert = assert
	local MenuV = assert(MenuV)
	local menu = MenuV:CreateMenu("FX NEWS", 'News Menu', 'topleft', 255, 0, 0, 'size-125')
	
menu.Theme = "native"
menu.Position = "topright"
menu.Color = {R=255,G=255,B=255}
		MenuV:OpenMenu(menu)
		
		local button = menu:AddButton({ icon = '😃', label = 'Post News', value = 10, description = 'Send the news to the phone' })	 
		local button1 = menu:AddButton({ icon = '😃', label = 'Erase News', value = 10, description = 'Erase News' })	 
		button:On("select",function()
		
			NuevasNoticias()
		end)
		button1:On("select",function()
		
		
			BorrarNoticias()
		end)
	
end

--[[ Citizen.CreateThread(function()
	 ]]
--[[ end) ]]

BorrarNoticias = function()

 	FXCore.Functions.TriggerCallback('crew-phone:get-news', function(news)
        local elements = {}
        for i=1, #news, 1 do
            table.insert(elements, {label = json.decode(news[i].alldata).name, value = json.decode(news[i].id)})
        end
		local assert = assert
		local MenuV = assert(MenuV)
		local menu = MenuV:CreateMenu("FX NEWS", 'Delete Menu', 'topleft', 255, 0, 0, 'size-125')
		MenuV:OpenMenu(menu)
		menu.Theme = "native"
		menu.Position = "topright"
		for k,v in ipairs(elements) do
			local button = menu:AddButton({ icon = '😃', label = v.label, value = v , description = v.label ,select = function(btn)
				local value = btn.Value
				menu.Title = "Delete News"..btn.Value.value
				if value.value == tonumber(value.value) then
					FXCore.Functions.Notify("News Deleted")
					TriggerServerEvent("crew-phone:delete-news", value.value)
				else
					FXCore.Functions.Notify("News Not Deleted")
				end

			end})	  
		end
	
	end)
end


NuevasNoticias = function()

	local dialog
	local dialog1
	local dialog2
	local dialog3
	local dialog4
	
			 local assert = assert
			  local MenuV = assert(MenuV)
			  local menu = MenuV:CreateMenu("FX NEWS", 'News Menu', 'topleft', 255, 0, 0, 'size-125')
			  MenuV:OpenMenu(menu)
			  menu.Theme = "Native"
			  local checkbox = menu:AddCheckbox({ icon = '💡', label = "Title", value = 'n' })
			  local checkbox1 = menu:AddCheckbox({ icon = '💡', label = "Content", value = 'n', disabled = false })
			  local checkbox2 = menu:AddCheckbox({ icon = '💡', label ="IMG", value = 'n' , disabled = false })
			  local button = menu:AddButton({ icon = '😃', label = 'Send News', value = 10, description = 'Send the news to the phone' })	  
			  checkbox:On("check",function()
				  -- dialog1 = LocalInput("news",30, "Titulo")
				  TriggerEvent("Input:Open","Title","FXCore",function(p)
					local price = (p and tostring(p) and tostring(p) == "" )
					
						dialog1 = p
					
				  end)
				   
				   
			  end) 
			  checkbox1:On("check",function()
				TriggerEvent("Input:Open","Contenido","FXCore",function(p)
					local price = (p and tostring(p) and tostring(p) == "")
					   
						dialog2 = p
				
				end)
				
			
			 end)
			 checkbox2:On("check",function()
				TriggerEvent("Input:Open","Contenido","FXCore",function(p)
					local price = (p and tostring(p) and tostring(p) == "")
				   
						dialog3 = p
						
					
					
				end)
			  end)
			 
			  button:On("select",function()
				TriggerServerEvent("crew-phone:new-news", dialog1, dialog2, dialog3, "")
			
			end)

end
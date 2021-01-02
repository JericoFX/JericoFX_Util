--# Print the information of a table to the console
--https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console

function tprint (tbl, indent)
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
	  formatting = string.rep("  ", indent) .. k .. ": "
	  if type(v) == "table" then
		print(formatting)
		tprint(v, indent+1)
	  elseif type(v) == 'boolean' then
		print(formatting .. tostring(v))      
	  else
		print(formatting .. v)
	  end
	end
  end

--#######################################################

DrawText3D = function(x,y,z, text, d)
	coords = vector3(x,y,z)
  
	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)
  
	if not size then size = 1 end
	if not font then font = 1 end
  
	local dist = Vdist(GetEntityCoords(GetPlayerPed(-1)),coords)
  
	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov
   
	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(255, 255, 255, math.floor(math.max(0.1,255 / math.max(1.0, dist/(d / 10) )) ))
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
  
	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
  end

  --#######################################################
  --Distance between 2 points
  vDist = function(v1,v2)  
	if not v1 or not v2 or not v1.x or not v2.x or not v1.z or not v2.z then return 0; end
	return math.sqrt( ((v1.x - v2.x)*(v1.x-v2.x)) + ((v1.y - v2.y)*(v1.y-v2.y)) + ((v1.z-v2.z)*(v1.z-v2.z)) ) 
  end
  

  exports('vDist', function(...) vDist(...); end)
  
  exports('tprint', function(...) tprint(...); end)

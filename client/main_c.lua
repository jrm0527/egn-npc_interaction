
EGNCore = exports['egn-core']:GetCoreObject()

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

-- OFFICER VARIABLES
speech = "Normal"

-- DRIVER VARIABLES
driverAttitude = 0
lostIdChance = 0
driverQuestioned = false
driverName = ""

-- TRAFFIC STOP VARIABLES
stoppedVeh = nil
stoppedDriver = nil
stoppedPlate = nil
pitting = false
stopped = false
mimicking = false
search = false
froze = false

local distanceToCheck = 20.0

----------------------
-- Main thread --
-----------------------
function IsPolice(job)
	for k, _ in pairs(Config.PoliceJobs) do
        if job == k then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
	while not LocalPlayer.state['isLoggedIn'] do
		Citizen.Wait(100)
	end		
	local playerData = EGNCore.Functions.GetPlayerData()
	local job = playerData['job']['name']
	if IsPolice(job) then
		Citizen.CreateThread(function()
			while true do
				if IsControlJustPressed(0, kbpomnu) then
					local player = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(player, false)
					if playerVeh then
						local pvPos = GetEntityCoords(playerVeh)
						local inFrontOfPlayerVeh = GetOffsetFromEntityInWorldCoords(playerVeh, 0.0, distanceToCheck, 0.0 )
						local targetVeh = GetVehicleInDirection(pvPos, inFrontOfPlayerVeh)
						if stopped and mimicking then
							if GetEntitySpeedVector(stoppedVeh, true).y ~= 0 then
								EGNCore.Functions.Notify('Wait until vehicle stops to terminate mimic', 'error')
							else
								TriggerEvent('egn-npc:unmimic', targetVeh)
							end
						else
							if IsVehicleSeatFree(targetVeh,-1) and IsVehicleSeatFree(targetVeh,0) or DoesEntityExist(targetVeh) == false then
								-- (vehicle is empty (or doesn't exist), ignore it.)
								EGNCore.Functions.Notify('Vehicle Not Found', 'error')
							else
								if IsVehicleSirenOn(playerVeh) then
									--pullover
									local targetDriver = GetPedInVehicleSeat(targetVeh, -1)
									TriggerEvent('egn-npc:pullover', targetVeh, targetDriver)
								else
									EGNCore.Functions.Notify('Activate siren to initiate a stop', 'error')
								end
							end
						end
					end
				end
				Citizen.Wait(0)
			end
		end)
		------------------------------------
		Citizen.CreateThread(function()
			while true do
				while froze do
					Citizen.Wait(1)
					SetVehicleSteerBias(stoppedVeh, 0.0)
					SetVehicleSteeringAngle(stoppedVeh, 0.0)
					SetVehicleEngineOn(stoppedVeh, false, true, true)
				end
				Wait(1500)
			end
		end)
	end
end)
-- E V E N T S --
RegisterNetEvent('egn-npc:pullover', function(targetVeh, targetDriver)
	EGNCore.Functions.Notify('The target vehicle is being pulled over', 'success')
	Citizen.Wait(1000)
	FreezeEntityPosition(targetVeh, true)
	froze = true
	RollDownWindows(targetVeh)

	local player = PlayerPedId()
	stoppedVeh = targetVeh
	stoppedDriver = targetDriver
	SetEntityHealth(stoppedDriver, 200)
	SetEntityAsMissionEntity(stoppedVeh, true, true)
	local playerPos = GetEntityCoords(player)
	local currentZone = zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]
	SetEntityAsMissionEntity(stoppedVeh, true, true)
	if currentZone == "Davis" or currentZone == "Rancho" or currentZone == "Strawberry" then
		local chanceFlee = math.random(13, 30)
		local chanceShootOrFlee = math.random(2,5)
	elseif IsThisModelABike(stoppedVeh) then
		local chanceFlee = math.random(23, 30)
		local chanceShootOrFlee = 0
	else
		local chanceFlee = math.random(30)
		local chanceShootOrFlee = math.random(5)
	end
	-------------------
	pedGender = GetPedType(stoppedDriver)
	if pedGender == 5 then
		pedGender = 'Female'
	elseif pedGender == 4 then
		pedGender = 'Male'
	else
		pedGender = 'Male'
	end
	
	stoppedPlate = GetVehicleNumberPlateText(stoppedVeh)
	
	if pedGender == "Male" then
		fname = Config.malenames[math.random(#Config.malenames)]
	elseif pedGender == "Female" then
		fname = Config.femalenames[math.random(#Config.femalenames)]
	else
		fname = Config.malenames[math.random(#Config.malenames)]
	end
	
	sname = Config.lastnames[math.random(#Config.lastnames)]
	dfname = fname
	dsname = sname
	dob_y = math.random(1949, 1999)
	dob_m = math.random(1, 12)
	dob_d = math.random(1, 29)
	regOwner = (fname .. " " .. sname)
	fullDob = (dob_m .. "/" .. dob_d .. "/" .. dob_y)
	driverName = regOwner
	fullDriverDob = fullDob	
	regYear = math.random(1990, 2022)		
	flags = "~g~NONE"
	InsuredRand = math.random(8)
	RegisteredRand = math.random(12)
	StolenRand = math.random(24)
	
	if StolenRand == 24 then
		flags = "~r~UNINSURED"
		flags = "~r~STOLEN"
		isStolen = true
	elseif RegisteredRand == 12 then
		flags = "~r~UNREGISTERED"
		regYear = "~r~UNREGISTERED"
	elseif InsuredRand == 8 then
		flags = "~r~UNINSURED"
	end
	
	lostIdChance = math.random(0,100)
	local diffname = math.random(0,100)
	if isStolen == true or diffname > 95 then
		dfname = Config.firstnames[math.random(#Config.firstnames)]
		dsname = Config.lastnames[math.random(#Config.lastnames)]
		ddob_y = math.random(1949, 1999)
		ddob_m = math.random(1, 12)
		ddob_d = math.random(1, 29)
		driverName = (dfname .. " " .. dsname)
		fullDriverDob = (dob_m .. "/" .. dob_d .. "/" .. dob_y)
		chanceFlee = math.random(25, 30)
		chanceShootOrFlee = math.random(2, 5)
		lostIdChance = math.random(80,100)
	end
	
	driverAttitude = math.random(100)
	
	pedFlags = "~g~NONE"
	offRand = math.random(100)
	if  offRand > 75  then
		pedFlags = Config.offense[math.random(#Config.offense)]
		chanceFlee = math.random(25, 30)
		chanceShootOrFlee = math.random(2, 5)
	end
	citations = math.random(-8, 6)
	if citations < 0 then
		citations = 0
	end
	
	breath = math.random(100)
	breathNum = 0
	drunk = false
	if breath > 60 then
		breathNum = math.random(1,7)
		if breath > 88 then
			breathNum = math.random(8,9)
			drunk = true
			chanceFlee = math.random(25, 30)
			if breath > 95 then
				chanceShootOrFlee = math.random(2, 5)
				breathNum = math.random(10,20)
			end
		end
	end
	drugnum_cannabis = math.random(100)
	drugnum_cocaine = math.random(100)
	cannabis = "~g~Negative"
	cocaine = "~g~Negative"
	if drugnum_cannabis > 85 then
		cannabis = "~r~Positive"
		drunk = true
		chanceFlee = math.random(18, 30)
	end
	if drugnum_cocaine > 90 then
		cocaine = "~r~Positive"
		drunk = true
		chanceFlee = math.random(20, 30)
	end	
	local searchNum = math.random(100)
	if searchNum >= 90 then
		search = true
		lostIdChance = math.random(70,100)
	end
	
	local randomHuangChance = math.random(40,90)
	if randomHuangChance == 69 then
		dfname = "Fucking"
		dsname = "Huang"
	end	
	
	driverQuestioned = false
		----------------
	if drunk == true then
		if not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") then
			RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
				while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
					Citizen.Wait(0)
				end
			end
					
		SetPedConfigFlag(stoppedDriver, 100, true)
		SetPedMovementClipset(stoppedDriver, "MOVE_M@DRUNK@VERYDRUNK", 1.0)
	end
	if isStolen == true then
		brokenWindow = math.random(2)
		if brokenWindow == 2 then
			SmashVehicleWindow(stoppedVeh, math.random(3))
		end
	end
	if stoppedVeh == randVeh then
		RemoveBlip(vehBlip)
	end
		----------------
	timeAfterStop = (math.random(5, 30) * 1000)
	timeAfterShoot = (math.random(5, 30) * 1000)
	--[[if chanceFlee == 30 then
		ALPR(stoppedVeh)
		TriggerEvent('egn-npc:flee')
		EGNCore.Functions.Notify('The target vehicle is fleeing!', 'primary')
	elseif chanceFlee == 29 then
			if chanceShootOrFlee == 5 then
				TriggerEvent('egn-npc:stop', stoppedVeh)
				Wait(timeAfterStop)
				TriggerEvent('egn-npc:shoot')
				Wait(timeAfterShoot)
				TriggerEvent('egn-npc:flee')
			else
			isPedGoingToFlee = true
				TriggerEvent('egn-npc:stop', stoppedVeh)
				while (isPedGoingToFlee) do
				Citizen.Wait(0)
					distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(stoppedDriver))
						if distanceToVeh <= 5 and IsPedInAnyVehicle(player) == false then
							stopped = false
							mimicking = false
							lockedin = false
							SetVehicleEngineOn(stoppedVeh, true, false, true)
							Citizen.Wait(5000)
							TriggerEvent("egn-npc:flee")
							isPedGoingToFlee = false
						end
				end
			end
	else]]
	TriggerEvent('egn-npc:stop')
	EGNCore.Functions.Notify('The target vehicle is now stopped', 'success')
	--end
end)

RegisterNetEvent('egn-npc:stop', function()
	fleeing = false
	stopped = true
	ALPR(stoppedVeh)
end)

RegisterCommand("carcheck", function()
	ShowNotification(chanceFlee .. " "	.. chanceShootOrFlee .. " " .. timeAfterStop .. "  " .. timeAfterShoot)
end)

---------------------------------------- NPC INTERACTIONS --------------------------------------------------------
RegisterNetEvent('egn-npc:mimic', function()
	local player = PlayerPedId()
	local playerVeh = GetVehiclePedIsIn(player, false)
	if mimicking then
		TriggerEvent('egn-npc:unmimic')
	else		
		if stopped then				
			if DoesEntityExist(stoppedVeh) then
				RequestAnimDict("misscarsteal3pullover")
				while not HasAnimDictLoaded("misscarsteal3pullover") do
					Citizen.Wait(100)
				end
				FreezeEntityPosition(stoppedVeh, true)
				froze = true
				mimicking = true
				TaskPlayAnim(player, "misscarsteal3pullover", "pull_over_left", 8.0, -8, -1, 49, 0, 0, 0, 0)
				EGNCore.Functions.Notify('The target vehicle is now mimicking you', 'success')
				Citizen.CreateThread(function()
					Citizen.Wait(1100)
					ClearPedSecondaryTask(player)
				end)
				--SetPedIntoVehicle(targetDriver, targetVeh, 0)
				Citizen.Wait(10)
				while mimicking do 
					Citizen.Wait(0)
					SetVehicleEngineOn(stoppedVeh, true, true, false)
					local speedVect = GetEntitySpeedVector(playerVeh, true)
					if speedVect.y > 0 and reverseWithPlayer then
						FreezeEntityPosition(stoppedVeh, false)
						froze = false
						SetVehicleForwardSpeed(stoppedVeh, (GetEntitySpeed(playerVeh) * 1.05))
					elseif speedVect.y < 0 and reverseWithPlayer then
						FreezeEntityPosition(stoppedVeh, false)
						froze = false
						SetVehicleForwardSpeed(stoppedVeh, -1 * GetEntitySpeed(playerVeh))
					elseif speedVect.y == 0 and reverseWithPlayer then
						FreezeEntityPosition(stoppedVeh, true)
						froze = true
					end
					SetVehicleSteeringAngle(stoppedVeh,GetVehicleSteeringAngle(playerVeh))
					--[[if IsPedInAnyVehicle(targetDriver) == false or IsVehicleDriveable(targetVeh, false) == false then
						TriggerEvent('egn-npc:unmimic')
					end]]
					while IsEntityInAir(stoppedVeh) do
						Citizen.Wait(0)
					end
				end
			end
		else
			EGNCore.Functions.Notify('You need to pull over a vehicle first', 'error')
		end
	end
end)

RegisterNetEvent('egn-npc:unmimic', function()
	while GetEntitySpeedVector(stoppedVeh, true).y ~= 0 do
		Wait(250)
	end
	mimicking = false
	FreezeEntityPosition(stoppedVeh, true)
	froze = true	
	Citizen.Wait(100)
	EGNCore.Functions.Notify('The target vehicle is no longer mimicking you', 'success')
	--stopped = true
	Wait(250)
	if GetEntitySpeed(stoppedVeh) <= 1 then
		SetVehicleEngineOn(stoppedVeh, false, false, true)
		SetVehicleSteeringAngle(stoppedVeh, 0.0)
		--SetVehicleFuelLevel(targetVeh, 0)
		RollDownWindows(stoppedVeh)
	end
	Wait(2000)
	--SetPedIntoVehicle(targetDriver, targetVeh, -1)
end)

RegisterNetEvent('egn-npc:client:getplate', function()
	local numPlate = ""	
	if stopped then
		numPlate = tostring(stoppedPlate)
	end
	local plate = KeyboardInput("Enter Plate:", 10, numPlate)
	TriggerEvent("egn-npc:client:runplate", plate)
end)

RegisterNetEvent('egn-npc:client:runplate', function(plate)
	TriggerEvent('radio')
	ShowNotification("~b~LSPD Database: ~w~\nRunning ~o~" .. plate .. "~w~." )
	Wait(2000)
	if stopped then
		ShowNotification("~w~Reg. Owner: ~y~" .. regOwner .. "~w~\nReg. Year: ~y~" .. regYear .. "~w~\nFlags: ~y~" .. flags)
	else
		ShowNotification("~w~Reg. Owner: ~y~" .. rregOwner .. "~w~\nReg. Year: ~y~" .. rregYear .. "~w~\nFlags: ~y~" .. rflags)
		-- This needs more permanent so if a person randomly runs a plate, it'll return the same info each time rather than random info every time
	end
end)

RegisterNetEvent('egn-npc:client:getid', function()
	local driveName = ""
	if stopped and driverQuestioned then
		driveName = tostring(driverName)
	end
	local name = KeyboardInput("Enter Name:", 30, driveName)
	TriggerEvent("egn-npc:client:runid", name)
end)

RegisterNetEvent('egn-npc:client:runid', function(name)
	TriggerEvent('radio')
	ShowNotification("~b~LSPD Database: ~w~\nRunning ~o~" .. name .. "~w~." )
	Wait(2000)
	if stopped then
		ShowNotification("~y~" .. driverName .. "~w~ | ~b~" .. pedGender .. "~w~ | ~b~" .. fullDriverDob .. "\n~w~Citations: ~r~" .. citations .. "\n~w~Flags: ~r~" .. pedFlags)
	else
		ShowNotification("~y~" .. name .. "~w~ | ~b~" .. rfullDriverDob .. "\n~w~Citations: ~r~" .. rcitations .. "\n~w~Flags: ~r~" .. rpedFlags)
	end
end)

RegisterNetEvent('egn-npc:client:setSpeechNormal', function()
	if speech == "Normal" then
		EGNCore.Functions.Notify('Speech is already normal', 'error')
	else
		speech = "Normal"
		EGNCore.Functions.Notify('Speech type changed to normal', 'success')
	end
end)

RegisterNetEvent('egn-npc:client:setSpeechAggressive', function()
	if speech == "Aggressive" then
		EGNCore.Functions.Notify('Speech is already aggressive', 'error')
	else
		speech = "Aggressive"
		EGNCore.Functions.Notify('Speech type changed to aggressive', 'success')
	end
end)

----------------------------------------------------- DIALOGUE ----------------------------------------------------------
RegisterNetEvent('egn-npc:client:hello', function()	
	local player = PlayerPedId()
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(stoppedDriver))
	if distanceToVeh <= 5 then
		RequestAnimDict("gestures@m@sitting@generic@casual")
		while not HasAnimDictLoaded("gestures@m@sitting@generic@casual") do
			Citizen.Wait(100)
		end			
		if speech == "Normal" then
			PlayAmbientSpeechWithVoice(stoppedDriver, "KIFFLOM_GREET", "s_m_y_sheriff_01_white_full_01", "SPEECH_PARAMS_FORCE_SHOUTED", 0)
			TaskPlayAnim(player, "gestures@m@standing@casual", "gesture_hello", 8.0, -8, -1, 49, 0, 0, 0, 0)
			Citizen.CreateThread(function()
				Citizen.Wait(1000)
				ClearPedTasks(player)
			end)
		else
			PlayAmbientSpeechWithVoice(stoppedDriver, "GENERIC_INSULT_HIGH", "s_m_y_sheriff_01_white_full_01", "SPEECH_PARAMS_FORCE_SHOUTED", 0)
			TaskPlayAnim(player, "gestures@m@standing@casual", "gesture_what_hard", 8.0, -8, -1, 49, 0, 0, 0, 0)
			Citizen.CreateThread(function()
				Citizen.Wait(1000)
				ClearPedTasks(player)
			end)
		end
		if breath > 60 then
			EGNCore.Functions.Notify('You smell alcohol from the vehicle', 'primary')
		elseif drugnum_cannabis > 85 then
			EGNCore.Functions.Notify('You smell marijuana from the vehicle', 'primary')
		elseif drugnum_cocaine > 90 then
			EGNCore.Functions.Notify('The driver is acting suspicious', 'primary')
		end
	end
end)

RegisterNetEvent('egn-npc:client:askid', function()
	local player = PlayerPedId()
	local driverResponseID = {}
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(stoppedDriver))
	if distanceToVeh <= 5 then
		if speech == "Normal" then
			local OfficerNormalQuotes = {"Can i see some ID?", "ID, please.", "License and registration."}
			ShowNotification("~o~Officer:~w~ " .. OfficerNormalQuotes[math.random(#OfficerNormalQuotes)])
		else
			local OfficerAggresiveQuotes = {"Show me your ID.", "Give me your ID.", "Give me your fucking license.", "Show me your info."}
			ShowNotification("~o~Officer:~w~ " .. OfficerAggresiveQuotes[math.random(#OfficerAggresiveQuotes)])
		end
		Wait(2000)
		if lostIdChance > 95 then
			ShowNotification("~b~Driver:~w~ Sorry officer, I don't have it on me...")
		else
			if driverAttitude <= 50 then
				driverResponseID = {"Yeah, sure.","Okay, here you go.","There.","Take it, just hurry up please.","*Gives ID*","Okay, here you go.","Sure thing!","Alright, no problem.","Yep, there it is."}
			elseif driverAttitude > 50 and driverAttitude <= 80 then
				driverResponseID = {"Take it, just hurry up please.","I really don't have the time for this...","What was I stopped for again?","Sure thing, did I do something wrong?","Is this necessary?"}
			elseif driverAttitude > 80 then
				driverResponseID = {"Is it because I'm black?","Just take it already...","Uhm.. Sure... Here.","But I've done nothing wrong, sir!", "Pig.", "Why dont you go and fight real crime?"}
			end
			ShowNotification("~b~Driver:~w~ " .. driverResponseID[math.random(#driverResponseID)])
			ShowNotification("~w~Driver's ID: ~y~" .. driverName  .. "~w~\nDOB: ~y~" .. fullDriverDob)
			driverQuestioned = true
		end
	else
		EGNCore.Functions.Notify('You need to be closer to the driver', 'error')
	end
end)

RegisterNetEvent('egn-npc:client:asksearch', function()
	ShowNotification("~o~Officer:~w~ " .. "Would you mind if i search your vehicle?")
	if search == true then
		driverResponseSearch = {"I'd prefer you not to...", "I'll have to pass on that","Uuuh... Y- No..","Go ahead. For the record its not my car","Yeah, why not.."}
	else
		driverResponseSearch = {"Go ahead","Shes all yours","I'd prefer you not to","I don't have anything to hide, go for it."}
	end
	ShowNotification("~b~Driver:~w~ " .. driverResponseSearch[math.random(#driverResponseSearch)])
end)

RegisterNetEvent('egn-npc:client:illegal', function()
	if stopped then
		ShowNotification("~o~Officer:~w~ " .. "Is there anything illegal in the vehicle?")
		driverResponseIllegal = {"No, sir", "Not that I know of.", "Nope.", "No.", "Apart from the 13 dead hookers in the back.. No.", "Maybe? But most probably not.", "I sure hope not"}
		ShowNotification("~b~Driver:~w~ " .. driverResponseIllegal[math.random(#driverResponseIllegal)])
	else
		EGNCore.Functions.Notify('You do not have a stopped vehicle', 'error')
	end	
end)

RegisterNetEvent('egn-npc:client:drug', function()
	if stopped then
		ShowNotification("~o~Officer:~w~ " .. "Have you consumed any drugs recently?")
		if drugnum_cannabis > 85 or drugnum_cocaine > 90 then
			driverResponseDrug = {"What is life?", "Who is me?", "NoOOOooo.", "Is that a UNICORN?!", "If I've done the what?", "WHAT DRUGS? I DONT KNOW KNOW ANYTHING ABOUT DRUGS.", "What's a drug?"}
		else
			driverResponseDrug = {"No, sir", "I don't do that stuff.", "Nope.", "No.", "Nah"}
		end
		ShowNotification("~b~Driver:~w~ " .. driverResponseDrug[math.random(#driverResponseDrug)])
	else
		EGNCore.Functions.Notify('You do not have a stopped vehicle', 'error')
	end	
end)

RegisterNetEvent('egn-npc:client:drunk', function()
	if stopped then
		ShowNotification("~o~Officer:~w~ " .. "Have you had anything to drink today?")
		if drunk == true then
			driverResponseDrunk = {"*Burp*", "What's a drink?", "No.", "You'll never catch me alive!", "Never", "Nope, i don't drink Ossifer", "Maybe?", "Just a few."}
		else
			driverResponseDrunk = {"No, sir", "I dont drink.", "Nope.", "No.", "Only 1.", "Yes... a water and 2 orange juices."}
		end
		ShowNotification("~b~Driver:~w~ " .. driverResponseDrunk[math.random(#driverResponseDrunk)])
	else
		EGNCore.Functions.Notify('You do not have a stopped vehicle', 'error')
	end	
end)

RegisterNetEvent('egn-npc:client:release', function()
	if stopped then
		if speech == "Normal" then
			ShowNotification("~o~Officer:~w~ Alright, you're free to go.")
		else
			ShowNotification("~o~Officer:~w~ Get out of here before i change my mind.")
		end
		if driverAttitude < 50 then
			driverResponseRelease = {"Okay, thanks.","Thanks.","Thank you officer, have a nice day!","Thanks, bye!","I'm free to go? Okay, bye!"}
		elseif driverAttitude > 50 and driverAttitude < 80 then
			driverResponseRelease = {"Alright.","Okay.","Good.","Okay, bye.","Okay, goodbye officer.","Later.","Bye bye.","Until next time."}
		elseif driverAttitude > 80 then
			driverResponseRelease = {"Bye, asshole...","Ugh.. Finally.","Damn cops...","Until next time.","Its about time, pig"}
		end
		ShowNotification("~b~Driver:~w~ " .. driverResponseRelease[math.random(#driverResponseRelease)])
		Wait(6000)
		stopped = false
		mimicking = false
		froze = false
		search = false
		pitting = false
		SetVehicleEngineOn(stoppedVeh, true, false, true)
		FreezeEntityPosition(stoppedVeh, false)
		RemovePedFromGroup(stoppedDriver)
		--TaskVehicleDriveWander(stoppedDriver, stoppedVeh, 40, 447);
		EGNCore.Functions.Notify('Vehicle Released', 'success')
		stoppedVeh = nil
		stoppedDriver = nil
		stoppedPlate = nil
	else
		EGNCore.Functions.Notify('You do not have a stopped vehicle', 'error')
	end		
end)

----------------------------------------------------- INTERACTIONS ----------------------------------------------------------
RegisterNetEvent('egn-npc:client:ticket', function()
	if stopped then
		local ticket = "CODE_HUMAN_MEDIC_TIME_OF_DEATH"
		local player = PlayerPedId()
		local fine = KeyboardInput("Fine:", 10)
		local charge = KeyboardInput("Charge:", 40)
		if not IsPedInAnyVehicle(player) then
			TaskStartScenarioInPlace(player, ticket, 0, 1)
			ShowNotification("~o~Officer:~w~ " .. "I'm issuing you a citation of ~g~ $" .. fine .. " ~w~for ~y~" .. charge)
			if driverAttitude < 50 then
				DriverTicketQuotes = {"Alright..","I understand.","Yeah, thats fine."}
			else
				DriverTicketQuotes = {"Oh come on!","You asshole.","All you cops do is fuck people over.","Go fight real crime."}
			end
			ShowNotification("~o~Driver:~w~ " .. DriverTicketQuotes[math.random(#DriverTicketQuotes)])
			Wait(3000)
			ClearPedTasks(player)
		else
			EGNCore.Functions.Notify('You must leave your car to issue a ticket', 'error')
			return
		end	
		TriggerServerEvent('egn-npc:server:collectFine', fine, charge, driverName)
	else
		EGNCore.Functions.Notify('You must detaim someone to issue a ticket', 'error')
	end
end)

RegisterNetEvent('egn-npc:client:warn', function()
	if stopped then
		if speech == "Normal" then
			officerSays = {"You can go, but don't do it again.","Don't make me pull you over again!","Have a good day. Be a little more careful next time.","I'll let you off with a warning this time."}
		else
			officerSays = {"Don't do that again.","Don't make me pull you over again!","I'll let you go this time.","I'll let you off with a warning this time."}
		end
		if driverAttitude < 50 then
			driverResponseWarn = {"Thanks.","Thank you officer.","Okay, thank you.","Okay, thank you officer.","Thank you so much!","Alright, thanks!","Yay! Thank you!","I'll be more careful next time!","Sorry about that!"}
		elseif driverAttitude > 50 and driverAttitude < 80 then
			driverResponseWarn = {"Thanks... I guess...","Yeah, whatever.","Finally.","Ugh..",}
		elseif driverAttitude > 80 then
			driverResponseWarn = {"Uh huh, bye.","Yeah, whatever.","Finally.","Ugh..","Prick."}
		end
		ShowNotification("~o~Officer:~w~ " .. officerSays[math.random(#officerSays)])
		Wait(2000)
		ShowNotification("~b~Driver:~w~ " .. driverResponseWarn[math.random(#driverResponseWarn)])
	else
		EGNCore.Functions.Notify('You do not have a stopped vehicle', 'error')
	end	
end)

RegisterNetEvent('egn-npc:client:exit', function()
	if stopped then
		player = PlayerPedId()
		--Citizen.CreateThread(function()
			if speech == "Normal" then
				ShowNotification("~o~Officer:~w~ Can you step out of the car for me, please?")
			else
				ShowNotification("~o~Officer:~w~ Get the fuck out of the car.")
			end
			local resistExitChance = math.random(30)
			if isStolen then
				resistExitChance = math.random(28,29)
			end
			--[[fleeAfterExitChance = math.random(10)
			if resistExitChance == 29 or resistExitChance == 25 or isPedGoingToFlee then
				stopped = false
				mimicking = false
				SetVehicleEngineOn(stoppedVeh, true, false, true)
				Citizen.Wait(500)
				local driverResponseResist = {"No way!","Fuck off!","Not today!","Shit!","Uhm.. Nope.","Get away from me!","Pig!","No.","Never!","You'll never take me alive, pig!"}
				ShowNotification("~b~Driver:~w~ ".. driverResponseResist[math.random(#driverResponseResist)])
				Citizen.Wait(5000)
				TriggerEvent("egn-npc:flee")
			else]]
				local driverResponseExit = {"What's the problem?","What seems to be the problem, officer?","Yeah, sure.","Okay.","Fine.","What now?","Whats up?","Ummm... O-okay.","This is ridiculous...","I'm kind of in a hurry right now.","Oh what now?!","No problem.","Am I being detained?","Yeah, okay... One moment.","Okay.","Uh huh.","Yep."}
				ShowNotification("~b~Driver:~w~ " .. driverResponseExit[math.random(#driverResponseExit)])
				TaskLeaveAnyVehicle(stoppedDriver)
				Wait(1000)
				local playerGroupId = GetPedGroupIndex(player)
				SetPedAsGroupMember(stoppedDriver, playerGroupId)
			--end
		--end)
	else
		EGNCore.Functions.Notify('You need to pull over a vehicle first', 'error')
	end
end)

RegisterNetEvent('egn-npc:client:mount', function()
	if stopped then
		ShowNotification("~o~Officer:~w~ Get back in the car, please.")
		--Citizen.CreateThread(function()			
			local player = PlayerPedId()
			local playerGroupId = GetPedGroupIndex(player)
			RemoveGroup(playerGroupId)
			Wait(250)
			TaskEnterVehicle(stoppedDriver,stoppedVeh,15000,-1,1.0,1,0)
			while GetPedInVehicleSeat(stoppedVeh, -1) ~= stoppedDriver do
				Wait(100)
			end
		--end)
	else
		EGNCore.Functions.Notify('You need to pull over a vehicle first', 'error')
	end
end)

RegisterNetEvent('egn-npc:client:breathtest', function()
	local player = PlayerPedId()
	--local playerPos = GetEntityCoords(player)
	local breathPed = nil
	local breathVeh = nil
	local breathNumber = 0
	if stopped then
	--local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(player, 0.0, 5.0, 0.0 ) -- get the ped DIRECTLY IN FRONT OF THE PLAYER (can be hard to get right, need some other way to do this. Maybe get the closest ped to the player)
		breathPed = stoppedDriver
		breathVeh = stoppedVeh
	else
		--TODO NEED TO WORK ON WAYS TO USE BREATHALYZER WHEN NOT PART OF TRAFFIC STOP
	end
	if DoesEntityExist(breathPed) then
		if breathPed == stoppedDriver then
			breathNumber = breathNum
		else
			TriggerEvent('getInfo')
			breathNumber = rbreathNum
		end
		TaskTurnPedToFaceEntity(breathPed, player, 6000)
		Search(player)
		ShowNotification("~w~Performing ~b~Breathalyzer~w~ test...")
		Wait(3000)
		if breathNumber >= 8 then
			ShowNotification("~b~BAC~w~ Level: ~r~0." .. breathNumber)
		else
			ShowNotification("~b~BAC~w~ Level: ~g~0." .. breathNumber)
		end
	else
		if DoesEntityExist(breathVeh) then
			breathDriver = GetPedInVehicleSeat(breathVeh, -1)
			if breathDriver == stoppedDriver then
				breathNumber = breathNum
			else
				TriggerEvent('getInfo')
				breathNumber = rbreathNum
			end
			if DoesEntityExist(breathDriver) then
				ShowNotification("~w~Performing ~b~Breathalyzer~w~ test...")
				Search(player)
				Wait(2000)
				if breathNumber >= 8 then
				ShowNotification("~b~BAC~w~ Level: ~r~0." .. breathNumber)
				else
				ShowNotification("~b~BAC~w~ Level: ~g~0." .. breathNumber)
				end
			end
		else
			EGNCore.Functions.Notify("You don't have a suspect to run this test", 'error')
		end
	end
end)

RegisterNetEvent('egn-npc:client:drugtest', function()
	local player = PlayerPedId()
	--local playerPos = GetEntityCoords(player)
	--local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(player, 0.0, 5.0, 0.0 ) -- get the ped DIRECTLY IN FRONT OF THE PLAYER (can be hard to get right, need some other way to do this. Maybe get the closest ped to the player)
    local drugPed = nil
    local drugVeh = nil
	local marijuana = 0
	local coke = 0
	if stopped then
	--local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(player, 0.0, 5.0, 0.0 ) -- get the ped DIRECTLY IN FRONT OF THE PLAYER (can be hard to get right, need some other way to do this. Maybe get the closest ped to the player)
		drugPed = stoppedDriver
		drugVeh = stoppedVeh
	else
		--TODO NEED TO WORK ON WAYS TO USE BREATHALYZER WHEN NOT PART OF TRAFFIC STOP
	end
	if DoesEntityExist(drugPed) then
		if drugPed == stoppedDriver then
			marijuana = cannabis
			coke = cocaine
		else
			TriggerEvent('getInfo')
			marijuana = rcannabis
			coke = rcocaine
		end
		TaskTurnPedToFaceEntity(drugPed, player, 6000)
		Search(player)
		ShowNotification("~w~Performing a ~b~Drug Screening~w~ test...")
		Wait(3000)
		ShowNotification("~w~Results:\n~b~  Cannabis~w~: " .. marijuana .. "\n~b~  Cocaine~w~: " .. coke)
	else
		if DoesEntityExist(drugVeh) then
			drugDriver = GetPedInVehicleSeat(drugVeh, -1)
			if drugDriver == stoppedDriver then
				marijuana = cannabis
				coke = cocaine
			else
				TriggerEvent('getInfo')
				marijuana = rcannabis
				coke = rcocaine
			end
			if DoesEntityExist(drugDriver) then
				Search(player)
				ShowNotification("~w~Performing a ~b~Drug Screening~w~ test...")
				Wait(3000)
				ShowNotification("~w~Results:\n~b~  Cannabis~w~: " .. marijuana .. "\n~b~  Cocaine~w~: " .. coke)
			end
		else
			EGNCore.Functions.Notify("You don't have a suspect to run this test", 'error')
		end
	end
end)

RegisterNetEvent('egn-npc:client:searchveh', function()
	local player = PlayerPedId()
	local searchVeh = nil
	local searchPed = nil
	if stopped then
		searchVeh = stoppedVeh
		searchPed = stoppedDriver
	else
		local playerPos = GetEntityCoords(player)
		--TODO NEED TO WORK ON WAYS TO USE BREATHALYZER WHEN NOT PART OF TRAFFIC STOP
		--local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(player, 0.0, 5.0, 0.0 ) -- get the ped DIRECTLY IN FRONT OF THE PLAYER (can be hard to get right, need some other way to do this. Maybe get the closest ped to the player)
		--local searchVeh = GetVehicleInDirection(playerPos, inFrontOfPlayer)
		--local searchPed = GetPedInDirection(playerPos, inFrontOfPlayer)
	end	
	if DoesEntityExist(searchVeh) or DoesEntityExist(searchPed) then
		Search(player)
		if DoesEntityExist(searchVeh) and IsEntityAVehicle(searchVeh) then
			ShowNotification("~b~Searching~w~ the vehicle...")
			SetVehicleDoorOpen(searchVeh, 0, false, false)
			SetVehicleDoorOpen(searchVeh, 1, false, false)
			SetVehicleDoorOpen(searchVeh, 2, false, false)
			SetVehicleDoorOpen(searchVeh, 3, false, false)
			SetVehicleDoorOpen(searchVeh, 4, false, false)
			SetVehicleDoorOpen(searchVeh, 5, false, false)
			Citizen.Wait(6000)
			SetVehicleDoorShut(searchVeh, 0, false, false)
			SetVehicleDoorShut(searchVeh, 1, false, false)
			SetVehicleDoorShut(searchVeh, 2, false, false)
			SetVehicleDoorShut(searchVeh, 3, false, false)
			SetVehicleDoorShut(searchVeh, 4, false, false)
			SetVehicleDoorShut(searchVeh, 5, false, false)
		else
			ShowNotification("~b~Searching~w~ the subject...")
			Wait(3000)
		end
		if search == true then
			ShowNotification("~w~Found ~r~"..Config.illegalItems[math.random(#Config.illegalItems)])
			--[[if fleeAfterExitChance == 10 then
				SetVehicleCanBeUsedByFleeingPeds(stoppedVeh, false)
				RemovePedFromGroup(stoppedDriver)
				TaskReactAndFleePed(stoppedDriver, player)
			end]]
		else
			ShowNotification("~w~Found ~g~nothing of interest.")
		end
	else
		EGNCore.Functions.Notify("You don't have a suspect to run this test", 'error')
	end
end)

RegisterCommand("flee", function()
	ShowNotification("*flee debug*")
	TriggerEvent('egn-npc:flee')
end)

RegisterCommand("pit", function()
	if stoppedVeh ~= nil then
		Citizen.CreateThread(function()
		if fleeing == true then
			pitting = false
			local vehicleHash = GetEntityModel(stoppedVeh)
			ShowNotification("~b~Officer:~w~ Requesting permission to pit the ~y~"..GetLabelText(GetDisplayNameFromVehicleModel(vehicleHash)).."~w~.")
			pitWait = math.random(3,10)
			Wait(pitWait * 1000)
			ShowNotification("~b~Permission to pit ~g~GRANTED~w~.")
			pitting = true
			while pitting do
				Citizen.Wait(0)
				if GetEntitySpeed(stoppedVeh) < 5 then
				stopped = true
				SetVehicleUndriveable(stoppedVeh, true)
				SetVehicleEngineHealth(stoppedVeh, -4000)
				mimicking = false
				lockedin = false
				Wait(1000)
				ShowNotification("~b~Pit ~g~SUCCESSFUL~w~.")
				pitting = false
				end
				end
			end
		end)
	end
end)

RegisterNetEvent('egn-npc:flee', function()
	stopped = false
	mimicking = false
	fleeing = true
	if IsVehicleSeatFree(stoppedVeh,-1) then
		TaskShuffleToNextVehicleSeat(stoppedDriver, stoppedVeh)
		Citizen.Wait(2000)
	end
	SetVehicleEngineOn(stoppedVeh, true, false, true)
	SetVehicleCanBeUsedByFleeingPeds(stoppedVeh, true)
	willRam = math.random(5)
	if willRam == 5 then
		TaskVehicleTempAction(stoppedDriver, stoppedVeh, 28, 3000)
	end
	Citizen.Wait(3000)
	
	TaskVehicleTempAction(stoppedDriver, stoppedVeh, 32, 30000)
	--TaskReactAndFleePed(stoppedVeh, player)
	TaskReactAndFleePed(stoppedDriver, player)
end)

RegisterNetEvent('egn-npc:shoot', function()
	stopped = false
	mimicking = false
	local npctol = GetHashKey("WEAPON_COMBATPISTOL")
	TaskLeaveAnyVehicle(stoppedDriver)
	Wait (1000)
	SetEntityAsMissionEntity(stoppedDriver, true, true)
	GiveWeaponToPed(stoppedDriver, npctol, 1000, 0, 1)
	TaskShootAtEntity(stoppedDriver, player, 100000000, GetHashKey('FIRING_PATTERN_FULL_AUTO'))
end)

RegisterCommand("lastalpr", function()
	ALPR(stoppedVeh)
end)

RegisterNetEvent('lastalpr', function()
	ALPR(stoppedVeh)
end)

RegisterCommand("info", function()
	TriggerEvent('getInfo')
	ShowNotification("~w~Reg. Owner: ~y~" .. rregOwner .. "~w~\nReg. Year: ~y~" .. rregYear .. "~w~\nFlags: ~y~" .. rflags)
end)

RegisterNetEvent('getInfo', function()
	rfname = fnamesar[math.random(#fnamesar)]
	rsname = snamesar[math.random(#snamesar)]
	rdob_y = math.random(1949, 1999)
	rdob_m = math.random(1, 12)
	rdob_d = math.random(1, 29)
	rregOwner = (rfname .. " " .. rsname)
	rfullDob = (rdob_m .. "/" .. rdob_d .. "/" .. rdob_y)
	rdriverName = rregOwner
	rfullDriverDob = rfullDob
	rregYear = math.random(1990, 2018)
	
	
	rflags = "~g~NONE"
	rInsuredRand = math.random(8)
	rRegisteredRand = math.random(12)
	rStolenRand = math.random(24)
	
	if rInsuredRand == 8 then
		rflags = "~r~UNINSURED"
	elseif rRegisteredRand == 12 then
		rflags = "~r~UNREGISTERED"
		rregYear = "~r~UNREGISTERED"
	elseif rStolenRand == 24 then
		rflags = "~r~STOLEN"
		risStolen = true
	end	
							
	if risStolen == true then
		rdfname = fnamesar[math.random(#fnamesar)]
		rdsname = snamesar[math.random(#snamesar)]
		rddob_y = math.random(1949, 1999)
		rddob_m = math.random(1, 12)
		rddob_d = math.random(1, 29)
		rdriverName = (rdfname .. " " .. rdsname)
		rfullDriverDob = (rdob_m .. "/" .. rdob_d .. "/" .. rdob_y)
	end
	
	rpedFlags = "~g~NONE";
	roffRand = math.random(100)
	if  roffRand > 75  then
		rpedFlags = Config.offense[math.random(#Config.offense)] 
	end
	rcitations = math.random(-5, 6)
	if rcitations < 0 then
		rcitations = 0
	end
	
	rbreath = math.random(100)
	rbreathNum = 0
	if rbreath > 60 then
		rbreathNum = math.random(1,7)
		if rbreath > 88 then
			rbreathNum = math.random(8,9)
			if rbreath > 95 then
				rbreathNum = math.random(10,20)
			end
		end
	end
	
	rdrugnum_cannabis = math.random(100)
	rdrugnum_cocaine = math.random(100)
	rcannabis = "~g~Negative"
	rcocaine = "~g~Negative"
	if rdrugnum_cannabis > 85 then
		rcannabis = "~r~Positive"
	end
	if rdrugnum_cocaine > 90 then
		rcocaine = "~r~Positive"
	end
	
end)

RegisterNetEvent('getFlags', function()
	TriggerEvent('getInfo')
	ShowNotification("~w~Reg. Owner: ~y~" .. rregOwner .. "~w~\nReg. Year: ~y~" .. rregYear .. "~w~\nFlags: ~y~" .. rflags)
end)

RegisterNetEvent('radio', function(player)
    Citizen.CreateThread(function()
		local player = PlayerPedId()
		loadAnimDict("random@arrests")
        TaskPlayAnim(player, "random@arrests", "generic_radio_enter", 1.5, 2.0, -1, 50, 2.0, 0, 0, 0 )
		Citizen.Wait(6000)
		ClearPedTasks(player)
    end)
end)
	
-- F U N C T I O N S --
	
	-- Gets a vehicle in a certain direction
	-- Credit to Konijima
function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, player, 0 )
    local _, _, _, _, targetVeh = GetRaycastResult( rayHandle )
    return targetVeh
end

function KeyboardInput(TextEntry, MaxStringLenght, DefaultText)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', DefaultText, '', '', '', MaxStringLenght)
	BlockInput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local Result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		BlockInput = false
		return Result
	else
		Citizen.Wait(500)
		BlockInput = false
		return nil
	end
end

function Search(player)
	local search = "PROP_HUMAN_BUM_BIN"
	if not IsPedInAnyVehicle(player) then
		TaskStartScenarioInPlace(player, search, 0, 1)
		Wait(4000)
		ClearPedTasks(player)
	else
		EGNCore.Functions.Notify('You must leave your car to conduct test', 'error')
	end
end

function titleCase(first, rest)
   return first:upper()..rest:lower()
end

	-- Shows a notification on the player's screen 
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function ALPR(vehicle)
	local vehicleHash = GetEntityModel(vehicle)
	local numPlate = GetVehicleNumberPlateText(vehicle)
		
	ShowNotification("Getting vehicle information...")
	Wait(2000)
	ShowNotification("~b~LSPD Database:~w~\nPlate: ~y~" .. numPlate .. "~w~\nModel: ~y~"..GetLabelText(GetDisplayNameFromVehicleModel(vehicleHash)) .. "~w~\nVehicle class: ~y~" .. Config.carType[GetVehicleClass(vehicle)])
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end
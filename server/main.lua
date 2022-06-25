local EGNCore = exports['egn-core']:GetCoreObject()

RegisterNetEvent('egn-npc:server:collectFine', function(fine, charge, npc)
	local src = source
	local Player = EGNCore.Functions.GetPlayer(src)	
	local fine = tonumber(fine)
	local charges = charge
	local npc = npc
	if Player then
		local fName = Player.PlayerData.charinfo['firstname']
		local lName = Player.PlayerData.charinfo['lastname']
		local fullName = (fName.." "..lName)
		local station = Player.PlayerData.job.name
		TriggerClientEvent('EGNCore:Notify', src, "$"..fine.." was collected from "..npc..".", "success")
		exports['egn-management']:AddMoney(station, fine)
		TriggerEvent("egn-log:server:CreateLog", "fines", "NPC Fine paid", "green", fullName.. " collected $" ..fine.. " from "..npc.." for "..charge..". Fine collected by "..station)
	end
end)
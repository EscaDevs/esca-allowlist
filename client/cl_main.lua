local admin = "not"
local adminauth = "not"
local password = "not"

RegisterNetEvent("ui_fix")
AddEventHandler("ui_fix",function()
	closeNUI()
end)

RegisterCommand('allowlist', function()
    SetNuiFocus(true, true)

	SendNUIMessage({action = "openUI"})
end)


function closeNUI()
	SetNuiFocus(false, false)
	SendNUIMessage({action = "closeUI"})
end


RegisterNetEvent('Allowlist_success')
AddEventHandler('Allowlist_success', function(name, auth, pass)
	SendNUIMessage({action = 'success'})
	admin = name
	adminauth = auth
	password = pass
end)

RegisterNetEvent('Error_username')
AddEventHandler('Error_username', function(name, auth)
	SendNUIMessage({action = 'error_username'})
end)

RegisterNetEvent('Error_password')
AddEventHandler('Error_password', function(name, auth)
	SendNUIMessage({action = 'error_password'})
	password = "not"
end)

RegisterNetEvent('Allowlist_already')
AddEventHandler('Allowlist_already', function(name, auth)
	SendNUIMessage({action = 'adderror_already'})
end)

RegisterNetEvent('Allowlist_added')
AddEventHandler('Allowlist_added', function(name, auth)
	SendNUIMessage({action = 'addsucces'})
end)


RegisterNUICallback('login', function(data, cb)
	TriggerServerEvent("Allowlist_login", data.usernam, data.pass)
end)


RegisterNUICallback('add', function(data, cb)
	if adminauth == "add" or adminauth == "all" then
		TriggerServerEvent("Allowlist_add", data.hex, data.nick, admin, password)
	else
		SendNUIMessage({action = 'adderror_auth'})
	end
end)


RegisterNUICallback('remove', function(data, cb)
	if adminauth == "remove" or adminauth == "all" then
		SendNUIMessage({
			action = 'removed',
			hex = data.hex
		})
		TriggerServerEvent("Allowlist_removed",data.hex,password)
	else
		SendNUIMessage({action = 'notremoved'})
	end
end)


RegisterNUICallback('reload', function(data, cb)
	TriggerServerEvent("Allowlist_reload")
end)

RegisterNUICallback('list', function(data, cb)
	TriggerServerEvent("GetList_Server")
end)

RegisterNetEvent("GetList_Client")
AddEventHandler("GetList_Client",function(data)
	SendNUIMessage({
		action = 'list',
		db = data

	})

end)

RegisterNUICallback('close', function(data, cb)
	SendNUIMessage({action = 'kapat'})
	closeNUI()
end)



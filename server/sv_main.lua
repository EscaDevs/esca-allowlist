
local res = "null"
Allowlist = {}

RegisterServerEvent("Allowlist_login")
AddEventHandler("Allowlist_login",function(username, password)
    local src = source
    local res = MySQL.Sync.fetchAll("SELECT * FROM allowlist_admin WHERE username = @username",
    {
        ['@username'] = username,
        ['@password'] = password
    })
    
	if json.encode(res) == "[]" then
        TriggerClientEvent("Error_username",src)
	    return
    elseif res[1].username == username and res[1].password == password then
	    TriggerClientEvent("Allowlist_success", src, res[1].admin_name ,res[1].auth, res[1].password)
	else
        TriggerClientEvent("Error_password",src)
	end
	
end)

RegisterServerEvent("Allowlist_add")
AddEventHandler("Allowlist_add",function(hex, nickname,admin, pass)
    local src = source
    local data = MySQL.Sync.fetchAll("SELECT hex FROM allowlist WHERE hex = @hex",{['@hex'] = hex})
    local check = MySQL.Sync.fetchAll("SELECT auth FROM allowlist_admin WHERE password = @password",
    {
        ['@password'] = pass
    })

    if json.encode(check) ~= "[]" then 
        if json.encode(data) == "[]" then
            MySQL.Async.execute('INSERT INTO allowlist (hex, nickname, adminname) VALUES (@hex, @nickname, @adminname)', {
                ['@hex'] = hex,
                ['@nickname'] = nickname,
                ['@adminname'] = admin
            })
            table.insert(Allowlist, hex)
            TriggerClientEvent("Allowlist_added",src)
        else
            TriggerClientEvent("Allowlist_already",src)
        end
    end
end)

RegisterServerEvent("Allowlist_removed")
AddEventHandler("Allowlist_removed",function(hex,pass)
    local src = source
    MySQL.Async.execute("DELETE FROM allowlist WHERE hex = @hex",
    {
        ["@hex"] = hex
    })
    local check = MySQL.Sync.fetchAll("SELECT auth FROM allowlist_admin WHERE password = @password",
    {
        ['@password'] = pass
    })
    if json.encode(check) ~= "[]" then 
        for i = 1, #Allowlist, 1 do
            if Allowlist[i] == hex then
                table.remove(Allowlist, i)
                break
            end
        end
    end
end)

RegisterServerEvent("GetList_Server")
AddEventHandler("GetList_Server",function()
    local src = source
    local data = MySQL.Sync.fetchAll("SELECT * FROM allowlist ",{})
    TriggerClientEvent("GetList_Client",src,data)
end)

RegisterServerEvent("Allowlist_reload")
AddEventHandler("Allowlist_reload",function()
    for i = 0, #Allowlist do
        Allowlist[i] = nil
    end

    initAllowlist()
    RconPrint("[Allowlist] Reloaded")

end)


RegisterCommand("rconreloadwl", function(source, args, rawCommand)
    for i = 0, #Allowlist do
        Allowlist[i] = nil
    end

    initAllowlist()
    RconPrint("[Allowlist] Reloaded")
end, true)

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    deferrals.defer()

    local source = source

    deferrals.update("Allowlist Checking...")

    Citizen.Wait(300)

    local Identifiers = GetPlayerIdentifiers(source)
    
    if not has_value(Allowlist, Identifiers[1]) and not has_value(Allowlist, Identifiers[2]) then
        deferrals.done("discord.gg/XXXXXX for Allowlist")
        CancelEvent()
        return
    else
        deferrals.done()
    end
end)


function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    
    return false
end



function initAllowlist()
    MySQL.Async.fetchAll('SELECT hex FROM allowlist', {}, function(result)
        for i = 1, #result, 1 do
            table.insert(Allowlist, tostring(result[i].hex):lower())
        end
    end)
end


MySQL.ready(function()
    initAllowlist()
end)

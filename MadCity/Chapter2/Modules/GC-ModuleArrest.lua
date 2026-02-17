local arrestid = {}
local lastGCUpdate = 0
local GC_UPDATE_INTERVAL = 5

local function getgc_module(input, andlist, orlist)
    input = input or false
    andlist = andlist or {}
    orlist = orlist or {}
    local output = {}
    for _,v in pairs(getgc(input)) do
        if input and type(v) == "table" then
            local isLegit = true
            for _,andItem in pairs(andlist) do
                if rawget(v, andItem) == nil then
                    isLegit = false
                end
            end
            if isLegit then
                if #orlist == 0 then
                    table.insert(output, v)
                else
                    for _,orItem in pairs(orlist) do
                        if rawget(v, orItem) ~= nil then
                            table.insert(output, v)
                            break
                        end
                    end
                end
            end
        elseif not input then
            table.insert(output, v)
        end
    end
    return output
end

local function findproxID()
    local currentTime = os.clock()
    if currentTime - lastGCUpdate < GC_UPDATE_INTERVAL then
        return arrestid
    end
    lastGCUpdate = currentTime
    
    local RunService = game:GetService("RunService")
    local count = 0
    
    for _,v in pairs(getgc_module(true, {"Name", "OriginObject", "ID"})) do
        if (rawget(v, "Name") == "player_interaction_arrest" or rawget(v, "Name") == "player_interaction_eject") and rawget(v, "OriginObject").Parent then
            local found = false
            local key = rawget(v, "OriginObject").Parent.Name..rawget(v, "Name")
            local id = tostring(rawget(v, "ID"))
            
            for _, ARREST_ID in pairs(arrestid) do
                if ARREST_ID[1] == key and ARREST_ID[2] == id then
                    found = true
                    break
                end
            end
            
            if not found then
                table.insert(arrestid, {key, id})
            end
        end
        
        count = count + 1
        if count % 50 == 0 then
            RunService.Heartbeat:Wait()
        end
    end
    
    return arrestid
end

_G.GCModule = {
    update = findproxID,
    getIDs = function() return arrestid end
}

return _G.GCModule

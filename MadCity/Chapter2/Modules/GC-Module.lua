return function(input, andlist, orlist)
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

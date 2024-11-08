function clamp(value, min, max)
    return math.max(min, math.min(value, max))
end

function scaleToRange(value)
    value = tonumber(string.format("%.2f", ((value - 1) * 2) / 98 - 1))
    return clamp(value, -1.0, 1.0)
end

function normalize(value)
    value = tonumber(string.format("%.2f", value / 100))
    return clamp(value, 0, 1.0)
end

function getFileName()
    local info = debug.getinfo(2, "S")
    local full_path = info.source:sub(2)
    local file_name_with_extension = full_path:match("([^/]+)$")
    local file_name = file_name_with_extension:match("(.+)%..+$")
    return file_name
end
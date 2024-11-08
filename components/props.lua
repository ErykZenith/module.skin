local filename = getFileName()
local template = game_character.templates[filename]

function game_character:getProps()
    if not self.character[filename] then
        return nil
    end
    return self.character[filename]
end

function game_character:getLimitedProps(data)
    local result = {}
    for _, index in pairs(template) do
        if data[index] then
            local drawableId = GetNumberOfPedPropDrawableVariations(self.ped, index) - 1
            local texture = GetNumberOfPedPropTextureVariations(self.ped, index, math.min(data[index][1] or 0, drawableId)) - 1
            if 
                drawableId > -1 or 
                texture > -1 
            then
                result[index] = { 
                    drawableId > -1 and drawableId or nil, 
                    texture > -1 and texture or nil 
                }
            end
        end
    end
    return result
end

function game_character:setProps(data)
    if not data then 
        return error("data is nil")
    end
    self:resetProps()
    local limit = self:getLimitedProps(data)
    for index, value in pairs(data) do
        local drawableId = clamp(value[1] or -1, -1, limit[index][1] or -1)
        local texture = clamp(value[2] or -1, -1, limit[index][2] or -1)
        if 
            drawableId > -1 or 
            texture > -1 
        then
            self.character[filename][index] = { 
                drawableId > -1 and drawableId or nil, 
                texture > -1 and texture or nil 
            }
        end
        SetPedPropIndex(self.ped, componentId, componentId == 1 and drawableId or drawableId-1, texture, 0)    
    end
    return data
end

function game_character:resetProps()
    for _, index in pairs(template) do
        ClearPedProp(self.ped, index)
    end
    self.character[filename] = {}
    return true
end
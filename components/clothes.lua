local filename = getFileName()
local template = game_character.templates[filename]

function game_character:getClothes()
    if not self.character[filename] then
        return nil
    end
    return self.character[filename]
end

function game_character:getLimitedClothes(data)
    local result = {}
    for _, index in pairs(template) do
        if data[index] then
            local drawableId = GetNumberOfPedDrawableVariations(self.ped, index) - 1
            local texture = GetNumberOfPedTextureVariations(self.ped, index, math.min(data[index][1] or 0, drawableId)) - 1
            if 
                drawableId > 0 or 
                texture > 0 
            then
                result[index] = { 
                    drawableId > 0 and drawableId or nil, 
                    texture > 0 and texture or nil 
                }
            end
        end
    end
    return result
end

function game_character:setClothes(data)
    if not data then 
        return error("data is nil")
    end
    self:resetClothes()
    local limit = self:getLimitedClothes(data)
    for index, value in pairs(data) do
        local drawableId = clamp(value[1] or 0, 0, limit[index][1] or 0)
        local texture = clamp(value[2] or 0, 0, limit[index][2] or 0)
        if 
            drawableId > 0 or 
            texture > 0 
        then
            self.character[filename][index] = { 
                drawableId > 0 and drawableId or nil, 
                texture > 0 and texture or nil 
            }
        end
        SetPedComponentVariation(self.ped, index, drawableId, texture, 0)
    end
    return self.character[filename]
end

function game_character:resetClothes()
    SetPedDefaultComponentVariation(self.ped)
    self.character[filename] = {}
    return true
end
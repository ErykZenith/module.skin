local filename = getFileName()
local template = game_character.templates[filename]

function game_character:getFaces()
    if not self.character[filename] then
        return nil
    end
    return self.character[filename]
end

function game_character:getLimitedFaces()
    local result = {
        [-3]=GetNumHairColors() - 1,
        [-2]=31,
        [-1]=45,
    }
    return result
end

function game_character:setFaces(data)
    if not data then 
        return error("data is nil")
    end
    self:resetFaces()
    local limit = self:getLimitedFaces()
    if data[-1] then
        local headBlendData = clamp(data[-1] or 0, 0, limit[-1])
        self.character[filename][-1] = headBlendData > 0 and headBlendData or nil
        SetPedHeadBlendData(self.ped, headBlendData, headBlendData, 0, 0, 0, 0, 1.0, 1.0, 0.0, false)
        data[-1] = nil
    end
    if data[-2] then
        local eyeColor = clamp(data[-2] or 0, 0, limit[-2])
        self.character[filename][-2] = eyeColor > 0 and eyeColor or nil
        SetPedEyeColor(self.ped, eyeColor)
        data[-2] = nil
    end
    if data[-3] then
        local colorID = clamp(data[-3][1] or 0, 0, limit[-3])
        local hairColor = clamp(data[-3][2] or 0, 0, limit[-3])
        self.character[filename][-3] = {
            colorID > 0 and colorID or nil,
            hairColor > 0 and hairColor or nil
        }
        SetPedHairTint(self.ped, colorID, hairColor)
        data[-3] = nil
    end
    for index, value in pairs(data) do
        value = clamp(value, 0, 100)
        local set = scaleToRange(value)
        self.character[filename][index] = value ~= 50 and value or nil
        SetPedFaceFeature(self.ped, index, set + 0.0)
    end
    return data
end

function game_character:resetFaces()
    SetPedHairTint(self.ped, 0, 0)
    SetPedEyeColor(self.ped, 0)
    SetPedHeadBlendData(self.ped, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.0, false)
    for _, index in pairs(template) do
        SetPedFaceFeature(self.ped, index, 0)
    end
    self.character[filename] = {}
    return true
end
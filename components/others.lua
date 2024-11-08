local filename = getFileName()
local template = game_character.templates[filename]

function game_character:getOthers()
    if not self.character[filename] then
        return nil
    end
    return self.character[filename]
end

function game_character:getLimitedOthers()
    local colors = GetNumHairColors() - 1
    local result = {
        [-1]=colors,
        [1]={28,1},
        [2]={331,1},
        [4]={74,2},
        [5]={6,2},
        [8]={9,1},
        [10]={16,1},
    }
    return result
end

function game_character:setOthers(data)
    if not data then 
        return error("data is nil")
    end
    self:resetOthers()
    local limit = self:getLimitedOthers()
    for index, value in pairs(data) do
        local overlayValue = clamp(value[1] or 0, 0, limit[index][1] or 0)
        local overlayOpacityValue = clamp(value[2] or 0, 0, 100)
        local overlayOpacity = normalize(overlayOpacityValue)
        local firstColour = clamp(value[3] or 0, 0, limit[-1] or 0)
        local secondColour = clamp(value[4] or 0, 0, limit[-1] or 0)
        self.character[filename][index] = {
            overlayValue > 0 and overlayValue or nil,
            overlayOpacity > 0 and overlayOpacityValue or nil,
            firstColour > 0 and firstColour or nil,
            secondColour > 0 and secondColour or nil
        }
        SetPedHeadOverlayColor(self.ped, index, limit[index][2], overlayValue, firstColour, secondColour)
        SetPedHeadOverlay(self.ped, index, overlayValue, overlayOpacity)
    end
    return data
end

function game_character:resetOthers()
    for _, index in pairs(template) do
        SetPedHeadOverlayColor(self.ped, index, 0, 0)
        SetPedHeadOverlay(self.ped, index, 0, 0)
    end
    self.character[filename] = {}
    return true
end
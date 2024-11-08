local filename = getFileName()
local template = game_character.templates[filename]

function game_character:resetPlayerModel(gender)
    if gender ~= 1 and gender ~= 0 then
        return error("gender must be 0 or 1")
    end
    for model, index in pairs(template) do
        if gender == index then
            return self:setPlayerModel(model)
        end
    end
    return error("gender not found")
end

function game_character:setPlayerModel(model)
    if type(model) == "string" then
        model = GetHashKey(model)
    end
    local time = GetGameTimer() + 3000
    RequestModel(model)
    while not HasModelLoaded(model) and time > GetGameTimer() do
        Wait(0)
    end
    if GetGameTimer() > time then 
        return error("model not loaded") 
    end
    if IsModelInCdimage(model) and IsModelValid(model) then
        SetPlayerModel(PlayerId(), model)
        self.ped = PlayerPedId()
        self:newCharacter()
        SetModelAsNoLongerNeeded(model)
        return true
    end
    return error("model not valid")
end

function game_character:getModel()
    local model = GetEntityModel(PlayerPedId())
    if template[model] then
        return template[model]
    end
    return model
end

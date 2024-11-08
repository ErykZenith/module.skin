game_character = {}
game_character.__index = game_character
game_character.templates = {
    others={
        BLEMISHES=0,
        FACIALHAIR=1,
        EYEBROWS=2,
        AGEING=3,
        MAKEUP=4,
        BLUSH=5,
        COMPLEXION=6,
        SUNDAMAGE=7,
        LIPSTICK=8,
        MOLESFRECKLES=9,
        CHESTHAIR=10,
        BODYBLEMISHES=11,
        ADDBODYBLEMISHES=12
    },
    faces={
        HAIRCOLOR=-3,
        EYECOLOR=-2,
        FACE=-1,
        NOSEWIDTH=0,
        NOSEPEAK=1,
        NOSELENGTH=2,
        NOSEBONECURVENESS=3,
        NOSETIP=4,
        NOSEBONETWIST=5,
        EYEBROW=6,
        EYEBROWINOUT=7,
        CHEEKBONES=8,
        CHEEKSIDEWAYSBONESIZE=9,
        CHEEKBONESWIDTH=10,
        EYEOPENING=11,
        LIPTHICKNESS=12,
        JAWBONEWIDTH=13,
        JAWBONESHAPE=14,
        CHINBONE=15,
        CHINBONELENGTH=16,
        CHINBONESHAPE=17,
        CHINHOLE=18,
        NECKTHICKNESS=19
    },
    clothes={
        BEARD=1,
        HAIR=2,
        UPPER=3,
        LOWER=4,
        HAND=5,
        FEET=6,
        TEETH=7,
        ACCESSORIES=8,
        TASK=9,
        DECL=10,
        JBIB=11
    },
    props={
        HEAD=0,
        EYES=1,
        EARS=2,
        MOUTH=3,
        LEFTHAND=4,
        RIGHTHAND=5,
        LEFTWRIST=6,
        RIGHTWRIST=7,
        HIP=8,
        LEFTFOOT=9,
        RIGHTFOOT=10,
        PHLHAND=11,
        PHRHAND=12,
        ANCHORS=13
    },
    models={
        [1885233650]=0, --mp_m_freemode_01 (default)
        [-1667301416]=1, --mp_f_freemode_01 (default)
    }
}

function game_character:create(ped)
    local instance = setmetatable({}, game_character)
    instance.ped = ped
    game_character:newCharacter()
    return instance
end

function game_character:newCharacter()
    self.character = {
        model = self:getModel(),
        clothes = {},
        props = {},
        faces = {},
        others = {}
    }
    SetPedDefaultComponentVariation(self.ped)
end

function game_character:mapNameToId(typeName, data)
    if not self.templates[typeName] then
        return error("typeName not found")
    end
    if not data then 
        return error("data is nil")
    end
    local result = {}
    for name, value in pairs(data) do
        local index = self.templates[typeName][name]
        if index then
            result[index] = value
        end
    end
    return result
end

function game_character:exportCharacter()
    local clothes, props, faces, others = self:getClothes(), self:getProps(), self:getFaces(), self:getOthers()
    local result = {
        self.character.model,
        self:tableToString(clothes),
        self:tableToString(props),
        self:tableToString(faces),
        self:tableToString(others)
    }
    result = table.concat(result, "|")
    return result
end

function game_character:importCharacter(str)
    local model, clothes, props, faces, others = self:stringToTable(str)
    if model ~= self.character.model then
        self:setPlayerModel(model)
    end
    if clothes then
        self:setClothes(clothes)
    end
    if props then
        self:setProps(props)
    end
    if faces then
        self:setFaces(faces)
    end
    if others then
        self:setOthers(others)
    end
    return true
end

function game_character:tableToString(data)
    if not data then 
        return ""
    end
    if type(data) == "number" then
        return tostring(data)
    end
    local parts = {}
    for key, values in pairs(data) do
        local part = tostring(key) .. "*"
        if type(values) == "table" then
            local subParts = {}
            for i, value in ipairs(values) do
                table.insert(subParts, "^" .. i .. ">" .. value)
            end
            part = part .. table.concat(subParts, ":")
        else
            part = part .. tostring(values)
        end
        part = part .. ";"
        table.insert(parts, part)
    end
    return table.concat(parts)
end

function game_character:stringToTable(str)
    if not str then 
        return nil
    end

    local sections = {}
    local initialNumber = str:match("^(%d+)|")
    if initialNumber then
        table.insert(sections, tonumber(initialNumber))
        str = str:gsub("^%d+|", "", 1)
    end

    for section in str:gmatch("[^|]*") do
        local sectionData = {}
        
        if section ~= "" then
            for keyStr, valueStr in section:gmatch("([^*]+)%*(.-);") do
                local key = tonumber(keyStr)
                if not key then goto continue end

                if valueStr:find("%^") then
                    local subTable = {}
                    for indexStr, valueStr in valueStr:gmatch("%^([^>]+)>([^:]+)") do
                        local index = tonumber(indexStr)
                        local value = tonumber(valueStr)
                        if index and value then
                            table.insert(subTable, value)
                        end
                    end
                    sectionData[key] = subTable
                else
                    local value = tonumber(valueStr)
                    if value then
                        sectionData[key] = value
                    end
                end
                ::continue::
            end
        else
            sectionData[#sectionData + 1] = {}
        end

        table.insert(sections, sectionData)
    end

    return table.unpack(sections)
end

function importModule()
    return game_character
end

exports("importModule", importModule)
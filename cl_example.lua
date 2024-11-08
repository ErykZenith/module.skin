local game_character = importModule() --export["module.skin"]:importModule()
local character = game_character:create(PlayerPedId())
character:resetPlayerModel(0)

-- example of setskin
custom_clothes = character:mapNameToId("clothes", {
    JBIB={20, 1},
    ACCESSORIES={1,1},
    UPPER={1, 2},
    LOWER={0, 1},
    HAIR={1, 0},
    FEET={5, 1},
    BEARD={1, 1},
    HAND={1, 1},
    TEETH={1, 1},
    TASK={1, 1},
    DECL={1, 1},
})
custom_prop = character:mapNameToId("props", {
    GLASSES={1, 1},
    HELMET={1, 1},
    EARS={1, 1},
    WATCHES={1, 1},
    BRACELET={1, 1}
})
custom_faces = character:mapNameToId("faces", {
    FACE=1,
    EYECOLOR=60,
    HAIRCOLOR={2, 1},
    NOSEWIDTH=100,
})
custom_others = character:mapNameToId("others", {
    FACIALHAIR={2, 100, 1, 1},
    EYEBROWS={2, 100, 1, 1},    
    MAKEUP={2, 100, 1, 10},
    BLUSH={2, 100, 1, 1},
    LIPSTICK={2, 100, 1, 1},
    CHESTHAIR={2, 100, 1, 1},
})
character:setClothes(custom_clothes)
character:setProps(custom_prop)
character:setFaces(custom_faces)
character:setOthers(custom_others)
-- example of save and load
local clothes, props, faces, others = character:getClothes(), character:getProps(), character:getFaces(), character:getOthers()
local save = {character.character.model,clothes, props, faces, others}
TriggerServerEvent("character:save", save)
-- example of export and import
Wait(1000)
local export = character:exportCharacter()
character:resetPlayerModel(0)
print(export)
Wait(1000)
character:importCharacter(export)
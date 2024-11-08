# module.skin
Fivem Skin Module
# module.skin

`module.skin` is a module designed for managing character skins and appearance in FiveM, allowing for easy customization and management of player skins. Ideal for FiveM server developers who need detailed control over character customization.

## Features
- **Character Skin and Appearance Management:** Customize various character aspects, including clothing, hair, facial features, and more.
- **Flexible Data Structure:** Allows for complex skin data storage and creating custom skin templates.
- **Export and Import Skins:** Easily export and import skin data to share or back up player appearance.
- **Lightweight Data Handling:** Optimized to handle small data packets, ensuring efficient performance and reduced resource usage.

### Core Functions
- **game_character:getClothes()**

`Retrieves the current clothes data for the character.
Parameters: None
Returns: A table of clothes data or nil if no clothes data is available.`

- **game_character:getLimitedClothes(data)**

`Retrieves limited clothes variations based on available drawable and texture limits for each component.
Parameters:
data (table): The data table containing clothes component IDs and their values.
Returns: A table of limited clothes variations with drawable and texture IDs set to their limits if available, or nil otherwise.`

- **game_character:setClothes(data)**

`Sets the character’s clothes based on the provided data, applying limits on drawable and texture values.
Parameters:
data (table): The table containing drawable and texture IDs for clothes components.
Returns: The updated character clothes table or an error if data is nil.`

- **game_character:resetClothes()**

`Resets the character’s clothes to default by setting all components to default variations.
Parameters: None
Returns: true upon successful reset.`

- **game_character:getProps()**

`Retrieves the character's current prop data, such as accessories or other add-ons. Parameters: None Returns: A table containing the character’s prop data for the current filename or nil if no data is set.`

- **game_character:getLimitedProps(data)**

`Determines the maximum drawable and texture variations for each prop based on the character's current setup. Parameters: data (table) - Contains the initial prop data, specifying drawable and texture values for each prop. Returns: A table with the maximum allowable drawable and texture values for each prop index.`

- **game_character:setProps(data)**

`Sets the character's props, such as accessories, based on the provided data while adhering to the limitations obtained from getLimitedProps. Parameters: data (table) - Contains drawable and texture values for each prop. Throws an error if data is nil. Returns: The updated prop data as a table.`

- **game_character:resetProps()**

Resets all character props to their default state by clearing each prop index. Parameters: None Returns: true upon successful reset of all props.

- **game_character:getFaces()**

`Retrieves the character’s current face feature data. Parameters: None Returns: A table containing the character’s face feature data or nil if no data is set.`

- **game_character:getLimitedFaces()**

`Defines the limits for specific face features such as maximum hair colors, eye colors, and head blends. Parameters: None Returns: A table with the maximum allowable values for hair color, eye color, and head blend options.`

- **game_character:setFaces(data)**

`Sets the character’s face features based on the provided data, adhering to the limits defined in getLimitedFaces. Parameters: data (table) - Contains the values for face features, including eye color, hair color, and specific face adjustments. Returns: The updated face feature data as a table or throws an error if data is nil.`

- **game_character:resetFaces()**

`Resets all face features of the character to their default values, including hair and eye color, head blend, and any additional face features. Parameters: None Returns: true upon successful reset of all face features.`

- **game_character:getOthers()**

`Retrieves the character's current "others" data, which may include overlays, colors, and other customization details. Parameters: None Returns: A table containing the character’s "others" data for the current filename, or nil if no data is set.`

- **game_character:getLimitedOthers()**

`Determines the maximum allowable values for specific overlays, colors, and other customizations. Parameters: None Returns: A table with the limits for overlay values, opacity, and color values for different customization indices.`

- **game_character:setOthers(data)**

`Sets the character's "others" properties, including overlays and colors, based on the provided data. Parameters: data (table) - Contains values for overlays, opacity, and colors for each customization index. Throws an error if data is nil. Returns: The updated "others" data as a table.`

- **game_character:resetOthers()**

`Resets all "others" properties to their default state, clearing overlays and colors for each index. Parameters: None Returns: true upon successful reset of all "others" properties.`

- **game_character:mapNameToId(typeName, data)**

`Maps names to IDs based on the specified type template (e.g., clothes, faces).
Parameters:
typeName (string): The type template name (e.g., "clothes", "faces").
data (table): The data table containing names and values to be mapped.
Returns: A mapped table with IDs as keys and original values, or an error if typeName or data is nil.`

- **game_character:resetPlayerModel(gender)**

`Resets the player's model based on the specified gender. Parameters:

gender (number): Accepts 0 or 1 (0 for male, 1 for female).
Returns: Sets the player model corresponding to the gender if found; returns an error if the gender is invalid or not found in the template.`

- **game_character:setPlayerModel(model)**

`Sets the player's model to the specified model name or hash. Parameters:

model (string | number): Accepts either the model name as a string or a model hash as a number.
Returns: true if the model is successfully set; returns an error if the model is invalid or fails to load.`

- **game_character:getModel()**

`Retrieves the model of the current player. Parameters: None

Returns: The model identifier as stored in the template if found, otherwise the model’s hash.`

- **game_character:exportCharacter()**

`Exports the character’s skin data, including model, clothes, props, faces, and others, into a serialized string.
Parameters: None
Returns: A string containing the serialized character data.`

- **game_character:importCharacter(str)**

`Imports character data from a serialized string and applies it to the character, setting model, clothes, props, faces, and other attributes.
Parameters:
str (string): A serialized string representing the character data.
Returns: true if successfully imported, or an error if the string is nil.`

- **game_character:tableToString(data)**

`Converts a table of data into a serialized string for export.
Parameters:
data (table): The data table to serialize.
Returns: A serialized string or an empty string if data is nil.`

- **game_character:stringToTable(str)**

`Converts a serialized string into a Lua table for import.
Parameters:
str (string): The serialized string to convert.
Returns: The deserialized table, split into sections for model, clothes, props, faces, and others.`

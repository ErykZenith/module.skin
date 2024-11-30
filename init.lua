local _export = exports["module.skin"]
module_skin = setmetatable({}, {
    __index = function(self, index)
        self[index] = function(...)
            return _export[index](...)
        end
        return self[index]
    end
})
----
-- Element Class
-- @elem_id : the id of the element
-- @elem_name : the name of the element 
----
Element = {}
Element.__index = Element;

function Element.new(elem_id,elem_name)
    local self = setmetatable({}, Element)
    self.id = elem_id
    self.name = elem_name
    return self
end

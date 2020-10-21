----
-- ClickableZone Class (used to define clickable zones)
----
ClickableZone = {}
ClickableZone.__index = ClickableZone;

function ClickableZone.new(id_button,id_mouseover,id_mouseholddown,x, y, hx, hy, function_mouse_up,function_mouse_down,function_mouse_holddown)
    local self = setmetatable({}, ClickableZone)
    self.id_button = id_button
    self.id_mouseover = id_mouseover
    self.id_mouseholddown = id_mouseholddown
    self.x = x
    self.y = y
    self.hx = hx
    self.hy = hy
    self.function_mouse_up = function_mouse_up
    self.function_mouse_down = function_mouse_down
    self.function_mouse_holddown = function_mouse_holddown
    return self
end

function ClickableZone.contains(self, x, y)
    return x > self.x and x < self.x + self.hx and
    y > self.y and y < self.y + self.hy
end

function ClickableZone.getIds(self)
	return {self.id_button,self.id_mouseover,self.id_mouseholddown}     
end

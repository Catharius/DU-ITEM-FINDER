----
-- ButtonManager Class (used to create buttons)
----
ButtonManager = {}
ButtonManager.__index = ButtonManager;

function ButtonManager.new()
    local self = setmetatable({}, ButtonManager)
    self.zones = {}
    self.mouseisdown = 0
    return self
end

function ButtonManager.createClickableZone(self, id_button, id_mouseover, id_mouseholddown, x, y, hx, hy, function_mouse_up,function_mouse_down,function_mouse_holddown)
    self.zones[id_button] = ClickableZone.new(id_button, id_mouseover, id_mouseholddown, x, y, hx, hy, function_mouse_up,function_mouse_down,function_mouse_holddown) 	  	  	
end

function ButtonManager.createAdvancedButtonArea(self, screen, x, y, hx, hy, button_html, button_style, mouseover_html, mouseover_style, mouseholddown_html, mouseholddown_style, function_mouse_up, function_mouse_down, function_mouse_holddown)
    button = "<div class='"..button_style.."'>" .. button_html .. "</div>"
    button_mouseover = "<div class='"..mouseover_style.."'>" .. mouseover_html .. "</div>"
    id_button = screen.addContent(x,y,button)
    id_mouseover = screen.addContent(x,y,button_mouseover)
    screen.showContent(id_mouseover, 0) 
    self:createClickableZone(id_button,id_mouseover,id_mouseholddown, x/100, y/100, hx/100, hy/100, function_mouse_up,function_mouse_down,function_mouse_holddown)
    return {id_button,id_mouseover}
end

function ButtonManager.processMouseUp(self, screen, x, y)
    for key, area in pairs(self.zones) do
        if area:contains(x, y) and area.function_mouse_up ~= nil then
            area.function_mouse_up()
            self.mouseisdown = 0
            screen.showContent(key, 1) 
            screen.showContent(area.id_mouseover, 0)
            screen.showContent(area.id_mouseholddown, 0)
        elseif not area:contains(x, y) and area.function_mouse_up ~= nil then
            screen.showContent(key, 1)
            screen.showContent(area.id_mouseover, 0)
            screen.showContent(area.id_mouseholddown, 0)    
        end
    end
end

function ButtonManager.processMouseDown(self, screen, x, y)
    for key, area in pairs(self.zones) do
        if area:contains(x, y) and area.function_mouse_down ~= nil then
            area.function_mouse_down()
            self.mouseisdown = 1
            screen.showContent(key, 0) 
            screen.showContent(area.id_mouseover, 0)
            screen.showContent(area.id_mouseholddown, 1)
        end
    end
end

function ButtonManager.processMouseHoldDown(self, x, y)
    for key, area in pairs(self.zones) do
        if area:contains(x, y) and area.function_mouse_holddown ~= nil and area.function_mouse_up ~= nil and area.function_mouse_down ~= nil and self.mouseisdown == 1 then
            area.function_mouse_holddown()
        end
    end
end

function ButtonManager.processMouseOver(self, screen, x, y)
    for key, area in pairs(self.zones) do
        if self.mouseisdown == 0 and area.id_mouseover ~= nil then
            if area:contains(x, y) then
                screen.showContent(key, 0) 
                screen.showContent(area.id_mouseover, 1)
            else 
                screen.showContent(key, 1) 
                screen.showContent(area.id_mouseover, 0)
            end
        end    
    end
end

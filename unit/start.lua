--------------------------------------------------------------------------------
-- Librairie permettant de faire des boutons et de les styliser comme vous voulez avec du code html
-- Auteur : Catharius
--------------------------------------------------------------------------------
number_keys = {"1","2","3","4","5","6","7","8","9"}
letter_first_row_keys = {"A","Z","E","R","T","Y","U","I","O","P"}
letter_second_row_keys = {"Q","S","D","F","G","H","J","K","L","M"}
letter_third_row_keys = {"W","X","C","V","B","N"}

screen.addContent(0,0,[[<style>.key {width:7vw;height:10vh;overflow:hidden;font-size:8vh;text-align:center;}  .key_style {background-color:white;color:black;} .key_hover_style {background-color:black;color:white;} .key_push_style {background-color:white;color:black;}</style>]]) -- Add the CSS
search_zone = screen.addContent(1,1,[[<div style="width:98vw;height:10vh;-moz-appearance: textfield;
    -webkit-appearance: textfield;
    background-color: white;
    background-color: -moz-field;
    border: 1px solid darkgray;
    box-shadow: 1px 1px 1px 0 lightgray inset;  
    font: -moz-field;
    font: -webkit-small-control;
    margin-top: 5px;
    padding: 2px 3px;"></div>]])


----------------------------------------------------------------------
-- Classe permettant de définir la zone de clic (Utilisé par la classe ButtonManager)
----------------------------------------------------------------------
ClickableZone = {}
ClickableZone.__index = ClickableZone;

function ClickableZone.new(id_mouseover,id_mouseholddown,x, y, hx, hy, function_mouse_up,function_mouse_down,function_mouse_holddown)
    local self = setmetatable({}, ClickableZone)
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

----------------------------------------------------------------------
-- Classe permettant de créer des boutons et les styliser
----------------------------------------------------------------------
ButtonManager = {}
ButtonManager.__index = ButtonManager;
local mouseisdown = 0

function ButtonManager.new()
    local self = setmetatable({}, ButtonManager)
    self.zones = {}
    return self
end

function ButtonManager.createClickableZone(self, id_button, id_mouseover, id_mouseholddown, x, y, hx, hy, function_mouse_up,function_mouse_down,function_mouse_holddown)
    self.zones[id_button] = ClickableZone.new(id_mouseover, id_mouseholddown, x, y, hx, hy, function_mouse_up,function_mouse_down,function_mouse_holddown)
end

function ButtonManager.deleteClickableZone(self, id)
    table.remove(self.zones, id)
end

----------------------------------------------------------------------
-- Supprime un bouton (Utile lorsque l'on va dans un sous-menu et que l'on veut nettoyer l'affichage des boutons non nécéssaires, nettoie aussi les mouseover et autres éléments reliés au bouton)
-- @param id : id du bouton à supprimer
----------------------------------------------------------------------
function ButtonManager.deleteButtonArea(self, screen, id)
    screen.deleteContent(id)
    self:deleteClickableZone(id)
end

----------------------------------------------------------------------
-- Crée un bouton
-- @param screen : l'écran sur lequel doit apparaitre la souris
-- @param x : position x du coin supérieur gauche du bouton (en pixel)
-- @param y : position y du coin supérieur gauche du bouton (en pixel)
-- @param hx : largeur du bouton (en pixel)
-- @param hy : hauteur du bouton (en pixel)
-- @param button_html : code du bouton dans son état normal
-- @param button_style : style du bouton dans son état normal
-- @param function_mouse_up : fonction à exécuter lorsque l'on relache le bouton de la souris, si non utilisée placer function() end sans rien dedans
-- @param function_mouse_down : fonction à exécuter lorsque l'on presse le bouton de la souris, si non utilisée placer function() end sans rien dedans
-- @param function_mouse_holddown : foonction à exécuter lorsque l'on maintient le bouton de la souris, si non utilisée placer function() end sans rien dedans
----------------------------------------------------------------------
function ButtonManager.createButtonArea(self, screen, x, y, hx, hy, button_html,button_style, function_mouse_up,function_mouse_down,function_mouse_holddown)
    button = "<div class='bootstrap' style='filter:brightness(75%);width:".. (hx) ..
    "vw;height:" .. (hy) .."vh;overflow:hidden;font-size:".. (hy/2) ..
    "vh;"..button_style.."'>" .. button_html .. "</div>"
    button_mouseover = "<div class='bootstrap' style='filter:brightness(100%);width:".. (hx) ..
    "vw;height:" .. (hy) .."vh;overflow:hidden;font-size:".. (hy/2) ..
    "vh;"..button_style.."'>" .. button_html .. "</div>"
    button_mouseholddown = "<div class='bootstrap' style='filter:brightness(50%);width:".. (hx) ..
    "vw;height:" .. (hy) .."vh;overflow:hidden;font-size:".. (hy/2) ..
    "vh;"..button_style.."'>" .. button_html .. "</div>"

    id = screen.addContent(x,y,button)
    id_mouseover = screen.addContent(x,y,button_mouseover)
    screen.showContent(id_mouseover, 0) 
    id_mouseholddown = screen.addContent(x,y,button_mouseholddown)
    screen.showContent(id_mouseholddown, 0) 
    self:createClickableZone(id,id_mouseover,id_mouseholddown, x/100, y/100, hx/100, hy/100, function_mouse_up,function_mouse_down,function_mouse_holddown)
    return id
end

----------------------------------------------------------------------
-- Crée un bouton en donnant toutes les possibilités (Pas d'accompagnement sur le style, il sera à réaliser par vos soins)
-- @param screen : l'écran sur lequel doit apparaitre la souris
-- @param x : position x du coin supérieur gauche du bouton (en pixel)
-- @param y : position y du coin supérieur gauche du bouton (en pixel)
-- @param hx : largeur du bouton (en pixel)
-- @param hy : hauteur du bouton (en pixel)
-- @param button_html : code du bouton dans son état normal
-- @param button_style : style du bouton dans son état normal
-- @param mouseover_html : code du bouton dans son état survolé par le curseur
-- @param mouseover_style : style du bouton dans son état survolé par le curseur
-- @param mouseholddown_html : code du bouton dans son état enfoncé
-- @param mouseholddown_style : style du bouton dans son état enfoncé
-- @param function_mouse_up : fonction à exécuter lorsque l'on relache le bouton de la souris
-- @param function_mouse_down : fonction à exécuter lorsque l'on presse le bouton de la souris
-- @param function_mouse_holddown : foonction à exécuter lorsque l'on maintient le bouton de la souris
----------------------------------------------------------------------
function ButtonManager.createAdvancedButtonArea(self, screen, x, y, hx, hy, button_html, button_style, mouseover_html, mouseover_style, mouseholddown_html, mouseholddown_style, function_mouse_up, function_mouse_down, function_mouse_holddown)
    button = "<div class='"..button_style.."'>" .. button_html .. "</div>"
    button_mouseover = "<div class='"..mouseover_style.."'>" .. mouseover_html .. "</div>"
    button_mouseholddown = "<div class='"..mouseholddown_style.."'>" .. mouseholddown_html .. "</div>"
    id_button = screen.addContent(x,y,button)
    id_mouseover = screen.addContent(x,y,button_mouseover)
    screen.showContent(id_mouseover, 0) 
    id_mouseholddown = screen.addContent(x,y,button_mouseholddown)
    screen.showContent(id_mouseholddown, 0) 
    self:createClickableZone(id_button,id_mouseover,id_mouseholddown, x/100, y/100, hx/100, hy/100, function_mouse_up,function_mouse_down,function_mouse_holddown)
    return id
end

----------------------------------------------------------------------
-- Fonction à placer dans le filter mouseUp de votre écran (renseigner * * sur le filter), permet de détecter le relachement du clic
-- @param screen : le nom de votre écran
-- @param x : A laisser tel quel, est renseigné par le filter
-- @param y : A laisser tel quel, est renseigné par le filter
-- Exemple : buttonManager:processMouseUp(votre_ecran,x,y)  (x et y étant renseigné par le filter, pas besoin de renseigner les variables au préalable)
----------------------------------------------------------------------
function ButtonManager.processMouseUp(self, screen, x, y)
    for key, area in pairs(self.zones) do
        if area:contains(x, y) and area.function_mouse_up ~= nil then
            area.function_mouse_up()
            mouseisdown = 0
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

----------------------------------------------------------------------
-- Fonction à placer dans le filter mouseDown de votre écran (renseigner * * sur le filter), permet de détecter le clic (s'exécute dès l'enfoncement du bouton de la souris plutot que le relachement)
-- @param screen : le nom de votre écran
-- @param x : A laisser tel quel, est renseigné par le filter
-- @param y : A laisser tel quel, est renseigné par le filter
-- Exemple : buttonManager:processMouseDown(votre_ecran,x,y)  (x et y étant renseigné par le filter, pas besoin de renseigner les variables au préalable)
----------------------------------------------------------------------
function ButtonManager.processMouseDown(self, screen, x, y)
    for key, area in pairs(self.zones) do
        if area:contains(x, y) and area.function_mouse_down ~= nil then
            area.function_mouse_down()
            mouseisdown = 1
            screen.showContent(key, 0) 
            screen.showContent(area.id_mouseover, 0)
            screen.showContent(area.id_mouseholddown, 1)
        end
    end
end

----------------------------------------------------------------------
-- Fonction à placer dans un timer ou le flush (attention le flush est violent, prévoir cela pour des commandes de vaisseaux par exemple)
-- Permet de détecter le maintient enfoncé sur le bouton (S'exécute donc plusieurs fois d'affilé tant que l'on maintient le bouton de la souris enfoncé)
-- Exemple : buttonManager:processMouseHoldDown(votre_ecran.getMouseX(),votre_ecran.getMouseY())
-- A noter que contrairement aux fonctions mouseUp et mouseDown il faut lui envoyer les infos mouseX et mouseY
----------------------------------------------------------------------
function ButtonManager.processMouseHoldDown(self, x, y)
    for key, area in pairs(self.zones) do
        if area:contains(x, y) and area.function_mouse_holddown ~= nil and area.function_mouse_up ~= nil and area.function_mouse_down ~= nil and mouseisdown == 1 then
            area.function_mouse_holddown()
        end
    end
end

----------------------------------------------------------------------
-- Fonction à placer dans le flush
-- Permet de détecter le survol bouton pour changer son aspect
-- Exemple : buttonManager:processMouseOver(ecran,ecran.getMouseX(),ecran.getMouseY())
-- A noter que contrairement aux fonctions mouseUp et mouseDown il faut lui envoyer les infos mouseX et mouseY
----------------------------------------------------------------------
function ButtonManager.processMouseOver(self, screen, x, y)
    for key, area in pairs(self.zones) do
        if mouseisdown == 0 and area.id_mouseover ~= nil then
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

buttonManager = ButtonManager.new()


--Création du clavier virtuel
key_style = "key key_style"
key_hover_style = "key key_hover_style"
key_push_style = "key key_push_style"

key_width = 7
key_height = 10
line_spacing=8

--Keyboard numbers
line_pos_y = 55
line_pos_x=7
for i,current_key in ipairs(number_keys) do
	buttonManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,key_width,key_height, current_key,key_style,current_key,key_hover_style,current_key,key_push_style,function()  end,function() end,function() end)	
	line_pos_x=line_pos_x+line_spacing
end
--Keyboard letter first line
line_pos_y = 66
line_pos_x=10
for i,current_key in ipairs(letter_first_row_keys) do
	buttonManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,key_width,key_height, current_key,key_style,current_key,key_hover_style,current_key,key_push_style,function()  end,function() end,function() end)	
	line_pos_x=line_pos_x+line_spacing
end
-- Keyboard second line
line_pos_y = 77
line_pos_x=12
for i,current_key in ipairs(letter_second_row_keys) do
	buttonManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,key_width,key_height, current_key,key_style,current_key,key_hover_style,current_key,key_push_style,function()  end,function() end,function() end)	
	line_pos_x=line_pos_x+line_spacing
end
-- Keyboard third line
line_pos_y = 88
line_pos_x=14
for i,current_key in ipairs(letter_third_row_keys) do
	buttonManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,key_width,key_height, current_key,key_style,current_key,key_hover_style,current_key,key_push_style,function()  end,function() end,function() end)	
	line_pos_x=line_pos_x+line_spacing
end





--for i,idelem in ipairs(core.getElementIdList()) do
--    if core.getElementTypeById(idelem) == "container" then
--     	html=html..core.getElementNameById(idelem).."<br>" 
--    end   
--end
screen.activate()

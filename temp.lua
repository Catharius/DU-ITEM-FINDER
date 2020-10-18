unit.setTimer("getpos",0.2)
markers_list = {} 
html=""
--for i,idelem in ipairs(core.getElementIdList()) do
--     if core.getElementTypeById(idelem) == "container" then
--     	html=html..core.getElementNameById(idelem).."<br>" 
--     end   
--end
--ecran.setHTML(html)

system.print(core.getElementNameById(1536))
local x,y,z = table.unpack(core.getElementPositionById(1536))
marker1 = core.spawnArrowSticker(x-128,y-128,(z-128)+14, "down") 
marker3 = core.spawnArrowSticker(x-128,y-128,(z-128)+11, "down")
marker5 = core.spawnArrowSticker(x-128,y-128,(z-128)+8, "down")
marker7 = core.spawnArrowSticker(x-128,y-128,(z-128)+5, "down")
marker9 = core.spawnArrowSticker(x-128,y-128,(z-128)+2, "down") 
table.insert(markers_list, marker1)
table.insert(markers_list, marker3)
table.insert(markers_list, marker5)
table.insert(markers_list, marker7)
table.insert(markers_list, marker9)

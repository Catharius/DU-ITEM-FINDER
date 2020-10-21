-- Get all containers and sort them by name
for i,idelem in ipairs(core.getElementIdList()) do
    if core.getElementTypeById(idelem) == "container" then
         name = core.getElementNameById(idelem)
         if not string.match(name, "XX") then
         	table.insert(sorted_container_table, Element.new(idelem,name)) 
         end   
         --table.insert(sorted_container_table, Element.new(idelem,core.getElementNameById(idelem))) 
    end  
end
table.sort(sorted_container_table,sortalphabeticaly)

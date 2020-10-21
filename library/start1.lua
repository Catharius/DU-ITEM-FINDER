----
-- Other functions
----
function sortalphabeticaly(a,b)
    a = core.getElementNameById(a.name)
    b = core.getElementNameById(b.name)
    return a < b
end

function selectItem(item_id)
    table.insert(selection,item_id)
    local x,y,z = table.unpack(core.getElementPositionById(item_id))
    marker1 = core.spawnArrowSticker(x-126.5,y-128,(z-128), "down")
    marker2 = core.spawnArrowSticker(x-126.5,y-128,(z-128), "down")
    core.rotateSticker(marker2,0,0,90)
    
    marker3 = core.spawnArrowSticker(x-129.5,y-128,(z-128), "down")
    marker4 = core.spawnArrowSticker(x-129.5,y-128,(z-128), "down")
    core.rotateSticker(marker4,0,0,90)
    
    --marker5 = core.spawnArrowSticker(x-128+2,y-128,(z-128), "east")
    --marker7 = core.spawnArrowSticker(x-128-2,y-128,(z-128), "west")
    --marker9 = core.spawnArrowSticker(x-128,y-128,(z-128)+2, "down") 
    table.insert(markers_list, marker1)
    table.insert(markers_list, marker2)
    --table.insert(markers_list, marker3)
    --table.insert(markers_list, marker5)
    --table.insert(markers_list, marker7)
    --table.insert(markers_list, marker9)
    
    search(search_string)
end

function search(name)
    clearScreenData()
    
    local line_pos_x =5
    local line_pos_y = 15

    local max_result = 5
    for i,elem in ipairs(sorted_container_table) do
        key_style = "search_result"
        key_hover_style = "search_result hover"
        key_push_style = "search_result"
        if string.match(elem.name, name) then
            for _,selectedElem in ipairs(selection) do
                if elem.id == selectedElem then
                    key_style = "selected_search_result" 
                end    
            end    
            btnManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,90,4,elem.name,key_style,elem.name,key_hover_style,elem.name,key_push_style,function() selectItem(elem.id)  end,function() end,function() end)
            line_pos_y=line_pos_y+5
            max_result = max_result-1
            if max_result == 0 then
                break
            end    
        end
    end    
end   

-- Search bar
function updateSearchBar(letter)
    nbchar = nbchar+1
    search_string = search_string..letter
    screen.resetContent(search_zone,[[<div class="search_bar">]]..search_string..[[</div>]])
    if nbchar>2 then
        search(search_string)
    end
end    

function deleteChar()
    if nbchar > 0 then
        nbchar=nbchar-1
        search_string = search_string:sub(1, #search_string - 1)
        screen.resetContent(search_zone,[[<div class="search_bar">]]..search_string..[[</div>]])
    end 
    if nbchar<= 2 then
        --Clear des boutons présent
        clearScreenData()
    end   
end

function clearScreenData() 
    screen.clear()
    -- Declaring a buttonManager
    btnManager = ButtonManager.new()	
    -- Add CSS to screen first and the empty search bar
    screen.addContent(0,0,[[<style>div {font-style:arial;} .selected_search_result {color:green;font-size:6vh;width:90vw} .search_result {color:white;font-size:6vh;width:90vw} .hover {color:yellow} .delkey {width:12vw;height:10vh;overflow:hidden;font-size:8vh;text-align:center;} .key {width:7vw;height:10vh;overflow:hidden;font-size:8vh;text-align:center;}  .key_style {background-color:white;color:black;} .key_hover_style {background-color:black;color:white;} .key_push_style {background-color:white;color:black;} .search_bar {width:98vw;height:10vh;-moz-appearance: textfield;-webkit-appearance: textfield;background-color: white;background-color: -moz-field;border: 1px solid darkgray;box-shadow: 1px 1px 1px 0 lightgray inset;font: -moz-field;font: -webkit-small-control;margin-top: 5px;padding: 2px 3px;color:black;font-size:8vh;}</style>]]) -- Add the CSS
    search_zone = screen.addContent(1,1,[[<div class="search_bar">]]..search_string..[[</div>]])
    if dosearch then
        search(search_string)
    end    
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
        btnManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,key_width,key_height, current_key,key_style,current_key,key_hover_style,current_key,key_push_style,function() updateSearchBar(current_key)  end,function() end,function() end)	
        line_pos_x=line_pos_x+line_spacing
    end
    btnManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,12,10, "DEL","del"..key_style,"DEL","del"..key_hover_style,"DEL","del"..key_push_style,function() deleteChar()  end,function() end,function() end)	

    --Keyboard letter first line
    line_pos_y = 66
    line_pos_x=10
    for i,current_key in ipairs(letter_first_row_keys) do
        btnManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,key_width,key_height, current_key,key_style,current_key,key_hover_style,current_key,key_push_style,function() updateSearchBar(current_key)  end,function() end,function() end)	
        line_pos_x=line_pos_x+line_spacing
    end
    -- Keyboard second line
    line_pos_y = 77
    line_pos_x=12
    for i,current_key in ipairs(letter_second_row_keys) do
        btnManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,key_width,key_height, current_key,key_style,current_key,key_hover_style,current_key,key_push_style,function() updateSearchBar(current_key)  end,function() end,function() end)	
        line_pos_x=line_pos_x+line_spacing
    end
    -- Keyboard third line
    line_pos_y = 88
    line_pos_x=14
    for i,current_key in ipairs(letter_third_row_keys) do
        btnManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,key_width,key_height, current_key,key_style,current_key,key_hover_style,current_key,key_push_style,function() updateSearchBar(current_key)  end,function() end,function() end)	
        line_pos_x=line_pos_x+line_spacing
    end
    btnManager:createAdvancedButtonArea(screen, line_pos_x, line_pos_y,12,10, "","del"..key_style,"","del"..key_hover_style,"","del"..key_push_style,function() updateSearchBar(" ")  end,function() end,function() end)	
    screen.activate()
end

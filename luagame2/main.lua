function love.load()

    --require
    lume = require "lume"

    --basic parameters
    fish = {}
    fish.image = love.graphics.newImage("fish.png")
    fish.fn = 5
    fish.x, fish.y = 350, 350
    fish.angle = 0
    fish.speed = 200
    fish.offsetx = fish.image:getWidth() / (fish.fn * 2)
    fish.offsety = fish.image:getHeight() / 2
    fish.image = love.graphics.newImage("fish.png")
    fish.frames = {}
    fish.frame_width, fish.frame_height = fish.image:getWidth() / fish.fn, fish.image:getHeight() 
    for i=0,fish.fn - 1 do
        table.insert(fish.frames, love.graphics.newQuad(i * fish.frame_width, 0, fish.frame_width, fish.frame_height, fish.image:getWidth(), fish.image:getHeight()))
    end
    fish.currentFrame = 1

    --load saved data
    if love.filesystem.getInfo("savedata.txt") then
        data = lume.deserialize(love.filesystem.read("savedata.txt"))
        fish.x = data.fish.x
        fish.y = data.fish.y
    end
end

function love.update(dt)
    --animate the fish
    fish.currentFrame = fish.currentFrame + 10 * dt
    if fish.currentFrame >= fish.fn then
        fish.currentFrame = 1
    end
    --move the fish
    mouse_x, mouse_y = love.mouse.getPosition()
    fish.angle = math.atan2(mouse_y - fish.y, mouse_x - fish.x)
    local dist = distance(fish.x, fish.y, mouse_x, mouse_y)
    
    if dist < 500 
    and dist > math.sqrt((fish.image:getWidth() / fish.fn) ^2 + (fish.image:getHeight()) ^2) 
    then
        fish.x = fish.x + fish.speed * math.cos(fish.angle) * dt
        fish.y = fish.y + fish.speed * math.sin(fish.angle) * dt
    end  
end

function love.draw()
    love.graphics.draw(fish.image, fish.frames[math.floor(fish.currentFrame)], fish.x, fish.y, fish.angle, 1, 1, fish.offsetx, fish.offsety)
    love.graphics.circle("fill", mouse_x, mouse_y, 7)
end

function love.keypressed(key)
    if key == "f1" then
        saveGame()
        love.event.quit("restart")
    elseif key == "f2" then
        love.filesystem.remove("savedata.txt")
        love.event.quit("restart")
    elseif key == "escape" then
        love.event.quit()
    end
end

function saveGame()
    data = {}
    data.fish = {
        x = fish.x,
        y = fish.y
    }
    love.filesystem.write("savedata.txt", lume.serialize(data))
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2) ^2 + (y1 - y2) ^2)
end



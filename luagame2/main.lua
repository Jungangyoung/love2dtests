function love.load()
    --settings
    love.mouse.setVisible(false)

    --require
    lume = require "lume"
    Object = require "classic"
    require "fish"
    require "enemy"
    fish = Fish(350, 350)
    enemy1 = Enemy(100, 200)
    enemy2 = Enemy(200, 400)
    enemy3 = Enemy(300, 300)

    --load saved data
    if love.filesystem.getInfo("savedata.txt") then
        data = lume.deserialize(love.filesystem.read("savedata.txt"))
        fish.x = data.fish.x
        fish.y = data.fish.y
        fish.angle = data.fish.angle
    end
end

function love.update(dt)
    mouse_x, mouse_y = love.mouse.getPosition()
    fish:update(dt)
    enemy1:update(dt, fish)
    enemy2:update(dt, enemy1)
    enemy3:update(dt, enemy2)
end

function love.draw()
    enemy1:draw()
    enemy2:draw()
    enemy3:draw()
    fish:draw()
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
        y = fish.y,
        angle = fish.angle
    }
    love.filesystem.write("savedata.txt", lume.serialize(data))
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2) ^2 + (y1 - y2) ^2)
end



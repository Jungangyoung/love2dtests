function love.load()
    fish = {}
    fish.image = love.graphics.newImage("fish.png")
    fish.fn = 5
    fish.x = 100
    fish.y = 100
    fish.angle = 0
    fish.speed = 200
    fish.offsetx = fish.image:getWidth() / (fish.fn * 2)
    fish.offsety = fish.image:getHeight() / 2
    fish.image = love.graphics.newImage("fish.png")
    frames = {}
    local frame_width, frame_height = fish.image:getWidth() / 5, fish.image:getHeight() 
    for i=0,fish.fn - 1 do
        table.insert(frames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, fish.image:getWidth(), fish.image:getHeight()))
    end
    currentFrame = 1
end

function love.update(dt)
    --animate the fish
    currentFrame = currentFrame + 10 * dt
    if currentFrame >= fish.fn then
        currentFrame = 1
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
    love.graphics.draw(fish.image, frames[math.floor(currentFrame)], fish.x, fish.y, fish.angle, 1, 1, fish.offsetx, fish.offsety)
    love.graphics.circle("fill", mouse_x, mouse_y, 7)
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2) ^2 + (y1 - y2) ^2)
end



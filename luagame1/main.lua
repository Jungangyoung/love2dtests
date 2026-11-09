function love.load()
    score = 0
    BALL_SIZE = 30
    x = 0
    y = 0
    a = 0
    b = 0
end

function love.update(dt)
    x = love.math.random(700)
    y = love.math.random(700)
    a = love.math.random(700)
    b = love.math.random(700)     
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", x, y, BALL_SIZE, BALL_SIZE)
    love.graphics.setColor(0, 0.5, 0.5)
    love.graphics.rectangle("fill", a, b, BALL_SIZE, BALL_SIZE)
    scoring()   
end

function scoring()
    if a % x == 0 or b % y == 0 then
        score = score + 1
    end
    if score <= 10 then
        love.graphics.print(score, 380, 280, 0, 3, 3)
    else 
        love.graphics.print("YOU WIN!", 320, 280, 0, 3, 3)
    end
end
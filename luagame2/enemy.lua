Enemy = Object:extend()

function Enemy:new(x, y)
    self.image = love.graphics.newImage("enemy.png")
    self.fn = 5
    self.x, self.y = x, y
    self.angle = 0
    self.speed = 200
    self.offsetx = self.image:getWidth() / (self.fn * 2)
    self.offsety = self.image:getHeight() / 2
    self.frames = {}
    self.frame_width, self.frame_height = self.image:getWidth() / self.fn, self.image:getHeight() 
    for i=0,self.fn - 1 do
        table.insert(self.frames, love.graphics.newQuad(i * self.frame_width, 0, self.frame_width, self.frame_height, self.image:getWidth(), self.image:getHeight()))
    end
    self.currentFrame = 1
end

function Enemy:update(dt, target)
    --current frame
    self.currentFrame = self.currentFrame + 10 * dt
    if self.currentFrame >= self.fn + 1 then
        self.currentFrame = 1
    end
    --move
    self.angle = math.atan2(target.y - self.y, target.x - self.x)
    local dist = distance(self.x, self.y, target.x, target.y)
    
    if dist < 500 
    and dist > math.sqrt((self.image:getWidth() / self.fn) ^2 + (self.image:getHeight()) ^2) 
    then
        self.x = self.x + self.speed * math.cos(self.angle) * dt
        self.y = self.y + self.speed * math.sin(self.angle) * dt
    end 
end

function Enemy:draw()
    love.graphics.draw(self.image, self.frames[math.floor(self.currentFrame)], self.x, self.y, self.angle, 1, 1, self.offsetx, self.offsety)
end
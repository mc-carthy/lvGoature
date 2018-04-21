local Entities = require('src/entities/entities')

local zepp = Entities.derive('base')

function zepp:setPos(x, y)
    self.x = x
    self.y = y
    self.w = 64
    self.h = 64
    self.fixedY = y
end

function zepp:load(x, y)
    self:setPos(x, y)
    self.image = love.graphics.newImage('src/assets/img/fly.png')
    self.birth = love.timer.getTime() + love.math.random(0, 128)
    self.size = love.math.random(4, 6)
end

function zepp:update(dt)
    self.x = self.x + self.size * 9 * dt
    self.y = self.fixedY + (math.sin(love.timer.getTime() - self.birth)) * self.size * 3

    if self.x > love.graphics.getWidth() then
        Entities.destroy(self.id)
    end
end

function zepp:die()
    Entities.create('zepp', -love.math.random(128, 256), 128)
end

function zepp:draw()
    local x, y = self:getPos()
    local w, h = self.image:getDimensions()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(self.image, x, y, 0, 64 / w, 64 / h)
end

return zepp
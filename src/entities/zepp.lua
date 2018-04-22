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
    self.rot = 0
    self.falling = false
    self.health = 5
    self.maxHealth = self.health
    self.smokes = {}
    self.smokeImage = love.graphics.newImage('src/assets/img/smoke.png')
end

function zepp:update(dt)
    self.x = self.x + self.size * 9 * dt
    self.y = self.fixedY + (math.sin(love.timer.getTime() - self.birth)) * self.size * 3

    if self.x > love.graphics.getWidth() then
        Entities.destroy(self.id)
    end

    if self.falling then
        self.fixedY = self.fixedY + 32 * dt
        self.rot = self.rot + math.pi * 0.025 * dt
        if self.y >= (love.graphics.getHeight() * 0.5) then
            startBackgroundExplosion(self.x + 512 * (self.size / 20), self.y + 128 * (self.size / 20), 1)
            self.falling = false
            Entities.destroy(self.id)
        end
    end

    for i, v in ipairs(self.smokes) do
        v.time = v.time - dt
        if v.time <= 0 then
            table.remove(self.smokes, i)
        end
    end
end

function zepp:fall()
    self.falling = true
end

function zepp:smoke()
    table.insert(self.smokes, { time = 3, x = self.x, y = self.y })
end

function zepp:damage()
    if self.health > 0 or not self.falling then
        score = score + 3
        zepp:smoke()
        self.health = self.health - 1
        if self.health <= 0 then
            self.falling = true
        end
    end
end

function zepp:die()
    Entities.create('zepp', -love.math.random(128, 256), 128, true)
end

function zepp:draw()
    local x, y = self:getPos()
    local w, h = self.image:getDimensions()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(self.image, x, y, self.rot, 64 / w, 64 / h)
    for k, v in pairs(self.smokes) do
        local scale = v.time / 3
        love.graphics.setColor(255, 255, 255, scale * 255)
        love.graphics.draw(self.smokeImage, v.x, v.y - (1 - scale) * 64, 0, 32 /  w, 32 / h, self.smokeImage:getWidth() / 2, self.smokeImage:getHeight() / 2)
    end
end

return zepp
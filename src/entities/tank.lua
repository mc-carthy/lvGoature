local Entities = require('src/entities/entities')

local tank = Entities.derive('base')

function tank:load(x, y)
    self:setPos(x, y)
    self.imgBarrel = love.graphics.newImage('src/assets/img/tankBarrel.png')
    self.imgTracks = love.graphics.newImage('src/assets/img/tankTracks.png')
    self.imgBody = love.graphics.newImage('src/assets/img/tankBody.png')
    self.imgSmoke = love.graphics.newImage('src/assets/img/smoke.png')
    self.w = self.imgBody:getWidth()
    self.h = self.imgBody:getHeight()
    self.speed = 16
    self.smokes = {}
    self.size = 1
    self.barrelRot = 0
    self.dist = love.math.random(100, 300)
    self.delta = 0
    self.exploding = false
    self.explosion = 0
    self.health = 8
    self.maxHealth = health
end

-- function tank:setPos(x, y)
--     self.x = x
--     self.y = y
-- end

-- TODO: Change this
function tank:getBarrelRad()
    return self.barrelRot * math.pi * 0.1 - math.pi * 0.1
end

function tank:getBarrelPos()
    return self.x + self.imgBarrel:getWidth() / 4, self.y - self.imgBarrel:getHeight() * 1.5 * self.size
end

function tank:fire()
    local rot = tank:getBarrelRad()
    local x, y = tank:getBarrelPos()
    local bullet = Entities.create('bullet', x + math.cos(rot) * 20 * self.size, y + math.sin(rot) * 20 * self.size, false)
    bullet:setVelocity(math.cos(rot) * 400, math.sin(rot) * 400)
end

function tank:damage(v)
    if v < 0 or self.exploding then return end
    tank:smoke(love.math.random(-128 * self.size, 128 * self.size), love.math.random(-64 * self.size, 64 * self.size))
    self.health = self.health - v
    addScore(1)
    if self.health <= 0 then
        self.health = 0
        addScore(5)
        tank:explode()
    end
end

function tank:explode()
    self.exploding = true
end

function tank:die()
    Entities.create('tank', -256, 512, false)
end

function tank:smoke(x, y, scale, speed)
    x = x or 0
    y = y or 0
    scale = scale or 1
    speed = speed or 64
    table.insert(self.smokes, { time = 3, x = self.x - self.w + x, y = self.y - self.h + y, speed = speed })

end

function tank:update(dt)
    if self.exploding then
        self.explosion = self.explosion + dt
        if self.explosion > 1 then
            Entities.destroy(self.id)
        end
        return
    end

    if self.x <= self.dist then
        self.x = self.x + self.speed * dt
        self.delta = self.delta + dt

        if self.delta >= 0.5 then
            tank:smoke(-200 * self.size, 80 * self.size, 0.5, love.math.random(4, 16))
            self.delta = 0
        end
    elseif self.x > self.dist and self.x <= self.dist + 50 then
        self.x = self.x + self.speed * 4 * (1 - self.x / self.dist + 50) * dt + 4
    else
        self.delta = self.delta + dt
        if self.delta >= 1 then
            self.delta = 0
            tank:fire()
        end
    end
    for i, v in ipairs(self.smokes) do
        v.time = v.time - dt
        if v.time <= 0 then
            table.remove(self.smokes, i)
        end
    end

    self.barrelRot = math.sin(love.timer.getTime())
end

function tank:draw()

    if self.exploding then
        love.graphics.setColor(255, 255, 255, 255 * (1 - self.explosion))
        love.graphics.circle('fill', self.x, self.y, self.explosion * 512, 64)
        love.graphics.setColor(255, 255, 255, 255 * (1 - self.explosion))
        local bx, by = self:getBarrelPos()
        love.graphics.draw(self.imgBarrel, bx, by, self:getBarrelRad(), self.size * 0.75, self.size * 0.75, 0, 16)
        love.graphics.draw(self.imgTracks, self.x - self.imgTracks:getWidth() / 2, self.y - self.imgTracks:getHeight() / 2, 0, self.size, self.size)
        love.graphics.draw(self.imgBody, self.x - self.imgBody:getWidth() / 2, self.y - self.imgBody:getHeight() / 2, 0, self.size, self.size)
        return
    end
    love.graphics.setColor(255, 255, 255, 255)
    local bx, by = self:getBarrelPos()
    love.graphics.draw(self.imgTracks, self.x - self.imgTracks:getWidth() / 2, self.y + self.imgTracks:getHeight() / 4, 0, self.size, self.size)
    love.graphics.draw(self.imgBarrel, bx, by, self:getBarrelRad(), self.size * 0.75, self.size * 0.75, 0, 0)
    love.graphics.draw(self.imgBody, self.x - self.imgBody:getWidth() / 2, self.y - self.imgBody:getHeight() / 2, 0, self.size, self.size)
    -- love.graphics.setColor(0, 0, 0, 255)
    -- love.graphics.rectangle('line', self.x - self.w / 2, self.y - self.h / 2, self.w, self.h)

    for i, v in ipairs(self.smokes) do
        local scale = v.time / 3
        love.graphics.setColor(255, 255, 255, 255 * scale)
        love.graphics.draw(self.imgSmoke, v.x, v.y, 0, self.size * scale, self.size * scale)
    end
end


return tank
local Entities = require('src/entities/entities')

local bullet = Entities.derive('base')

function bullet:load(x, y)
    self:setPos(x, y)
    self.r = 5
    self.velocity = { x = 0, y = 0 }
    self.inertia = 1
end

function bullet.setInertia(v)
    self.inertia = v
end

function bullet:setVelocity(x, y)
    self.velocity = { x = x, y = y}
end

function bullet:getVelocity()
    return self.velocity.x, self.velocity.y
end

function bullet:update(dt)
    self.x = self.x + self.velocity.x * dt
    self.y = self.y + self.velocity.y * dt
    self.velocity.y = self.velocity.y + 128 * self.inertia * dt

    if self.y > love.graphics.getHeight() or self.x > love.graphics.getWidth() then
        takeScore(1)
        Entities.destroy(self.id)
    end
end

function bullet:draw()
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.circle('fill', self.x, self.y, self.r, 8)
end

return bullet
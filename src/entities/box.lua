local Entities = require('src/entities/entities')

local box = Entities.derive('base')

function box:load(x, y)
    self:setPos(x, y)
    self.w = 64
    self.h = 64
end

function box:setSize(w, h)
    self.w = w
    self.h = h
end

function box:getSize()
    return self.w, self.h
end

function box:update(dt)
    self.y = self.y + 32 * dt
end

function box:draw()
    local x, y = self:getPos()
    local w, h = self:getSize()
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', x, y, w, h)
end

return box
local base = {}

base.x = 0
base.y = 0
base.health = 1

function base:setPos(x, y)
    self.x = x
    self.y = y
end

function base:getPos()
    return self.x, self.y
end

function base:load()

end

return base
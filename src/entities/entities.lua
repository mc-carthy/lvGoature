local entities = {}

entities.objects = {}
entities.path = 'src/entities/'
local register = {}
local id = 0

function entities.startup() 
    register['box'] = love.filesystem.load(entities.path .. 'box.lua')
end

function entities.derive(name)
    return love.filesystem.load(entities.path .. name .. '.lua')()
end

function entities.create(name, x, y)
    local x = x or 0
    local y = y or 0
    if register[name] then
        id = id + 1
        local ent = register[name]()
        ent:load()
        ent:setPos(x, y)
        ent.id = id
        entities.objects[#entities.objects + 1] = ent
        return entities.objects[#entities.objects]
    else
        return false
    end
end

function entities:update(dt)
    for k, v in pairs(entities.objects) do
        if v.update then
            print('update')
            v:update(dt)
        end
    end
end

function entities:draw()
    for k, v in pairs(entities.objects) do
        if v.draw then
            print('draw')
            v:draw()
        end
    end
end

return entities
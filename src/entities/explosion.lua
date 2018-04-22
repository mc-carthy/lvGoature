local explosion = {}

local image = love.graphics.newImage('src/assets/img/explosion.png')

function startBackgroundExplosion(x, y, mag)
    table.insert(explosion, {x = x, y = y, mag = mag, time = 0})
end

function drawBackgroundExplosions()
    for k, v in pairs(explosion) do
        local scale = (v.time / (4 * v.mag))
        love.graphics.setColor(255, 255, 255, 255 * (1 - (v.time / (4 * v.mag))))
        love.graphics.draw(image, v.x - (image:getWidth() / 2) * scale, v.y - (image:getHeight() / 2) * scale, 0, scale, scale)
        love.graphics.setColor(255, 255, 255, 191 * (1 - (v.time / (4 * v.mag))))
        love.graphics.circle('fill', v.x, v.y, 2048 * (1 - (v.time / (4 * v.mag))), 32)
    end
end

function updateBackgroundExplosions(dt)
    for i, v in ipairs(explosion) do
        v.time = v.time + dt
        if v.time > 4 * v.mag then
            table.remove(explosion, i)
        end
    end
end
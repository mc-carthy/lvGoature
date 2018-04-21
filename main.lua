local cloud = {}

function love.load()
    cloud.x = 128
    cloud.y = 128
    cloud.w = 128
    cloud.h = 64
    cloud.xSpeed = 32
end

function love.update(dt)
    cloud.x = cloud.x + cloud.xSpeed * dt
    if cloud.x > love.graphics.getWidth() then
        cloud.x = -cloud.w
    end
end

function love.draw()
    love.graphics.setColor(191, 255, 255, 255)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight() / 2)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('fill', cloud.x, cloud.y, cloud.w, cloud.h)
    love.graphics.setColor(127, 159, 0, 255)
    love.graphics.rectangle('fill', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), love.graphics.getHeight() / 2)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
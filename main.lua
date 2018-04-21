local cloud = {}

function love.load()
    cloud.x = 128
    cloud.xSpeed = 32
end

function love.update(dt)
    cloud.x = cloud.x + cloud.xSpeed * dt
end

function love.draw()
    love.graphics.setColor(191, 255, 255, 255)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight() / 2)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('fill', cloud.x, love.graphics.getHeight() / 4, love.graphics.getWidth() / 4, love.graphics.getHeight() / 8)
    love.graphics.setColor(127, 159, 0, 255)
    love.graphics.rectangle('fill', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), love.graphics.getHeight() / 2)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
local Victory = {}

local WIDTH = love.graphics.getWidth()
local HEIGHT = love.graphics.getHeight()

local font = nil
local exit_font = nil
local counter = 2
local print_exit = true

function Victory.load()
	font = love.graphics.newFont(64)
	exit_font = love.graphics.newFont(32)
end

function Victory.update(dt)
	counter = counter + 1 * dt

	print_exit = math.floor(counter) % 2 == 0

	if love.keyboard.isDown("space") then screen = "menu" end
end

function Victory.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(final_score, (WIDTH - final_score:getWidth()) / 2, (HEIGHT - final_score:getHeight()) / 2)

	if winner == "Player 1" then
		love.graphics.setColor(0.2, 0, 0.8)
	elseif winner == "Player 2" then
		love.graphics.setColor(0.8, 0, 0.2)
	end

	love.graphics.print("WINNER : "..winner, font, (WIDTH - font:getWidth("WINNER : "..winner)) / 2, 50)

	love.graphics.setColor(1, 1, 0)
	if print_exit == true then
		love.graphics.print("Press Space to continue.", exit_font, (WIDTH - exit_font:getWidth("Press Space to continue")) / 2, HEIGHT - 50 - exit_font:getHeight("Press Space to continue."))
	end
end

return Victory
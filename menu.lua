local Menu = {}
local buttons = {}

local WIDTH = love.graphics.getWidth()
local HEIGHT = love.graphics.getHeight()

local BUTTON_WIDTH = WIDTH / 3
local BUTTON_HEIGHT = 50

local button_font = nil
local title_font = nil
local creator_font = nil

local counter = 2
local print_creator = true

local sndClick = love.audio.newSource("audio/click.wav", 'static')

function Menu.load()
	buttons[1] = {}
	buttons[1].text = "Play"
	buttons[1].func = function()
		screen = "game"
		newGame() 
	end
	buttons[1].mo_color = {0, 0, 1}
	buttons[1].x = nil
	buttons[1].y = nil
	buttons[1].mo = false

	buttons[2] = {}
	buttons[2].text = "Controls"
	buttons[2].func = function() screen = "controls" end
	buttons[2].mo_color = {1, 0, 1}
	buttons[2].x = nil
	buttons[2].y = nil
	buttons[2].mo = false

	buttons[3] = {}
	buttons[3].text = "Exit"
	buttons[3].func = function() love.event.quit(0) end
	buttons[3].mo_color = {1, 0, 0}
	buttons[3].x = nil
	buttons[3].y = nil
	buttons[3].mo = false

	local margin = 16
	local cursor_y = 0
	local total_height = (BUTTON_HEIGHT + margin) * #buttons
	local begin_y = (HEIGHT - total_height) / 2

	for i=1, #buttons do
		buttons[i].x = (WIDTH - BUTTON_WIDTH) / 2
		buttons[i].y = begin_y + cursor_y

		cursor_y = cursor_y + BUTTON_HEIGHT + margin
	end

	button_font = love.graphics.newFont(32)
	title_font = love.graphics.newFont(96)
	creator_font = love.graphics.newFont(48)

	for i=1, #buttons do
		buttons[i].xt = (WIDTH - button_font:getWidth(buttons[i].text)) / 2
		buttons[i].yt = buttons[i].y + (BUTTON_HEIGHT - button_font:getHeight(buttons[i].text)) / 2
	end
end

function Menu.update(dt)
	local mx, my = love.mouse.getPosition()

	for i=1, #buttons do
		if mx > buttons[i].x and mx < buttons[i].x + BUTTON_WIDTH and my > buttons[i].y and my < buttons[i].y + BUTTON_HEIGHT then
			buttons[i].mo = true
		else
			buttons[i].mo = false
		end
	end

	counter = counter + 1 * dt
	if math.floor(counter) % 2 == 0 then
		print_creator = true
	else
		print_creator = false
	end
end

function Menu.draw()
	love.graphics.setDefaultFilter("nearest")

	for i=1, #buttons do
		if buttons[i].mo == true then
			love.graphics.setColor(unpack(buttons[i].mo_color))
		else
			love.graphics.setColor(1, 1, 1)
		end

		love.graphics.rectangle("fill", buttons[i].x, buttons[i].y, BUTTON_WIDTH, BUTTON_HEIGHT)

		love.graphics.setColor(0, 0, 0)
		love.graphics.print(buttons[i].text, button_font, buttons[i].xt, buttons[i].yt)

		love.graphics.setColor(0, 1, 0)
		love.graphics.print("Light-Ball", title_font, (WIDTH - title_font:getWidth("Light-Ball")) / 2, 20)

		if print_creator == true then
			love.graphics.setColor(1, 1, 0)
			love.graphics.print("Created by YogS-974", creator_font, (WIDTH - creator_font:getWidth("Created by YogS-974")) / 2, HEIGHT - 30 - creator_font:getHeight("Created by YogS-974"))
		end
	end
end

function Menu.mousepressed(x, y, b)
	if b == 1 then
		for i=1, #buttons do
			if buttons[i].mo == true then
				buttons[i].func()
				sndClick:play()
			end
		end
	end
end

return Menu
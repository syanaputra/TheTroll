-----------------------------------------------------------------------------------------
--
-- level8.lua
-- By		: Stephanus Yanaputra
-- Version	: 1.0
--
-----------------------------------------------------------------------------------------
local game_scene_group
local game_scene_block_group

local game_bg
local question_text
local question_text_2
local question_window
local question_label
local answer_text_1
local answer_text_2
local answer_text_3
local answer_text_4
local answer_window_1
local answer_window_2
local answer_window_3
local answer_window_4
local next_button

local q_set
local a_set
local chosen_set_idx

local current_lv = 8

function init_level8()
	print("Init Lv: " .. current_lv)
	
	function create_question()
		game_scene_group = display.newGroup()
		game_scene_block_group = display.newGroup()
		
		q_set = {
			[0] = "1, 3, 5, 7, ?",
			[1] = "11, 13, 17, 19, ?",
			[2] = "39, 46, 53, 60, ?",
			[3] = "8, 13, 18, 23, ?",
		}
		a_set = {
			[0] = "9",
			[1] = "23",
			[2] = "67",
			[3] = "28",
		}
		
		local random_selection = math.random(0,2)
		chosen_set_idx = random_selection
		print("Selected: " .. chosen_set_idx)
		
		-- Create Background
		game_bg =  display.newImageRect( game_scene_block_group, ASSET_FOLDER .. "bg01.png", phone_width, phone_height )
		game_bg.x = phone_middle_x
		game_bg.y = phone_middle_y

		
		
		-- Create Question Window
		question_window = display.newImageRect( game_scene_block_group, ASSET_FOLDER .. "question-window.png", 536 * 0.5, 426 * 0.5 )
		question_window.x = phone_middle_x
		question_window.y = q_window_middle_point_y
		
		-- Create Question Text
		question_text = display.newText( game_scene_block_group, q_set[random_selection], phone_middle_x, q_window_middle_point_y +15, DEFAULT_FONT, 25 )
		question_text_2 = display.newText( game_scene_block_group, "What is the next number", phone_middle_x, q_window_middle_point_y - 35, DEFAULT_FONT, 20 )
		question_label = display.newText( game_scene_block_group, "No. "..current_lv, phone_middle_x, q_window_middle_point_y - 85, DEFAULT_FONT, 24 )
		
		-- Create Next Button
		next_button = display.newImageRect( game_scene_block_group, ASSET_FOLDER .. "answer-window.png", answer_window_width, answer_window_height )
		next_button.x = phone_middle_x
		next_button.y = q_answer_middle_point_y_1
		next_button:addEventListener("tap", proceed_next)
		
		next_button_text = display.newText( game_scene_block_group, "Next", next_button.x, next_button.y, DEFAULT_FONT, 24 )
	end

	function proceed_next()
		-- Hide Button
		next_button.isVisible = false
		next_button_text.isVisible = false
		
		-- Create Answer Window
		answer_window_1 = display.newImageRect( game_scene_block_group, ASSET_FOLDER .. "answer-window.png", answer_window_width, answer_window_height )
		answer_window_1.x = q_answer_middle_point_x_1
		answer_window_1.y = q_answer_middle_point_y_1
		answer_window_1.idx = 0
		answer_window_1:addEventListener("tap", check_answer)
		
		answer_window_2 = display.newImageRect( game_scene_block_group, ASSET_FOLDER .. "answer-window.png", answer_window_width, answer_window_height )
		answer_window_2.x = q_answer_middle_point_x_1
		answer_window_2.y = q_answer_middle_point_y_2
		answer_window_2.idx = 1
		answer_window_2:addEventListener("tap", check_answer)
		
		answer_window_3 = display.newImageRect( game_scene_block_group, ASSET_FOLDER .. "answer-window.png", answer_window_width, answer_window_height )
		answer_window_3.x = q_answer_middle_point_x_2
		answer_window_3.y = q_answer_middle_point_y_1
		answer_window_3.idx = 2
		answer_window_3:addEventListener("tap", check_answer)
		
		answer_window_4 = display.newImageRect( game_scene_block_group, ASSET_FOLDER .. "answer-window.png", answer_window_width, answer_window_height )
		answer_window_4.x = q_answer_middle_point_x_2
		answer_window_4.y = q_answer_middle_point_y_2
		answer_window_4.idx = 3
		answer_window_4:addEventListener("tap", check_answer)
		
		-- Create Answer Text
		answer_text_1 = display.newText( game_scene_block_group, a_set[0], q_answer_middle_point_x_1, q_answer_middle_point_y_1, DEFAULT_FONT, 24 )
		answer_text_2 = display.newText( game_scene_block_group, a_set[1], q_answer_middle_point_x_1, q_answer_middle_point_y_2, DEFAULT_FONT, 24 )
		answer_text_3 = display.newText( game_scene_block_group, a_set[2], q_answer_middle_point_x_2, q_answer_middle_point_y_1, DEFAULT_FONT, 24 )
		answer_text_4 = display.newText( game_scene_block_group, a_set[3], q_answer_middle_point_x_2, q_answer_middle_point_y_2, DEFAULT_FONT, 24 )
	end

	function check_answer(event)
		if event.target.idx == chosen_set_idx then
			print("Correct")
			--Remove Question 1
			remove_question()
			
			--require("level9")
			--init_level9()
			require ("gamedone")
			init_gamedone(current_lv)
		else
			-- Game Over
			remove_question()
			print("Wrong!")
			require ("gameover")
			init_gameover(current_lv)
		end
	end

	function remove_question()
		game_scene_block_group.isVisible = true
		
		display.remove(game_bg)
		
		display.remove(question_text)
		display.remove(question_text_2)
		display.remove(question_window)
		display.remove(question_label)
		
		display.remove(answer_window_1)
		display.remove(answer_window_2)
		display.remove(answer_window_3)
		display.remove(answer_window_4)
		
		display.remove(answer_text_1)
		display.remove(answer_text_2)
		display.remove(answer_text_3)
		display.remove(answer_text_4)
		
		display.remove(next_button)
		display.remove(next_button_text)
		
		display.remove(game_scene_block_group)
		display.remove(game_scene_group)
	end
	
	create_question()
end
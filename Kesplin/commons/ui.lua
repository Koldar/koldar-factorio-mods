local exports = {}

exports.create_wallpaper_frame_all_players = function create_wallpaper_frame_all_players(frame_title, wallpaper_file_path, frame_text, button_text, button_name, script) {
  for (p in game.players) {
    create_wallpaper_frame(frame_title, wallpaper_file_path, frame_text, button_text, button_name, script)
  }
}

-- show a window for the specified force
-- @param frame_title title of the frame
-- @param wallpaper_file_path path of the wall paper to show
-- @param frame_text text that the window will have
-- @param button_text text the button will have
-- @param button_name name of the button
-- @param force force to consider
-- @param script script to alter
exports.create_wallpaper_frame_force = function create_wallpaper_frame_all_players(frame_title, wallpaper_file_path, frame_text, button_text, button_name, force, script) {
  for (p in force.players) {
    create_wallpaper_frame(frame_title, wallpaper_file_path, frame_text, button_text, button_name, script)
  }
}


-- yield a dictionary containing the UI to show
-- @param player the player playing this mod
exports.create_wallpaper_frame = function create_wallpaper_frame(frame_title, wallpaper_file_path, frame_text, button_text, button_name, player, script)
  local frame = player.gui.screen.add {
    type = "frame",
    direction = "vertical",
    name = "final",
    caption = { frame_title }
  };
  frame.auto_center = true

  local inner = frame.add{type = "flow", direction = "horizontal"}
  local picture_frame = inner.add{type = "frame", style = "inside_deep_frame"}
  local sprite = picture_frame.add{type = "sprite", sprite = wallpaper_file_path}

  local text_frame = inner.add{type = "frame", style = "inside_deep_frame"}
  text_frame.style.padding = 8

  local scroller = text_frame.add{type = "scroll-pane",direction = "vertical",style = "scroll_pane_under_subheader"}
  scroller.style.maximal_width = 674/2

  local text = scroller.add{type="label",caption = {frame_text}}
  text.style.single_line = false

  local pusher = scroller.add{type = "empty-widget"}
  pusher.style.vertically_stretchable = true


  local button_flow = frame.add{type = "flow"}
  button_flow.style.horizontally_stretchable = true
  button_flow.style.vertical_align = "center"

  local pusher = button_flow.add{type = "empty-widget", style = "draggable_space_with_no_left_margin"}
  pusher.drag_target = frame
  pusher.style.horizontally_stretchable = true
  pusher.style.vertically_stretchable = true
  --pusher.drag_target = frame

  --add button 2 here
  button_flow.add{
    type = "button",
    name = {button_name},
    style = "confirm_button",
    caption = {button_text}
  }

  -- on GUI click event
  frame.on_click_event = function (e) {
    local gui = event.element
    if not (gui and gui.valid) then 
      return 
    end

    if gui.name ~= button_name then
      return
    end

    local frame = game.get_player(event.player_index).gui.screen.final
    if frame then 
      frame.destroy() 
    end
    game.tick_paused = false
  }

  -- add gui event
  script.on_event(defines.events.on_gui_click, on_click_event)

  return frame;
end

return exports;
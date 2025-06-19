-- wake_toggle.lua for FlyWithLua
-- Toggle wake turbulence with menu item showing status and red text on screen when disabled

-- DataRef: 1 = override ON = wake turbulence OFF, 0 = normal wake ON
wake_override = dataref("wake_override", "sim/operation/override/override_wake_turbulence", "writable")

-- Internal state to track menu label
wake_enabled = (wake_override == 0)

-- Macro name (we will update this dynamically)
macro_name = "Wake: ON"

-- Function to update macro menu label
function update_macro_label()
    local new_label = wake_override == 0 and "Wake: ON" or "Wake: OFF"
    if new_label ~= macro_name then
        -- Remove old macro, add new one with updated label
        remove_macro(macro_id)
        macro_name = new_label
        macro_id = add_macro(macro_name, "toggle_wake()", "", "deactivate")
    end
end

-- Toggle wake turbulence function
function toggle_wake()
    if wake_override == 0 then
        wake_override = 1
        logMsg("[WakeToggle] Wake turbulence DISABLED.")
    else
        wake_override = 0
        logMsg("[WakeToggle] Wake turbulence ENABLED.")
    end
    update_macro_label()
end

-- Draw red warning text in bottom-left when wake turbulence is disabled
function draw_wake_status()
    if wake_override == 1 then
        draw_string_Helvetica_18(10, 20, "Wake Turbulence OFF", 1.0, 0.0, 0.0)  -- red text
    end
end

-- Initialize macro
macro_id = add_macro(macro_name, "toggle_wake()", "", "deactivate")

-- Update macro label every frame (to catch external changes too)
do_every_frame("update_macro_label()")

-- Draw status text every frame
do_every_draw("draw_wake_status()")

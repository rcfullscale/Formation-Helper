-- wake_toggle.lua for FlyWithLua
-- Toggles wake turbulence on/off with menu and shows red text when disabled

-- DataRef: 1 = override ON = wake turbulence OFF, 0 = normal wake ON
wake_override = dataref("wake_override", "sim/operation/override/override_wake_turbulence", "writable")

-- Toggle wake turbulence function
function toggle_wake()
    if wake_override == 0 then
        wake_override = 1
        logMsg("[WakeToggle] Wake turbulence DISABLED.")
    else
        wake_override = 0
        logMsg("[WakeToggle] Wake turbulence ENABLED.")
    end
end

-- Add macros for toggling with dynamic status
add_macro("Wake: ON", "toggle_wake()", "", "deactivate")
add_macro("Wake: OFF", "toggle_wake()", "", "activate")

-- Draw red warning text in bottom-left when wake turbulence is disabled
function draw_wake_status()
    if wake_override == 1 then
        draw_string_Helvetica_18(10, 20, "Wake Turbulence OFF", 1.0, 0.0, 0.0)  -- red text
    end
end

do_every_draw("draw_wake_status()")

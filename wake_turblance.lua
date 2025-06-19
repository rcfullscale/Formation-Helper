-- wake_toggle.lua for FlyWithLua
-- Toggle wake turbulence override and show menu status

-- Get the dataref (1 = override = wake OFF, 0 = no override = wake ON)
wake_override = dataref("wake_override", "sim/operation/override/override_wake_turbulence", "writable")

-- Internal state
wake_enabled = (wake_override == 0)

-- Function to toggle
function toggle_wake()
    if wake_override == 0 then
        wake_override = 1
        wake_enabled = false
        logMsg("[WakeToggle] Wake turbulence disabled.")
    else
        wake_override = 0
        wake_enabled = true
        logMsg("[WakeToggle] Wake turbulence enabled.")
    end
end

-- Function to return status string
function wake_status()
    return wake_enabled and "Wake: ON" or "Wake: OFF"
end

-- Macro with dynamic title
do_every_frame([[
    if wake_override == 0 then
        wake_enabled = true
    else
        wake_enabled = false
    end
]])

add_macro("Wake: OFF", "toggle_wake()", "", "activate")
add_macro("Wake: ON", "toggle_wake()", "", "deactivate")

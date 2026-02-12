-- Example Usage of the UI Library
-- This script shows how to use all the features

local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/SuperHackerYT/Claude-UI/refs/heads/main/UILibrary.lua"))()

-- Create the main window
local Window = UILibrary:CreateWindow({
    Name = "My Cool Script",
    Size = UDim2.new(0, 550, 0, 400)
})

-- Create first tab
local MainTab = Window:CreateTab("Main")

-- Add a label
MainTab:CreateLabel("Welcome to the UI Library!")

-- Add a button
MainTab:CreateButton({
    Name = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end
})

-- Add a toggle
local myToggle = MainTab:CreateToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(value)
        print("Toggle state:", value)
    end
})

-- Add a slider
local mySlider = MainTab:CreateSlider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Increment = 1,
    Callback = function(value)
        print("Slider value:", value)
    end
})

-- Add a textbox
local myTextBox = MainTab:CreateTextBox({
    Name = "Username",
    Placeholder = "Enter your name...",
    Callback = function(text)
        print("TextBox value:", text)
    end
})

-- Add a dropdown
local myDropdown = MainTab:CreateDropdown({
    Name = "Select Option",
    Options = {"Option 1", "Option 2", "Option 3", "Option 4"},
    Default = "Option 1",
    Callback = function(option)
        print("Selected option:", option)
    end
})

-- Create second tab for combat features
local CombatTab = Window:CreateTab("Combat")

CombatTab:CreateLabel("Combat Settings")

CombatTab:CreateToggle({
    Name = "Auto Attack",
    Default = false,
    Callback = function(value)
        print("Auto Attack:", value)
    end
})

CombatTab:CreateSlider({
    Name = "Attack Range",
    Min = 10,
    Max = 100,
    Default = 50,
    Increment = 5,
    Callback = function(value)
        print("Attack Range:", value)
    end
})

CombatTab:CreateButton({
    Name = "Kill All",
    Callback = function()
        print("Kill All executed!")
    end
})

-- Create third tab for player features
local PlayerTab = Window:CreateTab("Player")

PlayerTab:CreateLabel("Player Modifications")

PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

PlayerTab:CreateSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 300,
    Default = 50,
    Increment = 10,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})

PlayerTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
})

-- Create fourth tab for misc features
local MiscTab = Window:CreateTab("Misc")

MiscTab:CreateLabel("Miscellaneous Features")

MiscTab:CreateToggle({
    Name = "No Clip",
    Default = false,
    Callback = function(value)
        -- NoClip implementation would go here
        print("NoClip:", value)
    end
})

MiscTab:CreateDropdown({
    Name = "Teleport To",
    Options = {"Spawn", "Shop", "Arena", "Secret Area"},
    Default = "Spawn",
    Callback = function(location)
        print("Teleporting to:", location)
        -- Teleport logic would go here
    end
})

MiscTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        print("Infinite Jump toggled!")
    end
})

-- Programmatically updating elements:
-- myToggle.Set(true)  -- Set toggle to true
-- mySlider.Set(75)    -- Set slider to 75
-- myTextBox.Set("New Text")  -- Set textbox text
-- myDropdown.Set("Option 2")  -- Set dropdown to Option 2

print("UI Library loaded successfully!")

# Roblox UI Library Documentation

A modern, feature-rich UI library for Roblox with a clean design and smooth animations.

## Features

- **Modern Design**: Clean, dark-themed interface with smooth animations
- **Draggable Windows**: Click and drag the top bar to move the window
- **Multiple Tabs**: Organize your UI elements into different categories
- **Rich Components**: Buttons, toggles, sliders, textboxes, dropdowns, and labels
- **Ripple Effects**: Material design-inspired ripple effects on buttons
- **Smooth Animations**: Tween-based animations for all interactions
- **Easy to Use**: Simple API for quick implementation

## Installation

1. Copy the `UILibrary.lua` script
2. Load it in your script:

```lua
local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/SuperHackerYT/Claude-UI/refs/heads/main/UILibrary.lua"))()
```

Or if you have it as a ModuleScript:

```lua
local UILibrary = require(game.ReplicatedStorage.UILibrary)
```

## Basic Usage

### Creating a Window

```lua
local Window = UILibrary:CreateWindow({
    Name = "My Script Hub",
    Size = UDim2.new(0, 550, 0, 400)  -- Optional, defaults to 550x400
})
```

### Creating a Tab

```lua
local Tab = Window:CreateTab("Main")
```

## UI Elements

### Button

Creates a clickable button that executes a callback function.

```lua
Tab:CreateButton({
    Name = "Click Me",
    Callback = function()
        print("Button was clicked!")
    end
})
```

### Toggle

Creates a toggle switch for boolean values.

```lua
local toggle = Tab:CreateToggle({
    Name = "Enable Feature",
    Default = false,  -- Starting state
    Callback = function(value)
        print("Toggle is now:", value)
    end
})

-- Programmatically set the toggle
toggle.Set(true)
```

### Slider

Creates a slider for numeric values within a range.

```lua
local slider = Tab:CreateSlider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Increment = 1,  -- Step size
    Callback = function(value)
        print("Slider value:", value)
    end
})

-- Programmatically set the slider
slider.Set(75)
```

### TextBox

Creates an input field for text entry.

```lua
local textbox = Tab:CreateTextBox({
    Name = "Username",
    Placeholder = "Enter text...",
    Callback = function(text)
        print("Text entered:", text)
    end
})

-- Programmatically set the text
textbox.Set("New Value")
```

### Dropdown

Creates a dropdown menu for selecting from multiple options.

```lua
local dropdown = Tab:CreateDropdown({
    Name = "Select Mode",
    Options = {"Mode 1", "Mode 2", "Mode 3"},
    Default = "Mode 1",
    Callback = function(selected)
        print("Selected:", selected)
    end
})

-- Programmatically set the selection
dropdown.Set("Mode 2")
```

### Label

Creates a simple text label for displaying information.

```lua
local label = Tab:CreateLabel("This is a label")

-- Update the label text
label.Set("New label text")
```

## Complete Example

```lua
local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/SuperHackerYT/Claude-UI/refs/heads/main/UILibrary.lua"))()

-- Create window
local Window = UILibrary:CreateWindow({
    Name = "Script Hub"
})

-- Create tabs
local MainTab = Window:CreateTab("Main")
local SettingsTab = Window:CreateTab("Settings")

-- Add elements to Main tab
MainTab:CreateLabel("Welcome!")

MainTab:CreateButton({
    Name = "Test Button",
    Callback = function()
        print("Clicked!")
    end
})

local speedSlider = MainTab:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Increment = 1,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

-- Add elements to Settings tab
SettingsTab:CreateToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(enabled)
        print("Auto Farm:", enabled)
    end
})

SettingsTab:CreateDropdown({
    Name = "Theme",
    Options = {"Dark", "Light", "Blue"},
    Default = "Dark",
    Callback = function(theme)
        print("Theme changed to:", theme)
    end
})
```

## Customization

### Window Configuration

```lua
local Window = UILibrary:CreateWindow({
    Name = "Custom Name",           -- Window title
    Size = UDim2.new(0, 600, 0, 450) -- Custom size (width, height)
})
```

### Colors

To customize colors, modify the RGB values in the library script:

- **Main Background**: `Color3.fromRGB(25, 25, 35)`
- **Top Bar**: `Color3.fromRGB(30, 30, 45)`
- **Tab Container**: `Color3.fromRGB(20, 20, 30)`
- **Elements**: `Color3.fromRGB(40, 40, 60)`
- **Active Tab**: `Color3.fromRGB(60, 60, 90)`
- **Accent Color**: `Color3.fromRGB(80, 120, 255)`

## Features Breakdown

### Draggable Window
Click and hold the top bar to drag the window anywhere on screen.

### Close Button
Red X button in the top right corner to close the UI with a smooth animation.

### Scrollable Content
Each tab has a scrollable content area that automatically adjusts based on the number of elements.

### Ripple Effects
Buttons feature material design-inspired ripple effects when clicked.

### Smooth Animations
All interactions use tween-based animations for a polished feel.

## Tips

1. **Organization**: Use tabs to organize different categories of features
2. **Labels**: Use labels to separate sections within a tab
3. **Callbacks**: Keep callback functions clean and focused
4. **Defaults**: Set sensible default values for toggles and sliders
5. **Names**: Use clear, descriptive names for all elements

## Browser Compatibility

This library works in:
- Roblox Studio
- Roblox Client (PC)
- Mobile (with adapted touch controls)

## Performance

The library is optimized for performance:
- Minimal use of loops
- Efficient event connections
- Lightweight animations
- No memory leaks

## Support

If you encounter any issues:
1. Check that all syntax is correct
2. Ensure you're using the latest version
3. Verify that all required services are available
4. Check the console for error messages

## Credits

Created from scratch with modern UI/UX principles and Roblox best practices.

## License

Free to use and modify for personal and commercial projects.

-- Modern Roblox UI Library
-- Created with modular design and clean aesthetics

local UILibrary = {}
UILibrary.__index = UILibrary

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Utility Functions
local function tween(object, properties, duration)
    duration = duration or 0.2
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

local function createRipple(parent, x, y)
    local ripple = Instance.new("ImageLabel")
    ripple.Name = "Ripple"
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.BackgroundTransparency = 1
    ripple.Position = UDim2.new(0, x, 0, y)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
    ripple.ImageTransparency = 0.5
    ripple.ZIndex = 10
    ripple.Parent = parent
    
    tween(ripple, {Size = UDim2.new(1, 0, 1, 0), ImageTransparency = 1}, 0.5)
    
    task.delay(0.5, function()
        ripple:Destroy()
    end)
end

-- Main Library Constructor
function UILibrary:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or "UI Library"
    local windowSize = config.Size or UDim2.new(0, 550, 0, 400)
    
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UILibrary"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Main Window Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size = windowSize
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame
    
    -- Make frame translucent
    mainFrame.BackgroundTransparency = 0.15
    
    -- Top Bar
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 45)
    topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    topBar.BackgroundTransparency = 0.2
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame
    
    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 16)
    topCorner.Parent = topBar
    
    -- Cover bottom corners of top bar
    local topBarCover = Instance.new("Frame")
    topBarCover.Position = UDim2.new(0, 0, 1, -16)
    topBarCover.Size = UDim2.new(1, 0, 0, 16)
    topBarCover.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    topBarCover.BackgroundTransparency = 0.2
    topBarCover.BorderSizePixel = 0
    topBarCover.Parent = topBar
    
    -- Add gradient to top bar
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 80, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 60, 180))
    }
    gradient.Rotation = 45
    gradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.7),
        NumberSequenceKeypoint.new(1, 0.8)
    }
    gradient.Parent = topBar
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Position = UDim2.new(0, 15, 0, 0)
    title.Size = UDim2.new(1, -90, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = windowName
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topBar
    
    -- Minimize Button
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.AnchorPoint = Vector2.new(1, 0.5)
    minimizeButton.Position = UDim2.new(1, -50, 0.5, 0)
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
    minimizeButton.BackgroundTransparency = 0.3
    minimizeButton.Text = "−"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.TextSize = 18
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Parent = topBar
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 8)
    minimizeCorner.Parent = minimizeButton
    
    local minimized = false
    local originalSize = windowSize
    
    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            tween(mainFrame, {Size = UDim2.new(0, originalSize.X.Offset, 0, 45)}, 0.3)
            minimizeButton.Text = "□"
            tabContainer.Visible = false
            contentContainer.Visible = false
            if Window.Blur then
                Window.Blur.Enabled = false
            end
        else
            tween(mainFrame, {Size = originalSize}, 0.3)
            minimizeButton.Text = "−"
            tabContainer.Visible = true
            contentContainer.Visible = true
            if Window.Blur then
                Window.Blur.Enabled = true
            end
        end
    end)
    
    minimizeButton.MouseEnter:Connect(function()
        tween(minimizeButton, {BackgroundTransparency = 0.1})
    end)
    
    minimizeButton.MouseLeave:Connect(function()
        tween(minimizeButton, {BackgroundTransparency = 0.3})
    end)
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.AnchorPoint = Vector2.new(1, 0.5)
    closeButton.Position = UDim2.new(1, -10, 0.5, 0)
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 80)
    closeButton.BackgroundTransparency = 0.3
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.BorderSizePixel = 0
    closeButton.Parent = topBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        task.wait(0.3)
        if Window.Blur then
            Window.Blur:Destroy()
        end
        screenGui:Destroy()
    end)
    
    closeButton.MouseEnter:Connect(function()
        tween(closeButton, {BackgroundTransparency = 0.1})
    end)
    
    closeButton.MouseLeave:Connect(function()
        tween(closeButton, {BackgroundTransparency = 0.3})
    end)
    
    -- Tab Container
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Position = UDim2.new(0, 0, 0, 45)
    tabContainer.Size = UDim2.new(0, 150, 1, -45)
    tabContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    tabContainer.BackgroundTransparency = 0.3
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = mainFrame
    
    local tabListLayout = Instance.new("UIListLayout")
    tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabListLayout.Padding = UDim.new(0, 5)
    tabListLayout.Parent = tabContainer
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingTop = UDim.new(0, 10)
    tabPadding.PaddingLeft = UDim.new(0, 10)
    tabPadding.PaddingRight = UDim.new(0, 10)
    tabPadding.Parent = tabContainer
    
    -- Content Container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Position = UDim2.new(0, 150, 0, 45)
    contentContainer.Size = UDim2.new(1, -150, 1, -45)
    contentContainer.BackgroundTransparency = 1
    contentContainer.BorderSizePixel = 0
    contentContainer.Parent = mainFrame
    
    -- Dragging functionality (Mobile & Desktop compatible)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
    
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
    
    -- Window Object
    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    -- Blur effect
    local blur = Instance.new("BlurEffect")
    blur.Size = 10
    blur.Parent = game.Lighting
    Window.Blur = blur
    
    function Window:CreateTab(tabName)
        local Tab = {}
        Tab.Name = tabName
        Tab.Elements = {}
        
        -- Tab Button
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        tabButton.BackgroundTransparency = 0.4
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(220, 220, 240)
        tabButton.TextSize = 15
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.BorderSizePixel = 0
        tabButton.Parent = tabContainer
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 10)
        tabCorner.Parent = tabButton
        
        -- Tab Content Frame
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tabName .. "Content"
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.ScrollBarThickness = 4
        tabContent.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
        tabContent.Visible = false
        tabContent.Parent = contentContainer
        
        local contentListLayout = Instance.new("UIListLayout")
        contentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentListLayout.Padding = UDim.new(0, 8)
        contentListLayout.Parent = tabContent
        
        local contentPadding = Instance.new("UIPadding")
        contentPadding.PaddingTop = UDim.new(0, 10)
        contentPadding.PaddingLeft = UDim.new(0, 15)
        contentPadding.PaddingRight = UDim.new(0, 15)
        contentPadding.PaddingBottom = UDim.new(0, 10)
        contentPadding.Parent = tabContent
        
        -- Auto-resize ScrollingFrame
        contentListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentListLayout.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab switching
        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                tab.Button.BackgroundTransparency = 0.4
                tab.Button.TextColor3 = Color3.fromRGB(220, 220, 240)
                if tab.Gradient then
                    tab.Gradient:Destroy()
                    tab.Gradient = nil
                end
                tab.Content.Visible = false
            end
            
            tabButton.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
            tabButton.BackgroundTransparency = 0.2
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            
            -- Add gradient to active tab
            local tabGradient = Instance.new("UIGradient")
            tabGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 80, 200)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 100, 220))
            }
            tabGradient.Rotation = 90
            tabGradient.Parent = tabButton
            Tab.Gradient = tabGradient
            
            tabContent.Visible = true
            Window.CurrentTab = Tab
        end)
        
        tabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                tween(tabButton, {BackgroundTransparency = 0.2})
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                tween(tabButton, {BackgroundTransparency = 0.4})
            end
        end)
        
        Tab.Button = tabButton
        Tab.Content = tabContent
        
        -- If first tab, make it active
        if #Window.Tabs == 0 then
            tabButton.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
            tabButton.BackgroundTransparency = 0.2
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            
            local tabGradient = Instance.new("UIGradient")
            tabGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 80, 200)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 100, 220))
            }
            tabGradient.Rotation = 90
            tabGradient.Parent = tabButton
            Tab.Gradient = tabGradient
            
            tabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        -- Button Element
        function Tab:CreateButton(config)
            config = config or {}
            local buttonName = config.Name or "Button"
            local callback = config.Callback or function() end
            
            local buttonFrame = Instance.new("TextButton")
            buttonFrame.Name = buttonName
            buttonFrame.Size = UDim2.new(1, 0, 0, 40)
            buttonFrame.BackgroundColor3 = Color3.fromRGB(70, 90, 180)
            buttonFrame.BackgroundTransparency = 0.3
            buttonFrame.Text = buttonName
            buttonFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
            buttonFrame.TextSize = 15
            buttonFrame.Font = Enum.Font.GothamSemibold
            buttonFrame.BorderSizePixel = 0
            buttonFrame.ClipsDescendants = true
            buttonFrame.Parent = tabContent
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 12)
            buttonCorner.Parent = buttonFrame
            
            local buttonGradient = Instance.new("UIGradient")
            buttonGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 110, 200)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 90, 180))
            }
            buttonGradient.Rotation = 90
            buttonGradient.Parent = buttonFrame
            
            buttonFrame.MouseButton1Click:Connect(function()
                createRipple(buttonFrame, buttonFrame.AbsoluteSize.X / 2, buttonFrame.AbsoluteSize.Y / 2)
                callback()
            end)
            
            buttonFrame.MouseEnter:Connect(function()
                tween(buttonFrame, {BackgroundTransparency = 0.1})
            end)
            
            buttonFrame.MouseLeave:Connect(function()
                tween(buttonFrame, {BackgroundTransparency = 0.3})
            end)
            
            return buttonFrame
        end
        
        -- Toggle Element
        function Tab:CreateToggle(config)
            config = config or {}
            local toggleName = config.Name or "Toggle"
            local defaultState = config.Default or false
            local callback = config.Callback or function() end
            
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Name = toggleName
            toggleFrame.Size = UDim2.new(1, 0, 0, 40)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            toggleFrame.BackgroundTransparency = 0.3
            toggleFrame.BorderSizePixel = 0
            toggleFrame.Parent = tabContent
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 12)
            toggleCorner.Parent = toggleFrame
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Position = UDim2.new(0, 15, 0, 0)
            toggleLabel.Size = UDim2.new(1, -70, 1, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = toggleName
            toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleLabel.TextSize = 15
            toggleLabel.Font = Enum.Font.GothamSemibold
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame
            
            local toggleButton = Instance.new("TextButton")
            toggleButton.AnchorPoint = Vector2.new(1, 0.5)
            toggleButton.Position = UDim2.new(1, -12, 0.5, 0)
            toggleButton.Size = UDim2.new(0, 45, 0, 24)
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            toggleButton.BackgroundTransparency = 0.2
            toggleButton.Text = ""
            toggleButton.BorderSizePixel = 0
            toggleButton.Parent = toggleFrame
            
            local toggleButtonCorner = Instance.new("UICorner")
            toggleButtonCorner.CornerRadius = UDim.new(1, 0)
            toggleButtonCorner.Parent = toggleButton
            
            local toggleIndicator = Instance.new("Frame")
            toggleIndicator.Position = UDim2.new(0, 3, 0.5, 0)
            toggleIndicator.AnchorPoint = Vector2.new(0, 0.5)
            toggleIndicator.Size = UDim2.new(0, 18, 0, 18)
            toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleIndicator.BorderSizePixel = 0
            toggleIndicator.Parent = toggleButton
            
            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(1, 0)
            indicatorCorner.Parent = toggleIndicator
            
            local toggled = defaultState
            
            local function updateToggle()
                if toggled then
                    tween(toggleButton, {BackgroundColor3 = Color3.fromRGB(100, 120, 255)})
                    tween(toggleIndicator, {Position = UDim2.new(1, -21, 0.5, 0)})
                else
                    tween(toggleButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 70)})
                    tween(toggleIndicator, {Position = UDim2.new(0, 3, 0.5, 0)})
                end
                callback(toggled)
            end
            
            toggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                updateToggle()
            end)
            
            updateToggle()
            
            return {
                Set = function(state)
                    toggled = state
                    updateToggle()
                end
            }
        end
        
        -- Slider Element
        function Tab:CreateSlider(config)
            config = config or {}
            local sliderName = config.Name or "Slider"
            local minValue = config.Min or 0
            local maxValue = config.Max or 100
            local defaultValue = config.Default or 50
            local increment = config.Increment or 1
            local callback = config.Callback or function() end
            
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Name = sliderName
            sliderFrame.Size = UDim2.new(1, 0, 0, 55)
            sliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            sliderFrame.BackgroundTransparency = 0.3
            sliderFrame.BorderSizePixel = 0
            sliderFrame.Parent = tabContent
            
            local sliderCorner = Instance.new("UICorner")
            sliderCorner.CornerRadius = UDim.new(0, 12)
            sliderCorner.Parent = sliderFrame
            
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Position = UDim2.new(0, 15, 0, 5)
            sliderLabel.Size = UDim2.new(1, -90, 0, 20)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = sliderName
            sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            sliderLabel.TextSize = 15
            sliderLabel.Font = Enum.Font.GothamSemibold
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.Parent = sliderFrame
            
            local sliderValue = Instance.new("TextLabel")
            sliderValue.Position = UDim2.new(1, -15, 0, 5)
            sliderValue.Size = UDim2.new(0, 70, 0, 20)
            sliderValue.AnchorPoint = Vector2.new(1, 0)
            sliderValue.BackgroundTransparency = 1
            sliderValue.Text = tostring(defaultValue)
            sliderValue.TextColor3 = Color3.fromRGB(150, 180, 255)
            sliderValue.TextSize = 14
            sliderValue.Font = Enum.Font.GothamBold
            sliderValue.TextXAlignment = Enum.TextXAlignment.Right
            sliderValue.Parent = sliderFrame
            
            local sliderBar = Instance.new("Frame")
            sliderBar.Position = UDim2.new(0, 15, 1, -20)
            sliderBar.Size = UDim2.new(1, -30, 0, 8)
            sliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            sliderBar.BackgroundTransparency = 0.3
            sliderBar.BorderSizePixel = 0
            sliderBar.Parent = sliderFrame
            
            local sliderBarCorner = Instance.new("UICorner")
            sliderBarCorner.CornerRadius = UDim.new(1, 0)
            sliderBarCorner.Parent = sliderBar
            
            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
            sliderFill.BackgroundColor3 = Color3.fromRGB(100, 120, 255)
            sliderFill.BorderSizePixel = 0
            sliderFill.Parent = sliderBar
            
            local sliderFillCorner = Instance.new("UICorner")
            sliderFillCorner.CornerRadius = UDim.new(1, 0)
            sliderFillCorner.Parent = sliderFill
            
            local sliderFillGradient = Instance.new("UIGradient")
            sliderFillGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 100, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 120, 255))
            }
            sliderFillGradient.Parent = sliderFill
            
            local sliderButton = Instance.new("Frame")
            sliderButton.AnchorPoint = Vector2.new(1, 0.5)
            sliderButton.Position = UDim2.new(1, 0, 0.5, 0)
            sliderButton.Size = UDim2.new(0, 18, 0, 18)
            sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sliderButton.BorderSizePixel = 0
            sliderButton.Parent = sliderFill
            
            local sliderButtonCorner = Instance.new("UICorner")
            sliderButtonCorner.CornerRadius = UDim.new(1, 0)
            sliderButtonCorner.Parent = sliderButton
            
            local dragging = false
            local currentValue = defaultValue
            
            local function snap(value)
                return math.floor(value / increment + 0.5) * increment
            end
            
            local function updateSlider(input)
                local sizeX = sliderBar.AbsoluteSize.X
                local posX = math.clamp(input.Position.X - sliderBar.AbsolutePosition.X, 0, sizeX)
                local percentage = posX / sizeX
                
                local rawValue = minValue + (maxValue - minValue) * percentage
                currentValue = math.clamp(snap(rawValue), minValue, maxValue)
                
                local displayPercentage = (currentValue - minValue) / (maxValue - minValue)
                sliderFill.Size = UDim2.new(displayPercentage, 0, 1, 0)
                sliderValue.Text = tostring(currentValue)
                
                callback(currentValue)
            end
            
            sliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateSlider(input)
                end
            end)
            
            sliderBar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            -- Set initial value
            local percentage = (defaultValue - minValue) / (maxValue - minValue)
            sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
            
            return {
                Set = function(value)
                    currentValue = math.clamp(snap(value), minValue, maxValue)
                    local percentage = (currentValue - minValue) / (maxValue - minValue)
                    sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                    sliderValue.Text = tostring(currentValue)
                    callback(currentValue)
                end
            }
        end
        
        -- TextBox Element
        function Tab:CreateTextBox(config)
            config = config or {}
            local textBoxName = config.Name or "TextBox"
            local placeholder = config.Placeholder or "Enter text..."
            local callback = config.Callback or function() end
            
            local textBoxFrame = Instance.new("Frame")
            textBoxFrame.Name = textBoxName
            textBoxFrame.Size = UDim2.new(1, 0, 0, 40)
            textBoxFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            textBoxFrame.BackgroundTransparency = 0.3
            textBoxFrame.BorderSizePixel = 0
            textBoxFrame.Parent = tabContent
            
            local textBoxCorner = Instance.new("UICorner")
            textBoxCorner.CornerRadius = UDim.new(0, 12)
            textBoxCorner.Parent = textBoxFrame
            
            local textBoxLabel = Instance.new("TextLabel")
            textBoxLabel.Position = UDim2.new(0, 15, 0, 0)
            textBoxLabel.Size = UDim2.new(0, 110, 1, 0)
            textBoxLabel.BackgroundTransparency = 1
            textBoxLabel.Text = textBoxName
            textBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textBoxLabel.TextSize = 15
            textBoxLabel.Font = Enum.Font.GothamSemibold
            textBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
            textBoxLabel.Parent = textBoxFrame
            
            local textBox = Instance.new("TextBox")
            textBox.Position = UDim2.new(0, 135, 0.5, 0)
            textBox.AnchorPoint = Vector2.new(0, 0.5)
            textBox.Size = UDim2.new(1, -150, 0, 28)
            textBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
            textBox.BackgroundTransparency = 0.2
            textBox.Text = ""
            textBox.PlaceholderText = placeholder
            textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 170)
            textBox.TextSize = 14
            textBox.Font = Enum.Font.Gotham
            textBox.BorderSizePixel = 0
            textBox.ClearTextOnFocus = false
            textBox.Parent = textBoxFrame
            
            local textBoxInputCorner = Instance.new("UICorner")
            textBoxInputCorner.CornerRadius = UDim.new(0, 8)
            textBoxInputCorner.Parent = textBox
            
            textBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    callback(textBox.Text)
                end
            end)
            
            return {
                Set = function(text)
                    textBox.Text = text
                    callback(text)
                end
            }
        end
        
        -- Dropdown Element
        function Tab:CreateDropdown(config)
            config = config or {}
            local dropdownName = config.Name or "Dropdown"
            local options = config.Options or {"Option 1", "Option 2"}
            local defaultOption = config.Default or options[1]
            local callback = config.Callback or function() end
            
            local dropdownFrame = Instance.new("Frame")
            dropdownFrame.Name = dropdownName
            dropdownFrame.Size = UDim2.new(1, 0, 0, 40)
            dropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            dropdownFrame.BackgroundTransparency = 0.3
            dropdownFrame.BorderSizePixel = 0
            dropdownFrame.ClipsDescendants = true
            dropdownFrame.ZIndex = 2
            dropdownFrame.Parent = tabContent
            
            local dropdownCorner = Instance.new("UICorner")
            dropdownCorner.CornerRadius = UDim.new(0, 12)
            dropdownCorner.Parent = dropdownFrame
            
            local dropdownButton = Instance.new("TextButton")
            dropdownButton.Size = UDim2.new(1, 0, 0, 40)
            dropdownButton.BackgroundTransparency = 1
            dropdownButton.Text = ""
            dropdownButton.ZIndex = 3
            dropdownButton.Parent = dropdownFrame
            
            local dropdownLabel = Instance.new("TextLabel")
            dropdownLabel.Position = UDim2.new(0, 15, 0, 0)
            dropdownLabel.Size = UDim2.new(1, -50, 0, 40)
            dropdownLabel.BackgroundTransparency = 1
            dropdownLabel.Text = dropdownName .. ": " .. defaultOption
            dropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            dropdownLabel.TextSize = 15
            dropdownLabel.Font = Enum.Font.GothamSemibold
            dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            dropdownLabel.ZIndex = 3
            dropdownLabel.Parent = dropdownFrame
            
            local dropdownArrow = Instance.new("TextLabel")
            dropdownArrow.AnchorPoint = Vector2.new(1, 0.5)
            dropdownArrow.Position = UDim2.new(1, -15, 0, 20)
            dropdownArrow.Size = UDim2.new(0, 20, 0, 20)
            dropdownArrow.BackgroundTransparency = 1
            dropdownArrow.Text = "▼"
            dropdownArrow.TextColor3 = Color3.fromRGB(150, 180, 255)
            dropdownArrow.TextSize = 14
            dropdownArrow.Font = Enum.Font.GothamBold
            dropdownArrow.ZIndex = 3
            dropdownArrow.Parent = dropdownFrame
            
            local optionsList = Instance.new("Frame")
            optionsList.Position = UDim2.new(0, 0, 0, 40)
            optionsList.Size = UDim2.new(1, 0, 0, 0)
            optionsList.BackgroundTransparency = 1
            optionsList.ZIndex = 3
            optionsList.Parent = dropdownFrame
            
            local optionsListLayout = Instance.new("UIListLayout")
            optionsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            optionsListLayout.Parent = optionsList
            
            local expanded = false
            local currentOption = defaultOption
            
            for _, option in ipairs(options) do
                local optionButton = Instance.new("TextButton")
                optionButton.Size = UDim2.new(1, 0, 0, 35)
                optionButton.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
                optionButton.BackgroundTransparency = 0.2
                optionButton.Text = option
                optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                optionButton.TextSize = 14
                optionButton.Font = Enum.Font.Gotham
                optionButton.BorderSizePixel = 0
                optionButton.ZIndex = 4
                optionButton.Parent = optionsList
                
                optionButton.MouseButton1Click:Connect(function()
                    currentOption = option
                    dropdownLabel.Text = dropdownName .. ": " .. option
                    expanded = false
                    tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 40)})
                    tween(dropdownArrow, {Rotation = 0})
                    callback(option)
                end)
                
                optionButton.MouseEnter:Connect(function()
                    tween(optionButton, {BackgroundTransparency = 0})
                end)
                
                optionButton.MouseLeave:Connect(function()
                    tween(optionButton, {BackgroundTransparency = 0.2})
                end)
            end
            
            dropdownButton.MouseButton1Click:Connect(function()
                expanded = not expanded
                if expanded then
                    tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 40 + #options * 35)})
                    tween(dropdownArrow, {Rotation = 180})
                else
                    tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 40)})
                    tween(dropdownArrow, {Rotation = 0})
                end
            end)
            
            return {
                Set = function(option)
                    currentOption = option
                    dropdownLabel.Text = dropdownName .. ": " .. option
                    callback(option)
                end
            }
        end
        
        -- Label Element
        function Tab:CreateLabel(labelText)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 35)
            label.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            label.BackgroundTransparency = 0.3
            label.Text = labelText
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextSize = 15
            label.Font = Enum.Font.GothamSemibold
            label.BorderSizePixel = 0
            label.Parent = tabContent
            
            local labelCorner = Instance.new("UICorner")
            labelCorner.CornerRadius = UDim.new(0, 12)
            labelCorner.Parent = label
            
            return {
                Set = function(text)
                    label.Text = text
                end
            }
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    return Window
end

return UILibrary

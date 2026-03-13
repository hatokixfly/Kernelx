-- Kernel V2 GUI Script

local KernelV2 = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LogoButton = Instance.new("TextButton")
local LoadingPanel = Instance.new("Frame")
local LoadingText = Instance.new("TextLabel")
local LoadingBar = Instance.new("Frame")
local MainTab = Instance.new("TextButton")
local SettingsTab = Instance.new("TextButton")
local MainContent = Instance.new("Frame")
local SettingsContent = Instance.new("Frame")
local ToggleTemplate = Instance.new("TextButton")

-- Styles
local premiumBlack = Color3.fromRGB(25, 25, 25)
local accentRed = Color3.fromRGB(255, 0, 0)
local darkBackground = Color3.fromRGB(15, 15, 15)
local glowColor = Color3.fromRGB(255, 0, 0, 0.5)

-- Utility Functions
local function createDraggable(frame)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Logo Button
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.BackgroundColor3 = premiumBlack
LogoButton.Text = "K"
LogoButton.TextColor3 = accentRed
LogoButton.TextSize = 24
LogoButton.Font = Enum.Font.SourceSansBold
LogoButton.ZIndex = 2
LogoButton.Parent = KernelV2

createDraggable(LogoButton)

LogoButton.MouseButton1Click:Connect(function()
    if MainFrame.Visible then
        MainFrame:TweenPosition(UDim2.new(0.5, 0, 1, 0), "Out", "Quad", 0.5, true)
    else
        MainFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", 0.5, true)
    end
    MainFrame.Visible = not MainFrame.Visible
end)

-- Loading Panel
LoadingPanel.Size = UDim2.new(0, 300, 0, 150)
LoadingPanel.Position = UDim2.new(0.5, -150, 0.5, -75)
LoadingPanel.BackgroundColor3 = premiumBlack
LoadingPanel.BorderSizePixel = 0
LoadingPanel.Parent = KernelV2

LoadingText.Size = UDim2.new(1, 0, 0.5, 0)
LoadingText.Position = UDim2.new(0, 0, 0, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "KERNEL V2"
LoadingText.TextColor3 = accentRed
LoadingText.TextSize = 48
LoadingText.Font = Enum.Font.SourceSansBold
LoadingText.Parent = LoadingPanel

LoadingBar.Size = UDim2.new(1, 0, 0.1, 0)
LoadingBar.Position = UDim2.new(0, 0, 0.6, 0)
LoadingBar.BackgroundColor3 = accentRed
LoadingBar.Parent = LoadingPanel

spawn(function()
    for i = 0, 100, 1 do
        LoadingBar.Size = UDim2.new(i / 100, 0, 0.1, 0)
        wait(0.01)
    end
    LoadingPanel:TweenPosition(UDim2.new(0.5, 0, 1, 0), "Out", "Quad", 0.5, true)
    wait(0.5)
    LoadingPanel.Visible = false
    MainFrame.Visible = true
end)

-- Main Frame
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, 0, 1, 0)
MainFrame.BackgroundColor3 = premiumBlack
MainFrame.BorderSizePixel = 0
MainFrame.Parent = KernelV2

-- Tabs
MainTab.Size = UDim2.new(0.5, 0, 0, 50)
MainTab.Position = UDim2.new(0, 0, 0, 0)
MainTab.BackgroundColor3 = premiumBlack
MainTab.Text = "MAIN"
MainTab.TextColor3 = Color3.fromRGB(150, 150, 150)
MainTab.TextSize = 24
MainTab.Font = Enum.Font.SourceSansBold
MainTab.ZIndex = 2
MainTab.Parent = MainFrame

SettingsTab.Size = UDim2.new(0.5, 0, 0, 50)
SettingsTab.Position = UDim2.new(0.5, 0, 0, 0)
SettingsTab.BackgroundColor3 = accentRed
SettingsTab.Text = "SETTINGS"
SettingsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTab.TextSize = 24
SettingsTab.Font = Enum.Font.SourceSansBold
SettingsTab.ZIndex = 2
SettingsTab.Parent = MainFrame

-- Content Frames
MainContent.Size = UDim2.new(1, 0, 1, -50)
MainContent.Position = UDim2.new(0, 0, 0, 50)
MainContent.BackgroundColor3 = premiumBlack
MainContent.BorderSizePixel = 0
MainContent.Parent = MainFrame

SettingsContent.Size = UDim2.new(1, 0, 1, -50)
SettingsContent.Position = UDim2.new(0, 0, 0, 50)
SettingsContent.BackgroundColor3 = premiumBlack
SettingsContent.BorderSizePixel = 0
SettingsContent.Parent = MainFrame
SettingsContent.Visible = false

-- Toggle Template
local function createToggle(parent, text, callback)
    local toggle = ToggleTemplate:Clone()
    toggle.Size = UDim2.new(1, 0, 0, 30)
    toggle.Position = UDim2.new(0, 0, 0, 0)
    toggle.BackgroundColor3 = premiumBlack
    toggle.Text = text
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 20
    toggle.Font = Enum.Font.SourceSansBold
    toggle.ZIndex = 2
    toggle.Parent = parent

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0.2, 0, 1, 0)
    circle.Position = UDim2.new(0.8, 0, 0, 0)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = toggle

    local function updateToggle(state)
        circle:TweenPosition(UDim2.new(state and 0.8 or 0, 0, 0, 0), "Out", "Quad", 0.2, true)
        circle.BackgroundColor3 = state and accentRed or Color3.fromRGB(255, 255, 255)
    end

    toggle.MouseButton1Click:Connect(function()
        updateToggle(not circle.Position.X.Scale == 0.8)
        callback(not circle.Position.X.Scale == 0.8)
    end)

    return toggle
end

-- Main Content
createToggle(MainContent, "ESP BOX", function(state)
    -- ESP BOX logic
end)

createToggle(MainContent, "AUTO TOOL SLOT 1", function(state)
    -- AUTO TOOL SLOT 1 logic
end)

createToggle(MainContent, "AUTO ACTION", function(state)
    -- AUTO ACTION logic
end)

createToggle(MainContent, "START BOOST", function(state)
    -- START BOOST logic
end)

createToggle(MainContent, "KILL AURA", function(state)
    -- KILL AURA logic
end)

createToggle(MainContent, "AUTO KILL", function(state)
    -- AUTO KILL logic
end)

createToggle(MainContent, "AUTO JOIN", function(state)
    -- AUTO JOIN logic
end)

createToggle(MainContent, "SAVE SETTINGS", function(state)
    -- SAVE SETTINGS logic
end)

createToggle(MainContent, "PLAYER TRACKER", function(state)
    -- PLAYER TRACKER logic
end)

createToggle(MainContent, "ESP LINE", function(state)
    -- ESP LINE logic
end)

-- Settings Content
local function createSlider(parent, text, min, max, default, callback)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, 0, 0, 50)
    slider.Position = UDim2.new(0, 0, 0, 0)
    slider.BackgroundColor3 = premiumBlack
    slider.BorderSizePixel = 0
    slider.Parent = parent

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.5, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 20
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = slider

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(0.5, 0, 0.2, 0)
    sliderBar.Position = UDim2.new(0.5, 0, 0.4, 0)
    sliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = slider

    local function updateSlider(value)
        sliderBar.Size = UDim2.new(value, 0, 0.2, 0)
        callback(value)
    end

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local function onInputChanged(input)
                local newValue = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                updateSlider(newValue)
            end

            game:GetService("UserInputService").InputChanged:Connect(onInputChanged)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    game:GetService("UserInputService").InputChanged:Disconnect(onInputChanged)
                end
            end)
        end
    end)

    updateSlider(default)
end

createSlider(SettingsContent, "Transparency", 0, 1, 0.5, function(value)
    -- Transparency logic
end)

createSlider(SettingsContent, "UI Scale", 0.5, 2, 1, function(value)
    -- UI Scale logic
end)

local function createOption(parent, text, options, default, callback)
    local option = Instance.new("TextButton")
    option.Size = UDim2.new(1, 0, 0, 30)
    option.Position = UDim2.new(0, 0, 0, 0)
    option.BackgroundColor3 = premiumBlack
    option.Text = text
    option.TextColor3 = Color3.fromRGB(255, 255, 255)
    option.TextSize = 20
    option.Font = Enum.Font.SourceHansBold
    option.ZIndex = 2
    option.Parent = parent

    local dropdown = Instance.new("Frame")
    dropdown.Size = UDim2.new(1, 0, 0, 0)
    dropdown.Position = UDim2.new(0, 0, 1, 0)
    dropdown.BackgroundColor3 = premiumBlack
    dropdown.BorderSizePixel = 0
    dropdown.Parent = option

    for _, v in ipairs(options) do
        local item = Instance.new("TextButton")
        item.Size = UDim2.new(1, 0, 0, 30)
        item.Position = UDim2.new(0, 0, 0, 0)
        item.BackgroundColor3 = premiumBlack
        item.Text = v
        item.TextColor3 = Color3.fromRGB(255, 255, 255)
        item.TextSize = 20
        item.Font = Enum.Font.SourceSansBold
        item.ZIndex = 2
        item.Parent = dropdown

        item.MouseButton1Click:Connect(function()
            option.Text = v
            dropdown:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.2, true)
            callback(v)
        end)
    end

    option.MouseButton1Click:Connect(function()
        dropdown:TweenSize(UDim2.new(1, 0, 0, 30 * #options), "Out", "Quad", 0.2, true)
    end)

    callback(default)
end

createOption(SettingsContent, "Accent Color", {"Red", "Blue", "Green", "Purple"}, "Red", function(value)
    -- Accent Color logic
end)

local function createToggleOption(parent, text, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, 0, 0, 30)
    toggle.Position = UDim2.new(0, 0, 0, 0)
    toggle.BackgroundColor3 = premiumBlack
    toggle.Text = text
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 20
    toggle.Font = Enum.Font.SourceSansBold
    toggle.ZIndex = 2
    toggle.Parent = parent

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0.2, 0, 1, 0)
    circle.Position = UDim2.new(0.8, 0, 0, 0)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = toggle

    local function updateToggle(state)
        circle:TweenPosition(UDim2.new(state and 0.8 or 0, 0, 0, 0), "Out", "Quad", 0.2, true)
        circle.BackgroundColor3 = state and accentRed or Color3.fromRGB(255, 255, 255)
    end

    toggle.MouseButton1Click:Connect(function()
        updateToggle(not circle.Position.X.Scale == 0.8)
        callback(not circle.Position.X.Scale == 0.8)
    end)

    return toggle
end

createToggleOption(SettingsContent, "Glow", function(state)
    -- Glow logic
end)

createToggleOption(SettingsContent, "Shadow", function(state)
    -- Shadow logic
end)

Instance.new("TextButton", SettingsContent).Text = "Reset Position"
Instance.new("TextButton", SettingsContent).Text = "Close GUI"

-- Tab Switching
MainTab.MouseButton1Click:Connect(function()
    MainTab.BackgroundColor3 = accentRed
    MainTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsTab.BackgroundColor3 = premiumBlack
    SettingsTab.TextColor3 = Color3.fromRGB(150, 150, 150)
    MainContent.Visible = true
    SettingsContent.Visible = false
end)

SettingsTab.MouseButton1Click:Connect(function()
    SettingsTab.BackgroundColor3 = accentRed
    SettingsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTab.BackgroundColor3 = premiumBlack
    MainTab.TextColor3 = Color3.fromRGB(150, 150, 150)
    MainContent.Visible = false
    SettingsContent.Visible = true
end)

-- Initial State
MainTab:Click()

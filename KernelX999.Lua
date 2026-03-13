-- Kernel V2 GUI Script

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

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

KernelV2.Parent = player:WaitForChild("PlayerGui")

-- Styles
local premiumBlack = Color3.fromRGB(25, 25, 25)
local accentRed = Color3.fromRGB(255, 0, 0)
local darkBackground = Color3.fromRGB(15, 15, 15)
local glowColor = Color3.fromRGB(255, 0, 0)

-- Utility Functions
local function createDraggable(frame)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
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

    UIS.InputChanged:Connect(function(input)
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

-- Main Frame
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 1, 0)
MainFrame.BackgroundColor3 = premiumBlack
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = KernelV2

LogoButton.MouseButton1Click:Connect(function()
    if MainFrame.Visible then
        MainFrame:TweenPosition(UDim2.new(0.5, -300, 1, 0), "Out", "Quad", 0.5, true)
        task.wait(0.5)
        MainFrame.Visible = false
    else
        MainFrame.Visible = true
        MainFrame:TweenPosition(UDim2.new(0.5, -300, 0.5, -200), "Out", "Quad", 0.5, true)
    end
end)

-- Loading Panel
LoadingPanel.Size = UDim2.new(0, 300, 0, 150)
LoadingPanel.Position = UDim2.new(0.5, -150, 0.5, -75)
LoadingPanel.BackgroundColor3 = premiumBlack
LoadingPanel.BorderSizePixel = 0
LoadingPanel.Parent = KernelV2

LoadingText.Size = UDim2.new(1, 0, 0.5, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "KERNEL V2"
LoadingText.TextColor3 = accentRed
LoadingText.TextSize = 48
LoadingText.Font = Enum.Font.SourceSansBold
LoadingText.Parent = LoadingPanel

LoadingBar.Size = UDim2.new(0, 0, 0.1, 0)
LoadingBar.Position = UDim2.new(0, 0, 0.6, 0)
LoadingBar.BackgroundColor3 = accentRed
LoadingBar.Parent = LoadingPanel

task.spawn(function()
    for i = 0, 100 do
        LoadingBar.Size = UDim2.new(i / 100, 0, 0.1, 0)
        task.wait(0.01)
    end
    LoadingPanel.Visible = false
    MainFrame.Visible = true
    MainFrame:TweenPosition(UDim2.new(0.5, -300, 0.5, -200), "Out", "Quad", 0.5, true)
end)

-- Tabs
MainTab.Size = UDim2.new(0.5, 0, 0, 50)
MainTab.BackgroundColor3 = accentRed
MainTab.Text = "MAIN"
MainTab.TextColor3 = Color3.new(1,1,1)
MainTab.Parent = MainFrame

SettingsTab.Size = UDim2.new(0.5, 0, 0, 50)
SettingsTab.Position = UDim2.new(0.5, 0, 0, 0)
SettingsTab.BackgroundColor3 = premiumBlack
SettingsTab.Text = "SETTINGS"
SettingsTab.TextColor3 = Color3.fromRGB(150,150,150)
SettingsTab.Parent = MainFrame

-- Content
MainContent.Size = UDim2.new(1,0,1,-50)
MainContent.Position = UDim2.new(0,0,0,50)
MainContent.BackgroundColor3 = premiumBlack
MainContent.Parent = MainFrame

SettingsContent.Size = UDim2.new(1,0,1,-50)
SettingsContent.Position = UDim2.new(0,0,0,50)
SettingsContent.BackgroundColor3 = premiumBlack
SettingsContent.Visible = false
SettingsContent.Parent = MainFrame

-- Toggle Template Fix
local function createToggle(parent, text, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, 0, 0, 30)
    toggle.BackgroundColor3 = premiumBlack
    toggle.Text = text
    toggle.TextColor3 = Color3.new(1,1,1)
    toggle.Font = Enum.Font.SourceSansBold
    toggle.Parent = parent

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0.2,0,1,0)
    circle.Position = UDim2.new(0,0,0,0)
    circle.BackgroundColor3 = Color3.new(1,1,1)
    circle.Parent = toggle

    local state = false

    local function updateToggle()
        state = not state
        circle:TweenPosition(
            UDim2.new(state and 0.8 or 0,0,0,0),
            "Out","Quad",0.2,true
        )
        circle.BackgroundColor3 = state and accentRed or Color3.new(1,1,1)
        callback(state)
    end

    toggle.MouseButton1Click:Connect(updateToggle)

    return toggle
end

-- Main Content
createToggle(MainContent, "ESP BOX", function(state) end)
createToggle(MainContent, "AUTO TOOL SLOT 1", function(state) end)
createToggle(MainContent, "AUTO ACTION", function(state) end)
createToggle(MainContent, "START BOOST", function(state) end)
createToggle(MainContent, "KILL AURA", function(state) end)
createToggle(MainContent, "AUTO KILL", function(state) end)
createToggle(MainContent, "AUTO JOIN", function(state) end)
createToggle(MainContent, "SAVE SETTINGS", function(state) end)
createToggle(MainContent, "PLAYER TRACKER", function(state) end)
createToggle(MainContent, "ESP LINE", function(state) end)

-- Slider Fix
local function createSlider(parent, text, min, max, default, callback)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1,0,0,50)
    slider.BackgroundColor3 = premiumBlack
    slider.Parent = parent

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(default,0,0.2,0)
    sliderBar.Position = UDim2.new(0.5,0,0.4,0)
    sliderBar.BackgroundColor3 = Color3.new(1,1,1)
    sliderBar.Parent = slider

    callback(default)
end

createSlider(SettingsContent, "Transparency", 0, 1, 0.5, function(value) end)
createSlider(SettingsContent, "UI Scale", 0.5, 2, 1, function(value) end)

-- Tab Switching
MainTab.MouseButton1Click:Connect(function()
    MainContent.Visible = true
    SettingsContent.Visible = false
end)

SettingsTab.MouseButton1Click:Connect(function()
    MainContent.Visible = false
    SettingsContent.Visible = true
end)

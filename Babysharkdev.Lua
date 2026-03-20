
--// PhuBaby Dev GUI Script Framework
--// Author: Nguyễn Thanh Phú

--// UI Core Module
local UI = {}
UI.ScreenGui = Instance.new("ScreenGui")
UI.MainFrame = Instance.new("Frame")
UI.MainFrame.Size = UDim2.new(0, 400, 0, 500)
UI.MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
UI.MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UI.MainFrame.BorderSizePixel = 0
UI.MainFrame.Parent = UI.ScreenGui

-- Loading Module
local Loading = {}
Loading.LoadingFrame = Instance.new("Frame")
Loading.LoadingFrame.Size = UDim2.new(0, 400, 0, 100)
Loading.LoadingFrame.Position = UDim2.new(0.5, -200, 0.5, -50)
Loading.LoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Loading.LoadingFrame.BorderSizePixel = 0
Loading.LoadingFrame.Parent = UI.ScreenGui

Loading.LoadingBar = Instance.new("Frame")
Loading.LoadingBar.Size = UDim2.new(0, 0, 1, 0)
Loading.LoadingBar.Position = UDim2.new(0, 0, 0, 0)
Loading.LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Loading.LoadingBar.BorderSizePixel = 0
Loading.LoadingBar.Parent = Loading.LoadingFrame

Loading.LoadingText = Instance.new("TextLabel")
Loading.LoadingText.Size = UDim2.new(1, 0, 1, 0)
Loading.LoadingText.Position = UDim2.new(0, 0, 0, 0)
Loading.LoadingText.BackgroundTransparency = 1
Loading.LoadingText.TextColor3 = Color3.fromRGB(0, 255, 255)
Loading.LoadingText.Text = "Loading..."
Loading.LoadingText.Font = Enum.Font.SourceSans
Loading.LoadingText.TextSize = 24
Loading.LoadingText.Parent = Loading.LoadingFrame

spawn(function()
    for i = 1, 100 do
        Loading.LoadingBar.Size = UDim2.new(i / 100, 0, 1, 0)
        Loading.LoadingText.Text = "Loading... " .. i .. "%"
        wait(0.05)
    end
    Loading.LoadingFrame:TweenPosition(UDim2.new(0.5, -200, 0.5, -500), "Out", "Quad", 0.5)
    wait(0.5)
    Loading.LoadingFrame:Destroy()

    local Notification = Instance.new("TextLabel")
    Notification.Size = UDim2.new(0, 400, 0, 50)
    Notification.Position = UDim2.new(0.5, -200, 0.5, -25)
    Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Notification.BorderSizePixel = 0
    Notification.TextColor3 = Color3.fromRGB(0, 255, 255)
    Notification.Text = "PhuBaby Dev Loaded Successfully\nRun Script By Nguyễn Thanh Phú"
    Notification.Font = Enum.Font.SourceSans
    Notification.TextSize = 24
    Notification.Parent = UI.ScreenGui

    wait(2)
    Notification:Destroy()
end)

-- Toggle System Module
local Toggle = {}
Toggle.Create = function(parent, text)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
    ToggleFrame.Position = UDim2.new(0, 0, 0, 0)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(1, 0, 1, 0)
    ToggleButton.Position = UDim2.new(0, 0, 0, 0)
    ToggleButton.BackgroundTransparency = 1
    ToggleButton.Text = text
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.TextSize = 24
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Parent = ToggleFrame

    local ToggleState = false
    ToggleButton.MouseButton1Click:Connect(function()
        ToggleState = not ToggleState
        if ToggleState then
            ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
        else
            ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        local Notification = Instance.new("TextLabel")
        Notification.Size = UDim2.new(0, 200, 0, 50)
        Notification.Position = UDim2.new(0.5, -100, 0.5, -25)
        Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Notification.BorderSizePixel = 0
        Notification.TextColor3 = Color3.fromRGB(255, 255, 255)
        Notification.Text = ToggleState and "[ ON ] Function Enabled" or "[ OFF ] Function Disabled"
        Notification.Font = Enum.Font.SourceSans
        Notification.TextSize = 24
        Notification.Parent = UI.ScreenGui

        wait(2)
        Notification:Destroy()
    end)

    return ToggleFrame
end

-- Slider System Module
local Slider = {}
Slider.Create = function(parent, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    SliderFrame.Position = UDim2.new(0, 0, 0, 0)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, 0, 0.2, 0)
    SliderBar.Position = UDim2.new(0, 0, 0.8, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = SliderFrame

    local SliderThumb = Instance.new("Frame")
    SliderThumb.Size = UDim2.new(0, 20, 1, 0)
    SliderThumb.Position = UDim2.new((default - min) / (max - min), 0, 0, 0)
    SliderThumb.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    SliderThumb.BorderSizePixel = 0
    SliderThumb.Parent = SliderBar

    local SliderText = Instance.new("TextLabel")
    SliderText.Size = UDim2.new(1, 0, 0.8, 0)
    SliderText.Position = UDim2.new(0, 0, 0, 0)
    SliderText.BackgroundTransparency = 1
    SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderText.Text = tostring(default)
    SliderText.Font = Enum.Font.SourceSans
    SliderText.TextSize = 24
    SliderText.Parent = SliderFrame

    local dragging = false
    local startPos
    local startSize

    SliderThumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            startSize = SliderThumb.Size
        end
    end)

    SliderThumb.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startPos
            local newSize = startSize.X + delta.X
            newSize = math.clamp(newSize, 0, SliderBar.Size.X.UScale * SliderBar.Size.X.Offset)
            SliderThumb.Size = UDim2.new(0, newSize, 1, 0)
            local value = min + (max - min) * (newSize / SliderBar.Size.X.UScale / SliderBar.Size.X.Offset)
            SliderText.Text = tostring(math.round(value))
            if callback then
                callback(value)
            end
        end
    end)

    SliderThumb.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    return SliderFrame
end

-- Dropdown Module
local Dropdown = {}
Dropdown.Create = function(parent, options, callback)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(1, 0, 0, 50)
    DropdownFrame.Position = UDim2.new(0, 0, 0, 0)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Parent = parent

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.Position = UDim2.new(0, 0, 0, 0)
    DropdownButton.BackgroundTransparency = 1
    DropdownButton.Text = options[1]
    DropdownButton.Font = Enum.Font.SourceSans
    DropdownButton.TextSize = 24
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.Parent = DropdownFrame

    local DropdownList = Instance.new("Frame")
    DropdownList.Size = UDim2.new(1, 0, 0, 0)
    DropdownList.Position = UDim2.new(0, 0, 1, 0)
    DropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DropdownList.BorderSizePixel = 0
    DropdownList.Visible = false
    DropdownList.Parent = DropdownFrame

    for _, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Size = UDim2.new(1, 0, 0, 30)
        OptionButton.Position = UDim2.new(0, 0, _, 0)
        OptionButton.BackgroundTransparency = 1
        OptionButton.Text = option
        OptionButton.Font = Enum.Font.SourceSans
        OptionButton.TextSize = 24
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.Parent = DropdownList

        OptionButton.MouseButton1Click:Connect(function()
            DropdownButton.Text = option
            DropdownList.Visible = false
            if callback then
                callback(option)
            end
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        DropdownList.Visible = not DropdownList.Visible
    end)

    return DropdownFrame
end

-- Drag Mobile Module
local Drag = {}
Drag.Init = function(frame)
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

-- Notification Module
local Notification = {}
Notification.Create = function(text)
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Size = UDim2.new(0, 200, 0, 50)
    NotificationFrame.Position = UDim2.new(0.5, -100, 0.5, -25)
    NotificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.Parent = UI.ScreenGui

    local NotificationText = Instance.new("TextLabel")
    NotificationText.Size = UDim2.new(1, 0, 1, 0)
    NotificationText.Position = UDim2.new(0, 0, 0, 0)
    NotificationText.BackgroundTransparency = 1
    NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotificationText.Text = text
    NotificationText.Font = Enum.Font.SourceSans
    NotificationText.TextSize = 24
    NotificationText.Parent = NotificationFrame

    wait(2)
    NotificationFrame:Destroy()
end

-- Theme Neon Module
local Theme = {}
Theme.Apply = function()
    local function updateTheme()
        local hue = tick() % 6.28
        local color = Color3.fromHSV(hue / 6.28, 1, 1)
        UI.MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        UI.MainFrame.BorderColor3 = color
        UI.MainFrame.BorderSizePixel = 2
    end

    spawn(function()
        while true do
            updateTheme()
            wait(0.01)
        end
    end)
end

-- Server Info Module
local ServerInfo = {}
ServerInfo.Update = function()
    local ServerInfoFrame = Instance.new("Frame")
    ServerInfoFrame.Size = UDim2.new(1, 0, 0, 50)
    ServerInfoFrame.Position = UDim2.new(0, 0, 0, 0)
    ServerInfoFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ServerInfoFrame.BorderSizePixel = 0
    ServerInfoFrame.Parent = UI.MainFrame

    local PingText = Instance.new("TextLabel")
    PingText.Size = UDim2.new(0.25, 0, 1, 0)
    PingText.Position = UDim2.new(0, 0, 0, 0)
    PingText.BackgroundTransparency = 1
    PingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    PingText.Text = "Ping: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"].Value ..
        " ms"
    PingText.Font = Enum.Font.SourceSans
    PingText.TextSize = 24
    PingText.Parent = ServerInfoFrame

    local FPSText = Instance.new("TextLabel")
    FPSText.Size = UDim2.new(0.25, 0, 1, 0)
    FPSText.Position = UDim2.new(0.25, 0, 0, 0)
    FPSText.BackgroundTransparency = 1
    FPSText.TextColor3 = Color3.fromRGB(255, 255, 255)
    FPSText.Text = "FPS: " .. workspace:GetPropertyChangedSignal("SimulationRadius"):Wait()
        .. " FPS"
    FPSText.Font = Enum.Font.SourceSans
    FPSText.TextSize = 24
    FPSText.Parent = ServerInfoFrame

    local ServerIDText = Instance.new("TextLabel")
    ServerIDText.Size = UDim2.new(0.25, 0, 1, 0)
    ServerIDText.Position = UDim2.new(0.5, 0, 0, 0)
    ServerIDText.BackgroundTransparency = 1
    ServerIDText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ServerIDText.Text = "Server ID: " .. game.JobId
    ServerIDText.Font = Enum.Font.SourceSans
    ServerIDText.TextSize = 24
    ServerIDText.Parent = ServerInfoFrame

    local PlayerCountText = Instance.new("TextLabel")
    PlayerCountText.Size = UDim2.new(0.25, 0, 1, 0)
    PlayerCountText.Position = UDim2.new(0.75, 0, 0, 0)
    PlayerCountText.BackgroundTransparency = 1
    PlayerCountText.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerCountText.Text = "Players: " .. #game.Players:GetPlayers()
    PlayerCountText.Font = Enum.Font.SourceSans
    PlayerCountText.TextSize = 24
    PlayerCountText.Parent = ServerInfoFrame

    spawn(function()
        while true do
            PingText.Text = "Ping: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"].Value ..
                " ms"
            FPSText.Text = "FPS: " .. workspace:GetPropertyChangedSignal("SimulationRadius"):Wait()
                .. " FPS"
            PlayerCountText.Text = "Players: " .. #game.Players:GetPlayers()
            wait(1)
        end
    end)
end

-- Gameplay Placeholder Module
local Gameplay = {}
Gameplay.Hitbox = function(sizeLoading.BackgroundColor3 = Color3.fromRGB(10,10,10)
Loading.Parent = ScreenGui
Instance.new("UICorner",Loading).CornerRadius = UDim.new(0,14)

local BarBG = Instance.new("Frame")
BarBG.Size = UDim2.new(0,240,0,14)
BarBG.Position = UDim2.new(0.5,-120,0.65,0)
BarBG.BackgroundColor3 = Color3.fromRGB(25,25,25)
BarBG.Parent = Loading
Instance.new("UICorner",BarBG)

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Color3.fromRGB(0,255,255)
Bar.Parent = BarBG
Instance.new("UICorner",Bar)

local Percent = Instance.new("TextLabel")
Percent.Size = UDim2.new(1,0,0,40)
Percent.Position = UDim2.new(0,0,0.2,0)
Percent.BackgroundTransparency = 1
Percent.TextColor3 = Color3.new(1,1,1)
Percent.Font = Enum.Font.GothamBold
Percent.TextSize = 24
Percent.Parent = Loading

for i=1,100 do
	Percent.Text = i.."%"
	Bar.Size = UDim2.new(i/100,0,1,0)
	task.wait(0.008)
end

task.wait(0.2)
Loading:Destroy()

--====================================================
-- MAIN WINDOW
--====================================================

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,360,0,430)
Main.Position = UDim2.new(0.5,-180,0.5,-215)
Main.BackgroundColor3 = Color3.fromRGB(12,12,12)
Main.Parent = ScreenGui
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,16)

local Stroke = Instance.new("UIStroke",Main)
Stroke.Thickness = 2

RunService.RenderStepped:Connect(function()
	Stroke.Color = NeonColor()
end)

--====================================================
-- TITLE
--====================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = Main

--====================================================
-- MINIMIZE BUTTON
--====================================================

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0,40,0,40)
MinBtn.Position = UDim2.new(1,-45,0,5)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.Parent = Main
Instance.new("UICorner",MinBtn)

local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0,50,0,50)
OpenBtn.Position = UDim2.new(0,20,0.5,-25)
OpenBtn.Text = "+"
OpenBtn.Visible = false
OpenBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Parent = ScreenGui
Instance.new("UICorner",OpenBtn)

MinBtn.MouseButton1Click:Connect(function()
	Main.Visible = false
	OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
	Main.Visible = true
	OpenBtn.Visible = false
end)

--====================================================
-- NOTIFY MODULE
--====================================================

local function Notify(txt)
	local N = Instance.new("TextLabel")
	N.Size = UDim2.new(0,260,0,40)
	N.Position = UDim2.new(0.5,-130,0,20)
	N.BackgroundColor3 = Color3.fromRGB(15,15,15)
	N.Text = txt
	N.TextColor3 = Color3.new(1,1,1)
	N.Font = Enum.Font.GothamBold
	N.TextSize = 15
	N.Parent = ScreenGui
	Instance.new("UICorner",N)

	task.delay(2,function()
		N:Destroy()
	end)
end

Notify("Run Script By Nguyễn Thanh Phú")

--====================================================
-- TAB SYSTEM
--====================================================

local Tabs = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}
local TabHolder = Instance.new("Frame")
TabHolder.Size = UDim2.new(0,100,1,-60)
TabHolder.Position = UDim2.new(0,0,0,55)
TabHolder.BackgroundTransparency = 1
TabHolder.Parent = Main

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-110,1,-65)
Content.Position = UDim2.new(0,105,0,55)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Pages = {}

for i,v in ipairs(Tabs) do
	local Btn = Instance.new("TextButton")
	Btn.Size = UDim2.new(1,-10,0,45)
	Btn.Position = UDim2.new(0,5,0,(i-1)*50)
	Btn.Text = v
	Btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Btn.TextColor3 = Color3.new(1,1,1)
	Btn.Parent = TabHolder
	Instance.new("UICorner",Btn)

	local Page = Instance.new("ScrollingFrame")
	Page.Size = UDim2.new(1,0,1,0)
	Page.CanvasSize = UDim2.new(0,0,0,900)
	Page.ScrollBarThickness = 4
	Page.Visible = false
	Page.BackgroundTransparency = 1
	Page.Parent = Content
	Pages[v] = Page

	Btn.MouseButton1Click:Connect(function()
		for _,p in pairs(Pages) do
			p.Visible = false
		end
		Page.Visible = true
	end)
end

Pages["MAIN"].Visible = true

--====================================================
-- TOGGLE MODULE
--====================================================

local function CreateToggle(parent,text,y)
	local T = Instance.new("TextButton")
	T.Size = UDim2.new(0,220,0,45)
	T.Position = UDim2.new(0,10,0,y)
	T.BackgroundColor3 = Color3.fromRGB(120,0,0)
	T.Text = text.." [OFF]"
	T.TextColor3 = Color3.new(1,1,1)
	T.Parent = parent
	Instance.new("UICorner",T)

	local state=false

	T.MouseButton1Click:Connect(function()
		state = not state
		T.BackgroundColor3 = state and Color3.fromRGB(0,120,0) or Color3.fromRGB(120,0,0)
		T.Text = text..(state and " [ON]" or " [OFF]")
		Notify(state and "[ ON ] Function Enabled" or "[ OFF ] Function Disabled")
	end)
end

--====================================================
-- SLIDER MODULE
--====================================================

local function CreateSlider(parent,y)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(0,220,0,60)
	Frame.Position = UDim2.new(0,10,0,y)
	Frame.BackgroundTransparency = 1
	Frame.Parent = parent

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1,0,0,20)
	Label.BackgroundTransparency = 1
	Label.Text = "FOV: 50"
	Label.TextColor3 = Color3.new(1,1,1)
	Label.Parent = Frame

	local Bar = Instance.new("Frame")
	Bar.Size = UDim2.new(1,0,0,10)
	Bar.Position = UDim2.new(0,0,0,35)
	Bar.BackgroundColor3 = Color3.fromRGB(30,30,30)
	Bar.Parent = Frame
	Instance.new("UICorner",Bar)

	local Fill = Instance.new("Frame")
	Fill.Size = UDim2.new(0,0,1,0)
	Fill.BackgroundColor3 = Color3.fromRGB(0,255,255)
	Fill.Parent = Bar
	Instance.new("UICorner",Fill)

	local dragging=false

	Bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			dragging=true
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			dragging=false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging then
			local x = math.clamp((input.Position.X-Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X,0,1)
			Fill.Size = UDim2.new(x,0,1,0)
			Label.Text = "FOV: "..math.floor(50 + (450*x))
		end
	end)
end

--====================================================
-- MAIN CONTENT
--====================================================

CreateToggle(Pages["MAIN"],"Hitbox",20)
CreateToggle(Pages["MAIN"],"MultiJump",80)
CreateToggle(Pages["MAIN"],"Aura",140)
CreateToggle(Pages["MAIN"],"ShiftLock",200)
CreateSlider(Pages["MAIN"],270)

--====================================================
-- SERVER INFO
--====================================================

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(0,220,0,120)
Info.Position = UDim2.new(0,10,0,20)
Info.BackgroundColor3 = Color3.fromRGB(20,20,20)
Info.TextColor3 = Color3.new(1,1,1)
Info.Parent = Pages["SERVER"]
Instance.new("UICorner",Info)

task.spawn(function()
	while task.wait(1) do
		Info.Text =
			"Ping: "..math.random(20,80)..
			"\nFPS: "..math.random(58,60)..
			"\nPlayers: "..#Players:GetPlayers()
	end
end)

--====================================================
-- MOBILE DRAG
--====================================================

local dragging=false
local dragStart
local startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging=true
		dragStart=input.Position
		startPos=Main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging=false
	end
end)

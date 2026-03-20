--// PHUBABY DEV PREMIUM MOBILE 2026
--// Optimized for Delta iOS / Android

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

pcall(function()
	local old = PG:FindFirstChild("PhuBabyDev")
	if old then old:Destroy() end
end)

-- GUI ROOT
local Gui = Instance.new("ScreenGui")
Gui.Name = "PhuBabyDev"
Gui.ResetOnSpawn = false
Gui.Parent = PG

-- THEME
local ThemeHue = 0
local function Neon()
	return Color3.fromHSV(ThemeHue,1,1)
end

task.spawn(function()
	while task.wait(0.05) do
		ThemeHue = (ThemeHue + 0.003) % 1
	end
end)

-- LOADING SCREEN
local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0,300,0,120)
LoadFrame.Position = UDim2.new(0.5,-150,0.5,-60)
LoadFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
LoadFrame.Parent = Gui
Instance.new("UICorner",LoadFrame)

local LoadBarBG = Instance.new("Frame")
LoadBarBG.Size = UDim2.new(0,260,0,14)
LoadBarBG.Position = UDim2.new(0,20,0,70)
LoadBarBG.BackgroundColor3 = Color3.fromRGB(25,25,25)
LoadBarBG.Parent = LoadFrame
Instance.new("UICorner",LoadBarBG)

local LoadBar = Instance.new("Frame")
LoadBar.Size = UDim2.new(0,0,1,0)
LoadBar.BackgroundColor3 = Color3.fromRGB(0,255,255)
LoadBar.Parent = LoadBarBG
Instance.new("UICorner",LoadBar)

local LoadText = Instance.new("TextLabel")
LoadText.Size = UDim2.new(1,0,0,40)
LoadText.Position = UDim2.new(0,0,0,15)
LoadText.BackgroundTransparency = 1
LoadText.Text = "Loading 0%"
LoadText.TextColor3 = Color3.new(1,1,1)
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 20
LoadText.Parent = LoadFrame

for i=1,100 do
	LoadBar.Size = UDim2.new(i/100,0,1,0)
	LoadText.Text = "Loading "..i.."%"
	task.wait(0.01)
end

LoadFrame:Destroy()

-- MAIN UI
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,370,0,470)
Main.Position = UDim2.new(0.5,-185,0.5,-235)
Main.BackgroundColor3 = Color3.fromRGB(12,12,12)
Main.Parent = Gui
Instance.new("UICorner",Main)

local Stroke = Instance.new("UIStroke",Main)
Stroke.Thickness = 2

RunService.RenderStepped:Connect(function()
	Stroke.Color = Neon()
end)

-- TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = Main

-- NOTIFY
local function Notify(txt)
	local N = Instance.new("TextLabel")
	N.Size = UDim2.new(0,240,0,40)
	N.Position = UDim2.new(0.5,-120,0,20)
	N.BackgroundColor3 = Color3.fromRGB(20,20,20)
	N.Text = txt
	N.TextColor3 = Color3.new(1,1,1)
	N.Parent = Gui
	Instance.new("UICorner",N)

	task.delay(2,function()
		N:Destroy()
	end)
end

Notify("Run Script By Nguyễn Thanh Phú")

-- TABS
local Tabs = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}
local Pages = {}

for i,v in ipairs(Tabs) do
	local B = Instance.new("TextButton")
	B.Size = UDim2.new(0,68,0,35)
	B.Position = UDim2.new(0,(i-1)*72+5,0,50)
	B.Text = v
	B.TextColor3 = Color3.new(1,1,1)
	B.BackgroundColor3 = Color3.fromRGB(20,20,20)
	B.Parent = Main
	Instance.new("UICorner",B)

	local Page = Instance.new("Frame")
	Page.Size = UDim2.new(1,-20,1,-100)
	Page.Position = UDim2.new(0,10,0,95)
	Page.BackgroundTransparency = 1
	Page.Visible = (i==1)
	Page.Parent = Main
	Pages[v] = Page

	B.MouseButton1Click:Connect(function()
		for _,p in pairs(Pages) do p.Visible=false end
		Page.Visible=true
	end)
end

-- TOGGLE FUNCTION
local function Toggle(parent,text,y)
	local T = Instance.new("TextButton")
	T.Size = UDim2.new(0,220,0,42)
	T.Position = UDim2.new(0,10,0,y)
	T.BackgroundColor3 = Color3.fromRGB(120,0,0)
	T.Text = text.." [OFF]"
	T.TextColor3 = Color3.new(1,1,1)
	T.Parent = parent
	Instance.new("UICorner",T)

	local on=false

	T.MouseButton1Click:Connect(function()
		on=not on
		T.BackgroundColor3 = on and Color3.fromRGB(0,120,0) or Color3.fromRGB(120,0,0)
		T.Text = text..(on and " [ON]" or " [OFF]")
		Notify(on and "[ ON ] Function Enabled" or "[ OFF ] Function Disabled")
	end)
end

-- MAIN TAB
Toggle(Pages.MAIN,"Hitbox",10)
Toggle(Pages.MAIN,"MultiJump",60)
Toggle(Pages.MAIN,"Aura",110)
Toggle(Pages.MAIN,"ShiftLock",160)

-- FOV SLIDER
local SliderBG = Instance.new("Frame")
SliderBG.Size = UDim2.new(0,220,0,10)
SliderBG.Position = UDim2.new(0,10,0,230)
SliderBG.BackgroundColor3 = Color3.fromRGB(40,40,40)
SliderBG.Parent = Pages.MAIN
Instance.new("UICorner",SliderBG)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0,0,1,0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0,255,255)
SliderFill.Parent = SliderBG
Instance.new("UICorner",SliderFill)

local SliderText = Instance.new("TextLabel")
SliderText.Size = UDim2.new(0,220,0,30)
SliderText.Position = UDim2.new(0,10,0,195)
SliderText.BackgroundTransparency = 1
SliderText.Text = "FOV: 50"
SliderText.TextColor3 = Color3.new(1,1,1)
SliderText.Parent = Pages.MAIN

local dragging=false

SliderBG.InputBegan:Connect(function(input)
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
		local x = math.clamp((input.Position.X-SliderBG.AbsolutePosition.X)/SliderBG.AbsoluteSize.X,0,1)
		SliderFill.Size = UDim2.new(x,0,1,0)
		local val = math.floor(50 + x*450)
		SliderText.Text = "FOV: "..val
	end
end)

-- ESP TAB
Toggle(Pages.ESP,"Rainbow Outline",10)
Toggle(Pages.ESP,"Red Box",60)
Toggle(Pages.ESP,"Name Display",110)

-- PLAYER TAB DROPDOWN
local Drop = Instance.new("TextButton")
Drop.Size = UDim2.new(0,220,0,42)
Drop.Position = UDim2.new(0,10,0,10)
Drop.Text = "Select Player"
Drop.Parent = Pages.PLAYER
Instance.new("UICorner",Drop)

Drop.MouseButton1Click:Connect(function()
	local names={}
	for _,p in pairs(Players:GetPlayers()) do
		table.insert(names,p.Name)
	end
	if #names>0 then
		Drop.Text = names[1]
	end
end)

-- SERVER TAB
local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(0,300,0,120)
Info.Position = UDim2.new(0,10,0,10)
Info.BackgroundColor3 = Color3.fromRGB(20,20,20)
Info.TextColor3 = Color3.new(1,1,1)
Info.Parent = Pages.SERVER
Instance.new("UICorner",Info)

task.spawn(function()
	while task.wait(1) do
		local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
		Info.Text =
			"Ping: "..ping..
			"\nPlayers: "..#Players:GetPlayers()..
			"\nServer ID: "..game.JobId
	end
end)

-- SETTINGS TAB
Toggle(Pages.SETTINGS,"Notification",10)
Toggle(Pages.SETTINGS,"Theme Neon",60)

-- DRAG MOBILE
local drag=false
local dragStart,startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		drag=true
		dragStart=input.Position
		startPos=Main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if drag then
		local delta=input.Position-dragStart
		Main.Position=UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset+delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset+delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		drag=false
	end
end)- Notification Module
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

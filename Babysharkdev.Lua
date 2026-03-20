--// PHUBABY DEV MOBILE PREMIUM
--// Run Script By Nguyễn Thanh Phú

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

pcall(function()
	local old = PlayerGui:FindFirstChild("PhuBabyDev")
	if old then old:Destroy() end
end)

--====================================================
-- UI MODULE
--====================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDev"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local function NeonColor()
	return Color3.fromHSV((tick()*0.15)%1,1,1)
end

--====================================================
-- LOADING
--====================================================

local Loading = Instance.new("Frame")
Loading.Size = UDim2.new(0,300,0,140)
Loading.Position = UDim2.new(0.5,-150,0.5,-70)
Loading.BackgroundColor3 = Color3.fromRGB(10,10,10)
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

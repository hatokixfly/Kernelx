--// KERNEL X UI
--// Script By: KernelX

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local SavedPosition = nil

pcall(function()
    StarterGui:SetCore("SendNotification",{
        Title = "KernelX",
        Text = "Script By: KernelX",
        Duration = 4
    })
end)

-- GUI ROOT
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

------------------------------------------------
-- LOGO BUTTON
------------------------------------------------
local Logo = Instance.new("TextButton")
Logo.Parent = ScreenGui
Logo.Size = UDim2.new(0,50,0,50)
Logo.Position = UDim2.new(0,20,0.5,-25)
Logo.BackgroundColor3 = Color3.fromRGB(10,10,10)
Logo.Text = "K"
Logo.TextColor3 = Color3.fromRGB(255,0,0)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 28

local LogoCorner = Instance.new("UICorner",Logo)
LogoCorner.CornerRadius = UDim.new(1,0)

------------------------------------------------
-- MAIN FRAME
------------------------------------------------
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,600,0,400)
Main.Position = UDim2.new(0.5,-300,0.5,-200)
Main.BackgroundColor3 = Color3.fromRGB(8,8,8)
Main.Visible = false

local MainCorner = Instance.new("UICorner",Main)
MainCorner.CornerRadius = UDim.new(0,12)

------------------------------------------------
-- DRAGGABLE
------------------------------------------------
local dragging = false
local dragInput, dragStart, startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
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
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

------------------------------------------------
-- TITLE
------------------------------------------------
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "Nguyen Thanh Phu"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24

spawn(function()
	while true do
		for i = 0,1,0.01 do
			Title.TextColor3 = Color3.fromHSV(i,1,1)
			wait(0.03)
		end
	end
end)

------------------------------------------------
-- LEFT TAB
------------------------------------------------
local TabFrame = Instance.new("Frame")
TabFrame.Parent = Main
TabFrame.Size = UDim2.new(0,140,1,-50)
TabFrame.Position = UDim2.new(0,0,0,50)
TabFrame.BackgroundColor3 = Color3.fromRGB(12,12,12)

local MainTab = Instance.new("TextButton")
MainTab.Parent = TabFrame
MainTab.Size = UDim2.new(1,0,0,45)
MainTab.Text = "MAIN"
MainTab.BackgroundColor3 = Color3.fromRGB(255,0,0)
MainTab.TextColor3 = Color3.new(1,1,1)
MainTab.Font = Enum.Font.GothamBold

local SettingsTab = Instance.new("TextButton")
SettingsTab.Parent = TabFrame
SettingsTab.Size = UDim2.new(1,0,0,45)
SettingsTab.Position = UDim2.new(0,0,0,50)
SettingsTab.Text = "SETTINGS"
SettingsTab.BackgroundColor3 = Color3.fromRGB(20,20,20)
SettingsTab.TextColor3 = Color3.new(1,1,1)
SettingsTab.Font = Enum.Font.GothamBold

------------------------------------------------
-- CONTENT
------------------------------------------------
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Size = UDim2.new(1,-150,1,-60)
Content.Position = UDim2.new(0,145,0,55)
Content.BackgroundTransparency = 1

------------------------------------------------
-- TOGGLE CREATOR
------------------------------------------------
local y = 0

function CreateToggle(name, callback)
	local Holder = Instance.new("TextButton")
	Holder.Parent = Content
	Holder.Size = UDim2.new(1,0,0,40)
	Holder.Position = UDim2.new(0,0,0,y)
	Holder.BackgroundColor3 = Color3.fromRGB(15,15,15)
	Holder.Text = name
	Holder.TextColor3 = Color3.new(1,1,1)
	Holder.Font = Enum.Font.GothamBold
	
	local Toggle = Instance.new("Frame")
	Toggle.Parent = Holder
	Toggle.Size = UDim2.new(0,50,0,24)
	Toggle.Position = UDim2.new(1,-60,0.5,-12)
	Toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)

	local Ball = Instance.new("Frame")
	Ball.Parent = Toggle
	Ball.Size = UDim2.new(0,20,0,20)
	Ball.Position = UDim2.new(0,2,0,2)
	Ball.BackgroundColor3 = Color3.new(1,1,1)

	local on = false

	Holder.MouseButton1Click:Connect(function()
		on = not on
		
		if on then
			TweenService:Create(Ball,TweenInfo.new(0.2),{
				Position = UDim2.new(0,28,0,2)
			}):Play()
			
			pcall(function()
				StarterGui:SetCore("SendNotification",{
					Title=name,
					Text="ON",
					Duration=2
				})
			end)
		else
			TweenService:Create(Ball,TweenInfo.new(0.2),{
				Position = UDim2.new(0,2,0,2)
			}):Play()
			
			pcall(function()
				StarterGui:SetCore("SendNotification",{
					Title=name,
					Text="OFF",
					Duration=2
				})
			end)
		end
		
		callback(on)
	end)

	y = y + 45
end

------------------------------------------------
-- MAIN TOGGLES
------------------------------------------------
CreateToggle("ESP BOX", function(v)
	-- framework only
end)

CreateToggle("SAVE POSITION", function(v)
	if v then
		SavedPosition = LocalPlayer.Character.HumanoidRootPart.Position
	end
end)

CreateToggle("TELE POSITION", function(v)
	if v and SavedPosition then
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(SavedPosition)
	end
end)

CreateToggle("ANTI AFK", function(v)
	if v then
		LocalPlayer.Idled:Connect(function()
			game:GetService("VirtualUser"):CaptureController()
			game:GetService("VirtualUser"):ClickButton2(Vector2.new())
		end)
	end
end)

CreateToggle("AUTO SPACE", function(v)
	if v then
		spawn(function()
			while v do
				LocalPlayer.Character.Humanoid.Jump = true
				wait(1)
			end
		end)
	end
end)

------------------------------------------------
-- LOADING SCREEN
------------------------------------------------
local LoadFrame = Instance.new("Frame")
LoadFrame.Parent = ScreenGui
LoadFrame.Size = UDim2.new(0,300,0,120)
LoadFrame.Position = UDim2.new(0.5,-150,0.5,-60)
LoadFrame.BackgroundColor3 = Color3.fromRGB(5,5,5)

local LoadText = Instance.new("TextLabel")
LoadText.Parent = LoadFrame
LoadText.Size = UDim2.new(1,0,0,50)
LoadText.Text = "KERNELX"
LoadText.TextColor3 = Color3.fromRGB(255,0,0)
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 28
LoadText.BackgroundTransparency = 1

local Bar = Instance.new("Frame")
Bar.Parent = LoadFrame
Bar.Size = UDim2.new(0,0,0,6)
Bar.Position = UDim2.new(0,20,1,-20)
Bar.BackgroundColor3 = Color3.fromRGB(255,0,0)

for i = 1,100 do
	Bar.Size = UDim2.new(i/100, -40,0,6)
	wait(0.02)
end

LoadFrame:Destroy()
Main.Visible = true

------------------------------------------------
-- OPEN / CLOSE MENU
------------------------------------------------
Logo.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

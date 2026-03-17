local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

--------------------------------------------------
-- REMOTE EVENT
--------------------------------------------------
local remote = ReplicatedStorage:FindFirstChild("TradeControl")
if not remote then
	remote = Instance.new("RemoteEvent")
	remote.Name = "TradeControl"
	remote.Parent = ReplicatedStorage
end

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

--------------------------------------------------
-- LOGO
--------------------------------------------------
local logo = Instance.new("ImageButton", gui)
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,50,0.4,0)
logo.BackgroundColor3 = Color3.fromRGB(10,10,10)
logo.Image = "rbxassetid://7733960981"

Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local ls = Instance.new("UIStroke",logo)
ls.Color = Color3.fromRGB(255,0,0)

--------------------------------------------------
-- MENU
--------------------------------------------------
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,290,0,170)
frame.Position = UDim2.new(0.38,0,0.35,0)
frame.BackgroundColor3 = Color3.fromRGB(8,8,8)
frame.Visible = false

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(255,0,0)

--------------------------------------------------
-- TITLE 7 COLOR
--------------------------------------------------
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "PhuBaby"
title.Font = Enum.Font.GothamBold
title.TextSize = 22

task.spawn(function()
	local colors = {
		Color3.fromRGB(255,0,0),
		Color3.fromRGB(255,120,0),
		Color3.fromRGB(255,255,0),
		Color3.fromRGB(0,255,0),
		Color3.fromRGB(0,255,255),
		Color3.fromRGB(0,0,255),
		Color3.fromRGB(255,0,255)
	}
	local i = 1
	while true do
		title.TextColor3 = colors[i]
		i = i % #colors + 1
		task.wait(0.2)
	end
end)

--------------------------------------------------
-- CLOSE
--------------------------------------------------
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,26,0,26)
close.Position = UDim2.new(1,-32,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(120,0,0)
close.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",close).CornerRadius = UDim.new(1,0)

--------------------------------------------------
-- TOGGLE FUNCTION
--------------------------------------------------
function createToggle(name,yPos,signalName)
	local holder = Instance.new("Frame", frame)
	holder.Size = UDim2.new(0.9,0,0,42)
	holder.Position = UDim2.new(0.05,0,0,yPos)
	holder.BackgroundColor3 = Color3.fromRGB(18,18,18)

	Instance.new("UICorner",holder).CornerRadius = UDim.new(0,12)

	local txt = Instance.new("TextLabel", holder)
	txt.Size = UDim2.new(0.6,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = name
	txt.TextColor3 = Color3.new(1,1,1)
	txt.Font = Enum.Font.Gotham
	txt.TextSize = 17

	local toggle = Instance.new("TextButton", holder)
	toggle.Size = UDim2.new(0,50,0,24)
	toggle.Position = UDim2.new(1,-60,0.5,-12)
	toggle.Text = ""
	toggle.BackgroundColor3 = Color3.fromRGB(90,90,90)

	Instance.new("UICorner",toggle).CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame", toggle)
	knob.Size = UDim2.new(0,20,0,20)
	knob.Position = UDim2.new(0,2,0,2)
	knob.BackgroundColor3 = Color3.new(1,1,1)

	Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

	local enabled = false

	toggle.MouseButton1Click:Connect(function()
		enabled = not enabled

		if enabled then
			toggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
			knob.Position = UDim2.new(1,-22,0,2)
		else
			toggle.BackgroundColor3 = Color3.fromRGB(90,90,90)
			knob.Position = UDim2.new(0,2,0,2)
		end

		remote:FireServer(signalName, enabled)

		StarterGui:SetCore("SendNotification", {
			Title = name,
			Text = enabled and "Đã bật" or "Đã tắt",
			Duration = 2
		})
	end)
end

createToggle("Freeze Trade",45,"FreezeTrade")
createToggle("Auto Accept",95,"AutoAccept")

--------------------------------------------------
-- OPEN/CLOSE
--------------------------------------------------
logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

close.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

--------------------------------------------------
-- DRAG
--------------------------------------------------
function dragify(obj)
	local dragToggle, dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		obj.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end

	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragToggle = true
			dragStart = input.Position
			startPos = obj.Position
		end
	end)

	obj.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			update(input)
		end
	end)
end

dragify(frame)
dragify(logo)

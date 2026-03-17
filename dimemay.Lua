local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local espEnabled = false
local autoJump = false
local antiAfk = false

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

--------------------------------------------------
-- LOGO
--------------------------------------------------
local logo = Instance.new("ImageButton")
logo.Parent = gui
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,50,0.4,0)
logo.BackgroundColor3 = Color3.fromRGB(10,10,10)
logo.Image = "rbxassetid://7733960981"

Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local logoStroke = Instance.new("UIStroke",logo)
logoStroke.Color = Color3.fromRGB(255,0,0)

--------------------------------------------------
-- MENU
--------------------------------------------------
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,310,0,270)
frame.Position = UDim2.new(0.38,0,0.35,0)
frame.BackgroundColor3 = Color3.fromRGB(8,8,8)
frame.Visible = false

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(255,0,0)

--------------------------------------------------
-- TITLE
--------------------------------------------------
local title = Instance.new("TextLabel")
title.Parent = frame
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
-- BUTTON MAKER
--------------------------------------------------
function makeButton(text,y,callback)
	local btn = Instance.new("TextButton")
	btn.Parent = frame
	btn.Size = UDim2.new(0.9,0,0,38)
	btn.Position = UDim2.new(0.05,0,0,y)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,12)

	btn.MouseButton1Click:Connect(callback)

	return btn
end

--------------------------------------------------
-- FIND BRAINROT VALUE
--------------------------------------------------
function getValue(model)
	for _,v in pairs(model:GetDescendants()) do
		if v:IsA("NumberValue") or v:IsA("IntValue") then
			return v.Value
		end
	end
	return nil
end

--------------------------------------------------
-- ESP
--------------------------------------------------
makeButton("ESP BRAINROT",40,function()
	espEnabled = not espEnabled

	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") and string.find(v.Name:lower(),"brainrot") then

			local old = v:FindFirstChild("PhuESP")
			if old then old:Destroy() end

			local oldBill = v:FindFirstChild("PhuBill")
			if oldBill then oldBill:Destroy() end

			if espEnabled then
				local hl = Instance.new("Highlight")
				hl.Name = "PhuESP"
				hl.FillTransparency = 1
				hl.OutlineColor = Color3.fromRGB(255,0,0)
				hl.Parent = v

				if v.PrimaryPart then
					local bill = Instance.new("BillboardGui")
					bill.Name = "PhuBill"
					bill.Size = UDim2.new(0,200,0,50)
					bill.AlwaysOnTop = true
					bill.Adornee = v.PrimaryPart
					bill.Parent = v

					local txt = Instance.new("TextLabel")
					txt.Parent = bill
					txt.Size = UDim2.new(1,0,1,0)
					txt.BackgroundTransparency = 1

					local val = getValue(v)
					if val then
						txt.Text = v.Name.." | "..val.."/s"
					else
						txt.Text = v.Name
					end

					txt.TextColor3 = Color3.new(1,1,1)
					txt.Font = Enum.Font.GothamBold
					txt.TextSize = 14
				end
			end
		end
	end
end)

--------------------------------------------------
-- TP PET GẦN NHẤT
--------------------------------------------------
makeButton("TP PET",85,function()
	local nearest = nil
	local dist = math.huge

	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") and string.find(v.Name:lower(),"brainrot") and v.PrimaryPart then
			local d = (hrp.Position - v.PrimaryPart.Position).Magnitude
			if d < dist then
				dist = d
				nearest = v
			end
		end
	end

	if nearest then
		hrp.CFrame = nearest.PrimaryPart.CFrame + Vector3.new(0,3,0)
	end
end)

--------------------------------------------------
-- ANTI AFK
--------------------------------------------------
makeButton("ANTI AFK",130,function()
	if antiAfk then return end
	antiAfk = true

	player.Idled:Connect(function()
		VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		task.wait(1)
		VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
end)

--------------------------------------------------
-- AUTO SPACE
--------------------------------------------------
makeButton("AUTO SPACE",175,function()
	autoJump = not autoJump
end)

--------------------------------------------------
-- CLOSE
--------------------------------------------------
makeButton("CLOSE",220,function()
	frame.Visible = false
end)

--------------------------------------------------
-- AUTO JUMP LOOP
--------------------------------------------------
task.spawn(function()
	while true do
		task.wait(0.35)
		if autoJump then
			hum.Jump = true
		end
	end
end)

--------------------------------------------------
-- OPEN CLOSE
--------------------------------------------------
logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

--------------------------------------------------
-- DRAG
--------------------------------------------------
function dragify(obj)
	local dragging = false
	local dragStart
	local startPos

	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = obj.Position
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			obj.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

dragify(frame)
dragify(logo)

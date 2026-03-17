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

------------------------------------------------
-- GUI
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,280,0,240)
frame.Position = UDim2.new(0.35,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(10,10,10)

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(255,0,0)

------------------------------------------------
-- TITLE
------------------------------------------------
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "PhuBaby"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255,255,255)

------------------------------------------------
-- BUTTON FUNCTION
------------------------------------------------
function makeBtn(txt,y,cb)
	local b = Instance.new("TextButton")
	b.Parent = frame
	b.Size = UDim2.new(0.9,0,0,38)
	b.Position = UDim2.new(0.05,0,0,y)
	b.Text = txt
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(cb)
	return b
end

------------------------------------------------
-- FIND HIGHEST VALUE
------------------------------------------------
function getHighestBrainrot()
	local highest = nil
	local highestVal = 0

	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") and string.find(v.Name:lower(),"brainrot") then
			local val = 0

			for _,x in pairs(v:GetDescendants()) do
				if x:IsA("NumberValue") or x:IsA("IntValue") then
					val = x.Value
					break
				end
			end

			if val > highestVal and v.PrimaryPart then
				highestVal = val
				highest = v
			end
		end
	end

	return highest, highestVal
end

------------------------------------------------
-- CLEAR ESP
------------------------------------------------
function clearESP()
	for _,v in pairs(workspace:GetDescendants()) do
		if v:FindFirstChild("PhuESP") then
			v.PhuESP:Destroy()
		end
		if v:FindFirstChild("PhuBill") then
			v.PhuBill:Destroy()
		end
	end
end

------------------------------------------------
-- ESP HIGH VALUE ONLY
------------------------------------------------
makeBtn("ESP HIGH VALUE",40,function()
	espEnabled = not espEnabled

	clearESP()

	if espEnabled then
		local pet,val = getHighestBrainrot()

		if pet then
			local hl = Instance.new("Highlight")
			hl.Name = "PhuESP"
			hl.FillTransparency = 1
			hl.OutlineColor = Color3.fromRGB(255,255,0)
			hl.OutlineTransparency = 0
			hl.Parent = pet

			local bill = Instance.new("BillboardGui")
			bill.Name = "PhuBill"
			bill.Size = UDim2.new(0,220,0,60)
			bill.AlwaysOnTop = true
			bill.Adornee = pet.PrimaryPart
			bill.Parent = pet

			local txt = Instance.new("TextLabel")
			txt.Parent = bill
			txt.Size = UDim2.new(1,0,1,0)
			txt.BackgroundTransparency = 0.3
			txt.BackgroundColor3 = Color3.fromRGB(0,0,0)
			txt.TextColor3 = Color3.fromRGB(0,255,0)
			txt.Font = Enum.Font.GothamBold
			txt.TextScaled = true
			txt.Text = pet.Name.." | "..val.."/s"
		end
	end
end)

------------------------------------------------
-- TP HIGH VALUE
------------------------------------------------
makeBtn("TP HIGH VALUE",85,function()
	local pet = getHighestBrainrot()
	if pet then
		hrp.CFrame = pet.PrimaryPart.CFrame + Vector3.new(0,3,0)
	end
end)

------------------------------------------------
-- AUTO SPACE
------------------------------------------------
makeBtn("AUTO SPACE",130,function()
	autoJump = not autoJump
end)

task.spawn(function()
	while true do
		task.wait(0.25)
		if autoJump then
			if hum:GetState() ~= Enum.HumanoidStateType.Jumping then
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	end
end)

------------------------------------------------
-- ANTI AFK
------------------------------------------------
makeBtn("ANTI AFK",175,function()
	player.Idled:Connect(function()
		VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		task.wait(1)
		VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
end)

------------------------------------------------
-- DRAG MOBILE FIX
------------------------------------------------
local dragging = false
local dragInput
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

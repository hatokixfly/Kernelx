local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local savedPosition = nil
local autoReturn = false

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,290,0,170)
frame.Position = UDim2.new(0.38,0,0.35,0)
frame.BackgroundColor3 = Color3.fromRGB(10,10,10)

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255,0,0)

--------------------------------------------------
-- TITLE
--------------------------------------------------
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "PhuBaby"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255,255,255)

--------------------------------------------------
-- SAVE BUTTON
--------------------------------------------------
local saveBtn = Instance.new("TextButton", frame)
saveBtn.Size = UDim2.new(0.9,0,0,45)
saveBtn.Position = UDim2.new(0.05,0,0,45)
saveBtn.Text = "SAVE VỊ TRÍ"
saveBtn.Font = Enum.Font.GothamBold
saveBtn.TextSize = 18
saveBtn.TextColor3 = Color3.new(1,1,1)
saveBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)

Instance.new("UICorner", saveBtn).CornerRadius = UDim.new(0,12)

--------------------------------------------------
-- AUTO BUTTON
--------------------------------------------------
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(0.9,0,0,45)
autoBtn.Position = UDim2.new(0.05,0,0,100)
autoBtn.Text = "AUTO RETURN BASE : OFF"
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 17
autoBtn.TextColor3 = Color3.new(1,1,1)
autoBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)

Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0,12)

--------------------------------------------------
-- SAVE POSITION
--------------------------------------------------
saveBtn.MouseButton1Click:Connect(function()
	savedPosition = hrp.Position
	StarterGui:SetCore("SendNotification", {
		Title = "SAVE VỊ TRÍ",
		Text = "Đã lưu base",
		Duration = 2
	})
end)

--------------------------------------------------
-- AUTO RETURN
--------------------------------------------------
autoBtn.MouseButton1Click:Connect(function()
	autoReturn = not autoReturn

	if autoReturn then
		autoBtn.Text = "AUTO RETURN BASE : ON"
		autoBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
	else
		autoBtn.Text = "AUTO RETURN BASE : OFF"
		autoBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	end
end)

task.spawn(function()
	while true do
		task.wait(0.3)

		if autoReturn and savedPosition then
			char:PivotTo(CFrame.new(savedPosition))
		end
	end
end)

--------------------------------------------------
-- DRAG MENU
--------------------------------------------------
local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
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
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

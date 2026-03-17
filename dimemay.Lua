local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local savedPosition = nil
local autoRun = false

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,280,0,170)
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
-- SAVE BUTTON
--------------------------------------------------
local saveBtn = Instance.new("TextButton", frame)
saveBtn.Size = UDim2.new(0.9,0,0,45)
saveBtn.Position = UDim2.new(0.05,0,0,45)
saveBtn.Text = "SAVE VỊ TRÍ"
saveBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
saveBtn.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner", saveBtn).CornerRadius = UDim.new(0,12)

--------------------------------------------------
-- AUTO BUTTON
--------------------------------------------------
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(0.9,0,0,45)
autoBtn.Position = UDim2.new(0.05,0,0,100)
autoBtn.Text = "AUTO GET PET : OFF"
autoBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
autoBtn.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0,12)

--------------------------------------------------
-- SAVE
--------------------------------------------------
saveBtn.MouseButton1Click:Connect(function()
	savedPosition = hrp.Position

	StarterGui:SetCore("SendNotification",{
		Title="SAVE",
		Text="Đã lưu vị trí",
		Duration=2
	})
end)

--------------------------------------------------
-- AUTO
--------------------------------------------------
autoBtn.MouseButton1Click:Connect(function()
	autoRun = not autoRun

	if autoRun then
		autoBtn.Text = "AUTO GET PET : ON"
		autoBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
	else
		autoBtn.Text = "AUTO GET PET : OFF"
		autoBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	end
end)

--------------------------------------------------
-- CLICK MANG THEO XONG BAY + CHẠY
--------------------------------------------------
UIS.InputBegan:Connect(function(input,gp)
	if gp then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 and autoRun and savedPosition then

		-- bay lên trời
		local flyPos = hrp.Position + Vector3.new(0,80,0)

		local tween = TweenService:Create(
			hrp,
			TweenInfo.new(1),
			{CFrame = CFrame.new(flyPos)}
		)

		tween:Play()
		tween.Completed:Wait()

		task.wait(0.2)

		-- chạy về base
		hum:MoveTo(savedPosition)

		StarterGui:SetCore("SendNotification",{
			Title="AUTO GET PET",
			Text="Đang về base",
			Duration=2
		})
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

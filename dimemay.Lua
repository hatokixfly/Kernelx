--// PhuBaBy Compact Full Fixed

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

------------------------------------------------
-- STATE
------------------------------------------------

local savedBase = nil
local autoJump = false
local antiAfk = false
local autoPet = false

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false
gui.Name = "PhuBaByGUI"

------------------------------------------------
-- LOGO
------------------------------------------------

local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0,55,0,55)
logo.Position = UDim2.new(0,20,0.4,0)
logo.Text = "P"
logo.Font = Enum.Font.GothamBold
logo.TextScaled = true
logo.BackgroundColor3 = Color3.fromRGB(20,20,20)
logo.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

------------------------------------------------
-- FRAME
------------------------------------------------

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,280,0,260)
frame.Position = UDim2.new(0.5,-140,0.5,-130)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Visible = false

Instance.new("UICorner",frame)

------------------------------------------------
-- NOTIFY
------------------------------------------------

local function notify(txt)

	local n = Instance.new("TextLabel", gui)
	n.Size = UDim2.new(0,200,0,45)
	n.Position = UDim2.new(1,220,0.1,0)
	n.BackgroundColor3 = Color3.fromRGB(20,20,20)
	n.Text = txt
	n.TextColor3 = Color3.new(1,1,1)
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true

	Instance.new("UICorner",n)

	TweenService:Create(n,TweenInfo.new(.3),{
		Position = UDim2.new(1,-210,0.1,0)
	}):Play()

	task.wait(2)

	TweenService:Create(n,TweenInfo.new(.3),{
		TextTransparency = 1,
		BackgroundTransparency = 1
	}):Play()

	task.wait(.3)
	n:Destroy()

end

------------------------------------------------
-- BUTTON MAKER
------------------------------------------------

local y = 10

local function createToggle(name, callback)

	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1,-20,0,40)
	btn.Position = UDim2.new(0,10,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = name.." [OFF]"
	btn.Font = Enum.Font.GothamBold

	Instance.new("UICorner",btn)

	local state = false

	btn.MouseButton1Click:Connect(function()

		state = not state

		if state then
			btn.Text = name.." [ON]"
			btn.BackgroundColor3 = Color3.fromRGB(255,40,40)
			notify("[✓] "..name.." ON")
		else
			btn.Text = name.." [OFF]"
			btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
			notify("[✕] "..name.." OFF")
		end

		callback(state)

	end)

	y += 45

end

------------------------------------------------
-- SAVE BASE
------------------------------------------------

local saveBtn = Instance.new("TextButton", frame)
saveBtn.Size = UDim2.new(1,-20,0,40)
saveBtn.Position = UDim2.new(0,10,0,y)
saveBtn.Text = "Save Base"
saveBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
saveBtn.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",saveBtn)

saveBtn.MouseButton1Click:Connect(function()
	savedBase = hrp.CFrame
	notify("[✓] Base Saved")
end)

y += 45

------------------------------------------------
-- TELEPORT BASE
------------------------------------------------

local tpBtn = Instance.new("TextButton", frame)
tpBtn.Size = UDim2.new(1,-20,0,40)
tpBtn.Position = UDim2.new(0,10,0,y)
tpBtn.Text = "Teleport Base"
tpBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
tpBtn.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",tpBtn)

tpBtn.MouseButton1Click:Connect(function()
	if savedBase then
		hrp.CFrame = savedBase
		notify("[✓] Teleported")
	end
end)

y += 45

------------------------------------------------
-- AUTO PET
------------------------------------------------

createToggle("Auto Pet", function(v)
	autoPet = v
end)

task.spawn(function()

	while true do
		task.wait(0.3)

		if autoPet and savedBase then

			local carrying = false

			for _,v in pairs(char:GetChildren()) do
				if v:IsA("Model") then
					carrying = true
				end
			end

			if carrying then
				hrp.CFrame = savedBase
				task.wait(1)
			end

		end

	end

end)

------------------------------------------------
-- AUTO JUMP
------------------------------------------------

createToggle("Auto Jump", function(v)
	autoJump = v
end)

task.spawn(function()
	while true do
		task.wait(1)
		if autoJump then
			humanoid.Jump = true
		end
	end
end)

------------------------------------------------
-- ANTI AFK
------------------------------------------------

createToggle("Anti AFK", function(v)
	antiAfk = v
end)

player.Idled:Connect(function()
	if antiAfk then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

------------------------------------------------
-- OPEN CLOSE
------------------------------------------------

logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

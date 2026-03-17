--// PhuBaBy Auto Pet Strong Fix

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

local savedBase = nil
local autoPet = false

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0,55,0,55)
logo.Position = UDim2.new(0,20,0.4,0)
logo.Text = "P"
logo.BackgroundColor3 = Color3.fromRGB(20,20,20)
logo.TextColor3 = Color3.new(1,1,1)
logo.Font = Enum.Font.GothamBold
logo.TextScaled = true
Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,280,0,180)
frame.Position = UDim2.new(0.5,-140,0.5,-90)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Visible = false
Instance.new("UICorner",frame)

------------------------------------------------
-- NOTIFY
------------------------------------------------

local function notify(t)

	local n = Instance.new("TextLabel", gui)
	n.Size = UDim2.new(0,200,0,45)
	n.Position = UDim2.new(1,220,0.1,0)
	n.BackgroundColor3 = Color3.fromRGB(20,20,20)
	n.Text = t
	n.TextColor3 = Color3.new(1,1,1)
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true

	Instance.new("UICorner",n)

	TweenService:Create(n,TweenInfo.new(.3),{
		Position = UDim2.new(1,-210,0.1,0)
	}):Play()

	task.wait(2)

	n:Destroy()

end

------------------------------------------------
-- SAVE BASE
------------------------------------------------

local save = Instance.new("TextButton", frame)
save.Size = UDim2.new(1,-20,0,40)
save.Position = UDim2.new(0,10,0,10)
save.Text = "Save Base"
save.BackgroundColor3 = Color3.fromRGB(40,40,40)
save.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",save)

save.MouseButton1Click:Connect(function()
	savedBase = hrp.CFrame
	notify("[✓] Base Saved")
end)

------------------------------------------------
-- AUTO PET TOGGLE
------------------------------------------------

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(1,-20,0,40)
toggle.Position = UDim2.new(0,10,0,60)
toggle.Text = "Auto Pet [OFF]"
toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",toggle)

toggle.MouseButton1Click:Connect(function()

	autoPet = not autoPet

	if autoPet then
		toggle.Text = "Auto Pet [ON]"
		toggle.BackgroundColor3 = Color3.fromRGB(255,40,40)
		notify("[✓] Auto Pet ON")
	else
		toggle.Text = "Auto Pet [OFF]"
		toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
		notify("[✕] Auto Pet OFF")
	end

end)

------------------------------------------------
-- FORCE AUTO PET
------------------------------------------------

task.spawn(function()

	while true do
		task.wait(0.03)

		if autoPet and savedBase then

			local carrying = false

			for _,v in pairs(char:GetChildren()) do
				if v:IsA("Model") then
					carrying = true
				end
			end

			if carrying then

				for i = 1,20 do

					hrp.CFrame = hrp.CFrame + Vector3.new(0,3,0)
					task.wait(0.02)

					hrp.CFrame = savedBase + Vector3.new(0,3,0)
					task.wait(0.02)

					hrp.CFrame = savedBase

				end

			end

		end

	end

end)

------------------------------------------------
-- OPEN CLOSE
------------------------------------------------

logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

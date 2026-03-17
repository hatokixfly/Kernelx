--// PhuBaBy Compact GUI

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

------------------------------------------------
-- VARIABLES
------------------------------------------------

local savedBase = nil
local autoPet = false
local autoJump = false

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui",player.PlayerGui)
gui.ResetOnSpawn = false

local openBtn = Instance.new("TextButton",gui)
openBtn.Size = UDim2.new(0,50,0,50)
openBtn.Position = UDim2.new(0,20,0.4,0)
openBtn.Text = "P"
openBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)

Instance.new("UICorner",openBtn).CornerRadius = UDim.new(1,0)

local frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(0,260,0,220)
frame.Position = UDim2.new(0.5,-130,0.5,-110)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Visible = false

Instance.new("UICorner",frame)

------------------------------------------------
-- BUTTON CREATOR
------------------------------------------------

local y = 10

local function createButton(name,callback)

	local btn = Instance.new("TextButton",frame)
	btn.Size = UDim2.new(1,-20,0,35)
	btn.Position = UDim2.new(0,10,0,y)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	btn.TextColor3 = Color3.new(1,1,1)

	Instance.new("UICorner",btn)

	btn.MouseButton1Click:Connect(callback)

	y += 40
end

------------------------------------------------
-- SAVE BASE
------------------------------------------------

createButton("Save Base",function()
	savedBase = hrp.CFrame
end)

------------------------------------------------
-- AUTO PET
------------------------------------------------

createButton("Auto Pet",function()
	autoPet = not autoPet
end)

task.spawn(function()

	while task.wait(1) do

		if autoPet and savedBase then

			for _,v in pairs(workspace:GetDescendants()) do

				if v:IsA("ProximityPrompt") and v.ActionText == "Mang theo" then

					local pet = v.Parent

					if pet and pet:IsA("Model") and pet:FindFirstChild("HumanoidRootPart") then

						hrp.CFrame = pet.HumanoidRootPart.CFrame + Vector3.new(0,3,0)

						task.wait(.5)

						fireproximityprompt(v)

						task.wait(.5)

						hrp.CFrame = savedBase

					end

				end

			end

		end

	end

end)

------------------------------------------------
-- AUTO JUMP
------------------------------------------------

createButton("Auto Jump",function()
	autoJump = not autoJump
end)

task.spawn(function()
	while task.wait(1) do
		if autoJump then
			humanoid.Jump = true
		end
	end
end)

------------------------------------------------
-- ANTI AFK
------------------------------------------------

createButton("Anti AFK",function()

	player.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)

end)

------------------------------------------------
-- OPEN GUI
------------------------------------------------

openBtn.MouseButton1Click:Connect(function()

	frame.Visible = not frame.Visible

end)

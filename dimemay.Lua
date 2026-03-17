local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

------------------------------------------------
-- REMOVE OLD GUI
------------------------------------------------

if player.PlayerGui:FindFirstChild("PhuBaByStrength") then
	player.PlayerGui.PhuBaByStrength:Destroy()
end

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "PhuBaByStrength"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

------------------------------------------------
-- MAIN FRAME
------------------------------------------------

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,250,0,150)
frame.Position = UDim2.new(0.5,-125,0.5,-75)
frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

------------------------------------------------
-- TITLE
------------------------------------------------

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "PhuBaBy Strength"
title.TextColor3 = Color3.fromRGB(255,50,50)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

------------------------------------------------
-- INPUT
------------------------------------------------

local box = Instance.new("TextBox")
box.Parent = frame
box.Size = UDim2.new(0,220,0,35)
box.Position = UDim2.new(0.5,-110,0,45)
box.BackgroundColor3 = Color3.fromRGB(25,25,25)
box.TextColor3 = Color3.new(1,1,1)
box.PlaceholderText = "Nhập sức mạnh..."
box.Text = ""
box.Font = Enum.Font.GothamBold
box.TextScaled = true

Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)

------------------------------------------------
-- START BUTTON
------------------------------------------------

local btn = Instance.new("TextButton")
btn.Parent = frame
btn.Size = UDim2.new(0,220,0,35)
btn.Position = UDim2.new(0.5,-110,0,90)
btn.BackgroundColor3 = Color3.fromRGB(255,50,50)
btn.Text = "START SỨC MẠNH"
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true

Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

------------------------------------------------
-- CLOSE BUTTON
------------------------------------------------

local close = Instance.new("TextButton")
close.Parent = frame
close.Size = UDim2.new(0,25,0,25)
close.Position = UDim2.new(1,-30,0,5)
close.BackgroundColor3 = Color3.fromRGB(255,50,50)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextScaled = true

Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

------------------------------------------------
-- FIND STAT
------------------------------------------------

local function findStat()
	local stats = player:FindFirstChild("leaderstats")
	if not stats then return nil end

	for _,v in pairs(stats:GetChildren()) do
		if v:IsA("IntValue") or v:IsA("NumberValue") then
			return v
		end
	end
end

------------------------------------------------
-- START
------------------------------------------------

btn.MouseButton1Click:Connect(function()

	local value = tonumber(box.Text)
	if not value then return end

	local stat = findStat()

	if stat then
		task.spawn(function()
			while true do
				stat.Value = value
				task.wait()
			end
		end)
	end

	gui:Destroy()

end)

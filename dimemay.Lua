local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,260,0,180)
frame.Position = UDim2.new(0.5,-130,0.5,-90)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)

Instance.new("UICorner", frame)

------------------------------------------------
-- TITLE
------------------------------------------------

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,40)
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
box.Size = UDim2.new(1,-20,0,40)
box.Position = UDim2.new(0,10,0,50)
box.PlaceholderText = "Nhập sức mạnh..."
box.Text = ""
box.BackgroundColor3 = Color3.fromRGB(30,30,30)
box.TextColor3 = Color3.new(1,1,1)
box.Font = Enum.Font.GothamBold
box.TextScaled = true

Instance.new("UICorner", box)

------------------------------------------------
-- START BUTTON
------------------------------------------------

local btn = Instance.new("TextButton")
btn.Parent = frame
btn.Size = UDim2.new(1,-20,0,40)
btn.Position = UDim2.new(0,10,0,100)
btn.Text = "START SỨC MẠNH"
btn.BackgroundColor3 = Color3.fromRGB(255,40,40)
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true

Instance.new("UICorner", btn)

------------------------------------------------
-- CLOSE BUTTON
------------------------------------------------

local close = Instance.new("TextButton")
close.Parent = frame
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255,40,40)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextScaled = true

Instance.new("UICorner", close)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

------------------------------------------------
-- NOTIFY
------------------------------------------------

local function notify(txt)
	local n = Instance.new("TextLabel")
	n.Parent = gui
	n.Size = UDim2.new(0,220,0,50)
	n.Position = UDim2.new(1,220,0.1,0)
	n.BackgroundColor3 = Color3.fromRGB(20,20,20)
	n.Text = txt
	n.TextColor3 = Color3.new(1,1,1)
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true
	Instance.new("UICorner", n)

	TweenService:Create(n,TweenInfo.new(.3),{
		Position = UDim2.new(1,-230,0.1,0)
	}):Play()

	task.wait(2)
	n:Destroy()
end

------------------------------------------------
-- FIND STRENGTH
------------------------------------------------

local function findStrength()

	local paths = {
		player:FindFirstChild("leaderstats"),
		player:FindFirstChild("Data"),
		player:FindFirstChild("Stats")
	}

	for _,folder in pairs(paths) do
		if folder then
			for _,v in pairs(folder:GetChildren()) do
				if string.lower(v.Name):find("strength") then
					return v
				end
			end
		end
	end

	return nil
end

------------------------------------------------
-- START
------------------------------------------------

btn.MouseButton1Click:Connect(function()

	local value = tonumber(box.Text)

	if not value then
		notify("❌ Nhập số hợp lệ")
		return
	end

	local strength = findStrength()

	if strength then
		strength.Value = value
		notify("✅ Thành công: "..value)

		task.wait(1)
		gui:Destroy() -- close menu sau khi thành công

	else
		notify("❌ Không tìm thấy Strength")
	end

end)

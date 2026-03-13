local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- CONFIG
--------------------------------------------------

local Accent = Color3.fromRGB(255,0,0)

--------------------------------------------------
-- GUI ROOT
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "KernelxUI"
gui.Parent = PlayerGui
gui.ResetOnSpawn = false

--------------------------------------------------
-- LOGO BUTTON
--------------------------------------------------

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,70,0,70)
logo.Position = UDim2.new(0,20,0.5,-35)
logo.Text = "K"
logo.TextColor3 = Accent
logo.TextScaled = true
logo.Font = Enum.Font.GothamBold
logo.BackgroundColor3 = Color3.fromRGB(10,10,10)
logo.BorderSizePixel = 0
logo.AutoButtonColor = false

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(1,0)
logoCorner.Parent = logo

--------------------------------------------------
-- MAIN FRAME
--------------------------------------------------

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,780,0,480)
main.Position = UDim2.new(0.5,-390,0.5,-240)
main.BackgroundColor3 = Color3.fromRGB(5,5,5)
main.BorderSizePixel = 0
main.Visible = false

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,18)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Accent
stroke.Thickness = 2
stroke.Parent = main

--------------------------------------------------
-- HEADER
--------------------------------------------------

local header = Instance.new("TextLabel")
header.Parent = main
header.Size = UDim2.new(1,0,0,60)
header.BackgroundTransparency = 1
header.Text = "Kernelx"
header.TextColor3 = Accent
header.Font = Enum.Font.GothamBold
header.TextScaled = true

--------------------------------------------------
-- LEFT PANEL
--------------------------------------------------

local left = Instance.new("Frame")
left.Parent = main
left.Size = UDim2.new(0,180,1,-70)
left.Position = UDim2.new(0,10,0,65)
left.BackgroundTransparency = 1

local function createTab(name,y)
	local b = Instance.new("TextButton")
	b.Parent = left
	b.Size = UDim2.new(1,0,0,55)
	b.Position = UDim2.new(0,0,0,y)
	b.Text = name
	b.Font = Enum.Font.GothamBold
	b.TextColor3 = Color3.new(1,1,1)
	b.TextScaled = true
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.BorderSizePixel = 0
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,12)
	c.Parent = b
	
	return b
end

local mainTab = createTab("MAIN",0)
local settingsTab = createTab("SETTINGS",70)

--------------------------------------------------
-- CONTENT FRAME
--------------------------------------------------

local content = Instance.new("Frame")
content.Parent = main
content.Size = UDim2.new(1,-210,1,-90)
content.Position = UDim2.new(0,200,0,75)
content.BackgroundTransparency = 1

--------------------------------------------------
-- NOTIFICATION
--------------------------------------------------

local function notify(text)
	local n = Instance.new("TextLabel")
	n.Parent = gui
	n.Size = UDim2.new(0,280,0,50)
	n.Position = UDim2.new(1,-300,0,40)
	n.BackgroundColor3 = Color3.fromRGB(10,10,10)
	n.TextColor3 = Color3.new(1,1,1)
	n.Text = text
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true
	
	local nc = Instance.new("UICorner")
	nc.CornerRadius = UDim.new(0,12)
	nc.Parent = n
	
	local ns = Instance.new("UIStroke")
	ns.Color = Accent
	ns.Parent = n
	
	n.TextTransparency = 1
	n.BackgroundTransparency = 1
	
	TweenService:Create(n,TweenInfo.new(0.3),{
		TextTransparency = 0,
		BackgroundTransparency = 0
	}):Play()
	
	task.wait(2)
	
	TweenService:Create(n,TweenInfo.new(0.3),{
		TextTransparency = 1,
		BackgroundTransparency = 1
	}):Play()
	
	task.wait(0.4)
	n:Destroy()
end

--------------------------------------------------
-- TOGGLE CREATOR
--------------------------------------------------

local function createToggle(parent,name,y,callback)
	local box = Instance.new("Frame")
	box.Parent = parent
	box.Size = UDim2.new(1,0,0,70)
	box.Position = UDim2.new(0,0,0,y)
	box.BackgroundColor3 = Color3.fromRGB(15,15,15)
	box.BorderSizePixel = 0
	
	local bc = Instance.new("UICorner")
	bc.CornerRadius = UDim.new(0,14)
	bc.Parent = box
	
	local txt = Instance.new("TextLabel")
	txt.Parent = box
	txt.Size = UDim2.new(0.6,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = name
	txt.TextColor3 = Color3.new(1,1,1)
	txt.Font = Enum.Font.GothamBold
	txt.TextScaled = true
	
	local toggle = Instance.new("TextButton")
	toggle.Parent = box
	toggle.Size = UDim2.new(0,70,0,34)
	toggle.Position = UDim2.new(1,-90,0.5,-17)
	toggle.Text = ""
	toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
	toggle.BorderSizePixel = 0
	
	local tc = Instance.new("UICorner")
	tc.CornerRadius = UDim.new(1,0)
	tc.Parent = toggle
	
	local knob = Instance.new("Frame")
	knob.Parent = toggle
	knob.Size = UDim2.new(0,28,0,28)
	knob.Position = UDim2.new(0,3,0.5,-14)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	knob.BorderSizePixel = 0
	
	local kc = Instance.new("UICorner")
	kc.CornerRadius = UDim.new(1,0)
	kc.Parent = knob
	
	local state = false
	
	toggle.MouseButton1Click:Connect(function()
		state = not state
		
		if state then
			TweenService:Create(toggle,TweenInfo.new(0.25),{
				BackgroundColor3 = Accent
			}):Play()
			
			TweenService:Create(knob,TweenInfo.new(0.25),{
				Position = UDim2.new(1,-31,0.5,-14)
			}):Play()
		else
			TweenService:Create(toggle,TweenInfo.new(0.25),{
				BackgroundColor3 = Color3.fromRGB(40,40,40)
			}):Play()
			
			TweenService:Create(knob,TweenInfo.new(0.25),{
				Position = UDim2.new(0,3,0.5,-14)
			}):Play()
		end
		
		callback(state)
	end)
end

--------------------------------------------------
-- MAIN TAB
--------------------------------------------------

createToggle(content,"AUTO SLOT 1",0,function(v)
	notify("AUTO SLOT 1 "..(v and "ENABLED" or "DISABLED"))
	
	if v then
		task.spawn(function()
			while v do
				local char = player.Character
				if char then
					local tool = char:FindFirstChildOfClass("Tool")
					if not tool then
						local backpack = player:FindFirstChild("Backpack")
						if backpack and backpack:FindFirstChildOfClass("Tool") then
							backpack:FindFirstChildOfClass("Tool").Parent = char
						end
					end
				end
				task.wait(1)
			end
		end)
	end
end)

createToggle(content,"ANTI AFK",90,function(v)
	notify("ANTI AFK "..(v and "ENABLED" or "DISABLED"))
	
	if v then
		player.Idled:Connect(function()
			VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			task.wait(1)
			VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
	end
end)

--------------------------------------------------
-- SETTINGS TAB
--------------------------------------------------

local settingsFrame = Instance.new("Frame")
settingsFrame.Parent = content
settingsFrame.Size = UDim2.new(1,0,1,0)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Visible = false

local fps = Instance.new("TextButton")
fps.Parent = settingsFrame
fps.Size = UDim2.new(0,220,0,50)
fps.Text = "BOOST FPS"
fps.BackgroundColor3 = Color3.fromRGB(20,20,20)
fps.TextColor3 = Color3.new(1,1,1)

fps.MouseButton1Click:Connect(function()
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Enabled = false
		end
	end
	notify("BOOST FPS APPLIED")
end)

--------------------------------------------------
-- COLOR APPLY
--------------------------------------------------

local colors = {
	RED = Color3.fromRGB(255,0,0),
	BLUE = Color3.fromRGB(0,170,255),
	YELLOW = Color3.fromRGB(255,255,0),
	BLACK = Color3.fromRGB(30,30,30)
}

local x = 0
for name,col in pairs(colors) do
	local b = Instance.new("TextButton")
	b.Parent = settingsFrame
	b.Size = UDim2.new(0,100,0,40)
	b.Position = UDim2.new(0,x,0,70)
	b.Text = name
	b.BackgroundColor3 = col
	b.TextColor3 = Color3.new(1,1,1)
	x += 110
	
	b.MouseButton1Click:Connect(function()
		Accent = col
		stroke.Color = Accent
		header.TextColor3 = Accent
		logo.TextColor3 = Accent
		notify("COLOR APPLIED")
	end)
end

--------------------------------------------------
-- CREDIT
--------------------------------------------------

local credit = Instance.new("TextLabel")
credit.Parent = settingsFrame
credit.Position = UDim2.new(0,0,1,-50)
credit.Size = UDim2.new(1,0,0,40)
credit.BackgroundTransparency = 1
credit.Text = "Script By: Nguyen Thanh Phu"
credit.Font = Enum.Font.GothamBold
credit.TextScaled = true

task.spawn(function()
	while true do
		for i=0,1,0.02 do
			credit.TextColor3 = Color3.fromHSV(i,1,1)
			task.wait()
		end
	end
end)

--------------------------------------------------
-- TAB SWITCH
--------------------------------------------------

mainTab.MouseButton1Click:Connect(function()
	content.Visible = true
	settingsFrame.Visible = false
end)

settingsTab.MouseButton1Click:Connect(function()
	content.Visible = false
	settingsFrame.Visible = true
end)

--------------------------------------------------
-- MENU OPEN CLOSE
--------------------------------------------------

logo.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
	
	if main.Visible then
		main.Size = UDim2.new(0,0,0,0)
		TweenService:Create(main,TweenInfo.new(0.35),{
			Size = UDim2.new(0,780,0,480)
		}):Play()
	end
end)

--------------------------------------------------
-- DRAG SYSTEM
--------------------------------------------------

local function dragify(frame)
	local dragToggle = nil
	local dragStart
	local startPos
	
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)
	
	frame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragToggle = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

dragify(main)
dragify(logo)

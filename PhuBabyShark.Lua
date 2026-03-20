-- PhuBaby Dev Premium GUI Framework 2026 -- Loadstring Ready Framework (replace raw link when hosting) -- UI Framework only, gameplay logic uses placeholders

local Players = game:GetService("Players") local TweenService = game:GetService("TweenService") local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local Stats = game:GetService("Stats") local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("PhuBabyDev") then CoreGui.PhuBabyDev:Destroy() end

local Config = { AccentHue = 0, Notifications = true, ThemeNeon = true, Language = "Vietnamese" }

local State = { Hitbox = false, MultiJump = false, Aura = false, ShiftLock = false, FOV = 120 }

local function AccentColor() return Color3.fromHSV(Config.AccentHue,1,1) end

local function Tween(obj, props, t) TweenService:Create(obj, TweenInfo.new(t or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play() end

local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "PhuBabyDev" ScreenGui.ResetOnSpawn = false ScreenGui.Parent = CoreGui

local NotificationHolder = Instance.new("Frame", ScreenGui) NotificationHolder.BackgroundTransparency = 1 NotificationHolder.Position = UDim2.new(1,-320,0,20) NotificationHolder.Size = UDim2.new(0,300,0,200)

local function Notify(text) if not Config.Notifications then return end local box = Instance.new("Frame", NotificationHolder) box.Size = UDim2.new(1,0,0,40) box.BackgroundColor3 = Color3.fromRGB(15,15,15) box.BorderSizePixel = 0 local corner = Instance.new("UICorner", box) local stroke = Instance.new("UIStroke", box) stroke.Color = AccentColor()

local lbl = Instance.new("TextLabel", box)
lbl.Size = UDim2.new(1,0,1,0)
lbl.BackgroundTransparency = 1
lbl.Text = text
lbl.TextColor3 = Color3.new(1,1,1)
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 13

box.Position = UDim2.new(1,0,0,0)
Tween(box,{Position = UDim2.new(0,0,0,0)},0.3)
task.delay(2,function()
    Tween(box,{Position = UDim2.new(1,0,0,0)},0.3)
    task.wait(0.3)
    box:Destroy()
end)

end

local Loading = Instance.new("Frame", ScreenGui) Loading.Size = UDim2.new(0,420,0,180) Loading.Position = UDim2.new(0.5,-210,0.5,-90) Loading.BackgroundColor3 = Color3.fromRGB(10,10,10) Loading.BorderSizePixel = 0 Instance.new("UICorner", Loading).CornerRadius = UDim.new(0,14)

local LoadStroke = Instance.new("UIStroke", Loading) LoadStroke.Thickness = 2

local LoadText = Instance.new("TextLabel", Loading) LoadText.Size = UDim2.new(1,0,0,50) LoadText.BackgroundTransparency = 1 LoadText.Text = "PhuBaby Dev Loading 0%" LoadText.Font = Enum.Font.GothamBold LoadText.TextSize = 18 LoadText.TextColor3 = Color3.new(1,1,1)

local BarBg = Instance.new("Frame", Loading) BarBg.Size = UDim2.new(0.85,0,0,14) BarBg.Position = UDim2.new(0.075,0,0.62,0) BarBg.BackgroundColor3 = Color3.fromRGB(30,30,30) BarBg.BorderSizePixel = 0 Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1,0)

local Bar = Instance.new("Frame", BarBg) Bar.Size = UDim2.new(0,0,1,0) Bar.BorderSizePixel = 0 Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

local Main = Instance.new("Frame", ScreenGui) Main.Visible = false Main.Size = UDim2.new(0,650,0,420) Main.Position = UDim2.new(0.5,-325,0.5,-210) Main.BackgroundColor3 = Color3.fromRGB(8,8,8) Main.BorderSizePixel = 0 Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local MainStroke = Instance.new("UIStroke", Main) MainStroke.Thickness = 2

local Title = Instance.new("TextLabel", Main) Title.Size = UDim2.new(1,0,0,45) Title.BackgroundTransparency = 1 Title.Text = "PhuBaby Dev" Title.Font = Enum.Font.GothamBold Title.TextSize = 20 Title.TextColor3 = Color3.new(1,1,1)

local MinBtn = Instance.new("TextButton", Main) MinBtn.Size = UDim2.new(0,35,0,35) MinBtn.Position = UDim2.new(1,-45,0,5) MinBtn.Text = "+" MinBtn.Font = Enum.Font.GothamBold MinBtn.TextSize = 20 MinBtn.BackgroundColor3 = Color3.fromRGB(20,20,20) MinBtn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", MinBtn)

local Restore = Instance.new("TextButton", ScreenGui) Restore.Visible = false Restore.Size = UDim2.new(0,50,0,50) Restore.Position = UDim2.new(0,20,0.5,0) Restore.Text = "-" Restore.Font = Enum.Font.GothamBold Restore.TextSize = 22 Restore.BackgroundColor3 = Color3.fromRGB(10,10,10) Restore.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", Restore)

local TabBar = Instance.new("Frame", Main) TabBar.Size = UDim2.new(0,130,1,-50) TabBar.Position = UDim2.new(0,0,0,50) TabBar.BackgroundColor3 = Color3.fromRGB(12,12,12) BorderSizePixel = 0

local Content = Instance.new("Frame", Main) Content.Size = UDim2.new(1,-140,1,-60) Content.Position = UDim2.new(0,135,0,55) Content.BackgroundTransparency = 1

local Tabs = {} local Pages = {} local tabNames = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}

for i,name in ipairs(tabNames) do local btn = Instance.new("TextButton", TabBar) btn.Size = UDim2.new(1,-10,0,45) btn.Position = UDim2.new(0,5,0,(i-1)*50) btn.Text = name btn.Font = Enum.Font.GothamBold btn.TextSize = 14 btn.BackgroundColor3 = Color3.fromRGB(18,18,18) btn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", btn) Tabs[name] = btn

local page = Instance.new("ScrollingFrame", Content)
page.Size = UDim2.new(1,0,1,0)
page.CanvasSize = UDim2.new(0,0,0,800)
page.ScrollBarThickness = 4
page.BackgroundTransparency = 1
page.Visible = i == 1
Pages[name] = page

local layout = Instance.new("UIListLayout", page)
layout.Padding = UDim.new(0,8)

btn.MouseButton1Click:Connect(function()
    for n,p in pairs(Pages) do
        p.Visible = false
    end
    page.Visible = true
end)

end

local function CreateToggle(parent, text, callback) local frame = Instance.new("Frame", parent) frame.Size = UDim2.new(1,-10,0,50) frame.BackgroundColor3 = Color3.fromRGB(15,15,15) Instance.new("UICorner", frame)

local lbl = Instance.new("TextLabel", frame)
lbl.Size = UDim2.new(0.7,0,1,0)
lbl.BackgroundTransparency = 1
lbl.Text = text
lbl.TextColor3 = Color3.new(1,1,1)
lbl.Font = Enum.Font.Gotham
lbl.TextSize = 14

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0,60,0,28)
btn.Position = UDim2.new(1,-70,0.5,-14)
btn.Text = "OFF"
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.fromRGB(120,20,20)
Instance.new("UICorner", btn)

local state = false
btn.MouseButton1Click:Connect(function()
    state = not state
    btn.Text = state and "ON" or "OFF"
    btn.BackgroundColor3 = state and Color3.fromRGB(20,120,20) or Color3.fromRGB(120,20,20)
    Notify(state and "[ ON ] Function Enabled" or "[ OFF ] Function Disabled")
    callback(state)
end)

end

local function CreateSlider(parent, text, min, max, default, callback) local frame = Instance.new("Frame", parent) frame.Size = UDim2.new(1,-10,0,70) frame.BackgroundColor3 = Color3.fromRGB(15,15,15) Instance.new("UICorner", frame)

local lbl = Instance.new("TextLabel", frame)
lbl.Size = UDim2.new(1,0,0,25)
lbl.BackgroundTransparency = 1
lbl.Text = text..": "..default
lbl.TextColor3 = Color3.new(1,1,1)
lbl.Font = Enum.Font.Gotham

local bar = Instance.new("Frame", frame)
bar.Size = UDim2.new(0.9,0,0,10)
bar.Position = UDim2.new(0.05,0,0.6,0)
bar.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", bar)

local fill = Instance.new("Frame", bar)
fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
fill.BackgroundColor3 = AccentColor()
Instance.new("UICorner", fill)

local drag = false
bar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end
end)
UserInputService.InputChanged:Connect(function(i)
    if drag then
        local x = math.clamp((i.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
        fill.Size = UDim2.new(x,0,1,0)
        local val = math.floor(min + ((max-min)*x))
        lbl.Text = text..": "..val
        callback(val)
    end
end)

end

local function CreateDropdown(parent, text) local frame = Instance.new("Frame", parent) frame.Size = UDim2.new(1,-10,0,50) frame.BackgroundColor3 = Color3.fromRGB(15,15,15) Instance.new("UICorner", frame)

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1,0,1,0)
btn.Text = text.." ▼"
btn.BackgroundTransparency = 1
btn.TextColor3 = Color3.new(1,1,1)

end

CreateToggle(Pages.MAIN,"Hitbox Module Placeholder", function(v) State.Hitbox = v end) CreateSlider(Pages.MAIN,"Hitbox Size",1,20,5,function(v) end) CreateToggle(Pages.MAIN,"MultiJump Module Placeholder", function(v) State.MultiJump = v end) CreateToggle(Pages.MAIN,"Aura Module Placeholder", function(v) State.Aura = v end) CreateToggle(Pages.MAIN,"ShiftLock Module Placeholder", function(v) State.ShiftLock = v end) CreateSlider(Pages.MAIN,"FOV Size",50,500,120,function(v) State.FOV = v end)

CreateToggle(Pages.ESP,"Rainbow Visual Outline", function() end) CreateToggle(Pages.ESP,"Red Box Visual", function() end) CreateToggle(Pages.ESP,"Name Display", function() end) CreateToggle(Pages.ESP,"Auto Module Placeholder", function() end)

CreateDropdown(Pages.PLAYER,"Player List") CreateToggle(Pages.PLAYER,"Action Placeholder", function() end) CreateToggle(Pages.PLAYER,"Refresh Players", function() end)

local ServerInfo = Instance.new("TextLabel", Pages.SERVER) ServerInfo.Size = UDim2.new(1,-10,0,120) ServerInfo.BackgroundColor3 = Color3.fromRGB(15,15,15) ServerInfo.TextColor3 = Color3.new(1,1,1) ServerInfo.Font = Enum.Font.GothamBold ServerInfo.TextSize = 14 ServerInfo.TextYAlignment = Enum.TextYAlignment.Top Instance.new("UICorner", ServerInfo)

CreateDropdown(Pages.SETTINGS,"Language: Vietnamese / English") CreateToggle(Pages.SETTINGS,"Notification Toggle", function(v) Config.Notifications = v end) CreateToggle(Pages.SETTINGS,"Theme Neon Toggle", function(v) Config.ThemeNeon = v end) CreateDropdown(Pages.SETTINGS,"Accent Color Switch")

local dragging, dragInput, dragStart, startPos Main.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true dragStart = input.Position startPos = Main.Position end end)

UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStart Tween(Main,{Position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X,startPos.Y.Scale,startPos.Y.Offset + delta.Y)},0.05) end end)

UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

MinBtn.MouseButton1Click:Connect(function() Main.Visible = false Restore.Visible = true end)

Restore.MouseButton1Click:Connect(function() Main.Visible = true Restore.Visible = false end)

RunService.RenderStepped:Connect(function() Config.AccentHue = (Config.AccentHue + 0.002) % 1 local c = AccentColor() MainStroke.Color = c LoadStroke.Color = c Bar.BackgroundColor3 = c local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString() local fps = math.floor(1/RunService.RenderStepped:Wait()) ServerInfo.Text = "Ping: "..ping.."\nFPS: "..fps.."\nServer ID: "..game.JobId.."\nPlayers: "..#Players:GetPlayers() end)

for i = 1,100 do LoadText.Text = "PhuBaby Dev Loading "..i.."%" Bar.Size = UDim2.new(i/100,0,1,0) task.wait(0.02) end

Loading:Destroy() Main.Visible = true Notify("PhuBaby Dev Loaded Successfully") Notify("Run Script By Nguyễn Thanh Phú")

-- loadstring(game:HttpGet("YOUR_RAW_LINK"))()

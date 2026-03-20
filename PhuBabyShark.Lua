-- PhuBaby Dev Premium GUI Framework (Loadstring Ready) -- Premium UI Framework for private game framework / placeholder modules -- Run Script By Nguyễn Thanh Phú

local Players = game:GetService("Players") local TweenService = game:GetService("TweenService") local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local StarterGui = game:GetService("StarterGui") local LocalPlayer = Players.LocalPlayer local Mouse = LocalPlayer:GetMouse()

local Framework = {} local Theme = { Hue = 0, Accent = Color3.fromHSV(0,1,1), Background = Color3.fromRGB(10,10,10), Secondary = Color3.fromRGB(18,18,18), Text = Color3.fromRGB(255,255,255) }

local function Notify(title,text) pcall(function() StarterGui:SetCore("SendNotification",{ Title = title, Text = text, Duration = 3 }) end) end

RunService.RenderStepped:Connect(function() Theme.Hue = (tick()*0.15)%1 Theme.Accent = Color3.fromHSV(Theme.Hue,1,1) end)

local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "PhuBabyDev" ScreenGui.ResetOnSpawn = false ScreenGui.Parent = game.CoreGui

local Loading = Instance.new("Frame",ScreenGui) Loading.Size = UDim2.new(0,360,0,140) Loading.Position = UDim2.new(0.5,-180,0.5,-70) Loading.BackgroundColor3 = Theme.Background Loading.BorderSizePixel = 0 Loading.AnchorPoint = Vector2.new(0,0) Instance.new("UICorner",Loading).CornerRadius = UDim.new(0,16)

local LoadBarBG = Instance.new("Frame",Loading) LoadBarBG.Size = UDim2.new(0,320,0,12) LoadBarBG.Position = UDim2.new(0,20,0,90) LoadBarBG.BackgroundColor3 = Theme.Secondary LoadBarBG.BorderSizePixel = 0 Instance.new("UICorner",LoadBarBG).CornerRadius = UDim.new(1,0)

local LoadBar = Instance.new("Frame",LoadBarBG) LoadBar.Size = UDim2.new(0,0,1,0) LoadBar.BorderSizePixel = 0 LoadBar.BackgroundColor3 = Theme.Accent Instance.new("UICorner",LoadBar).CornerRadius = UDim.new(1,0)

local LoadText = Instance.new("TextLabel",Loading) LoadText.Size = UDim2.new(1,0,0,30) LoadText.Position = UDim2.new(0,0,0,25) LoadText.BackgroundTransparency = 1 LoadText.Text = "Loading 0%" LoadText.TextColor3 = Theme.Text LoadText.Font = Enum.Font.GothamBold LoadText.TextSize = 18

for i=1,100 do LoadBar.Size = UDim2.new(i/100,0,1,0) LoadBar.BackgroundColor3 = Theme.Accent LoadText.Text = "Loading "..i.."%" task.wait(0.02) end

Loading:Destroy() Notify("PhuBaby Dev Loaded Successfully","Run Script By Nguyễn Thanh Phú")

local Main = Instance.new("Frame",ScreenGui) Main.Size = UDim2.new(0,620,0,420) Main.Position = UDim2.new(0.5,-310,0.5,-210) Main.BackgroundColor3 = Theme.Background Main.BorderSizePixel = 0 Instance.new("UICorner",Main).CornerRadius = UDim.new(0,18)

local Stroke = Instance.new("UIStroke",Main) Stroke.Thickness = 2

RunService.RenderStepped:Connect(function() Stroke.Color = Theme.Accent end)

local Top = Instance.new("Frame",Main) Top.Size = UDim2.new(1,0,0,42) Top.BackgroundColor3 = Theme.Secondary Top.BorderSizePixel = 0 Instance.new("UICorner",Top).CornerRadius = UDim.new(0,18)

local Title = Instance.new("TextLabel",Top) Title.Size = UDim2.new(1,-80,1,0) Title.Position = UDim2.new(0,15,0,0) Title.BackgroundTransparency = 1 Title.Text = "PhuBaby Dev" Title.TextColor3 = Color3.new(1,1,1) Title.Font = Enum.Font.GothamBold Title.TextSize = 18 Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton",Top) MinBtn.Size = UDim2.new(0,32,0,28) MinBtn.Position = UDim2.new(1,-40,0,7) MinBtn.Text = "+" MinBtn.Font = Enum.Font.GothamBold MinBtn.TextSize = 18 MinBtn.BackgroundColor3 = Theme.Secondary MinBtn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner",MinBtn).CornerRadius = UDim.new(1,0)

local OpenBtn = Instance.new("TextButton",ScreenGui) OpenBtn.Size = UDim2.new(0,42,0,42) OpenBtn.Position = UDim2.new(0,30,0.5,0) OpenBtn.Text = "-" OpenBtn.Visible = false OpenBtn.Font = Enum.Font.GothamBold OpenBtn.TextSize = 20 OpenBtn.BackgroundColor3 = Theme.Background OpenBtn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner",OpenBtn).CornerRadius = UDim.new(1,0)

MinBtn.MouseButton1Click:Connect(function() Main.Visible = false OpenBtn.Visible = true end)

OpenBtn.MouseButton1Click:Connect(function() Main.Visible = true OpenBtn.Visible = false end)

local dragging, dragInput, dragStart, startPos Top.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true dragStart = input.Position startPos = Main.Position input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end) end end)

Top.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)

UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then local delta = input.Position - dragStart TweenService:Create(Main,TweenInfo.new(0.08),{ Position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X,startPos.Y.Scale,startPos.Y.Offset + delta.Y) }):Play() end end)

local Tabs = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"} local TabButtons = Instance.new("Frame",Main) TabButtons.Size = UDim2.new(0,130,1,-52) TabButtons.Position = UDim2.new(0,10,0,48) TabButtons.BackgroundTransparency = 1

local Content = Instance.new("Frame",Main) Content.Size = UDim2.new(1,-150,1,-60) Content.Position = UDim2.new(0,140,0,50) Content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout",TabButtons) layout.Padding = UDim.new(0,8)

local Pages = {} for _,name in ipairs(Tabs) do local b = Instance.new("TextButton",TabButtons) b.Size = UDim2.new(1,0,0,42) b.Text = name b.Font = Enum.Font.GothamBold b.TextSize = 14 b.BackgroundColor3 = Theme.Secondary b.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner",b).CornerRadius = UDim.new(0,12)

local page = Instance.new("ScrollingFrame",Content)
page.Size = UDim2.new(1,0,1,0)
page.CanvasSize = UDim2.new(0,0,0,800)
page.ScrollBarThickness = 4
page.Visible = false
page.BackgroundTransparency = 1

local pl = Instance.new("UIListLayout",page)
pl.Padding = UDim.new(0,8)

Pages[name] = page

b.MouseButton1Click:Connect(function()
    for _,p in pairs(Pages) do p.Visible = false end
    page.Visible = true
end)

end Pages["MAIN"].Visible = true

local function Toggle(parent,text) local f = Instance.new("Frame",parent) f.Size = UDim2.new(1,-10,0,44) f.BackgroundColor3 = Theme.Secondary Instance.new("UICorner",f).CornerRadius = UDim.new(0,12)

local l = Instance.new("TextLabel",f)
l.Size = UDim2.new(0.7,0,1,0)
l.Position = UDim2.new(0,12,0,0)
l.BackgroundTransparency = 1
l.Text = text
l.TextColor3 = Color3.new(1,1,1)
l.Font = Enum.Font.Gotham
l.TextXAlignment = Enum.TextXAlignment.Left

local t = Instance.new("TextButton",f)
t.Size = UDim2.new(0,52,0,24)
t.Position = UDim2.new(1,-64,0.5,-12)
t.Text = "OFF"
t.BackgroundColor3 = Color3.fromRGB(150,0,0)
t.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",t).CornerRadius = UDim.new(1,0)

local state = false
t.MouseButton1Click:Connect(function()
    state = not state
    t.Text = state and "ON" or "OFF"
    t.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(150,0,0)
    Notify(state and "[ ON ] Function Enabled" or "[ OFF ] Function Disabled",text)
end)

end

local function Slider(parent,text,min,max,default) local f = Instance.new("Frame",parent) f.Size = UDim2.new(1,-10,0,60) f.BackgroundColor3 = Theme.Secondary Instance.new("UICorner",f).CornerRadius = UDim.new(0,12)

local lbl = Instance.new("TextLabel",f)
lbl.Size = UDim2.new(1,-20,0,20)
lbl.Position = UDim2.new(0,10,0,5)
lbl.BackgroundTransparency = 1
lbl.Text = text..": "..default
lbl.TextColor3 = Color3.new(1,1,1)
lbl.Font = Enum.Font.Gotham
lbl.TextXAlignment = Enum.TextXAlignment.Left

local bar = Instance.new("Frame",f)
bar.Size = UDim2.new(1,-20,0,8)
bar.Position = UDim2.new(0,10,0,38)
bar.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner",bar).CornerRadius = UDim.new(1,0)

local fill = Instance.new("Frame",bar)
fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
fill.BackgroundColor3 = Theme.Accent
Instance.new("UICorner",fill).CornerRadius = UDim.new(1,0)

local draggingSlider = false
bar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSlider = true end
end)
bar.InputEnded:Connect(function() draggingSlider = false end)

UserInputService.InputChanged:Connect(function(i)
    if draggingSlider then
        local x = math.clamp((i.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
        fill.Size = UDim2.new(x,0,1,0)
        local val = math.floor(min + ((max-min)*x))
        lbl.Text = text..": "..val
    end
end)

end

Toggle(Pages["MAIN"],"Hitbox Module Placeholder") Slider(Pages["MAIN"],"Hitbox Size",1,20,5) Toggle(Pages["MAIN"],"MultiJump Module Placeholder") Toggle(Pages["MAIN"],"Aura Module Placeholder") Toggle(Pages["MAIN"],"ShiftLock Module Placeholder") Slider(Pages["MAIN"],"FOV Size",50,500,150)

for _,n in ipairs({"Rainbow Visual Outline","Red Box Visual","Name Display","Auto Module Placeholder"}) do Toggle(Pages["ESP"],n) end

Toggle(Pages["PLAYER"],"Dropdown Placeholder") Toggle(Pages["PLAYER"],"Action Button Placeholder") Toggle(Pages["PLAYER"],"Refresh Button")

Toggle(Pages["SERVER"],"Ping") Toggle(Pages["SERVER"],"FPS") Toggle(Pages["SERVER"],"Server ID") Toggle(Pages["SERVER"],"Player Count")

Toggle(Pages["SETTINGS"],"Vietnamese") Toggle(Pages["SETTINGS"],"English") Toggle(Pages["SETTINGS"],"Notification") Toggle(Pages["SETTINGS"],"Theme Neon")

RunService.RenderStepped:Connect(function() Stroke.Color = Theme.Accent LoadBar.BackgroundColor3 = Theme.Accent end)

--// PHUBABY DEV FIX FULL
--// Run Script By Nguyễn Thanh Phú

pcall(function()
    if game.CoreGui:FindFirstChild("PhuBabyDev") then
        game.CoreGui.PhuBabyDev:Destroy()
    end
end)

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- GUI ROOT
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDev"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 700, 0, 420)
Main.Position = UDim2.new(0.5, -350, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0,16)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 2

-- NEON LOOP
RunService.RenderStepped:Connect(function()
    Stroke.Color = Color3.fromHSV((tick()%5)/5,1,1)
end)

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.new(1,1,1)

-- TAB HOLDER
local TabHolder = Instance.new("Frame")
TabHolder.Parent = Main
TabHolder.Size = UDim2.new(0,140,1,-50)
TabHolder.Position = UDim2.new(0,0,0,50)
TabHolder.BackgroundTransparency = 1

-- CONTENT
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Size = UDim2.new(1,-150,1,-60)
Content.Position = UDim2.new(0,150,0,55)
Content.BackgroundTransparency = 1

local tabs = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}
local pages = {}

for i,v in pairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Parent = TabHolder
    btn.Size = UDim2.new(1,-10,0,45)
    btn.Position = UDim2.new(0,5,0,(i-1)*50)
    btn.Text = v
    btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    Instance.new("UICorner",btn)

    local page = Instance.new("ScrollingFrame")
    page.Parent = Content
    page.Size = UDim2.new(1,0,1,0)
    page.CanvasSize = UDim2.new(0,0,0,800)
    page.ScrollBarThickness = 4
    page.BackgroundTransparency = 1
    page.Visible = false

    pages[v] = page

    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do
            p.Visible = false
        end
        page.Visible = true
    end)
end

pages["MAIN"].Visible = true

-- TOGGLE FUNCTION
local function CreateToggle(parent,text,y)
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.Size = UDim2.new(0,300,0,40)
    b.Position = UDim2.new(0,10,0,y)
    b.BackgroundColor3 = Color3.fromRGB(120,0,0)
    b.Text = text.." [OFF]"
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner",b)

    local state = false

    b.MouseButton1Click:Connect(function()
        state = not state
        if state then
            b.BackgroundColor3 = Color3.fromRGB(0,120,0)
            b.Text = text.." [ON]"
        else
            b.BackgroundColor3 = Color3.fromRGB(120,0,0)
            b.Text = text.." [OFF]"
        end
    end)
end

-- MAIN CONTENT
CreateToggle(pages["MAIN"],"Hitbox Module Placeholder",20)
CreateToggle(pages["MAIN"],"MultiJump Module Placeholder",80)
CreateToggle(pages["MAIN"],"Aura Module Placeholder",140)
CreateToggle(pages["MAIN"],"ShiftLock Module Placeholder",200)

-- SERVER INFO
local info = Instance.new("TextLabel")
info.Parent = pages["SERVER"]
info.Size = UDim2.new(0,350,0,120)
info.Position = UDim2.new(0,10,0,20)
info.BackgroundColor3 = Color3.fromRGB(15,15,15)
info.TextColor3 = Color3.new(1,1,1)
info.Font = Enum.Font.GothamBold
info.TextSize = 15
Instance.new("UICorner",info)

RunService.RenderStepped:Connect(function()
    info.Text =
        "Ping: "..math.random(20,80)..
        "\nFPS: "..math.random(58,60)..
        "\nPlayers: "..#Players:GetPlayers()
end)

-- DRAG SYSTEM
local dragging = false
local dragInput, dragStart, startPos

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)Instance.new("UICorner",LoadingFrame).CornerRadius = UDim.new(0,18)

local LoadingBarBG = Instance.new("Frame")
LoadingBarBG.Size = UDim2.new(0,360,0,18)
LoadingBarBG.Position = UDim2.new(0.5,-180,0.65,0)
LoadingBarBG.BackgroundColor3 = Color3.fromRGB(30,30,30)
LoadingBarBG.Parent = LoadingFrame
Instance.new("UICorner",LoadingBarBG).CornerRadius = UDim.new(1,0)

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0,0,1,0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0,255,255)
LoadingBar.Parent = LoadingBarBG
Instance.new("UICorner",LoadingBar).CornerRadius = UDim.new(1,0)

local Percent = Instance.new("TextLabel")
Percent.Size = UDim2.new(1,0,0,40)
Percent.Position = UDim2.new(0,0,0.25,0)
Percent.BackgroundTransparency = 1
Percent.Text = "1%"
Percent.TextColor3 = Color3.new(1,1,1)
Percent.Font = Enum.Font.GothamBold
Percent.TextSize = 28
Percent.Parent = LoadingFrame

for i=1,100 do
    Percent.Text = i.."%"
    TweenService:Create(LoadingBar,TweenInfo.new(0.02),{
        Size = UDim2.new(i/100,0,1,0)
    }):Play()
    task.wait(0.02)
end

task.wait(0.3)
LoadingFrame:Destroy()

--====================================================
-- MAIN WINDOW
--====================================================

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,720,0,450)
Main.Position = UDim2.new(0.5,-360,0.5,-225)
Main.BackgroundColor3 = Color3.fromRGB(12,12,12)
Main.Parent = ScreenGui
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,18)

local Stroke = Instance.new("UIStroke",Main)
Stroke.Thickness = 2

RunService.RenderStepped:Connect(function()
    Stroke.Color = NeonColor()
end)

--====================================================
-- TITLE
--====================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = Main

--====================================================
-- NOTIFICATION MODULE
--====================================================

local function Notify(text)
    local N = Instance.new("TextLabel")
    N.Size = UDim2.new(0,320,0,45)
    N.Position = UDim2.new(1,-340,0,20)
    N.BackgroundColor3 = Color3.fromRGB(15,15,15)
    N.Text = text
    N.TextColor3 = Color3.new(1,1,1)
    N.Font = Enum.Font.GothamBold
    N.TextSize = 18
    N.Parent = ScreenGui
    Instance.new("UICorner",N).CornerRadius = UDim.new(0,12)

    TweenService:Create(N,TweenInfo.new(0.4),{
        Position = UDim2.new(1,-340,0,70)
    }):Play()

    task.wait(2)

    TweenService:Create(N,TweenInfo.new(0.4),{
        Position = UDim2.new(1,50,0,70)
    }):Play()

    task.wait(0.4)
    N:Destroy()
end

Notify("PhuBaby Dev Loaded Successfully")
Notify("Run Script By Nguyễn Thanh Phú")

--====================================================
-- TAB SYSTEM
--====================================================

local Tabs = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}
local TabHolder = Instance.new("Frame")
TabHolder.Size = UDim2.new(0,140,1,-50)
TabHolder.Position = UDim2.new(0,0,0,50)
TabHolder.BackgroundTransparency = 1
TabHolder.Parent = Main

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-150,1,-60)
Content.Position = UDim2.new(0,150,0,55)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Pages = {}

for i,v in pairs(Tabs) do
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,-10,0,45)
    Btn.Position = UDim2.new(0,5,0,(i-1)*50)
    Btn.Text = v
    Btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 16
    Btn.Parent = TabHolder
    Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,10)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1,0,1,0)
    Page.CanvasSize = UDim2.new(0,0,0,900)
    Page.ScrollBarThickness = 4
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.Parent = Content
    Pages[v] = Page

    Btn.MouseButton1Click:Connect(function()
        for _,p in pairs(Pages) do
            p.Visible = false
        end
        Page.Visible = true
    end)
end

Pages["MAIN"].Visible = true

--====================================================
-- TOGGLE MODULE
--====================================================

local function CreateToggle(parent,text,posY)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0,300,0,40)
    Toggle.Position = UDim2.new(0,10,0,posY)
    Toggle.BackgroundColor3 = Color3.fromRGB(40,0,0)
    Toggle.Text = text.." [ OFF ]"
    Toggle.TextColor3 = Color3.new(1,1,1)
    Toggle.Font = Enum.Font.GothamBold
    Toggle.TextSize = 15
    Toggle.Parent = parent
    Instance.new("UICorner",Toggle).CornerRadius = UDim.new(0,10)

    local state = false

    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Toggle.BackgroundColor3 = state and Color3.fromRGB(0,120,0) or Color3.fromRGB(120,0,0)
        Toggle.Text = text..(state and " [ ON ]" or " [ OFF ]")
        Notify((state and "[ ON ] " or "[ OFF ] ")..text)
    end)
end

--====================================================
-- SLIDER MODULE
--====================================================

local function CreateSlider(parent,text,posY,min,max)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0,320,0,60)
    Frame.Position = UDim2.new(0,10,0,posY)
    Frame.BackgroundTransparency = 1
    Frame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1,0,0,20)
    Label.BackgroundTransparency = 1
    Label.Text = text..": "..min
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.Parent = Frame

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1,0,0,10)
    Bar.Position = UDim2.new(0,0,0,35)
    Bar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Bar.Parent = Frame
    Instance.new("UICorner",Bar)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(0,0,1,0)
    Fill.BackgroundColor3 = Color3.fromRGB(0,255,255)
    Fill.Parent = Bar
    Instance.new("UICorner",Fill)

    local Drag = false

    Bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            Drag = true
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            Drag = false
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if Drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local x = math.clamp((i.Position.X-Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X,0,1)
            Fill.Size = UDim2.new(x,0,1,0)
            local val = math.floor(min+(max-min)*x)
            Label.Text = text..": "..val
        end
    end)
end

--====================================================
-- MAIN TAB
--====================================================

CreateToggle(Pages["MAIN"],"Hitbox Module Placeholder",20)
CreateSlider(Pages["MAIN"],"Hitbox Size",80,1,20)
CreateToggle(Pages["MAIN"],"MultiJump Module Placeholder",160)
CreateToggle(Pages["MAIN"],"Aura Module Placeholder",220)
CreateToggle(Pages["MAIN"],"ShiftLock Module Placeholder",280)
CreateSlider(Pages["MAIN"],"FOV Size",340,50,500)

--====================================================
-- ESP TAB
--====================================================

CreateToggle(Pages["ESP"],"Rainbow Visual Outline",20)
CreateToggle(Pages["ESP"],"Red Box Visual",80)
CreateToggle(Pages["ESP"],"Name Display",140)
CreateToggle(Pages["ESP"],"Auto Module Placeholder",200)

--====================================================
-- PLAYER TAB
--====================================================

local Dropdown = Instance.new("TextButton")
Dropdown.Size = UDim2.new(0,320,0,40)
Dropdown.Position = UDim2.new(0,10,0,20)
Dropdown.Text = "Select Player ▼"
Dropdown.BackgroundColor3 = Color3.fromRGB(20,20,20)
Dropdown.TextColor3 = Color3.new(1,1,1)
Dropdown.Parent = Pages["PLAYER"]
Instance.new("UICorner",Dropdown)

--====================================================
-- SERVER TAB
--====================================================

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(0,400,0,120)
Info.Position = UDim2.new(0,10,0,20)
Info.BackgroundColor3 = Color3.fromRGB(15,15,15)
Info.TextColor3 = Color3.new(1,1,1)
Info.Font = Enum.Font.GothamBold
Info.TextSize = 16
Info.Parent = Pages["SERVER"]
Instance.new("UICorner",Info)

RunService.RenderStepped:Connect(function()
    Info.Text =
        "Ping: "..math.random(20,80)..
        "\nFPS: "..math.random(58,60)..
        "\nServer ID: "..game.JobId..
        "\nPlayer Count: "..#Players:GetPlayers()
end)

--====================================================
-- SETTINGS TAB
--====================================================

CreateToggle(Pages["SETTINGS"],"Notification Toggle",20)
CreateToggle(Pages["SETTINGS"],"Theme Neon Toggle",80)

--====================================================
-- DRAG SYSTEM
--====================================================

local dragToggle = nil
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragToggle then
        updateInput(input)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = false
    end
end)local MinBtn = Instance.new("TextButton",Top) MinBtn.Size = UDim2.new(0,32,0,28) MinBtn.Position = UDim2.new(1,-40,0,7) MinBtn.Text = "+" MinBtn.Font = Enum.Font.GothamBold MinBtn.TextSize = 18 MinBtn.BackgroundColor3 = Theme.Secondary MinBtn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner",MinBtn).CornerRadius = UDim.new(1,0)

local OpenBtn = Instance.new("TextButton") OpenBtn.Parent = ScreenGui OpenBtn.ZIndex = 20 OpenBtn.Size = UDim2.new(0,42,0,42) OpenBtn.Position = UDim2.new(0,30,0.5,0) OpenBtn.Text = "-" OpenBtn.Visible = false OpenBtn.Font = Enum.Font.GothamBold OpenBtn.TextSize = 20 OpenBtn.BackgroundColor3 = Theme.Background OpenBtn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner",OpenBtn).CornerRadius = UDim.new(1,0)

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

RunService.RenderStepped:Connect(function() Stroke.Color = Theme.Accent end)

for _,obj in ipairs(ScreenGui:GetDescendants()) do if obj:IsA("TextLabel") or obj:IsA("TextButton") then obj.ZIndex = 6 elseif obj:IsA("Frame") then if obj ~= Main and obj ~= Loading then obj.ZIndex = 5 end end end

Main.Visible = truelocal MinBtn = Instance.new("TextButton",Top) MinBtn.Size = UDim2.new(0,32,0,28) MinBtn.Position = UDim2.new(1,-40,0,7) MinBtn.Text = "+" MinBtn.Font = Enum.Font.GothamBold MinBtn.TextSize = 18 MinBtn.BackgroundColor3 = Theme.Secondary MinBtn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner",MinBtn).CornerRadius = UDim.new(1,0)

local OpenBtn = Instance.new("TextButton") OpenBtn.Parent = ScreenGui OpenBtn.ZIndex = 20 OpenBtn.Size = UDim2.new(0,42,0,42) OpenBtn.Position = UDim2.new(0,30,0.5,0) OpenBtn.Text = "-" OpenBtn.Visible = false OpenBtn.Font = Enum.Font.GothamBold OpenBtn.TextSize = 20 OpenBtn.BackgroundColor3 = Theme.Background OpenBtn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner",OpenBtn).CornerRadius = UDim.new(1,0)

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

RunService.RenderStepped:Connect(function() Stroke.Color = Theme.Accent end)

for _,obj in ipairs(ScreenGui:GetDescendants()) do if obj:IsA("TextLabel") or obj:IsA("TextButton") then obj.ZIndex = 6 elseif obj:IsA("Frame") then if obj ~= Main and obj ~= Loading then obj.ZIndex = 5 end end end

Main.Visible = truelocal function Tween(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDev"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local NotificationHolder = Instance.new("Frame", ScreenGui)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.Position = UDim2.new(1,-320,0,20)
NotificationHolder.Size = UDim2.new(0,300,0,200)

local function Notify(text)
    if not Config.Notifications then return end
    local box = Instance.new("Frame", NotificationHolder)
    box.Size = UDim2.new(1,0,0,40)
    box.BackgroundColor3 = Color3.fromRGB(15,15,15)
    box.TabBar.BorderSizePixel = 0
    local corner = Instance.new("UICorner", box)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = AccentColor()

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

local Loading = Instance.new("Frame", ScreenGui)
Loading.Size = UDim2.new(0,420,0,180)
Loading.Position = UDim2.new(0.5,-210,0.5,-90)
Loading.BackgroundColor3 = Color3.fromRGB(10,10,10)
Loading.BorderSizePixel = 0
Instance.new("UICorner", Loading).CornerRadius = UDim.new(0,14)

local LoadStroke = Instance.new("UIStroke", Loading)
LoadStroke.Thickness = 2

local LoadText = Instance.new("TextLabel", Loading)
LoadText.Size = UDim2.new(1,0,0,50)
LoadText.BackgroundTransparency = 1
LoadText.Text = "PhuBaby Dev Loading 0%"
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 18
LoadText.TextColor3 = Color3.new(1,1,1)

local BarBg = Instance.new("Frame", Loading)
BarBg.Size = UDim2.new(0.85,0,0,14)
BarBg.Position = UDim2.new(0.075,0,0.62,0)
BarBg.BackgroundColor3 = Color3.fromRGB(30,30,30)
BarBg.BorderSizePixel = 0
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1,0)

local Bar = Instance.new("Frame", BarBg)
Bar.Size = UDim2.new(0,0,1,0)
Bar.BorderSizePixel = 0
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

local Main = Instance.new("Frame", ScreenGui)
Main.Visible = false
Main.Size = UDim2.new(0,650,0,420)
Main.Position = UDim2.new(0.5,-325,0.5,-210)
Main.BackgroundColor3 = Color3.fromRGB(8,8,8)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.new(1,1,1)

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0,35,0,35)
MinBtn.Position = UDim2.new(1,-45,0,5)
MinBtn.Text = "+"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
MinBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MinBtn)

local Restore = Instance.new("TextButton", ScreenGui)
Restore.Visible = false
Restore.Size = UDim2.new(0,50,0,50)
Restore.Position = UDim2.new(0,20,0.5,0)
Restore.Text = "-"
Restore.Font = Enum.Font.GothamBold
Restore.TextSize = 22
Restore.BackgroundColor3 = Color3.fromRGB(10,10,10)
Restore.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Restore)

local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(0,130,1,-50)
TabBar.Position = UDim2.new(0,0,0,50)
TabBar.BackgroundColor3 = Color3.fromRGB(12,12,12)
BorderSizePixel = 0

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1,-140,1,-60)
Content.Position = UDim2.new(0,135,0,55)
Content.BackgroundTransparency = 1

local Tabs = {}
local Pages = {}
local tabNames = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}

for i,name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(1,-10,0,45)
    btn.Position = UDim2.new(0,5,0,(i-1)*50)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(18,18,18)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    Tabs[name] = btn

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

local function CreateToggle(parent, text, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,-10,0,50)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", frame)

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

local function CreateSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,-10,0,70)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", frame)

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

local function CreateDropdown(parent, text)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,-10,0,50)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", frame)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,0,1,0)
    btn.Text = text.." ▼"
    btn.BackgroundTransparency = 1
    btn.TextColor3 = Color3.new(1,1,1)
end

CreateToggle(Pages.MAIN,"Hitbox Module Placeholder", function(v) State.Hitbox = v end)
CreateSlider(Pages.MAIN,"Hitbox Size",1,20,5,function(v) end)
CreateToggle(Pages.MAIN,"MultiJump Module Placeholder", function(v) State.MultiJump = v end)
CreateToggle(Pages.MAIN,"Aura Module Placeholder", function(v) State.Aura = v end)
CreateToggle(Pages.MAIN,"ShiftLock Module Placeholder", function(v) State.ShiftLock = v end)
CreateSlider(Pages.MAIN,"FOV Size",50,500,120,function(v) State.FOV = v end)

CreateToggle(Pages.ESP,"Rainbow Visual Outline", function() end)
CreateToggle(Pages.ESP,"Red Box Visual", function() end)
CreateToggle(Pages.ESP,"Name Display", function() end)
CreateToggle(Pages.ESP,"Auto Module Placeholder", function() end)

CreateDropdown(Pages.PLAYER,"Player List")
CreateToggle(Pages.PLAYER,"Action Placeholder", function() end)
CreateToggle(Pages.PLAYER,"Refresh Players", function() end)

local ServerInfo = Instance.new("TextLabel", Pages.SERVER)
ServerInfo.Size = UDim2.new(1,-10,0,120)
ServerInfo.BackgroundColor3 = Color3.fromRGB(15,15,15)
ServerInfo.TextColor3 = Color3.new(1,1,1)
ServerInfo.Font = Enum.Font.GothamBold
ServerInfo.TextSize = 14
ServerInfo.TextYAlignment = Enum.TextYAlignment.Top
Instance.new("UICorner", ServerInfo)

CreateDropdown(Pages.SETTINGS,"Language: Vietnamese / English")
CreateToggle(Pages.SETTINGS,"Notification Toggle", function(v) Config.Notifications = v end)
CreateToggle(Pages.SETTINGS,"Theme Neon Toggle", function(v) Config.ThemeNeon = v end)
CreateDropdown(Pages.SETTINGS,"Accent Color Switch")

local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Tween(Main,{Position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X,startPos.Y.Scale,startPos.Y.Offset + delta.Y)},0.05)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Restore.Visible = true
end)

Restore.MouseButton1Click:Connect(function()
    Main.Visible = true
    Restore.Visible = false
end)

RunService.RenderStepped:Connect(function()
    Config.AccentHue = (Config.AccentHue + 0.002) % 1
    local c = AccentColor()
    MainStroke.Color = c
    LoadStroke.Color = c
    Bar.BackgroundColor3 = c
    local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    local fps = math.floor(workspace:GetRealPhysicsFPS())
    ServerInfo.Text = "Ping: "..ping.."\nFPS: "..fps.."\nServer ID: "..game.JobId.."\nPlayers: "..#Players:GetPlayers()
end)

for i = 1,100 do
    LoadText.Text = "PhuBaby Dev Loading "..i.."%"
    Bar.Size = UDim2.new(i/100,0,1,0)
    task.wait(0.02)
end

Loading:Destroy()
Main.Visible = true
Notify("PhuBaby Dev Loaded Successfully")
Notify("Run Script By Nguyễn Thanh Phú")

-- loadstring(game:HttpGet("YOUR_RAW_LINK"))()
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDev"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Loading = Instance.new("Frame",ScreenGui)
Loading.Size = UDim2.new(0,360,0,140)
Loading.Position = UDim2.new(0.5,-180,0.5,-70)
Loading.BackgroundColor3 = Theme.Background
Loading.BorderSizePixel = 0
Loading.AnchorPoint = Vector2.new(0,0)
Instance.new("UICorner",Loading).CornerRadius = UDim.new(0,16)

local LoadBarBG = Instance.new("Frame",Loading)
LoadBarBG.Size = UDim2.new(0,320,0,12)
LoadBarBG.Position = UDim2.new(0,20,0,90)
LoadBarBG.BackgroundColor3 = Theme.Secondary
LoadBarBG.BorderSizePixel = 0
Instance.new("UICorner",LoadBarBG).CornerRadius = UDim.new(1,0)

local LoadBar = Instance.new("Frame",LoadBarBG)
LoadBar.Size = UDim2.new(0,0,1,0)
LoadBar.BorderSizePixel = 0
LoadBar.BackgroundColor3 = Theme.Accent
Instance.new("UICorner",LoadBar).CornerRadius = UDim.new(1,0)

local LoadText = Instance.new("TextLabel",Loading)
LoadText.Size = UDim2.new(1,0,0,30)
LoadText.Position = UDim2.new(0,0,0,25)
LoadText.BackgroundTransparency = 1
LoadText.Text = "Loading 0%"
LoadText.TextColor3 = Theme.Text
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 18

for i=1,100 do
    LoadBar.Size = UDim2.new(i/100,0,1,0)
    LoadBar.BackgroundColor3 = Theme.Accent
    LoadText.Text = "Loading "..i.."%"
    task.wait(0.02)
end

Loading:Destroy()
Notify("PhuBaby Dev Loaded Successfully","Run Script By Nguyễn Thanh Phú")

local Main = Instance.new("Frame",ScreenGui)
Main.Size = UDim2.new(0,620,0,420)
Main.Position = UDim2.new(0.5,-310,0.5,-210)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,18)

local Stroke = Instance.new("UIStroke",Main)
Stroke.Thickness = 2

RunService.RenderStepped:Connect(function()
    Stroke.Color = Theme.Accent
end)

local Top = Instance.new("Frame",Main)
Top.Size = UDim2.new(1,0,0,42)
Top.BackgroundColor3 = Theme.Secondary
Top.BorderSizePixel = 0
Instance.new("UICorner",Top).CornerRadius = UDim.new(0,18)

local Title = Instance.new("TextLabel",Top)
Title.Size = UDim2.new(1,-80,1,0)
Title.Position = UDim2.new(0,15,0,0)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton",Top)
MinBtn.Size = UDim2.new(0,32,0,28)
MinBtn.Position = UDim2.new(1,-40,0,7)
MinBtn.Text = "+"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.BackgroundColor3 = Theme.Secondary
MinBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",MinBtn).CornerRadius = UDim.new(1,0)

local OpenBtn = Instance.new("TextButton",ScreenGui)
OpenBtn.Size = UDim2.new(0,42,0,42)
OpenBtn.Position = UDim2.new(0,30,0.5,0)
OpenBtn.Text = "-"
OpenBtn.Visible = false
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 20
OpenBtn.BackgroundColor3 = Theme.Background
OpenBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",OpenBtn).CornerRadius = UDim.new(1,0)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)

local dragging, dragInput, dragStart, startPos
Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

Top.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        TweenService:Create(Main,TweenInfo.new(0.08),{
            Position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X,startPos.Y.Scale,startPos.Y.Offset + delta.Y)
        }):Play()
    end
end)

local Tabs = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}
local TabButtons = Instance.new("Frame",Main)
TabButtons.Size = UDim2.new(0,130,1,-52)
TabButtons.Position = UDim2.new(0,10,0,48)
TabButtons.BackgroundTransparency = 1

local Content = Instance.new("Frame",Main)
Content.Size = UDim2.new(1,-150,1,-60)
Content.Position = UDim2.new(0,140,0,50)
Content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout",TabButtons)
layout.Padding = UDim.new(0,8)

local Pages = {}
for _,name in ipairs(Tabs) do
    local b = Instance.new("TextButton",TabButtons)
    b.Size = UDim2.new(1,0,0,42)
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BackgroundColor3 = Theme.Secondary
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,12)

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
end
Pages["MAIN"].Visible = true

local function Toggle(parent,text)
    local f = Instance.new("Frame",parent)
    f.Size = UDim2.new(1,-10,0,44)
    f.BackgroundColor3 = Theme.Secondary
    Instance.new("UICorner",f).CornerRadius = UDim.new(0,12)

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

local function Slider(parent,text,min,max,default)
    local f = Instance.new("Frame",parent)
    f.Size = UDim2.new(1,-10,0,60)
    f.BackgroundColor3 = Theme.Secondary
    Instance.new("UICorner",f).CornerRadius = UDim.new(0,12)

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

Toggle(Pages["MAIN"],"Hitbox Module Placeholder")
Slider(Pages["MAIN"],"Hitbox Size",1,20,5)
Toggle(Pages["MAIN"],"MultiJump Module Placeholder")
Toggle(Pages["MAIN"],"Aura Module Placeholder")
Toggle(Pages["MAIN"],"ShiftLock Module Placeholder")
Slider(Pages["MAIN"],"FOV Size",50,500,150)

for _,n in ipairs({"Rainbow Visual Outline","Red Box Visual","Name Display","Auto Module Placeholder"}) do
    Toggle(Pages["ESP"],n)
end

Toggle(Pages["PLAYER"],"Dropdown Placeholder")
Toggle(Pages["PLAYER"],"Action Button Placeholder")
Toggle(Pages["PLAYER"],"Refresh Button")

Toggle(Pages["SERVER"],"Ping")
Toggle(Pages["SERVER"],"FPS")
Toggle(Pages["SERVER"],"Server ID")
Toggle(Pages["SERVER"],"Player Count")

Toggle(Pages["SETTINGS"],"Vietnamese")
Toggle(Pages["SETTINGS"],"English")
Toggle(Pages["SETTINGS"],"Notification")
Toggle(Pages["SETTINGS"],"Theme Neon")

RunService.RenderStepped:Connect(function()
    Stroke.Color = Theme.Accent
    LoadBar.BackgroundColor3 = Theme.Accent
end)
local function Tween(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDev"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local NotificationHolder = Instance.new("Frame", ScreenGui)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.Position = UDim2.new(1,-320,0,20)
NotificationHolder.Size = UDim2.new(0,300,0,200)

local function Notify(text)
    if not Config.Notifications then return end
    local box = Instance.new("Frame", NotificationHolder)
    box.Size = UDim2.new(1,0,0,40)
    box.BackgroundColor3 = Color3.fromRGB(15,15,15)
    box.BorderSizePixel = 0
    local corner = Instance.new("UICorner", box)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = AccentColor()

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

local Loading = Instance.new("Frame", ScreenGui)
Loading.Size = UDim2.new(0,420,0,180)
Loading.Position = UDim2.new(0.5,-210,0.5,-90)
Loading.BackgroundColor3 = Color3.fromRGB(10,10,10)
Loading.BorderSizePixel = 0
Instance.new("UICorner", Loading).CornerRadius = UDim.new(0,14)

local LoadStroke = Instance.new("UIStroke", Loading)
LoadStroke.Thickness = 2

local LoadText = Instance.new("TextLabel", Loading)
LoadText.Size = UDim2.new(1,0,0,50)
LoadText.BackgroundTransparency = 1
LoadText.Text = "PhuBaby Dev Loading 0%"
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 18
LoadText.TextColor3 = Color3.new(1,1,1)

local BarBg = Instance.new("Frame", Loading)
BarBg.Size = UDim2.new(0.85,0,0,14)
BarBg.Position = UDim2.new(0.075,0,0.62,0)
BarBg.BackgroundColor3 = Color3.fromRGB(30,30,30)
BarBg.BorderSizePixel = 0
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1,0)

local Bar = Instance.new("Frame", BarBg)
Bar.Size = UDim2.new(0,0,1,0)
Bar.BorderSizePixel = 0
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

local Main = Instance.new("Frame", ScreenGui)
Main.Visible = false
Main.Size = UDim2.new(0,650,0,420)
Main.Position = UDim2.new(0.5,-325,0.5,-210)
Main.BackgroundColor3 = Color3.fromRGB(8,8,8)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.new(1,1,1)

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0,35,0,35)
MinBtn.Position = UDim2.new(1,-45,0,5)
MinBtn.Text = "+"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
MinBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MinBtn)

local Restore = Instance.new("TextButton", ScreenGui)
Restore.Visible = false
Restore.Size = UDim2.new(0,50,0,50)
Restore.Position = UDim2.new(0,20,0.5,0)
Restore.Text = "-"
Restore.Font = Enum.Font.GothamBold
Restore.TextSize = 22
Restore.BackgroundColor3 = Color3.fromRGB(10,10,10)
Restore.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Restore)

local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(0,130,1,-50)
TabBar.Position = UDim2.new(0,0,0,50)
TabBar.BackgroundColor3 = Color3.fromRGB(12,12,12)
BorderSizePixel = 0

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1,-140,1,-60)
Content.Position = UDim2.new(0,135,0,55)
Content.BackgroundTransparency = 1

local Tabs = {}
local Pages = {}
local tabNames = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}

for i,name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(1,-10,0,45)
    btn.Position = UDim2.new(0,5,0,(i-1)*50)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(18,18,18)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    Tabs[name] = btn

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

local function CreateToggle(parent, text, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,-10,0,50)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", frame)

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

local function CreateSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,-10,0,70)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", frame)

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

local function CreateDropdown(parent, text)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,-10,0,50)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", frame)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,0,1,0)
    btn.Text = text.." ▼"
    btn.BackgroundTransparency = 1
    btn.TextColor3 = Color3.new(1,1,1)
end

CreateToggle(Pages.MAIN,"Hitbox Module Placeholder", function(v) State.Hitbox = v end)
CreateSlider(Pages.MAIN,"Hitbox Size",1,20,5,function(v) end)
CreateToggle(Pages.MAIN,"MultiJump Module Placeholder", function(v) State.MultiJump = v end)
CreateToggle(Pages.MAIN,"Aura Module Placeholder", function(v) State.Aura = v end)
CreateToggle(Pages.MAIN,"ShiftLock Module Placeholder", function(v) State.ShiftLock = v end)
CreateSlider(Pages.MAIN,"FOV Size",50,500,120,function(v) State.FOV = v end)

CreateToggle(Pages.ESP,"Rainbow Visual Outline", function() end)
CreateToggle(Pages.ESP,"Red Box Visual", function() end)
CreateToggle(Pages.ESP,"Name Display", function() end)
CreateToggle(Pages.ESP,"Auto Module Placeholder", function() end)

CreateDropdown(Pages.PLAYER,"Player List")
CreateToggle(Pages.PLAYER,"Action Placeholder", function() end)
CreateToggle(Pages.PLAYER,"Refresh Players", function() end)

local ServerInfo = Instance.new("TextLabel", Pages.SERVER)
ServerInfo.Size = UDim2.new(1,-10,0,120)
ServerInfo.BackgroundColor3 = Color3.fromRGB(15,15,15)
ServerInfo.TextColor3 = Color3.new(1,1,1)
ServerInfo.Font = Enum.Font.GothamBold
ServerInfo.TextSize = 14
ServerInfo.TextYAlignment = Enum.TextYAlignment.Top
Instance.new("UICorner", ServerInfo)

CreateDropdown(Pages.SETTINGS,"Language: Vietnamese / English")
CreateToggle(Pages.SETTINGS,"Notification Toggle", function(v) Config.Notifications = v end)
CreateToggle(Pages.SETTINGS,"Theme Neon Toggle", function(v) Config.ThemeNeon = v end)
CreateDropdown(Pages.SETTINGS,"Accent Color Switch")

local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Tween(Main,{Position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X,startPos.Y.Scale,startPos.Y.Offset + delta.Y)},0.05)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Restore.Visible = true
end)

Restore.MouseButton1Click:Connect(function()
    Main.Visible = true
    Restore.Visible = false
end)

RunService.RenderStepped:Connect(function()
    Config.AccentHue = (Config.AccentHue + 0.002) % 1
    local c = AccentColor()
    MainStroke.Color = c
    LoadStroke.Color = c
    Bar.BackgroundColor3 = c
    local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    local fps = math.floor(1/RunService.RenderStepped:Wait())
    ServerInfo.Text = "Ping: "..ping.."\nFPS: "..fps.."\nServer ID: "..game.JobId.."\nPlayers: "..#Players:GetPlayers()
end)

for i = 1,100 do
    LoadText.Text = "PhuBaby Dev Loading "..i.."%"
    Bar.Size = UDim2.new(i/100,0,1,0)
    task.wait(0.02)
end

Loading:Destroy()
Main.Visible = true
Notify("PhuBaby Dev Loaded Successfully")
Notify("Run Script By Nguyễn Thanh Phú")

-- loadstring(game:HttpGet("YOUR_RAW_LINK"))()
local function Tween(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDev"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local NotificationHolder = Instance.new("Frame", ScreenGui)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.Position = UDim2.new(1,-320,0,20)
NotificationHolder.Size = UDim2.new(0,300,0,200)

local function Notify(text)
    if not Config.Notifications then return end
    local box = Instance.new("Frame", NotificationHolder)
    box.Size = UDim2.new(1,0,0,40)
    box.BackgroundColor3 = Color3.fromRGB(15,15,15)
    box.BorderSizePixel = 0
    local corner = Instance.new("UICorner", box)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = AccentColor()

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

local Loading = Instance.new("Frame", ScreenGui)
Loading.Size = UDim2.new(0,420,0,180)
Loading.Position = UDim2.new(0.5,-210,0.5,-90)
Loading.BackgroundColor3 = Color3.fromRGB(10,10,10)
Loading.BorderSizePixel = 0
Instance.new("UICorner", Loading).CornerRadius = UDim.new(0,14)

local LoadStroke = Instance.new("UIStroke", Loading)
LoadStroke.Thickness = 2

local LoadText = Instance.new("TextLabel", Loading)
LoadText.Size = UDim2.new(1,0,0,50)
LoadText.BackgroundTransparency = 1
LoadText.Text = "PhuBaby Dev Loading 0%"
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 18
LoadText.TextColor3 = Color3.new(1,1,1)

local BarBg = Instance.new("Frame", Loading)
BarBg.Size = UDim2.new(0.85,0,0,14)
BarBg.Position = UDim2.new(0.075,0,0.62,0)
BarBg.BackgroundColor3 = Color3.fromRGB(30,30,30)
BarBg.BorderSizePixel = 0
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1,0)

local Bar = Instance.new("Frame", BarBg)
Bar.Size = UDim2.new(0,0,1,0)
Bar.BorderSizePixel = 0
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

local Main = Instance.new("Frame", ScreenGui)
Main.Visible = false
Main.Size = UDim2.new(0,650,0,420)
Main.Position = UDim2.new(0.5,-325,0.5,-210)
Main.BackgroundColor3 = Color3.fromRGB(8,8,8)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.new(1,1,1)

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0,35,0,35)
MinBtn.Position = UDim2.new(1,-45,0,5)
MinBtn.Text = "+"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
MinBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MinBtn)

local Restore = Instance.new("TextButton", ScreenGui)
Restore.Visible = false
Restore.Size = UDim2.new(0,50,0,50)
Restore.Position = UDim2.new(0,20,0.5,0)
Restore.Text = "-"
Restore.Font = Enum.Font.GothamBold
Restore.TextSize = 22
Restore.BackgroundColor3 = Color3.fromRGB(10,10,10)
Restore.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Restore)

local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(0,130,1,-50)
TabBar.Position = UDim2.new(0,0,0,50)
TabBar.BackgroundColor3 = Color3.fromRGB(12,12,12)
BorderSizePixel = 0

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1,-140,1,-60)
Content.Position = UDim2.new(0,135,0,55)
Content.BackgroundTransparency = 1

local Tabs = {}
local Pages = {}
local tabNames = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}

for i,name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(1,-10,0,45)
    btn.Position = UDim2.new(0,5,0,(i-1)*50)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(18,18,18)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    Tabs[name] = btn

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

local function CreateToggle(parent, text, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,-10,0,50)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", frame)

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

local function CreateSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,-10,0,70)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", frame)

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

local function CreateDropdown(parent, text)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,-10,0,50)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", frame)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,0,1,0)
    btn.Text = text.." ▼"
    btn.BackgroundTransparency = 1
    btn.TextColor3 = Color3.new(1,1,1)
end

CreateToggle(Pages.MAIN,"Hitbox Module Placeholder", function(v) State.Hitbox = v end)
CreateSlider(Pages.MAIN,"Hitbox Size",1,20,5,function(v) end)
CreateToggle(Pages.MAIN,"MultiJump Module Placeholder", function(v) State.MultiJump = v end)
CreateToggle(Pages.MAIN,"Aura Module Placeholder", function(v) State.Aura = v end)
CreateToggle(Pages.MAIN,"ShiftLock Module Placeholder", function(v) State.ShiftLock = v end)
CreateSlider(Pages.MAIN,"FOV Size",50,500,120,function(v) State.FOV = v end)

CreateToggle(Pages.ESP,"Rainbow Visual Outline", function() end)
CreateToggle(Pages.ESP,"Red Box Visual", function() end)
CreateToggle(Pages.ESP,"Name Display", function() end)
CreateToggle(Pages.ESP,"Auto Module Placeholder", function() end)

CreateDropdown(Pages.PLAYER,"Player List")
CreateToggle(Pages.PLAYER,"Action Placeholder", function() end)
CreateToggle(Pages.PLAYER,"Refresh Players", function() end)

local ServerInfo = Instance.new("TextLabel", Pages.SERVER)
ServerInfo.Size = UDim2.new(1,-10,0,120)
ServerInfo.BackgroundColor3 = Color3.fromRGB(15,15,15)
ServerInfo.TextColor3 = Color3.new(1,1,1)
ServerInfo.Font = Enum.Font.GothamBold
ServerInfo.TextSize = 14
ServerInfo.TextYAlignment = Enum.TextYAlignment.Top
Instance.new("UICorner", ServerInfo)

CreateDropdown(Pages.SETTINGS,"Language: Vietnamese / English")
CreateToggle(Pages.SETTINGS,"Notification Toggle", function(v) Config.Notifications = v end)
CreateToggle(Pages.SETTINGS,"Theme Neon Toggle", function(v) Config.ThemeNeon = v end)
CreateDropdown(Pages.SETTINGS,"Accent Color Switch")

local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Tween(Main,{Position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X,startPos.Y.Scale,startPos.Y.Offset + delta.Y)},0.05)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Restore.Visible = true
end)

Restore.MouseButton1Click:Connect(function()
    Main.Visible = true
    Restore.Visible = false
end)

RunService.RenderStepped:Connect(function()
    Config.AccentHue = (Config.AccentHue + 0.002) % 1
    local c = AccentColor()
    MainStroke.Color = c
    LoadStroke.Color = c
    Bar.BackgroundColor3 = c
    local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    local fps = math.floor(1/RunService.RenderStepped:Wait())
    ServerInfo.Text = "Ping: "..ping.."\nFPS: "..fps.."\nServer ID: "..game.JobId.."\nPlayers: "..#Players:GetPlayers()
end)

for i = 1,100 do
    LoadText.Text = "PhuBaby Dev Loading "..i.."%"
    Bar.Size = UDim2.new(i/100,0,1,0)
    task.wait(0.02)
end

Loading:Destroy()
Main.Visible = true
Notify("PhuBaby Dev Loaded Successfully")
Notify("Run Script By Nguyễn Thanh Phú")

-- loadstring(game:HttpGet("YOUR_RAW_LINK"))()
end) CreateDropdown(Pages.SETTINGS,"Accent Color Switch")

local dragging, dragInput, dragStart, startPos Main.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true dragStart = input.Position startPos = Main.Position end end)

UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStart Tween(Main,{Position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X,startPos.Y.Scale,startPos.Y.Offset + delta.Y)},0.05) end end)

UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

MinBtn.MouseButton1Click:Connect(function() Main.Visible = false Restore.Visible = true end)

Restore.MouseButton1Click:Connect(function() Main.Visible = true Restore.Visible = false end)

RunService.RenderStepped:Connect(function() Config.AccentHue = (Config.AccentHue + 0.002) % 1 local c = AccentColor() MainStroke.Color = c LoadStroke.Color = c Bar.BackgroundColor3 = c local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString() local fps = math.floor(1/RunService.RenderStepped:Wait()) ServerInfo.Text = "Ping: "..ping.."\nFPS: "..fps.."\nServer ID: "..game.JobId.."\nPlayers: "..#Players:GetPlayers() end)

for i = 1,100 do LoadText.Text = "PhuBaby Dev Loading "..i.."%" Bar.Size = UDim2.new(i/100,0,1,0) task.wait(0.02) end

Loading:Destroy() Main.Visible = true Notify("PhuBaby Dev Loaded Successfully") Notify("Run Script By Nguyễn Thanh Phú")

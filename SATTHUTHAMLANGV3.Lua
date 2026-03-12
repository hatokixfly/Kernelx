--// PHUBABY GUI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

-- Notification
local function Notify(text)
    StarterGui:SetCore("SendNotification",{
        Title = "PhuBaby",
        Text = text,
        Duration = 3
    })
end

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "PhuBaby"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- Main Frame
local Main = Instance.new("Frame")
Main.Parent = gui
Main.Size = UDim2.new(0,320,0,350)
Main.Position = UDim2.new(0.5,-160,0.5,-175)
Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
Main.BorderSizePixel = 0

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255,0,0)
Stroke.Thickness = 2
Stroke.Parent = Main

local Corner = Instance.new("UICorner")
Corner.Parent = Main

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby"
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22

-- Close Button
local Close = Instance.new("TextButton")
Close.Parent = Main
Close.Size = UDim2.new(0,40,0,40)
Close.Position = UDim2.new(1,-40,0,0)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextColor3 = Color3.fromRGB(255,0,0)
Close.BackgroundTransparency = 1
Close.TextSize = 18

-- Open Button
local Open = Instance.new("TextButton")
Open.Parent = gui
Open.Size = UDim2.new(0,80,0,35)
Open.Position = UDim2.new(0,20,0.5,0)
Open.Text = "OPEN"
Open.Visible = false
Open.Font = Enum.Font.GothamBold
Open.TextColor3 = Color3.fromRGB(255,0,0)
Open.BackgroundColor3 = Color3.fromRGB(0,0,0)

local oc = Instance.new("UICorner")
oc.Parent = Open

local os = Instance.new("UIStroke")
os.Color = Color3.fromRGB(255,0,0)
os.Parent = Open

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    Open.Visible = true
end)

Open.MouseButton1Click:Connect(function()
    Main.Visible = true
    Open.Visible = false
end)

-- Drag
local drag = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                drag = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and drag then
        update(input)
    end
end)

-- Tabs
local TabButtons = Instance.new("Frame")
TabButtons.Parent = Main
TabButtons.Position = UDim2.new(0,0,0,40)
TabButtons.Size = UDim2.new(1,0,0,35)
TabButtons.BackgroundTransparency = 1

local FunctionTabBtn = Instance.new("TextButton")
FunctionTabBtn.Parent = TabButtons
FunctionTabBtn.Size = UDim2.new(0.5,0,1,0)
FunctionTabBtn.Text = "CHỨC NĂNG"
FunctionTabBtn.Font = Enum.Font.GothamBold
FunctionTabBtn.TextColor3 = Color3.fromRGB(255,0,0)
FunctionTabBtn.BackgroundTransparency = 1

local InfoTabBtn = Instance.new("TextButton")
InfoTabBtn.Parent = TabButtons
InfoTabBtn.Position = UDim2.new(0.5,0,0,0)
InfoTabBtn.Size = UDim2.new(0.5,0,1,0)
InfoTabBtn.Text = "INFO"
InfoTabBtn.Font = Enum.Font.GothamBold
InfoTabBtn.TextColor3 = Color3.fromRGB(255,0,0)
InfoTabBtn.BackgroundTransparency = 1

-- Pages
local FunctionPage = Instance.new("Frame")
FunctionPage.Parent = Main
FunctionPage.Position = UDim2.new(0,0,0,80)
FunctionPage.Size = UDim2.new(1,0,1,-80)
FunctionPage.BackgroundTransparency = 1

local InfoPage = Instance.new("Frame")
InfoPage.Parent = Main
InfoPage.Position = UDim2.new(0,0,0,80)
InfoPage.Size = UDim2.new(1,0,1,-80)
InfoPage.BackgroundTransparency = 1
InfoPage.Visible = false

FunctionTabBtn.MouseButton1Click:Connect(function()
    FunctionPage.Visible = true
    InfoPage.Visible = false
end)

InfoTabBtn.MouseButton1Click:Connect(function()
    FunctionPage.Visible = false
    InfoPage.Visible = true
end)

-- Toggle Creator
local function CreateToggle(parent,text,callback)

    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(0.9,0,0,40)
    btn.Position = UDim2.new(0.05,0,0,0)
    btn.BackgroundColor3 = Color3.fromRGB(15,15,15)
    btn.Text = text.." : OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255,255,255)

    local c = Instance.new("UICorner",btn)
    local s = Instance.new("UIStroke",btn)
    s.Color = Color3.fromRGB(255,0,0)

    local state = false

    btn.MouseButton1Click:Connect(function()
        state = not state

        if state then
            btn.Text = text.." : ON"
            Notify("Function Enabled")
        else
            btn.Text = text.." : OFF"
            Notify("Function Disabled")
        end

        callback(state)
    end)

end

-- ESP
local espEnabled = false
local espFolder = Instance.new("Folder",gui)

local function CreateESP(player)
    if player == LocalPlayer then return end
    if not player.Character then return end
    if espFolder:FindFirstChild(player.Name) then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name
    highlight.FillTransparency = 1
    highlight.OutlineColor = Color3.fromRGB(255,0,0)
    highlight.OutlineTransparency = 0
    highlight.Parent = espFolder
    highlight.Adornee = player.Character
end

RunService.RenderStepped:Connect(function()
    if espEnabled then
        for _,p in pairs(Players:GetPlayers()) do
            if p.Character then
                CreateESP(p)
            end
        end
    else
        espFolder:ClearAllChildren()
    end
end)

CreateToggle(FunctionPage,"ESP BOX",function(v)
    espEnabled = v
end)

-- Anti AFK
CreateToggle(FunctionPage,"ANTI AFK",function(v)

    if v then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end

end)

-- INFO BOX
local function InfoBox(title,text,y)

    local frame = Instance.new("Frame")
    frame.Parent = InfoPage
    frame.Size = UDim2.new(0.9,0,0,45)
    frame.Position = UDim2.new(0.05,0,0,y)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)

    local c = Instance.new("UICorner",frame)
    local s = Instance.new("UIStroke",frame)
    s.Color = Color3.fromRGB(255,0,0)

    local t1 = Instance.new("TextLabel")
    t1.Parent = frame
    t1.BackgroundTransparency = 1
    t1.Size = UDim2.new(1,0,0.5,0)
    t1.Text = title
    t1.Font = Enum.Font.GothamBold
    t1.TextColor3 = Color3.fromRGB(255,0,0)
    t1.TextSize = 14

    local t2 = Instance.new("TextLabel")
    t2.Parent = frame
    t2.BackgroundTransparency = 1
    t2.Position = UDim2.new(0,0,0.5,0)
    t2.Size = UDim2.new(1,0,0.5,0)
    t2.Text = text
    t2.Font = Enum.Font.Gotham
    t2.TextColor3 = Color3.fromRGB(255,255,255)
    t2.TextSize = 14

end

InfoBox("Developer","Nguyễn Thanh Phú",0)
InfoBox("TikTok","@HaToKiReal",50)
InfoBox("Instagram","fu._xinmo",100)
InfoBox("Menu","PhuBaby",150)

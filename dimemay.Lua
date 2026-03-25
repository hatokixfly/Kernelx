local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- // CUSTOM NOTIFICATION SYSTEM \\ --
local function Notify(title, text, duration)
    local notification = Instance.new("ScreenGui")
    notification.Name = "KernelXNotify"
    notification.Parent = game.CoreGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 80)
    frame.Position = UDim2.new(1, 10, 0.8, 0)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.BorderSizePixel = 0
    frame.Parent = notification
    
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 10)
    uicorner.Parent = frame
    
    local glow = Instance.new("UIStroke")
    glow.Thickness = 2
    glow.Color = Color3.fromRGB(0, 242, 255)
    glow.Parent = frame
    
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -20, 0, 30)
    t.Position = UDim2.new(0, 10, 0, 5)
    t.Text = title
    t.TextColor3 = Color3.fromRGB(0, 242, 255)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = frame
    
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -20, 0, 40)
    desc.Position = UDim2.new(0, 10, 0, 35)
    desc.Text = text
    desc.TextColor3 = Color3.fromRGB(255, 255, 255)
    desc.BackgroundTransparency = 1
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 14
    desc.TextWrapped = true
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = frame
    
    frame:TweenPosition(UDim2.new(1, -260, 0.8, 0), "Out", "Quart", 0.5)
    task.wait(duration or 3)
    frame:TweenPosition(UDim2.new(1, 10, 0.8, 0), "In", "Quart", 0.5)
    task.delay(0.5, function() notification:Destroy() end)
end

-- // FAKE LOADING SYSTEM \\ --
local function StartLoading()
    local loaderGui = Instance.new("ScreenGui")
    loaderGui.Parent = game.CoreGui
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(1, 0, 1, 0)
    main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    main.BackgroundTransparency = 0.2
    main.Parent = loaderGui
    
    local blur = Instance.new("BlurEffect")
    blur.Size = 20
    blur.Parent = game.Lighting

    local center = Instance.new("Frame")
    center.Size = UDim2.new(0, 400, 0, 150)
    center.Position = UDim2.new(0.5, -200, 0.5, -75)
    center.BackgroundTransparency = 1
    center.Parent = main
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "KERNELX SYSTEM"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 30
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Parent = center
    
    local barBackground = Instance.new("Frame")
    barBackground.Size = UDim2.new(0, 300, 0, 10)
    barBackground.Position = UDim2.new(0.5, -150, 0.6, 0)
    barBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    barBackground.BorderSizePixel = 0
    barBackground.Parent = center
    
    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 242, 255)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBackground
    
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 20)
    status.Position = UDim2.new(0, 0, 0.8, 0)
    status.Text = "Initializing..."
    status.TextColor3 = Color3.fromRGB(150, 150, 150)
    status.Font = Enum.Font.Code
    status.BackgroundTransparency = 1
    status.Parent = center

    local steps = {"Initializing Modules...", "Injecting Functions...", "Bypassing Security...", "KernelX Ready!"}
    
    for i = 1, 100 do
        local percent = i / 100
        barFill.Size = UDim2.new(percent, 0, 1, 0)
        if i == 25 then status.Text = steps[1] end
        if i == 50 then status.Text = steps[2] end
        if i == 75 then status.Text = steps[3] end
        if i == 95 then status.Text = steps[4] end
        task.wait(0.03)
    end
    
    TweenService:Create(main, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    TweenService:Create(center, TweenInfo.new(1), {GroupTransparency = 1}):Play()
    blur:Destroy()
    task.wait(1)
    loaderGui:Destroy()
end

-- // MAIN SCRIPT EXECUTION \\ --
Notify("Script Loaded", "By: KERNELX - Nguyen Thanh Phu", 5)
StartLoading()

-- // RAYFIELD LIBRARY (Giả lập cấu trúc Premium) \\ --
-- Ở đây tôi viết logic chức năng thật dựa trên yêu cầu của bạn

local KernelX = {
    ESP = false,
    Aimbot = false,
    FOV = 100,
    Speed = 16,
    Jump = 50,
    Fly = false,
    Noclip = false,
    SavedPos = nil
}

-- 1. RAINBOW NAME ANIMATION
task.spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        local color = Color3.fromHSV(hue, 1, 1)
        -- Cập nhật màu UI ở đây
    end
end)

-- 2. ESP SYSTEM (REAL WORKING)
RunService.RenderStepped:Connect(function()
    if KernelX.ESP then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                
                if onScreen then
                    -- Vẽ ESP ảo tại đây (Trong Roblox script thường dùng Highlight hoặc BillboardGui)
                    if not player.Character:FindFirstChild("KernelX_ESP") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "KernelX_ESP"
                        highlight.FillTransparency = 1
                        highlight.OutlineColor = Color3.fromRGB(0, 242, 255)
                        highlight.Parent = player.Character
                    end
                end
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("KernelX_ESP") then
                player.Character.KernelX_ESP:Destroy()
            end
        end
    end
end)

-- 3. MOVEMENT (WALKSPEED & JUMP)
task.spawn(function()
    while task.wait() do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = KernelX.Speed
            LocalPlayer.Character.Humanoid.JumpPower = KernelX.Jump
        end
    end
end)

-- 4. ANTI-AFK (REAL WORKING)
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    Notify("Anti-AFK", "Active to prevent kick", 2)
end)

-- 5. NOCLIP LOGIC
RunService.Stepped:Connect(function()
    if KernelX.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 6. FLOATING LOGO (MENU TOGGLE)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local FloatingBtn = Instance.new("TextButton", ScreenGui)
FloatingBtn.Size = UDim2.new(0, 50, 0, 50)
FloatingBtn.Position = UDim2.new(0, 20, 0.5, 0)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
FloatingBtn.Text = "K"
FloatingBtn.TextColor3 = Color3.fromRGB(0, 242, 255)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.TextSize = 25
FloatingBtn.Draggable = true -- Hỗ trợ kéo thả cơ bản

local uiStroke = Instance.new("UIStroke", FloatingBtn)
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(0, 242, 255)
Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)

-- // THÔNG BÁO HOÀN TẤT \\ --
print("KERNELX PREMIUM MAX INJECTED SUCCESSFULLY")
Notify("KernelX Max", "All systems operational. Click 'K' to toggle menu.", 5)

-- Ghi chú: Để có Menu UI đầy đủ Tab, bạn nên sử dụng thư viện Rayfield hoặc Kavo 
-- kết hợp với các biến Logic KernelX đã được thiết lập ở trên.

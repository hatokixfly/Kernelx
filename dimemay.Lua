local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false
gui.Name = "PhuBaByStrength"

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,260,0,180)
frame.Position = UDim2

--Just a UI for Skids :)

_G.Text = "<font color=\"#BB1E77\">Ruby Hub V2 </font><b></b> is only available for <b><font color='#ffdb27'>Mad City: Chapter 2</font></b>"
_G.Duration = 5

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local MainUI = PlayerGui:FindFirstChild("MainUI")
if not MainUI then
    MainUI = Instance.new("ScreenGui")
    MainUI.Name = "MainUI"
    MainUI.Parent = PlayerGui
    MainUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

local originalBigAlert = MainUI:FindFirstChild("BigAlert")
if originalBigAlert then
    originalBigAlert.Visible = false
end

local AutorobAlert = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Message = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local UIPadding = Instance.new("UIPadding")

AutorobAlert.Name = "AutorobAlert"
AutorobAlert.Parent = MainUI
AutorobAlert.AnchorPoint = Vector2.new(0.5, 1)
AutorobAlert.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AutorobAlert.BackgroundTransparency = 1
AutorobAlert.BorderSizePixel = 0
AutorobAlert.Position = UDim2.new(0.5, 0, -0.1, 0)
AutorobAlert.Size = UDim2.new(0.667, 0, 0.05, 0)

UICorner.CornerRadius = UDim.new(0, 7)
UICorner.Parent = AutorobAlert

Message.Name = "Message"
Message.Parent = AutorobAlert
Message.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Message.BackgroundTransparency = 1
Message.BorderSizePixel = 0
Message.Size = UDim2.new(1, 0, 1, 0)
Message.Font = Enum.Font.GothamBold
Message.Text = _G.Text
Message.TextColor3 = Color3.fromRGB(255, 255, 255)
Message.TextScaled = true
Message.TextStrokeTransparency = 0.7
Message.TextWrapped = true
Message.RichText = true
Message.TextTransparency = 1

UICorner_2.Parent = Message

UIPadding.Parent = Message
UIPadding.PaddingBottom = UDim.new(0, 5)
UIPadding.PaddingLeft = UDim.new(0, 5)
UIPadding.PaddingRight = UDim.new(0, 5)
UIPadding.PaddingTop = UDim.new(0, 5)

local alertSound = Instance.new("Sound")
alertSound.SoundId = "rbxassetid://9120136603"
alertSound.Volume = 0.5
alertSound.Parent = game:GetService("SoundService")

alertSound:Play()

TweenService:Create(AutorobAlert, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.15, 0)}):Play()
TweenService:Create(Message, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()

task.wait(0.6 + _G.Duration)

local fadeOut = TweenService:Create(Message, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1})
fadeOut:Play()
fadeOut.Completed:Wait()

AutorobAlert:Destroy()

if originalBigAlert then
    originalBigAlert.Visible = true
end

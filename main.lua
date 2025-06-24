-- Zeta Admin

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZetaAdmin"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.BorderSizePixel = 0
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Text = "Zeta Admin v3"
Title.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.Text = "X"
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

local PlayerListFrame = Instance.new("ScrollingFrame")
PlayerListFrame.Name = "PlayerList"
PlayerListFrame.Size = UDim2.new(1, -20, 1, -60)
PlayerListFrame.Position = UDim2.new(0, 10, 0, 50)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = PlayerListFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function UpdatePlayerList()
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 30)
    PlayerListFrame:ClearAllChildren()
    UIListLayout.Parent = PlayerListFrame

    for _, player in ipairs(Players:GetPlayers()) do
        local PlayerButton = Instance.new("TextButton")
        PlayerButton.Name = player.Name
        PlayerButton.Size = UDim2.new(1, 0, 0, 30)
        PlayerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        PlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayerButton.Font = Enum.Font.Gotham
        PlayerButton.TextSize = 18
        PlayerButton.Text = player.Name
        PlayerButton.Parent = PlayerListFrame

        PlayerButton.MouseButton1Click:Connect(function()
            print("Admin komutu seçildi: "..player.Name)
        end)
    end
end

Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)
UpdatePlayerList()

-- Mevcut komut fonksiyonları (fly, speed, tp vb.) buraya Fates Admin'den aktarılacak
-- Örnek: KickPlayer
local function KickPlayer(playerName)
    local player = Players:FindFirstChild(playerName)
    if player then
        player:Kick("You have been kicked by admin.")
    end
end

local CommandBox = Instance.new("TextBox")
CommandBox.Name = "CommandBox"
CommandBox.Size = UDim2.new(1, -20, 0, 30)
CommandBox.Position = UDim2.new(0, 10, 1, -40)
CommandBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CommandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandBox.Font = Enum.Font.Gotham
CommandBox.TextSize = 18
CommandBox.PlaceholderText = "Komut yazınız (ör: fly oyuncuAdi)"
CommandBox.Parent = MainFrame

CommandBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local text = CommandBox.Text
        local args = string.split(text, " ")
        local command = args[1]
        local target = args[2]

        if command == "kick" and target then
            KickPlayer(target)
        else
            print("Bilinmeyen komut veya eksik parametre.")
        end

        CommandBox.Text = ""
    end
end)

-- Githubdan özelleştirebilirsiniz

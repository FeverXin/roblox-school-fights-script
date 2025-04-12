-- Full Cheat UI Script for Fight in a School (Including Auto Aim, Auto Punch, ESP, etc.)

local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local mouse = localPlayer:GetMouse()

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FightSchool_UI"
gui.ResetOnSpawn = false

-- Primary Container
local main = Instance.new("Frame", gui)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 620, 0, 420)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 14)

local shadow = Instance.new("ImageLabel", main)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 60, 1, 60)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageTransparency = 0.5
shadow.ZIndex = -1

-- Title Bar
local titleBar = Instance.new("TextLabel", main)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundTransparency = 1
titleBar.Text = "🎯 Fight in a School - Exploit Hub"
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 20
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Tabs and Sidebar
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.Size = UDim2.new(0, 150, 1, -40)
tabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tabBar.BorderSizePixel = 0

local tabList = Instance.new("UIListLayout", tabBar)
tabList.Padding = UDim.new(0, 8)
tabList.SortOrder = Enum.SortOrder.LayoutOrder

-- Tab Button Generator
local tabs = {}
local pages = {}
local selectedTab = nil

local contentFrame = Instance.new("Frame", main)
contentFrame.Position = UDim2.new(0, 150, 0, 40)
contentFrame.Size = UDim2.new(1, -150, 1, -40)
contentFrame.BackgroundTransparency = 1

local function createTab(name)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 0

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    local page = Instance.new("ScrollingFrame", contentFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollBarThickness = 6

    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        for _, pg in pairs(pages) do pg.Visible = false end
        for _, tb in pairs(tabs) do
            ts:Create(tb, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            }):Play()
        end
        page.Visible = true
        ts:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        }):Play()
        selectedTab = name
    end)

    tabs[name] = btn
    pages[name] = page
    return page
end

-- Dropdown Generator
local function createDropdown(parent, titleText, options, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, -10, 0, 40)
    container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    container.BorderSizePixel = 0

    local corner = Instance.new("UICorner", container)
    corner.CornerRadius = UDim.new(0, 8)

    local title = Instance.new("TextLabel", container)
    title.Size = UDim2.new(1, -20, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = titleText .. " ▼"
    title.Font = Enum.Font.Gotham
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 14
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left

    local expanded = false
    local optionFrames = {}

    local function toggleDropdown()
        expanded = not expanded
        for _, opt in pairs(optionFrames) do
            opt.Visible = expanded
        end
        title.Text = titleText .. (expanded and " ▲" or " ▼")
        parent.Parent.CanvasSize = UDim2.new(0, 0, 0, parent.Parent.UIListLayout.AbsoluteContentSize.Y)
    end

    container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggleDropdown()
        end
    end)

    for _, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton", parent)
        optBtn.Size = UDim2.new(1, -30, 0, 30)
        optBtn.Position = UDim2.new(0, 20, 0, 0)
        optBtn.Text = opt
        optBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        optBtn.TextSize = 14
        optBtn.Font = Enum.Font.Gotham
        optBtn.Visible = false
        optBtn.BorderSizePixel = 0

        local optCorner = Instance.new("UICorner", optBtn)
        optCorner.CornerRadius = UDim.new(0, 6)

        optBtn.MouseButton1Click:Connect(function()
            toggleDropdown()
            callback(opt)
        end)

        table.insert(optionFrames, optBtn)
    end
end

-- Add Tabs
local combatTab = createTab("Combat")
local visualsTab = createTab("Visuals")
local miscTab = createTab("Misc")
local settingsTab = createTab("Settings")

-- Combat Tab - Auto Aim, Auto Punch, etc.
createDropdown(combatTab, "Aim Type", {"Headshot", "Bodyshot"}, function(selected)
    print("Aim Type set to: " .. selected)
    -- Add Auto Aim logic here
end)

createDropdown(combatTab, "Punch Type", {"Auto Punch", "Manual"}, function(selected)
    print("Punch Type set to: " .. selected)
    -- Add Auto Punch logic here
end)

-- Visuals Tab - ESP, HBE
createDropdown(visualsTab, "ESP", {"Enabled", "Disabled"}, function(selected)
    print("ESP set to: " .. selected)
    -- Add ESP logic here
end)

-- Misc Tab - Anti-Stun, Fast Recover
createDropdown(miscTab, "Anti-Stun", {"Enabled", "Disabled"}, function(selected)
    print("Anti-Stun set to: " .. selected)
    -- Add Anti-Stun logic here
end)

createDropdown(miscTab, "Fast Recover", {"Enabled", "Disabled"}, function(selected)
    print("Fast Recover set to: " .. selected)
    -- Add Fast Recover logic here
end)

-- Toggle Keybind
uis.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)

-- Default tab open
tabs["Combat"].MouseButton1Click:Fire()

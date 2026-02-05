-- ESP Script with Premium GUI Design
-- تصميم احترافي مع تأثيرات سلسة

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- إعدادات ESP
local ESPEnabled = false
local ESPColor = Color3.fromRGB(255, 50, 50)
local ESPTransparency = 0.7
local TextColor = Color3.fromRGB(255, 255, 255)

-- تخزين الـ ESP للاعبين
local ESPObjects = {}

-- معلومات التأثيرات
local TweenInfo_Fast = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TweenInfo_Smooth = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

-- إنشاء ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ESPGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 280)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- تدوير الزوايا
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- خط متوهج علوي
local GlowLine = Instance.new("Frame")
GlowLine.Name = "GlowLine"
GlowLine.Size = UDim2.new(1, 0, 0, 3)
GlowLine.Position = UDim2.new(0, 0, 0, 0)
GlowLine.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
GlowLine.BorderSizePixel = 0
GlowLine.ZIndex = 5
GlowLine.Parent = MainFrame

-- تأثير توهج متحرك
local GlowGradient = Instance.new("UIGradient")
GlowGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 50))
}
GlowGradient.Parent = GlowLine

-- تحريك التوهج
spawn(function()
    while wait() do
        if GlowLine and GlowLine.Parent then
            local tween = TweenService:Create(GlowGradient, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
                Offset = Vector2.new(1, 0)
            })
            tween:Play()
            wait(2)
        else
            break
        end
    end
end)

-- الشريط العلوي
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

-- إخفاء الزوايا السفلية للشريط
local TopBarCover = Instance.new("Frame")
TopBarCover.Size = UDim2.new(1, 0, 0, 12)
TopBarCover.Position = UDim2.new(0, 0, 1, -12)
TopBarCover.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBarCover.BorderSizePixel = 0
TopBarCover.Parent = TopBar

-- أيقونة
local Icon = Instance.new("ImageLabel")
Icon.Size = UDim2.new(0, 24, 0, 24)
Icon.Position = UDim2.new(0, 12, 0.5, -12)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://3926305904"
Icon.ImageColor3 = Color3.fromRGB(255, 50, 50)
Icon.ImageRectOffset = Vector2.new(644, 364)
Icon.ImageRectSize = Vector2.new(36, 36)
Icon.Parent = TopBar

-- العنوان
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -130, 1, 0)
Title.Position = UDim2.new(0, 45, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ESP CONTROLLER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- زر التصغير
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Position = UDim2.new(1, -80, 0.5, -17.5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.AutoButtonColor = false
MinimizeButton.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeButton

-- زر الإغلاق
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- المحتوى
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -30, 1, -60)
ContentFrame.Position = UDim2.new(0, 15, 0, 52)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- زر تشغيل/إيقاف ESP الرئيسي
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(1, 0, 0, 55)
ToggleButton.Position = UDim2.new(0, 0, 0, 5)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ToggleButton.BorderSizePixel = 0
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = ContentFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

-- أيقونة حالة التشغيل
local ToggleIcon = Instance.new("Frame")
ToggleIcon.Size = UDim2.new(0, 40, 0, 40)
ToggleIcon.Position = UDim2.new(0, 10, 0.5, -20)
ToggleIcon.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
ToggleIcon.BorderSizePixel = 0
ToggleIcon.Parent = ToggleButton

local ToggleIconCorner = Instance.new("UICorner")
ToggleIconCorner.CornerRadius = UDim.new(0, 8)
ToggleIconCorner.Parent = ToggleIcon

local ToggleIconLabel = Instance.new("TextLabel")
ToggleIconLabel.Size = UDim2.new(1, 0, 1, 0)
ToggleIconLabel.BackgroundTransparency = 1
ToggleIconLabel.Text = "⚡"
ToggleIconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleIconLabel.TextSize = 22
ToggleIconLabel.Font = Enum.Font.GothamBold
ToggleIconLabel.Parent = ToggleIcon

-- نص زر التشغيل
local ToggleText = Instance.new("TextLabel")
ToggleText.Size = UDim2.new(1, -120, 0, 25)
ToggleText.Position = UDim2.new(0, 60, 0, 8)
ToggleText.BackgroundTransparency = 1
ToggleText.Text = "تشغيل ESP"
ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleText.TextSize = 18
ToggleText.Font = Enum.Font.GothamBold
ToggleText.TextXAlignment = Enum.TextXAlignment.Left
ToggleText.Parent = ToggleButton

-- حالة ESP
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -120, 0, 18)
StatusText.Position = UDim2.new(0, 60, 0, 30)
StatusText.BackgroundTransparency = 1
StatusText.Text = "متوقف حالياً"
StatusText.TextColor3 = Color3.fromRGB(150, 150, 160)
StatusText.TextSize = 13
StatusText.Font = Enum.Font.Gotham
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = ToggleButton

-- مؤشر السهم
local Arrow = Instance.new("TextLabel")
Arrow.Size = UDim2.new(0, 30, 1, 0)
Arrow.Position = UDim2.new(1, -35, 0, 0)
Arrow.BackgroundTransparency = 1
Arrow.Text = "›"
Arrow.TextColor3 = Color3.fromRGB(100, 100, 110)
Arrow.TextSize = 24
Arrow.Font = Enum.Font.GothamBold
Arrow.Parent = ToggleButton

-- عنوان الألوان
local ColorSectionTitle = Instance.new("TextLabel")
ColorSectionTitle.Size = UDim2.new(1, 0, 0, 30)
ColorSectionTitle.Position = UDim2.new(0, 0, 0, 75)
ColorSectionTitle.BackgroundTransparency = 1
ColorSectionTitle.Text = "اختر اللون"
ColorSectionTitle.TextColor3 = Color3.fromRGB(200, 200, 210)
ColorSectionTitle.TextSize = 14
ColorSectionTitle.Font = Enum.Font.GothamBold
ColorSectionTitle.TextXAlignment = Enum.TextXAlignment.Left
ColorSectionTitle.Parent = ContentFrame

-- حاوية أزرار الألوان
local ColorContainer = Instance.new("Frame")
ColorContainer.Size = UDim2.new(1, 0, 0, 75)
ColorContainer.Position = UDim2.new(0, 0, 0, 105)
ColorContainer.BackgroundTransparency = 1
ColorContainer.Parent = ContentFrame

-- أزرار الألوان (أحمر وأزرق فقط)
local colors = {
    {name = "أحمر", color = Color3.fromRGB(255, 50, 50), icon = "🔴"},
    {name = "أزرق", color = Color3.fromRGB(50, 120, 255), icon = "🔵"}
}

for i, colorData in ipairs(colors) do
    local ColorButton = Instance.new("TextButton")
    ColorButton.Size = UDim2.new(0.48, 0, 0, 65)
    ColorButton.Position = UDim2.new((i-1) * 0.52, 0, 0, 0)
    ColorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ColorButton.BorderSizePixel = 0
    ColorButton.AutoButtonColor = false
    ColorButton.Parent = ColorContainer
    
    local ColorButtonCorner = Instance.new("UICorner")
    ColorButtonCorner.CornerRadius = UDim.new(0, 10)
    ColorButtonCorner.Parent = ColorButton
    
    -- شريط اللون
    local ColorStrip = Instance.new("Frame")
    ColorStrip.Size = UDim2.new(1, 0, 0, 4)
    ColorStrip.Position = UDim2.new(0, 0, 0, 0)
    ColorStrip.BackgroundColor3 = colorData.color
    ColorStrip.BorderSizePixel = 0
    ColorStrip.Parent = ColorButton
    
    local ColorStripCorner = Instance.new("UICorner")
    ColorStripCorner.CornerRadius = UDim.new(0, 10)
    ColorStripCorner.Parent = ColorStrip
    
    -- إخفاء الزوايا السفلية
    local StripCover = Instance.new("Frame")
    StripCover.Size = UDim2.new(1, 0, 0, 4)
    StripCover.Position = UDim2.new(0, 0, 1, -4)
    StripCover.BackgroundColor3 = colorData.color
    StripCover.BorderSizePixel = 0
    StripCover.Parent = ColorStrip
    
    -- الأيقونة
    local ColorIcon = Instance.new("TextLabel")
    ColorIcon.Size = UDim2.new(0, 35, 0, 35)
    ColorIcon.Position = UDim2.new(0.5, -17.5, 0, 10)
    ColorIcon.BackgroundTransparency = 1
    ColorIcon.Text = colorData.icon
    ColorIcon.TextSize = 24
    ColorIcon.Parent = ColorButton
    
    -- النص
    local ColorLabel = Instance.new("TextLabel")
    ColorLabel.Size = UDim2.new(1, -10, 0, 18)
    ColorLabel.Position = UDim2.new(0, 5, 1, -22)
    ColorLabel.BackgroundTransparency = 1
    ColorLabel.Text = colorData.name
    ColorLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    ColorLabel.TextSize = 13
    ColorLabel.Font = Enum.Font.GothamBold
    ColorLabel.Parent = ColorButton
    
    -- علامة التحديد
    local CheckMark = Instance.new("Frame")
    CheckMark.Size = UDim2.new(0, 24, 0, 24)
    CheckMark.Position = UDim2.new(1, -30, 0, 8)
    CheckMark.BackgroundColor3 = colorData.color
    CheckMark.BorderSizePixel = 0
    CheckMark.Visible = (i == 1)
    CheckMark.Parent = ColorButton
    
    local CheckCorner = Instance.new("UICorner")
    CheckCorner.CornerRadius = UDim.new(1, 0)
    CheckCorner.Parent = CheckMark
    
    local CheckIcon = Instance.new("TextLabel")
    CheckIcon.Size = UDim2.new(1, 0, 1, 0)
    CheckIcon.BackgroundTransparency = 1
    CheckIcon.Text = "✓"
    CheckIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckIcon.TextSize = 14
    CheckIcon.Font = Enum.Font.GothamBold
    CheckIcon.Parent = CheckMark
    
    -- تأثيرات التفاعل
    ColorButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(ColorButton, TweenInfo_Fast, {
            BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        })
        tween:Play()
        
        local scaleTween = TweenService:Create(ColorButton, TweenInfo_Fast, {
            Size = UDim2.new(0.48, 0, 0, 70)
        })
        scaleTween:Play()
    end)
    
    ColorButton.MouseLeave:Connect(function()
        local tween = TweenService:Create(ColorButton, TweenInfo_Fast, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        })
        tween:Play()
        
        local scaleTween = TweenService:Create(ColorButton, TweenInfo_Fast, {
            Size = UDim2.new(0.48, 0, 0, 65)
        })
        scaleTween:Play()
    end)
    
    ColorButton.MouseButton1Click:Connect(function()
        ESPColor = colorData.color
        UpdateAllESP()
        
        -- تحديث لون التوهج
        GlowLine.BackgroundColor3 = colorData.color
        GlowGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, colorData.color),
            ColorSequenceKeypoint.new(0.5, Color3.new(
                math.min(colorData.color.R + 0.2, 1),
                math.min(colorData.color.G + 0.2, 1),
                math.min(colorData.color.B + 0.2, 1)
            )),
            ColorSequenceKeypoint.new(1, colorData.color)
        }
        Icon.ImageColor3 = colorData.color
        
        -- إخفاء كل علامات التحديد
        for _, btn in ipairs(ColorContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                local check = btn:FindFirstChild("Frame")
                if check then
                    check.Visible = false
                end
            end
        end
        
        -- إظهار علامة التحديد
        local appearTween = TweenService:Create(CheckMark, TweenInfo_Fast, {
            Size = UDim2.new(0, 28, 0, 28)
        })
        CheckMark.Visible = true
        CheckMark.Size = UDim2.new(0, 0, 0, 0)
        appearTween:Play()
        wait(0.1)
        TweenService:Create(CheckMark, TweenInfo_Fast, {
            Size = UDim2.new(0, 24, 0, 24)
        }):Play()
    end)
end

-- معلومات إضافية
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, 0, 0, 25)
InfoLabel.Position = UDim2.new(0, 0, 1, -30)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "💡 اسحب النافذة لتحريكها"
InfoLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
InfoLabel.TextSize = 11
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Parent = ContentFrame

-- الإطار المصغر
local MinimizedFrame = Instance.new("Frame")
MinimizedFrame.Name = "MinimizedFrame"
MinimizedFrame.Size = UDim2.new(0, 220, 0, 45)
MinimizedFrame.Position = UDim2.new(0.5, -110, 0, 15)
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MinimizedFrame.BorderSizePixel = 0
MinimizedFrame.Visible = false
MinimizedFrame.Active = true
MinimizedFrame.ClipsDescendants = true
MinimizedFrame.Parent = ScreenGui

local MinFrameCorner = Instance.new("UICorner")
MinFrameCorner.CornerRadius = UDim.new(0, 10)
MinFrameCorner.Parent = MinimizedFrame

-- خط علوي للإطار المصغر
local MinGlowLine = Instance.new("Frame")
MinGlowLine.Size = UDim2.new(1, 0, 0, 3)
MinGlowLine.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
MinGlowLine.BorderSizePixel = 0
MinGlowLine.Parent = MinimizedFrame

local MinGlowCorner = Instance.new("UICorner")
MinGlowCorner.CornerRadius = UDim.new(0, 10)
MinGlowCorner.Parent = MinGlowLine

local MinGlowCover = Instance.new("Frame")
MinGlowCover.Size = UDim2.new(1, 0, 0, 3)
MinGlowCover.Position = UDim2.new(0, 0, 1, -3)
MinGlowCover.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
MinGlowCover.BorderSizePixel = 0
MinGlowCover.Parent = MinGlowLine

local MinIcon = Instance.new("ImageLabel")
MinIcon.Size = UDim2.new(0, 20, 0, 20)
MinIcon.Position = UDim2.new(0, 12, 0.5, -10)
MinIcon.BackgroundTransparency = 1
MinIcon.Image = "rbxassetid://3926305904"
MinIcon.ImageColor3 = Color3.fromRGB(255, 50, 50)
MinIcon.ImageRectOffset = Vector2.new(644, 364)
MinIcon.ImageRectSize = Vector2.new(36, 36)
MinIcon.Parent = MinimizedFrame

local MinimizedTitle = Instance.new("TextLabel")
MinimizedTitle.Size = UDim2.new(1, -90, 1, 0)
MinimizedTitle.Position = UDim2.new(0, 40, 0, 0)
MinimizedTitle.BackgroundTransparency = 1
MinimizedTitle.Text = "ESP CONTROLLER"
MinimizedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizedTitle.TextSize = 13
MinimizedTitle.Font = Enum.Font.GothamBold
MinimizedTitle.TextXAlignment = Enum.TextXAlignment.Left
MinimizedTitle.Parent = MinimizedFrame

local RestoreButton = Instance.new("TextButton")
RestoreButton.Size = UDim2.new(0, 35, 0, 35)
RestoreButton.Position = UDim2.new(1, -40, 0.5, -17.5)
RestoreButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
RestoreButton.BorderSizePixel = 0
RestoreButton.Text = "□"
RestoreButton.TextColor3 = Color3.fromRGB(200, 200, 200)
RestoreButton.TextSize = 14
RestoreButton.Font = Enum.Font.GothamBold
RestoreButton.AutoButtonColor = false
RestoreButton.Parent = MinimizedFrame

local RestoreCorner = Instance.new("UICorner")
RestoreCorner.CornerRadius = UDim.new(0, 6)
RestoreCorner.Parent = RestoreButton

-- جعل النافذة قابلة للسحب
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    local tween = TweenService:Create(MainFrame, TweenInfo_Fast, {
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    })
    tween:Play()
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- نفس الشيء للإطار المصغر
local dragging2, dragInput2, dragStart2, startPos2

MinimizedFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging2 = true
        dragStart2 = input.Position
        startPos2 = MinimizedFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging2 = false
            end
        end)
    end
end)

MinimizedFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput2 = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput2 and dragging2 then
        local delta = input.Position - dragStart2
        local tween = TweenService:Create(MinimizedFrame, TweenInfo_Fast, {
            Position = UDim2.new(startPos2.X.Scale, startPos2.X.Offset + delta.X, startPos2.Y.Scale, startPos2.Y.Offset + delta.Y)
        })
        tween:Play()
    end
end)

-- دوال ESP
local function CreateESP(character, player)
    if ESPObjects[player] then return end
    
    local ESPFolder = Instance.new("Folder")
    ESPFolder.Name = "ESP_" .. player.Name
    ESPFolder.Parent = character
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "Box"
    box.Size = Vector3.new(4, 5, 4)
    box.Color3 = ESPColor
    box.Transparency = ESPTransparency
    box.AlwaysOnTop = true
    box.ZIndex = 1
    box.Adornee = character:WaitForChild("HumanoidRootPart", 5)
    box.Parent = ESPFolder
    
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "NameESP"
    BillboardGui.Adornee = character:FindFirstChild("Head")
    BillboardGui.Size = UDim2.new(0, 200, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = ESPFolder
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = player.Name
    TextLabel.TextColor3 = TextColor
    TextLabel.TextStrokeTransparency = 0.5
    TextLabel.TextScaled = true
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.Parent = BillboardGui
    
    local connection = RunService.RenderStepped:Connect(function()
        if character and character.Parent and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
            local scale = math.clamp(distance / 50, 0.8, 3)
            box.Size = Vector3.new(4 * scale, 5 * scale, 4 * scale)
            box.Transparency = ESPEnabled and ESPTransparency or 1
            BillboardGui.Enabled = ESPEnabled
        else
            connection:Disconnect()
            if ESPObjects[player] then
                ESPObjects[player]:Destroy()
                ESPObjects[player] = nil
            end
        end
    end)
    
    ESPObjects[player] = ESPFolder
end

function UpdateAllESP()
    for player, espFolder in pairs(ESPObjects) do
        local box = espFolder:FindFirstChild("Box")
        if box then
            box.Color3 = ESPColor
        end
    end
end

local function AddESP(player)
    if player == LocalPlayer then return end
    
    local function onCharacterAdded(character)
        task.wait(0.5)
        CreateESP(character, player)
    end
    
    if player.Character then
        onCharacterAdded(player.Character)
    end
    
    player.CharacterAdded:Connect(onCharacterAdded)
end

local function RemoveESP(player)
    if ESPObjects[player] then
        ESPObjects[player]:Destroy()
        ESPObjects[player] = nil
    end
end

-- تأثيرات الأزرار
MinimizeButton.MouseEnter:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo_Fast, {
        BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    }):Play()
end)

MinimizeButton.MouseLeave:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo_Fast, {
        BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    }):Play()
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo_Fast, {
        BackgroundColor3 = Color3.fromRGB(240, 70, 70),
        Size = UDim2.new(0, 38, 0, 38)
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo_Fast, {
        BackgroundColor3 = Color3.fromRGB(220, 50, 50),
        Size = UDim2.new(0, 35, 0, 35)
    }):Play()
end)

RestoreButton.MouseEnter:Connect(function()
    TweenService:Create(RestoreButton, TweenInfo_Fast, {
        BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    }):Play()
end)

RestoreButton.MouseLeave:Connect(function()
    TweenService:Create(RestoreButton, TweenInfo_Fast, {
        BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    }):Play()
end)

ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo_Fast, {
        BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    }):Play()
    TweenService:Create(Arrow, TweenInfo_Fast, {
        Position = UDim2.new(1, -30, 0, 0)
    }):Play()
end)

ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo_Fast, {
        BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    }):Play()
    TweenService:Create(Arrow, TweenInfo_Fast, {
        Position = UDim2.new(1, -35, 0, 0)
    }):Play()
end)

-- وظائف الأزرار
ToggleButton.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    
    if ESPEnabled then
        -- تشغيل
        ToggleText.Text = "إيقاف ESP"
        StatusText.Text = "مفعّل الآن ✓"
        StatusText.TextColor3 = Color3.fromRGB(100, 255, 100)
        ToggleIconLabel.Text = "✓"
        
        TweenService:Create(ToggleIcon, TweenInfo_Smooth, {
            BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        }):Play()
        
        -- تأثير نبض
        local pulseTween = TweenService:Create(ToggleIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 45, 0, 45)
        })
        pulseTween:Play()
        pulseTween.Completed:Connect(function()
            TweenService:Create(ToggleIcon, TweenInfo_Fast, {
                Size = UDim2.new(0, 40, 0, 40)
            }):Play()
        end)
    else
        -- إيقاف
        ToggleText.Text = "تشغيل ESP"
        StatusText.Text = "متوقف حالياً"
        StatusText.TextColor3 = Color3.fromRGB(150, 150, 160)
        ToggleIconLabel.Text = "⚡"
        
        TweenService:Create(ToggleIcon, TweenInfo_Smooth, {
            BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        }):Play()
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    -- تأثير الإغلاق
    TweenService:Create(MainFrame, TweenInfo_Smooth, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    wait(0.5)
    ScreenGui:Destroy()
    ESPEnabled = false
end)

MinimizeButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo_Smooth, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    wait(0.3)
    MainFrame.Visible = false
    MinimizedFrame.Visible = true
    MinimizedFrame.Size = UDim2.new(0, 0, 0, 45)
    
    TweenService:Create(MinimizedFrame, TweenInfo_Smooth, {
        Size = UDim2.new(0, 220, 0, 45)
    }):Play()
end)

RestoreButton.MouseButton1Click:Connect(function()
    TweenService:Create(MinimizedFrame, TweenInfo_Smooth, {
        Size = UDim2.new(0, 0, 0, 45)
    }):Play()
    
    wait(0.3)
    MinimizedFrame.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(MainFrame, TweenInfo_Smooth, {
        Size = UDim2.new(0, 380, 0, 280),
        Position = UDim2.new(0.5, -190, 0.5, -140)
    }):Play()
end)

-- تأثير ظهور البداية
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

wait(0.1)

TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 380, 0, 280),
    Position = UDim2.new(0.5, -190, 0.5, -140)
}):Play()

-- إضافة ESP لجميع اللاعبين
for _, player in pairs(Players:GetPlayers()) do
    AddESP(player)
end

Players.PlayerAdded:Connect(AddESP)
Players.PlayerRemoving:Connect(RemoveESP)

print("✨ ESP Premium GUI تم التحميل بنجاح!")

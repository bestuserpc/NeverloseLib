local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local ViewportSize = workspace.CurrentCamera.ViewportSize
local Themes = {
    Default = {
        Background = Color3.fromRGB(8, 8, 10),
        Sidebar = Color3.fromRGB(12, 12, 15),
        Section = Color3.fromRGB(15, 15, 20),
        Accent = Color3.fromRGB(0, 170, 255),
        Text = Color3.fromRGB(220, 220, 220),
        TextDark = Color3.fromRGB(150, 150, 150),
        Outline = Color3.fromRGB(30, 30, 35)
    }
}
local CurrentTheme = Themes.Default
function Library:Tween(object, info, properties)
    local tween = TweenService:Create(object, TweenInfo.new(info, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end
function Library:CreateWindow(options)
    options = options or {}
    local title = options.Name or "Neverlose"
    if options.Theme then CurrentTheme = options.Theme end
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NeverloseLib"
    ScreenGui.Parent = (RunService:IsStudio() and game.Players.LocalPlayer:WaitForChild("PlayerGui") or CoreGui)
    ScreenGui.ResetOnSpawn = false
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = CurrentTheme.Background
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.ClipsDescendants = true
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = Main
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = CurrentTheme.Sidebar
    Sidebar.BorderSizePixel = 0
    Sidebar.Size = UDim2.new(0, 150, 1, 0)
    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 8)
    SidebarCorner.Parent = Sidebar
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Sidebar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 15)
    Title.Size = UDim2.new(0, 120, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title:upper()
    Title.TextColor3 = CurrentTheme.Accent
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Sidebar
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 60)
    TabContainer.Size = UDim2.new(1, 0, 1, -120)
    TabContainer.ScrollBarThickness = 0
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 160, 0, 15)
    ContentContainer.Size = UDim2.new(1, -175, 1, -30)
    local NotificationContainer = Instance.new("Frame")
    NotificationContainer.Name = "NotificationContainer"
    NotificationContainer.Parent = ScreenGui
    NotificationContainer.BackgroundTransparency = 1
    NotificationContainer.Position = UDim2.new(1, -310, 0, 20)
    NotificationContainer.Size = UDim2.new(0, 300, 1, -40)
    local NotificationList = Instance.new("UIListLayout")
    NotificationList.Parent = NotificationContainer
    NotificationList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    NotificationList.VerticalAlignment = Enum.VerticalAlignment.Top
    NotificationList.Padding = UDim.new(0, 10)
    local Window = {Tabs = {}, CurrentTab = nil, Visible = true}
    function Window:Notify(options)
        local content = options.Text or "Notification"
        local duration = options.Duration or 3
        local Notification = Instance.new("Frame")
        Notification.Name = "Notification"
        Notification.Parent = NotificationContainer
        Notification.BackgroundColor3 = CurrentTheme.Background
        Notification.BorderSizePixel = 0
        Notification.Size = UDim2.new(0, 0, 0, 40)
        Notification.ClipsDescendants = true
        local NotifCorner = Instance.new("UICorner")
        NotifCorner.CornerRadius = UDim.new(0, 6)
        NotifCorner.Parent = Notification
        local NotifAccent = Instance.new("Frame")
        NotifAccent.Name = "Accent"
        NotifAccent.Parent = Notification
        NotifAccent.BackgroundColor3 = CurrentTheme.Accent
        NotifAccent.Size = UDim2.new(0, 4, 1, 0)
        local NotifText = Instance.new("TextLabel")
        NotifText.Parent = Notification
        NotifText.BackgroundTransparency = 1
        NotifText.Position = UDim2.new(0, 15, 0, 0)
        NotifText.Size = UDim2.new(1, -20, 1, 0)
        NotifText.Font = Enum.Font.GothamMedium
        NotifText.Text = content
        NotifText.TextColor3 = CurrentTheme.Text
        NotifText.TextSize = 13
        NotifText.TextXAlignment = Enum.TextXAlignment.Left
        Library:Tween(Notification, 0.4, {Size = UDim2.new(1, 0, 0, 40)})
        task.delay(duration, function()
            Library:Tween(Notification, 0.4, {Size = UDim2.new(0, 0, 0, 40)})
            task.wait(0.4)
            Notification:Destroy()
        end)
    end
    function Window:SetTheme(newTheme)
        CurrentTheme = newTheme
        Main.BackgroundColor3 = CurrentTheme.Background
        Sidebar.BackgroundColor3 = CurrentTheme.Sidebar
        Title.TextColor3 = CurrentTheme.Accent
        for _, tab in ipairs(Window.Tabs) do
            tab.Button.TextColor3 = (Window.CurrentTab and Window.CurrentTab.Button == tab.Button) and CurrentTheme.Accent or CurrentTheme.TextDark
            if Window.CurrentTab and Window.CurrentTab.Button == tab.Button then
                tab.Button.BackgroundTransparency = 0.8
                tab.Button.BackgroundColor3 = CurrentTheme.Accent
            end
            for _, section in ipairs(tab.Sections) do
                section.Frame.BackgroundColor3 = CurrentTheme.Section
                section.Title.TextColor3 = CurrentTheme.Text
                for _, element in ipairs(section.Elements) do
                    if element.Type == "Button" then
                        element.Instance.BackgroundColor3 = CurrentTheme.Outline
                        element.Instance.TextColor3 = CurrentTheme.Text
                    elseif element.Type == "Toggle" then
                        element.Title.TextColor3 = element.Toggled and CurrentTheme.Text or CurrentTheme.TextDark
                        element.Box.BackgroundColor3 = element.Toggled and CurrentTheme.Accent or CurrentTheme.Outline
                    elseif element.Type == "Slider" then
                        element.Title.TextColor3 = CurrentTheme.TextDark
                        element.ValueLabel.TextColor3 = CurrentTheme.Accent
                        element.Bar.BackgroundColor3 = CurrentTheme.Outline
                        element.Fill.BackgroundColor3 = CurrentTheme.Accent
                    elseif element.Type == "Dropdown" then
                        element.Frame.BackgroundColor3 = CurrentTheme.Outline
                        element.Title.TextColor3 = CurrentTheme.TextDark
                    end
                end
            end
        end
    end
    local Dragging, DragInput, DragStart, StartPos
    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = input.Position
            StartPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then Dragging = false end
            end)
        end
    end)
    Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then DragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            local Delta = input.Position - DragStart
            Main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
        end
    end)
    function Window:Toggle()
        Window.Visible = not Window.Visible
        Main.Visible = Window.Visible
    end
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then Window:Toggle() end
    end)
    function Window:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = CurrentTheme.Accent
        TabButton.BackgroundTransparency = 1
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.Text = "   " .. name
        TabButton.TextColor3 = CurrentTheme.TextDark
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.AutoButtonColor = false
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 4)
        TabCorner.Parent = TabButton
        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Name = name .. "Frame"
        TabFrame.Parent = ContentContainer
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.Visible = false
        TabFrame.ScrollBarThickness = 2
        TabFrame.ScrollBarImageColor3 = CurrentTheme.Accent
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        local TabLayout = Instance.new("UIListLayout")
        TabLayout.Parent = TabFrame
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 10)
        local TabPadding = Instance.new("UIPadding")
        TabPadding.Parent = TabFrame
        TabPadding.PaddingLeft = UDim.new(0, 5)
        TabPadding.PaddingRight = UDim.new(0, 5)
        TabPadding.PaddingTop = UDim.new(0, 5)
        local Tab = {Sections = {}, Button = TabButton, Frame = TabFrame}
        function Tab:Select()
            if Window.CurrentTab then
                Library:Tween(Window.CurrentTab.Button, 0.2, {BackgroundTransparency = 1, TextColor3 = CurrentTheme.TextDark})
                Window.CurrentTab.Frame.Visible = false
            end
            Window.CurrentTab = Tab
            Library:Tween(TabButton, 0.2, {BackgroundTransparency = 0.8, TextColor3 = CurrentTheme.Accent})
            TabFrame.Visible = true
        end
        TabButton.MouseButton1Click:Connect(function() Tab:Select() end)
        if #Window.Tabs == 0 then Tab:Select() end
        function Tab:CreateSection(name)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = name .. "Section"
            SectionFrame.Parent = TabFrame
            SectionFrame.BackgroundColor3 = CurrentTheme.Section
            SectionFrame.BorderSizePixel = 0
            SectionFrame.Size = UDim2.new(1, 0, 0, 40)
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 6)
            SectionCorner.Parent = SectionFrame
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 10, 0, 10)
            SectionTitle.Size = UDim2.new(1, -20, 0, 20)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = name:upper()
            SectionTitle.TextColor3 = CurrentTheme.Text
            SectionTitle.TextSize = 12
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "Content"
            SectionContent.Parent = SectionFrame
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 0, 0, 35)
            SectionContent.Size = UDim2.new(1, 0, 1, -35)
            local SectionList = Instance.new("UIListLayout")
            SectionList.Parent = SectionContent
            SectionList.SortOrder = Enum.SortOrder.LayoutOrder
            SectionList.Padding = UDim.new(0, 5)
            local SectionPadding = Instance.new("UIPadding")
            SectionPadding.Parent = SectionContent
            SectionPadding.PaddingLeft = UDim.new(0, 10)
            SectionPadding.PaddingRight = UDim.new(0, 10)
            SectionPadding.PaddingBottom = UDim.new(0, 10)
            local Section = {Elements = {}, Frame = SectionFrame, Title = SectionTitle}
            local function UpdateSectionSize()
                SectionFrame.Size = UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y + 45)
                TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 20)
            end
            SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSectionSize)
            function Section:CreateButton(name, callback)
                local Button = Instance.new("TextButton")
                Button.Parent = SectionContent
                Button.BackgroundColor3 = CurrentTheme.Outline
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 0, 30)
                Button.Font = Enum.Font.GothamMedium
                Button.Text = name
                Button.TextColor3 = CurrentTheme.Text
                Button.TextSize = 13
                Button.AutoButtonColor = false
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = Button
                Button.MouseEnter:Connect(function() Library:Tween(Button, 0.2, {BackgroundColor3 = CurrentTheme.Accent, BackgroundTransparency = 0.7}) end)
                Button.MouseLeave:Connect(function() Library:Tween(Button, 0.2, {BackgroundColor3 = CurrentTheme.Outline, BackgroundTransparency = 0}) end)
                Button.MouseButton1Click:Connect(function() callback() end)
                table.insert(Section.Elements, {Type = "Button", Instance = Button})
            end
            function Section:CreateToggle(name, default, callback)
                local ToggleFrame = Instance.new("TextButton")
                ToggleFrame.Parent = SectionContent
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
                ToggleFrame.Text = ""
                local ToggleTitle = Instance.new("TextLabel")
                ToggleTitle.Parent = ToggleFrame
                ToggleTitle.BackgroundTransparency = 1
                ToggleTitle.Size = UDim2.new(1, -40, 1, 0)
                ToggleTitle.Font = Enum.Font.GothamMedium
                ToggleTitle.Text = name
                ToggleTitle.TextColor3 = CurrentTheme.TextDark
                ToggleTitle.TextSize = 13
                ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
                local Box = Instance.new("Frame")
                Box.Parent = ToggleFrame
                Box.BackgroundColor3 = CurrentTheme.Outline
                Box.Position = UDim2.new(1, -35, 0.5, -10)
                Box.Size = UDim2.new(0, 35, 0, 20)
                local BoxCorner = Instance.new("UICorner")
                BoxCorner.CornerRadius = UDim.new(1, 0)
                BoxCorner.Parent = Box
                local Indicator = Instance.new("Frame")
                Indicator.Parent = Box
                Indicator.BackgroundColor3 = CurrentTheme.TextDark
                Indicator.Position = UDim2.new(0, 2, 0.5, -8)
                Indicator.Size = UDim2.new(0, 16, 0, 16)
                local IndicatorCorner = Instance.new("UICorner")
                IndicatorCorner.CornerRadius = UDim.new(1, 0)
                IndicatorCorner.Parent = Indicator
                local Toggled = default or false
                local elementData = {Type = "Toggle", Title = ToggleTitle, Box = Box, Toggled = Toggled}
                local function Update()
                    elementData.Toggled = Toggled
                    if Toggled then
                        Library:Tween(Box, 0.2, {BackgroundColor3 = CurrentTheme.Accent})
                        Library:Tween(Indicator, 0.2, {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.new(1,1,1)})
                        Library:Tween(ToggleTitle, 0.2, {TextColor3 = CurrentTheme.Text})
                    else
                        Library:Tween(Box, 0.2, {BackgroundColor3 = CurrentTheme.Outline})
                        Library:Tween(Indicator, 0.2, {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = CurrentTheme.TextDark})
                        Library:Tween(ToggleTitle, 0.2, {TextColor3 = CurrentTheme.TextDark})
                    end
                    callback(Toggled)
                end
                ToggleFrame.MouseButton1Click:Connect(function() Toggled = not Toggled Update() end)
                Update()
                table.insert(Section.Elements, elementData)
            end
            function Section:CreateSlider(name, min, max, default, callback)
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Parent = SectionContent
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Size = UDim2.new(1, 0, 0, 45)
                local SliderTitle = Instance.new("TextLabel")
                SliderTitle.Parent = SliderFrame
                SliderTitle.BackgroundTransparency = 1
                SliderTitle.Size = UDim2.new(1, 0, 0, 20)
                SliderTitle.Font = Enum.Font.GothamMedium
                SliderTitle.Text = name
                SliderTitle.TextColor3 = CurrentTheme.TextDark
                SliderTitle.TextSize = 13
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                local SliderValue = Instance.new("TextLabel")
                SliderValue.Parent = SliderFrame
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(1, -50, 0, 0)
                SliderValue.Size = UDim2.new(0, 50, 0, 20)
                SliderValue.Font = Enum.Font.GothamMedium
                SliderValue.Text = tostring(default)
                SliderValue.TextColor3 = CurrentTheme.Accent
                SliderValue.TextSize = 13
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                local SliderBar = Instance.new("Frame")
                SliderBar.Parent = SliderFrame
                SliderBar.BackgroundColor3 = CurrentTheme.Outline
                SliderBar.Position = UDim2.new(0, 0, 0, 25)
                SliderBar.Size = UDim2.new(1, 0, 0, 6)
                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(1, 0)
                BarCorner.Parent = SliderBar
                local Fill = Instance.new("Frame")
                Fill.Parent = SliderBar
                Fill.BackgroundColor3 = CurrentTheme.Accent
                Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(1, 0)
                FillCorner.Parent = Fill
                local Sliding = false
                local function Move(input)
                    local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    local val = math.floor(min + (max - min) * pos)
                    SliderValue.Text = tostring(val)
                    Library:Tween(Fill, 0.1, {Size = UDim2.new(pos, 0, 1, 0)})
                    callback(val)
                end
                SliderBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then Sliding = true Move(input) end end)
                UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then Sliding = false end end)
                UserInputService.InputChanged:Connect(function(input) if Sliding and input.UserInputType == Enum.UserInputType.MouseMovement then Move(input) end end)
                table.insert(Section.Elements, {Type = "Slider", Title = SliderTitle, ValueLabel = SliderValue, Bar = SliderBar, Fill = Fill})
            end
            function Section:CreateDropdown(name, list, callback)
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Parent = SectionContent
                DropdownFrame.BackgroundColor3 = CurrentTheme.Outline
                DropdownFrame.Size = UDim2.new(1, 0, 0, 30)
                DropdownFrame.ClipsDescendants = true
                local DropdownCorner = Instance.new("UICorner")
                DropdownCorner.CornerRadius = UDim.new(0, 4)
                DropdownCorner.Parent = DropdownFrame
                local DropdownTitle = Instance.new("TextButton")
                DropdownTitle.Parent = DropdownFrame
                DropdownTitle.BackgroundTransparency = 1
                DropdownTitle.Size = UDim2.new(1, 0, 0, 30)
                DropdownTitle.Font = Enum.Font.GothamMedium
                DropdownTitle.Text = "   " .. name
                DropdownTitle.TextColor3 = CurrentTheme.TextDark
                DropdownTitle.TextSize = 13
                DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
                local Arrow = Instance.new("TextLabel")
                Arrow.Parent = DropdownTitle
                Arrow.BackgroundTransparency = 1
                Arrow.Position = UDim2.new(1, -25, 0, 0)
                Arrow.Size = UDim2.new(0, 20, 1, 0)
                Arrow.Font = Enum.Font.GothamMedium
                Arrow.Text = ">"
                Arrow.TextColor3 = CurrentTheme.TextDark
                Arrow.TextSize = 14
                Arrow.Rotation = 90
                local ItemContainer = Instance.new("Frame")
                ItemContainer.Parent = DropdownFrame
                ItemContainer.BackgroundTransparency = 1
                ItemContainer.Position = UDim2.new(0, 0, 0, 30)
                ItemContainer.Size = UDim2.new(1, 0, 0, 0)
                local ItemList = Instance.new("UIListLayout")
                ItemList.Parent = ItemContainer
                ItemList.SortOrder = Enum.SortOrder.LayoutOrder
                local Open = false
                DropdownTitle.MouseButton1Click:Connect(function()
                    Open = not Open
                    local targetSize = Open and (35 + #list * 25) or 30
                    Library:Tween(DropdownFrame, 0.3, {Size = UDim2.new(1, 0, 0, targetSize)})
                    Library:Tween(Arrow, 0.3, {Rotation = Open and 270 or 90})
                end)
                for _, v in ipairs(list) do
                    local Item = Instance.new("TextButton")
                    Item.Parent = ItemContainer
                    Item.BackgroundTransparency = 1
                    Item.Size = UDim2.new(1, 0, 0, 25)
                    Item.Font = Enum.Font.GothamMedium
                    Item.Text = v
                    Item.TextColor3 = CurrentTheme.TextDark
                    Item.TextSize = 12
                    Item.MouseEnter:Connect(function() Library:Tween(Item, 0.2, {TextColor3 = CurrentTheme.Accent}) end)
                    Item.MouseLeave:Connect(function() Library:Tween(Item, 0.2, {TextColor3 = CurrentTheme.TextDark}) end)
                    Item.MouseButton1Click:Connect(function()
                        DropdownTitle.Text = "   " .. v
                        Open = false
                        Library:Tween(DropdownFrame, 0.3, {Size = UDim2.new(1, 0, 0, 30)})
                        Library:Tween(Arrow, 0.3, {Rotation = 90})
                        callback(v)
                    end)
                end
                table.insert(Section.Elements, {Type = "Dropdown", Frame = DropdownFrame, Title = DropdownTitle})
            end
            function Section:CreateKeybind(name, default, callback)
                local KeybindFrame = Instance.new("Frame")
                KeybindFrame.Parent = SectionContent
                KeybindFrame.BackgroundTransparency = 1
                KeybindFrame.Size = UDim2.new(1, 0, 0, 30)
                local KeybindTitle = Instance.new("TextLabel")
                KeybindTitle.Parent = KeybindFrame
                KeybindTitle.BackgroundTransparency = 1
                KeybindTitle.Size = UDim2.new(1, -60, 1, 0)
                KeybindTitle.Font = Enum.Font.GothamMedium
                KeybindTitle.Text = name
                KeybindTitle.TextColor3 = CurrentTheme.TextDark
                KeybindTitle.TextSize = 13
                KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left
                local BindButton = Instance.new("TextButton")
                BindButton.Parent = KeybindFrame
                BindButton.BackgroundColor3 = CurrentTheme.Outline
                BindButton.Position = UDim2.new(1, -60, 0.5, -10)
                BindButton.Size = UDim2.new(0, 60, 0, 20)
                BindButton.Font = Enum.Font.GothamMedium
                BindButton.Text = default.Name
                BindButton.TextColor3 = CurrentTheme.Text
                BindButton.TextSize = 11
                local BindCorner = Instance.new("UICorner")
                BindCorner.CornerRadius = UDim.new(0, 4)
                BindCorner.Parent = BindButton
                local Binding = false
                BindButton.MouseButton1Click:Connect(function() Binding = true BindButton.Text = "..." end)
                UserInputService.InputBegan:Connect(function(input) if Binding and input.UserInputType == Enum.UserInputType.Keyboard then Binding = false BindButton.Text = input.KeyCode.Name callback(input.KeyCode) end end)
            end
            function Section:CreateColorpicker(name, default, callback)
                local ColorpickerFrame = Instance.new("Frame")
                ColorpickerFrame.Parent = SectionContent
                ColorpickerFrame.BackgroundTransparency = 1
                ColorpickerFrame.Size = UDim2.new(1, 0, 0, 30)
                local ColorTitle = Instance.new("TextLabel")
                ColorTitle.Parent = ColorpickerFrame
                ColorTitle.BackgroundTransparency = 1
                ColorTitle.Size = UDim2.new(1, -40, 1, 0)
                ColorTitle.Font = Enum.Font.GothamMedium
                ColorTitle.Text = name
                ColorTitle.TextColor3 = CurrentTheme.TextDark
                ColorTitle.TextSize = 13
                ColorTitle.TextXAlignment = Enum.TextXAlignment.Left
                local ColorButton = Instance.new("TextButton")
                ColorButton.Parent = ColorpickerFrame
                ColorButton.BackgroundColor3 = default
                ColorButton.Position = UDim2.new(1, -35, 0.5, -10)
                ColorButton.Size = UDim2.new(0, 35, 0, 20)
                ColorButton.Text = ""
                local ColorCorner = Instance.new("UICorner")
                ColorCorner.CornerRadius = UDim.new(0, 4)
                ColorCorner.Parent = ColorButton
                ColorButton.MouseButton1Click:Connect(function() local r, g, b = math.random(), math.random(), math.random() local newColor = Color3.new(r, g, b) ColorButton.BackgroundColor3 = newColor callback(newColor) end)
            end
            table.insert(Tab.Sections, Section)
            return Section
        end
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    local KeybindList = Instance.new("Frame")
    KeybindList.Parent = ScreenGui
    KeybindList.BackgroundColor3 = CurrentTheme.Background
    KeybindList.Position = UDim2.new(0, 20, 0.5, -100)
    KeybindList.Size = UDim2.new(0, 150, 0, 30)
    KeybindList.Visible = false
    local KeybindListCorner = Instance.new("UICorner")
    KeybindListCorner.CornerRadius = UDim.new(0, 6)
    KeybindListCorner.Parent = KeybindList
    local KeybindListTitle = Instance.new("TextLabel")
    KeybindListTitle.Parent = KeybindList
    KeybindListTitle.BackgroundTransparency = 1
    KeybindListTitle.Size = UDim2.new(1, 0, 0, 30)
    KeybindListTitle.Font = Enum.Font.GothamBold
    KeybindListTitle.Text = "KEYBINDS"
    KeybindListTitle.TextColor3 = CurrentTheme.Accent
    KeybindListTitle.TextSize = 12
    local KeybindContainer = Instance.new("Frame")
    KeybindContainer.Parent = KeybindList
    KeybindContainer.BackgroundTransparency = 1
    KeybindContainer.Position = UDim2.new(0, 0, 0, 30)
    KeybindContainer.Size = UDim2.new(1, 0, 1, -30)
    local KeybindListLayout = Instance.new("UIListLayout")
    KeybindListLayout.Parent = KeybindContainer
    KeybindListLayout.Padding = UDim.new(0, 5)
    function Window:SetKeybindListVisible(visible) KeybindList.Visible = visible end
    function Window:AddKeybindToList(name, key)
        local Item = Instance.new("Frame")
        Item.Parent = KeybindContainer
        Item.BackgroundTransparency = 1
        Item.Size = UDim2.new(1, 0, 0, 20)
        local NameLabel = Instance.new("TextLabel")
        NameLabel.Parent = Item
        NameLabel.BackgroundTransparency = 1
        NameLabel.Position = UDim2.new(0, 10, 0, 0)
        NameLabel.Size = UDim2.new(0.6, 0, 1, 0)
        NameLabel.Font = Enum.Font.Gotham
        NameLabel.Text = name
        NameLabel.TextColor3 = CurrentTheme.Text
        NameLabel.TextSize = 11
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        local KeyLabel = Instance.new("TextLabel")
        KeyLabel.Parent = Item
        KeyLabel.BackgroundTransparency = 1
        KeyLabel.Position = UDim2.new(0.6, 0, 0, 0)
        KeyLabel.Size = UDim2.new(0.4, -10, 1, 0)
        KeyLabel.Font = Enum.Font.Gotham
        KeyLabel.Text = "[" .. key .. "]"
        KeyLabel.TextColor3 = CurrentTheme.TextDark
        KeyLabel.TextSize = 11
        KeyLabel.TextXAlignment = Enum.TextXAlignment.Right
        KeybindList.Size = UDim2.new(0, 150, 0, 35 + KeybindListLayout.AbsoluteContentSize.Y)
    end
    return Window
end
return Library

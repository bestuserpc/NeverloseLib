local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bestuserpc/NeverloseLib/refs/heads/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/bestuserpc/NeverloseLib/refs/heads/main/ThemeManager.lua"))()

local Window = Library:CreateWindow({
    Name = "Neverlose.cc",
    Theme = ThemeManager:GetTheme("Default")
})

local Tabs = {
    Main = Window:CreateTab("Main"),
    Visuals = Window:CreateTab("Visuals"),
    Settings = Window:CreateTab("Settings")
}

-- Settings Tab (Theme Selection)
local ThemeSection = Tabs.Settings:CreateSection("Theme Settings")

local themeNames = {}
for name, _ in pairs(ThemeManager.Themes) do
    table.insert(themeNames, name)
end

ThemeSection:CreateDropdown("UI Theme", themeNames, function(selected)
    local newTheme = ThemeManager:GetTheme(selected)
    Window:SetTheme(newTheme)
    Window:Notify({
        Text = "Theme changed to " .. selected,
        Duration = 3
    })
end)

-- Main Tab
local AimbotSection = Tabs.Main:CreateSection("Aimbot")
AimbotSection:CreateToggle("Enable Aimbot", false, function(state)
    print("Aimbot:", state)
end)

AimbotSection:CreateSlider("Aimbot FOV", 0, 180, 90, function(val)
    print("FOV:", val)
end)

-- Visuals Tab
local EspSection = Tabs.Visuals:CreateSection("Player ESP")
EspSection:CreateToggle("Box ESP", true, function(state)
    print("Box ESP:", state)
end)

EspSection:CreateColorpicker("ESP Color", Color3.fromRGB(0, 170, 255), function(color)
    print("ESP Color changed:", color)
end)

-- Keybind List Example
Window:SetKeybindListVisible(true)
Window:AddKeybindToList("Aimbot", "V")

Window:Notify({
    Text = "Neverlose.cc loaded successfully!",
    Duration = 5
})

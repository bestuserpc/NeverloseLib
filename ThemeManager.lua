local ThemeManager = {}
ThemeManager.Themes = {
    Default = {
        Background = Color3.fromRGB(8, 8, 10),
        Sidebar = Color3.fromRGB(12, 12, 15),
        Section = Color3.fromRGB(15, 15, 20),
        Accent = Color3.fromRGB(0, 170, 255),
        Text = Color3.fromRGB(220, 220, 220),
        TextDark = Color3.fromRGB(150, 150, 150),
        Outline = Color3.fromRGB(30, 30, 35)
    },
    Midnight = {
        Background = Color3.fromRGB(5, 5, 5),
        Sidebar = Color3.fromRGB(8, 8, 8),
        Section = Color3.fromRGB(10, 10, 12),
        Accent = Color3.fromRGB(180, 0, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(120, 120, 120),
        Outline = Color3.fromRGB(20, 20, 25)
    },
    Acid = {
        Background = Color3.fromRGB(10, 15, 10),
        Sidebar = Color3.fromRGB(15, 20, 15),
        Section = Color3.fromRGB(20, 25, 20),
        Accent = Color3.fromRGB(150, 255, 0),
        Text = Color3.fromRGB(220, 255, 220),
        TextDark = Color3.fromRGB(100, 150, 100),
        Outline = Color3.fromRGB(30, 40, 30)
    },
    Valentine = {
        Background = Color3.fromRGB(15, 10, 12),
        Sidebar = Color3.fromRGB(20, 15, 17),
        Section = Color3.fromRGB(25, 20, 22),
        Accent = Color3.fromRGB(255, 100, 150),
        Text = Color3.fromRGB(255, 220, 230),
        TextDark = Color3.fromRGB(150, 100, 120),
        Outline = Color3.fromRGB(40, 30, 35)
    }
}
function ThemeManager:GetTheme(name)
    return self.Themes[name] or self.Themes.Default
end
return ThemeManager

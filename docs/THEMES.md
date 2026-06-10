# Themes

CursedPaint ships with eight themes:

- `Cursed`
- `Gojo`
- `Sukuna`
- `Megumi`
- `Nobara`
- `Manga`
- `Candy`
- `Void`

Set a theme when creating the window:

```lua
local Window = CursedPaint:CreateWindow({
	Title = "Testing UI",
	Theme = "Cursed",
})
```

Change it later:

```lua
Window:SetTheme("Manga")
```

Add a theme dropdown:

```lua
local Settings = Window:CreateTab("Settings")
Settings:ThemeDropdown("Theme")
```

## Custom Theme

Add a new theme before creating your window:

```lua
CursedPaint.Themes.MyTheme = {
	Background = Color3.fromRGB(18, 18, 22),
	Panel = Color3.fromRGB(31, 31, 38),
	PanelAlt = Color3.fromRGB(44, 44, 54),
	Ink = Color3.fromRGB(245, 240, 230),
	Muted = Color3.fromRGB(170, 160, 150),
	Accent = Color3.fromRGB(255, 90, 110),
	AccentAlt = Color3.fromRGB(255, 205, 95),
	Good = Color3.fromRGB(100, 220, 135),
	Bad = Color3.fromRGB(255, 90, 90),
	Stroke = Color3.fromRGB(8, 8, 10),
	Shadow = Color3.fromRGB(0, 0, 0),
}

local Window = CursedPaint:CreateWindow({
	Theme = "MyTheme",
})
```

## Color Keys

- `Background`: main window background.
- `Panel`: normal cards and header.
- `PanelAlt`: inputs, tracks, secondary cards.
- `Ink`: primary text.
- `Muted`: secondary text.
- `Accent`: buttons, active tabs, section bars.
- `AccentAlt`: slider/progress highlights and extra emphasis.
- `Good`: enabled toggles.
- `Bad`: error/negative color.
- `Stroke`: chunky border color.
- `Shadow`: window shadow color.

# Themes

CursedPaint ships with seven themes:

- `Dark` default
- `Paper`
- `Smoke`
- `Blood`
- `Void`
- `Forest`
- `Candy`

Set a theme when creating the window:

```lua
local Window = CursedPaint:CreateWindow({
	Theme = "Dark",
})
```

Change it later:

```lua
Window:SetTheme("Blood")
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
	Backdrop = Color3.fromRGB(11, 12, 16),
	Left = Color3.fromRGB(17, 19, 26),
	Panel = Color3.fromRGB(27, 29, 38),
	PanelAlt = Color3.fromRGB(37, 40, 51),
	Text = Color3.fromRGB(246, 241, 232),
	Muted = Color3.fromRGB(170, 164, 154),
	Ink = Color3.fromRGB(2, 3, 6),
	SelectedTop = Color3.fromRGB(74, 79, 102),
	SelectedBottom = Color3.fromRGB(132, 82, 126),
	Bar = Color3.fromRGB(57, 62, 78),
	BarFill = Color3.fromRGB(26, 203, 246),
	Good = Color3.fromRGB(76, 220, 128),
	Bad = Color3.fromRGB(238, 81, 90),
	PanelTransparency = 0.02,
	RowTransparency = 0.04,
	Radius = 10,
	StrokeThickness = 1.4,
}

local Window = CursedPaint:CreateWindow({
	Theme = "MyTheme",
})
```

## Color Keys

- `Backdrop`: outer board color.
- `Left`: left tab menu color.
- `Panel`: control row color.
- `PanelAlt`: input and secondary color.
- `Text`: main text color.
- `Muted`: helper text color.
- `Ink`: border color.
- `SelectedTop`: selected tab gradient top.
- `SelectedBottom`: selected tab gradient bottom.
- `Bar`: progress track color.
- `BarFill`: progress fill color.
- `Good`: enabled state color.
- `Bad`: negative/error color.
- `PanelTransparency`: outer board transparency.
- `RowTransparency`: control row transparency.
- `Radius`: corner radius in pixels.
- `StrokeThickness`: default border thickness.

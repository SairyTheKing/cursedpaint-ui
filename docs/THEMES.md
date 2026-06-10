# Themes

CursedPaint ships with six paper-menu themes:

- `Paper`
- `Smoke`
- `Blood`
- `Void`
- `Forest`
- `Candy`

Set a theme when creating the window:

```lua
local Window = CursedPaint:CreateWindow({
	Theme = "Paper",
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
	Backdrop = Color3.fromRGB(226, 224, 215),
	Left = Color3.fromRGB(238, 235, 204),
	Panel = Color3.fromRGB(245, 244, 238),
	PanelAlt = Color3.fromRGB(223, 221, 214),
	Text = Color3.fromRGB(18, 18, 18),
	Muted = Color3.fromRGB(60, 60, 60),
	Ink = Color3.fromRGB(0, 0, 0),
	SelectedTop = Color3.fromRGB(255, 246, 158),
	SelectedBottom = Color3.fromRGB(214, 98, 62),
	Bar = Color3.fromRGB(103, 103, 99),
	BarFill = Color3.fromRGB(21, 205, 244),
	Good = Color3.fromRGB(61, 183, 100),
	Bad = Color3.fromRGB(215, 65, 65),
	PanelTransparency = 0.24,
	RowTransparency = 0.12,
}

local Window = CursedPaint:CreateWindow({
	Theme = "MyTheme",
})
```

## Color Keys

- `Backdrop`: outer board color.
- `Left`: left tab menu color.
- `Panel`: quest/control row color.
- `PanelAlt`: input/secondary color.
- `Text`: main text color.
- `Muted`: small helper text color.
- `Ink`: black sketch border color.
- `SelectedTop`: selected tab gradient top.
- `SelectedBottom`: selected tab gradient bottom.
- `Bar`: progress track color.
- `BarFill`: progress fill color.
- `Good`: enabled state color.
- `Bad`: negative/error color.
- `PanelTransparency`: outer board transparency.
- `RowTransparency`: control row transparency.

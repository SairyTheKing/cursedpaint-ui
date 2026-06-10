# Themes

CursedPaint ships with eight themes:

- `Brawl` default
- `Dark`
- `Paper`
- `Smoke`
- `Blood`
- `Void`
- `Forest`
- `Candy`

Set a theme when creating the window:

```lua
local Window = CursedPaint:CreateWindow({
	Theme = "Brawl",
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
	Backdrop = Color3.fromRGB(35, 35, 38),
	Left = Color3.fromRGB(232, 226, 176),
	Panel = Color3.fromRGB(238, 238, 231),
	PanelAlt = Color3.fromRGB(204, 205, 199),
	Text = Color3.fromRGB(13, 13, 13),
	Muted = Color3.fromRGB(47, 47, 47),
	Ink = Color3.fromRGB(0, 0, 0),
	SelectedTop = Color3.fromRGB(255, 246, 143),
	SelectedBottom = Color3.fromRGB(213, 93, 58),
	Bar = Color3.fromRGB(88, 88, 86),
	BarFill = Color3.fromRGB(18, 203, 245),
	Good = Color3.fromRGB(69, 190, 102),
	Bad = Color3.fromRGB(220, 67, 70),
	PanelTransparency = 0.16,
	RowTransparency = 0.08,
	TextureTransparency = 0.8,
	GlowTransparency = 0.78,
	Radius = 9,
	StrokeThickness = 1.8,
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
- `TextureTransparency`: subtle inner paper/glass overlay transparency.
- `GlowTransparency`: subtle accent glow transparency.
- `Radius`: corner radius in pixels.
- `StrokeThickness`: default border thickness.

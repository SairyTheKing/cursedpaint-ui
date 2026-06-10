# Theme

CursedPaint now ships with one default style:

- `JJS`

It is a sketch-menu style with thick black outlines, a pale yellow side menu, white/gray paper rows, yellow-orange selected tabs, and cyan progress bars.

```lua
local Window = CursedPaint:CreateWindow({
	Title = "CursedPaint",
})
```

`Window:SetTheme(...)` still exists for old scripts, but it always reapplies the single `JJS` style.

## Style Keys

```lua
CursedPaint.Themes.JJS = {
	Backdrop = Color3.fromRGB(104, 103, 99),
	Left = Color3.fromRGB(249, 244, 184),
	Panel = Color3.fromRGB(248, 247, 238),
	PanelAlt = Color3.fromRGB(220, 219, 208),
	Text = Color3.fromRGB(8, 8, 8),
	Muted = Color3.fromRGB(34, 34, 34),
	Ink = Color3.fromRGB(0, 0, 0),
	SelectedTop = Color3.fromRGB(255, 246, 124),
	SelectedBottom = Color3.fromRGB(210, 89, 52),
	Bar = Color3.fromRGB(92, 92, 88),
	BarFill = Color3.fromRGB(10, 204, 245),
	PanelTransparency = 0.24,
	RowTransparency = 0.03,
	Radius = 7,
	StrokeThickness = 4,
	ThinStrokeThickness = 3,
}
```

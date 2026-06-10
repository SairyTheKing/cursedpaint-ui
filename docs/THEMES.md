# Theme

CursedPaint now ships with one default style:

- `JJS`

It is a sketch-menu style with clean ink outlines, a pale yellow side menu, white/gray paper rows, yellow-orange selected tabs, and cyan progress bars.

```lua
local Window = CursedPaint:CreateWindow({
	Title = "CursedPaint",
})
```

`Window:SetTheme(...)` still exists for old scripts, but it always reapplies the single `JJS` style.

## Style Keys

```lua
CursedPaint.Themes.JJS = {
	Backdrop = Color3.fromRGB(132, 132, 126),
	Left = Color3.fromRGB(244, 241, 178),
	Panel = Color3.fromRGB(246, 245, 236),
	PanelAlt = Color3.fromRGB(221, 221, 210),
	Text = Color3.fromRGB(8, 8, 8),
	Muted = Color3.fromRGB(34, 34, 34),
	Ink = Color3.fromRGB(0, 0, 0),
	SelectedTop = Color3.fromRGB(255, 246, 124),
	SelectedBottom = Color3.fromRGB(210, 89, 52),
	Bar = Color3.fromRGB(92, 92, 88),
	BarFill = Color3.fromRGB(10, 204, 245),
	PanelTransparency = 0.08,
	ContentTransparency = 0.18,
	RowTransparency = 0.08,
	Radius = 4,
	StrokeThickness = 2,
	ThinStrokeThickness = 1,
}
```

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
	Backdrop = Color3.fromRGB(115, 115, 112),
	Left = Color3.fromRGB(246, 241, 183),
	Panel = Color3.fromRGB(242, 242, 235),
	PanelAlt = Color3.fromRGB(190, 190, 184),
	Text = Color3.fromRGB(8, 8, 8),
	Muted = Color3.fromRGB(34, 34, 34),
	Ink = Color3.fromRGB(0, 0, 0),
	SelectedTop = Color3.fromRGB(255, 246, 124),
	SelectedBottom = Color3.fromRGB(210, 89, 52),
	Bar = Color3.fromRGB(92, 92, 88),
	BarFill = Color3.fromRGB(10, 204, 245),
	PanelTransparency = 0.32,
	RowTransparency = 0.1,
	Radius = 5,
	StrokeThickness = 3,
	ThinStrokeThickness = 2,
}
```

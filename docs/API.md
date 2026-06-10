# API

## Create Window

```lua
local Window = CursedPaint:CreateWindow({
	Theme = "Paper",
	Size = UDim2.fromOffset(650, 370),
	Position = UDim2.fromScale(0.5, 0.5),
	ToggleKey = Enum.KeyCode.RightControl,
	ConfigFolder = "CursedPaintUI",
})
```

Options:

- `Theme`: theme name.
- `Size`: board size.
- `Position`: board position.
- `ToggleKey`: key that hides/shows the UI.
- `ConfigFolder`: folder used by `SaveConfig` when file APIs exist.

## Tabs

```lua
local Daily = Window:CreateTab("Daily")
```

Tabs appear on the left side as vertical text buttons.

## Section

```lua
Daily:Section("Daily")
```

## Label

```lua
local Label = Daily:Label("Refreshes in: 7h 29m 23s")
Label:Set("Refreshes in: 1h 10m 02s")
```

## Paragraph

```lua
Daily:Paragraph({
	Title = "Info",
	Content = "Longer text goes here.",
})
```

## Quest

```lua
local Quest = Daily:Quest({
	Title = "Roll 15 times",
	Value = 0,
	Max = 15,
})

Quest:Set(8, 15)
```

This creates a large row with:

- title
- `value/max` counter
- progress bar

## Progress

```lua
local Total = Daily:Progress({
	Title = "Total Progress",
	Value = 50,
	Max = 100,
})

Total:Set(75)
```

## Button

```lua
Daily:Button({
	Title = "Claim Reward",
	ButtonText = "CLAIM",
	Callback = function()
		print("clicked")
	end,
})
```

## Toggle

```lua
local Toggle = Daily:Toggle({
	Title = "Auto Sprint",
	Flag = "auto_sprint",
	Default = true,
	Callback = function(value)
		print(value)
	end,
})

Toggle:Set(false)
print(Toggle:Get())
```

## Slider

```lua
local Slider = Daily:Slider({
	Title = "Volume",
	Flag = "volume",
	Min = 0,
	Max = 100,
	Step = 5,
	Default = 50,
	Callback = function(value)
		print(value)
	end,
})

Slider:Set(80)
```

## Dropdown

```lua
local Dropdown = Daily:Dropdown({
	Title = "Mode",
	Flag = "mode",
	Options = { "Casual", "Ranked", "Private" },
	Default = "Casual",
	Callback = function(value)
		print(value)
	end,
})

Dropdown:Set("Ranked")
```

## Textbox

```lua
Daily:Textbox({
	Title = "Shout",
	Flag = "shout",
	Placeholder = "type here",
	Default = "hello",
	Callback = function(text)
		print(text)
	end,
})
```

By default, textbox callbacks run when enter is pressed.

Use `SubmitOnly = false` if you want focus loss to submit too.

## Keybind

```lua
Daily:Keybind({
	Title = "Toggle UI",
	Flag = "toggle_ui",
	Default = Enum.KeyCode.RightControl,
	Pressed = function(key)
		print("pressed", key.Name)
	end,
})
```

## ColorPicker

```lua
Daily:ColorPicker({
	Title = "Bar Color",
	Flag = "bar_color",
	Default = Color3.fromRGB(21, 205, 244),
	Callback = function(color)
		print(color)
	end,
})
```

Saved color flags use hex text like `#15CDF4`.

## Theme Dropdown

```lua
Daily:ThemeDropdown("Theme")
```

## Notifications

```lua
Window:Notify({
	Title = "Loaded",
	Content = "Quest menu loaded.",
	Duration = 3,
})
```

## Themes

```lua
Window:SetTheme("Blood")
local names = Window:GetThemes()
```

## Config

```lua
Window:SaveConfig("default")
Window:LoadConfig("default")
```

Every control with `Flag` saves its value in:

```lua
Window.Flags
```

## Cleanup

```lua
Window:Destroy()
```

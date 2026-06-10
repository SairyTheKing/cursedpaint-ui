# API

## Create Window

```lua
local Window = CursedPaint:CreateWindow({
	Title = "CursedPaint",
	Theme = "Paper",
	Size = UDim2.fromOffset(650, 370),
	Position = UDim2.fromScale(0.5, 0.5),
	BackgroundImage = nil,
	SideImage = CursedPaint.PlaceholderImage,
	ToggleKey = Enum.KeyCode.RightControl,
	ConfigFolder = "CursedPaintUI",
})
```

Options:

- `Theme`: theme name.
- `Size`: board size.
- `Position`: board position.
- `Title`: optional left-menu title.
- `BackgroundImage`: optional full-board image.
- `SideImage`: optional faded image on the content side.
- `BackgroundImageTransparency`: image transparency.
- `SideImageTransparency`: side image transparency.
- `ToggleKey`: key that hides/shows the UI.
- `ConfigFolder`: folder used by `SaveConfig` when file APIs exist.

Change images later:

```lua
Window:SetBackgroundImage("rbxassetid://123456", 0.7)
Window:SetSideImage("rbxassetid://123456", 0.6)
```

## Tabs

```lua
local Daily = Window:CreateTab("Daily")
local Main = Window:AddTab("Main")
```

Tabs appear on the left side as vertical text buttons.

`AddTab` and `CreateTab` are the same.

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

## Image

```lua
Daily:Image({
	Title = "Image Row",
	Caption = "Use any Roblox image asset.",
	Image = "rbxassetid://123456",
	Height = 120,
	ImageTransparency = 0.1,
})
```

## Banner

```lua
Daily:Banner({
	Title = "Banner",
	Image = CursedPaint.PlaceholderImage,
})
```

## Quest

```lua
local Quest = Daily:Quest({
	Title = "Roll 15 times",
	Value = 0,
	Max = 15,
	Image = "rbxassetid://123456",
	ImageTransparency = 0.7,
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
	Icon = "rbxassetid://123456",
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

## Stepper

```lua
local Stepper = Daily:Stepper({
	Title = "Combo Limit",
	Flag = "combo_limit",
	Min = 1,
	Max = 10,
	Step = 1,
	Default = 4,
	Callback = function(value)
		print(value)
	end,
})

Stepper:Set(6)
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

## MultiDropdown

```lua
local Multi = Daily:MultiDropdown({
	Title = "Enabled Moves",
	Flag = "moves",
	Options = { "M1", "Special", "Ultimate", "Dash" },
	Default = { "M1", "Dash" },
	Callback = function(values)
		print(#values)
	end,
})

Multi:Set({ "Special", "Ultimate" })
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

## Add Aliases

Every control also has an `Add...` alias:

```lua
Tab:AddImage(...)
Tab:AddBanner(...)
Tab:AddButton(...)
Tab:AddToggle(...)
Tab:AddSlider(...)
Tab:AddDropdown(...)
Tab:AddMultiDropdown(...)
```

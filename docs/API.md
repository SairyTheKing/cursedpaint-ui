# API

## Create Window

```lua
local Window = CursedPaint:CreateWindow({
	Title = "Testing UI",
	Subtitle = "finger paint panel",
	Theme = "Cursed",
	Size = UDim2.fromOffset(610, 468),
	Position = UDim2.fromOffset(92, 92),
	ToggleKey = Enum.KeyCode.RightControl,
	ConfigFolder = "CursedPaintUI",
})
```

Options:

- `Title`: window title.
- `Subtitle`: small text under the title.
- `Theme`: theme name.
- `Size`: window size.
- `Position`: screen position.
- `ToggleKey`: key that hides/shows the UI.
- `ConfigFolder`: folder used by `SaveConfig` when file APIs exist.

## Tabs

```lua
local Main = Window:CreateTab("Main", "*")
```

## Section

```lua
Main:Section("Combat")
```

## Label

```lua
local Status = Main:Label("Ready")
Status:Set("Loaded")
```

## Paragraph

```lua
Main:Paragraph({
	Title = "Info",
	Content = "Longer text goes here.",
})
```

## Button

```lua
Main:Button({
	Title = "Click Me",
	Description = "Runs a callback.",
	ButtonText = "GO",
	Callback = function()
		print("clicked")
	end,
})
```

## Toggle

```lua
local Toggle = Main:Toggle({
	Title = "Enabled",
	Flag = "enabled",
	Default = false,
	Callback = function(value)
		print(value)
	end,
})

Toggle:Set(true)
print(Toggle:Get())
```

## Slider

```lua
local Slider = Main:Slider({
	Title = "Power",
	Flag = "power",
	Min = 0,
	Max = 100,
	Step = 5,
	Default = 50,
	Callback = function(value)
		print(value)
	end,
})

Slider:Set(75)
```

## Dropdown

```lua
local Dropdown = Main:Dropdown({
	Title = "Mode",
	Flag = "mode",
	Options = { "Calm", "Silly", "Cursed" },
	Default = "Silly",
	Callback = function(value)
		print(value)
	end,
})

Dropdown:Set("Cursed")
```

## Textbox

```lua
Main:Textbox({
	Title = "Message",
	Flag = "message",
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
Main:Keybind({
	Title = "Panic Key",
	Flag = "panic_key",
	Default = Enum.KeyCode.K,
	Pressed = function(key)
		print("pressed", key.Name)
	end,
})
```

## ColorPicker

```lua
Main:ColorPicker({
	Title = "Aura",
	Flag = "aura",
	Default = Color3.fromRGB(255, 82, 92),
	Callback = function(color)
		print(color)
	end,
})
```

Saved color flags use hex text like `#FF525C`.

## Progress

```lua
local Progress = Main:Progress({
	Title = "Cooldown",
	Value = 25,
	Max = 100,
})

Progress:Set(80)
```

## Theme Dropdown

```lua
Main:ThemeDropdown("Theme")
```

## Notifications

```lua
Window:Notify({
	Title = "Loaded",
	Content = "CursedPaint is ready.",
	Duration = 3,
})
```

## Themes

```lua
Window:SetTheme("Gojo")
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

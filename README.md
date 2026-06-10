# CursedPaint UI

CursedPaint UI is a Roblox Luau UI library for testing panels, quest menus, and showcase scripts.

The default style is a flat translucent paper menu with black sketch borders, left-side text tabs, FingerPaint text, and cyan progress bars. It is made to feel closer to a goofy Roblox fighting-game menu while staying original and asset-free.

## Load

```lua
local CursedPaint = loadstring(game:HttpGet("https://raw.githubusercontent.com/SairyTheKing/cursedpaint-ui/main/Source.lua"))()
```

Or put `Source.lua` into Roblox Studio as a ModuleScript:

```lua
local CursedPaint = require(path.to.Source)
```

## Quick Start

```lua
local Window = CursedPaint:CreateWindow({
	Theme = "Paper",
	Size = UDim2.fromOffset(650, 370),
	ToggleKey = Enum.KeyCode.RightControl,
})

local Main = Window:AddTab("Main")

Main:AddToggle({
	Title = "Auto Sprint",
	Flag = "auto_sprint",
	Default = true,
})

Main:AddSlider({
	Title = "Walk Speed",
	Flag = "walk_speed",
	Min = 16,
	Max = 100,
	Step = 1,
	Default = 24,
})
```

Full example: [showcase.client.lua](examples/showcase.client.lua)

## Features

- FingerPaint-style text with fallback font.
- Translucent paper board layout.
- Left-side vertical tabs.
- Draggable window.
- Minimize, close, and toggle key.
- Quest rows with counters and bars.
- Buttons, toggles, sliders, steppers, dropdowns, multi-dropdowns, textboxes, keybinds, and color pickers.
- Notifications.
- Config save/load with `writefile` when available and memory fallback otherwise.
- Themes: `Paper`, `Smoke`, `Blood`, `Void`, `Forest`, `Candy`.

Controls:

- `Section`
- `Label`
- `Paragraph`
- `Quest`
- `Progress`
- `Button`
- `Toggle`
- `Slider`
- `Stepper`
- `Dropdown`
- `MultiDropdown`
- `Textbox`
- `Keybind`
- `ColorPicker`
- `ThemeDropdown`

## Config

Controls with a `Flag` are stored in:

```lua
Window.Flags
```

Save:

```lua
Window:SaveConfig("showcase")
```

Load:

```lua
Window:LoadConfig("showcase")
```

If file APIs are available, config goes to:

```txt
CursedPaintUI/showcase.json
```

If file APIs are not available, config is kept in memory for the current session.

## Docs

- [API](docs/API.md)
- [Themes](docs/THEMES.md)

## Note

This is a testing UI library. It does not include game automation, bypasses, or gameplay logic.

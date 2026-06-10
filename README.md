# CursedPaint UI

CursedPaint UI is a Roblox Luau UI library for testing panels, showcases, and small script tools.

It uses a goofy hand-painted style with `Enum.Font.FingerPaint`, chunky borders, dark panels, loud accents, and theme swapping. It is inspired by silly fighting-game UI energy, but it is an original library.

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
	Title = "Testing UI",
	Subtitle = "finger paint mode",
	Theme = "Cursed",
	ToggleKey = Enum.KeyCode.RightControl,
})

local Tab = Window:CreateTab("Start", "*")

Tab:Button({
	Title = "Bonk",
	ButtonText = "DO IT",
	Callback = function()
		Window:Notify({
			Title = "Bonk",
			Content = "Button pressed.",
		})
	end,
})
```

Full example: [showcase.client.lua](examples/showcase.client.lua)

## Features

- FingerPaint-style title/control text with fallback font.
- Draggable window.
- Minimize, close, and toggle key.
- Tabs.
- Notifications.
- Config save/load with `writefile` when available and memory fallback otherwise.
- Themes: `Cursed`, `Gojo`, `Sukuna`, `Megumi`, `Nobara`, `Manga`, `Candy`, `Void`.
- Controls:
  - `Section`
  - `Label`
  - `Paragraph`
  - `Button`
  - `Toggle`
  - `Slider`
  - `Dropdown`
  - `Textbox`
  - `Keybind`
  - `ColorPicker`
  - `Progress`
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

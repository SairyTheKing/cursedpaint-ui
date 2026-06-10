# CursedPaint UI

[API docs](docs/API.md) | [Themes](docs/THEMES.md) | [Showcase](examples/showcase.client.lua)

CursedPaint UI is a simple Roblox Luau UI library for testing panels, script menus, settings pages, and showcase interfaces.

It uses a dark rounded sketch style by default, with FingerPaint-style text when Roblox supports it. The goal is quick setup, readable code, and enough controls to build a real panel without fighting the API.

## Load

```lua
local CursedPaint = loadstring(game:HttpGet("https://raw.githubusercontent.com/SairyTheKing/cursedpaint-ui/main/loader.lua"))()
```

Direct source load:

```lua
local CursedPaint = loadstring(game:HttpGet("https://raw.githubusercontent.com/SairyTheKing/cursedpaint-ui/main/Source.lua"))()
```

Roblox Studio ModuleScript:

```lua
local CursedPaint = require(path.to.Source)
```

## Quick Start

```lua
local Window = CursedPaint:CreateWindow({
	Title = "CursedPaint",
	Theme = "Dark",
	Size = UDim2.fromOffset(690, 395),
	Resizable = true,
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
	Default = 24,
})
```

## Features

- Dark rounded default theme, plus `Paper`, `Smoke`, `Blood`, `Void`, `Forest`, and `Candy`.
- Draggable, minimizable, closable, toggleable, and resizable window.
- Tabs, sections, labels, paragraphs, images, banners, quests, and progress bars.
- Buttons, toggles, sliders, steppers, dropdowns, multi-dropdowns, textboxes, keybinds, and color pickers.
- Notifications and theme switching.
- Config save/load with `writefile` when available and memory fallback otherwise.
- Image helpers for Roblox asset IDs and HTTP images when executor file APIs exist.

## Images

Use normal Roblox assets when possible:

```lua
Window:SetSideImage("rbxassetid://123456789", 0.65)
```

HTTP images need executor support for `writefile` and `getcustomasset`:

```lua
local image = CursedPaint:DownloadImage("https://example.com/image.png")
Window:SetBackgroundImage(image, 0.75)
```

## Config

```lua
Window:SaveConfig("main")
Window:LoadConfig("main")
```

Controls with a `Flag` are saved into `Window.Flags`.

## Note

This is a testing UI library. It does not include game automation, bypasses, or gameplay logic.

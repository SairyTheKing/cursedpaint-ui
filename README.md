# CursedPaint UI

[API docs](docs/API.md) | [Themes](docs/THEMES.md) | [Showcase](examples/showcase.client.lua)

CursedPaint UI is a simple Roblox Luau UI library for testing panels, script menus, settings pages, and showcase interfaces.

It uses one JJS-style sketch-menu theme by default: clean ink outlines, pale side tabs, paper panels, yellow-orange selected tabs, and cyan progress bars. FingerPaint text is attempted through a Roblox font asset, the bundled GitHub `.ttf`, Roblox `Font.fromName`, family paths, and enum fallback.

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
	Size = UDim2.fromOffset(840, 500),
	Resizable = true,
	Animated = true,
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

- One default `JJS` sketch theme.
- Clean ink outlines across windows, tabs, rows, buttons, inputs, and bars.
- Roomier rows and reserved window-control space to avoid text/control overlap.
- Default `rbxassetid://12187375716` font asset on every text object, with bundled TTF and Roblox fallback.
- Draggable, minimizable, closable, toggleable, and resizable window.
- Animated opening, tab switching, toasts, rows, buttons, and progress bars.
- Tabs, sections, labels, paragraphs, images, banners, quests, and progress bars.
- Buttons, toggles, sliders, steppers, dropdowns, multi-dropdowns, textboxes, keybinds, and color pickers.
- Notifications.
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

## Font

```lua
Window:SetFont("FingerPaint")
print(CursedPaint:GetFontStatus().Method)
```

CursedPaint tries this Roblox font asset first:

```lua
print(CursedPaint.FontAssetId) -- rbxassetid://12187375716
```

If that does not load, CursedPaint can try the bundled TTF:

```lua
print(CursedPaint.FontFileUrl)
```

The TTF fallback needs executor file APIs: `writefile` and `getcustomasset`. To override the default:

```lua
Window:SetFont("rbxassetid://YOUR_FONT_ASSET_ID")
```

## Note

This is a testing UI library. It does not include game automation, bypasses, or gameplay logic.

# API

## Create Window

```lua
local Window = CursedPaint:CreateWindow({
	Title = "CursedPaint",
	Theme = "Dark",
	Size = UDim2.fromOffset(690, 395),
	MinSize = Vector2.new(520, 320),
	Position = UDim2.fromScale(0.5, 0.5),
	Resizable = true,
	BackgroundImage = nil,
	SideImage = nil,
	ToggleKey = Enum.KeyCode.RightControl,
	ConfigFolder = "CursedPaintUI",
	Font = "FingerPaint",
})
```

Options:

- `Theme`: theme name. Default is `Dark`.
- `Size`: window size.
- `MinSize`: resize limit as `Vector2` or offset `UDim2`.
- `Position`: window position.
- `Resizable`: set to `false` to hide the resize handle.
- `Title`: optional left-menu title.
- `BackgroundImage`: optional full-board image.
- `SideImage`: optional faded image on the content side.
- `BackgroundImageTransparency`: background image transparency.
- `SideImageTransparency`: side image transparency.
- `ToggleKey`: key that hides/shows the UI.
- `ConfigFolder`: folder used by `SaveConfig` when file APIs exist.
- `Font`: font enum or enum name string.

Aliases:

```lua
CursedPaint:New(options)
Window:AddTab("Main")
Window:CreateTab("Main")
```

## Window Methods

```lua
Window:SetTheme("Paper")
Window:SetFont("Cartoon")
Window:SetVisible(true)
Window:SetMinimized(false)
Window:SetBackgroundImage("rbxassetid://123456", 0.7)
Window:SetSideImage("rbxassetid://123456", 0.6)
Window:Notify({ Title = "Hi", Content = "Loaded." })
Window:SaveConfig("main")
Window:LoadConfig("main")
Window:Destroy()
```

## Image Helpers

```lua
local placeholder = CursedPaint:GetPlaceholderImage()
local asset = CursedPaint:DownloadImage("https://example.com/image.png", "image.png")
```

`DownloadImage` requires executor file APIs: `writefile` and `getcustomasset`. Roblox asset IDs such as `123456` and `rbxassetid://123456` work directly.

## Tabs

```lua
local Main = Window:AddTab("Main")
```

Controls can also use the `Add` prefix:

```lua
Main:AddButton({ Title = "Run" })
Main:Button({ Title = "Run" })
```

## Text

```lua
Main:AddSection("General")

local Label = Main:AddLabel("Ready.")
Label:Set("Running.")

Main:AddParagraph({
	Title = "Info",
	Content = "Longer text goes here.",
})

Main:AddDivider("Group")
Main:AddSpace(8)
```

## Images

```lua
Main:AddImage({
	Title = "Preview",
	Caption = "Image row.",
	Image = "rbxassetid://123456",
	Height = 120,
})

Main:AddBanner({
	Title = "Banner",
	Image = CursedPaint:GetPlaceholderImage(),
})
```

## Progress And Quests

```lua
local Progress = Main:AddProgress({
	Title = "Total Progress",
	Value = 50,
	Max = 100,
})
Progress:Set(75)

local Quest = Main:AddQuest({
	Title = "Roll 15 times",
	Value = 0,
	Max = 15,
	Image = "rbxassetid://123456",
})
Quest:Set(8, 15)
```

## Button

```lua
Main:AddButton({
	Title = "Claim Reward",
	Description = "Runs a callback.",
	ButtonText = "CLAIM",
	Icon = "rbxassetid://123456",
	Callback = function()
		print("clicked")
	end,
})
```

## Toggle

```lua
local Toggle = Main:AddToggle({
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
local Slider = Main:AddSlider({
	Title = "Volume",
	Flag = "volume",
	Min = 0,
	Max = 100,
	Step = 5,
	Default = 50,
})

Slider:Set(80)
```

## Stepper

```lua
local Stepper = Main:AddStepper({
	Title = "Combo Limit",
	Flag = "combo_limit",
	Min = 1,
	Max = 10,
	Step = 1,
	Default = 4,
})

Stepper:Set(6)
```

## Dropdowns

```lua
local Dropdown = Main:AddDropdown({
	Title = "Mode",
	Flag = "mode",
	Options = { "Casual", "Ranked", "Private" },
	Default = "Casual",
})

Dropdown:Set("Ranked")

local Multi = Main:AddMultiDropdown({
	Title = "Moves",
	Flag = "moves",
	Options = { "M1", "Special", "Ultimate", "Dash" },
	Default = { "M1", "Dash" },
})

Multi:Set({ "Special", "Ultimate" })
```

## Textbox

```lua
Main:AddTextbox({
	Title = "Shout",
	Flag = "shout",
	Placeholder = "type here",
	Default = "hello",
	SubmitOnly = true,
	Callback = function(text)
		print(text)
	end,
})
```

## Keybind

```lua
Main:AddKeybind({
	Title = "Notify Key",
	Flag = "notify_key",
	Default = Enum.KeyCode.RightShift,
	Pressed = function(key)
		print(key.Name)
	end,
})
```

## Color Picker

```lua
Main:AddColorPicker({
	Title = "Accent",
	Flag = "accent",
	Default = Color3.fromRGB(26, 203, 246),
	Callback = function(color)
		print(color)
	end,
})
```

## Theme Dropdown

```lua
Main:AddThemeDropdown("Theme")
```

This creates a dropdown that calls `Window:SetTheme`.

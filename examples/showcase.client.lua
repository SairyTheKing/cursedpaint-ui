-- CursedPaint UI showcase
-- Paste into a LocalScript or run through an executor with HttpGet enabled.

local CursedPaint = loadstring(game:HttpGet("https://raw.githubusercontent.com/SairyTheKing/cursedpaint-ui/main/loader.lua"))()
local DemoImage = CursedPaint:GetPlaceholderImage()

local Window = CursedPaint:CreateWindow({
	Title = "CursedPaint",
	Size = UDim2.fromOffset(840, 500),
	MinSize = Vector2.new(640, 390),
	Resizable = true,
	Animated = true,
	SideImage = DemoImage,
	SideImageTransparency = 0.78,
	ToggleKey = Enum.KeyCode.RightControl,
})

local Main = Window:AddTab("Main")
local Controls = Window:AddTab("Controls")
local Combat = Window:AddTab("Combat")
local Visuals = Window:AddTab("Visuals")
local Settings = Window:AddTab("Settings")
local Daily = Window:AddTab("Daily")
Window:AddTab("-")

Main:AddSection("CursedPaint UI")
Main:AddBanner({
	Title = "JJS Sketch Menu",
	Caption = "Thick outlines, paper panels, yellow tabs, and cyan progress bars.",
	Image = DemoImage,
	ImageTransparency = 0.18,
})
Main:AddParagraph({
	Title = "What this is",
	Content = "A simple Roblox Luau UI library with tabs, flags, config, images, notifications, and script-friendly controls.",
})
Main:AddButton({
	Title = "Notification",
	Description = "Shows a themed popup.",
	ButtonText = "SHOW",
	Icon = DemoImage,
	Callback = function()
		Window:Notify({
			Title = "CursedPaint",
			Content = "Button callbacks are working.",
		})
	end,
})
Main:AddDivider("State")
local Status = Main:AddLabel("Ready.")
Main:AddProgress({
	Title = "Total Progress",
	Value = 50,
	Max = 100,
})

Controls:AddSection("Basic Controls")
Controls:AddToggle({
	Title = "Auto Sprint",
	Description = "Boolean flag example.",
	Flag = "auto_sprint",
	Default = true,
	Icon = DemoImage,
	Callback = function(value)
		Status:Set("Auto Sprint: " .. tostring(value))
	end,
})
Controls:AddSlider({
	Title = "Walk Speed",
	Flag = "walk_speed",
	Min = 16,
	Max = 100,
	Step = 1,
	Default = 24,
	Callback = function(value)
		Status:Set("Walk Speed: " .. tostring(value))
	end,
})
Controls:AddStepper({
	Title = "Combo Limit",
	Flag = "combo_limit",
	Min = 1,
	Max = 10,
	Step = 1,
	Default = 4,
	Callback = function(value)
		Status:Set("Combo Limit: " .. tostring(value))
	end,
})
Controls:AddTextbox({
	Title = "Shout Text",
	Flag = "shout_text",
	Placeholder = "type then press enter",
	Default = "domain expansion",
	Callback = function(text)
		Window:Notify({
			Title = "Textbox",
			Content = text,
		})
	end,
})

Combat:AddSection("Dropdowns")
Combat:AddDropdown({
	Title = "Character",
	Flag = "character",
	Options = {
		"Honored One",
		"Vessel",
		"Restless Gambler",
		"Ten Shadows",
		"Perfection",
		"Blood Manipulator",
		"Switcher",
	},
	Default = "Vessel",
	Callback = function(value)
		Status:Set("Character: " .. tostring(value))
	end,
})
Combat:AddMultiDropdown({
	Title = "Enabled Moves",
	Flag = "enabled_moves",
	Options = { "M1", "Special", "Ultimate", "Dash", "Counter" },
	Default = { "M1", "Dash" },
	Callback = function(values)
		Status:Set("Enabled moves: " .. tostring(#values))
	end,
})
Combat:AddButton({
	Title = "Fake Attack",
	Description = "Example command button.",
	ButtonText = "USE",
	Callback = function()
		Window:Notify({
			Title = "Combat",
			Content = "Fake attack fired.",
		})
	end,
})

Visuals:AddSection("Visuals")
Visuals:AddImage({
	Title = "Image Row",
	Caption = "Use an rbxassetid, rbxasset URL, or HTTP image with executor file APIs.",
	Image = DemoImage,
	Height = 120,
	ImageTransparency = 0.08,
})
Visuals:AddColorPicker({
	Title = "Accent Color",
	Flag = "accent_color",
	Default = Color3.fromRGB(26, 203, 246),
	Callback = function(color)
		Status:Set("Picked color: " .. tostring(color))
	end,
})
Visuals:AddButton({
	Title = "Set Side Image",
	Description = "Changes the faded image on the right side.",
	ButtonText = "SET",
	Callback = function()
		Window:SetSideImage(DemoImage, 0.66)
		Status:Set("Side image changed.")
	end,
})

Settings:AddSection("Settings")
Settings:AddSlider({
	Title = "Motion Speed",
	Flag = "motion_speed",
	Min = 0.5,
	Max = 2,
	Step = 0.1,
	Default = 1,
	Callback = function(value)
		Window:SetMotion(true, value)
	end,
})
Settings:AddDropdown({
	Title = "Font",
	Flag = "font_select",
	Options = { "FingerPaint", "Cartoon", "GothamBold", "Gotham" },
	Default = "FingerPaint",
	Callback = function(font)
		Window:SetFont(font)
	end,
})
Settings:AddKeybind({
	Title = "Notify Key",
	Flag = "notify_key",
	Default = Enum.KeyCode.RightShift,
	Pressed = function(key)
		Window:Notify({
			Title = "Keybind",
			Content = key.Name .. " pressed.",
		})
	end,
})
Settings:AddButton({
	Title = "Save Config",
	Description = "Uses writefile if available, memory fallback otherwise.",
	ButtonText = "SAVE",
	Callback = function()
		local saved = Window:SaveConfig("showcase")
		Window:Notify({
			Title = "Config",
			Content = saved and "Saved to file." or "Saved in memory.",
		})
	end,
})
Settings:AddButton({
	Title = "Load Config",
	Description = "Restores flags and theme.",
	ButtonText = "LOAD",
	Callback = function()
		local ok, message = Window:LoadConfig("showcase")
		Window:Notify({
			Title = "Config",
			Content = ok and "Loaded config." or tostring(message),
		})
	end,
})
Settings:AddLabel("Drag the bottom-right handle to resize. RightControl toggles the UI.")

Daily:AddQuest({
	Title = "Roll 15 times",
	Value = 0,
	Max = 15,
	Image = DemoImage,
	ImageTransparency = 0.72,
})
Daily:AddQuest({
	Title = "Use Special 15 times",
	Value = 3,
	Max = 15,
	Image = DemoImage,
	ImageTransparency = 0.78,
})
Daily:AddQuest({
	Title = "Play for 15 minutes",
	Value = 8,
	Max = 15,
	Image = DemoImage,
	ImageTransparency = 0.82,
})
Daily:AddLabel("Refreshes in: 7h 29m 23s")
Daily:AddProgress({
	Title = "Total Progress",
	Value = 50,
	Max = 100,
})

Window:Notify({
	Title = "CursedPaint",
	Content = "Showcase loaded.",
	Duration = 3,
})

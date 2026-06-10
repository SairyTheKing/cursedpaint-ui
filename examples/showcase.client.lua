-- CursedPaint UI showcase
-- Paste into a LocalScript, or run through your testing environment.

local CursedPaint = loadstring(game:HttpGet("https://raw.githubusercontent.com/SairyTheKing/cursedpaint-ui/main/Source.lua"))()
local PlaceholderImage = CursedPaint.PlaceholderImage

local Window = CursedPaint:CreateWindow({
	Title = "CursedPaint",
	Theme = "Paper",
	Size = UDim2.fromOffset(650, 370),
	SideImage = PlaceholderImage,
	SideImageTransparency = 0.78,
	ToggleKey = Enum.KeyCode.RightControl,
})

local Main = Window:AddTab("Main")
local Controls = Window:AddTab("Controls")
local Combat = Window:AddTab("Combat")
local Visuals = Window:AddTab("Visuals")
local Config = Window:AddTab("Config")
local Daily = Window:AddTab("Daily")
Window:AddTab("-")

Main:AddSection("CursedPaint UI")
Main:AddBanner({
	Title = "Paper Menu Library",
	Caption = "Replace this image with any Roblox asset id.",
	Image = PlaceholderImage,
	ImageTransparency = 0.18,
})
Main:AddParagraph({
	Title = "Testing Library",
	Content = "A real control library with a flat paper menu style, FingerPaint text, image rows, tabs, callbacks, flags, config, and notifications.",
})
Main:AddButton({
	Title = "Notification",
	Description = "Shows a paper-style popup.",
	ButtonText = "SHOW",
	Icon = PlaceholderImage,
	Callback = function()
		Window:Notify({
			Title = "CursedPaint",
			Content = "Button callbacks work.",
		})
	end,
})
Main:AddDivider("Status")
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
	Icon = PlaceholderImage,
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
	Caption = "Use AddImage or AddBanner for big art blocks.",
	Image = PlaceholderImage,
	Height = 120,
	ImageTransparency = 0.08,
})
Visuals:AddColorPicker({
	Title = "Bar Color",
	Flag = "bar_color",
	Default = Color3.fromRGB(21, 205, 244),
	Callback = function(color)
		Status:Set("Picked color: " .. tostring(color))
	end,
})
Visuals:AddDropdown({
	Title = "Theme",
	Flag = "theme_select",
	Options = { "Paper", "Smoke", "Blood", "Void", "Forest", "Candy" },
	Default = "Paper",
	Callback = function(theme)
		Window:SetTheme(theme)
	end,
})
Visuals:AddButton({
	Title = "Set Side Image",
	Description = "Changes the faded image on the right side.",
	ButtonText = "SET",
	Callback = function()
		Window:SetSideImage(PlaceholderImage, 0.6)
		Status:Set("Side image changed.")
	end,
})
Visuals:AddKeybind({
	Title = "Toggle UI",
	Flag = "toggle_key",
	Default = Enum.KeyCode.RightControl,
	Pressed = function()
		Window:SetVisible(false)
	end,
})

Config:AddSection("Config")
Config:AddButton({
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
Config:AddButton({
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
Config:AddLabel("RightControl toggles the UI.")

Daily:AddQuest({
	Title = "Roll 15 times",
	Value = 0,
	Max = 15,
	Image = PlaceholderImage,
	ImageTransparency = 0.72,
})
Daily:AddQuest({
	Title = "Use Special 15 times",
	Value = 3,
	Max = 15,
	Image = PlaceholderImage,
	ImageTransparency = 0.78,
})
Daily:AddQuest({
	Title = "Play for 15 minutes",
	Value = 8,
	Max = 15,
	Image = PlaceholderImage,
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
	Content = "Full UI library showcase loaded.",
	Duration = 3,
})

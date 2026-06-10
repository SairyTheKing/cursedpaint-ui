-- CursedPaint UI showcase
-- Paste into a LocalScript, or run through your testing environment.

local CursedPaint = loadstring(game:HttpGet("https://raw.githubusercontent.com/SairyTheKing/cursedpaint-ui/main/Source.lua"))()

local Window = CursedPaint:CreateWindow({
	Title = "CursedPaint UI",
	Subtitle = "finger paint test panel",
	Theme = "Cursed",
	ToggleKey = Enum.KeyCode.RightControl,
})

local Start = Window:CreateTab("Start", "*")
local Fun = Window:CreateTab("Silly", "!")
local Config = Window:CreateTab("Config", "#")

Start:Section("Showcase")

Start:Paragraph({
	Title = "What is this?",
	Content = "A hand-painted Roblox UI library with tabs, themes, controls, config, and goofy motion.",
})

Start:Button({
	Title = "Bonk Button",
	Description = "Runs a callback and sends a notification.",
	ButtonText = "BONK",
	Callback = function()
		Window:Notify({
			Title = "Bonk",
			Content = "The silly button has been pressed.",
			Duration = 2.5,
		})
	end,
})

Start:Toggle({
	Title = "Silly Mode",
	Description = "Stores a boolean flag.",
	Flag = "silly_mode",
	Default = true,
	Callback = function(value)
		print("Silly Mode:", value)
	end,
})

Start:Slider({
	Title = "Doodle Power",
	Description = "A rounded stepped slider.",
	Flag = "doodle_power",
	Min = 0,
	Max = 100,
	Step = 5,
	Default = 35,
	Callback = function(value)
		print("Doodle Power:", value)
	end,
})

Start:Dropdown({
	Title = "Move Style",
	Description = "Pick one option.",
	Flag = "move_style",
	Options = { "Calm", "Silly", "Cursed", "Sweaty" },
	Default = "Silly",
	Callback = function(value)
		print("Move Style:", value)
	end,
})

Fun:Section("Inputs")

Fun:Textbox({
	Title = "Shout Text",
	Description = "Press enter to submit.",
	Flag = "shout_text",
	Placeholder = "domain expansion...",
	Default = "paint time",
	Callback = function(text)
		Window:Notify({
			Title = "Textbox",
			Content = "You typed: " .. text,
		})
	end,
})

Fun:Keybind({
	Title = "Panic Key",
	Description = "Click the key button, then press a key.",
	Flag = "panic_key",
	Default = Enum.KeyCode.K,
	Pressed = function(key)
		Window:Notify({
			Title = "Keybind",
			Content = key.Name .. " was pressed.",
		})
	end,
})

Fun:ColorPicker({
	Title = "Aura Color",
	Description = "Six quick swatches.",
	Flag = "aura_color",
	Default = Color3.fromRGB(255, 82, 92),
	Callback = function(color)
		print("Aura Color:", color)
	end,
})

local Cooldown = Fun:Progress({
	Title = "Fake Cooldown",
	Description = "You can update this from your own code.",
	Value = 42,
	Max = 100,
})

Fun:Button({
	Title = "Random Cooldown",
	ButtonText = "ROLL",
	Callback = function()
		Cooldown:Set(math.random(0, 100))
	end,
})

Config:Section("Looks")
Config:ThemeDropdown("Theme")

Config:Button({
	Title = "Save Config",
	Description = "Uses writefile when available, memory fallback otherwise.",
	ButtonText = "SAVE",
	Callback = function()
		local saved = Window:SaveConfig("showcase")
		Window:Notify({
			Title = "Config",
			Content = saved and "Saved to file." or "Saved in memory for this session.",
		})
	end,
})

Config:Button({
	Title = "Load Config",
	Description = "Restores flags and theme.",
	ButtonText = "LOAD",
	Callback = function()
		local ok, message = Window:LoadConfig("showcase")
		Window:Notify({
			Title = "Config",
			Content = ok and "Loaded showcase config." or tostring(message),
		})
	end,
})

Config:Label("Tip: RightControl toggles the whole UI.")

Window:Notify({
	Title = "CursedPaint loaded",
	Content = "Open the tabs and mess with the controls.",
	Duration = 3,
})

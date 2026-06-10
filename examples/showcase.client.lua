-- CursedPaint UI showcase
-- Paste into a LocalScript, or run through your testing environment.

local CursedPaint = loadstring(game:HttpGet("https://raw.githubusercontent.com/SairyTheKing/cursedpaint-ui/main/Source.lua"))()

local Window = CursedPaint:CreateWindow({
	Theme = "Paper",
	Size = UDim2.fromOffset(650, 370),
	ToggleKey = Enum.KeyCode.RightControl,
})

local Daily = Window:CreateTab("Daily")
local Weekly = Window:CreateTab("Weekly")
local Stats = Window:CreateTab("Stats")
local Gamemodes = Window:CreateTab("Gamemodes")
local General = Window:CreateTab("General")
local Honored = Window:CreateTab("Honored One")
local Vessel = Window:CreateTab("Vessel")
local Gambler = Window:CreateTab("Restless Gambler")
local Shadows = Window:CreateTab("Ten Shadows")
local Perfection = Window:CreateTab("Perfection")
local Blood = Window:CreateTab("Blood Manipulator")
local Switcher = Window:CreateTab("Switcher")
Window:CreateTab("-")

Daily:Quest({
	Title = "Roll 15 times",
	Value = 0,
	Max = 15,
})

Daily:Quest({
	Title = "Use Special 15 times",
	Value = 0,
	Max = 15,
})

Daily:Quest({
	Title = "Play for 15 minutes",
	Value = 0,
	Max = 15,
})

Daily:Label("Refreshes in: 7h 29m 23s")
Daily:Progress({
	Title = "Total Progress",
	Value = 50,
	Max = 100,
})

Weekly:Section("Weekly")
Weekly:Quest({
	Title = "Win 10 rounds",
	Value = 3,
	Max = 10,
})
Weekly:Quest({
	Title = "Deal 5000 damage",
	Value = 2400,
	Max = 5000,
})
Weekly:Progress({
	Title = "Total Progress",
	Value = 38,
	Max = 100,
})

Stats:Section("Stats")
Stats:Label("Kills: 128")
Stats:Label("Wins: 17")
Stats:Label("Favorite mode: Silly")

Gamemodes:Section("Gamemodes")
Gamemodes:Button({
	Title = "Casual",
	ButtonText = "PLAY",
	Callback = function()
		Window:Notify({
			Title = "Gamemodes",
			Content = "Casual selected.",
		})
	end,
})
Gamemodes:Button({
	Title = "Ranked",
	ButtonText = "PLAY",
	Callback = function()
		Window:Notify({
			Title = "Gamemodes",
			Content = "Ranked selected.",
		})
	end,
})

General:Section("General")
General:Toggle({
	Title = "Auto Sprint",
	Flag = "auto_sprint",
	Default = true,
})
General:Slider({
	Title = "Volume",
	Flag = "volume",
	Min = 0,
	Max = 100,
	Step = 5,
	Default = 50,
})
General:Dropdown({
	Title = "Menu Theme",
	Flag = "menu_theme",
	Options = { "Paper", "Smoke", "Blood", "Void", "Forest", "Candy" },
	Default = "Paper",
	Callback = function(theme)
		Window:SetTheme(theme)
	end,
})

Honored:Section("Honored One")
Honored:Quest({
	Title = "Land Blue 5 times",
	Value = 1,
	Max = 5,
})
Honored:Quest({
	Title = "Hit a reversal",
	Value = 0,
	Max = 1,
})

Vessel:Section("Vessel")
Vessel:Toggle({
	Title = "Show Move Tips",
	Flag = "vessel_tips",
	Default = false,
})
Vessel:Slider({
	Title = "Rage",
	Flag = "rage",
	Min = 0,
	Max = 100,
	Step = 1,
	Default = 25,
})

Gambler:Section("Restless Gambler")
Gambler:Button({
	Title = "Spin Luck",
	ButtonText = "ROLL",
	Callback = function()
		Window:Notify({
			Title = "Jackpot",
			Content = "You rolled " .. tostring(math.random(1, 777)) .. ".",
		})
	end,
})

Shadows:Section("Ten Shadows")
Shadows:ColorPicker({
	Title = "Shadow Color",
	Flag = "shadow_color",
	Default = Color3.fromRGB(21, 205, 244),
})

Perfection:Section("Perfection")
Perfection:Textbox({
	Title = "Shout",
	Flag = "shout",
	Placeholder = "type something",
	Default = "idle transfiguration",
	Callback = function(text)
		Window:Notify({
			Title = "Shout",
			Content = text,
		})
	end,
})

Blood:Section("Blood Manipulator")
Blood:Slider({
	Title = "Blood Flow",
	Flag = "blood_flow",
	Min = 0,
	Max = 100,
	Step = 10,
	Default = 70,
})

Switcher:Section("Switcher")
Switcher:Keybind({
	Title = "Toggle UI",
	Flag = "toggle_ui",
	Default = Enum.KeyCode.RightControl,
	Pressed = function()
		Window:SetVisible(false)
	end,
})
Switcher:Button({
	Title = "Save Config",
	ButtonText = "SAVE",
	Callback = function()
		local saved = Window:SaveConfig("showcase")
		Window:Notify({
			Title = "Config",
			Content = saved and "Saved to file." or "Saved in memory.",
		})
	end,
})
Switcher:Button({
	Title = "Load Config",
	ButtonText = "LOAD",
	Callback = function()
		local ok, message = Window:LoadConfig("showcase")
		Window:Notify({
			Title = "Config",
			Content = ok and "Loaded config." or tostring(message),
		})
	end,
})

Window:Notify({
	Title = "CursedPaint",
	Content = "Quest-style showcase loaded.",
	Duration = 3,
})

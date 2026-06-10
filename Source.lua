-- CursedPaint UI
-- A silly hand-painted Roblox Luau UI library for testing scripts and showcases.

local CursedPaint = {}
CursedPaint.__index = CursedPaint
CursedPaint.Version = "0.1.0"

CursedPaint.Themes = {
	Cursed = {
		Background = Color3.fromRGB(23, 20, 25),
		Panel = Color3.fromRGB(35, 31, 39),
		PanelAlt = Color3.fromRGB(46, 39, 51),
		Ink = Color3.fromRGB(245, 235, 216),
		Muted = Color3.fromRGB(188, 176, 159),
		Accent = Color3.fromRGB(219, 46, 66),
		AccentAlt = Color3.fromRGB(255, 188, 66),
		Good = Color3.fromRGB(101, 211, 122),
		Bad = Color3.fromRGB(255, 95, 95),
		Stroke = Color3.fromRGB(9, 8, 11),
		Shadow = Color3.fromRGB(7, 6, 8),
	},
	Gojo = {
		Background = Color3.fromRGB(14, 18, 28),
		Panel = Color3.fromRGB(25, 31, 46),
		PanelAlt = Color3.fromRGB(33, 43, 65),
		Ink = Color3.fromRGB(235, 245, 255),
		Muted = Color3.fromRGB(163, 184, 212),
		Accent = Color3.fromRGB(87, 149, 255),
		AccentAlt = Color3.fromRGB(190, 232, 255),
		Good = Color3.fromRGB(92, 221, 192),
		Bad = Color3.fromRGB(255, 102, 122),
		Stroke = Color3.fromRGB(6, 9, 16),
		Shadow = Color3.fromRGB(4, 6, 10),
	},
	Sukuna = {
		Background = Color3.fromRGB(29, 13, 16),
		Panel = Color3.fromRGB(45, 22, 26),
		PanelAlt = Color3.fromRGB(62, 30, 36),
		Ink = Color3.fromRGB(255, 228, 219),
		Muted = Color3.fromRGB(217, 160, 146),
		Accent = Color3.fromRGB(255, 58, 76),
		AccentAlt = Color3.fromRGB(255, 129, 82),
		Good = Color3.fromRGB(112, 218, 126),
		Bad = Color3.fromRGB(255, 77, 77),
		Stroke = Color3.fromRGB(13, 5, 7),
		Shadow = Color3.fromRGB(9, 4, 5),
	},
	Megumi = {
		Background = Color3.fromRGB(14, 25, 24),
		Panel = Color3.fromRGB(24, 42, 39),
		PanelAlt = Color3.fromRGB(32, 58, 53),
		Ink = Color3.fromRGB(226, 246, 237),
		Muted = Color3.fromRGB(154, 196, 181),
		Accent = Color3.fromRGB(68, 193, 157),
		AccentAlt = Color3.fromRGB(168, 221, 116),
		Good = Color3.fromRGB(112, 227, 141),
		Bad = Color3.fromRGB(255, 104, 104),
		Stroke = Color3.fromRGB(5, 12, 11),
		Shadow = Color3.fromRGB(4, 8, 8),
	},
	Nobara = {
		Background = Color3.fromRGB(35, 19, 25),
		Panel = Color3.fromRGB(52, 30, 39),
		PanelAlt = Color3.fromRGB(70, 41, 53),
		Ink = Color3.fromRGB(255, 235, 235),
		Muted = Color3.fromRGB(219, 163, 175),
		Accent = Color3.fromRGB(238, 86, 124),
		AccentAlt = Color3.fromRGB(255, 204, 87),
		Good = Color3.fromRGB(102, 219, 130),
		Bad = Color3.fromRGB(255, 82, 103),
		Stroke = Color3.fromRGB(14, 6, 9),
		Shadow = Color3.fromRGB(10, 4, 7),
	},
	Manga = {
		Background = Color3.fromRGB(238, 232, 218),
		Panel = Color3.fromRGB(255, 250, 235),
		PanelAlt = Color3.fromRGB(235, 226, 207),
		Ink = Color3.fromRGB(31, 28, 25),
		Muted = Color3.fromRGB(100, 93, 83),
		Accent = Color3.fromRGB(38, 37, 35),
		AccentAlt = Color3.fromRGB(210, 67, 67),
		Good = Color3.fromRGB(58, 153, 84),
		Bad = Color3.fromRGB(204, 63, 63),
		Stroke = Color3.fromRGB(18, 16, 14),
		Shadow = Color3.fromRGB(169, 158, 137),
	},
	Candy = {
		Background = Color3.fromRGB(31, 25, 44),
		Panel = Color3.fromRGB(52, 42, 72),
		PanelAlt = Color3.fromRGB(70, 55, 92),
		Ink = Color3.fromRGB(255, 242, 252),
		Muted = Color3.fromRGB(217, 184, 224),
		Accent = Color3.fromRGB(255, 116, 190),
		AccentAlt = Color3.fromRGB(108, 226, 255),
		Good = Color3.fromRGB(124, 236, 159),
		Bad = Color3.fromRGB(255, 95, 130),
		Stroke = Color3.fromRGB(13, 9, 20),
		Shadow = Color3.fromRGB(9, 6, 15),
	},
	Void = {
		Background = Color3.fromRGB(10, 10, 14),
		Panel = Color3.fromRGB(18, 18, 24),
		PanelAlt = Color3.fromRGB(28, 28, 36),
		Ink = Color3.fromRGB(235, 238, 245),
		Muted = Color3.fromRGB(137, 143, 158),
		Accent = Color3.fromRGB(158, 116, 255),
		AccentAlt = Color3.fromRGB(255, 232, 99),
		Good = Color3.fromRGB(98, 224, 151),
		Bad = Color3.fromRGB(255, 88, 105),
		Stroke = Color3.fromRGB(0, 0, 0),
		Shadow = Color3.fromRGB(0, 0, 0),
	},
}

local Window = {}
Window.__index = Window

local Tab = {}
Tab.__index = Tab

local function cloneTheme(theme)
	local copy = {}
	for key, value in pairs(theme) do
		copy[key] = value
	end
	return copy
end

local function getTheme(name)
	return cloneTheme(CursedPaint.Themes[name] or CursedPaint.Themes.Cursed)
end

local function safeFont()
	local ok, font = pcall(function()
		return Enum.Font.FingerPaint
	end)

	if ok and font then
		return font
	end

	return Enum.Font.GothamBold
end

local function service(name)
	return game:GetService(name)
end

local function tween(instance, duration, goal, style, direction)
	local tweenService = service("TweenService")
	local info = TweenInfo.new(
		duration or 0.15,
		style or Enum.EasingStyle.Quad,
		direction or Enum.EasingDirection.Out
	)
	local created = tweenService:Create(instance, info, goal)
	created:Play()
	return created
end

local function make(className, props, children)
	local instance = Instance.new(className)

	for key, value in pairs(props or {}) do
		if key ~= "Parent" then
			instance[key] = value
		end
	end

	for _, child in ipairs(children or {}) do
		child.Parent = instance
	end

	if props and props.Parent then
		instance.Parent = props.Parent
	end

	return instance
end

local function round(parent, radius)
	return make("UICorner", {
		CornerRadius = UDim.new(0, radius or 8),
		Parent = parent,
	})
end

local function stroke(parent, color, thickness)
	return make("UIStroke", {
		Color = color,
		Thickness = thickness or 2,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = parent,
	})
end

local function padding(parent, left, top, right, bottom)
	return make("UIPadding", {
		PaddingLeft = UDim.new(0, left or 0),
		PaddingTop = UDim.new(0, top or left or 0),
		PaddingRight = UDim.new(0, right or left or 0),
		PaddingBottom = UDim.new(0, bottom or top or left or 0),
		Parent = parent,
	})
end

local function list(parent, paddingSize)
	return make("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, paddingSize or 8),
		Parent = parent,
	})
end

local function grid(parent, cellSize, paddingSize)
	return make("UIGridLayout", {
		CellSize = cellSize,
		CellPadding = UDim2.fromOffset(paddingSize or 8, paddingSize or 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = parent,
	})
end

local function autoY(frame, layout)
	local function update()
		frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, 0, layout.AbsoluteContentSize.Y)
	end

	update()
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update)
end

local function resolveParent()
	local ok, hui = pcall(function()
		if gethui then
			return gethui()
		end
		return nil
	end)

	if ok and hui then
		return hui
	end

	local okCore, coreGui = pcall(function()
		return service("CoreGui")
	end)

	if okCore and coreGui then
		return coreGui
	end

	local players = service("Players")
	local player = players.LocalPlayer
	if player then
		return player:WaitForChild("PlayerGui")
	end

	return nil
end

local function protectGui(gui)
	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(gui)
		end
	end)
end

local function setTextDefaults(label, textSize)
	label.Font = safeFont()
	label.TextSize = textSize or 18
	label.TextWrapped = true
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
end

local function boolText(value)
	return value and "ON" or "OFF"
end

local function call(callback, ...)
	if typeof(callback) == "function" then
		task.spawn(callback, ...)
	end
end

local function normalizeFlag(title, flag)
	if flag and flag ~= "" then
		return flag
	end

	return tostring(title or "flag"):lower():gsub("[^%w]+", "_"):gsub("^_+", ""):gsub("_+$", "")
end

local function clampNumber(value, minValue, maxValue)
	return math.clamp(tonumber(value) or minValue, minValue, maxValue)
end

local function roundToStep(value, step)
	local size = tonumber(step) or 1
	if size <= 0 then
		return value
	end

	return math.floor((value / size) + 0.5) * size
end

local function colorToHex(color)
	local r = math.floor(color.R * 255 + 0.5)
	local g = math.floor(color.G * 255 + 0.5)
	local b = math.floor(color.B * 255 + 0.5)
	return string.format("#%02X%02X%02X", r, g, b)
end

local function hexToColor(value, fallback)
	local text = tostring(value or "")
	local r, g, b = text:match("^#?(%x%x)(%x%x)(%x%x)$")
	if r then
		return Color3.fromRGB(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16))
	end
	return fallback
end

local function themeNames()
	local names = {}
	for name in pairs(CursedPaint.Themes) do
		table.insert(names, name)
	end
	table.sort(names)
	return names
end

local function createBase(parent, theme)
	local base = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 46),
		Parent = parent,
	})
	round(base, 8)
	stroke(base, theme.Stroke, 2)
	padding(base, 12, 8, 12, 8)
	return base
end

local function createTitle(base, title, description, theme)
	local titleLabel = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = title or "Control",
		TextColor3 = theme.Ink,
		Size = UDim2.new(1, -92, 0, description and 20 or 28),
		Parent = base,
	})
	setTextDefaults(titleLabel, 17)

	local descLabel
	if description and description ~= "" then
		descLabel = make("TextLabel", {
			BackgroundTransparency = 1,
			Text = description,
			TextColor3 = theme.Muted,
			TextSize = 13,
			Font = Enum.Font.Gotham,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			Position = UDim2.fromOffset(0, 22),
			Size = UDim2.new(1, -92, 0, 34),
			Parent = base,
		})
		base.Size = UDim2.new(1, 0, 0, 64)
	end

	return titleLabel, descLabel
end

local function makeSmallButton(parent, text, theme)
	local button = make("TextButton", {
		AutoButtonColor = false,
		BackgroundColor3 = theme.Accent,
		BorderSizePixel = 0,
		Font = safeFont(),
		Text = text,
		TextColor3 = theme.Ink,
		TextSize = 15,
		Size = UDim2.fromOffset(82, 30),
		Parent = parent,
	})
	round(button, 7)
	stroke(button, theme.Stroke, 2)

	button.MouseEnter:Connect(function()
		tween(button, 0.12, { BackgroundColor3 = theme.AccentAlt })
	end)

	button.MouseLeave:Connect(function()
		tween(button, 0.12, { BackgroundColor3 = theme.Accent })
	end)

	return button
end

function CursedPaint:CreateWindow(options)
	options = options or {}

	local themeName = options.Theme or "Cursed"
	local theme = getTheme(themeName)
	local parent = options.Parent or resolveParent()
	assert(parent, "CursedPaint UI could not find a UI parent.")

	local gui = make("ScreenGui", {
		Name = options.GuiName or "CursedPaintUI",
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	protectGui(gui)
	gui.Parent = parent

	local shadow = make("Frame", {
		BackgroundColor3 = theme.Shadow,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		Position = options.Position or UDim2.fromOffset(92, 92),
		Size = options.Size or UDim2.fromOffset(610, 468),
		Parent = gui,
	})
	round(shadow, 12)

	local main = make("Frame", {
		BackgroundColor3 = theme.Background,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(-5, -5),
		Size = UDim2.fromScale(1, 1),
		Parent = shadow,
	})
	round(main, 12)
	stroke(main, theme.Stroke, 3)

	local top = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 72),
		Parent = main,
	})
	round(top, 12)
	stroke(top, theme.Stroke, 2)

	local title = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = options.Title or "CursedPaint UI",
		TextColor3 = theme.Ink,
		Position = UDim2.fromOffset(18, 8),
		Size = UDim2.new(1, -148, 0, 32),
		Parent = top,
	})
	setTextDefaults(title, 24)

	local subtitle = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = options.Subtitle or "silly test panel",
		TextColor3 = theme.Muted,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(20, 42),
		Size = UDim2.new(1, -164, 0, 18),
		Parent = top,
	})

	local close = makeSmallButton(top, "X", theme)
	close.Position = UDim2.new(1, -48, 0, 18)
	close.Size = UDim2.fromOffset(30, 30)

	local minimize = makeSmallButton(top, "-", theme)
	minimize.Position = UDim2.new(1, -86, 0, 18)
	minimize.Size = UDim2.fromOffset(30, 30)

	local tabsBar = make("ScrollingFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(12, 82),
		Size = UDim2.new(0, 154, 1, -94),
		CanvasSize = UDim2.fromOffset(0, 0),
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = theme.Accent,
		Parent = main,
	})
	padding(tabsBar, 0, 0, 6, 0)
	local tabsLayout = list(tabsBar, 7)
	tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		tabsBar.CanvasSize = UDim2.fromOffset(0, tabsLayout.AbsoluteContentSize.Y + 8)
	end)

	local content = make("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(178, 82),
		Size = UDim2.new(1, -190, 1, -94),
		Parent = main,
	})

	local toastHolder = make("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -330, 0, 16),
		Size = UDim2.fromOffset(310, 420),
		Parent = gui,
	})
	local toastLayout = list(toastHolder, 8)
	toastLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	local self = setmetatable({
		ScreenGui = gui,
		Root = shadow,
		Main = main,
		Top = top,
		TitleLabel = title,
		SubtitleLabel = subtitle,
		TabsBar = tabsBar,
		Content = content,
		ToastHolder = toastHolder,
		ThemeName = themeName,
		Theme = theme,
		Flags = {},
		_flagSetters = {},
		_themeBindings = {},
		_tabs = {},
		_tabButtons = {},
		_activeTab = nil,
		_minimized = false,
		_visible = true,
		_normalSize = shadow.Size,
		_configFolder = options.ConfigFolder or "CursedPaintUI",
	}, Window)

	self:_bindTheme(function(nextTheme)
		shadow.BackgroundColor3 = nextTheme.Shadow
		main.BackgroundColor3 = nextTheme.Background
		top.BackgroundColor3 = nextTheme.Panel
		title.TextColor3 = nextTheme.Ink
		subtitle.TextColor3 = nextTheme.Muted
		tabsBar.ScrollBarImageColor3 = nextTheme.Accent
	end)

	close.MouseButton1Click:Connect(function()
		self:Destroy()
	end)

	minimize.MouseButton1Click:Connect(function()
		self:SetMinimized(not self._minimized)
	end)

	self:_makeDraggable(top, shadow)

	local userInput = service("UserInputService")
	local toggleKey = options.ToggleKey
	if toggleKey then
		userInput.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == toggleKey then
				self:SetVisible(not self._visible)
			end
		end)
	end

	return self
end

function Window:_bindTheme(callback)
	table.insert(self._themeBindings, callback)
	callback(self.Theme)
end

function Window:_applyTheme()
	for _, callback in ipairs(self._themeBindings) do
		callback(self.Theme)
	end
end

function Window:SetTheme(name)
	if not CursedPaint.Themes[name] then
		return false
	end

	self.ThemeName = name
	self.Theme = getTheme(name)
	self:_applyTheme()
	self.Flags.__theme = name
	return true
end

function Window:GetThemes()
	return themeNames()
end

function Window:SetVisible(visible)
	self._visible = visible
	self.Root.Visible = visible
end

function Window:SetMinimized(minimized)
	self._minimized = minimized
	local targetSize
	if minimized then
		targetSize = UDim2.fromOffset(self.Root.AbsoluteSize.X, 72)
		self.TabsBar.Visible = false
		self.Content.Visible = false
	else
		targetSize = self._normalSize
		self.TabsBar.Visible = true
		self.Content.Visible = true
	end
	tween(self.Root, 0.18, { Size = targetSize })
end

function Window:Destroy()
	if self.ScreenGui then
		self.ScreenGui:Destroy()
	end
end

function Window:_makeDraggable(handle, target)
	local userInput = service("UserInputService")
	local dragging = false
	local dragStart
	local startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = target.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	userInput.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			target.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

function Window:CreateTab(title, icon)
	local theme = self.Theme
	local page = make("ScrollingFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.fromOffset(0, 0),
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = theme.Accent,
		Visible = false,
		Parent = self.Content,
	})
	padding(page, 0, 0, 8, 0)
	local pageLayout = list(page, 8)
	pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		page.CanvasSize = UDim2.fromOffset(0, pageLayout.AbsoluteContentSize.Y + 12)
	end)

	local button = make("TextButton", {
		AutoButtonColor = false,
		BackgroundColor3 = theme.Panel,
		BorderSizePixel = 0,
		Font = safeFont(),
		Text = (icon and icon .. " " or "") .. tostring(title or "Tab"),
		TextColor3 = theme.Muted,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, 0, 0, 42),
		Parent = self.TabsBar,
	})
	round(button, 8)
	stroke(button, theme.Stroke, 2)
	padding(button, 12, 0, 8, 0)

	local tab = setmetatable({
		Window = self,
		Title = title,
		Button = button,
		Page = page,
		Layout = pageLayout,
	}, Tab)

	table.insert(self._tabs, tab)
	self._tabButtons[tab] = button

	self:_bindTheme(function(nextTheme)
		page.ScrollBarImageColor3 = nextTheme.Accent
		button.TextColor3 = self._activeTab == tab and nextTheme.Ink or nextTheme.Muted
		button.BackgroundColor3 = self._activeTab == tab and nextTheme.Accent or nextTheme.Panel
	end)

	button.MouseButton1Click:Connect(function()
		self:SelectTab(tab)
	end)

	if not self._activeTab then
		self:SelectTab(tab)
	end

	return tab
end

function Window:SelectTab(tab)
	for _, other in ipairs(self._tabs) do
		other.Page.Visible = other == tab
		local button = self._tabButtons[other]
		if button then
			button.BackgroundColor3 = other == tab and self.Theme.Accent or self.Theme.Panel
			button.TextColor3 = other == tab and self.Theme.Ink or self.Theme.Muted
		end
	end
	self._activeTab = tab
end

function Window:Notify(options)
	options = options or {}
	local theme = self.Theme
	local toast = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(310, 0),
		Parent = self.ToastHolder,
	})
	round(toast, 8)
	stroke(toast, theme.Stroke, 2)
	padding(toast, 12, 10, 12, 10)

	local title = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = options.Title or "CursedPaint",
		TextColor3 = theme.Ink,
		Size = UDim2.new(1, 0, 0, 22),
		Parent = toast,
	})
	setTextDefaults(title, 17)

	local body = make("TextLabel", {
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		Text = options.Content or options.Text or "Something happened.",
		TextColor3 = theme.Muted,
		TextSize = 13,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		Position = UDim2.fromOffset(0, 26),
		Size = UDim2.new(1, 0, 0, 44),
		Parent = toast,
	})

	toast.Size = UDim2.fromOffset(310, 84)
	toast.BackgroundTransparency = 1
	title.TextTransparency = 1
	body.TextTransparency = 1
	tween(toast, 0.16, { BackgroundTransparency = 0 })
	tween(title, 0.16, { TextTransparency = 0 })
	tween(body, 0.16, { TextTransparency = 0 })

	task.delay(options.Duration or 3, function()
		if toast.Parent then
			tween(toast, 0.16, { BackgroundTransparency = 1 })
			tween(title, 0.16, { TextTransparency = 1 })
			tween(body, 0.16, { TextTransparency = 1 })
			task.wait(0.18)
			if toast.Parent then
				toast:Destroy()
			end
		end
	end)

	return toast
end

function Window:_setFlag(flag, value)
	self.Flags[flag] = value
end

function Window:_registerFlag(flag, setter)
	self._flagSetters[flag] = setter
end

function Window:SaveConfig(name)
	local http = service("HttpService")
	local configName = tostring(name or "default")
	local payload = http:JSONEncode({
		theme = self.ThemeName,
		flags = self.Flags,
		version = CursedPaint.Version,
	})

	local saved = false
	pcall(function()
		if makefolder and not isfolder(self._configFolder) then
			makefolder(self._configFolder)
		end
		if writefile then
			writefile(self._configFolder .. "/" .. configName .. ".json", payload)
			saved = true
		end
	end)

	CursedPaint._memoryConfigs = CursedPaint._memoryConfigs or {}
	CursedPaint._memoryConfigs[configName] = payload
	return saved, payload
end

function Window:LoadConfig(name)
	local http = service("HttpService")
	local configName = tostring(name or "default")
	local payload

	pcall(function()
		local path = self._configFolder .. "/" .. configName .. ".json"
		if readfile and (not isfile or isfile(path)) then
			payload = readfile(path)
		end
	end)

	if not payload and CursedPaint._memoryConfigs then
		payload = CursedPaint._memoryConfigs[configName]
	end

	if not payload then
		return false, "Config not found."
	end

	local ok, data = pcall(function()
		return http:JSONDecode(payload)
	end)

	if not ok or type(data) ~= "table" then
		return false, "Config is not valid JSON."
	end

	if data.theme then
		self:SetTheme(data.theme)
	end

	for flag, value in pairs(data.flags or {}) do
		if self._flagSetters[flag] then
			self._flagSetters[flag](value, true)
		else
			self.Flags[flag] = value
		end
	end

	return true
end

function Tab:_base(options)
	local base = createBase(self.Page, self.Window.Theme)
	local titleLabel, descLabel = createTitle(base, options.Title, options.Description, self.Window.Theme)

	self.Window:_bindTheme(function(theme)
		base.BackgroundColor3 = theme.Panel
		titleLabel.TextColor3 = theme.Ink
		if descLabel then
			descLabel.TextColor3 = theme.Muted
		end
		local outline = base:FindFirstChildOfClass("UIStroke")
		if outline then
			outline.Color = theme.Stroke
		end
	end)

	return base
end

function Tab:Section(title)
	local theme = self.Window.Theme
	local section = make("TextLabel", {
		BackgroundColor3 = theme.Accent,
		BorderSizePixel = 0,
		Font = safeFont(),
		Text = "  " .. tostring(title or "Section"),
		TextColor3 = theme.Ink,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, 0, 0, 34),
		Parent = self.Page,
	})
	round(section, 8)
	stroke(section, theme.Stroke, 2)

	self.Window:_bindTheme(function(nextTheme)
		section.BackgroundColor3 = nextTheme.Accent
		section.TextColor3 = nextTheme.Ink
		local outline = section:FindFirstChildOfClass("UIStroke")
		if outline then
			outline.Color = nextTheme.Stroke
		end
	end)

	return section
end

function Tab:Label(text)
	local theme = self.Window.Theme
	local label = make("TextLabel", {
		BackgroundColor3 = theme.PanelAlt,
		BorderSizePixel = 0,
		Text = tostring(text or "Label"),
		TextColor3 = theme.Ink,
		Size = UDim2.new(1, 0, 0, 36),
		Parent = self.Page,
	})
	setTextDefaults(label, 16)
	padding(label, 12, 0, 12, 0)
	round(label, 8)
	stroke(label, theme.Stroke, 2)

	self.Window:_bindTheme(function(nextTheme)
		label.BackgroundColor3 = nextTheme.PanelAlt
		label.TextColor3 = nextTheme.Ink
	end)

	return {
		Set = function(_, value)
			label.Text = tostring(value)
		end,
		Instance = label,
	}
end

function Tab:Paragraph(options)
	options = options or {}
	local theme = self.Window.Theme
	local frame = createBase(self.Page, theme)
	frame.Size = UDim2.new(1, 0, 0, 96)

	local title = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = options.Title or "Paragraph",
		TextColor3 = theme.Ink,
		Size = UDim2.new(1, 0, 0, 24),
		Parent = frame,
	})
	setTextDefaults(title, 18)

	local body = make("TextLabel", {
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		Text = options.Content or options.Text or "",
		TextColor3 = theme.Muted,
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		Position = UDim2.fromOffset(0, 30),
		Size = UDim2.new(1, 0, 1, -30),
		Parent = frame,
	})

	self.Window:_bindTheme(function(nextTheme)
		frame.BackgroundColor3 = nextTheme.Panel
		title.TextColor3 = nextTheme.Ink
		body.TextColor3 = nextTheme.Muted
	end)

	return {
		Set = function(_, value)
			body.Text = tostring(value)
		end,
		Instance = frame,
	}
end

function Tab:Button(options)
	options = options or {}
	local theme = self.Window.Theme
	local base = self:_base(options)
	local button = makeSmallButton(base, options.ButtonText or "DO IT", theme)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, 0, 0.5, 0)

	button.MouseButton1Click:Connect(function()
		button.Rotation = math.random(-2, 2)
		tween(button, 0.08, { Size = UDim2.fromOffset(76, 28) })
		task.delay(0.08, function()
			if button.Parent then
				tween(button, 0.12, { Size = UDim2.fromOffset(82, 30) })
			end
		end)
		call(options.Callback)
	end)

	self.Window:_bindTheme(function(nextTheme)
		button.BackgroundColor3 = nextTheme.Accent
		button.TextColor3 = nextTheme.Ink
	end)

	return base
end

function Tab:Toggle(options)
	options = options or {}
	local theme = self.Window.Theme
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = options.Default == true
	local base = self:_base(options)
	local button = makeSmallButton(base, boolText(value), theme)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, 0, 0.5, 0)
	button.BackgroundColor3 = value and theme.Good or theme.PanelAlt

	local function set(nextValue, silent)
		value = nextValue == true
		self.Window:_setFlag(flag, value)
		button.Text = boolText(value)
		tween(button, 0.12, { BackgroundColor3 = value and self.Window.Theme.Good or self.Window.Theme.PanelAlt })
		if not silent then
			call(options.Callback, value)
		end
	end

	button.MouseButton1Click:Connect(function()
		set(not value)
	end)

	self.Window:_registerFlag(flag, set)
	set(value, true)

	self.Window:_bindTheme(function(nextTheme)
		button.TextColor3 = nextTheme.Ink
		button.BackgroundColor3 = value and nextTheme.Good or nextTheme.PanelAlt
	end)

	return {
		Set = set,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = base,
	}
end

function Tab:Slider(options)
	options = options or {}
	local theme = self.Window.Theme
	local minValue = tonumber(options.Min) or 0
	local maxValue = tonumber(options.Max) or 100
	local step = tonumber(options.Step) or 1
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = clampNumber(options.Default or minValue, minValue, maxValue)
	value = roundToStep(value, step)

	local base = self:_base({
		Title = options.Title,
		Description = options.Description,
	})
	base.Size = UDim2.new(1, 0, 0, options.Description and 84 or 68)

	local valueLabel = make("TextLabel", {
		BackgroundTransparency = 1,
		Font = safeFont(),
		Text = tostring(value),
		TextColor3 = theme.AccentAlt,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Right,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.fromOffset(82, 24),
		Parent = base,
	})

	local track = make("Frame", {
		BackgroundColor3 = theme.PanelAlt,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -18),
		Size = UDim2.new(1, 0, 0, 10),
		Parent = base,
	})
	round(track, 5)
	stroke(track, theme.Stroke, 1)

	local fill = make("Frame", {
		BackgroundColor3 = theme.Accent,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(0, 1),
		Parent = track,
	})
	round(fill, 5)

	local dragging = false
	local userInput = service("UserInputService")

	local function set(nextValue, silent)
		value = roundToStep(clampNumber(nextValue, minValue, maxValue), step)
		local alpha = (value - minValue) / math.max(maxValue - minValue, 0.0001)
		self.Window:_setFlag(flag, value)
		valueLabel.Text = tostring(value)
		tween(fill, 0.08, { Size = UDim2.fromScale(alpha, 1) })
		if not silent then
			call(options.Callback, value)
		end
	end

	local function readFromX(x)
		local alpha = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
		set(minValue + ((maxValue - minValue) * alpha))
	end

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			readFromX(input.Position.X)
		end
	end)

	userInput.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			readFromX(input.Position.X)
		end
	end)

	userInput.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	self.Window:_registerFlag(flag, set)
	set(value, true)

	self.Window:_bindTheme(function(nextTheme)
		valueLabel.TextColor3 = nextTheme.AccentAlt
		track.BackgroundColor3 = nextTheme.PanelAlt
		fill.BackgroundColor3 = nextTheme.Accent
	end)

	return {
		Set = set,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = base,
	}
end

function Tab:Dropdown(options)
	options = options or {}
	local theme = self.Window.Theme
	local choices = options.Options or options.Values or {}
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = options.Default or choices[1]
	local open = false

	local base = self:_base(options)
	local button = makeSmallButton(base, tostring(value or "Pick"), theme)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, 0, 0.5, 0)
	button.Size = UDim2.fromOffset(118, 30)

	local menu = make("Frame", {
		BackgroundColor3 = theme.PanelAlt,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -118, 1, 6),
		Size = UDim2.fromOffset(118, 0),
		ClipsDescendants = true,
		Visible = false,
		ZIndex = 8,
		Parent = base,
	})
	round(menu, 7)
	stroke(menu, theme.Stroke, 2)
	local menuLayout = list(menu, 2)
	autoY(menu, menuLayout)

	local function set(nextValue, silent)
		value = nextValue
		self.Window:_setFlag(flag, value)
		button.Text = tostring(value)
		if not silent then
			call(options.Callback, value)
		end
	end

	for _, choice in ipairs(choices) do
		local option = make("TextButton", {
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Font = safeFont(),
			Text = tostring(choice),
			TextColor3 = theme.Ink,
			TextSize = 14,
			Size = UDim2.new(1, 0, 0, 28),
			ZIndex = 9,
			Parent = menu,
		})
		option.MouseButton1Click:Connect(function()
			set(choice)
			open = false
			menu.Visible = false
		end)
	end

	button.MouseButton1Click:Connect(function()
		open = not open
		menu.Visible = open
	end)

	self.Window:_registerFlag(flag, set)
	if value ~= nil then
		set(value, true)
	end

	self.Window:_bindTheme(function(nextTheme)
		button.BackgroundColor3 = nextTheme.Accent
		button.TextColor3 = nextTheme.Ink
		menu.BackgroundColor3 = nextTheme.PanelAlt
		for _, child in ipairs(menu:GetChildren()) do
			if child:IsA("TextButton") then
				child.TextColor3 = nextTheme.Ink
			end
		end
	end)

	return {
		Set = set,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = base,
	}
end

function Tab:Textbox(options)
	options = options or {}
	local theme = self.Window.Theme
	local flag = normalizeFlag(options.Title, options.Flag)
	local base = self:_base(options)
	local box = make("TextBox", {
		BackgroundColor3 = theme.PanelAlt,
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		Font = Enum.Font.Gotham,
		PlaceholderText = options.Placeholder or "type here",
		Text = tostring(options.Default or ""),
		TextColor3 = theme.Ink,
		PlaceholderColor3 = theme.Muted,
		TextSize = 14,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.fromOffset(150, 30),
		Parent = base,
	})
	round(box, 7)
	stroke(box, theme.Stroke, 1)

	local function set(nextValue, silent)
		box.Text = tostring(nextValue or "")
		self.Window:_setFlag(flag, box.Text)
		if not silent then
			call(options.Callback, box.Text)
		end
	end

	box.FocusLost:Connect(function(enterPressed)
		if options.SubmitOnly == false or enterPressed then
			set(box.Text)
		end
	end)

	self.Window:_registerFlag(flag, set)
	set(box.Text, true)

	self.Window:_bindTheme(function(nextTheme)
		box.BackgroundColor3 = nextTheme.PanelAlt
		box.TextColor3 = nextTheme.Ink
		box.PlaceholderColor3 = nextTheme.Muted
	end)

	return {
		Set = set,
		Get = function()
			return box.Text
		end,
		Flag = flag,
		Instance = base,
	}
end

function Tab:Keybind(options)
	options = options or {}
	local theme = self.Window.Theme
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = options.Default or Enum.KeyCode.RightShift
	local listening = false
	local base = self:_base(options)
	local button = makeSmallButton(base, value.Name, theme)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, 0, 0.5, 0)
	button.Size = UDim2.fromOffset(118, 30)

	local function set(nextValue, silent)
		if typeof(nextValue) == "string" then
			nextValue = Enum.KeyCode[nextValue] or value
		end
		value = nextValue
		button.Text = value.Name
		self.Window:_setFlag(flag, value.Name)
		if not silent then
			call(options.Callback, value)
		end
	end

	button.MouseButton1Click:Connect(function()
		listening = true
		button.Text = "..."
	end)

	service("UserInputService").InputBegan:Connect(function(input, gameProcessed)
		if listening and input.KeyCode ~= Enum.KeyCode.Unknown then
			listening = false
			set(input.KeyCode)
			return
		end

		if not gameProcessed and input.KeyCode == value then
			call(options.Pressed, value)
		end
	end)

	self.Window:_registerFlag(flag, set)
	set(value, true)

	return {
		Set = set,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = base,
	}
end

function Tab:ColorPicker(options)
	options = options or {}
	local theme = self.Window.Theme
	local flag = normalizeFlag(options.Title, options.Flag)
	local colors = options.Colors or {
		Color3.fromRGB(255, 82, 92),
		Color3.fromRGB(255, 193, 77),
		Color3.fromRGB(88, 222, 129),
		Color3.fromRGB(80, 170, 255),
		Color3.fromRGB(190, 120, 255),
		Color3.fromRGB(255, 255, 255),
	}
	local value = options.Default or colors[1]
	local base = self:_base(options)
	base.Size = UDim2.new(1, 0, 0, options.Description and 92 or 70)

	local holder = make("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.fromOffset(174, 28),
		Parent = base,
	})
	grid(holder, UDim2.fromOffset(24, 24), 5)

	local swatches = {}

	local function set(nextValue, silent)
		if typeof(nextValue) == "string" then
			nextValue = hexToColor(nextValue, value)
		end
		value = nextValue
		self.Window:_setFlag(flag, colorToHex(value))
		for swatch, color in pairs(swatches) do
			local outline = swatch:FindFirstChildOfClass("UIStroke")
			if outline then
				outline.Thickness = color == value and 3 or 1
			end
		end
		if not silent then
			call(options.Callback, value)
		end
	end

	for _, color in ipairs(colors) do
		local swatch = make("TextButton", {
			AutoButtonColor = false,
			BackgroundColor3 = color,
			BorderSizePixel = 0,
			Text = "",
			Parent = holder,
		})
		round(swatch, 6)
		stroke(swatch, theme.Stroke, 1)
		swatches[swatch] = color
		swatch.MouseButton1Click:Connect(function()
			set(color)
		end)
	end

	self.Window:_registerFlag(flag, set)
	set(value, true)

	return {
		Set = set,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = base,
	}
end

function Tab:Progress(options)
	options = options or {}
	local theme = self.Window.Theme
	local value = tonumber(options.Value) or 0
	local maxValue = tonumber(options.Max) or 100
	local base = self:_base({
		Title = options.Title,
		Description = options.Description,
	})
	base.Size = UDim2.new(1, 0, 0, options.Description and 84 or 68)

	local track = make("Frame", {
		BackgroundColor3 = theme.PanelAlt,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -18),
		Size = UDim2.new(1, 0, 0, 10),
		Parent = base,
	})
	round(track, 5)

	local fill = make("Frame", {
		BackgroundColor3 = theme.AccentAlt,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(0, 1),
		Parent = track,
	})
	round(fill, 5)

	local function set(nextValue)
		value = clampNumber(nextValue, 0, maxValue)
		fill.Size = UDim2.fromScale(value / math.max(maxValue, 1), 1)
	end

	set(value)

	self.Window:_bindTheme(function(nextTheme)
		track.BackgroundColor3 = nextTheme.PanelAlt
		fill.BackgroundColor3 = nextTheme.AccentAlt
	end)

	return {
		Set = set,
		Get = function()
			return value
		end,
		Instance = base,
	}
end

function Tab:ThemeDropdown(title)
	return self:Dropdown({
		Title = title or "Theme",
		Description = "Swap the paint job.",
		Options = self.Window:GetThemes(),
		Default = self.Window.ThemeName,
		Flag = "__theme",
		Callback = function(themeName)
			self.Window:SetTheme(themeName)
		end,
	})
end

function CursedPaint:Notify(options)
	local window = CursedPaint._lastWindow
	if window then
		return window:Notify(options)
	end
end

local originalCreateWindow = CursedPaint.CreateWindow
function CursedPaint:CreateWindow(options)
	local window = originalCreateWindow(self, options)
	CursedPaint._lastWindow = window
	return window
end

return CursedPaint

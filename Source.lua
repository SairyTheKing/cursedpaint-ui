-- CursedPaint UI
-- Flat FingerPaint Roblox UI library with a translucent paper/menu style.

local CursedPaint = {}
CursedPaint.__index = CursedPaint
CursedPaint.Version = "0.4.0"
CursedPaint.PlaceholderImage = "rbxasset://textures/ui/GuiImagePlaceholder.png"

CursedPaint.Themes = {
	Paper = {
		Backdrop = Color3.fromRGB(226, 224, 215),
		Left = Color3.fromRGB(238, 235, 204),
		Panel = Color3.fromRGB(245, 244, 238),
		PanelAlt = Color3.fromRGB(223, 221, 214),
		Text = Color3.fromRGB(18, 18, 18),
		Muted = Color3.fromRGB(60, 60, 60),
		Ink = Color3.fromRGB(0, 0, 0),
		SelectedTop = Color3.fromRGB(255, 246, 158),
		SelectedBottom = Color3.fromRGB(214, 98, 62),
		Bar = Color3.fromRGB(103, 103, 99),
		BarFill = Color3.fromRGB(21, 205, 244),
		Good = Color3.fromRGB(61, 183, 100),
		Bad = Color3.fromRGB(215, 65, 65),
		PanelTransparency = 0.24,
		RowTransparency = 0.12,
	},
	Smoke = {
		Backdrop = Color3.fromRGB(196, 196, 190),
		Left = Color3.fromRGB(221, 218, 198),
		Panel = Color3.fromRGB(244, 244, 240),
		PanelAlt = Color3.fromRGB(205, 205, 200),
		Text = Color3.fromRGB(12, 12, 12),
		Muted = Color3.fromRGB(67, 67, 67),
		Ink = Color3.fromRGB(0, 0, 0),
		SelectedTop = Color3.fromRGB(255, 255, 215),
		SelectedBottom = Color3.fromRGB(145, 145, 145),
		Bar = Color3.fromRGB(82, 82, 82),
		BarFill = Color3.fromRGB(50, 215, 255),
		Good = Color3.fromRGB(67, 171, 94),
		Bad = Color3.fromRGB(201, 67, 67),
		PanelTransparency = 0.18,
		RowTransparency = 0.08,
	},
	Blood = {
		Backdrop = Color3.fromRGB(53, 32, 34),
		Left = Color3.fromRGB(238, 219, 197),
		Panel = Color3.fromRGB(247, 237, 224),
		PanelAlt = Color3.fromRGB(224, 197, 187),
		Text = Color3.fromRGB(20, 10, 10),
		Muted = Color3.fromRGB(95, 55, 55),
		Ink = Color3.fromRGB(0, 0, 0),
		SelectedTop = Color3.fromRGB(255, 209, 129),
		SelectedBottom = Color3.fromRGB(188, 46, 52),
		Bar = Color3.fromRGB(103, 77, 77),
		BarFill = Color3.fromRGB(255, 80, 76),
		Good = Color3.fromRGB(73, 179, 91),
		Bad = Color3.fromRGB(215, 65, 65),
		PanelTransparency = 0.22,
		RowTransparency = 0.1,
	},
	Void = {
		Backdrop = Color3.fromRGB(25, 27, 34),
		Left = Color3.fromRGB(215, 219, 235),
		Panel = Color3.fromRGB(236, 239, 250),
		PanelAlt = Color3.fromRGB(194, 202, 229),
		Text = Color3.fromRGB(7, 9, 16),
		Muted = Color3.fromRGB(58, 64, 88),
		Ink = Color3.fromRGB(0, 0, 0),
		SelectedTop = Color3.fromRGB(218, 235, 255),
		SelectedBottom = Color3.fromRGB(66, 122, 218),
		Bar = Color3.fromRGB(75, 80, 98),
		BarFill = Color3.fromRGB(66, 208, 255),
		Good = Color3.fromRGB(63, 178, 127),
		Bad = Color3.fromRGB(204, 77, 98),
		PanelTransparency = 0.18,
		RowTransparency = 0.08,
	},
	Forest = {
		Backdrop = Color3.fromRGB(32, 49, 43),
		Left = Color3.fromRGB(218, 232, 204),
		Panel = Color3.fromRGB(237, 244, 226),
		PanelAlt = Color3.fromRGB(201, 221, 190),
		Text = Color3.fromRGB(9, 22, 16),
		Muted = Color3.fromRGB(55, 85, 68),
		Ink = Color3.fromRGB(0, 0, 0),
		SelectedTop = Color3.fromRGB(233, 255, 162),
		SelectedBottom = Color3.fromRGB(72, 161, 98),
		Bar = Color3.fromRGB(81, 102, 85),
		BarFill = Color3.fromRGB(82, 222, 133),
		Good = Color3.fromRGB(71, 184, 95),
		Bad = Color3.fromRGB(206, 75, 73),
		PanelTransparency = 0.2,
		RowTransparency = 0.1,
	},
	Candy = {
		Backdrop = Color3.fromRGB(55, 40, 68),
		Left = Color3.fromRGB(247, 222, 236),
		Panel = Color3.fromRGB(255, 242, 250),
		PanelAlt = Color3.fromRGB(232, 200, 224),
		Text = Color3.fromRGB(29, 16, 31),
		Muted = Color3.fromRGB(104, 65, 105),
		Ink = Color3.fromRGB(0, 0, 0),
		SelectedTop = Color3.fromRGB(255, 239, 161),
		SelectedBottom = Color3.fromRGB(232, 90, 173),
		Bar = Color3.fromRGB(117, 93, 118),
		BarFill = Color3.fromRGB(35, 211, 255),
		Good = Color3.fromRGB(80, 195, 119),
		Bad = Color3.fromRGB(224, 76, 116),
		PanelTransparency = 0.18,
		RowTransparency = 0.08,
	},
}

local Window = {}
Window.__index = Window

local Tab = {}
Tab.__index = Tab

local function kindOf(value)
	if typeof then
		return typeof(value)
	end
	return type(value)
end

local function isFunction(value)
	return kindOf(value) == "function"
end

local function service(name)
	return game:GetService(name)
end

local function cloneTheme(theme)
	local copy = {}
	for key, value in pairs(theme) do
		copy[key] = value
	end
	return copy
end

local function getTheme(name)
	return cloneTheme(CursedPaint.Themes[name] or CursedPaint.Themes.Paper)
end

local function themeNames()
	local names = {}
	for name in pairs(CursedPaint.Themes) do
		table.insert(names, name)
	end
	table.sort(names)
	return names
end

local function handFont()
	local ok, font = pcall(function()
		return Enum.Font.FingerPaint
	end)

	if ok and font then
		return font
	end

	local okCartoon, cartoon = pcall(function()
		return Enum.Font.Cartoon
	end)

	if okCartoon and cartoon then
		return cartoon
	end

	return Enum.Font.GothamBold
end

local function applyHandFont(instance)
	instance.Font = handFont()
	pcall(function()
		if Font then
			instance.FontFace = Font.new("rbxasset://fonts/families/FingerPaint.json")
		end
	end)
end

local function bodyFont()
	return Enum.Font.Gotham
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

local function stroke(parent, theme, thickness)
	return make("UIStroke", {
		Color = theme.Ink,
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

local function list(parent, gap)
	return make("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, gap or 6),
		Parent = parent,
	})
end

local function grid(parent, cellSize, gap)
	return make("UIGridLayout", {
		CellSize = cellSize,
		CellPadding = UDim2.fromOffset(gap or 6, gap or 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = parent,
	})
end

local function tween(instance, duration, goal)
	local tweenService = service("TweenService")
	local info = TweenInfo.new(duration or 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local created = tweenService:Create(instance, info, goal)
	created:Play()
	return created
end

local function call(callback, ...)
	if isFunction(callback) then
		task.spawn(callback, ...)
	end
end

local function normalizeFlag(title, flag)
	if flag and flag ~= "" then
		return tostring(flag)
	end

	return tostring(title or "flag"):lower():gsub("[^%w]+", "_"):gsub("^_+", ""):gsub("_+$", "")
end

local function boolText(value)
	return value and "ON" or "OFF"
end

local function clampNumber(value, minValue, maxValue)
	return math.clamp(tonumber(value) or minValue, minValue, maxValue)
end

local function roundToStep(value, step)
	local stepValue = tonumber(step) or 1
	if stepValue <= 0 then
		return value
	end
	return math.floor((value / stepValue) + 0.5) * stepValue
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

local function autoCanvas(scroll, layout)
	local function update()
		scroll.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 10)
	end
	update()
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update)
end

local function resolveParent()
	local okHui, hui = pcall(function()
		if gethui then
			return gethui()
		end
		return nil
	end)

	if okHui and hui then
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

local function setHandText(label, size, align)
	applyHandFont(label)
	label.TextSize = size or 18
	label.TextWrapped = true
	label.TextXAlignment = align or Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
end

local function updateStroke(parent, theme)
	local outline = parent:FindFirstChildOfClass("UIStroke")
	if outline then
		outline.Color = theme.Ink
	end
end

local function normalizeImage(image)
	if image == nil or image == "" then
		return nil
	end

	if type(image) == "number" then
		return "rbxassetid://" .. tostring(image)
	end

	local text = tostring(image)
	if text:match("^%d+$") then
		return "rbxassetid://" .. text
	end

	return text
end

local function imageLabel(parent, image, props)
	local normalized = normalizeImage(image)
	if not normalized then
		return nil
	end

	props = props or {}
	props.BackgroundTransparency = props.BackgroundTransparency == nil and 1 or props.BackgroundTransparency
	props.BorderSizePixel = props.BorderSizePixel or 0
	props.Image = normalized
	props.Parent = parent

	local label = make("ImageLabel", props)
	return label
end

local function makeButton(parent, text, theme, width)
	local button = make("TextButton", {
		AutoButtonColor = false,
		BackgroundColor3 = theme.Panel,
		BackgroundTransparency = theme.RowTransparency,
		BorderSizePixel = 0,
		Font = handFont(),
		Text = text,
		TextColor3 = theme.Text,
		TextSize = 18,
		Size = UDim2.fromOffset(width or 96, 31),
		Parent = parent,
	})
	applyHandFont(button)
	stroke(button, theme, 2)

	button.MouseEnter:Connect(function()
		tween(button, 0.1, { BackgroundTransparency = 0.02 })
	end)

	button.MouseLeave:Connect(function()
		tween(button, 0.1, { BackgroundTransparency = theme.RowTransparency })
	end)

	return button
end

local function createProgressBar(parent, theme, yOffset)
	local track = make("Frame", {
		Active = true,
		BackgroundColor3 = theme.Bar,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 8, 0, yOffset),
		Size = UDim2.new(1, -16, 0, 13),
		Parent = parent,
	})
	stroke(track, theme, 1)

	local fill = make("Frame", {
		BackgroundColor3 = theme.BarFill,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(0, 1),
		Parent = track,
	})

	return track, fill
end

local function rowTitle(parent, title, theme, y, rightWidth)
	local label = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(title or "Control"),
		TextColor3 = theme.Text,
		Position = UDim2.fromOffset(8, y or 3),
		Size = UDim2.new(1, -(rightWidth or 120), 0, 28),
		Parent = parent,
	})
	setHandText(label, 21)
	return label
end

function CursedPaint:CreateWindow(options)
	options = options or {}

	local themeName = options.Theme or "Paper"
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

	local root = make("Frame", {
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = theme.Backdrop,
		BackgroundTransparency = theme.PanelTransparency,
		BorderSizePixel = 0,
		Position = options.Position or UDim2.fromScale(0.5, 0.5),
		Size = options.Size or UDim2.fromOffset(650, 370),
		ZIndex = 1,
		Parent = gui,
	})
	stroke(root, theme, 2)

	local texture = make("Frame", {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.86,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(4, 4),
		Size = UDim2.new(1, -8, 1, -8),
		ZIndex = 1,
		Parent = root,
	})
	stroke(texture, theme, 1)

	local backgroundImage = imageLabel(root, options.BackgroundImage, {
		ImageTransparency = options.BackgroundImageTransparency or 0.72,
		Position = UDim2.fromOffset(4, 4),
		ScaleType = Enum.ScaleType.Crop,
		Size = UDim2.new(1, -8, 1, -8),
		ZIndex = 2,
	})

	local left = make("Frame", {
		BackgroundColor3 = theme.Left,
		BackgroundTransparency = 0.12,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(8, 8),
		Size = UDim2.new(0, 176, 1, -16),
		ZIndex = 3,
		Parent = root,
	})
	stroke(left, theme, 1)

	local titleLabel
	local tabsTop = 6
	if options.Title or options.Subtitle then
		titleLabel = make("TextLabel", {
			BackgroundTransparency = 1,
			Text = tostring(options.Title or "CursedPaint"),
			TextColor3 = theme.Text,
			Position = UDim2.fromOffset(9, 5),
			Size = UDim2.new(1, -18, 0, 28),
			ZIndex = 5,
			Parent = left,
		})
		setHandText(titleLabel, 21, Enum.TextXAlignment.Center)
		tabsTop = 42
	end

	local tabs = make("ScrollingFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.fromOffset(0, 0),
		Position = UDim2.fromOffset(6, tabsTop),
		ScrollBarImageColor3 = theme.Ink,
		ScrollBarThickness = 3,
		Size = UDim2.new(1, -12, 1, -(tabsTop + 6)),
		ZIndex = 4,
		Parent = left,
	})
	local tabsLayout = list(tabs, 1)
	autoCanvas(tabs, tabsLayout)

	local content = make("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(194, 8),
		Size = UDim2.new(1, -202, 1, -16),
		ZIndex = 3,
		Parent = root,
	})

	local sideImage = imageLabel(content, options.SideImage or options.PortraitImage, {
		AnchorPoint = Vector2.new(1, 0),
		ImageTransparency = options.SideImageTransparency or options.PortraitTransparency or 0.62,
		Position = UDim2.new(1, -4, 0, 0),
		ScaleType = Enum.ScaleType.Crop,
		Size = UDim2.new(0, options.SideImageWidth or 155, 1, 0),
		ZIndex = 3,
	})

	local bottomStrip = make("Frame", {
		BackgroundColor3 = theme.Bar,
		BackgroundTransparency = 0.64,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 8, 1, -18),
		Size = UDim2.new(1, -16, 0, 10),
		ZIndex = 2,
		Parent = root,
	})
	stroke(bottomStrip, theme, 1)

	local close = makeButton(root, "X", theme, 28)
	close.Position = UDim2.new(1, -38, 0, 10)
	close.ZIndex = 20

	local minimize = makeButton(root, "-", theme, 28)
	minimize.Position = UDim2.new(1, -72, 0, 10)
	minimize.ZIndex = 20

	local toastHolder = make("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -330, 0, 16),
		Size = UDim2.fromOffset(310, 330),
		Parent = gui,
	})
	local toastLayout = list(toastHolder, 8)
	toastLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	local self = setmetatable({
		ScreenGui = gui,
		Root = root,
		Texture = texture,
		BackgroundImage = backgroundImage,
		Left = left,
		TitleLabel = titleLabel,
		TabsBar = tabs,
		Content = content,
		SideImage = sideImage,
		BottomStrip = bottomStrip,
		ToastHolder = toastHolder,
		ThemeName = themeName,
		Theme = theme,
		Flags = {},
		_flagSetters = {},
		_themeBindings = {},
		_tabs = {},
		_tabButtons = {},
		_activeTab = nil,
		_visible = true,
		_minimized = false,
		_normalSize = root.Size,
		_configFolder = options.ConfigFolder or "CursedPaintUI",
	}, Window)

	self:_bindTheme(function(nextTheme)
		root.BackgroundColor3 = nextTheme.Backdrop
		root.BackgroundTransparency = nextTheme.PanelTransparency
		texture.BackgroundTransparency = 0.86
		if backgroundImage then
			backgroundImage.ImageTransparency = options.BackgroundImageTransparency or 0.72
		end
		left.BackgroundColor3 = nextTheme.Left
		if titleLabel then
			titleLabel.TextColor3 = nextTheme.Text
		end
		tabs.ScrollBarImageColor3 = nextTheme.Ink
		bottomStrip.BackgroundColor3 = nextTheme.Bar
		close.BackgroundColor3 = nextTheme.Panel
		close.BackgroundTransparency = nextTheme.RowTransparency
		close.TextColor3 = nextTheme.Text
		minimize.BackgroundColor3 = nextTheme.Panel
		minimize.BackgroundTransparency = nextTheme.RowTransparency
		minimize.TextColor3 = nextTheme.Text
		updateStroke(root, nextTheme)
		updateStroke(texture, nextTheme)
		updateStroke(left, nextTheme)
		updateStroke(bottomStrip, nextTheme)
		updateStroke(close, nextTheme)
		updateStroke(minimize, nextTheme)
	end)

	close.MouseButton1Click:Connect(function()
		self:Destroy()
	end)

	minimize.MouseButton1Click:Connect(function()
		self:SetMinimized(not self._minimized)
	end)

	self:_makeDraggable(root, root)

	local userInput = service("UserInputService")
	if options.ToggleKey then
		userInput.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == options.ToggleKey then
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
	self.Flags.__theme = name
	self:_applyTheme()
	return true
end

function Window:SetBackgroundImage(image, transparency)
	local normalized = normalizeImage(image)
	if not normalized then
		if self.BackgroundImage then
			self.BackgroundImage:Destroy()
			self.BackgroundImage = nil
		end
		return nil
	end

	if not self.BackgroundImage then
		self.BackgroundImage = imageLabel(self.Root, normalized, {
			ImageTransparency = transparency or 0.72,
			Position = UDim2.fromOffset(4, 4),
			ScaleType = Enum.ScaleType.Crop,
			Size = UDim2.new(1, -8, 1, -8),
			ZIndex = 2,
		})
	else
		self.BackgroundImage.Image = normalized
		self.BackgroundImage.ImageTransparency = transparency or self.BackgroundImage.ImageTransparency
	end

	return self.BackgroundImage
end

function Window:SetSideImage(image, transparency)
	local normalized = normalizeImage(image)
	if not normalized then
		if self.SideImage then
			self.SideImage:Destroy()
			self.SideImage = nil
		end
		return nil
	end

	if not self.SideImage then
		self.SideImage = imageLabel(self.Content, normalized, {
			AnchorPoint = Vector2.new(1, 0),
			ImageTransparency = transparency or 0.62,
			Position = UDim2.new(1, -4, 0, 0),
			ScaleType = Enum.ScaleType.Crop,
			Size = UDim2.new(0, 155, 1, 0),
			ZIndex = 3,
		})
	else
		self.SideImage.Image = normalized
		self.SideImage.ImageTransparency = transparency or self.SideImage.ImageTransparency
	end

	return self.SideImage
end

function Window:GetThemes()
	return themeNames()
end

function Window:SetVisible(visible)
	self._visible = visible == true
	self.Root.Visible = self._visible
end

function Window:SetMinimized(minimized)
	self._minimized = minimized == true
	if self._minimized then
		self.Left.Visible = false
		self.Content.Visible = false
		tween(self.Root, 0.14, { Size = UDim2.fromOffset(140, 42) })
	else
		self.Left.Visible = true
		self.Content.Visible = true
		tween(self.Root, 0.14, { Size = self._normalSize })
	end
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
		CanvasSize = UDim2.fromOffset(0, 0),
		ScrollBarImageColor3 = theme.Ink,
		ScrollBarThickness = 3,
		Size = UDim2.fromScale(1, 1),
		Visible = false,
		Parent = self.Content,
	})
	padding(page, 0, 0, 4, 0)
	local pageLayout = list(page, 7)
	autoCanvas(page, pageLayout)

	local button = make("TextButton", {
		AutoButtonColor = false,
		BackgroundColor3 = theme.Left,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Font = handFont(),
		Text = (icon and icon ~= "" and (icon .. " ") or "") .. tostring(title or "Tab"),
		TextColor3 = theme.Text,
		TextSize = 16,
		Size = UDim2.new(1, 0, 0, 28),
		Parent = self.TabsBar,
	})
	applyHandFont(button)
	stroke(button, theme, 1)

	local gradient = make("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, theme.SelectedTop),
			ColorSequenceKeypoint.new(1, theme.SelectedBottom),
		}),
		Enabled = false,
		Rotation = 0,
		Parent = button,
	})

	local tab = setmetatable({
		Window = self,
		Title = title,
		Page = page,
		Button = button,
		Gradient = gradient,
		Layout = pageLayout,
	}, Tab)

	table.insert(self._tabs, tab)
	self._tabButtons[tab] = button

	self:_bindTheme(function(nextTheme)
		page.ScrollBarImageColor3 = nextTheme.Ink
		button.TextColor3 = nextTheme.Text
		button.BackgroundColor3 = nextTheme.Left
		updateStroke(button, nextTheme)
		gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, nextTheme.SelectedTop),
			ColorSequenceKeypoint.new(1, nextTheme.SelectedBottom),
		})
		if self._activeTab == tab then
			button.BackgroundTransparency = 0
			gradient.Enabled = true
		else
			button.BackgroundTransparency = 1
			gradient.Enabled = false
		end
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
		other.Gradient.Enabled = other == tab
		other.Button.BackgroundTransparency = other == tab and 0 or 1
	end
	self._activeTab = tab
end

function Window:_setFlag(flag, value)
	self.Flags[flag] = value
end

function Window:_registerFlag(flag, setter)
	self._flagSetters[flag] = setter
end

function Window:Notify(options)
	options = options or {}
	local theme = self.Theme
	local toast = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BackgroundTransparency = theme.RowTransparency,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(310, 76),
		Parent = self.ToastHolder,
	})
	stroke(toast, theme, 2)
	padding(toast, 9, 5, 9, 5)

	local title = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = options.Title or "Notice",
		TextColor3 = theme.Text,
		Size = UDim2.new(1, 0, 0, 25),
		Parent = toast,
	})
	setHandText(title, 18)

	local body = make("TextLabel", {
		BackgroundTransparency = 1,
		Font = bodyFont(),
		Text = options.Content or options.Text or "Something happened.",
		TextColor3 = theme.Muted,
		TextSize = 13,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		Position = UDim2.fromOffset(0, 29),
		Size = UDim2.new(1, 0, 1, -30),
		Parent = toast,
	})

	task.delay(options.Duration or 3, function()
		if toast.Parent then
			tween(toast, 0.12, { BackgroundTransparency = 1 })
			task.wait(0.14)
			if toast.Parent then
				toast:Destroy()
			end
		end
	end)

	return toast
end

function Window:SaveConfig(name)
	local http = service("HttpService")
	local configName = tostring(name or "default")
	local payload = http:JSONEncode({
		theme = self.ThemeName,
		flags = self.Flags,
		version = CursedPaint.Version,
	})

	local savedToFile = false
	pcall(function()
		if makefolder then
			local folderExists = false
			if isfolder then
				folderExists = isfolder(self._configFolder)
			end
			if not folderExists then
				makefolder(self._configFolder)
			end
		end
		if writefile then
			writefile(self._configFolder .. "/" .. configName .. ".json", payload)
			savedToFile = true
		end
	end)

	CursedPaint._memoryConfigs = CursedPaint._memoryConfigs or {}
	CursedPaint._memoryConfigs[configName] = payload
	return savedToFile, payload
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
		return false, "Invalid config JSON."
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

function Tab:_row(height)
	local theme = self.Window.Theme
	local row = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BackgroundTransparency = theme.RowTransparency,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Size = UDim2.new(1, 0, 0, height or 58),
		Parent = self.Page,
	})
	stroke(row, theme, 2)

	self.Window:_bindTheme(function(nextTheme)
		row.BackgroundColor3 = nextTheme.Panel
		row.BackgroundTransparency = nextTheme.RowTransparency
		updateStroke(row, nextTheme)
	end)

	return row
end

function Tab:Section(title)
	local theme = self.Window.Theme
	local label = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(title or "Section"),
		TextColor3 = theme.Text,
		Size = UDim2.new(1, 0, 0, 34),
		Parent = self.Page,
	})
	setHandText(label, 22)

	self.Window:_bindTheme(function(nextTheme)
		label.TextColor3 = nextTheme.Text
	end)

	return label
end

function Tab:Label(text)
	local theme = self.Window.Theme
	local row = self:_row(36)
	local label = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(text or "Label"),
		TextColor3 = theme.Text,
		Position = UDim2.fromOffset(8, 0),
		Size = UDim2.new(1, -16, 1, 0),
		Parent = row,
	})
	setHandText(label, 17)

	self.Window:_bindTheme(function(nextTheme)
		label.TextColor3 = nextTheme.Text
	end)

	return {
		Set = function(_, value)
			label.Text = tostring(value)
		end,
		Instance = row,
	}
end

function Tab:Divider(text)
	local theme = self.Window.Theme
	local row = make("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, text and 30 or 16),
		Parent = self.Page,
	})

	local line = make("Frame", {
		BackgroundColor3 = theme.Ink,
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 8, 0.5, -1),
		Size = UDim2.new(1, -16, 0, 2),
		Parent = row,
	})

	local label
	if text then
		label = make("TextLabel", {
			BackgroundColor3 = theme.Panel,
			BackgroundTransparency = 0,
			Text = tostring(text),
			TextColor3 = theme.Text,
			Position = UDim2.fromOffset(10, 0),
			Size = UDim2.fromOffset(160, 30),
			Parent = row,
		})
		setHandText(label, 16)
	end

	self.Window:_bindTheme(function(nextTheme)
		line.BackgroundColor3 = nextTheme.Ink
		if label then
			label.BackgroundColor3 = nextTheme.Panel
			label.TextColor3 = nextTheme.Text
		end
	end)

	return row
end

function Tab:Space(height)
	return make("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, height or 8),
		Parent = self.Page,
	})
end

function Tab:Paragraph(options)
	options = options or {}
	local theme = self.Window.Theme
	local row = self:_row(88)
	local title = rowTitle(row, options.Title or "Info", theme, 2, 16)
	local body = make("TextLabel", {
		BackgroundTransparency = 1,
		Font = bodyFont(),
		Text = options.Content or options.Text or "",
		TextColor3 = theme.Muted,
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		Position = UDim2.fromOffset(9, 33),
		Size = UDim2.new(1, -18, 1, -38),
		Parent = row,
	})

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		body.TextColor3 = nextTheme.Muted
	end)

	return {
		Set = function(_, value)
			body.Text = tostring(value)
		end,
		Instance = row,
	}
end

function Tab:Image(options)
	options = options or {}
	local theme = self.Window.Theme
	local height = options.Height or 132
	local row = self:_row(height)

	local image = imageLabel(row, options.Image or CursedPaint.PlaceholderImage, {
		ImageColor3 = options.ImageColor3 or Color3.fromRGB(255, 255, 255),
		ImageTransparency = options.ImageTransparency or 0,
		Position = UDim2.fromOffset(0, 0),
		ScaleType = options.ScaleType or Enum.ScaleType.Crop,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,
	})

	local shade = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BackgroundTransparency = 0.28,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -44),
		Size = UDim2.new(1, 0, 0, 44),
		ZIndex = 3,
		Parent = row,
	})

	local title
	if options.Title then
		title = make("TextLabel", {
			BackgroundTransparency = 1,
			Text = tostring(options.Title),
			TextColor3 = theme.Text,
			Position = UDim2.fromOffset(8, height - 42),
			Size = UDim2.new(1, -16, 0, 24),
			ZIndex = 4,
			Parent = row,
		})
		setHandText(title, 20)
	end

	local caption
	if options.Caption or options.Description then
		caption = make("TextLabel", {
			BackgroundTransparency = 1,
			Font = bodyFont(),
			Text = tostring(options.Caption or options.Description),
			TextColor3 = theme.Muted,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromOffset(10, height - 19),
			Size = UDim2.new(1, -20, 0, 16),
			ZIndex = 4,
			Parent = row,
		})
	end

	self.Window:_bindTheme(function(nextTheme)
		shade.BackgroundColor3 = nextTheme.Panel
		if title then
			title.TextColor3 = nextTheme.Text
		end
		if caption then
			caption.TextColor3 = nextTheme.Muted
		end
	end)

	return {
		Set = function(_, nextImage)
			if image then
				image.Image = normalizeImage(nextImage) or CursedPaint.PlaceholderImage
			end
		end,
		Instance = row,
		Image = image,
	}
end

function Tab:Banner(options)
	options = options or {}
	options.Height = options.Height or 96
	return self:Image(options)
end

function Tab:Quest(options)
	options = options or {}
	local theme = self.Window.Theme
	local maxValue = tonumber(options.Max) or 1
	local value = clampNumber(options.Value or 0, 0, maxValue)
	local row = self:_row(options.Height or 82)
	local art = imageLabel(row, options.Image or options.Portrait, {
		AnchorPoint = Vector2.new(1, 0),
		ImageTransparency = options.ImageTransparency or 0.55,
		Position = UDim2.new(1, -2, 0, 2),
		ScaleType = Enum.ScaleType.Crop,
		Size = UDim2.fromOffset(options.ImageWidth or 150, (options.Height or 82) - 4),
		ZIndex = 2,
	})
	local title = rowTitle(row, options.Title or "Quest", theme, 2, art and 168 or 16)
	title.ZIndex = 4
	local counter = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(value) .. "/" .. tostring(maxValue),
		TextColor3 = theme.Text,
		Position = UDim2.fromOffset(8, 33),
		Size = UDim2.new(1, art and -176 or -16, 0, 24),
		ZIndex = 4,
		Parent = row,
	})
	setHandText(counter, 22)
	local track, fill = createProgressBar(row, theme, 60)
	track.ZIndex = 5
	fill.ZIndex = 6

	local function set(nextValue, nextMax)
		if nextMax then
			maxValue = math.max(tonumber(nextMax) or maxValue, 1)
		end
		value = clampNumber(nextValue, 0, maxValue)
		counter.Text = tostring(value) .. "/" .. tostring(maxValue)
		fill.Size = UDim2.fromScale(value / math.max(maxValue, 1), 1)
	end

	set(value, maxValue)

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		counter.TextColor3 = nextTheme.Text
		track.BackgroundColor3 = nextTheme.Bar
		fill.BackgroundColor3 = nextTheme.BarFill
		if art then
			art.ImageTransparency = options.ImageTransparency or 0.55
		end
		updateStroke(track, nextTheme)
	end)

	return {
		Set = function(_, nextValue, nextMax)
			set(nextValue, nextMax)
		end,
		Get = function()
			return value, maxValue
		end,
		Instance = row,
	}
end

function Tab:Progress(options)
	options = options or {}
	local theme = self.Window.Theme
	local maxValue = tonumber(options.Max) or 100
	local value = clampNumber(options.Value or 0, 0, maxValue)
	local row = self:_row(options.Height or 56)
	local title = rowTitle(row, options.Title or "Progress", theme, 0, 16)
	local track, fill = createProgressBar(row, theme, 36)

	local function set(nextValue, nextMax)
		if nextMax then
			maxValue = math.max(tonumber(nextMax) or maxValue, 1)
		end
		value = clampNumber(nextValue, 0, maxValue)
		title.Text = tostring(options.Title or "Progress") .. ": " .. tostring(math.floor((value / maxValue) * 100 + 0.5)) .. "%"
		fill.Size = UDim2.fromScale(value / math.max(maxValue, 1), 1)
	end

	set(value, maxValue)

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		track.BackgroundColor3 = nextTheme.Bar
		fill.BackgroundColor3 = nextTheme.BarFill
		updateStroke(track, nextTheme)
	end)

	return {
		Set = function(_, nextValue, nextMax)
			set(nextValue, nextMax)
		end,
		Get = function()
			return value, maxValue
		end,
		Instance = row,
	}
end

function Tab:Button(options)
	options = options or {}
	local theme = self.Window.Theme
	local row = self:_row(56)
	local title = rowTitle(row, options.Title or "Button", theme, 2, 128)
	local icon = imageLabel(row, options.Icon, {
		ImageTransparency = options.IconTransparency or 0,
		Position = UDim2.fromOffset(8, 10),
		ScaleType = Enum.ScaleType.Fit,
		Size = UDim2.fromOffset(34, 34),
		ZIndex = 4,
	})
	if icon then
		title.Position = UDim2.fromOffset(48, 2)
		title.Size = UDim2.new(1, -168, 0, 28)
	end
	local desc
	if options.Description then
		desc = make("TextLabel", {
			BackgroundTransparency = 1,
			Font = bodyFont(),
			Text = options.Description,
			TextColor3 = theme.Muted,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromOffset(icon and 49 or 9, 32),
			Size = UDim2.new(1, icon and -180 or -140, 0, 18),
			Parent = row,
		})
	end

	local button = makeButton(row, options.ButtonText or "DO", theme, 105)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -8, 0.5, 0)

	button.MouseButton1Click:Connect(function()
		tween(button, 0.06, { Rotation = math.random(-2, 2) })
		task.delay(0.08, function()
			if button.Parent then
				tween(button, 0.1, { Rotation = 0 })
			end
		end)
		call(options.Callback)
	end)

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		button.BackgroundColor3 = nextTheme.Panel
		button.BackgroundTransparency = nextTheme.RowTransparency
		button.TextColor3 = nextTheme.Text
		updateStroke(button, nextTheme)
		if desc then
			desc.TextColor3 = nextTheme.Muted
		end
	end)

	return row
end

function Tab:Toggle(options)
	options = options or {}
	local theme = self.Window.Theme
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = options.Default == true
	local row = self:_row(56)
	local title = rowTitle(row, options.Title or "Toggle", theme, 2, 128)
	local icon = imageLabel(row, options.Icon, {
		ImageTransparency = options.IconTransparency or 0,
		Position = UDim2.fromOffset(8, 10),
		ScaleType = Enum.ScaleType.Fit,
		Size = UDim2.fromOffset(34, 34),
		ZIndex = 4,
	})
	if icon then
		title.Position = UDim2.fromOffset(48, 2)
		title.Size = UDim2.new(1, -168, 0, 28)
	end
	local desc
	if options.Description then
		desc = make("TextLabel", {
			BackgroundTransparency = 1,
			Font = bodyFont(),
			Text = options.Description,
			TextColor3 = theme.Muted,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromOffset(icon and 49 or 9, 32),
			Size = UDim2.new(1, icon and -180 or -140, 0, 18),
			Parent = row,
		})
	end
	local button = makeButton(row, boolText(value), theme, 105)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -8, 0.5, 0)

	local function set(nextValue, silent)
		value = nextValue == true
		self.Window:_setFlag(flag, value)
		button.Text = boolText(value)
		button.BackgroundColor3 = value and self.Window.Theme.BarFill or self.Window.Theme.PanelAlt
		button.BackgroundTransparency = 0.05
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
		title.TextColor3 = nextTheme.Text
		button.TextColor3 = nextTheme.Text
		button.BackgroundColor3 = value and nextTheme.BarFill or nextTheme.PanelAlt
		updateStroke(button, nextTheme)
		if desc then
			desc.TextColor3 = nextTheme.Muted
		end
	end)

	return {
		Set = function(_, nextValue, silent)
			set(nextValue, silent)
		end,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = row,
	}
end

function Tab:Slider(options)
	options = options or {}
	local theme = self.Window.Theme
	local minValue = tonumber(options.Min) or 0
	local maxValue = tonumber(options.Max) or 100
	local step = tonumber(options.Step) or 1
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = roundToStep(clampNumber(options.Default or minValue, minValue, maxValue), step)
	local row = self:_row(72)
	local title = rowTitle(row, options.Title or "Slider", theme, 1, 92)
	local valueLabel = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(value),
		TextColor3 = theme.Text,
		Font = handFont(),
		TextSize = 19,
		TextXAlignment = Enum.TextXAlignment.Right,
		Position = UDim2.new(1, -88, 0, 3),
		Size = UDim2.fromOffset(80, 24),
		Parent = row,
	})
	applyHandFont(valueLabel)
	local track, fill = createProgressBar(row, theme, 48)
	local dragging = false
	local userInput = service("UserInputService")

	local function set(nextValue, silent)
		value = roundToStep(clampNumber(nextValue, minValue, maxValue), step)
		local alpha = (value - minValue) / math.max(maxValue - minValue, 0.0001)
		self.Window:_setFlag(flag, value)
		valueLabel.Text = tostring(value)
		fill.Size = UDim2.fromScale(alpha, 1)
		if not silent then
			call(options.Callback, value)
		end
	end

	local function readPosition(x)
		local alpha = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
		set(minValue + ((maxValue - minValue) * alpha))
	end

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			readPosition(input.Position.X)
		end
	end)

	userInput.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			readPosition(input.Position.X)
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
		title.TextColor3 = nextTheme.Text
		valueLabel.TextColor3 = nextTheme.Text
		track.BackgroundColor3 = nextTheme.Bar
		fill.BackgroundColor3 = nextTheme.BarFill
		updateStroke(track, nextTheme)
	end)

	return {
		Set = function(_, nextValue, silent)
			set(nextValue, silent)
		end,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = row,
	}
end

function Tab:Stepper(options)
	options = options or {}
	local theme = self.Window.Theme
	local minValue = tonumber(options.Min) or 0
	local maxValue = tonumber(options.Max) or 10
	local step = tonumber(options.Step) or 1
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = roundToStep(clampNumber(options.Default or minValue, minValue, maxValue), step)
	local row = self:_row(56)
	local title = rowTitle(row, options.Title or "Stepper", theme, 2, 154)

	local minus = makeButton(row, "-", theme, 32)
	minus.AnchorPoint = Vector2.new(1, 0.5)
	minus.Position = UDim2.new(1, -116, 0.5, 0)

	local valueLabel = make("TextLabel", {
		BackgroundColor3 = theme.PanelAlt,
		BackgroundTransparency = 0.05,
		BorderSizePixel = 0,
		Text = tostring(value),
		TextColor3 = theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Center,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -45, 0.5, 0),
		Size = UDim2.fromOffset(62, 31),
		Parent = row,
	})
	applyHandFont(valueLabel)
	stroke(valueLabel, theme, 1)

	local plus = makeButton(row, "+", theme, 32)
	plus.AnchorPoint = Vector2.new(1, 0.5)
	plus.Position = UDim2.new(1, -8, 0.5, 0)

	local function set(nextValue, silent)
		value = roundToStep(clampNumber(nextValue, minValue, maxValue), step)
		self.Window:_setFlag(flag, value)
		valueLabel.Text = tostring(value)
		if not silent then
			call(options.Callback, value)
		end
	end

	minus.MouseButton1Click:Connect(function()
		set(value - step)
	end)

	plus.MouseButton1Click:Connect(function()
		set(value + step)
	end)

	self.Window:_registerFlag(flag, set)
	set(value, true)

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		minus.BackgroundColor3 = nextTheme.Panel
		minus.TextColor3 = nextTheme.Text
		valueLabel.BackgroundColor3 = nextTheme.PanelAlt
		valueLabel.TextColor3 = nextTheme.Text
		plus.BackgroundColor3 = nextTheme.Panel
		plus.TextColor3 = nextTheme.Text
		updateStroke(minus, nextTheme)
		updateStroke(valueLabel, nextTheme)
		updateStroke(plus, nextTheme)
	end)

	return {
		Set = function(_, nextValue, silent)
			set(nextValue, silent)
		end,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = row,
	}
end

function Tab:Dropdown(options)
	options = options or {}
	local theme = self.Window.Theme
	local choices = options.Options or options.Values or {}
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = options.Default or choices[1]
	local open = false
	local closedHeight = 56
	local row = self:_row(closedHeight)
	local title = rowTitle(row, options.Title or "Dropdown", theme, 2, 136)
	local button = makeButton(row, tostring(value or "Pick"), theme, 124)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -8, 0, 28)
	button.TextSize = 15

	local menu = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(8, closedHeight),
		Size = UDim2.new(1, -16, 0, 0),
		Visible = false,
		ZIndex = 10,
		Parent = row,
	})
	stroke(menu, theme, 2)
	local menuLayout = list(menu, 0)

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
			BackgroundColor3 = theme.Panel,
			BackgroundTransparency = theme.RowTransparency,
			BorderSizePixel = 0,
			Font = handFont(),
			Text = tostring(choice),
			TextColor3 = theme.Text,
			TextSize = 16,
			Size = UDim2.new(1, 0, 0, 28),
			ZIndex = 11,
			Parent = menu,
		})
		applyHandFont(option)
		option.MouseButton1Click:Connect(function()
			set(choice)
			open = false
			menu.Visible = false
			row.Size = UDim2.new(1, 0, 0, closedHeight)
		end)
	end

	button.MouseButton1Click:Connect(function()
		open = not open
		menu.Visible = open
		local menuHeight = #choices * 28
		menu.Size = UDim2.new(1, -16, 0, menuHeight)
		row.Size = UDim2.new(1, 0, 0, open and (closedHeight + menuHeight + 8) or closedHeight)
	end)

	self.Window:_registerFlag(flag, set)
	if value ~= nil then
		set(value, true)
	end

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		button.BackgroundColor3 = nextTheme.Panel
		button.BackgroundTransparency = nextTheme.RowTransparency
		button.TextColor3 = nextTheme.Text
		menu.BackgroundColor3 = nextTheme.Panel
		updateStroke(button, nextTheme)
		updateStroke(menu, nextTheme)
		for _, child in ipairs(menu:GetChildren()) do
			if child:IsA("TextButton") then
				child.TextColor3 = nextTheme.Text
				child.BackgroundColor3 = nextTheme.Panel
			end
		end
	end)

	return {
		Set = function(_, nextValue, silent)
			set(nextValue, silent)
		end,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = row,
	}
end

function Tab:MultiDropdown(options)
	options = options or {}
	local theme = self.Window.Theme
	local choices = options.Options or options.Values or {}
	local flag = normalizeFlag(options.Title, options.Flag)
	local selected = {}
	local open = false
	local closedHeight = 56
	local row = self:_row(closedHeight)
	local title = rowTitle(row, options.Title or "Multi Dropdown", theme, 2, 146)
	local button = makeButton(row, "...", theme, 134)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -8, 0, 28)
	button.TextSize = 14

	local menu = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(8, closedHeight),
		Size = UDim2.new(1, -16, 0, 0),
		Visible = false,
		ZIndex = 10,
		Parent = row,
	})
	stroke(menu, theme, 2)
	list(menu, 0)

	local optionButtons = {}

	local function selectedList()
		local output = {}
		for _, choice in ipairs(choices) do
			if selected[choice] then
				table.insert(output, choice)
			end
		end
		return output
	end

	local function updateButton()
		local output = selectedList()
		if #output == 0 then
			button.Text = "None"
		elseif #output == 1 then
			button.Text = tostring(output[1])
		else
			button.Text = tostring(#output) .. " selected"
		end

		for choice, option in pairs(optionButtons) do
			option.Text = (selected[choice] and "[x] " or "[ ] ") .. tostring(choice)
			option.BackgroundTransparency = selected[choice] and 0.02 or theme.RowTransparency
		end
	end

	local function set(nextValue, silent)
		selected = {}
		if kindOf(nextValue) == "table" then
			for key, item in pairs(nextValue) do
				if type(key) == "number" then
					selected[item] = true
				elseif item == true then
					selected[key] = true
				end
			end
		elseif nextValue ~= nil then
			selected[nextValue] = true
		end

		local output = selectedList()
		self.Window:_setFlag(flag, output)
		updateButton()
		if not silent then
			call(options.Callback, output)
		end
	end

	for _, choice in ipairs(choices) do
		local option = make("TextButton", {
			AutoButtonColor = false,
			BackgroundColor3 = theme.Panel,
			BackgroundTransparency = theme.RowTransparency,
			BorderSizePixel = 0,
			Font = handFont(),
			Text = "[ ] " .. tostring(choice),
			TextColor3 = theme.Text,
			TextSize = 15,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 28),
			ZIndex = 11,
			Parent = menu,
		})
		applyHandFont(option)
		padding(option, 8, 0, 8, 0)
		optionButtons[choice] = option
		option.MouseButton1Click:Connect(function()
			selected[choice] = not selected[choice]
			local output = selectedList()
			self.Window:_setFlag(flag, output)
			updateButton()
			call(options.Callback, output)
		end)
	end

	button.MouseButton1Click:Connect(function()
		open = not open
		menu.Visible = open
		local menuHeight = #choices * 28
		menu.Size = UDim2.new(1, -16, 0, menuHeight)
		row.Size = UDim2.new(1, 0, 0, open and (closedHeight + menuHeight + 8) or closedHeight)
	end)

	self.Window:_registerFlag(flag, set)
	set(options.Default or {}, true)

	self.Window:_bindTheme(function(nextTheme)
		theme = nextTheme
		title.TextColor3 = nextTheme.Text
		button.BackgroundColor3 = nextTheme.Panel
		button.BackgroundTransparency = nextTheme.RowTransparency
		button.TextColor3 = nextTheme.Text
		menu.BackgroundColor3 = nextTheme.Panel
		updateStroke(button, nextTheme)
		updateStroke(menu, nextTheme)
		for _, option in pairs(optionButtons) do
			option.BackgroundColor3 = nextTheme.Panel
			option.TextColor3 = nextTheme.Text
		end
		updateButton()
	end)

	return {
		Set = function(_, nextValue, silent)
			set(nextValue, silent)
		end,
		Get = function()
			return selectedList()
		end,
		Flag = flag,
		Instance = row,
	}
end

function Tab:Textbox(options)
	options = options or {}
	local theme = self.Window.Theme
	local flag = normalizeFlag(options.Title, options.Flag)
	local row = self:_row(58)
	local title = rowTitle(row, options.Title or "Textbox", theme, 2, 168)
	local box = make("TextBox", {
		BackgroundColor3 = theme.PanelAlt,
		BackgroundTransparency = 0.05,
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		Font = bodyFont(),
		PlaceholderText = options.Placeholder or "type",
		Text = tostring(options.Default or ""),
		TextColor3 = theme.Text,
		PlaceholderColor3 = theme.Muted,
		TextSize = 14,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.fromOffset(154, 30),
		Parent = row,
	})
	stroke(box, theme, 1)

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
		title.TextColor3 = nextTheme.Text
		box.BackgroundColor3 = nextTheme.PanelAlt
		box.TextColor3 = nextTheme.Text
		box.PlaceholderColor3 = nextTheme.Muted
		updateStroke(box, nextTheme)
	end)

	return {
		Set = function(_, nextValue, silent)
			set(nextValue, silent)
		end,
		Get = function()
			return box.Text
		end,
		Flag = flag,
		Instance = row,
	}
end

function Tab:Keybind(options)
	options = options or {}
	local theme = self.Window.Theme
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = options.Default or Enum.KeyCode.RightShift
	local listening = false
	local row = self:_row(56)
	local title = rowTitle(row, options.Title or "Keybind", theme, 2, 136)
	local button = makeButton(row, value.Name, theme, 124)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -8, 0.5, 0)
	button.TextSize = 15

	local function set(nextValue, silent)
		if kindOf(nextValue) == "string" then
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

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		button.BackgroundColor3 = nextTheme.Panel
		button.BackgroundTransparency = nextTheme.RowTransparency
		button.TextColor3 = nextTheme.Text
		updateStroke(button, nextTheme)
	end)

	return {
		Set = function(_, nextValue, silent)
			set(nextValue, silent)
		end,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = row,
	}
end

function Tab:ColorPicker(options)
	options = options or {}
	local theme = self.Window.Theme
	local flag = normalizeFlag(options.Title, options.Flag)
	local colors = options.Colors or {
		Color3.fromRGB(255, 80, 80),
		Color3.fromRGB(255, 190, 70),
		Color3.fromRGB(82, 222, 133),
		Color3.fromRGB(21, 205, 244),
		Color3.fromRGB(142, 113, 255),
		Color3.fromRGB(255, 255, 255),
	}
	local value = options.Default or colors[1]
	local row = self:_row(70)
	local title = rowTitle(row, options.Title or "Color", theme, 2, 16)
	local holder = make("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(8, 36),
		Size = UDim2.new(1, -16, 0, 26),
		Parent = row,
	})
	grid(holder, UDim2.fromOffset(26, 22), 6)

	local swatches = {}

	local function set(nextValue, silent)
		if kindOf(nextValue) == "string" then
			nextValue = hexToColor(nextValue, value)
		end
		value = nextValue
		self.Window:_setFlag(flag, colorToHex(value))
		local selectedHex = colorToHex(value)
		for swatch, color in pairs(swatches) do
			local outline = swatch:FindFirstChildOfClass("UIStroke")
			if outline then
				outline.Thickness = colorToHex(color) == selectedHex and 3 or 1
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
		stroke(swatch, theme, 1)
		swatches[swatch] = color
		swatch.MouseButton1Click:Connect(function()
			set(color)
		end)
	end

	self.Window:_registerFlag(flag, set)
	set(value, true)

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		for swatch in pairs(swatches) do
			updateStroke(swatch, nextTheme)
		end
	end)

	return {
		Set = function(_, nextValue, silent)
			set(nextValue, silent)
		end,
		Get = function()
			return value
		end,
		Flag = flag,
		Instance = row,
	}
end

function Tab:ThemeDropdown(title)
	return self:Dropdown({
		Title = title or "Theme",
		Flag = "__theme",
		Options = self.Window:GetThemes(),
		Default = self.Window.ThemeName,
		Callback = function(themeName)
			self.Window:SetTheme(themeName)
		end,
	})
end

Window.AddTab = Window.CreateTab
Window.Tab = Window.CreateTab

Tab.AddSection = Tab.Section
Tab.AddLabel = Tab.Label
Tab.AddParagraph = Tab.Paragraph
Tab.AddImage = Tab.Image
Tab.AddBanner = Tab.Banner
Tab.AddQuest = Tab.Quest
Tab.AddProgress = Tab.Progress
Tab.AddButton = Tab.Button
Tab.AddToggle = Tab.Toggle
Tab.AddSlider = Tab.Slider
Tab.AddStepper = Tab.Stepper
Tab.AddDropdown = Tab.Dropdown
Tab.AddMultiDropdown = Tab.MultiDropdown
Tab.AddTextbox = Tab.Textbox
Tab.AddInput = Tab.Textbox
Tab.AddKeybind = Tab.Keybind
Tab.AddColorPicker = Tab.ColorPicker
Tab.AddDivider = Tab.Divider
Tab.AddSpace = Tab.Space
Tab.AddThemeDropdown = Tab.ThemeDropdown

function CursedPaint:Notify(options)
	local window = CursedPaint._lastWindow
	if window then
		return window:Notify(options)
	end
	return nil
end

local createWindow = CursedPaint.CreateWindow
function CursedPaint:CreateWindow(options)
	local window = createWindow(self, options)
	CursedPaint._lastWindow = window
	return window
end

function CursedPaint:New(options)
	return self:CreateWindow(options)
end

return CursedPaint

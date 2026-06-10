-- CursedPaint UI
-- Animated FingerPaint Roblox UI library with a translucent sketch-menu style.

local CursedPaint = {}
CursedPaint.__index = CursedPaint
CursedPaint.Version = "0.7.5"
CursedPaint.PlaceholderImage = "cursedpaint://placeholder"
CursedPaint._imageCache = {}
CursedPaint._downloadedFontAssets = {}
CursedPaint._fontFaceCache = {}
CursedPaint.Font = "FingerPaint"
CursedPaint.FontFace = nil
CursedPaint.FontAssetId = "rbxassetid://12187375716"
CursedPaint.FontFile = "FingerPaint-Regular.ttf"
CursedPaint.FontFileUrl = "https://raw.githubusercontent.com/SairyTheKing/cursedpaint-ui/main/FingerPaint-Regular.ttf"
CursedPaint._fontStatus = {
	Requested = "FingerPaint",
	Resolved = false,
	Method = "pending",
	Value = "FingerPaint",
}
CursedPaint.Motion = {
	Enabled = true,
	Speed = 1,
}

CursedPaint.Themes = {
	JJS = {
		Backdrop = Color3.fromRGB(132, 132, 126),
		Left = Color3.fromRGB(244, 241, 178),
		Panel = Color3.fromRGB(246, 245, 236),
		PanelAlt = Color3.fromRGB(221, 221, 210),
		Text = Color3.fromRGB(8, 8, 8),
		Muted = Color3.fromRGB(34, 34, 34),
		Ink = Color3.fromRGB(0, 0, 0),
		SelectedTop = Color3.fromRGB(255, 246, 124),
		SelectedBottom = Color3.fromRGB(210, 89, 52),
		Bar = Color3.fromRGB(92, 92, 88),
		BarFill = Color3.fromRGB(10, 204, 245),
		Good = Color3.fromRGB(68, 188, 100),
		Bad = Color3.fromRGB(220, 62, 66),
		PanelTransparency = 0.08,
		ContentTransparency = 0.18,
		RowTransparency = 0.08,
		TextureTransparency = 0.98,
		GlowTransparency = 1,
		Radius = 4,
		StrokeThickness = 3,
		ThinStrokeThickness = 2,
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
	return cloneTheme(CursedPaint.Themes[name] or CursedPaint.Themes.JJS)
end

local function themeNames()
	local names = {}
	for name in pairs(CursedPaint.Themes) do
		table.insert(names, name)
	end
	table.sort(names)
	return names
end

local function resolveEnumFont(value)
	if kindOf(value) == "EnumItem" then
		return value
	end

	if type(value) == "string" then
		local ok, font = pcall(function()
			return Enum.Font[value]
		end)

		if ok and font then
			return font
		end
	end

	return nil
end

local FONT_NAME_ALIASES = {
	fingerpaint = { "Finger Paint", "FingerPaint", "Fingerpaint" },
	patrickhand = { "Patrick Hand", "PatrickHand" },
	permanentmarker = { "Permanent Marker", "PermanentMarker" },
}

local FONT_ASSETS = {
	fingerpaint = {
		"rbxassetid://12187375716",
	},
}

local FONT_DOWNLOADS = {
	fingerpaint = {
		"https://raw.githubusercontent.com/SairyTheKing/cursedpaint-ui/main/FingerPaint-Regular.ttf",
	},
}

local FONT_FAMILY_PATHS = {
	fingerpaint = {
		"rbxasset://fonts/families/FingerPaint.json",
		"rbxasset://fonts/families/Fingerpaint.json",
		"rbxasset://fonts/families/fingerpaint.json",
	},
	patrickhand = {
		"rbxasset://fonts/families/PatrickHand.json",
		"rbxasset://fonts/families/Patrickhand.json",
	},
	permanentmarker = {
		"rbxasset://fonts/families/PermanentMarker.json",
		"rbxasset://fonts/families/Permanentmarker.json",
	},
}

local function fontLookupKey(value)
	return tostring(value or ""):gsub("[%s_%-]+", ""):lower()
end

local function jsonString(value)
	local text = tostring(value or "")
	text = text:gsub("\\", "\\\\")
	text = text:gsub('"', '\\"')
	text = text:gsub("\n", "\\n")
	text = text:gsub("\r", "\\r")
	return '"' .. text .. '"'
end

local function setFontStatus(requested, resolved, method, value)
	CursedPaint._fontStatus = {
		Requested = requested or CursedPaint.Font or "FingerPaint",
		Resolved = resolved == true,
		Method = method or "unknown",
		Value = value,
	}
end

local function addFontCandidate(candidates, seen, kind, value)
	if value == nil or value == "" then
		return
	end

	local id = kind .. ":" .. tostring(value)
	if seen[id] then
		return
	end

	seen[id] = true
	table.insert(candidates, {
		Kind = kind,
		Value = value,
	})
end

local function fontCandidates(value)
	local text = tostring(value or "")
	local candidates = {}
	local seen = {}

	if text == "" then
		return candidates
	end

	if text:match("^rbxasset://") or text:match("^rbxassetid://") then
		addFontCandidate(candidates, seen, "path", text)
		return candidates
	end

	if text:match("^%d+$") then
		addFontCandidate(candidates, seen, "path", "rbxassetid://" .. text)
		return candidates
	end

	local key = fontLookupKey(text)
	for _, asset in ipairs(FONT_ASSETS[key] or {}) do
		addFontCandidate(candidates, seen, "path", asset)
	end

	for _, url in ipairs(FONT_DOWNLOADS[key] or {}) do
		addFontCandidate(candidates, seen, "download", url)
	end

	local aliases = FONT_NAME_ALIASES[key] or { text }
	for _, name in ipairs(aliases) do
		addFontCandidate(candidates, seen, "name", name)
	end

	for _, path in ipairs(FONT_FAMILY_PATHS[key] or {}) do
		addFontCandidate(candidates, seen, "path", path)
	end

	addFontCandidate(candidates, seen, "name", text)
	return candidates
end

local function cacheFontFace(key, requested, method, value, face)
	CursedPaint._fontFaceCache[key] = face
	setFontStatus(requested, true, method, value)
	return face
end

local function fontFromName(name, requested)
	local key = "name:" .. tostring(name)
	if CursedPaint._fontFaceCache[key] then
		setFontStatus(requested, true, "Font.fromName cache", name)
		return CursedPaint._fontFaceCache[key]
	end

	local ok, face = pcall(function()
		if not Font or not Font.fromName then
			return nil
		end

		if Enum and Enum.FontWeight and Enum.FontStyle then
			return Font.fromName(name, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		end

		return Font.fromName(name)
	end)

	if ok and face then
		return cacheFontFace(key, requested, "Font.fromName", name, face)
	end

	return nil
end

local function fontAssetId(value)
	local text = tostring(value or "")
	return text:match("^rbxassetid://(%d+)$") or text:match("^(%d+)$")
end

local function fontFromId(id, requested)
	local numberId = tonumber(id)
	if not numberId then
		return nil
	end

	local key = "id:" .. tostring(numberId)
	if CursedPaint._fontFaceCache[key] then
		setFontStatus(requested, true, "Font.fromId cache", "rbxassetid://" .. tostring(numberId))
		return CursedPaint._fontFaceCache[key]
	end

	local ok, face = pcall(function()
		if not Font or not Font.fromId then
			return nil
		end

		if Enum and Enum.FontWeight and Enum.FontStyle then
			return Font.fromId(numberId, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		end

		return Font.fromId(numberId)
	end)

	if ok and face then
		return cacheFontFace(key, requested, "Font.fromId", "rbxassetid://" .. tostring(numberId), face)
	end

	return nil
end

local function fontFromPath(path, requested)
	local id = fontAssetId(path)
	if id then
		local face = fontFromId(id, requested)
		if face then
			return face
		end
	end

	local key = "path:" .. tostring(path)
	if CursedPaint._fontFaceCache[key] then
		setFontStatus(requested, true, "Font.new cache", path)
		return CursedPaint._fontFaceCache[key]
	end

	local ok, face = pcall(function()
		if not Font then
			return nil
		end

		if Enum and Enum.FontWeight and Enum.FontStyle then
			return Font.new(path, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		end

		return Font.new(path)
	end)

	if ok and face then
		return cacheFontFace(key, requested, "Font.new", path, face)
	end

	local okSimple, simpleFace = pcall(function()
		if not Font then
			return nil
		end

		return Font.new(path)
	end)

	if okSimple and simpleFace then
		return cacheFontFace(key, requested, "Font.new", path, simpleFace)
	end

	return nil
end

local function ensureFontAssetFolder()
	pcall(function()
		if makefolder and (not isfolder or not isfolder("CursedPaintUI")) then
			makefolder("CursedPaintUI")
		end
	end)

	pcall(function()
		if makefolder and (not isfolder or not isfolder("CursedPaintUI/fonts")) then
			makefolder("CursedPaintUI/fonts")
		end
	end)
end

local function downloadedFontAssets(url)
	local text = tostring(url or "")
	if text == "" then
		return nil
	end

	if CursedPaint._downloadedFontAssets[text] then
		return CursedPaint._downloadedFontAssets[text]
	end

	local ok, assets = pcall(function()
		if not writefile or not getcustomasset then
			return nil
		end

		ensureFontAssetFolder()

		local safeName = tostring(text:match("([^/%?#]+)[%?#]?$") or CursedPaint.FontFile or "font.ttf")
		safeName = safeName:gsub("[^%w%._%-]", "_")
		if not safeName:match("%.ttf$") and not safeName:match("%.otf$") then
			safeName = safeName .. ".ttf"
		end

		local fontPath = "CursedPaintUI/fonts/" .. safeName
		local shouldDownload = true
		pcall(function()
			if isfile and isfile(fontPath) then
				shouldDownload = false
			end
		end)

		if shouldDownload then
			local bytes = game:HttpGet(text)
			if not bytes or bytes == "" then
				return nil
			end
			writefile(fontPath, bytes)
		end

		local fontAsset = getcustomasset(fontPath)
		if not fontAsset then
			return nil
		end

		local familyName = safeName:gsub("%.%w+$", "")
		local familyPath = "CursedPaintUI/fonts/" .. familyName .. ".family.json"
		local familyJson = "{"
			.. '"name":' .. jsonString(familyName) .. ","
			.. '"faces":[{'
			.. '"name":"Regular",'
			.. '"weight":400,'
			.. '"style":"normal",'
			.. '"assetId":' .. jsonString(fontAsset)
			.. "}]"
			.. "}"
		writefile(familyPath, familyJson)

		local familyAsset = getcustomasset(familyPath)
		return {
			File = fontAsset,
			Family = familyAsset,
		}
	end)

	if ok and assets then
		CursedPaint._downloadedFontAssets[text] = assets
		return assets
	end

	return nil
end

local function fontFromDownloadedUrl(url, requested)
	local assets = downloadedFontAssets(url)
	if not assets then
		return nil
	end

	if assets.Family then
		local face = fontFromPath(assets.Family, requested)
		if face then
			setFontStatus(requested, true, "GitHub .ttf family", url)
			return face
		end
	end

	if assets.File then
		local face = fontFromPath(assets.File, requested)
		if face then
			setFontStatus(requested, true, "GitHub .ttf file", url)
			return face
		end
	end

	return nil
end

local function resolveFontFace(value)
	local kind = kindOf(value)
	if kind == "Font" then
		setFontStatus(value, true, "FontFace", value)
		return value
	end

	if kind == "EnumItem" then
		local key = "enum:" .. tostring(value)
		if CursedPaint._fontFaceCache[key] then
			setFontStatus(value, true, "Font.fromEnum cache", tostring(value))
			return CursedPaint._fontFaceCache[key]
		end

		local ok, face = pcall(function()
			if Font and Font.fromEnum then
				return Font.fromEnum(value)
			end
			return nil
		end)

		if ok and face then
			return cacheFontFace(key, value, "Font.fromEnum", tostring(value), face)
		end

		return nil
	end

	for _, candidate in ipairs(fontCandidates(value)) do
		local face = nil

		if candidate.Kind == "name" then
			face = fontFromName(candidate.Value, value)
		elseif candidate.Kind == "download" then
			face = fontFromDownloadedUrl(candidate.Value, value)
		elseif candidate.Kind == "path" then
			face = fontFromPath(candidate.Value, value)
		end

		if face then
			return face
		end
	end

	return nil
end

local function handFont()
	local configured = resolveEnumFont(CursedPaint.Font)
	if configured then
		return configured
	end

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
	local font = handFont()
	pcall(function()
		instance.Font = font
	end)

	local face = resolveFontFace(CursedPaint.FontFace)
		or resolveFontFace(CursedPaint.Font)
		or resolveFontFace("FingerPaint")
		or resolveFontFace(font)

	if face then
		local ok = pcall(function()
			instance.FontFace = face
		end)
		if ok then
			return
		end
	end

	local okEnumFace, enumFace = pcall(function()
		if Font and Font.fromEnum then
			return Font.fromEnum(font)
		end
		return nil
	end)

	if okEnumFace and enumFace then
		local applied = pcall(function()
			instance.FontFace = enumFace
		end)

		if applied then
			setFontStatus(CursedPaint.Font, true, "Font.fromEnum fallback", tostring(font))
			return
		end
	end

	setFontStatus(CursedPaint.Font, false, "Enum.Font fallback", tostring(font))
end

function CursedPaint:GetFontStatus()
	local status = CursedPaint._fontStatus or {}
	return {
		Requested = status.Requested or CursedPaint.Font or "FingerPaint",
		Resolved = status.Resolved == true,
		Method = status.Method or "unknown",
		Value = status.Value,
	}
end

function CursedPaint:GetFontHelp()
	return "CursedPaint tries rbxassetid://12187375716 first. If that asset is unavailable, it tries the GitHub TTF when writefile/getcustomasset exist. You can override it with Window:SetFont(\"rbxassetid://YOUR_FONT_ASSET_ID\")."
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

	if className == "TextLabel" or className == "TextButton" or className == "TextBox" then
		applyHandFont(instance)
	end

	if props and props.Parent then
		instance.Parent = props.Parent
	end

	return instance
end

local function stroke(parent, theme, thickness)
	local defaultThickness = theme.StrokeThickness or 2
	local thinThickness = theme.ThinStrokeThickness or math.max(defaultThickness - 1, 1)
	local resolved = thickness or defaultThickness
	if thickness and thickness <= 1 then
		resolved = thinThickness
	elseif thickness then
		resolved = math.max(thickness, defaultThickness)
	end

	return make("UIStroke", {
		Color = theme.Ink,
		Thickness = resolved,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = parent,
	})
end

local function cornerRadius(theme, radius)
	local resolved = radius
	if resolved == nil and theme then
		resolved = theme.Radius
	end
	if resolved == nil then
		resolved = 7
	end
	return UDim.new(0, resolved)
end

local function corner(parent, theme, radius)
	return make("UICorner", {
		CornerRadius = cornerRadius(theme, radius),
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
	if not instance then
		return nil
	end

	local speed = CursedPaint.Motion and tonumber(CursedPaint.Motion.Speed) or 1
	if speed <= 0 then
		speed = 1
	end

	local ok, created = pcall(function()
		local tweenService = service("TweenService")
		local info = TweenInfo.new((duration or 0.12) / speed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		return tweenService:Create(instance, info, goal)
	end)

	if ok and created then
		pcall(function()
			created:Play()
		end)
		return created
	end

	for key, value in pairs(goal or {}) do
		pcall(function()
			instance[key] = value
		end)
	end

	return nil
end

local function tweenStyle(instance, duration, goal, style, direction)
	if not instance then
		return nil
	end

	local speed = CursedPaint.Motion and tonumber(CursedPaint.Motion.Speed) or 1
	if speed <= 0 then
		speed = 1
	end

	local ok, created = pcall(function()
		local tweenService = service("TweenService")
		local info = TweenInfo.new(
			(duration or 0.12) / speed,
			style or Enum.EasingStyle.Quad,
			direction or Enum.EasingDirection.Out
		)
		return tweenService:Create(instance, info, goal)
	end)

	if ok and created then
		pcall(function()
			created:Play()
		end)
		return created
	end

	for key, value in pairs(goal or {}) do
		pcall(function()
			instance[key] = value
		end)
	end

	return nil
end

local function motionEnabled()
	return not CursedPaint.Motion or CursedPaint.Motion.Enabled ~= false
end

local function addScale(parent, scale)
	return make("UIScale", {
		Scale = scale or 1,
		Parent = parent,
	})
end

local function popScale(scaleObject, amount)
	if not motionEnabled() or not scaleObject then
		return
	end

	scaleObject.Scale = amount or 0.97
	tweenStyle(scaleObject, 0.18, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

local function setButtonRestTransparency(button, value)
	pcall(function()
		button:SetAttribute("CursedPaintRestTransparency", value)
	end)
end

local function getButtonRestTransparency(button, fallback)
	local ok, value = pcall(function()
		return button:GetAttribute("CursedPaintRestTransparency")
	end)

	return (ok and tonumber(value)) or fallback or 0
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
	pcall(function()
		label.LineHeight = 0.92
	end)
end

local function setSingleLineText(label, align)
	label.TextWrapped = false
	label.TextXAlignment = align or Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	pcall(function()
		label.TextTruncate = Enum.TextTruncate.AtEnd
	end)
	pcall(function()
		label.LineHeight = 0.92
	end)
end

local function updateStroke(parent, theme)
	local outline = parent:FindFirstChildOfClass("UIStroke")
	if outline then
		outline.Color = theme.Ink
	end
end

local function updateCorner(parent, theme, radius)
	local rounded = parent:FindFirstChildOfClass("UICorner")
	if rounded then
		rounded.CornerRadius = cornerRadius(theme, radius)
	end
end

local PLACEHOLDER_PNG =
	"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+/p9sAAAAASUVORK5CYII="

local function base64Decode(data)
	local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	data = tostring(data or ""):gsub("[^" .. alphabet .. "=]", "")

	return (data:gsub(".", function(char)
		if char == "=" then
			return ""
		end

		local bits = ""
		local value = alphabet:find(char, 1, true) - 1
		for index = 6, 1, -1 do
			bits = bits .. (value % (2 ^ index) - value % (2 ^ (index - 1)) > 0 and "1" or "0")
		end
		return bits
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(bits)
		if #bits ~= 8 then
			return ""
		end

		local byte = 0
		for index = 1, 8 do
			if bits:sub(index, index) == "1" then
				byte = byte + 2 ^ (8 - index)
			end
		end

		return string.char(byte)
	end))
end

local function ensureAssetFolder()
	pcall(function()
		if makefolder and (not isfolder or not isfolder("CursedPaintUI")) then
			makefolder("CursedPaintUI")
		end
	end)

	pcall(function()
		if makefolder and (not isfolder or not isfolder("CursedPaintUI/assets")) then
			makefolder("CursedPaintUI/assets")
		end
	end)
end

local function customAssetFromBytes(fileName, bytes)
	local ok, asset = pcall(function()
		if not writefile or not getcustomasset then
			return nil
		end

		ensureAssetFolder()
		local safeName = tostring(fileName or "image.png"):gsub("[^%w%._%-]", "_")
		local path = "CursedPaintUI/assets/" .. safeName
		writefile(path, bytes)
		return getcustomasset(path)
	end)

	if ok then
		return asset
	end

	return nil
end

local function placeholderImage()
	if CursedPaint._imageCache.placeholder then
		return CursedPaint._imageCache.placeholder
	end

	local asset = customAssetFromBytes("placeholder.png", base64Decode(PLACEHOLDER_PNG))
		or "rbxasset://textures/ui/GuiImagePlaceholder.png"

	CursedPaint._imageCache.placeholder = asset
	return asset
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

	if text == CursedPaint.PlaceholderImage or text:lower() == "placeholder" then
		return placeholderImage()
	end

	if text:match("^https?://") then
		return CursedPaint:DownloadImage(text)
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
	setSingleLineText(button, Enum.TextXAlignment.Center)
	corner(button, theme)
	stroke(button, theme, 2)
	setButtonRestTransparency(button, theme.RowTransparency)
	local scale = addScale(button, 1)

	button.MouseEnter:Connect(function()
		tween(button, 0.1, { BackgroundTransparency = 0.02 })
		if motionEnabled() then
			tweenStyle(scale, 0.1, { Scale = 1.018 }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		end
	end)

	button.MouseLeave:Connect(function()
		tween(button, 0.1, { BackgroundTransparency = getButtonRestTransparency(button, theme.RowTransparency) })
		if motionEnabled() then
			tween(scale, 0.1, { Scale = 1 })
		end
	end)

	button.MouseButton1Down:Connect(function()
		if motionEnabled() then
			tween(scale, 0.06, { Scale = 0.975 })
		end
	end)

	button.MouseButton1Up:Connect(function()
		if motionEnabled() then
			tweenStyle(scale, 0.1, { Scale = 1 }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		end
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
	corner(track, theme, 5)
	stroke(track, theme, 1)

	local fill = make("Frame", {
		BackgroundColor3 = theme.BarFill,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(0, 1),
		Parent = track,
	})
	corner(fill, theme, 5)

	return track, fill
end

local function setProgressFill(fill, alpha, animated)
	local size = UDim2.fromScale(math.clamp(alpha or 0, 0, 1), 1)
	if animated ~= false and motionEnabled() then
		tweenStyle(fill, 0.18, { Size = size }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	else
		fill.Size = size
	end
end

local function rowTitle(parent, title, theme, y, rightWidth)
	local label = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(title or "Control"),
		TextColor3 = theme.Text,
		Position = UDim2.fromOffset(8, y or 3),
		Size = UDim2.new(1, -(rightWidth or 120), 0, 30),
		Parent = parent,
	})
	setHandText(label, 20)
	setSingleLineText(label)
	return label
end

function CursedPaint:CreateWindow(options)
	options = options or {}

	if options.Font then
		CursedPaint.Font = resolveEnumFont(options.Font) or options.Font
	end
	if options.FontFace then
		CursedPaint.FontFace = options.FontFace
	end

	local themeName = "JJS"
	local theme = getTheme(themeName)
	local parent = options.Parent or resolveParent()
	assert(parent, "CursedPaint UI could not find a UI parent.")
	local sidebarWidth = tonumber(options.SidebarWidth) or 190
	local contentTop = tonumber(options.ContentTop) or 48
	local contentBottomInset = tonumber(options.ContentBottomInset) or 44

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
		ClipsDescendants = true,
		Position = options.Position or UDim2.fromScale(0.5, 0.5),
		Size = options.Size or UDim2.fromOffset(840, 500),
		ZIndex = 1,
		Parent = gui,
	})
	local rootScale = addScale(root, 1)
	corner(root, theme)
	stroke(root, theme, 2)

	local accentGlow = make("Frame", {
		BackgroundColor3 = theme.BarFill,
		BackgroundTransparency = theme.GlowTransparency or 0.82,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(8, 8),
		Size = UDim2.new(1, -16, 1, -16),
		ZIndex = 1,
		Parent = root,
	})
	corner(accentGlow, theme, math.max((theme.Radius or 7) - 2, 2))
	local accentGlowGradient = make("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, theme.BarFill),
			ColorSequenceKeypoint.new(1, theme.SelectedBottom),
		}),
		Rotation = 35,
		Parent = accentGlow,
	})

	local texture = make("Frame", {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = theme.TextureTransparency or 0.86,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(4, 4),
		Size = UDim2.new(1, -8, 1, -8),
		ZIndex = 1,
		Parent = root,
	})
	corner(texture, theme, math.max((theme.Radius or 7) - 3, 2))
	stroke(texture, theme, 1)

	local backgroundImage = imageLabel(root, options.BackgroundImage, {
		ImageTransparency = options.BackgroundImageTransparency or 0.72,
		Position = UDim2.fromOffset(4, 4),
		ScaleType = Enum.ScaleType.Crop,
		Size = UDim2.new(1, -8, 1, -8),
		ZIndex = 2,
	})
	if backgroundImage then
		corner(backgroundImage, theme, math.max((theme.Radius or 7) - 3, 2))
	end

	local left = make("Frame", {
		BackgroundColor3 = theme.Left,
		BackgroundTransparency = 0.12,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(10, 10),
		Size = UDim2.new(0, sidebarWidth, 1, -20),
		ZIndex = 3,
		Parent = root,
	})
	corner(left, theme, math.max((theme.Radius or 7) - 2, 2))
	stroke(left, theme, 1)

	local titleLabel
	local tabsTop = 6
	if options.Title or options.Subtitle then
		titleLabel = make("TextLabel", {
			BackgroundTransparency = 1,
			Text = tostring(options.Title or "CursedPaint"),
			TextColor3 = theme.Text,
			Position = UDim2.fromOffset(9, 5),
			Size = UDim2.new(1, -18, 0, 34),
			ZIndex = 5,
			Parent = left,
		})
		setHandText(titleLabel, 24, Enum.TextXAlignment.Center)
		setSingleLineText(titleLabel, Enum.TextXAlignment.Center)
		tabsTop = 48
	end

	local tabs = make("ScrollingFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.fromOffset(0, 0),
		Position = UDim2.fromOffset(6, tabsTop),
		ScrollBarImageColor3 = theme.Ink,
		ScrollBarThickness = 3,
		Size = UDim2.new(1, -12, 1, -(tabsTop + 34)),
		ZIndex = 4,
		Parent = left,
	})
	local tabsLayout = list(tabs, 2)
	autoCanvas(tabs, tabsLayout)

	local content = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BackgroundTransparency = theme.ContentTransparency or 0.18,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.fromOffset(sidebarWidth + 22, contentTop),
		Size = UDim2.new(1, -(sidebarWidth + 32), 1, -(contentTop + contentBottomInset)),
		ZIndex = 3,
		Parent = root,
	})
	corner(content, theme, math.max((theme.Radius or 4) - 1, 2))
	stroke(content, theme, 2)

	local sideImage = imageLabel(content, options.SideImage or options.PortraitImage, {
		AnchorPoint = Vector2.new(1, 0),
		ImageTransparency = options.SideImageTransparency or options.PortraitTransparency or 0.62,
		Position = UDim2.new(1, -4, 0, 0),
		ScaleType = Enum.ScaleType.Crop,
		Size = UDim2.new(0, options.SideImageWidth or 190, 1, 0),
		ZIndex = 4,
	})
	if sideImage then
		corner(sideImage, theme, math.max((theme.Radius or 7) - 2, 2))
	end

	local bottomStrip = make("Frame", {
		BackgroundColor3 = theme.BarFill,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, sidebarWidth + 22, 1, -26),
		Size = UDim2.new(1, -(sidebarWidth + 70), 0, 10),
		ZIndex = 4,
		Parent = root,
	})
	corner(bottomStrip, theme, 3)
	stroke(bottomStrip, theme, 1)
	local bottomGradient = make("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, theme.BarFill),
			ColorSequenceKeypoint.new(0.55, theme.SelectedTop),
			ColorSequenceKeypoint.new(1, theme.BarFill),
		}),
		Rotation = 0,
		Parent = bottomStrip,
	})

	local topStrip = make("Frame", {
		BackgroundColor3 = theme.BarFill,
		BackgroundTransparency = 0.12,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(14, 12),
		Size = UDim2.new(1, -28, 0, 4),
		ZIndex = 5,
		Parent = root,
	})
	corner(topStrip, theme, 3)

	local close = makeButton(root, "X", theme, 28)
	close.Position = UDim2.new(1, -38, 0, 16)
	close.ZIndex = 20

	local minimize = makeButton(root, "-", theme, 28)
	minimize.Position = UDim2.new(1, -72, 0, 16)
	minimize.ZIndex = 20

	local resizeGrip
	if options.Resizable ~= false then
		resizeGrip = makeButton(root, "///", theme, 42)
		resizeGrip.AnchorPoint = Vector2.new(1, 1)
		resizeGrip.Position = UDim2.new(1, -9, 1, -9)
		resizeGrip.Size = UDim2.fromOffset(42, 24)
		resizeGrip.TextSize = 13
		resizeGrip.ZIndex = 20
	end

	local toastHolder = make("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -330, 0, 16),
		Size = UDim2.fromOffset(310, 330),
		ZIndex = 50,
		Parent = gui,
	})
	local toastLayout = list(toastHolder, 8)
	toastLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	local minSize = options.MinSize or Vector2.new(640, 390)
	if kindOf(minSize) == "UDim2" then
		minSize = Vector2.new(minSize.X.Offset, minSize.Y.Offset)
	end

	local self = setmetatable({
		ScreenGui = gui,
		Root = root,
		RootScale = rootScale,
		AccentGlow = accentGlow,
		AccentGlowGradient = accentGlowGradient,
		Texture = texture,
		BackgroundImage = backgroundImage,
		Left = left,
		TitleLabel = titleLabel,
		TabsBar = tabs,
		Content = content,
		SideImage = sideImage,
		BottomStrip = bottomStrip,
		BottomGradient = bottomGradient,
		TopStrip = topStrip,
		ResizeGrip = resizeGrip,
		ToastHolder = toastHolder,
		ThemeName = themeName,
		Theme = theme,
		Flags = {},
		_flagSetters = {},
		_themeBindings = {},
		_connections = {},
		_tabs = {},
		_tabButtons = {},
		_activeTab = nil,
		_visible = true,
		_minimized = false,
		_normalSize = root.Size,
		_minSize = minSize,
		_configFolder = options.ConfigFolder or "CursedPaintUI",
	}, Window)

	self:_bindTheme(function(nextTheme)
		root.BackgroundColor3 = nextTheme.Backdrop
		root.BackgroundTransparency = nextTheme.PanelTransparency
		accentGlow.BackgroundColor3 = nextTheme.BarFill
		accentGlow.BackgroundTransparency = nextTheme.GlowTransparency or 0.82
		accentGlowGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, nextTheme.BarFill),
			ColorSequenceKeypoint.new(1, nextTheme.SelectedBottom),
		})
		texture.BackgroundTransparency = nextTheme.TextureTransparency or 0.86
		if backgroundImage then
			backgroundImage.ImageTransparency = options.BackgroundImageTransparency or 0.72
			updateCorner(backgroundImage, nextTheme, math.max((nextTheme.Radius or 7) - 3, 2))
		end
		left.BackgroundColor3 = nextTheme.Left
		if titleLabel then
			titleLabel.TextColor3 = nextTheme.Text
		end
		content.BackgroundColor3 = nextTheme.Panel
		content.BackgroundTransparency = nextTheme.ContentTransparency or 0.18
		if sideImage then
			updateCorner(sideImage, nextTheme, math.max((nextTheme.Radius or 7) - 2, 2))
		end
		tabs.ScrollBarImageColor3 = nextTheme.Ink
		bottomStrip.BackgroundColor3 = nextTheme.BarFill
		topStrip.BackgroundColor3 = nextTheme.BarFill
		bottomGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, nextTheme.BarFill),
			ColorSequenceKeypoint.new(0.55, nextTheme.SelectedTop),
			ColorSequenceKeypoint.new(1, nextTheme.BarFill),
		})
		close.BackgroundColor3 = nextTheme.Panel
		close.BackgroundTransparency = nextTheme.RowTransparency
		setButtonRestTransparency(close, nextTheme.RowTransparency)
		close.TextColor3 = nextTheme.Text
		minimize.BackgroundColor3 = nextTheme.Panel
		minimize.BackgroundTransparency = nextTheme.RowTransparency
		setButtonRestTransparency(minimize, nextTheme.RowTransparency)
		minimize.TextColor3 = nextTheme.Text
		if resizeGrip then
			resizeGrip.BackgroundColor3 = nextTheme.Panel
			resizeGrip.BackgroundTransparency = nextTheme.RowTransparency
			setButtonRestTransparency(resizeGrip, nextTheme.RowTransparency)
			resizeGrip.TextColor3 = nextTheme.Text
			updateStroke(resizeGrip, nextTheme)
			updateCorner(resizeGrip, nextTheme)
		end
		updateStroke(root, nextTheme)
		updateCorner(accentGlow, nextTheme, math.max((nextTheme.Radius or 7) - 2, 2))
		updateStroke(texture, nextTheme)
		updateStroke(left, nextTheme)
		updateStroke(content, nextTheme)
		updateStroke(bottomStrip, nextTheme)
		updateStroke(close, nextTheme)
		updateStroke(minimize, nextTheme)
		updateCorner(root, nextTheme)
		updateCorner(texture, nextTheme, math.max((nextTheme.Radius or 7) - 3, 2))
		updateCorner(left, nextTheme, math.max((nextTheme.Radius or 7) - 2, 2))
		updateCorner(content, nextTheme, math.max((nextTheme.Radius or 4) - 1, 2))
		updateCorner(bottomStrip, nextTheme, 3)
		updateCorner(topStrip, nextTheme, 3)
		updateCorner(close, nextTheme)
		updateCorner(minimize, nextTheme)
	end)

	close.MouseButton1Click:Connect(function()
		self:Destroy()
	end)

	minimize.MouseButton1Click:Connect(function()
		self:SetMinimized(not self._minimized)
	end)

	self:_makeDraggable(root, root)
	if resizeGrip then
		self:_makeResizable(resizeGrip, root, self._minSize)
	end

	if options.Animated ~= false and motionEnabled() then
		rootScale.Scale = 0.92
		root.Rotation = -1
		root.BackgroundTransparency = 1
		task.defer(function()
			if root.Parent then
				tweenStyle(rootScale, 0.34, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				tweenStyle(root, 0.24, {
					BackgroundTransparency = self.Theme.PanelTransparency,
					Rotation = 0,
				}, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			end
		end)
	end

	local userInput = service("UserInputService")
	if options.ToggleKey then
		self:_track(userInput.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == options.ToggleKey then
				self:SetVisible(not self._visible)
			end
		end))
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
	if self._destroyed then
		return false
	end

	self.ThemeName = "JJS"
	self.Theme = getTheme("JJS")
	self.Flags.__theme = "JJS"
	self:_applyTheme()
	return name == nil or name == "JJS"
end

function Window:_track(connection)
	if connection then
		table.insert(self._connections, connection)
	end
	return connection
end

function Window:_disconnectAll()
	for _, connection in ipairs(self._connections or {}) do
		pcall(function()
			connection:Disconnect()
		end)
	end
	self._connections = {}
end

function CursedPaint:SetFont(font, fontFace)
	local requested = fontFace or font or "FingerPaint"
	setFontStatus(requested, false, "pending", requested)
	CursedPaint.Font = resolveEnumFont(font) or font or "FingerPaint"
	CursedPaint.FontFace = resolveFontFace(fontFace) or fontFace
	return CursedPaint.Font
end

function CursedPaint:SetMotion(enabled, speed)
	if type(enabled) == "table" then
		CursedPaint.Motion.Enabled = enabled.Enabled ~= false
		CursedPaint.Motion.Speed = tonumber(enabled.Speed) or CursedPaint.Motion.Speed or 1
	else
		CursedPaint.Motion.Enabled = enabled ~= false
		CursedPaint.Motion.Speed = tonumber(speed) or CursedPaint.Motion.Speed or 1
	end

	return CursedPaint.Motion
end

function Window:SetFont(font, fontFace)
	CursedPaint:SetFont(font, fontFace)

	for _, descendant in ipairs(self.ScreenGui:GetDescendants()) do
		if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
			applyHandFont(descendant)
		end
	end

	return true
end

function Window:SetMotion(enabled, speed)
	return CursedPaint:SetMotion(enabled, speed)
end

function CursedPaint:GetPlaceholderImage()
	return placeholderImage()
end

function CursedPaint:DownloadImage(url, fileName)
	local text = tostring(url or "")
	if not text:match("^https?://") then
		return normalizeImage(url)
	end

	if CursedPaint._imageCache[text] then
		return CursedPaint._imageCache[text]
	end

	local ok, asset = pcall(function()
		if not writefile or not getcustomasset then
			return nil
		end

		ensureAssetFolder()
		local data = game:HttpGet(text)
		if not data or data == "" then
			return nil
		end

		local safeName = tostring(fileName or text:match("([^/%?#]+)[%?#]?$") or "download.png")
		safeName = safeName:gsub("[^%w%._%-]", "_")
		if not safeName:match("%.%w+$") then
			safeName = safeName .. ".png"
		end

		local path = "CursedPaintUI/assets/" .. safeName
		writefile(path, data)
		return getcustomasset(path)
	end)

	if ok and asset then
		CursedPaint._imageCache[text] = asset
		return asset
	end

	return nil
end

function Window:SetBackgroundImage(image, transparency)
	if self._destroyed then
		return nil
	end

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
		if self.BackgroundImage then
			corner(self.BackgroundImage, self.Theme, math.max((self.Theme.Radius or 7) - 3, 2))
		end
	else
		self.BackgroundImage.Image = normalized
		self.BackgroundImage.ImageTransparency = transparency or self.BackgroundImage.ImageTransparency
	end

	return self.BackgroundImage
end

function Window:SetSideImage(image, transparency)
	if self._destroyed then
		return nil
	end

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
			ZIndex = 1,
		})
		if self.SideImage then
			corner(self.SideImage, self.Theme, math.max((self.Theme.Radius or 7) - 2, 2))
		end
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
	if self._destroyed then
		return
	end

	self._visible = visible == true
	if self._visible then
		self.Root.Visible = true
		if self.RootScale and motionEnabled() then
			self.RootScale.Scale = 0.96
			self.Root.BackgroundTransparency = math.min((self.Theme.PanelTransparency or 0) + 0.25, 1)
			tweenStyle(self.RootScale, 0.2, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			tween(self.Root, 0.16, { BackgroundTransparency = self.Theme.PanelTransparency })
		end
	else
		if self.RootScale and motionEnabled() then
			tween(self.RootScale, 0.11, { Scale = 0.96 })
			tween(self.Root, 0.1, { BackgroundTransparency = math.min((self.Theme.PanelTransparency or 0) + 0.25, 1) })
			task.delay(0.12, function()
				if not self._visible and self.Root then
					self.Root.Visible = false
				end
			end)
		else
			self.Root.Visible = false
		end
	end
end

function Window:SetMinimized(minimized)
	if self._destroyed then
		return
	end

	self._minimized = minimized == true
	if self._minimized then
		self.Left.Visible = false
		self.Content.Visible = false
		if self.ResizeGrip then
			self.ResizeGrip.Visible = false
		end
		tween(self.Root, 0.14, { Size = UDim2.fromOffset(140, 42) })
	else
		self.Left.Visible = true
		self.Content.Visible = true
		if self.ResizeGrip then
			self.ResizeGrip.Visible = true
		end
		tween(self.Root, 0.14, { Size = self._normalSize })
	end
end

function Window:Destroy()
	if self._destroyed then
		return
	end
	self._destroyed = true
	self:_disconnectAll()
	if self.ScreenGui then
		self.ScreenGui:Destroy()
	end
end

function Window:_makeDraggable(handle, target)
	local userInput = service("UserInputService")
	local dragging = false
	local dragStart
	local startPos

	self:_track(handle.InputBegan:Connect(function(input)
		if self._destroyed or self._resizing then
			return
		end
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
	end))

	self:_track(userInput.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			target.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end))
end

function Window:_makeResizable(handle, target, minSize)
	local userInput = service("UserInputService")
	local resizing = false
	local resizeStart
	local startSize
	minSize = minSize or Vector2.new(480, 300)

	self:_track(handle.InputBegan:Connect(function(input)
		if self._destroyed then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			self._resizing = true
			resizeStart = input.Position
			startSize = target.Size
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
					self._resizing = false
				end
			end)
		end
	end))

	self:_track(userInput.InputChanged:Connect(function(input)
		if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - resizeStart
			local startWidth = startSize.X.Offset ~= 0 and startSize.X.Offset or target.AbsoluteSize.X
			local startHeight = startSize.Y.Offset ~= 0 and startSize.Y.Offset or target.AbsoluteSize.Y
			local nextWidth = math.max(minSize.X, startWidth + delta.X)
			local nextHeight = math.max(minSize.Y, startHeight + delta.Y)
			local nextSize = UDim2.fromOffset(nextWidth, nextHeight)
			target.Size = nextSize
			self._normalSize = nextSize
		end
	end))
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
		ZIndex = 5,
		Parent = self.Content,
	})
	local pageScale = addScale(page, 1)
	padding(page, 10, 10, 10, 10)
	local pageLayout = list(page, 6)
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
		Size = UDim2.new(1, 0, 0, 34),
		Parent = self.TabsBar,
	})
	applyHandFont(button)
	setSingleLineText(button, Enum.TextXAlignment.Center)
	corner(button, theme, 6)
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
		PageScale = pageScale,
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
		updateCorner(button, nextTheme, 6)
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
	local previous = self._activeTab
	for _, other in ipairs(self._tabs) do
		local selected = other == tab
		other.Gradient.Enabled = selected

		if selected then
			other.Page.Visible = true
			if motionEnabled() and other.PageScale and previous ~= tab then
				other.PageScale.Scale = 0.985
				tweenStyle(other.PageScale, 0.18, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			end
			tween(other.Button, 0.12, { BackgroundTransparency = 0 })
		else
			other.Page.Visible = false
			tween(other.Button, 0.1, { BackgroundTransparency = 1 })
		end
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
	if self._destroyed then
		return nil
	end

	options = options or {}
	local theme = self.Theme
	local toast = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BackgroundTransparency = theme.RowTransparency,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(310, 76),
		ZIndex = 51,
		Parent = self.ToastHolder,
	})
	corner(toast, theme)
	stroke(toast, theme, 2)
	padding(toast, 9, 5, 9, 5)
	local toastScale = addScale(toast, motionEnabled() and 0.94 or 1)
	local accent = make("Frame", {
		BackgroundColor3 = theme.BarFill,
		BackgroundTransparency = 0.08,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 8, 1, -7),
		Size = UDim2.new(1, -16, 0, 4),
		ZIndex = 52,
		Parent = toast,
	})
	corner(accent, theme, 3)

	local title = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = options.Title or "Notice",
		TextColor3 = theme.Text,
		Size = UDim2.new(1, 0, 0, 25),
		ZIndex = 52,
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
		ZIndex = 52,
		Parent = toast,
	})

	if motionEnabled() then
		local targetTransparency = toast.BackgroundTransparency
		toast.BackgroundTransparency = 1
		task.defer(function()
			if toast.Parent then
				tweenStyle(toastScale, 0.2, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				tween(toast, 0.14, { BackgroundTransparency = targetTransparency })
			end
		end)
	end

	task.delay(options.Duration or 3, function()
		if toast.Parent then
			if motionEnabled() then
				tween(toastScale, 0.1, { Scale = 0.94 })
			end
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
		if makefolder and (not isfolder or not isfolder(self._configFolder)) then
			makefolder(self._configFolder)
		end
	end)

	pcall(function()
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
		ZIndex = 6,
		Parent = self.Page,
	})
	corner(row, theme)
	stroke(row, theme, 2)
	local rowScale = addScale(row, 1)

	self.Window:_bindTheme(function(nextTheme)
		row.BackgroundColor3 = nextTheme.Panel
		row.BackgroundTransparency = nextTheme.RowTransparency
		updateStroke(row, nextTheme)
		updateCorner(row, nextTheme)
	end)

	if motionEnabled() then
		rowScale.Scale = 0.985
		row.BackgroundTransparency = 1
		task.defer(function()
			if row.Parent then
				tweenStyle(rowScale, 0.18, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				tween(row, 0.16, { BackgroundTransparency = self.Window.Theme.RowTransparency })
			end
		end)
	end

	return row
end

function Tab:Section(title)
	local theme = self.Window.Theme
	local label = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(title or "Section"),
		TextColor3 = theme.Text,
		Size = UDim2.new(1, 0, 0, 30),
		Parent = self.Page,
	})
	setHandText(label, 20)
	setSingleLineText(label)

	self.Window:_bindTheme(function(nextTheme)
		label.TextColor3 = nextTheme.Text
	end)

	return label
end

function Tab:Label(text)
	local theme = self.Window.Theme
	local row = self:_row(38)
	local label = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(text or "Label"),
		TextColor3 = theme.Text,
		Position = UDim2.fromOffset(8, 0),
		Size = UDim2.new(1, -16, 1, 0),
		Parent = row,
	})
	setHandText(label, 17)
	setSingleLineText(label)

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
		Size = UDim2.new(1, 0, 0, text and 22 or 12),
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
			TextColor3 = theme.Muted,
			Position = UDim2.fromOffset(10, 0),
			Size = UDim2.fromOffset(160, 22),
			Parent = row,
		})
		setHandText(label, 15)
		setSingleLineText(label, Enum.TextXAlignment.Center)
	end

	self.Window:_bindTheme(function(nextTheme)
		line.BackgroundColor3 = nextTheme.Ink
		if label then
			label.BackgroundColor3 = nextTheme.Panel
			label.TextColor3 = nextTheme.Muted
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
	local row = self:_row(options.Height or 86)
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
		Position = UDim2.fromOffset(9, 32),
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
	local height = options.Height or 118
	local row = self:_row(height)

	local image = imageLabel(row, options.Image or CursedPaint.PlaceholderImage, {
		ImageColor3 = options.ImageColor3 or Color3.fromRGB(255, 255, 255),
		ImageTransparency = options.ImageTransparency or 0,
		Position = UDim2.fromOffset(0, 0),
		ScaleType = options.ScaleType or Enum.ScaleType.Crop,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,
	})
	if image then
		corner(image, theme)
	end

	local shade = make("Frame", {
		BackgroundColor3 = theme.Panel,
		BackgroundTransparency = 0.28,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -38),
		Size = UDim2.new(1, 0, 0, 38),
		ZIndex = 3,
		Parent = row,
	})

	local title
	if options.Title then
		title = make("TextLabel", {
			BackgroundTransparency = 1,
			Text = tostring(options.Title),
			TextColor3 = theme.Text,
			Position = UDim2.fromOffset(8, height - 37),
			Size = UDim2.new(1, -16, 0, 22),
			ZIndex = 4,
			Parent = row,
		})
		setHandText(title, 20)
		setSingleLineText(title)
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
			Position = UDim2.fromOffset(10, height - 17),
			Size = UDim2.new(1, -20, 0, 14),
			ZIndex = 4,
			Parent = row,
		})
		setSingleLineText(caption)
	end

	self.Window:_bindTheme(function(nextTheme)
		shade.BackgroundColor3 = nextTheme.Panel
		if image then
			updateCorner(image, nextTheme)
		end
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
				image.Image = normalizeImage(nextImage) or placeholderImage()
			end
		end,
		Instance = row,
		Image = image,
	}
end

function Tab:Banner(options)
	options = options or {}
	options.Height = options.Height or 76
	return self:Image(options)
end

function Tab:Quest(options)
	options = options or {}
	local theme = self.Window.Theme
	local maxValue = tonumber(options.Max) or 1
	local value = clampNumber(options.Value or 0, 0, maxValue)
	local height = options.Height or 82
	local row = self:_row(height)
	local art = imageLabel(row, options.Image or options.Portrait, {
		AnchorPoint = Vector2.new(1, 0),
		ImageTransparency = options.ImageTransparency or 0.55,
		Position = UDim2.new(1, -2, 0, 2),
		ScaleType = Enum.ScaleType.Crop,
		Size = UDim2.fromOffset(options.ImageWidth or 150, height - 4),
		ZIndex = 2,
	})
	if art then
		corner(art, theme, math.max((theme.Radius or 7) - 2, 2))
	end
	local title = rowTitle(row, options.Title or "Quest", theme, 2, art and 168 or 16)
	title.ZIndex = 4
	local counter = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(value) .. "/" .. tostring(maxValue),
		TextColor3 = theme.Text,
		Position = UDim2.fromOffset(8, 34),
		Size = UDim2.new(1, art and -176 or -16, 0, 24),
		ZIndex = 4,
		Parent = row,
	})
	setHandText(counter, 22)
	setSingleLineText(counter)
	local track, fill = createProgressBar(row, theme, height - 22)
	track.ZIndex = 5
	fill.ZIndex = 6

	local function set(nextValue, nextMax)
		if nextMax then
			maxValue = math.max(tonumber(nextMax) or maxValue, 1)
		end
		value = clampNumber(nextValue, 0, maxValue)
		counter.Text = tostring(value) .. "/" .. tostring(maxValue)
		setProgressFill(fill, value / math.max(maxValue, 1))
	end

	set(value, maxValue)

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		counter.TextColor3 = nextTheme.Text
		track.BackgroundColor3 = nextTheme.Bar
		fill.BackgroundColor3 = nextTheme.BarFill
		if art then
			art.ImageTransparency = options.ImageTransparency or 0.55
			updateCorner(art, nextTheme, math.max((nextTheme.Radius or 7) - 2, 2))
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
	local row = self:_row(options.Height or 58)
	local title = rowTitle(row, options.Title or "Progress", theme, 3, 16)
	local track, fill = createProgressBar(row, theme, 39)

	local function set(nextValue, nextMax)
		if nextMax then
			maxValue = math.max(tonumber(nextMax) or maxValue, 1)
		end
		value = clampNumber(nextValue, 0, maxValue)
		title.Text = tostring(options.Title or "Progress") .. ": " .. tostring(math.floor((value / maxValue) * 100 + 0.5)) .. "%"
		setProgressFill(fill, value / math.max(maxValue, 1))
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
	local row = self:_row(60)
	local title = rowTitle(row, options.Title or "Button", theme, 3, 128)
	local icon = imageLabel(row, options.Icon, {
		ImageTransparency = options.IconTransparency or 0,
		Position = UDim2.fromOffset(8, 13),
		ScaleType = Enum.ScaleType.Fit,
		Size = UDim2.fromOffset(34, 34),
		ZIndex = 4,
	})
	if icon then
		title.Position = UDim2.fromOffset(48, 3)
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
			Position = UDim2.fromOffset(icon and 49 or 9, 35),
			Size = UDim2.new(1, icon and -180 or -140, 0, 18),
			Parent = row,
		})
		setSingleLineText(desc)
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
		setButtonRestTransparency(button, nextTheme.RowTransparency)
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
	local row = self:_row(60)
	local title = rowTitle(row, options.Title or "Toggle", theme, 3, 128)
	local icon = imageLabel(row, options.Icon, {
		ImageTransparency = options.IconTransparency or 0,
		Position = UDim2.fromOffset(8, 13),
		ScaleType = Enum.ScaleType.Fit,
		Size = UDim2.fromOffset(34, 34),
		ZIndex = 4,
	})
	if icon then
		title.Position = UDim2.fromOffset(48, 3)
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
			Position = UDim2.fromOffset(icon and 49 or 9, 35),
			Size = UDim2.new(1, icon and -180 or -140, 0, 18),
			Parent = row,
		})
		setSingleLineText(desc)
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
		setButtonRestTransparency(button, 0.05)
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
		button.BackgroundTransparency = 0.05
		setButtonRestTransparency(button, 0.05)
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
	if maxValue < minValue then
		minValue, maxValue = maxValue, minValue
	end
	local step = tonumber(options.Step) or 1
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = roundToStep(clampNumber(options.Default or minValue, minValue, maxValue), step)
	local row = self:_row(74)
	local title = rowTitle(row, options.Title or "Slider", theme, 3, 92)
	local valueLabel = make("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(value),
		TextColor3 = theme.Text,
		Font = handFont(),
		TextSize = 19,
		TextXAlignment = Enum.TextXAlignment.Right,
		Position = UDim2.new(1, -88, 0, 5),
		Size = UDim2.fromOffset(80, 24),
		Parent = row,
	})
	applyHandFont(valueLabel)
	setSingleLineText(valueLabel, Enum.TextXAlignment.Right)
	local track, fill = createProgressBar(row, theme, 50)
	local dragging = false
	local userInput = service("UserInputService")

	local function set(nextValue, silent)
		value = roundToStep(clampNumber(nextValue, minValue, maxValue), step)
		local alpha = (value - minValue) / math.max(maxValue - minValue, 0.0001)
		self.Window:_setFlag(flag, value)
		valueLabel.Text = tostring(value)
		setProgressFill(fill, alpha)
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

	self.Window:_track(userInput.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			readPosition(input.Position.X)
		end
	end))

	self.Window:_track(userInput.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end))

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
	if maxValue < minValue then
		minValue, maxValue = maxValue, minValue
	end
	local step = tonumber(options.Step) or 1
	local flag = normalizeFlag(options.Title, options.Flag)
	local value = roundToStep(clampNumber(options.Default or minValue, minValue, maxValue), step)
	local row = self:_row(60)
	local title = rowTitle(row, options.Title or "Stepper", theme, 3, 154)

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
	setSingleLineText(valueLabel, Enum.TextXAlignment.Center)
	corner(valueLabel, theme)
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
		minus.BackgroundTransparency = nextTheme.RowTransparency
		setButtonRestTransparency(minus, nextTheme.RowTransparency)
		minus.TextColor3 = nextTheme.Text
		valueLabel.BackgroundColor3 = nextTheme.PanelAlt
		valueLabel.TextColor3 = nextTheme.Text
		plus.BackgroundColor3 = nextTheme.Panel
		plus.BackgroundTransparency = nextTheme.RowTransparency
		setButtonRestTransparency(plus, nextTheme.RowTransparency)
		plus.TextColor3 = nextTheme.Text
		updateStroke(minus, nextTheme)
		updateStroke(valueLabel, nextTheme)
		updateStroke(plus, nextTheme)
		updateCorner(valueLabel, nextTheme)
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
	local optionHeight = 30
	local closedHeight = 60
	local row = self:_row(closedHeight)
	local title = rowTitle(row, options.Title or "Dropdown", theme, 3, 136)
	local button = makeButton(row, tostring(value or "Pick"), theme, 124)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -8, 0, 30)
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
	corner(menu, theme)
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
			Size = UDim2.new(1, 0, 0, optionHeight),
			ZIndex = 11,
			Parent = menu,
		})
		applyHandFont(option)
		setSingleLineText(option)
		padding(option, 8, 0, 8, 0)
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
		local menuHeight = #choices * optionHeight
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
		setButtonRestTransparency(button, nextTheme.RowTransparency)
		button.TextColor3 = nextTheme.Text
		menu.BackgroundColor3 = nextTheme.Panel
		updateStroke(button, nextTheme)
		updateStroke(menu, nextTheme)
		updateCorner(menu, nextTheme)
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
	local optionHeight = 30
	local closedHeight = 60
	local row = self:_row(closedHeight)
	local title = rowTitle(row, options.Title or "Multi Dropdown", theme, 3, 146)
	local button = makeButton(row, "...", theme, 134)
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -8, 0, 30)
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
	corner(menu, theme)
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
			Size = UDim2.new(1, 0, 0, optionHeight),
			ZIndex = 11,
			Parent = menu,
		})
		applyHandFont(option)
		setSingleLineText(option)
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
		local menuHeight = #choices * optionHeight
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
		setButtonRestTransparency(button, nextTheme.RowTransparency)
		button.TextColor3 = nextTheme.Text
		menu.BackgroundColor3 = nextTheme.Panel
		updateStroke(button, nextTheme)
		updateStroke(menu, nextTheme)
		updateCorner(menu, nextTheme)
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
	local row = self:_row(60)
	local title = rowTitle(row, options.Title or "Textbox", theme, 3, 168)
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
	corner(box, theme)
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
		updateCorner(box, nextTheme)
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
	local row = self:_row(60)
	local title = rowTitle(row, options.Title or "Keybind", theme, 3, 136)
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

	self.Window:_track(service("UserInputService").InputBegan:Connect(function(input, gameProcessed)
		if self.Window._destroyed then
			return
		end

		if listening and input.KeyCode ~= Enum.KeyCode.Unknown then
			listening = false
			set(input.KeyCode)
			return
		end

		if not gameProcessed and input.KeyCode == value then
			call(options.Pressed, value)
		end
	end))

	self.Window:_registerFlag(flag, set)
	set(value, true)

	self.Window:_bindTheme(function(nextTheme)
		title.TextColor3 = nextTheme.Text
		button.BackgroundColor3 = nextTheme.Panel
		button.BackgroundTransparency = nextTheme.RowTransparency
		setButtonRestTransparency(button, nextTheme.RowTransparency)
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
	if #colors == 0 then
		colors = { Color3.fromRGB(255, 255, 255) }
	end
	local value = options.Default or colors[1]
	local row = self:_row(72)
	local title = rowTitle(row, options.Title or "Color", theme, 3, 16)
	local holder = make("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(8, 40),
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
		corner(swatch, theme, 5)
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
			updateCorner(swatch, nextTheme, 5)
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

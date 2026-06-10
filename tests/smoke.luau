local fs = require("@lune/fs")

Color3 = {
	fromRGB = function(r, g, b)
		return {
			R = r / 255,
			G = g / 255,
			B = b / 255,
		}
	end,
}

local source = fs.readFile("Source.lua")
local chunk, sourceError = loadstring(source, "Source.lua")
assert(chunk, sourceError)

local library = chunk()
assert(type(library) == "table", "Source.lua must return a table")
assert(type(library.CreateWindow) == "function", "CreateWindow is missing")
assert(type(library.Themes) == "table", "Themes table is missing")
assert(library.Themes.JJS ~= nil, "JJS theme is missing")
local themeCount = 0
for _ in pairs(library.Themes) do
	themeCount = themeCount + 1
end
assert(themeCount == 1, "Only the JJS theme should ship")
assert(library.Themes.JJS.StrokeThickness >= 3, "JJS outline should be thick")
assert(library.Version == "0.7.4", "Version should be 0.7.4")
assert(library.Font == "FingerPaint", "Default font should be FingerPaint")
assert(library.FontAssetId == "rbxassetid://12187375716", "FontAssetId should point at the Roblox font asset")
assert(library.FontFile == "FingerPaint-Regular.ttf", "FontFile should point at the bundled TTF")
assert(type(library.FontFileUrl) == "string", "FontFileUrl is missing")
assert(type(library.GetFontStatus) == "function", "GetFontStatus is missing")
assert(type(library.GetFontHelp) == "function", "GetFontHelp is missing")
assert(library:GetFontStatus().Requested == "FingerPaint", "Font status should start on FingerPaint")
assert(type(library.SetMotion) == "function", "SetMotion is missing")
assert(library.Themes.JJS.RowTransparency <= 0.05, "JJS rows should read like solid paper")

local loader = fs.readFile("loader.lua")
local loaderChunk, loaderError = loadstring(loader, "loader.lua")
assert(loaderChunk, loaderError)

local showcase = fs.readFile("examples/showcase.client.lua")
local showcaseChunk, showcaseError = loadstring(showcase, "showcase.client.lua")
assert(showcaseChunk, showcaseError)

print("cursedpaint smoke ok")

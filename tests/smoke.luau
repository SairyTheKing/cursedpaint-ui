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
assert(library.Themes.Cursed ~= nil, "Cursed theme is missing")
assert(library.Themes.Gojo ~= nil, "Gojo theme is missing")
assert(library.Version ~= nil, "Version is missing")

local showcase = fs.readFile("examples/showcase.client.lua")
local showcaseChunk, showcaseError = loadstring(showcase, "showcase.client.lua")
assert(showcaseChunk, showcaseError)

print("cursedpaint smoke ok")

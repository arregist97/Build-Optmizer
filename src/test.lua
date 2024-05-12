Builds = require("builds")
Frames = require("frames")


local filepath = "../data/Smite 2 Items - Sheet1.csv"

local frame = Frames.from_csv(filepath)

local test_build = Builds.optimize_for_stat(frame, "Strength")

Builds.print(test_build)

local stats = {"Intelligence", "Physical Protection", "Magical Protection"}

local test_build_2 = Builds.optimize_multiple_stats(frame, stats)

Builds.print(test_build_2)

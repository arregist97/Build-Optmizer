Builds = require("builds")
Frames = require("frames")


local filepath = "../data/Smite 2 Items - Sheet1.csv"

local frame = Frames.from_csv(filepath)

local test_build = Builds.optimize_for_stat(frame, "Strength")
print("Example Strength Optimized Build:")
Builds.print(test_build)
print("---------------------------------------------------")

local stats = {"Intelligence", "Physical Protection", "Magical Protection"}

local test_build_2 = Builds.optimize_multiple_stats(frame, stats)
print("Example Multistat Optimization")
print("Built for Intelligence, Physical Protection, and Magical Protection:")
Builds.print(test_build_2)

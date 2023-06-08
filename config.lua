CONFIG = {}

CONFIG.PrepCoke = vector3(1090.47, -3194.78, -38.99) -- The location where players prepare coke
CONFIG.BagCoke = vector3(1095.4, -3194.88, -38.99) -- The location where the player bag coke
CONFIG.PackageCoke = vector3(1100.71, -3198.79, -38.99)

CONFIG.ShowBlip = true -- Whether there should be blips for drug picking and the coke lab
CONFIG.CokePlant = "prop_veg_crop_04_leaf" -- The plant for the coke

CONFIG.CokePicked = 3 -- How many cokeleafs the player gets for every time they plant the coke.

CONFIG.CokeLeafItem = 'cokeleaf' -- Coca Leaf, also what player will get from picking coke.
CONFIG.ProcessedCokeItem = 'processedcoke' -- Processed Coke
CONFIG.BaggedCokeItem = 'cokebaggy'
CONFIG.PackedCokeItem = 'packagedcoca'

CONFIG.CokeLeafsNeeded = 3 -- How many coke leafs needed to make Processed Coke
CONFIG.ProcessedCokeGiven = 1 -- How many processed coke will be given for each process.

CONFIG.ProcessedCokeNeeded = 5 -- How many processed coke needed for a baggy
CONFIG.CokeBaggyGiven = 1 -- How many coke baggy's given from processing coke.

CONFIG.CokeBagsNeeded = 10 -- How many coke bags needed to make a coke package
CONFIG.CokePackagesGiven = 1 -- How many coke packages given when packaging coke.

CONFIG.PickingLocations = { -- Locations player can pick up coke plants
    vector3(-2166.29, 5180.69, 15.34-0.9),
    vector3(-2161.72, 5183.33, 14.95-0.9),
    vector3(-2159.58, 5170.82, 13.87-0.9),
    vector3(-2168.95, 5164.08, 13.51-0.9)
}
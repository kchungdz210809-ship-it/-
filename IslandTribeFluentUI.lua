-- ===== Fluent UI Loader =====
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- ===== Window =====
local Window = Fluent:CreateWindow({
    Title = "🌴Island Tribes 🌴",
    SubTitle = "Made by Chung credit #Chungdz",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- ===== Tabs =====
local Tabs = {
    Main = Window:AddTab({ Title = "🏠 Main" }),
    Duping = Window:AddTab({ Title = "🤑 Duping" }),
    Crazy = Window:AddTab({ Title = "😵‍💫 Crazy Dupe" }),
    Armor = Window:AddTab({ Title = "🛡️ Armor & Weapons" }),
    OpenDrop = Window:AddTab({ Title = "📦 Open & Drop" }),
    Other = Window:AddTab({ Title = "🔧 Other" }),
    Autofarm = Window:AddTab({ Title = "🤖 Autofarm" }),
    Sell = Window:AddTab({ Title = "💰 Auto Sell" }),
    Player = Window:AddTab({ Title = "👤 Player Mods" })
}

-- ===== Services =====
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local MyInventory = LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:FindFirstChild("StarterGear")
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- ===== RemoteEvents =====
local RemoteEvents = {
    ToolAction = ReplicatedStorage:WaitForChild('References'):WaitForChild('Comm'):WaitForChild('Events'):WaitForChild('ToolAction'),
    InventoryInteraction = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"),
    UpdateStorageChest = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("UpdateStorageChest"),
    SetSettings = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("SetSettings"),
    BuyWorldEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent"),
    ItemInteracted = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ItemInteracted"),
    CraftItem = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("CraftItem"),
    TradeTrader = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("TradeTrader"),
    KeyDoor = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("KeyDoor"),
    Sonar = ReplicatedStorage:WaitForChild('References'):WaitForChild('Comm'):WaitForChild('Events'):WaitForChild('Sonar')
}

-- ===== Biến toàn cục =====
getgenv().configs = getgenv().configs or {}
getgenv().configs.AutoPickup = false
getgenv().configs.Hitbox = false
getgenv().configs.PlayerEsp = false
getgenv().configs.ConiferFarm = false
getgenv().configs.ObsidianBoss = false
getgenv().configs.ZenLuckBoss = false
getgenv().configs.SpiritBoss = false
getgenv().configs.LuckySlime = false
getgenv().configs.EvilSkeleton = false
getgenv().configs.Ogre = false
getgenv().configs.Squid = false
getgenv().configs.AutoRepairClub = false
getgenv().configs.UseSoulKeys = false
getgenv().configs.InfJump = false
getgenv().configs.AntiRagDoll = false
getgenv().configs.JumpPower = false
getgenv().configs.ExtraSpeed = false
getgenv().configs.GliderModSpeedToggle = false
getgenv().configs.AutoEat = false
getgenv().configs.EatingType = 'AFK'
getgenv().QuickSpeedKey = Enum.KeyCode.B
getgenv().QuickSpeedMultiplier = 1
getgenv().GliderModSpeed = 30
getgenv().InfiniteJump = nil
AutoAttackPlayer = false
KillAuraLoop = nil
healingEnabled = false
healTask = nil
getgenv().bypassing = false
getgenv().AutoPickupLoop = nil
getgenv().PercentChanged = nil
_G.SellSilver = false
_G.SellSlime = false
_G.SellGold = false
_G.SellRuby = false
_G.SellDiamonds = false
_G.SellSouls = false
_G.SellZenyte = false
_G.SellVolcanicOre = false
_G.SellObsidian = false
_G.SellLunarOre = false
_G.SellMoonstone = false

-- ===== ALL ITEMS =====
local ALLITEMS = {
    [1] = "Stick",
    [2] = "Small Raft",
    [3] = "Small Campfire",
    [4] = "Wood Boots",
    [5] = "Wooden Harvester",
    [6] = "Wood Helmet",
    [7] = "Wooden Club",
    [8] = "Leather Bag",
    [9] = "Wood Body",
    [10] = "Wood Legs",
    [11] = "Wood Storage Chest",
    [12] = "Wood Bridge",
    [13] = "Wood Wall",
    [14] = "Teepee",
    [15] = "Plant Box",
    [16] = "Hardleather Bag",
    [17] = "Stone Boots",
    [18] = "Stone Harvester",
    [19] = "Wooden Sword",
    [20] = "Large Campfire",
    [21] = "Stone Helmet",
    [22] = "Party Raft",
    [23] = "Wood Gate",
    [24] = "Reinforced Bag",
    [25] = "Stone Body",
    [26] = "Stone Legs",
    [27] = "Stone Storage Chest",
    [28] = "Furnace",
    [29] = "Silver Boots",
    [30] = "Wooden Bow",
    [31] = "Arrow",
    [32] = "Stone Wall",
    [33] = "Silver Helmet",
    [34] = "Stone Sword",
    [35] = "Fishing Rod",
    [36] = "Stone Gate",
    [37] = "Silver Bag",
    [38] = "Silver Harvester",
    [39] = "Silver Body",
    [40] = "Silver Legs",
    [41] = "Silver Storage Chest",
    [42] = "Ladder",
    [43] = "Gold Boots",
    [44] = "Silver Sword",
    [45] = "Stone Land Bridge",
    [46] = "Silver Wall",
    [47] = "Gold Helmet",
    [48] = "Bed",
    [49] = "Stone Bridge",
    [50] = "Silver Gate",
    [51] = "Golden Harvester",
    [52] = "Gold Body",
    [53] = "Gold Legs",
    [54] = "Gold Storage Chest",
    [55] = "Golden Bag",
    [56] = "Ruby Boots",
    [57] = "Golden Sword",
    [58] = "Gold Wall",
    [59] = "Ruby Helmet",
    [60] = "Tent Raft",
    [61] = "Golden Bow",
    [62] = "Gold Gate",
    [63] = "Ruby Harvester",
    [64] = "Ruby Body",
    [65] = "Ruby Legs",
    [66] = "Ruby Storage Chest",
    [67] = "Diamond Boots",
    [68] = "Ruby Sword",
    [69] = "Ruby Bag",
    [70] = "Diamond Harvester",
    [71] = "Diamond Helmet",
    [72] = "Ruby Wall",
    [73] = "Diamond Body",
    [74] = "Diamond Legs",
    [75] = "Ruby Gate",
    [76] = "Diamond Storage Chest",
    [77] = "Ruby Bow",
    [78] = "Diamond Wall",
    [79] = "Diamond Gate",
    [80] = "Diamond Bag",
    [81] = "Small Log",
    [82] = "Big Log",
    [83] = "Small Rock",
    [84] = "Large Rock",
    [85] = "Raw Fish",
    [86] = "Cooked Fish",
    [87] = "Raw Meat",
    [88] = "Cooked Meat",
    [89] = "Silver Ore",
    [90] = "Silver Bar",
    [91] = "Gold Ore",
    [92] = "Gold Bar",
    [93] = "Unrefined Ruby",
    [94] = "Ruby",
    [95] = "Unrefined Diamond",
    [96] = "Diamond",
    [97] = "Redberry",
    [98] = "Coconut",
    [99] = "Watermelon",
    [100] = "Watermelon Seeds",
    [101] = "Carrot",
    [102] = "Carrot Seeds",
    [103] = "Raw Potato",
    [104] = "Potato Seeds",
    [105] = "Banana",
    [106] = "Leaves",
    [107] = "Leather",
    [108] = "Feather",
    [109] = "Feather Stack",
    [110] = "Arrow Stack",
    [111] = "Freshy Chest",
    [112] = "Stone Supplies",
    [113] = "Wooden Warrior Pack",
    [114] = "Feather Pack",
    [115] = "Arrow Pack",
    [116] = "Silver Warrior Pack",
    [117] = "Fisherman's Pack",
    [118] = "Golden Archer Pack",
    [119] = "Ruby Hero Pack",
    [120] = "Infinite Campfire",
    [121] = "Bowling Pins",
    [122] = "Cabbage",
    [123] = "Cabbage Seeds",
    [124] = "Torch",
    [125] = "Tiki Torch",
    [126] = "Baked Potato",
    [127] = "Small Wood Base",
    [128] = "Medium Wood Base",
    [129] = "Large Wood Base",
    [130] = "Small Stone Base",
    [131] = "Medium Stone Base",
    [132] = "Large Stone Base",
    [133] = "Repair Hammer",
    [134] = "Unrefined Zenyte",
    [135] = "Zenyte",
    [136] = "Totem",
    [137] = "Caveberry",
    [138] = "Slime Ball",
    [139] = "Slime Helmet",
    [140] = "Slime Body",
    [141] = "Slime Legs",
    [142] = "Slime Boots",
    [143] = "Slimy Pack",
    [144] = "Zenyte Helmet",
    [145] = "Zenyte Body",
    [146] = "Zenyte Storage Chest",
    [147] = "Zenyte Legs",
    [148] = "Zenyte Boots",
    [149] = "Zenyte Wall",
    [150] = "Zenyte Gate",
    [151] = "Zenyte Bag",
    [152] = "Slime Club",
    [153] = "Zenyte Harvester",
    [154] = "Diamond Sword",
    [155] = "Wooden Mine Cart",
    [156] = "Party Cart",
    [157] = "Silver Mine Cart",
    [158] = "Ruby Mine Cart",
    [159] = "Zenyte Mine Cart",
    [160] = "Coal",
    [161] = "Infinite Furnace",
    [162] = "Beginner Wand",
    [163] = "Clue Scroll (Easy)",
    [164] = "Clue Scroll (Medium)",
    [165] = "Clue Scroll (Hard)",
    [166] = "Treasure Chest (Easy)",
    [167] = "Treasure Chest (Medium)",
    [168] = "Treasure Chest (Hard)",
    [169] = "Shovel",
    [170] = "Clue Bottle (Easy)",
    [171] = "Clue Bottle (Medium)",
    [172] = "Clue Bottle (Hard)",
    [173] = "Lucky Sword",
    [174] = "Lucky Bow",
    [175] = "Lucky Helmet",
    [176] = "Lucky Body",
    [177] = "Lucky Legs",
    [178] = "Lucky Boots",
    [179] = "Lucky Harvester",
    [180] = "Lucky Fruit",
    [181] = "Candy",
    [182] = "Kerosene Lamp",
    [183] = "Sleigh",
    [184] = "Magical Sleigh",
    [185] = "Grinch's Sleigh",
    [186] = "Candy Bag",
    [187] = "Pile of Candy",
    [188] = "Candy Pack",
    [189] = "Explorer Energy",
    [190] = "Cave Door Key (d)",
    [191] = "Key Handle (d)",
    [192] = "Key Shaft (d)",
    [193] = "Cave Door Key (z)",
    [194] = "Key Handle (z)",
    [195] = "Key Shaft (z)",
    [196] = "Stone Anvil",
    [197] = "Silver Crossbow",
    [198] = "Diamond Crossbow",
    [199] = "Zenyte Crossbow",
    [200] = "Soul",
    [201] = "Soul Helmet",
    [202] = "Soul Body",
    [203] = "Soul Legs",
    [204] = "Soul Boots",
    [205] = "Zenyte Sword",
    [206] = "Wooden Shield",
    [207] = "Silver Shield",
    [208] = "Golden Shield",
    [209] = "Ruby Shield",
    [210] = "Diamond Shield",
    [211] = "Zenyte Shield",
    [212] = "Golden Anvil",
    [213] = "Diamond Anvil",
    [214] = "Cave Key Pack",
    [215] = "OP Sword",
    [216] = "Soul Sword",
    [217] = "Soul Bag",
    [218] = "Soul Shield",
    [219] = "Lucky Shield",
    [220] = "Soul Key",
    [221] = "Pirate Ship",
    [222] = "Springy Boots",
    [223] = "Volcanic Ore",
    [224] = "Obsidian",
    [225] = "Obsidian Helmet",
    [226] = "Obsidian Body",
    [227] = "Obsidian Legs",
    [228] = "Obsidian Boots",
    [229] = "Volcanic Furnace",
    [230] = "Obsidian Club",
    [231] = "Obsidian Wall",
    [232] = "Obsidian Gate",
    [233] = "Obsidian Storage Chest",
    [234] = "Harpoon Turret",
    [235] = "Obsidian Shield",
    [236] = "Obsidian Bag",
    [237] = "Instakill Sword",
    [238] = "Pearl Helmet",
    [239] = "Pearl Body",
    [240] = "Pearl Legs",
    [241] = "Pearl Boots",
    [242] = "Raw Seaweed",
    [243] = "Cooked Seaweed",
    [244] = "Pink Shell",
    [245] = "White Shell",
    [246] = "Orange Shell",
    [247] = "Pearl",
    [248] = "Seaglass",
    [249] = "Seaglass Helmet",
    [250] = "Seaglass Body",
    [251] = "Seaglass Legs",
    [252] = "Seaglass Boots",
    [253] = "White Shell Sword",
    [254] = "Pink Shell Sword",
    [255] = "Orange Shell Sword",
    [256] = "White Shell Harvester",
    [257] = "Pink Shell Harvester",
    [258] = "Orange Shell Harvester",
    [259] = "Shell Helmet",
    [260] = "Shell Body",
    [261] = "Shell Legs",
    [262] = "Flippers",
    [263] = "Poison Seaweed",
    [264] = "Stone Trap",
    [265] = "Ruby Trap",
    [266] = "Zenyte Trap",
    [267] = "Pink Egg",
    [268] = "Purple Egg",
    [269] = "Red Egg",
    [270] = "Yellow Egg",
    [271] = "Easter Candy",
    [272] = "Easter Glider",
    [273] = "Repairio Spellbook",
    [274] = "Warrior Energy",
    [275] = "Protector Energy",
    [276] = "Magic Portal",
    [277] = "Healing Aura",
    [278] = "Electric Aura",
    [279] = "Hunger Aura",
    [280] = "Book of Exploration (I)",
    [281] = "Book of Exploration (II)",
    [282] = "Book of Exploration (III)",
    [283] = "Book of Protection (I)",
    [284] = "Book of Protection (II)",
    [285] = "Book of Protection (III)",
    [286] = "Book of Combat (I)",
    [287] = "Book of Combat (II)",
    [288] = "Book of Combat (III)",
    [289] = "Apprentice Wand",
    [290] = "Adept Staff",
    [291] = "Master Staff",
    [292] = "Transcended Staff",
    [293] = "Visionary Staff",
    [294] = "Wool",
    [295] = "Book",
    [296] = "Magical Book",
    [297] = "Obsidian Harvester",
    [298] = "Magic Repair Table (I)",
    [299] = "Magic Repair Table (II)",
    [300] = "Magic Repair Table (III)",
    [301] = "Glider",
    [302] = "Imbue Spellbook",
    [303] = "Shieldio Spellbook",
    [304] = "Hungaria Spellbook",
    [305] = "Baseio Retreatio Spellbook",
    [306] = "Healia Spellbook",
    [307] = "Deadia Protectia Spellbook",
    [308] = "Baseio Destroyio Spellbook",
    [309] = "Oofio Spellbook",
    [310] = "Freezio Spellbook",
    [311] = "Starvio Spellbook",
    [312] = "Electricia Spellbook",
    [313] = "Portalio Spellbook",
    [314] = "Protectio Claimio Spellbook",
    [315] = "Warrio Claimio Spellbook",
    [316] = "Explorer Energy Pack",
    [317] = "Protector Energy Pack",
    [318] = "Warrior Energy Pack",
    [319] = "Explorer Energy Stack",
    [320] = "Protector Energy Stack",
    [321] = "Warrior Energy Stack",
    [322] = "Infinite Bag",
    [323] = "Deflectio Projectio Spellbook",
    [324] = "Seed Pack",
    [325] = "Fruit Pack",
    [326] = "Diamond Hero Pack",
    [327] = "Zenyte Warrior Pack",
    [328] = "Box of Redberries",
    [329] = "Box of Coconuts",
    [330] = "Box of Bananas",
    [331] = "Box of Watermelons",
    [332] = "Potato Seed Box",
    [333] = "Cabbage Seed Box",
    [334] = "Carrot Seed Box",
    [335] = "Watermelon Seed Box",
    [336] = "Halloween Pumpkin",
    [337] = "Jack-o'-lantern",
    [338] = "Weak Pet Net",
    [339] = "Sturdy Pet Net",
    [340] = "Strong Pet Net",
    [341] = "Unbreakable Pet Net",
    [342] = "Christmas Present",
    [343] = "Snowball",
    [344] = "Obsidian Floor",
    [345] = "Pile of Snowballs",
    [346] = "Snowball Pack",
    [347] = "Silver Snowball",
    [348] = "Golden Snowball",
    [349] = "Ruby Snowball",
    [350] = "Diamond Snowball",
    [351] = "Zenyte Snowball",
    [352] = "Obsidian Snowball",
    [353] = "Candy Snowball",
    [354] = "Starter Sword",
    [355] = "Starter Harvester",
    [356] = "Starter Helmet",
    [357] = "Starter Body",
    [358] = "Starter Legs",
    [359] = "Starter Boots",
    [360] = "Lunar Ore",
    [361] = "Moonstone",
    [362] = "Lunario Enchantio Spellbook",
    [363] = "Moonstone Helmet",
    [364] = "Moonstone Body",
    [365] = "Moonstone Legs",
    [366] = "Moonstone Boots",
    [367] = "Moonstone Shield",
    [368] = "Moonstone Harvester",
    [369] = "Moonstone Sword",
    [370] = "Moonstone Bag",
    [371] = "Potion Cauldron",
    [372] = "Candy Potion",
    [373] = "Moonstone Storage Chest",
    [374] = "Moonstone Wall",
    [375] = "Moonstone Gate",
    [376] = "Moonstone Crossbow",
    [377] = "Lunar Arrow",
    [378] = "Pumpkin",
    [379] = "Pumpkin Shield",
    [380] = "Pumpkin Bag",
    [381] = "Pumpkin Seeds",
    [382] = "Treasure Chest Pack",
}

local ALLITEMSTABLE = {}
local SWITCHEDITEMSTABLE = {}
for id, name in pairs(ALLITEMS) do
    ALLITEMSTABLE[id] = name
    SWITCHEDITEMSTABLE[name] = id
end

-- ===== Boss Death Connections =====
local AutoPickupOnObsidianDeath = nil
local AutoPickupOnZenLuckBossDeath = nil
local AutoPickupOnSpiritBossDeath = nil
local AutoPickuponLuckySlimeDeath = nil
local AutoPickupOnSkeletonDeath = nil
local AutoPickupOnOgreDeath = nil
local AutoPickupOnSquidDeath = nil

-- ===== Shared Functions =====
local function IsPlayerAlive(player)
    return player and player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local function GetClosestChest()
    local closest, range = nil, math.huge
    local replicators = Workspace:FindFirstChild("Replicators")
    if not replicators then return nil end
    local chestFolder = replicators:FindFirstChild("NonPassive") or replicators:FindFirstChild("Passive")
    if not chestFolder then return nil end
    if IsPlayerAlive(LocalPlayer) then
        local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        for _, chest in pairs(chestFolder:GetChildren()) do
            if string.find(chest.Name, "Storage") and chest:FindFirstChildOfClass("MeshPart") then
                local part = chest:FindFirstChildOfClass("MeshPart")
                local dist = (hrp.Position - part.Position).Magnitude
                if dist < range then
                    range, closest = dist, chest
                end
            end
        end
    end
    return closest
end

-- ===== AutoPickup =====
function AutoPickup()
    local checkpassivenonpassive = Workspace:FindFirstChild("Replicators"):FindFirstChild('NonPassive') and 'NonPassive' or 'Passive'
    if IsPlayerAlive(LocalPlayer) then
        local AllPickups = {}
        local mypos = LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position
        for _, item in pairs(Workspace:WaitForChild('Replicators')[checkpassivenonpassive]:GetChildren()) do
            if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 18.5 and not string.find(item.Name:lower(), 'clue') then
                if ALLITEMSTABLE[tonumber(item.Name)] or SWITCHEDITEMSTABLE[item.Name] then
                    table.insert(AllPickups, item)
                end
            end
        end
        for _, item in pairs(Workspace:WaitForChild('Replicators'):WaitForChild('Both'):GetChildren()) do
            if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 18.5 and not string.find(item.Name:lower(), 'clue') then
                if ALLITEMSTABLE[tonumber(item.Name)] or SWITCHEDITEMSTABLE[item.Name] then
                    table.insert(AllPickups, item)
                end
            end
        end
        for _, item in pairs(Workspace:GetChildren()) do
            if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 18.5 and not string.find(item.Name:lower(), 'clue') then
                if ALLITEMSTABLE[tonumber(item.Name)] or SWITCHEDITEMSTABLE[item.Name] then
                    table.insert(AllPickups, item)
                end
            end
        end
        if #AllPickups > 0 then
            for _, getitem in ipairs(AllPickups) do
                repeat task.wait()
                    local mybagspace = string.split(LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('HUD'):WaitForChild('Status'):WaitForChild('Content'):WaitForChild('Bag'):WaitForChild('StatusLabel').Text, '/')
                    if tonumber(mybagspace[1])+1 >= tonumber(mybagspace[2]) then return false end 
                    if IsPlayerAlive(LocalPlayer) then
                        if getitem.Parent then
                            RemoteEvents['ItemInteracted']:FireServer(getitem, "Pickup")
                        end
                    end
                until not getitem.Parent or (LocalPlayer.Character.HumanoidRootPart.Position - getitem:GetPivot().Position).magnitude > 18.5 or tonumber(mybagspace[1])+1 >= tonumber(mybagspace[2]) or not IsPlayerAlive(LocalPlayer)
            end
        end
    end
end

-- ===== AutoPickupBoss =====
local function AutoPickupBoss()
    local checkpassivenonpassive = Workspace:FindFirstChild("Replicators"):FindFirstChild('NonPassive') and 'NonPassive' or 'Passive'
    if IsPlayerAlive(LocalPlayer) then
        local AllPickups = {}
        local mypos = LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position
        
        for _, item in pairs(Workspace:WaitForChild('Replicators')[checkpassivenonpassive]:GetChildren()) do
            if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 20 and not string.find(item.Name:lower(), 'clue') then
                if not item:FindFirstChild("Humanoid") then
                    table.insert(AllPickups, item)
                end
            end
        end
        for _, item in pairs(Workspace:WaitForChild('Replicators'):WaitForChild('Both'):GetChildren()) do
            if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 20 and not string.find(item.Name:lower(), 'clue') then
                if not item:FindFirstChild("Humanoid") then
                    table.insert(AllPickups, item)
                end
            end
        end
        for _, item in pairs(Workspace:GetChildren()) do
            if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 20 and not string.find(item.Name:lower(), 'clue') then
                if not item:FindFirstChild("Humanoid") then
                    table.insert(AllPickups, item)
                end
            end
        end
        
        if #AllPickups > 0 then
            for _, getitem in ipairs(AllPickups) do
                repeat task.wait()
                    local mybagspace = string.split(LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('HUD'):WaitForChild('Status'):WaitForChild('Content'):WaitForChild('Bag'):WaitForChild('StatusLabel').Text, '/')
                    if tonumber(mybagspace[1])+1 >= tonumber(mybagspace[2]) then return false end 
                    if IsPlayerAlive(LocalPlayer) then
                        if getitem.Parent then
                            RemoteEvents['ItemInteracted']:FireServer(getitem, "Pickup")
                        end
                    end
                until not getitem.Parent or (LocalPlayer.Character.HumanoidRootPart.Position - getitem:GetPivot().Position).magnitude > 20 or tonumber(mybagspace[1])+1 >= tonumber(mybagspace[2]) or not IsPlayerAlive(LocalPlayer)
            end
        end
    end
end

-- ===== Hitbox Extender =====
function Hitbox()
    while getgenv().configs.Hitbox do
        task.wait(0.2)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and IsPlayerAlive(plr) then
                local hitbox = plr.Character:FindFirstChild('Hitbox')
                if hitbox and hitbox.Size ~= Vector3.new(20, 20, 20) then
                    hitbox.Size = Vector3.new(20, 20, 20)
                end
            end
        end
    end
end

-- ===== Player Mod Functions =====
function InfJump()
    if getgenv().InfiniteJump then
        pcall(function() getgenv().InfiniteJump:Disconnect() end)
        getgenv().InfiniteJump = nil
    end
    getgenv().InfiniteJump = Mouse.KeyDown:Connect(function(Key)
        if Key == " " then
            if getgenv().configs.InfJump and IsPlayerAlive(LocalPlayer) then
                LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
            end
        end
    end)
end

function JumpPower()
    while getgenv().configs.JumpPower do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            LocalPlayer.Character.Humanoid.JumpPower = 100
        end
    end
end

function ExtraSpeed()
    while getgenv().configs.ExtraSpeed do
        task.wait(0.1)
        if IsPlayerAlive(LocalPlayer) then
            LocalPlayer.Character.Humanoid.WalkSpeed = 21
        end
    end
end

-- ===== Auto Eat =====
function AutoEat()
    local function GreatestFoodSource()
        local foodtable = {}
        local highestfood = nil
        local greatestfoodpossible = -math.huge
        
        for _, food in pairs(MyInventory:GetChildren()) do
            if food.Name == 'Raw Potato' or food.Name == 'Watermelon' or food.Name == 'Banana' or food.Name == 'Redberry' or food.Name == 'Coconut' or food.Name == 'Baked Potato' or food.Name == 'Carrot' or food.Name == 'Cabbage' or food.Name == 'Cooked Fish' or food.Name == 'Cooked Meat' or food.Name == 'Caveberry' or food.Name == 'Slime Ball' or food.Name == 'Lucky Fruit' or food.Name == 'Pumpkin' then
                table.insert(foodtable, food)
            end
        end
        for _, food in pairs(foodtable) do
            local nameLabel = food:FindFirstChild('Top'):FindFirstChild('NameLabel')
            if nameLabel then
                local foodamount = tonumber(string.match(nameLabel.Text, '%d+'))
                if foodamount and foodamount > greatestfoodpossible then
                    greatestfoodpossible = foodamount
                    highestfood = food.Name
                end
            end
        end
        return highestfood
    end
    
    while getgenv().configs.AutoEat do
        task.wait(0.5)
        if not IsPlayerAlive(LocalPlayer) then continue end
        
        local Food = GreatestFoodSource()
        if not Food then continue end
        
        local foodId = SWITCHEDITEMSTABLE[Food]
        if not foodId then continue end
        
        if getgenv().configs.EatingType == 'AFK' then
            local hungerBar = LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('HUD'):WaitForChild('Status'):WaitForChild('Content'):WaitForChild('Hunger'):WaitForChild('Bar'):WaitForChild('Bar')
            local maxHunger = hungerBar.Parent.AbsoluteSize.X
            local currentHunger = hungerBar.AbsoluteSize.X
            if maxHunger - currentHunger >= 20 then
                RemoteEvents['InventoryInteraction']:FireServer(foodId, 'Eat')
                task.wait(0.2)
            end
        elseif getgenv().configs.EatingType == 'War' then
            local healthBar = LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('HUD'):WaitForChild('Status'):WaitForChild('Content'):WaitForChild('Health'):WaitForChild('Bar'):WaitForChild('Sub')
            local maxHealth = healthBar.Parent.AbsoluteSize.X
            local currentHealth = healthBar.AbsoluteSize.X
            if maxHealth - currentHealth >= 20 then
                RemoteEvents['InventoryInteraction']:FireServer(foodId, 'Eat')
                task.wait(0.2)
            end
        end
    end
end

-- ===== Player ESP =====
local ChrAddedFunc = nil
local EspDrawings = {}

function PlayerEsp()
    if getgenv().configs.PlayerEsp then
        function EspOnPlayer(target)
            local Boxoutline = Drawing.new('Square')
            Boxoutline.Thickness = 1
            Boxoutline.Filled = false
            Boxoutline.Transparency = 1
            Boxoutline.Color = Color3.new(0, 0, 0)
            
            local Box = Drawing.new('Square')
            Box.Thickness = 1
            Box.Transparency = 1
            Box.Filled = false
            Box.Color = Color3.fromRGB(0, 255, 0)
            
            local Healthbaroutline = Drawing.new('Square')
            Healthbaroutline.Thickness = 1
            Healthbaroutline.Filled = false
            Healthbaroutline.Transparency = 1
            Healthbaroutline.Color = Color3.new(0, 0, 0)
            
            local Healthbar = Drawing.new('Square')
            Healthbar.Thickness = 1
            Healthbar.Filled = false
            Healthbar.Transparency = 1
            Healthbar.Color = Color3.fromRGB(0, 255, 0)
            
            local EspRenderStepped = RunService.RenderStepped:Connect(function()
                if not getgenv().configs.PlayerEsp then
                    pcall(function()
                        Boxoutline:Remove()
                        Box:Remove()
                        Healthbaroutline:Remove()
                        Healthbar:Remove()
                        EspRenderStepped:Disconnect()
                    end)
                    return 
                end
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("Head") then
                    if IsPlayerAlive(target) then
                        local HumPos, onScreen = Camera:WorldToViewportPoint(target.Character.HumanoidRootPart.Position)
                        if onScreen then
                            local headpos = Camera:WorldToViewportPoint(target.Character.Head.Position + Vector3.new(0, 0.5, 0))
                            local LegPosition = Camera:WorldToViewportPoint(target.Character.HumanoidRootPart.Position - Vector3.new(0, 4.5, 0))
                            local humanoid = target.Character:FindFirstChildOfClass('Humanoid')
                            
                            if humanoid then
                                local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                                local boxWidth = 1050 / HumPos.Z
                                local boxHeight = headpos.Y - LegPosition.Y
                                
                                Boxoutline.Size = Vector2.new(boxWidth, boxHeight)
                                Boxoutline.Position = Vector2.new(HumPos.X - boxWidth / 2, HumPos.Y - boxHeight / 2)
                                Boxoutline.Visible = true
                                
                                Box.Size = Vector2.new(boxWidth - 2, boxHeight - 2)
                                Box.Position = Vector2.new(HumPos.X - (boxWidth - 2) / 2, HumPos.Y - (boxHeight - 2) / 2)
                                Box.Visible = true
                                
                                Healthbaroutline.Size = Vector2.new(4, boxHeight)
                                Healthbaroutline.Position = Boxoutline.Position - Vector2.new(8, 0)
                                Healthbaroutline.Visible = true
                                
                                local healthHeight = boxHeight * healthPercent
                                Healthbar.Size = Vector2.new(2, healthHeight)
                                Healthbar.Position = Vector2.new(Box.Position.X - 7, Box.Position.Y + boxHeight - healthHeight)
                                Healthbar.Color = Color3.fromRGB(255, 0, 0):lerp(Color3.fromRGB(0, 255, 0), healthPercent)
                                Healthbar.Visible = true
                            end
                        else
                            Boxoutline.Visible = false
                            Box.Visible = false
                            Healthbaroutline.Visible = false
                            Healthbar.Visible = false
                        end
                    else
                        Boxoutline.Visible = false
                        Box.Visible = false
                        Healthbaroutline.Visible = false
                        Healthbar.Visible = false
                    end
                end
            end)
            
            table.insert(EspDrawings, {Boxoutline, Box, Healthbaroutline, Healthbar, EspRenderStepped})
        end
        
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                EspOnPlayer(plr)
            end
        end
        
        if not ChrAddedFunc then
            ChrAddedFunc = Players.PlayerAdded:Connect(function(plr)
                if not getgenv().configs.PlayerEsp then
                    ChrAddedFunc:Disconnect()
                    ChrAddedFunc = nil
                    return
                end
                EspOnPlayer(plr)
            end)
        end
    else
        for _, drawings in ipairs(EspDrawings) do
            for _, drawing in ipairs(drawings) do
                if drawing and drawing.Remove then
                    pcall(function() drawing:Remove() end)
                end
            end
        end
        EspDrawings = {}
        if ChrAddedFunc then
            ChrAddedFunc:Disconnect()
            ChrAddedFunc = nil
        end
    end
end

-- ===== Anti-AFK =====
if not getgenv().Idling then
    getgenv().Idling = true
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(0.5)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end

-- ===== AUTOFARM FUNCTIONS =====
function ConiferFarm()
    local function GetClosestTree()
        local range, closesttree = math.huge, nil
        for _, tree in pairs(Workspace:WaitForChild('Replicators'):WaitForChild('Both'):GetChildren()) do
            if tree.Name == 'Conifer' and IsPlayerAlive(LocalPlayer) then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - tree:GetPivot().Position).magnitude
                if dist < range then
                    range, closesttree = dist, tree
                end
            end
        end
        return closesttree
    end
    while getgenv().configs.ConiferFarm and task.wait() do
        if IsPlayerAlive(LocalPlayer) then
            local tree = GetClosestTree()
            if tree and tree.Parent then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(tree:GetPivot().Position)
                RemoteEvents['ToolAction']:FireServer(tree)
            else
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.X, 400, LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
            end
        end
    end
end

function ObsidianBoss()
    while getgenv().configs.ObsidianBoss do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Obsidian Golem')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not AutoPickupOnObsidianDeath then
                    AutoPickupOnObsidianDeath = Boss.AncestryChanged:Connect(function(golem, parent)
                        if not getgenv().configs.ObsidianBoss then
                            AutoPickupOnObsidianDeath:Disconnect()
                            AutoPickupOnObsidianDeath = nil
                        end
                        if not parent then
                            task.wait(0.3)
                            AutoPickupBoss()
                            if AutoPickupOnObsidianDeath then
                                AutoPickupOnObsidianDeath:Disconnect()
                                AutoPickupOnObsidianDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(-8, 13.5, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 15, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            else
                task.wait(0.5)
                AutoPickupBoss()
                task.wait(2)
            end
        end
    end
end

function ZenLuckBoss()
    local function AttackBoss()
        local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Zenyte Golem') or Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Lucky Golem')
        if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
            if not AutoPickupOnZenLuckBossDeath then
                AutoPickupOnZenLuckBossDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                    if not getgenv().configs.ZenLuckBoss then
                        AutoPickupOnZenLuckBossDeath:Disconnect()
                        AutoPickupOnZenLuckBossDeath = nil
                    end
                    if not parent then
                        task.wait(0.3)
                        AutoPickupBoss()
                        if AutoPickupOnZenLuckBossDeath then
                            AutoPickupOnZenLuckBossDeath:Disconnect()
                            AutoPickupOnZenLuckBossDeath = nil
                        end
                    end
                end)
            end
            local bosspos = Boss.HumanoidRootPart.Position
            local myroot = LocalPlayer.Character.HumanoidRootPart
            if Boss.Humanoid.Health > 50 then
                myroot.CFrame = CFrame.new(bosspos + Vector3.new(-8, 13, 0))
            else
                myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 10, 0))
            end
            RemoteEvents['ToolAction']:FireServer(Boss)
        else
            if IsPlayerAlive(LocalPlayer) then
                AutoPickupBoss()
                task.wait(1)
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1663, -460, -4558)
                RemoteEvents['KeyDoor']:FireServer(Workspace:WaitForChild('Map'):WaitForChild("Zenyte Boss Cave"):WaitForChild("Cave Door (z)"))
            end
        end
    end
    while getgenv().configs.ZenLuckBoss do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Soul = MyInventory:FindFirstChild('Soul')
            if getgenv().configs.ObsidianBoss then
                if not Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Obsidian Golem') then
                    AttackBoss()
                end
            else
                AttackBoss()
            end
            if getgenv().configs.UseSoulKeys and Soul and Soul:FindFirstChild('Top') then
                local SoulAmount = string.match(Soul.Top.TextLabel.Text, '%d+')
                if tonumber(SoulAmount) >= 10 and not MyInventory:FindFirstChild('Soul Key') then
                    RemoteEvents['CraftItem']:FireServer(220)
                end
            end
        end
    end
end

function SpiritBoss()
    local function AttackBoss()
        local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Zenyte Golem') or Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Lucky Golem')
        if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
            if not AutoPickupOnSpiritBossDeath then
                AutoPickupOnSpiritBossDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                    if not getgenv().configs.SpiritBoss then
                        AutoPickupOnSpiritBossDeath:Disconnect()
                        AutoPickupOnSpiritBossDeath = nil
                    end
                    if not parent then
                        task.wait(0.3)
                        AutoPickupBoss()
                        if AutoPickupOnSpiritBossDeath then
                            AutoPickupOnSpiritBossDeath:Disconnect()
                            AutoPickupOnSpiritBossDeath = nil
                        end
                    end
                end)
            end
            local bosspos = Boss.HumanoidRootPart.Position
            local myroot = LocalPlayer.Character.HumanoidRootPart
            if Boss.Humanoid.Health >= 50 then
                TweenService:Create(myroot, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {CFrame = CFrame.new(bosspos + Vector3.new(-13, 18, 0))}):Play()
            else
                TweenService:Create(myroot, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(bosspos + Vector3.new(0, 22, 0))}):Play()
            end
            RemoteEvents['ToolAction']:FireServer(Boss)
        else
            if IsPlayerAlive(LocalPlayer) then
                AutoPickupBoss()
                task.wait(1)
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1663, -460, -4558)
                RemoteEvents['KeyDoor']:FireServer(Workspace:WaitForChild('Map'):WaitForChild("Mushroom Boss Cave "):WaitForChild("Cave Door (d)"))
            end
        end
    end
    while getgenv().configs.SpiritBoss do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Soul = MyInventory:FindFirstChild('Soul')
            if getgenv().configs.ObsidianBoss then
                if not Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Obsidian Golem') then
                    AttackBoss()
                end
            else
                AttackBoss()
            end
            if getgenv().configs.UseSoulKeys and Soul and Soul:FindFirstChild('Top') then
                local SoulAmount = string.match(Soul.Top.TextLabel.Text, '%d+')
                if tonumber(SoulAmount) >= 10 and not MyInventory:FindFirstChild('Soul Key') then
                    RemoteEvents['CraftItem']:FireServer(220)
                end
            end
        end
    end
end

function LuckySlime()
    while getgenv().configs.LuckySlime do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):WaitForChild('Both'):FindFirstChild('Lucky Slime')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not AutoPickuponLuckySlimeDeath then
                    AutoPickuponLuckySlimeDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                        if not getgenv().configs.LuckySlime then
                            AutoPickuponLuckySlimeDeath:Disconnect()
                            AutoPickuponLuckySlimeDeath = nil
                        end
                        if not parent then
                            task.wait(0.3)
                            AutoPickupBoss()
                            if AutoPickuponLuckySlimeDeath then
                                AutoPickuponLuckySlimeDeath:Disconnect()
                                AutoPickuponLuckySlimeDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(-8, 13.5, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 15, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            else
                task.wait(0.5)
                AutoPickupBoss()
                task.wait(2)
            end
        end
    end
end

function EvilSkeleton()
    while getgenv().configs.EvilSkeleton do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Evil Skeleton')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not AutoPickupOnSkeletonDeath then
                    AutoPickupOnSkeletonDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                        if not getgenv().configs.EvilSkeleton then
                            AutoPickupOnSkeletonDeath:Disconnect()
                            AutoPickupOnSkeletonDeath = nil
                        end
                        if not parent then
                            task.wait(0.3)
                            AutoPickupBoss()
                            if AutoPickupOnSkeletonDeath then
                                AutoPickupOnSkeletonDeath:Disconnect()
                                AutoPickupOnSkeletonDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, -15, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 17.5, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            else
                task.wait(0.5)
                AutoPickupBoss()
                task.wait(2)
            end
        end
    end
end

function Ogre()
    while getgenv().configs.Ogre do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Ogre')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not AutoPickupOnOgreDeath then
                    AutoPickupOnOgreDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                        if not getgenv().configs.Ogre then
                            AutoPickupOnOgreDeath:Disconnect()
                            AutoPickupOnOgreDeath = nil
                        end
                        if not parent then
                            task.wait(0.3)
                            AutoPickupBoss()
                            if AutoPickupOnOgreDeath then
                                AutoPickupOnOgreDeath:Disconnect()
                                AutoPickupOnOgreDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(-8, 13.5, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 15, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            else
                task.wait(0.5)
                AutoPickupBoss()
                task.wait(2)
            end
        end
    end
end

function Squid()
    while getgenv().configs.Squid do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Captain Squid')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not AutoPickupOnSquidDeath then
                    AutoPickupOnSquidDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                        if not getgenv().configs.Squid then
                            AutoPickupOnSquidDeath:Disconnect()
                            AutoPickupOnSquidDeath = nil
                        end
                        if not parent then
                            task.wait(0.3)
                            AutoPickupBoss()
                            if AutoPickupOnSquidDeath then
                                AutoPickupOnSquidDeath:Disconnect()
                                AutoPickupOnSquidDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, -15, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 17.5, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            else
                task.wait(0.5)
                AutoPickupBoss()
                task.wait(2)
            end
        end
    end
end

-- ===== Auto Repair Club (ĐÃ SỬA HOÀN CHỈNH) =====
function AutoRepairClub()
    if not getgenv().configs.AutoRepairClub then
        if getgenv().PercentChanged then
            pcall(function() getgenv().PercentChanged:Disconnect() end)
            getgenv().PercentChanged = nil
        end
        return
    end

    -- Tìm Obsidian Club
    local club = nil
    for _, tool in pairs(MyInventory:GetChildren()) do
        if tool.Name == 'Obsidian Club' then
            club = tool
            break
        end
    end

    if not club then
        Fluent:Notify({ Title = "No Club", Content = "Obsidian Club not found in inventory", Duration = 3 })
        return
    end

    -- Tìm label durability
    local label = club:FindFirstChild('Top'):FindFirstChild('Right'):FindFirstChild('Degradable'):FindFirstChild('Label')
    if not label then
        Fluent:Notify({ Title = "Error", Content = "Cannot find durability label", Duration = 3 })
        return
    end

    -- Nếu đã có connection thì không tạo mới
    if getgenv().PercentChanged then return end

    getgenv().PercentChanged = label:GetPropertyChangedSignal("Text"):Connect(function()
        if not getgenv().configs.AutoRepairClub then
            if getgenv().PercentChanged then
                pcall(function() getgenv().PercentChanged:Disconnect() end)
                getgenv().PercentChanged = nil
            end
            return
        end

        local text = label.Text
        local percentdegraded = string.sub(text, 1, 4)
        local checkdecimal = string.sub(text, 3, 3)

        if checkdecimal == '.' and tonumber(percentdegraded) <= 50.5 then
            -- Lưu trạng thái boss hiện tại
            local bossStates = {
                zen = getgenv().configs.ZenLuckBoss,
                spirit = getgenv().configs.SpiritBoss,
                obsidian = getgenv().configs.ObsidianBoss
            }

            -- Tạm dừng boss farm
            if bossStates.zen then getgenv().configs.ZenLuckBoss = false end
            if bossStates.spirit then getgenv().configs.SpiritBoss = false end
            if bossStates.obsidian then getgenv().configs.ObsidianBoss = false end

            task.wait(0.3)

            local ClosestChest = GetClosestChest()
            if ClosestChest then
                -- Sửa club bằng chest
                RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest, true, 230)
                task.wait(0.3)
                RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest, false, 230)
                Fluent:Notify({ Title = "Repaired", Content = "Club repaired via chest", Duration = 1 })
                task.wait(0.2)
            else
                -- Không có chest: teleport đến bàn craft
                if IsPlayerAlive(LocalPlayer) then
                    local oldpos = LocalPlayer.Character.HumanoidRootPart.CFrame
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(7296, 274, 18681))
                    task.wait(0.5)
                    RemoteEvents['CraftItem']:FireServer(11, Vector3.new(7303.52, 288, 18678.74), 0)
                    task.wait(0.5)
                    
                    local ClosestChest2 = GetClosestChest()
                    if ClosestChest2 then
                        RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest2, true, 230)
                        task.wait(0.3)
                        RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest2, false, 230)
                        Fluent:Notify({ Title = "Repaired", Content = "Club repaired via craft", Duration = 1 })
                        task.wait(0.2)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
                    end
                end
            end

            -- Equip lại club nếu đang equip
            pcall(function()
                if MyInventory:FindFirstChild('Obsidian Club') then
                    local equipLabel = MyInventory:FindFirstChild('Obsidian Club'):FindFirstChild('Bottom'):FindFirstChild('Equip'):FindFirstChild('TextLabel')
                    if equipLabel and equipLabel.Text == "Equip" then
                        RemoteEvents['InventoryInteraction']:FireServer(230, "Equip")
                    end
                end
            end)

            -- Bật lại boss farm
            task.wait(0.3)
            if bossStates.zen then
                getgenv().configs.ZenLuckBoss = true
                task.spawn(ZenLuckBoss)
            end
            if bossStates.spirit then
                getgenv().configs.SpiritBoss = true
                task.spawn(SpiritBoss)
            end
            if bossStates.obsidian then
                getgenv().configs.ObsidianBoss = true
                task.spawn(ObsidianBoss)
            end
        end
    end)
end

-- ===== TAB 1: Main =====
Tabs.Main:AddSection("Other Scripts")

Tabs.Main:AddButton({
    Title = "Ctrl + click TP",
    Description = "Teleport by clicking",
    Callback = function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Click%20Teleport.txt"))()
    end
})

Tabs.Main:AddButton({
    Title = "Infinite Yield",
    Description = "Admin commands",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

Tabs.Main:AddButton({
    Title = "Dark Dex",
    Description = "Explorer",
    Callback = function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
    end
})

Tabs.Main:AddButton({
    Title = "ESP",
    Description = "Wallhack",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/ESP.lua"))()
    end
})

Tabs.Main:AddButton({
    Title = "Shiftlock Mobile",
    Description = "Enables shiftlock",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/ltseverydayyou/uuuuuuu/blob/main/shiftlock?raw=true"))()
    end
})

Tabs.Main:AddSection("Anti-Cheat Bypass")

Tabs.Main:AddButton({
    Title = "AC Bypass",
    Description = "Bypass Anti-Cheat using Sonar spam",
    Callback = function()
        if not IsPlayerAlive(LocalPlayer) then
            Fluent:Notify({ Title = "Not alive", Content = "Maybe click the play button?", Duration = 5 })
            return
        end
        local oldpos = LocalPlayer.Character.HumanoidRootPart.CFrame
        local myroot = LocalPlayer.Character.HumanoidRootPart
        for i = 1, 100 do
            myroot.CFrame = CFrame.new(7562, 221, 18946)
            RemoteEvents['Sonar']:FireServer()
            myroot.CFrame = oldpos
        end
        Fluent:Notify({ Title = "Success", Content = "Bypassed AntiCheat", Duration = 4 })
    end
})

if not getgenv().bypassing then
    getgenv().bypassing = true
    local bypassac
    bypassac = hookmetamethod(game, '__namecall', function(self, ...)
        if not checkcaller() and self == RemoteEvents['Sonar'] then
            return nil
        end
        return bypassac(self, ...)
    end)
end

Tabs.Main:AddSection("Toggles")

Tabs.Main:AddToggle("KillAura", {
    Title = "Kill Aura",
    Description = "Auto attack nearest player",
    Default = false,
    Callback = function(value)
        AutoAttackPlayer = value
        if AutoAttackPlayer then
            if KillAuraLoop then return end
            KillAuraLoop = task.spawn(function()
                while AutoAttackPlayer do
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    if HumanoidRootPart then
                        local closestPlayer, closestDistance = nil, 30
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHRP = player.Character.HumanoidRootPart
                                local dist = (targetHRP.Position - HumanoidRootPart.Position).Magnitude
                                if dist <= closestDistance then
                                    closestPlayer, closestDistance = player.Character, dist
                                end
                            end
                        end
                        if closestPlayer then
                            RemoteEvents['ToolAction']:FireServer(closestPlayer)
                        end
                    end
                    task.wait(0.01)
                end
                KillAuraLoop = nil
            end)
        else
            if KillAuraLoop then task.cancel(KillAuraLoop) KillAuraLoop = nil end
        end
    end
})

Tabs.Main:AddToggle("InfJump", {
    Title = "Infinite Jump",
    Description = "Jump forever",
    Default = false,
    Callback = function(value)
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Infinite%20Jump.txt"))()
    end
})

local craftToggle = Tabs.Main:AddToggle("AutoCraft", {
    Title = "Auto Craft Closest Player [R]",
    Description = "Press R to toggle",
    Default = false,
    Callback = function(value)
        getgenv().AutoCraftClosestPlayer = value
        task.spawn(function()
            while getgenv().AutoCraftClosestPlayer do
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart then
                    local closestPlayer, closestDistance = nil, 40
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local targetHRP = player.Character.HumanoidRootPart
                            local dist = (targetHRP.Position - HumanoidRootPart.Position).Magnitude
                            if dist <= closestDistance then
                                closestPlayer, closestDistance = player.Character, dist
                            end
                        end
                    end
                    if closestPlayer then
                        local pos = closestPlayer.HumanoidRootPart.Position
                        RemoteEvents['CraftItem']:FireServer(264, vector.create(pos.X, pos.Y - 3, pos.Z), 0)
                    end
                end
                task.wait(0.5)
            end
        end)
    end
})

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.R then
        getgenv().AutoCraftClosestPlayer = not getgenv().AutoCraftClosestPlayer
        craftToggle:SetValue(getgenv().AutoCraftClosestPlayer)
    end
end)

Tabs.Main:AddToggle("HealPumpkin", {
    Title = "Spam Pumpkin If <100HP",
    Description = "Eat pumpkin when health low",
    Default = false,
    Callback = function(value)
        healingEnabled = value
        if not healingEnabled then
            healTask = nil
            return
        end
        if not healTask then
            healTask = task.spawn(function()
                while healingEnabled do
                    task.wait(0.01)
                    if not IsPlayerAlive(LocalPlayer) then break end
                    local hum = LocalPlayer.Character.Humanoid
                    if hum.Health < 100 then
                        RemoteEvents['InventoryInteraction']:FireServer(378, "Eat")
                    end
                end
            end)
        end
    end
})

Tabs.Main:AddToggle("AutoPickup", {
    Title = "Auto Pickup",
    Description = "Auto pickup items nearby",
    Default = false,
    Callback = function(value)
        getgenv().configs.AutoPickup = value
        if value then
            task.spawn(function()
                while getgenv().configs.AutoPickup do
                    AutoPickup()
                    task.wait(0.3)
                end
            end)
        end
    end
})

Tabs.Main:AddToggle("HitboxExtender", {
    Title = "Hitbox Extender",
    Description = "Enlarge enemy hitbox to 20x20x20",
    Default = false,
    Callback = function(value)
        getgenv().configs.Hitbox = value
        if value then
            task.spawn(Hitbox)
        else
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and IsPlayerAlive(plr) and plr.Character:FindFirstChild('Hitbox') then
                    plr.Character.Hitbox.Size = Vector3.new(4.9453125, 6.273651123046875, 2.0283203125)
                end
            end
        end
    end
})

Tabs.Main:AddToggle("PlayerEsp", {
    Title = "Player ESP",
    Description = "Show ESP boxes on players",
    Default = false,
    Callback = function(value)
        getgenv().configs.PlayerEsp = value
        PlayerEsp()
    end
})

Tabs.Main:AddSlider("WalkSpeed", {
    Title = "WalkSpeed",
    Description = "Adjust movement speed",
    Default = 16,
    Min = 1,
    Max = 350,
    Rounding = 1,
    Callback = function(value)
        if LocalPlayer.Character then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

Tabs.Main:AddSlider("JumpPower", {
    Title = "JumpPower",
    Description = "Adjust jump height",
    Default = 16,
    Min = 1,
    Max = 350,
    Rounding = 1,
    Callback = function(value)
        if LocalPlayer.Character then
            LocalPlayer.Character.Humanoid.JumpPower = value
        end
    end
})

-- ===== TAB 2: Duping =====
Tabs.Duping:AddSection("Start Duping")

Tabs.Duping:AddButton({
    Title = "🏁 Start Dupe",
    Description = "Begin duplication process",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", { Title = "Dupe Started", Text = "Dupe process started.", Duration = 4 })
        RemoteEvents['SetSettings']:FireServer(RemoteEvents['SetSettings'])
    end
})

local function createPackButton(tab, name, itemID, count, putOut)
    tab:AddButton({
        Title = name,
        Description = (putOut and "PutOut " or "PutIn ") .. count .. "x",
        Callback = function()
            local chest = GetClosestChest()
            if not chest then return end
            for i = 1, count do
                RemoteEvents['UpdateStorageChest']:FireServer(chest, not putOut, itemID)
            end
        end
    })
end

Tabs.Duping:AddSection("Packs")
createPackButton(Tabs.Duping, "Snow Pack 500x", 346, 500, false)
createPackButton(Tabs.Duping, "PutOut Snow Pack 500x", 346, 500, true)
createPackButton(Tabs.Duping, "Candy Poion 500x", 372, 500, false)
createPackButton(Tabs.Duping, "PutOut Candy Poion 500x", 372, 500, true)
createPackButton(Tabs.Duping, "Chest pack 500x", 382, 500, false)
createPackButton(Tabs.Duping, "Putout Chest pack 25x", 382, 25, true)
createPackButton(Tabs.Duping, "Candypack 500x 😊", 188, 500, false)
createPackButton(Tabs.Duping, "PutOut Candypack 500x 😊", 188, 500, true)
createPackButton(Tabs.Duping, "Fruit pack 25x", 325, 25, false)
createPackButton(Tabs.Duping, "PutOut Fruit pack 25x", 325, 25, true)
createPackButton(Tabs.Duping, "Prot. pack 25x", 317, 25, false)
createPackButton(Tabs.Duping, "Warr. pack 25x", 318, 25, false)

Tabs.Duping:AddButton({
    Title = "Zen Pack 500x",
    Description = "PutIn Zen",
    Callback = function()
        local localChest = Workspace.Replicators.NonPassive["Obsidian Storage Chest"]
        if not localChest then return end
        for i = 1, 500 do RemoteEvents['UpdateStorageChest']:FireServer(localChest, true, 327) end
    end
})

Tabs.Duping:AddButton({
    Title = "Diamond Pack 500x",
    Description = "PutIn Diamond",
    Callback = function()
        local localChest = Workspace.Replicators.NonPassive["Obsidian Storage Chest"]
        if not localChest then return end
        for i = 1, 500 do RemoteEvents['UpdateStorageChest']:FireServer(localChest, true, 326) end
    end
})

createPackButton(Tabs.Duping, "Fresh pack 25x", 111, 25, false)
createPackButton(Tabs.Duping, "Stone pack 25x", 112, 25, false)

Tabs.Duping:AddButton({
    Title = "Dupe All x500",
    Description = "Multiple items",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then return end
        local ids = {203,204,216,188,325,272,301,271}
        for i = 1, 499 do
            for _, id in ipairs(ids) do RemoteEvents['UpdateStorageChest']:FireServer(chest, true, id) end
        end
    end
})

Tabs.Duping:AddButton({
    Title = "Dupe All2 x500",
    Description = "Another set",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then return end
        local ids = {112,382,378,225,226,227,228,201,202}
        for i = 1, 499 do
            for _, id in ipairs(ids) do RemoteEvents['UpdateStorageChest']:FireServer(chest, true, id) end
        end
    end
})

-- ===== TAB 3: Crazy Dupe =====
Tabs.Crazy:AddSection("Gliders 🪁")
Tabs.Crazy:AddButton({ Title = "Easter Glider", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 272) end end })
Tabs.Crazy:AddButton({ Title = "Glider", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 301) end end })

Tabs.Crazy:AddSection("Others")
Tabs.Crazy:AddButton({ Title = "Portal Book", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 313) end end })
Tabs.Crazy:AddButton({ Title = "Deflect Book", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 323) end end })
Tabs.Crazy:AddButton({ Title = "Freezio Book", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 310) end end })
Tabs.Crazy:AddButton({ Title = "Oofio Book", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 309) end end })
Tabs.Crazy:AddButton({ Title = "Pumpkin Shield 10x", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then for i=1,10 do RemoteEvents['UpdateStorageChest']:FireServer(c, true, 379) end end end })
createPackButton(Tabs.Crazy, "Easter Candy 500x", 271, 500, false)
createPackButton(Tabs.Crazy, "PutOut Easter Candy 500x", 271, 500, true)
createPackButton(Tabs.Crazy, "Pumpkin 500x", 378, 500, false)
createPackButton(Tabs.Crazy, "PutOut Pumpkin 500x", 378, 500, true)
createPackButton(Tabs.Crazy, "Hard Chest 25x", 168, 25, false)
createPackButton(Tabs.Crazy, "PutOut Hard Chest 25x", 168, 25, true)

-- ===== TAB 4: Armor and Weapons =====
Tabs.Armor:AddSection("Armor")
Tabs.Armor:AddButton({ Title = "🌋 Dupe Obsidian Armor", Description = "Full set", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({225,226,227,228,235}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "🦴 Soul Duping", Description = "Soul items", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({204,202,201,203,218,216}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "MoonStone Set Duping", Description = "Moon set", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({369,366,365,364,363}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "Starter Pack Duping", Description = "Starter", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({354,355,356,357,358,359}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })

Tabs.Armor:AddSection("Sword And Bow")
Tabs.Armor:AddButton({ Title = "MoonSword And ObClub", Description = "Weapons", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({369,230}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "MoonBow, ZenBow And DiaBow", Description = "Bows", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({199,198,376}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "Vision Staff", Description = "Staff", Callback = function() local c=GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 293) end end })

-- ===== TAB 5: Open and Drop =====
Tabs.OpenDrop:AddSection("Open Chest")
Tabs.OpenDrop:AddButton({ Title = "Open Easy Chest", Description = "Open", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(166, "Open") end })
Tabs.OpenDrop:AddButton({ Title = "Open Medium Chest", Description = "Open", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(167, "Open") end })
Tabs.OpenDrop:AddButton({ Title = "Open Hard Chest", Description = "Open", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(168, "Open") end })

Tabs.OpenDrop:AddSection("Teleport")
Tabs.OpenDrop:AddButton({ Title = "Leaderboard Place", Description = "TP to coords", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5313,4,-5508) end end })

Tabs.OpenDrop:AddSection("Drop")
local function dropButton(title, id)
    Tabs.OpenDrop:AddButton({ Title = title, Description = "Drop", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(id, "Drop") end })
end
dropButton("Glider", 301)
dropButton("Candy Pack", 188)
dropButton("Warrior Pack", 318)
dropButton("Fruit Pack", 325)
dropButton("Chest Pack", 382)
dropButton("Drop Easy Chest", 166)
dropButton("Drop Medium Chest", 167)
dropButton("Drop Hard Chest", 168)
dropButton("Drop Lunar Arrow", 377)
dropButton("Ob Snowball", 352)

-- ===== TAB 6: Other =====
Tabs.Other:AddSection("Moon And Ob")
createPackButton(Tabs.Other, "Volcanic Ore x200", 223, 200, false)
createPackButton(Tabs.Other, "Obsidian x200", 224, 200, false)
createPackButton(Tabs.Other, "Lunar Ore x200", 360, 200, false)
createPackButton(Tabs.Other, "PutOut Lunar Ore x200", 360, 200, true)
createPackButton(Tabs.Other, "MoonStone x200", 361, 200, false)
createPackButton(Tabs.Other, "jack lantern", 337, 200, false)

Tabs.Other:AddButton({
    Title = "Snowball Drop",
    Description = "Drop many",
    Callback = function()
        local c = GetClosestChest()
        if not c then return end
        local ids = {352,353}
        for i=1,500 do
            for _,id in ipairs(ids) do RemoteEvents['UpdateStorageChest']:FireServer(c, false, id) end
        end
    end
})

Tabs.Other:AddSection("Spawn And Craft")
Tabs.Other:AddButton({
    Title = "Craft Pumpshield",
    Description = "Load pump script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/pump"))()
    end
})

-- ===== TAB 7: Autofarm =====
Tabs.Autofarm:AddSection("Tree Farm")

Tabs.Autofarm:AddToggle("ConiferFarm", {
    Title = "🌲 Conifer Farm",
    Description = "Auto chop Conifer trees",
    Default = false,
    Callback = function(value)
        getgenv().configs.ConiferFarm = value
        if value then task.spawn(ConiferFarm) end
    end
})

Tabs.Autofarm:AddSection("Boss Farm")

Tabs.Autofarm:AddToggle("ObsidianBoss", {
    Title = "🪨 Obsidian Golem",
    Description = "Auto farm Obsidian Golem boss",
    Default = false,
    Callback = function(value)
        getgenv().configs.ObsidianBoss = value
        if value then task.spawn(ObsidianBoss) end
    end
})

Tabs.Autofarm:AddToggle("ZenLuckBoss", {
    Title = "🍀 Zen/Lucky Golem",
    Description = "Auto farm Zenyte or Lucky Golem",
    Default = false,
    Callback = function(value)
        getgenv().configs.ZenLuckBoss = value
        if value then task.spawn(ZenLuckBoss) end
    end
})

Tabs.Autofarm:AddToggle("SpiritBoss", {
    Title = "👻 Spirit Boss",
    Description = "Auto farm Spirit Boss",
    Default = false,
    Callback = function(value)
        getgenv().configs.SpiritBoss = value
        if value then task.spawn(SpiritBoss) end
    end
})

Tabs.Autofarm:AddToggle("LuckySlime", {
    Title = "🟢 Lucky Slime",
    Description = "Auto farm Lucky Slime",
    Default = false,
    Callback = function(value)
        getgenv().configs.LuckySlime = value
        if value then task.spawn(LuckySlime) end
    end
})

Tabs.Autofarm:AddToggle("EvilSkeleton", {
    Title = "💀 Evil Skeleton",
    Description = "Auto farm Evil Skeleton",
    Default = false,
    Callback = function(value)
        getgenv().configs.EvilSkeleton = value
        if value then task.spawn(EvilSkeleton) end
    end
})

Tabs.Autofarm:AddToggle("Ogre", {
    Title = "👹 Ogre",
    Description = "Auto farm Ogre",
    Default = false,
    Callback = function(value)
        getgenv().configs.Ogre = value
        if value then task.spawn(Ogre) end
    end
})

Tabs.Autofarm:AddToggle("Squid", {
    Title = "🦑 Captain Squid",
    Description = "Auto farm Captain Squid",
    Default = false,
    Callback = function(value)
        getgenv().configs.Squid = value
        if value then task.spawn(Squid) end
    end
})

Tabs.Autofarm:AddSection("Auto Repair")

Tabs.Autofarm:AddToggle("AutoRepairClub", {
    Title = "🔧 Auto Repair Club",
    Description = "Auto repair Obsidian Club when durability < 50%",
    Default = false,
    Callback = function(value)
        getgenv().configs.AutoRepairClub = value
        if value then
            task.spawn(AutoRepairClub)
        else
            if getgenv().PercentChanged then
                pcall(function() getgenv().PercentChanged:Disconnect() end)
                getgenv().PercentChanged = nil
            end
        end
    end
})

Tabs.Autofarm:AddToggle("UseSoulKeys", {
    Title = "🔑 Use Soul Keys",
    Description = "Auto craft Soul Keys when have 10+ souls",
    Default = false,
    Callback = function(value)
        getgenv().configs.UseSoulKeys = value
    end
})

Tabs.Autofarm:AddSection("Auto Eat")

Tabs.Autofarm:AddToggle("AutoEat", {
    Title = "🍽️ Auto Eat",
    Description = "Auto eat food when hungry/low health",
    Default = false,
    Callback = function(value)
        getgenv().configs.AutoEat = value
        if value then
            task.spawn(AutoEat)
        end
    end
})

Tabs.Autofarm:AddDropdown("EatingType", {
    Title = "Eating Type",
    Description = "AFK = eat when hungry, War = eat when low health",
    Values = {"AFK", "War"},
    Default = 1,
    Callback = function(value)
        getgenv().configs.EatingType = value
    end
})

-- ===== TAB 8: Auto Sell =====
Tabs.Sell:AddSection("Auto Sell Items")

Tabs.Sell:AddToggle("SellSilverBar", {
    Title = "4 Silver Bar = 1 Token",
    Description = "Auto sell silver bars",
    Default = false,
    Callback = function(value)
        _G.SellSilver = value
        if _G.SellSilver then
            task.spawn(function()
                while _G.SellSilver do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 14)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellSlimeBall", {
    Title = "40 Slime Ball = 1 Token",
    Description = "Auto sell slime balls",
    Default = false,
    Callback = function(value)
        _G.SellSlime = value
        if _G.SellSlime then
            task.spawn(function()
                while _G.SellSlime do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 15)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellGoldBar", {
    Title = "2 Gold Bar = 1 Token",
    Description = "Auto sell gold bars",
    Default = false,
    Callback = function(value)
        _G.SellGold = value
        if _G.SellGold then
            task.spawn(function()
                while _G.SellGold do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 16)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellRuby", {
    Title = "1 Ruby = 3 Token",
    Description = "Auto sell rubies",
    Default = false,
    Callback = function(value)
        _G.SellRuby = value
        if _G.SellRuby then
            task.spawn(function()
                while _G.SellRuby do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 17)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellDiamond", {
    Title = "1 Diamond = 4 Token",
    Description = "Auto sell diamonds",
    Default = false,
    Callback = function(value)
        _G.SellDiamonds = value
        if _G.SellDiamonds then
            task.spawn(function()
                while _G.SellDiamonds do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 18)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellSoul", {
    Title = "1 Soul = 5 Token",
    Description = "Auto sell souls",
    Default = false,
    Callback = function(value)
        _G.SellSouls = value
        if _G.SellSouls then
            task.spawn(function()
                while _G.SellSouls do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 22)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellZenyte", {
    Title = "1 Zenyte = 6 Token",
    Description = "Auto sell zenyte",
    Default = false,
    Callback = function(value)
        _G.SellZenyte = value
        if _G.SellZenyte then
            task.spawn(function()
                while _G.SellZenyte do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 19)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellVolcanicOre", {
    Title = "1 Volcanic Ore = 15 Token",
    Description = "Auto sell volcanic ore",
    Default = false,
    Callback = function(value)
        _G.SellVolcanicOre = value
        if _G.SellVolcanicOre then
            task.spawn(function()
                while _G.SellVolcanicOre do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 23)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellObsidian", {
    Title = "1 Obsidian = 20 Token",
    Description = "Auto sell obsidian",
    Default = false,
    Callback = function(value)
        _G.SellObsidian = value
        if _G.SellObsidian then
            task.spawn(function()
                while _G.SellObsidian do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 24)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellLunar", {
    Title = "1 Lunar Ore = 25 Token",
    Description = "Auto sell lunar ore",
    Default = false,
    Callback = function(value)
        _G.SellLunarOre = value
        if _G.SellLunarOre then
            task.spawn(function()
                while _G.SellLunarOre do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 25)
                end
            end)
        end
    end
})

Tabs.Sell:AddToggle("SellMoonstone", {
    Title = "1 Moonstone = 30 Token",
    Description = "Auto sell moonstone",
    Default = false,
    Callback = function(value)
        _G.SellMoonstone = value
        if _G.SellMoonstone then
            task.spawn(function()
                while _G.SellMoonstone do
                    task.wait(1)
                    RemoteEvents['TradeTrader']:FireServer("Resource Trader", 26)
                end
            end)
        end
    end
})

-- Armor Trader
Tabs.Sell:AddSection("Armor Trader")

local armorItems = {
    {"Ruby Shield", 27}, {"Diamond Shield", 28}, {"Zenyte Shield", 29},
    {"Obsidian Shield", 30}, {"Ruby Helmet", 31}, {"Ruby Body", 32},
    {"Ruby Legs", 33}, {"Ruby Boots", 34}, {"Diamond Helmet", 35},
    {"Diamond Body", 36}, {"Diamond Legs", 37}, {"Diamond Boots", 38},
    {"Zenyte Helmet", 39}, {"Zenyte Body", 40}, {"Zenyte Legs", 41},
    {"Zenyte Boots", 42}, {"Obsidian Helmet", 43}, {"Obsidian Body", 44},
    {"Obsidian Legs", 45}, {"Obsidian Boots", 46}, {"Moonstone Helmet", 47},
    {"Moonstone Body", 48}, {"Moonstone Legs", 49}, {"Moonstone Boots", 50},
    {"Springy Boots", 51}
}

for _, item in ipairs(armorItems) do
    Tabs.Sell:AddButton({
        Title = item[1],
        Description = "Buy from Armor Trader",
        Callback = function()
            RemoteEvents['TradeTrader']:FireServer("Armour Trader", item[2])
        end
    })
end

-- Weapon Trader
Tabs.Sell:AddSection("Weapon Trader")

local weaponItems = {
    {"Silver Sword", 11}, {"Gold Sword", 12}, {"Gold Bow", 13},
    {"Ruby Sword", 14}, {"Diamond Sword", 15}, {"Zenyte Sword", 17},
    {"Diamond Crossbow", 16}, {"Zenyte Crossbow", 18}, {"Obsidian Club", 19},
    {"Moonstone Sword", 20}
}

for _, item in ipairs(weaponItems) do
    Tabs.Sell:AddButton({
        Title = item[1],
        Description = "Buy from Weapon Trader",
        Callback = function()
            RemoteEvents['TradeTrader']:FireServer("Weapon Trader", item[2])
        end
    })
end

-- ===== TAB 9: Player Mods =====
local PlayerTab = Tabs.Player

-- Player Modifications
PlayerTab:AddSection("Player Modifications")

PlayerTab:AddToggle("InfJump", {
    Title = "Inf-Jump",
    Description = "Infinite jump",
    Default = false,
    Callback = function(value)
        getgenv().configs.InfJump = value
        if value then
            InfJump()
        else
            if getgenv().InfiniteJump then
                pcall(function() getgenv().InfiniteJump:Disconnect() end)
                getgenv().InfiniteJump = nil
            end
        end
    end
})

PlayerTab:AddToggle("AntiRagDoll", {
    Title = "Anti-Ragdoll",
    Description = "Prevents ragdoll",
    Default = false,
    Callback = function(value)
        getgenv().configs.AntiRagDoll = value
        if getgenv().configs.AntiRagDoll then
            if not getgenv().RagDollBypass then
                getgenv().RagDollBypass = LocalPlayer.Character:WaitForChild('Humanoid').StateChanged:Connect(function()
                    if not getgenv().configs.AntiRagDoll then
                        getgenv().RagDollBypass:Disconnect()
                        getgenv().RagDollBypass = nil
                        return
                    end
                    if IsPlayerAlive(LocalPlayer) then
                        if LocalPlayer.Character:WaitForChild('Humanoid'):GetState() == Enum.HumanoidStateType.Physics then
                            LocalPlayer.Character.Humanoid:ChangeState(2)
                        end
                    end
                end)
            end
        else
            if getgenv().RagDollBypass then
                getgenv().RagDollBypass:Disconnect()
                getgenv().RagDollBypass = nil
            end
        end
    end
})

PlayerTab:AddKeybind("QuickSpeed", {
    Title = "QuickSpeed",
    Description = "Hold key to boost speed",
    Default = "B",
    Mode = "Hold",
    Callback = function(key)
        getgenv().QuickSpeedKey = key
    end,
    KeyPressed = function()
        while UserInputService:IsKeyDown(getgenv().QuickSpeedKey) and not UserInputService:GetFocusedTextBox() do
            task.wait()
            if IsPlayerAlive(LocalPlayer) then
                if LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    LocalPlayer.Character:TranslateBy(LocalPlayer.Character.Humanoid.MoveDirection * (getgenv().QuickSpeedMultiplier * 0.50))
                end
            end
        end
    end
})

PlayerTab:AddSlider("QuickSpeedMultiplier", {
    Title = "QuickSpeed multiplier",
    Description = "Speed multiplier for QuickSpeed",
    Default = 1,
    Min = 1,
    Max = 20,
    Rounding = 0,
    Callback = function(value)
        getgenv().QuickSpeedMultiplier = value
    end
})

PlayerTab:AddSlider("SwimSpeed", {
    Title = "Swim Speed",
    Description = "Adjust swim speed",
    Default = 14,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        local Constants = require(ReplicatedStorage:WaitForChild('References'):WaitForChild('SharedData'):WaitForChild('CONSTANTS'))
        Constants.WALK_SPEEDS.SWIM = value
    end
})

PlayerTab:AddToggle("JumpPower", {
    Title = "Jump Power",
    Description = "Set jump power to 100",
    Default = false,
    Callback = function(value)
        getgenv().configs.JumpPower = value
        if value then task.spawn(JumpPower) end
    end
})

PlayerTab:AddToggle("SneakySpeed", {
    Title = "Sneaky Speed",
    Description = "Set walkspeed to 21",
    Default = false,
    Callback = function(value)
        getgenv().configs.ExtraSpeed = value
        if value then 
            task.spawn(ExtraSpeed) 
        else
            if IsPlayerAlive(LocalPlayer) then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end
    end
})

-- Misc Mods
PlayerTab:AddSection("Misc Mods")

PlayerTab:AddButton({
    Title = "Get Map Candy (OP)",
    Description = "Auto pickup all candies on map",
    Callback = function()
        function GetCandy()
            for _, candy in pairs(Workspace:GetDescendants()) do
                if candy.Name == 'Candy' then
                    repeat task.wait()
                        local CandyPos = candy:GetPivot().Position
                        if IsPlayerAlive(LocalPlayer) then
                            if candy.Parent then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(CandyPos + Vector3.new(0, 2, 0))
                                RemoteEvents['ItemInteracted']:FireServer(candy, "Pickup")
                            end
                        end
                    until not candy.Parent or not IsPlayerAlive(LocalPlayer)
                end
            end
        end
        GetCandy()
        if not Workspace:FindFirstChild('Candy', true) then
            Fluent:Notify({ Title = "No Candies", Content = "No candies left in the map", Duration = 3 })
        end
    end
})

-- Glider Mod
if MyInventory:FindFirstChild("Glider") or MyInventory:FindFirstChild("Easter Glider") then
    PlayerTab:AddToggle("GliderModSpeedToggle", {
        Title = "Mod Glider Speed",
        Description = "Toggle glider speed mod",
        Default = false,
        Callback = function(value)
            local GliderModule = require(LocalPlayer:WaitForChild('PlayerScripts'):WaitForChild('Main'):WaitForChild('ToolController'):WaitForChild('ToolObject'):WaitForChild('Controllers'):WaitForChild('Glider'))
            if value then
                setconstant(GliderModule.Step, 9, tonumber(getgenv().GliderModSpeed))
            else
                setconstant(GliderModule.Step, 9, 30)
            end
        end
    })
    
    PlayerTab:AddSlider("GliderModSpeed", {
        Title = "Glider Speed Value",
        Description = "Speed for glider",
        Default = 30,
        Min = 30,
        Max = 300,
        Rounding = 0,
        Callback = function(value)
            getgenv().GliderModSpeed = value
        end
    })
end

PlayerTab:AddButton({
    Title = "Restore Candy Mesh",
    Description = "Fix invisible candies",
    Callback = function()
        local CheckPassiveOrNonPassive = Workspace:FindFirstChild("Replicators"):FindFirstChild('NonPassive') and 'NonPassive' or 'Passive'
        for _, candy in pairs(Workspace:GetDescendants()) do
            if candy.Name == 'Candy' and candy:FindFirstChildOfClass('MeshPart') then
                candy.PrimaryPart.MeshId = 'rbxassetid://4018923852'
            end
        end
        if not getgenv().CandyAdded then
            getgenv().CandyAdded = Workspace:WaitForChild('Replicators')[CheckPassiveOrNonPassive].ChildAdded:Connect(function(candie)
                task.wait(0.1)
                if candie.Name == 'Pile of Candy' then
                    for _, multicandy in pairs(candie:FindFirstChildOfClass('Model'):GetChildren()) do
                        multicandy.MeshId = 'rbxassetid://4018923852'
                    end
                elseif candie.Name == 'Candy' and candie:FindFirstChildOfClass('MeshPart') then
                    candie.PrimaryPart.MeshId = 'rbxassetid://4018923852'
                end
            end)
            getgenv().CandyAdded2 = Workspace.ChildAdded:Connect(function(candie)
                task.wait(0.1)
                if candie.Name == 'Candy' and candie:FindFirstChildOfClass('MeshPart') then
                    candie.PrimaryPart.MeshId = 'rbxassetid://4018923852'
                end
            end)
        end
        Fluent:Notify({ Title = "Restored mesh", Content = "Candies should now be visible", Duration = 3 })
    end
})

PlayerTab:AddButton({
    Title = "Drive in water",
    Description = "Allow cart to drive on water",
    Callback = function()
        local Cart = require(LocalPlayer:WaitForChild('PlayerScripts'):WaitForChild('Main'):WaitForChild('Vehicle'):WaitForChild('Cart'))
        Cart.TerrainCheck = function()
            return false 
        end
        Fluent:Notify({ Title = "Success", Content = "Cart can now drive on water", Duration = 2 })
    end
})

-- Player TP
PlayerTab:AddParagraph({
    Title = "Player TP",
    Content = "Enter username in the box below then click button"
})

PlayerTab:AddButton({
    Title = "TP to Player",
    Description = "Click to open input box",
    Callback = function()
        local inputBox = Instance.new("TextBox")
        inputBox.Size = UDim2.new(0, 200, 0, 30)
        inputBox.PlaceholderText = "Enter username"
        inputBox.Text = ""
        inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        inputBox.BorderSizePixel = 0
        inputBox.Font = Enum.Font.Gotham
        inputBox.TextSize = 14
        inputBox.Parent = LocalPlayer.PlayerGui
        
        local confirmBtn = Instance.new("TextButton")
        confirmBtn.Size = UDim2.new(0, 80, 0, 30)
        confirmBtn.Position = UDim2.new(0, 210, 0, 0)
        confirmBtn.Text = "TP"
        confirmBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 200)
        confirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        confirmBtn.BorderSizePixel = 0
        confirmBtn.Font = Enum.Font.Gotham
        confirmBtn.TextSize = 14
        confirmBtn.Parent = inputBox
        
        confirmBtn.MouseButton1Click:Connect(function()
            local value = inputBox.Text
            if value == "" then 
                inputBox:Destroy()
                return 
            end
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    if string.find(plr.Name:lower(), value:lower()) or string.find(plr.DisplayName:lower(), value:lower()) then
                        if IsPlayerAlive(LocalPlayer) and IsPlayerAlive(plr) then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position)
                            Fluent:Notify({ Title = "Success", Content = "Tped to: " .. plr.Name, Duration = 3 })
                            inputBox:Destroy()
                            return
                        end
                    end
                end
            end
            Fluent:Notify({ Title = "Error", Content = "Player not found", Duration = 3 })
            inputBox:Destroy()
        end)
        
        inputBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                confirmBtn.MouseButton1Click:Fire()
            end
        end)
        
        inputBox.Position = UDim2.new(0.5, -150, 0.5, -15)
        confirmBtn.Position = UDim2.new(0, 210, 0, 0)
    end
})

-- ===== Notify & Init =====
Fluent:Notify({
    Title = "WSP",
    Content = "Made by Chungdz",
    Duration = 5
})

Window:SelectTab(1)
Fluent:Notify({
    Title = "🌴Island Tribes 🌴",
    Content = "Loaded with all features!",
    Duration = 3
})

-- ===== SaveManager =====
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("IslandTribes")
SaveManager:BuildConfigSection(Window)
InterfaceManager:BuildInterfaceSection(Window)
SaveManager:LoadAutoloadConfig()

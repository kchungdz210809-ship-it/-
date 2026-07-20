-- ===== TẢI FLUENT UI =====
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- ===== WINDOW =====
local Window = Fluent:CreateWindow({
    Title = "🌴Island Tribes 🌴",
    SubTitle = "Made by Chung credit #Chungdz",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- ===== LẤY SERVICES =====
local Workspace = game:GetService('Workspace')
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService("TweenService")
local RunService = game:GetService('RunService')
local Lighting = game:GetService('Lighting')
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

-- ===== LOCALPLAYER =====
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera
local PlayersFolder = Workspace:FindFirstChild("Replicators"):FindFirstChild('NonPassive')

-- ===== HÀM =====
function GetCharacter(playerName)
    local playerFolder = PlayersFolder:FindFirstChild(playerName)
    if playerFolder then
        return playerFolder:FindFirstChild("Character")
    else
        return nil
    end
end

function IsPlayerAlive(player)
    if player.Character and player.Character:FindFirstChild('Humanoid') and player.Character:FindFirstChild('HumanoidRootPart') and player.Character:FindFirstChild('Humanoid').Health > 0 then
        return true
    end
    return false
end

-- ===== REMOTE EVENTS =====
local RemoteEvents = {
    ToolAction = ReplicatedStorage:WaitForChild('References'):WaitForChild('Comm'):WaitForChild('Events'):WaitForChild('ToolAction');
    InventoryInteraction = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction");
    UpdateStorageChest = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("UpdateStorageChest");
    SetSettings = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("SetSettings");
    BuyWorldEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent");
    ItemInteracted = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ItemInteracted");
    CraftItem = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("CraftItem");
    TradeTrader = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("TradeTrader");
    KeyDoor = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("KeyDoor");
    Sonar = ReplicatedStorage:WaitForChild('References'):WaitForChild('Comm'):WaitForChild('Events'):WaitForChild('Sonar');
}

-- ===== MYINVENTORY =====
local MyInventory = LocalPlayer:WaitForChild('PlayerGui'):FindFirstChild('Menus'):FindFirstChild('Inventory'):FindFirstChild('Inventory'):FindFirstChild('List')

-- ===== ALLITEMS =====
local ALLITEMS = {
    [1] = "Stick", [2] = "Small Raft", [3] = "Small Campfire", [4] = "Wood Boots",
    [5] = "Wooden Harvester", [6] = "Wood Helmet", [7] = "Wooden Club", [8] = "Leather Bag",
    [9] = "Wood Body", [10] = "Wood Legs", [11] = "Wood Storage Chest", [12] = "Wood Bridge",
    [13] = "Wood Wall", [14] = "Teepee", [15] = "Plant Box", [16] = "Hardleather Bag",
    [17] = "Stone Boots", [18] = "Stone Harvester", [19] = "Wooden Sword", [20] = "Large Campfire",
    [21] = "Stone Helmet", [22] = "Party Raft", [23] = "Wood Gate", [24] = "Reinforced Bag",
    [25] = "Stone Body", [26] = "Stone Legs", [27] = "Stone Storage Chest", [28] = "Furnace",
    [29] = "Silver Boots", [30] = "Wooden Bow", [31] = "Arrow", [32] = "Stone Wall",
    [33] = "Silver Helmet", [34] = "Stone Sword", [35] = "Fishing Rod", [36] = "Stone Gate",
    [37] = "Silver Bag", [38] = "Silver Harvester", [39] = "Silver Body", [40] = "Silver Legs",
    [41] = "Silver Storage Chest", [42] = "Ladder", [43] = "Gold Boots", [44] = "Silver Sword",
    [45] = "Stone Land Bridge", [46] = "Silver Wall", [47] = "Gold Helmet", [48] = "Bed",
    [49] = "Stone Bridge", [50] = "Silver Gate", [51] = "Golden Harvester", [52] = "Gold Body",
    [53] = "Gold Legs", [54] = "Gold Storage Chest", [55] = "Golden Bag", [56] = "Ruby Boots",
    [57] = "Golden Sword", [58] = "Gold Wall", [59] = "Ruby Helmet", [60] = "Tent Raft",
    [61] = "Golden Bow", [62] = "Gold Gate", [63] = "Ruby Harvester", [64] = "Ruby Body",
    [65] = "Ruby Legs", [66] = "Ruby Storage Chest", [67] = "Diamond Boots", [68] = "Ruby Sword",
    [69] = "Ruby Bag", [70] = "Diamond Harvester", [71] = "Diamond Helmet", [72] = "Ruby Wall",
    [73] = "Diamond Body", [74] = "Diamond Legs", [75] = "Ruby Gate", [76] = "Diamond Storage Chest",
    [77] = "Ruby Bow", [78] = "Diamond Wall", [79] = "Diamond Gate", [80] = "Diamond Bag",
    [81] = "Small Log", [82] = "Big Log", [83] = "Small Rock", [84] = "Large Rock",
    [85] = "Raw Fish", [86] = "Cooked Fish", [87] = "Raw Meat", [88] = "Cooked Meat",
    [89] = "Silver Ore", [90] = "Silver Bar", [91] = "Gold Ore", [92] = "Gold Bar",
    [93] = "Unrefined Ruby", [94] = "Ruby", [95] = "Unrefined Diamond", [96] = "Diamond",
    [97] = "Redberry", [98] = "Coconut", [99] = "Watermelon", [100] = "Watermelon Seeds",
    [101] = "Carrot", [102] = "Carrot Seeds", [103] = "Raw Potato", [104] = "Potato Seeds",
    [105] = "Banana", [106] = "Leaves", [107] = "Leather", [108] = "Feather",
    [109] = "Feather Stack", [110] = "Arrow Stack", [111] = "Freshy Chest", [112] = "Stone Supplies",
    [113] = "Wooden Warrior Pack", [114] = "Feather Pack", [115] = "Arrow Pack", [116] = "Silver Warrior Pack",
    [117] = "Fisherman's Pack", [118] = "Golden Archer Pack", [119] = "Ruby Hero Pack", [120] = "Infinite Campfire",
    [121] = "Bowling Pins", [122] = "Cabbage", [123] = "Cabbage Seeds", [124] = "Torch",
    [125] = "Tiki Torch", [126] = "Baked Potato", [127] = "Small Wood Base", [128] = "Medium Wood Base",
    [129] = "Large Wood Base", [130] = "Small Stone Base", [131] = "Medium Stone Base", [132] = "Large Stone Base",
    [133] = "Repair Hammer", [134] = "Unrefined Zenyte", [135] = "Zenyte", [136] = "Totem",
    [137] = "Caveberry", [138] = "Slime Ball", [139] = "Slime Helmet", [140] = "Slime Body",
    [141] = "Slime Legs", [142] = "Slime Boots", [143] = "Slimy Pack", [144] = "Zenyte Helmet",
    [145] = "Zenyte Body", [146] = "Zenyte Storage Chest", [147] = "Zenyte Legs", [148] = "Zenyte Boots",
    [149] = "Zenyte Wall", [150] = "Zenyte Gate", [151] = "Zenyte Bag", [152] = "Slime Club",
    [153] = "Zenyte Harvester", [154] = "Diamond Sword", [155] = "Wooden Mine Cart", [156] = "Party Cart",
    [157] = "Silver Mine Cart", [158] = "Ruby Mine Cart", [159] = "Zenyte Mine Cart", [160] = "Coal",
    [161] = "Infinite Furnace", [162] = "Beginner Wand", [163] = "Clue Scroll (Easy)", [164] = "Clue Scroll (Medium)",
    [165] = "Clue Scroll (Hard)", [166] = "Treasure Chest (Easy)", [167] = "Treasure Chest (Medium)", [168] = "Treasure Chest (Hard)",
    [169] = "Shovel", [170] = "Clue Bottle (Easy)", [171] = "Clue Bottle (Medium)", [172] = "Clue Bottle (Hard)",
    [173] = "Lucky Sword", [174] = "Lucky Bow", [175] = "Lucky Helmet", [176] = "Lucky Body",
    [177] = "Lucky Legs", [178] = "Lucky Boots", [179] = "Lucky Harvester", [180] = "Lucky Fruit",
    [181] = "Candy", [182] = "Kerosene Lamp", [183] = "Sleigh", [184] = "Magical Sleigh",
    [185] = "Grinch's Sleigh", [186] = "Candy Bag", [187] = "Pile of Candy", [188] = "Candy Pack",
    [189] = "Explorer Energy", [190] = "Cave Door Key (d)", [191] = "Key Handle (d)", [192] = "Key Shaft (d)",
    [193] = "Cave Door Key (z)", [194] = "Key Handle (z)", [195] = "Key Shaft (z)", [196] = "Stone Anvil",
    [197] = "Silver Crossbow", [198] = "Diamond Crossbow", [199] = "Zenyte Crossbow", [200] = "Soul",
    [201] = "Soul Helmet", [202] = "Soul Body", [203] = "Soul Legs", [204] = "Soul Boots",
    [205] = "Zenyte Sword", [206] = "Wooden Shield", [207] = "Silver Shield", [208] = "Golden Shield",
    [209] = "Ruby Shield", [210] = "Diamond Shield", [211] = "Zenyte Shield", [212] = "Golden Anvil",
    [213] = "Diamond Anvil", [214] = "Cave Key Pack", [215] = "OP Sword", [216] = "Soul Sword",
    [217] = "Soul Bag", [218] = "Soul Shield", [219] = "Lucky Shield", [220] = "Soul Key",
    [221] = "Pirate Ship", [222] = "Springy Boots", [223] = "Volcanic Ore", [224] = "Obsidian",
    [225] = "Obsidian Helmet", [226] = "Obsidian Body", [227] = "Obsidian Legs", [228] = "Obsidian Boots",
    [229] = "Volcanic Furnace", [230] = "Obsidian Club", [231] = "Obsidian Wall", [232] = "Obsidian Gate",
    [233] = "Obsidian Storage Chest", [234] = "Harpoon Turret", [235] = "Obsidian Shield", [236] = "Obsidian Bag",
    [237] = "Instakill Sword", [238] = "Pearl Helmet", [239] = "Pearl Body", [240] = "Pearl Legs",
    [241] = "Pearl Boots", [242] = "Raw Seaweed", [243] = "Cooked Seaweed", [244] = "Pink Shell",
    [245] = "White Shell", [246] = "Orange Shell", [247] = "Pearl", [248] = "Seaglass",
    [249] = "Seaglass Helmet", [250] = "Seaglass Body", [251] = "Seaglass Legs", [252] = "Seaglass Boots",
    [253] = "White Shell Sword", [254] = "Pink Shell Sword", [255] = "Orange Shell Sword", [256] = "White Shell Harvester",
    [257] = "Pink Shell Harvester", [258] = "Orange Shell Harvester", [259] = "Shell Helmet", [260] = "Shell Body",
    [261] = "Shell Legs", [262] = "Flippers", [263] = "Poison Seaweed", [264] = "Stone Trap",
    [265] = "Ruby Trap", [266] = "Zenyte Trap", [267] = "Pink Egg", [268] = "Purple Egg",
    [269] = "Red Egg", [270] = "Yellow Egg", [271] = "Easter Candy", [272] = "Easter Glider",
    [273] = "Repairio Spellbook", [274] = "Warrior Energy", [275] = "Protector Energy", [276] = "Magic Portal",
    [277] = "Healing Aura", [278] = "Electric Aura", [279] = "Hunger Aura", [280] = "Book of Exploration (I)",
    [281] = "Book of Exploration (II)", [282] = "Book of Exploration (III)", [283] = "Book of Protection (I)",
    [284] = "Book of Protection (II)", [285] = "Book of Protection (III)", [286] = "Book of Combat (I)",
    [287] = "Book of Combat (II)", [288] = "Book of Combat (III)", [289] = "Apprentice Wand",
    [290] = "Adept Staff", [291] = "Master Staff", [292] = "Transcended Staff", [293] = "Visionary Staff",
    [294] = "Wool", [295] = "Book", [296] = "Magical Book", [297] = "Obsidian Harvester",
    [298] = "Magic Repair Table (I)", [299] = "Magic Repair Table (II)", [300] = "Magic Repair Table (III)",
    [301] = "Glider", [302] = "Imbue Spellbook", [303] = "Shieldio Spellbook", [304] = "Hungaria Spellbook",
    [305] = "Baseio Retreatio Spellbook", [306] = "Healia Spellbook", [307] = "Deadia Protectia Spellbook",
    [308] = "Baseio Destroyio Spellbook", [309] = "Oofio Spellbook", [310] = "Freezio Spellbook",
    [311] = "Starvio Spellbook", [312] = "Electricia Spellbook", [313] = "Portalio Spellbook",
    [314] = "Protectio Claimio Spellbook", [315] = "Warrio Claimio Spellbook", [316] = "Explorer Energy Pack",
    [317] = "Protector Energy Pack", [318] = "Warrior Energy Pack", [319] = "Explorer Energy Stack",
    [320] = "Protector Energy Stack", [321] = "Warrior Energy Stack", [322] = "Infinite Bag",
    [323] = "Deflectio Projectio Spellbook", [324] = "Seed Pack", [325] = "Fruit Pack", [326] = "Diamond Hero Pack",
    [327] = "Zenyte Warrior Pack", [328] = "Box of Redberries", [329] = "Box of Coconuts", [330] = "Box of Bananas",
    [331] = "Box of Watermelons", [332] = "Potato Seed Box", [333] = "Cabbage Seed Box", [334] = "Carrot Seed Box",
    [335] = "Watermelon Seed Box", [336] = "Halloween Pumpkin", [337] = "Jack-o'-lantern", [338] = "Weak Pet Net",
    [339] = "Sturdy Pet Net", [340] = "Strong Pet Net", [341] = "Unbreakable Pet Net", [342] = "Christmas Present",
    [343] = "Snowball", [344] = "Obsidian Floor", [345] = "Pile of Snowballs", [346] = "Snowball Pack",
    [347] = "Silver Snowball", [348] = "Golden Snowball", [349] = "Ruby Snowball", [350] = "Diamond Snowball",
    [351] = "Zenyte Snowball", [352] = "Obsidian Snowball", [353] = "Candy Snowball", [354] = "Starter Sword",
    [355] = "Starter Harvester", [356] = "Starter Helmet", [357] = "Starter Body", [358] = "Starter Legs",
    [359] = "Starter Boots", [360] = "Lunar Ore", [361] = "Moonstone", [362] = "Lunario Enchantio Spellbook",
    [363] = "Moonstone Helmet", [364] = "Moonstone Body", [365] = "Moonstone Legs", [366] = "Moonstone Boots",
    [367] = "Moonstone Shield", [368] = "Moonstone Harvester", [369] = "Moonstone Sword", [370] = "Moonstone Bag",
    [371] = "Potion Cauldron", [372] = "Candy Potion", [373] = "Moonstone Storage Chest", [374] = "Moonstone Wall",
    [375] = "Moonstone Gate", [376] = "Moonstone Crossbow", [377] = "Lunar Arrow", [378] = "Pumpkin",
    [379] = "Pumpkin Shield", [380] = "Pumpkin Bag", [381] = "Pumpkin Seeds", [382] = "Treasure Chest Pack"
}

-- ===== BẢNG CHUYỂN ĐỔI =====
local ALLITEMSTABLE = {}
local SWITCHEDITEMSTABLE = {}
for id, name in pairs(ALLITEMS) do
    ALLITEMSTABLE[id] = name
    SWITCHEDITEMSTABLE[name] = id
end

-- ===== SETS =====
local MoonstoneSet = {363, 364, 365, 366}
local ObsidianSet = {225, 226, 227, 228}
local AllShields = {206, 207, 208, 209, 210, 211, 219, 235, 367, 379}
local AllSwords = {173, 205, 230, 369, 255, 254, 253}
local AllBows = {174, 197, 198, 199, 376}
local AllBooks = {281, 282, 283, 284, 285, 286, 287, 296, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 323, 362}
local AllStaffs = {293, 292, 291, 290, 162, 289}

-- ===== CONFIGS =====
getgenv().configs = {
    Bypassing = false; AutoPickup2 = false; InfJump = false; ClickTp = false;
    AutoEat = false; MineAura = false; MobAura = false; CheaterDetector = false;
    KillAura = false; PlayerLock = false; Pumpkins = false; Hitbox = false;
    SafeDeath = false; OpKillAura = false; PredictOpKillAura = false;
    AutoRepairClub = false; ConiferFarm = false; UseSoulKeys = false;
    ObsidianBoss = false; ZenLuckBoss = false; SpiritBoss = false;
    LuckySlime = false; EvilSkeleton = false; Ogre = false; Squid = false;
    JumpPower = false; AntiRagDoll = false; ExtraSpeed = false;
    AmountToLoopDrop = false; PlayerEsp = false;
    EatingType = 'AFK'; TrapType = 'Stone Trap'; LevelCheck = 'True'; ChestType = 'Any';
}
getgenv().QuickSpeedMultiplier = 1
getgenv().AmountOfChestInserts = 1
getgenv().PredictAmount = 3
getgenv().QuickSpeedKey = Enum.KeyCode.B
getgenv().QuickSpeedToggle = false
getgenv().GliderModSpeed = 30
getgenv().GliderModToggle = false

-- ===== CẤU HÌNH AIMBOT =====
getgenv().AimbotEnabled = true
getgenv().AimbotPart = "Head"
getgenv().AimbotRange = 75
getgenv().AimbotFOV = 100

-- ===== BIẾN TOÀN CỤC =====
local Whitelist_table = {}
local OpKillAuraTable = {}
local TimeTped, TimeBetweenTps, TeleportHappened = 0, 15, false
local SafeDeathHealthChecker = nil
local ItemIndexed, ItemIndexedNumber = nil, nil
local CurrentlyLocked = nil

-- ===== BYPASS AC =====
if not getgenv().bypassing then
    getgenv().bypassing = true
    local bypassac
    bypassac = hookmetamethod(game, '__namecall', function(self, ...)
        local args = {...}
        if not checkcaller() and self == RemoteEvents['Sonar'] then
            return nil
        end
        return bypassac(self, ...)
    end) 
end

-- ===== ANTI AFK =====
if not getgenv().Idling then
    getgenv().Idling = true
    LocalPlayer.Idled:connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- ===== HÀM LẤY CHEST =====
function GetClosestChest()
    local closest
    local range = math.huge
    local check = Workspace:FindFirstChild("Replicators"):FindFirstChild('NonPassive') and 'NonPassive' or 'Passive'
    if IsPlayerAlive(LocalPlayer) then
        for _, chest in pairs(Workspace:WaitForChild("Replicators")[check]:GetChildren()) do
            if string.find(chest.Name, 'Storage') and chest:FindFirstChildOfClass('MeshPart') then
                local dist = (LocalPlayer.Character:WaitForChild('HumanoidRootPart').Position - chest:FindFirstChildOfClass('MeshPart').Position).magnitude
                if dist < range then
                    range = dist
                    closest = chest
                end
            end
        end
        return closest
    end
end

-- ===== HÀM SELL =====
function SellItem(Item, SellAmount, Id)
    local GetItem = MyInventory:FindFirstChild(Item)
    if GetItem then
        local NumberOfItem = string.match(GetItem:FindFirstChild('Top'):FindFirstChild('NameLabel').Text, '%d+')
        if not NumberOfItem then
            NumberOfItem = 1
        end
        if tonumber(NumberOfItem) >= SellAmount then
            RemoteEvents['TradeTrader']:FireServer('Resource Trader', Id)
        end
    end
end

-- ===== AUTO PICKUP =====
function AutoPickup()
    local check = Workspace:FindFirstChild("Replicators"):FindFirstChild('NonPassive') and 'NonPassive' or 'Passive'
    if IsPlayerAlive(LocalPlayer) then
        local AllPickups = {}
        local mypos = LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position
        for _, item in pairs(Workspace:WaitForChild('Replicators')[check]:GetChildren()) do
            if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 18.5 and not string.find(item.Name:lower(), 'clue') then
                if table.find(ALLITEMSTABLE, item.Name) then
                    table.insert(AllPickups, item)
                end
            end
        end
        for _, item in pairs(Workspace:WaitForChild('Replicators'):WaitForChild('Both'):GetChildren()) do
            if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 18.5 and not string.find(item.Name:lower(), 'clue') then
                if table.find(ALLITEMSTABLE, item.Name) then
                    table.insert(AllPickups, item)
                end
            end
        end
        for _, item in pairs(Workspace:GetChildren()) do
            if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 18.5 and not string.find(item.Name:lower(), 'clue') then
                if table.find(ALLITEMSTABLE, item.Name) then
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

-- ===== AUTO PICKUP 2 =====
function AutoPickup2()
    if getgenv().configs.AutoPickup2 then
        if not getgenv().AutoPickingUp then
            getgenv().AutoPickingUp = Workspace.DescendantAdded:Connect(function(pickup)
                if not getgenv().configs.AutoPickup2 then
                    getgenv().AutoPickingUp:Disconnect()
                    getgenv().AutoPickingUp = nil
                    return
                end
                if not string.find(pickup.Name:lower(), 'clue') then
                    if table.find(ALLITEMSTABLE, pickup.Name) then
                        if IsPlayerAlive(LocalPlayer) then
                            local mypos = LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position
                            local itempos = pickup:GetPivot().Position
                            if (mypos - itempos).magnitude < 18.5 then
                                repeat task.wait()
                                    local mybagspace = string.split(LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('HUD'):WaitForChild('Status'):WaitForChild('Content'):WaitForChild('Bag'):WaitForChild('StatusLabel').Text, '/')
                                    if IsPlayerAlive(LocalPlayer) then
                                        if pickup.Parent then
                                            RemoteEvents['ItemInteracted']:FireServer(pickup, "Pickup")
                                        end
                                    end
                                until not pickup.Parent or (LocalPlayer.Character.HumanoidRootPart.Position - pickup:GetPivot().Position).magnitude > 18.5 or tonumber(mybagspace[1])+1 >= tonumber(mybagspace[2]) or not IsPlayerAlive(LocalPlayer) or not getgenv().configs.AutoPickup2
                            end
                        end
                    end
                end
            end)
        end
        AutoPickup()
    else
        if getgenv().AutoPickingUp then
            getgenv().AutoPickingUp:Disconnect()
            getgenv().AutoPickingUp = nil
        end
    end
end

-- ===== CLICK TP =====
function ClickTp()
    if getgenv().configs.ClickTp then
        if not getgenv().MouseClick then
            getgenv().MouseClick = UserInputService.InputBegan:Connect(function(input)
                if getgenv().configs.ClickTp then
                    if not UserInputService:GetFocusedTextBox() then
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                            if IsPlayerAlive(LocalPlayer) then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position)
                            end
                        end
                    end
                end
            end)
        end
    end
end

-- ===== AUTO EAT =====
function AutoEat()
    local function GreatestFoodSource()
        local foodtable = {}
        local highestfood
        local greatestfoodpossible = -math.huge
        for _, food in pairs(MyInventory:GetChildren()) do
            if food.Name == 'Raw Potato' or food.Name == 'Watermelon' or food.Name == 'Banana' or food.Name == 'Redberry' or food.Name == 'Coconut' or food.Name == 'Baked Potato' or food.Name == 'Carrot' or food.Name == 'Cabbage' or food.Name == 'Cooked Fish' or food.Name == 'Cooked Meat' or food.Name == 'Caveberry' or food.Name == 'Slime Ball' or food.Name == 'Lucky Fruit' then
                table.insert(foodtable, food)
            end
        end
        for _, food in pairs(foodtable) do
            local foodamount = tonumber(string.match(food:WaitForChild('Top'):WaitForChild('NameLabel').Text, '%d+'))
            if foodamount and foodamount > greatestfoodpossible then
                greatestfoodpossible = foodamount
                highestfood = food.Name
            end
        end
        return highestfood
    end
    local maxhungerbar = LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('HUD'):WaitForChild('Status'):WaitForChild('Content'):WaitForChild('Hunger'):WaitForChild('Bar').AbsoluteSize
    local subbar = LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('HUD'):WaitForChild('Status'):WaitForChild('Content'):WaitForChild('Health'):WaitForChild('Bar'):WaitForChild('Sub')
    while getgenv().configs.AutoEat do
        if getgenv().configs.AutoEat then
            task.wait()
            local Food = GreatestFoodSource()
            if Food then
                if getgenv().configs.EatingType == 'AFK' then
                    local currenthungerbar = LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('HUD'):WaitForChild('Status'):WaitForChild('Content'):WaitForChild('Hunger'):WaitForChild('Bar'):WaitForChild('Bar').AbsoluteSize
                    if IsPlayerAlive(LocalPlayer) then
                        if (maxhungerbar - currenthungerbar).magnitude >= 20.7 then
                            RemoteEvents['InventoryInteraction']:FireServer(SWITCHEDITEMSTABLE[Food], 'Eat')
                            task.wait()
                        end
                    end
                elseif getgenv().configs.EatingType == 'War' then
                    local maxsubbar = subbar.Parent.AbsoluteSize
                    if IsPlayerAlive(LocalPlayer) then
                        if (maxsubbar - subbar.AbsoluteSize).magnitude >= 20.7 then
                            RemoteEvents['InventoryInteraction']:FireServer(SWITCHEDITEMSTABLE[Food], 'Eat')
                            task.wait()
                        end
                    end
                end
            end
        end
    end
end

-- ===== MINE AURA =====
function MineAura()
    while getgenv().configs.MineAura do
        if getgenv().configs.MineAura then
            task.wait(0.3)
            if IsPlayerAlive(LocalPlayer) then
                local function getclosestore()
                    local range = 21
                    local closestore
                    for _, ore in pairs(Workspace:WaitForChild('Replicators'):WaitForChild('Both'):GetChildren()) do
                        if not string.find(ore.Name:lower(), 'slime') then
                            if Workspace:FindFirstChild("Volcanic Rock") then
                                Workspace:FindFirstChild("Volcanic Rock").Parent = Workspace:WaitForChild('Replicators'):WaitForChild('Both')
                            end
                            if ore:FindFirstChild('Health') and not ore:FindFirstChild('Humanoid') and not ore:FindFirstChild('HumanoidRootPart') then
                                local obj
                                local dist
                                obj = ore:GetPivot().Position
                                local mypos = LocalPlayer.Character.HumanoidRootPart.Position
                                dist = (mypos - obj).magnitude
                                if dist < range then
                                    if ore.Name == 'Plantain' then
                                        if ore:FindFirstChild('Tree') and ore:FindFirstChild('Tree'):FindFirstChild('Palm Tree_Trunk') then
                                            obj = Vector3.new(3378, 15, -4475)
                                        end
                                    end
                                    dist = (mypos - obj).magnitude
                                    range = dist
                                    closestore = ore
                                end
                            end
                        end
                    end
                    return closestore
                end
                local NearestOre = getclosestore()
                if NearestOre then
                    RemoteEvents['ToolAction']:FireServer(NearestOre)
                end
            end
        end
    end
end

-- ===== MOB AURA =====
function MobAura()
    while getgenv().configs.MobAura do
        if getgenv().configs.MobAura then
            task.wait(.15)
            local function getclosestmob()
                local range = 30
                local closestmob = nil
                if IsPlayerAlive(LocalPlayer) then
                    for _, mob in pairs(Workspace:WaitForChild('Replicators'):WaitForChild('Both'):GetChildren()) do
                        if mob:FindFirstChild('HumanoidRootPart') and mob:FindFirstChild('Humanoid') and mob:FindFirstChild('Humanoid').Health > 0 then
                            local mypos = LocalPlayer.Character.HumanoidRootPart.Position
                            local mobpos = mob.HumanoidRootPart.Position
                            local dist = (mypos - mobpos).magnitude
                            if dist < range then
                                range = dist
                                closestmob = mob
                            end
                        end
                    end
                end
                return closestmob
            end
            local nearestmob = getclosestmob()
            if nearestmob then
                RemoteEvents['ToolAction']:FireServer(nearestmob)
            end
        end
    end
end

-- ===== KILL AURA =====
function KillAura()
    while getgenv().configs.KillAura do
        if getgenv().configs.KillAura then
            task.wait()
            local function GetClosestKAPlayer()
                local range = 32
                local closest
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer then
                        if not table.find(Whitelist_table, plr.Name) then
                            if IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) then
                                local char = plr.Character
                                if char:FindFirstChild("PlayerBillboard") and char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title') and char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon') then
                                    if char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 == Color3.fromRGB(80, 63, 47) then
                                        local mypos = LocalPlayer.Character.HumanoidRootPart.Position
                                        local plrpos = plr.Character.HumanoidRootPart.Position
                                        local dist = (mypos - plrpos).magnitude
                                        if dist < range then
                                            range = dist
                                            closest = plr.Character
                                        end
                                    else
                                        if char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 ~= LocalPlayer.Character:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 then
                                            local mypos = LocalPlayer.Character.HumanoidRootPart.Position
                                            local plrpos = plr.Character.HumanoidRootPart.Position
                                            local dist = (mypos - plrpos).magnitude
                                            if dist < range then
                                                range = dist
                                                closest = plr.Character
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                return closest
            end
            local NearestPlayer = GetClosestKAPlayer()
            if NearestPlayer then
                RemoteEvents['ToolAction']:FireServer(NearestPlayer)
            end
        end
    end
end

-- ===== PLAYER LOCK =====
function PlayerLock()
    local function Wallcheck(target)
        local ray = Ray.new(Camera.CFrame.Position, (target.Position - Camera.CFrame.Position).Unit * 1000)
        local part, position = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character}, false, true)
        if part then
            local humanoid = part.Parent:FindFirstChildOfClass('Humanoid')
            if not humanoid then
                humanoid = part.Parent.Parent:FindFirstChildOfClass('Humanoid')
            end
            if humanoid and target and humanoid.Parent == target.Parent then
                local pos, visible = Camera:WorldToScreenPoint(target.Position)
                if visible then
                    return true
                end
            end
        end
        return false
    end
    local function GetNearestPlayerToMouse()
        if CurrentlyLocked and CurrentlyLocked.Humanoid.Health > 0 then return CurrentlyLocked end
        local dist = 150
        local closest
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                if IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) then
                    local char = plr.Character
                    local plrpos, onscreen = Camera:WorldToViewportPoint(char['HumanoidRootPart'].Position)
                    if onscreen then
                        if char:FindFirstChild("PlayerBillboard") and char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title') and char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon') then
                            if char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 == Color3.fromRGB(80, 63, 47) then
                                local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(plrpos.X, plrpos.Y)).Magnitude
                                if mag < dist and (char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude < dist then
                                    if Wallcheck(char:FindFirstChild('HumanoidRootPart')) then
                                        dist = mag
                                        closest = char
                                    end
                                end
                            else
                                if char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 ~= LocalPlayer.Character:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 then
                                    local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(plrpos.X, plrpos.Y)).Magnitude
                                    if mag < dist and (char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude < dist then
                                        if Wallcheck(char:FindFirstChild('HumanoidRootPart')) then
                                            dist = mag
                                            closest = char
                                        end
                                    end
                                end
                            end
                        end
                    end
                end     
            end
        end
        return closest
    end
    if not getgenv().Updater then
        getgenv().Updater = RunService.RenderStepped:Connect(function()
            if getgenv().configs.PlayerLock then
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                    if GetNearestPlayerToMouse() then
                        CurrentlyLocked = GetNearestPlayerToMouse()
                        local SmoothSnap = TweenService:Create(Camera, TweenInfo.new(0.01, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, CurrentlyLocked:FindFirstChild('HumanoidRootPart').Position)})
                        SmoothSnap:Play()
                        SmoothSnap.Completed:Wait()
                    end
                else
                    if CurrentlyLocked ~= nil then
                        CurrentlyLocked = nil
                    end
                end
            end
        end)
    end
end

-- ===== PUMPKINS =====
function Pumpkins()
    while getgenv().configs.Pumpkins do
        if getgenv().configs.Pumpkins then
            task.wait()
            if IsPlayerAlive(LocalPlayer) then
                local hum = LocalPlayer.Character.Humanoid
                if hum.Health < 75 then
                    RemoteEvents['InventoryInteraction']:FireServer(378, "Eat")
                end
            end
        end
    end
end

-- ===== HITBOX =====
function Hitbox()
    while getgenv().configs.Hitbox do
        if getgenv().configs.Hitbox then
            task.wait(0.2)
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    if IsPlayerAlive(plr) and plr.Character:FindFirstChild('Hitbox') then
                        if plr.Character.Hitbox.Size ~= Vector3.new(20, 20, 20) then
                            plr.Character.Hitbox.Size = Vector3.new(20, 20, 20)
                        end
                    end
                end
            end
        end
    end
end

-- ===== SAFE DEATH =====
function SafeDeath()
    if getgenv().configs.SafeDeath then
        if not SafeDeathHealthChecker then
            SafeDeathHealthChecker = LocalPlayer.Character:WaitForChild('Humanoid').HealthChanged:Connect(function(health)
                if getgenv().configs.SafeDeath then
                    if not TeleportHappened then
                        if health <= 35 then
                            getgenv().configs.ZenLuckBoss = false
                            getgenv().configs.SpiritBoss = false
                            getgenv().configs.ObsidianBoss = false
                            getgenv().configs.Ogre = false
                            getgenv().configs.Squid = false
                            getgenv().configs.LuckySlime = false
                            getgenv().configs.EvilSkeleton = false
                            local SavePlayer = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(3, Enum.EasingStyle.Linear), {CFrame = CFrame.new(Vector3.new(7135, 73, 18677))})
                            SavePlayer:Play()
                            Fluent:Notify({ Title = "You have been saved from death!", Content = "The Arc Angels have saved you! Heal Up before you go back to battle!", Duration = 7 })
                            TeleportHappened = true
                            TimeTped = tick()
                        end
                    else
                        if tick() > TimeTped + TimeBetweenTps then
                            TeleportHappened = false
                        end
                    end
                end
            end)
        end
    end
end

-- ===== OP KILL AURA =====
function OpKillAura()
    while getgenv().configs.OpKillAura do
        if getgenv().configs.OpKillAura then
            task.wait()
            if OpKillAuraTable[1] then
                if IsPlayerAlive(OpKillAuraTable[1]) and IsPlayerAlive(LocalPlayer) then
                    local myroot = LocalPlayer.Character.HumanoidRootPart
                    local enemyroot = OpKillAuraTable[1].Character.HumanoidRootPart
                    if getgenv().configs.PredictOpKillAura then
                        myroot.CFrame = CFrame.new(enemyroot.Position + (enemyroot.AssemblyLinearVelocity / getgenv().PredictAmount))
                    else
                        myroot.CFrame = CFrame.new(enemyroot.Position)
                    end
                    if LocalPlayer.Character.Humanoid.Health <= 20 then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7137, 73, 18673)
                        Fluent:Notify({ Title = "You are low!", Content = "I've saved you. Heal up.", Duration = 8 })
                        return
                    end
                    local MyYPos = LocalPlayer.Character.HumanoidRootPart.CFrame.Y
                    if MyYPos <= -800 then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7137, 73, 18673)
                        Fluent:Notify({ Title = "Suicide", Content = "Careful, he's trying to suicide you", Duration = 3 })
                        return
                    end
                    RemoteEvents['ToolAction']:FireServer(OpKillAuraTable[1].Character)
                    if not getgenv().configs.OpKillAura and LocalPlayer.Character.Humanoid.Health > 25 then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(enemyroot.Position + Vector3.new(0, 25, 0))
                    end
                end
            end
        end
    end
end

-- ===== CONIFER FARM =====
function ConiferFarm()
    local function GetClosestTree()
        local range = math.huge
        local closesttree
        for _, tree in pairs(Workspace:WaitForChild('Replicators'):WaitForChild('Both'):GetChildren()) do
            if tree.Name == 'Conifer' then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - tree:GetPivot().Position).magnitude
                if dist < range then
                    range = dist
                    closesttree = tree
                end
            end
        end
        return closesttree
    end

    local function TreeFarm()
        local ClosestTree
        ClosestTree = GetClosestTree()
        if ClosestTree then
            repeat task.wait()
                ClosestTree = GetClosestTree()
                if not getgenv().configs.ConiferFarm then 
                    if IsPlayerAlive(LocalPlayer) then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.X + 10, LocalPlayer.Character.HumanoidRootPart.CFrame.Y, LocalPlayer.Character.HumanoidRootPart.CFrame.Z - 10)
                    end
                    return
                end
                if ClosestTree.Parent then
                    if IsPlayerAlive(LocalPlayer) then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ClosestTree:GetPivot().Position)
                        RemoteEvents['ToolAction']:FireServer(ClosestTree)
                    end
                end
            until not ClosestTree.Parent or not IsPlayerAlive(LocalPlayer) or not getgenv().configs.ConiferFarm
        end
    end
    while getgenv().configs.ConiferFarm and task.wait() do
        if not getgenv().configs.ConiferFarm then 
            if IsPlayerAlive(LocalPlayer) then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.X + 10, LocalPlayer.Character.HumanoidRootPart.CFrame.Y, LocalPlayer.Character.HumanoidRootPart.CFrame.Z - 10)
            end
        end
        if IsPlayerAlive(LocalPlayer) then
            if not Workspace:WaitForChild('Replicators'):WaitForChild('Both'):FindFirstChild('Conifer') then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.X, 400, LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
            else
                TreeFarm()
            end
        end
    end
end

-- ===== AUTO REPAIR CLUB =====
function AutoRepairClub()
    if getgenv().configs.AutoRepairClub then
        local zenwastrue = false
        local spiritwastrue = false
        local obwastrue = false
        for _, tool in pairs(MyInventory:GetChildren()) do
            if tool.Name == 'Obsidian Club' then
                if not getgenv().PercentChanged then
                    getgenv().PercentChanged = tool:FindFirstChild('Top'):FindFirstChild('Right'):FindFirstChild('Degradable'):FindFirstChild('Label'):GetPropertyChangedSignal("Text"):Connect(function()
                        if not getgenv().configs.AutoRepairClub then
                            getgenv().PercentChanged:Disconnect()
                            getgenv().PercentChange = nil
                            return
                        end
                        local percentdegraded = tool:FindFirstChild('Top'):FindFirstChild('Right'):FindFirstChild('Degradable'):FindFirstChild('Label').Text:sub(1, 4)
                        local checkdecimal = tool:FindFirstChild('Top'):FindFirstChild('Right'):FindFirstChild('Degradable'):FindFirstChild('Label').Text:sub(3, 3)
                        if checkdecimal == '.' then
                            if tonumber(percentdegraded) <= 50.5 then
                                local ClosestChest = GetClosestChest()
                                if ClosestChest then
                                    RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest, true, 230)
                                    RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest, false, 230)
                                    Fluent:Notify({ Title = "Repaired", Content = "Club repaired", Duration = 1 })
                                    task.wait(0.2)
                                    pcall(function()
                                        if MyInventory:FindFirstChild('Obsidian Club') then
                                            if MyInventory:FindFirstChild('Obsidian Club'):FindFirstChild('Bottom'):FindFirstChild('Equip'):FindFirstChild('TextLabel').Text == "Equip" then
                                                RemoteEvents['InventoryInteraction']:FireServer(230, "Equip")
                                            end
                                        end
                                    end)
                                else
                                    if getgenv().configs.ZenLuckBoss then
                                        zenwastrue = true
                                        getgenv().configs.ZenLuckBoss = false
                                    elseif getgenv().configs.SpiritBoss then
                                        spiritwastrue = true
                                        getgenv().configs.SpiritBoss = false
                                    elseif getgenv().configs.ObsidianBoss then
                                        obwastrue = true
                                        getgenv().configs.ObsidianBoss = false
                                    end
                                    if IsPlayerAlive(LocalPlayer) then
                                        task.wait(0.2)
                                        local oldpos = LocalPlayer.Character.HumanoidRootPart.CFrame
                                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(7296, 274, 18681))
                                        task.wait(0.5)
                                        RemoteEvents['CraftItem']:FireServer(11, Vector3.new(7303.52, 288, 18678.74), 0)
                                        task.wait(0.5)
                                        local ClosestChest = GetClosestChest()
                                        if ClosestChest then
                                            RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest, true, 230)
                                            RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest, false, 230)
                                            Fluent:Notify({ Title = "Repaired", Content = "Club repaired", Duration = 1 })
                                            task.wait(0.2)
                                            pcall(function()
                                                if MyInventory:FindFirstChild('Obsidian Club') then
                                                    if MyInventory:FindFirstChild('Obsidian Club'):FindFirstChild('Bottom'):FindFirstChild('Equip'):FindFirstChild('TextLabel').Text == "Equip" then
                                                        RemoteEvents['InventoryInteraction']:FireServer(230, "Equip")
                                                    end
                                                end
                                            end)
                                            if zenwastrue then
                                                zenwastrue = false
                                                task.spawn(function()
                                                    getgenv().configs.ZenLuckBoss = true
                                                    ZenLuckBoss()
                                                end)
                                            elseif spiritwastrue then
                                                spiritwastrue = false
                                                task.spawn(function()
                                                    getgenv().configs.SpiritBoss = true
                                                    SpiritBoss()
                                                end)
                                            elseif obwastrue then
                                                obwastrue = false
                                                task.spawn(function()
                                                    getgenv().configs.ObsidianBoss = true
                                                    ObsidianBoss()
                                                end)
                                            else
                                                LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end
    else
        if getgenv().PercentChanged then
            getgenv().PercentChanged:Disconnect()
            getgenv().PercentChanged = nil
        end
    end
end

-- ===== TRAP PLAYER =====
function TrapPlayer()
    if IsPlayerAlive(LocalPlayer) then
        local function GetClosestTrapPlayer()
            local range = 70
            local closest = nil
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) then
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude
                    if plr.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        if dist < range then
                            range = dist
                            closest = (plr.Character.LeftFoot.Position + plr.Character.HumanoidRootPart.AssemblyLinearVelocity) + Vector3.new(0, 1, 0)
                        end
                    else
                        if dist < range then
                            range = dist
                            closest = (plr.Character.LeftFoot.Position) + Vector3.new(0, 1, 0)
                        end
                    end
                end
            end
            return closest
        end
        RemoteEvents['CraftItem']:FireServer(SWITCHEDITEMSTABLE[getgenv().configs.TrapType], GetClosestTrapPlayer(), 690)
    end
end

-- ===== OBSIDIAN BOSS =====
function ObsidianBoss()
    while getgenv().configs.ObsidianBoss do
        if getgenv().configs.ObsidianBoss then
            task.wait()
            if getgenv().configs.KillAura == true then
                getgenv().configs.KillAura = false
            end
            if IsPlayerAlive(LocalPlayer) then
                local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Obsidian Golem')
                if not getgenv().configs.ZenLuckBoss and not getgenv().configs.SpiritBoss then
                    if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                        if not AutoPickupOnObsidianDeath then
                            AutoPickupOnObsidianDeath = Boss.AncestryChanged:Connect(function(golem, parent)
                                if not getgenv().configs.ObsidianBoss then
                                    AutoPickupOnObsidianDeath:Disconnect()
                                    AutoPickupOnObsidianDeath = nil
                                end
                                if not parent then
                                    task.wait(0.2)
                                    AutoPickup()
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
                    end
                end
            end
        end
    end
end

-- ===== ZEN LUCK BOSS =====
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
                        task.wait(0.2)
                        AutoPickup()
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
            if not AutoPickupOnZenLuckBossDeath then
                task.wait(1)
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1663, -460, -4558)
                RemoteEvents['KeyDoor']:FireServer(Workspace:WaitForChild('Map'):WaitForChild("Zenyte Boss Cave"):WaitForChild("Cave Door (z)"))
            end
        end
    end
    while getgenv().configs.ZenLuckBoss do
        if getgenv().configs.ZenLuckBoss then
            task.wait()
            if getgenv().configs.KillAura == true then
                getgenv().configs.KillAura = false
            end
            if IsPlayerAlive(LocalPlayer) then
                local Soul = MyInventory:FindFirstChild('Soul')
                if Workspace:WaitForChild('Map'):WaitForChild("Zenyte Boss Cave"):FindFirstChild("Gem Clusters") then
                    Workspace:WaitForChild('Map'):WaitForChild("Zenyte Boss Cave"):FindFirstChild("Gem Clusters"):Destroy()
                end
                if getgenv().configs.ObsidianBoss then
                    if not Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Obsidian Golem') then
                        AttackBoss()
                    end
                else
                    AttackBoss()
                end
                if getgenv().configs.UseSoulKeys then
                    if Soul and Soul:FindFirstChild('Top'):FindFirstChild('TextLabel') then
                        local SoulAmount = string.match(Soul.Top.TextLabel.Text, '%d+')
                        if tonumber(SoulAmount) >= 10 and not MyInventory:FindFirstChild('Soul Key') then
                            RemoteEvents['CraftItem']:FireServer(220)
                        end
                    end
                end
            end
        end
    end
end

-- ===== SPIRIT BOSS =====
function SpiritBoss()
    local function AttackBoss()
        local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Spirit Golem')
        if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
            if not AutoPickupOnSpiritBossDeath then
                AutoPickupOnSpiritBossDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                    if not getgenv().configs.SpiritBoss then
                        AutoPickupOnSpiritBossDeath:Disconnect()
                        AutoPickupOnSpiritBossDeath = nil
                    end
                    if not parent then
                        task.wait(0.2)
                        AutoPickup()
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
            if not AutoPickupOnSpiritBossDeath then
                task.wait(1)
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1663, -460, -4558)
                RemoteEvents['KeyDoor']:FireServer(Workspace:WaitForChild('Map'):WaitForChild("Mushroom Boss Cave "):WaitForChild("Cave Door (d)"))
            end
        end
    end
    while getgenv().configs.SpiritBoss do
        if getgenv().configs.SpiritBoss then
            task.wait()
            if getgenv().configs.KillAura == true then
                getgenv().configs.KillAura = false
            end
            if IsPlayerAlive(LocalPlayer) then
                local Soul = MyInventory:FindFirstChild('Soul')
                if Workspace:FindFirstChild('PoisionMushroom') then
                    Workspace:FindFirstChild('PoisionMushroom'):Destroy()
                end
                if getgenv().configs.ObsidianBoss then
                    if not Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Obsidian Golem') then
                        AttackBoss()
                    end
                else
                    AttackBoss()
                end
                if getgenv().configs.UseSoulKeys then
                    if Soul and Soul:FindFirstChild('Top'):FindFirstChild('TextLabel') then
                        local SoulAmount = string.match(Soul.Top.TextLabel.Text, '%d+')
                        if tonumber(SoulAmount) >= 10 and not MyInventory:FindFirstChild('Soul Key') then
                            RemoteEvents['CraftItem']:FireServer(220)
                        end
                    end
                end
            end
        end
    end
end

-- ===== LUCKY SLIME =====
function LuckySlime()
    while getgenv().configs.LuckySlime do
        if getgenv().configs.LuckySlime then
            task.wait()
            if getgenv().configs.KillAura == true then
                getgenv().configs.KillAura = false
            end
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
                                task.wait(0.2)
                                AutoPickup()
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
                end
            end
        end
    end
end

-- ===== EVIL SKELETON =====
function EvilSkeleton()
    while getgenv().configs.EvilSkeleton do
        if getgenv().configs.EvilSkeleton then
            task.wait()
            if getgenv().configs.KillAura == true then
                getgenv().configs.KillAura = false
            end
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
                                task.wait(0.2)
                                AutoPickup()
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
                end
            end
        end
    end
end

-- ===== OGRE =====
function Ogre()
    while getgenv().configs.Ogre do
        if getgenv().configs.Ogre then
            task.wait()
            if getgenv().configs.KillAura == true then
                getgenv().configs.KillAura = false
            end
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
                                task.wait(0.2)
                                AutoPickup()
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
                end
            end
        end
    end
end

-- ===== SQUID =====
function Squid()
    while getgenv().configs.Squid do
        if getgenv().configs.Squid then
            task.wait()
            if getgenv().configs.KillAura == true then
                getgenv().configs.KillAura = false
            end
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
                                task.wait(0.2)
                                AutoPickup()
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
                end
            end
        end
    end
end

-- ===== INF JUMP =====
function InfJump()
    getgenv().InfiniteJump = Mouse.KeyDown:Connect(function(Key)
        if Key == " " then
            if getgenv().configs.InfJump and IsPlayerAlive(LocalPlayer) then
                LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
            else
                getgenv().InfiniteJump:Disconnect()
            end
        end
    end)
end

-- ===== JUMP POWER =====
function JumpPower()
    while getgenv().configs.JumpPower do
        if getgenv().configs.JumpPower then
            task.wait()
            if IsPlayerAlive(LocalPlayer) then
                LocalPlayer.Character.Humanoid.JumpPower = 100
            end
        end
    end
end

-- ===== PLAYER ESP =====
function PlayerEsp()
    if getgenv().configs.PlayerEsp then
        function EspOnPlayer(target)
            local EspRenderStepped
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
            EspRenderStepped = RunService.RenderStepped:Connect(function()
                if getgenv().configs.PlayerEsp == false then
                    if Boxoutline then Boxoutline:Remove() end
                    if Box then Box:Remove() end
                    if Healthbaroutline then Healthbaroutline:Remove() end
                    if Healthbar then Healthbar:Remove() end
                    if EspRenderStepped then EspRenderStepped:Disconnect() end
                    return
                end
                if target then
                    if IsPlayerAlive(target) then
                        local HumPos, onScreen = Camera:WorldToViewportPoint(target.Character.HumanoidRootPart.Position)
                        if onScreen then
                            local headpos = Camera:WorldToViewportPoint(target.Character.Head.Position + Vector3.new(0, 0.5, 0))
                            local LegPosition = Camera:WorldToViewportPoint(target.Character.HumanoidRootPart.Position - Vector3.new(0, 4.5, 0))
                            
                            Boxoutline.Size = Vector2.new(1050 / HumPos.Z, headpos.Y - LegPosition.Y)
                            Boxoutline.Position = Vector2.new(HumPos.X - Boxoutline.Size.X / 2, HumPos.Y - Boxoutline.Size.Y / 2)
                            Boxoutline.Visible = true
                            
                            Box.Size = Vector2.new(1050 / HumPos.Z, headpos.Y - LegPosition.Y)
                            Box.Position = Vector2.new(HumPos.X - Box.Size.X / 2, HumPos.Y - Box.Size.Y / 2 )
                            Box.Visible = true
                            
                            Healthbaroutline.Size = Vector2.new(2, headpos.Y - LegPosition.Y)
                            Healthbaroutline.Position = Boxoutline.Position - Vector2.new(8, 0)
                            Healthbaroutline.Visible = true
                            
                            Healthbar.Size = Vector2.new(2, (headpos.Y - LegPosition.Y) / (target.Character:FindFirstChildOfClass('Humanoid').MaxHealth / math.clamp(target.Character:FindFirstChildOfClass('Humanoid').Health, 0, target.Character:FindFirstChildOfClass('Humanoid').MaxHealth)))
                            Healthbar.Position = Vector2.new(Box.Position.X - 8, Box.Position.Y + (1/Healthbar.Size.Y))
                            Healthbar.Color = Color3.fromRGB(255, 0, 0):lerp(Color3.fromRGB(0, 255, 0), target.Character:FindFirstChildOfClass('Humanoid').Health / target.Character:FindFirstChildOfClass('Humanoid').MaxHealth)
                            Healthbar.Visible = true
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
                end
                EspOnPlayer(plr)
            end)
        end
    end
end

-- ===== AIMBOT =====
local AimbotState = {
    Enabled = true,
    Connections = {},
    LockedTarget = nil
}

local isAiming = false
local targetLocked = false

local function GetClosestInFOV()
    local closest = nil
    local minDist = math.huge
    local mousePos = UserInputService:GetMouseLocation()
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local part = player.Character:FindFirstChild(getgenv().AimbotPart)
            if part then
                local realDist = (part.Position - root.Position).Magnitude
                if realDist > getgenv().AimbotRange then
                    continue
                end
                
                local screenPos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                    if dist <= getgenv().AimbotFOV and dist < minDist then
                        closest = part
                        minDist = dist
                    end
                end
            end
        end
    end
    return closest
end

local function IsTargetValid(target)
    if not target then return false end
    if not target.Parent then return false end
    local player = Players:GetPlayerFromCharacter(target.Parent)
    if not player then return false end
    if player == LocalPlayer then return false end
    if not player.Character then return false end
    if not player.Character:FindFirstChild(getgenv().AimbotPart) then return false end
    
    local char = LocalPlayer.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    local dist = (target.Position - root.Position).Magnitude
    if dist > getgenv().AimbotRange then return false end
    
    return true
end

local connections = {}

table.insert(connections, UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isAiming = true
        if getgenv().AimbotEnabled and AimbotState.Enabled then
            local target = GetClosestInFOV()
            if target then
                AimbotState.LockedTarget = target
                targetLocked = true
            end
        end
    end
end))

table.insert(connections, UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isAiming = false
        targetLocked = false
        AimbotState.LockedTarget = nil
    end
end))

table.insert(connections, UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F1 then
        getgenv().AimbotEnabled = not getgenv().AimbotEnabled
        if not getgenv().AimbotEnabled then
            targetLocked = false
            AimbotState.LockedTarget = nil
        end
    end
end))

table.insert(connections, RunService.RenderStepped:Connect(function()
    if getgenv().AimbotEnabled and isAiming and AimbotState.Enabled then
        local target = AimbotState.LockedTarget
        
        if targetLocked and target and IsTargetValid(target) then
            local newPart = target.Parent:FindFirstChild(getgenv().AimbotPart)
            if newPart then
                workspace.CurrentCamera.CFrame = CFrame.new(
                    workspace.CurrentCamera.CFrame.Position,
                    newPart.Position
                )
            end
        else
            if targetLocked then
                targetLocked = false
                AimbotState.LockedTarget = nil
                local newTarget = GetClosestInFOV()
                if newTarget then
                    AimbotState.LockedTarget = newTarget
                    targetLocked = true
                end
            end
        end
    end
end))

AimbotState.Connections = connections

-- ===== TẠO CÁC TAB =====
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Farming = Window:AddTab({ Title = "Farm", Icon = "tree" }),
    Teleports = Window:AddTab({ Title = "Teleports", Icon = "map-pin" }),
    Resources = Window:AddTab({ Title = "Resources", Icon = "package" }),
    Chests = Window:AddTab({ Title = "Treasure Chests", Icon = "gift" }),
    LocalPlayer = Window:AddTab({ Title = "LocalPlayer", Icon = "user" }),
    Dupe = Window:AddTab({ Title = "Dupe", Icon = "copy" }),
    AutoSell = Window:AddTab({ Title = "AutoSell", Icon = "dollar-sign" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Credits = Window:AddTab({ Title = "Credits", Icon = "star" })
}

-- ===== MAIN TAB =====
local MainSection = Tabs.Main:AddSection("Main")
MainSection:AddToggle("RememberConfigs", { Title = "Remember Configs", Default = false, Callback = function() end })

MainSection:AddButton({
    Title = "AC Bypass",
    Callback = function()
        if not IsPlayerAlive(LocalPlayer) then
            Fluent:Notify({ Title = "Not alive", Content = "Maybe click the play button?", Duration = 5 })
            return
        end
        if IsPlayerAlive(LocalPlayer) then
            local oldpos = LocalPlayer.Character.HumanoidRootPart.CFrame
            local myroot = LocalPlayer.Character.HumanoidRootPart
            for i = 1, 100 do
                myroot.CFrame = CFrame.new(7562, 221, 18946)
                RemoteEvents['Sonar']:FireServer()
                myroot.CFrame = oldpos
            end
            Fluent:Notify({ Title = "Bypassed", Content = "AntiCheat bypassed!", Duration = 3 })
        end
    end
})

MainSection:AddButton({
    Title = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source', true))()
    end
})

local AutoPickupSection = Tabs.Main:AddSection("Auto Pickup")
AutoPickupSection:AddKeybind("AutoPickupKey", { Title = "AutoPickup Key", Default = "X", Callback = function() AutoPickup() end })
AutoPickupSection:AddToggle("AutoPickupToggle", { Title = "AutoPickup (toggle)", Default = false, Callback = function(Value) getgenv().configs.AutoPickup2 = Value AutoPickup2() end })

MainSection:AddButton({
    Title = "Steal any op loot on ground",
    Callback = function()
        local function FindFunnyClosestItem()
            local closest
            local range = math.huge
            for _, funnyitem in pairs(Workspace:GetDescendants()) do
                if funnyitem:IsA("Model") then
                    if string.find(funnyitem.Name:lower(), 'obsidian') or string.find(funnyitem.Name:lower(), 'staff') or string.find(funnyitem.Name:lower(), 'moonstone') or string.find(funnyitem.Name:lower(), 'lunar') or string.find(funnyitem.Name:lower(), 'zenyte') or string.find(funnyitem.Name:lower(), 'diamond') or string.find(funnyitem.Name:lower(), 'lucky') or string.find(funnyitem.Name:lower(), 'pumpkin') or string.find(funnyitem.Name:lower(), 'book') or string.find(funnyitem.Name:lower(), 'volcanic ore') then
                        if not funnyitem:FindFirstChildOfClass('StringValue') and not funnyitem.Parent:FindFirstChildOfClass('Humanoid') and not string.find(funnyitem.Name:lower(), 'harvest') and not string.find(funnyitem.Name:lower(), 'wizard') and not string.find(funnyitem.Name:lower(), 'zenytes') and not string.find(funnyitem.Parent.Name:lower(), 'anvil') and not string.find(funnyitem.Name:lower(), 'pet') and not string.find(funnyitem.Name:lower(), 'cave') and not string.find(funnyitem.Name:lower(), 'rock') and not string.find(funnyitem.Name:lower(), 'stone') then
                            if IsPlayerAlive(LocalPlayer) then
                                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - funnyitem:GetPivot().Position).magnitude
                                if dist < range then
                                    range = dist
                                    closest = funnyitem
                                end
                            end
                        end
                    end
                end
            end
            return closest
        end
        if FindFunnyClosestItem() then
            local oldpos = LocalPlayer.Character.HumanoidRootPart.CFrame
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(FindFunnyClosestItem():GetPivot().Position)
            task.wait(0.2)
            AutoPickup()
            LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
        else
            Fluent:Notify({ Title = "wah wah wahhh", Content = "nothing good on da floor :(", Duration = 3 })
        end
    end
})

local InstantRepairSection = Tabs.Main:AddSection("Instant Repair free, click as many times as needed")
InstantRepairSection:AddDropdown("InstantRepair", {
    Title = "Instant Repair",
    Values = { "MoonstoneSet", "ObsidianSet", "AllShields", "AllSwords", "AllBows", "AllBooks", "AllStaffs" },
    Default = 1,
    Callback = function(Value)
        local ClosestChest = GetClosestChest()
        if not ClosestChest then
            Fluent:Notify({ Title = "Needs chest", Content = "Place any chest down!", Duration = 2.5 })
            return
        end
        local set
        if Value == "MoonstoneSet" then set = MoonstoneSet
        elseif Value == "ObsidianSet" then set = ObsidianSet
        elseif Value == "AllShields" then set = AllShields
        elseif Value == "AllSwords" then set = AllSwords
        elseif Value == "AllBows" then set = AllBows
        elseif Value == "AllBooks" then set = AllBooks
        elseif Value == "AllStaffs" then set = AllStaffs
        end
        for _, piece in pairs(set) do
            RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest, true, piece)
            RemoteEvents['UpdateStorageChest']:FireServer(ClosestChest, false, piece)
        end
        Fluent:Notify({ Title = "Repaired", Content = "Repaired " .. Value, Duration = 1 })
    end
})

local ChestSection = Tabs.Main:AddSection("Place Anything in (nearest) chest")
ChestSection:AddDropdown("ChestType", { Title = "Specific Chest Type", Values = { "Any", "Wood", "Stone", "Silver", "Gold", "Ruby", "Diamond", "Zenyte", "Obsidian", "Moonstone" }, Default = 1, Callback = function(Value) getgenv().configs.ChestType = Value end })

ChestSection:AddButton({
    Title = "Store Item",
    Callback = function()
        local function GetClosestFilteredChest()
            local CheckPassiveOrNonPassive = Workspace:FindFirstChild("Replicators"):FindFirstChild('NonPassive') and 'NonPassive' or 'Passive'
            local closest
            local range = math.huge
            if IsPlayerAlive(LocalPlayer) then
                for _, chest in pairs(Workspace:WaitForChild("Replicators")[CheckPassiveOrNonPassive]:GetChildren()) do
                    if string.find(chest.Name:lower(), 'storage') and chest:FindFirstChildOfClass('MeshPart') then
                        if getgenv().configs.ChestType == 'Any' then
                            local dist = (LocalPlayer.Character:WaitForChild('HumanoidRootPart').Position - chest:FindFirstChildOfClass('MeshPart').Position).magnitude
                            if dist < range then
                                range = dist
                                closest = chest
                            end
                        else
                            if string.find(chest.Name:lower(), getgenv().configs.ChestType:lower()) then
                                local dist = (LocalPlayer.Character:WaitForChild('HumanoidRootPart').Position - chest:FindFirstChildOfClass('MeshPart').Position).magnitude
                                if dist < range then
                                    range = dist
                                    closest = chest
                                end
                            end
                        end
                    end
                end
            end
            return closest
        end
        local GetFilteredChest = GetClosestFilteredChest()
        if not GetFilteredChest then
            Fluent:Notify({ Title = "Needs chest", Content = "Place any chest down!", Duration = 2.5 })
            return
        end
        for i = 1, getgenv().AmountOfChestInserts do
            RemoteEvents['UpdateStorageChest']:FireServer(GetFilteredChest, true, SWITCHEDITEMSTABLE[getgenv().ItemToPutInChest])
        end
    end
})

local ChestItems = {}
for _, inv in pairs(MyInventory:GetChildren()) do
    if inv:IsA("ImageLabel") and inv.Name ~= 'Arrow' then
        table.insert(ChestItems, inv.Name)
    end
end
table.sort(ChestItems)

ChestSection:AddDropdown("InventoryItem", { Title = "Inventory Item", Values = ChestItems, Default = 1, Callback = function(Value) getgenv().ItemToPutInChest = Value end })
ChestSection:AddSlider("AmountChestItem", { Title = "Amount of item", Min = 1, Max = 200, Default = 1, Rounding = 0, Callback = function(Value) getgenv().AmountOfChestInserts = Value end })

local AutoEatSection2 = Tabs.Main:AddSection("Auto Eat")
AutoEatSection2:AddToggle("AutoEat", { Title = "Auto Eat (Greatest food source)", Default = false, Callback = function(Value) getgenv().configs.AutoEat = Value AutoEat() end })
AutoEatSection2:AddDropdown("EatingType", { Title = "Auto Eat Type", Values = { "AFK", "War" }, Default = 1, Callback = function(Value) getgenv().configs.EatingType = Value end })

local MiscSection3 = Tabs.Main:AddSection("Misc")
MiscSection3:AddToggle("CtrlTp", { Title = "Ctrl+Click tp", Default = false, Callback = function(Value) getgenv().configs.ClickTp = Value ClickTp() end })
MiscSection3:AddToggle("MineAura", { Title = "Mine Aura", Default = false, Callback = function(Value) getgenv().configs.MineAura = Value MineAura() end })

MiscSection3:AddButton({
    Title = "Go invisible (Player noclips)",
    Callback = function()
        if IsPlayerAlive(LocalPlayer) then
            local oldpos = LocalPlayer.Character.HumanoidRootPart.Position
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7195, 98, 18663)
            for _, descendant in pairs(LocalPlayer.Character:GetDescendants()) do
                if descendant:IsA("Motor6D") or descendant.Name == 'PlayerBillboard' then
                    descendant:Destroy()
                end
            end
            task.wait(1)
            if LocalPlayer.Character:FindFirstChild('Hitbox') then
                LocalPlayer.Character.Hitbox:Destroy()
            end
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(oldpos)
        end
    end
})

MiscSection3:AddButton({
    Title = "Go Visible (Resets character)",
    Callback = function()
        if IsPlayerAlive(LocalPlayer) then
            local Respawn
            local oldpos = LocalPlayer.Character.HumanoidRootPart.Position
            LocalPlayer.Character.Humanoid.Health = 0
            Respawn = LocalPlayer.CharacterAdded:Connect(function(chr)
                chr:WaitForChild('HumanoidRootPart').CFrame = CFrame.new(oldpos)
                Respawn:Disconnect()
                return
            end)
        end
    end
})

MiscSection3:AddButton({
    Title = "Render Map (Helpful for loading assets)",
    Callback = function()
        if IsPlayerAlive(LocalPlayer) then
            local oldpos = LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame
            local function MakeTween(pos)
                return TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {CFrame = CFrame.new(pos)})
            end
            local a = MakeTween(Vector3.new(-1812, 46, -7685))
            a:Play()
            a.Completed:Wait()
            local b = MakeTween(Vector3.new(-1838, 46, -3189))
            b:Play()
            b.Completed:Wait()
            local c = MakeTween(Vector3.new(5825, 76, -3258))
            c:Play()
            c.Completed:Wait()
            local d = MakeTween(Vector3.new(5330, 36, -7372))
            d:Play()
            d.Completed:Wait()
            local e = MakeTween(Vector3.new(4782, 74, -5208))
            e:Play()
            e.Completed:Wait()
            local f = MakeTween(Vector3.new(-152, 106, -4079))
            f:Play()
            f.Completed:Wait()
            LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame = oldpos
        end
    end
})

MiscSection3:AddToggle("HackerDetector", {
    Title = "Other Hacker Detector",
    Default = false,
    Callback = function(Value)
        local function CheckTeleport(rootpart, initialpos)
            task.wait(0.2)
            if (rootpart.Position - initialpos).magnitude > 100 then
                return true
            end
        end
        local function CheaterDetector()
            _G.cooldown = 0
            local abs = math.abs
            local Reason = 'Unknown'
            while getgenv().configs.CheaterDetector do
                if getgenv().configs.CheaterDetector then
                    task.wait(_G.cooldown)
                    for _, plr in pairs(Players:GetPlayers()) do
                        if plr ~= LocalPlayer then
                            if IsPlayerAlive(plr) then
                                local oldpos = plr.Character.HumanoidRootPart.Position
                                local velocity = plr.Character.HumanoidRootPart.AssemblyLinearVelocity
                                local maxvelocity = {abs(velocity.X), abs(velocity.Y), abs(velocity.Z)}
                                local max = math.max(unpack(maxvelocity))
                                task.spawn(function()
                                    if CheckTeleport(plr.Character.HumanoidRootPart, plr.Character.HumanoidRootPart.Position) then
                                        Reason = 'Teleporting'
                                        Fluent:Notify({ Title = "Suspicious Activity", Content = plr.Name .. " is looking suspicious, Reason: " .. Reason, Duration = 3 })
                                    end
                                    _G.cooldown = 0.5
                                end)
                                if plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.PlatformStanding then
                                    Reason = 'Flying'
                                    Fluent:Notify({ Title = "Suspicious Activity", Content = plr.Name .. " is looking suspicious, Reason: " .. Reason, Duration = 3 })
                                    _G.cooldown = 3
                                elseif plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated and max > 60 then
                                    Reason = 'Vehicle Fly/Speed'
                                    Fluent:Notify({ Title = "Suspicious Activity", Content = plr.Name .. " is looking suspicious, Reason: " .. Reason, Duration = 3 })
                                    _G.cooldown = 1
                                elseif max > 80 and max ~= maxvelocity[2] then
                                    Reason = 'Excessive Speed'
                                    Fluent:Notify({ Title = "Suspicious Activity", Content = plr.Name .. " is looking suspicious, Reason: " .. Reason, Duration = 3 })
                                    _G.cooldown = 1
                                elseif plr.Character.Humanoid.WalkSpeed > 24 then
                                    Reason = 'Speed'
                                    Fluent:Notify({ Title = "Suspicious Activity", Content = plr.Name .. " is looking suspicious, Reason: " .. Reason, Duration = 3 })
                                    _G.cooldown = 1
                                elseif plr.Character.Humanoid.JumpPower > 80 then
                                    Reason = 'Jump Power'
                                    Fluent:Notify({ Title = "Suspicious Activity", Content = plr.Name .. " is looking suspicious, Reason: " .. Reason, Duration = 3 })
                                    _G.cooldown = 1
                                end
                            end
                        end
                    end
                end
            end
        end
        getgenv().configs.CheaterDetector = Value
        CheaterDetector()
    end
})

-- ===== COMBAT TAB =====
local KillAuraSection2 = Tabs.Combat:AddSection("Kill Aura")
KillAuraSection2:AddToggle("KillAura2", { Title = "Kill Aura", Default = false, Callback = function(Value) getgenv().configs.KillAura = Value KillAura() end })
KillAuraSection2:AddInput("WhitelistPerson", { Title = "Whitelist Person", Default = "", Placeholder = "Username here", Callback = function(Value)
    if Value == "" then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if string.find(plr.Name:lower(), Value:lower()) or string.find(plr.DisplayName:lower(), Value:lower()) then
            table.insert(Whitelist_table, plr.Name)
            Fluent:Notify({ Title = "Added", Content = plr.Name .. " whitelisted", Duration = 3 })
            return
        end
    end
end })
KillAuraSection2:AddInput("RemoveWhitelist", { Title = "Remove Whitelisted Person", Default = "", Placeholder = "Username here", Callback = function(Value)
    if Value == "" then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if string.find(plr.Name:lower(), Value:lower()) or string.find(plr.DisplayName:lower(), Value:lower()) then
            if table.find(Whitelist_table, plr.Name) then
                table.remove(Whitelist_table, table.find(Whitelist_table, plr.Name))
                Fluent:Notify({ Title = "Removed", Content = plr.Name .. " removed from whitelist", Duration = 3 })
                return
            end
        end
    end
end })

local CloseCombatSection2 = Tabs.Combat:AddSection("Close Combat")
CloseCombatSection2:AddToggle("PlayerLock", { 
    Title = "Player Lock (Aimbot)", 
    Default = false, 
    Callback = function(Value) 
        getgenv().configs.PlayerLock = Value 
        if Value then
            if type(PlayerLock) == "function" then
                PlayerLock()
            else
                Fluent:Notify({ Title = "Error", Content = "PlayerLock function not found", Duration = 3 })
            end
        end
    end 
})
CloseCombatSection2:AddToggle("AutoHeal", { 
    Title = "Auto Heal (Pumpkins)", 
    Default = false, 
    Callback = function(Value) 
        getgenv().configs.Pumpkins = Value 
        if Value then
            if type(Pumpkins) == "function" then
                Pumpkins()
            end
        end
    end 
})
CloseCombatSection2:AddToggle("HitboxExtender", { 
    Title = "Hitbox Extender", 
    Default = false, 
    Callback = function(Value) 
        getgenv().configs.Hitbox = Value 
        if type(Hitbox) == "function" then
            Hitbox() 
        end
        if not getgenv().configs.Hitbox then 
            for _, plr in pairs(Players:GetPlayers()) do 
                if plr ~= LocalPlayer and IsPlayerAlive(plr) and plr.Character:FindFirstChild('Hitbox') then 
                    plr.Character.Hitbox.Size = Vector3.new(4.9453125, 6.273651123046875, 2.0283203125) 
                end 
            end 
        end 
    end 
})

-- ===== AIMBOT UI =====
local AimbotSection = Tabs.Combat:AddSection("Aimbot")
AimbotSection:AddToggle("AimbotToggle", { 
    Title = "Enable Aimbot", 
    Default = true, 
    Callback = function(Value) 
        getgenv().AimbotEnabled = Value
        if not Value then
            targetLocked = false
            AimbotState.LockedTarget = nil
        end
    end 
})
AimbotSection:AddDropdown("AimbotPart", {
    Title = "Target Part",
    Values = { "Head", "HumanoidRootPart", "Torso", "LeftFoot", "RightFoot", "LeftHand", "RightHand" },
    Default = 1,
    Callback = function(Value)
        getgenv().AimbotPart = Value
    end
})
AimbotSection:AddSlider("AimbotRange", {
    Title = "Range",
    Min = 10,
    Max = 1000,
    Default = 75,
    Rounding = 0,
    Callback = function(Value)
        getgenv().AimbotRange = Value
    end
})
AimbotSection:AddSlider("AimbotFOV", {
    Title = "FOV",
    Min = 10,
    Max = 500,
    Default = 100,
    Rounding = 0,
    Callback = function(Value)
        getgenv().AimbotFOV = Value
    end
})
AimbotSection:AddParagraph({ Title = "Controls", Content = "Key: F1 to toggle | Right-click to lock" })

local AdvancedSection2 = Tabs.Combat:AddSection("Advanced Kill Aura")
AdvancedSection2:AddInput("OpKillAuraTarget", { Title = "Op KillAura Target", Default = "", Placeholder = "Username here", Callback = function(Value)
    if Value == "" then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if string.find(plr.Name:lower(), Value:lower()) or string.find(plr.DisplayName:lower(), Value:lower()) then
            table.insert(OpKillAuraTable, 1, plr)
            Fluent:Notify({ Title = "Targeted", Content = "Targeting " .. plr.Name, Duration = 3 })
            return
        end
    end
end })
AdvancedSection2:AddToggle("OPKillAura", { Title = "Op Kill Aura", Default = false, Callback = function(Value) getgenv().configs.OpKillAura = Value OpKillAura() end })
AdvancedSection2:AddToggle("TogglePredict", { Title = "Toggle Predict", Default = false, Callback = function(Value) getgenv().configs.PredictOpKillAura = Value end })

local CombatMiscSection2 = Tabs.Combat:AddSection("Miscs")
CombatMiscSection2:AddToggle("MobAura", { Title = "Mob Aura", Default = false, Callback = function(Value) getgenv().configs.MobAura = Value MobAura() end })
CombatMiscSection2:AddKeybind("TrapPlayerKey", { Title = "Trap Player", Default = "Minus", Callback = function() TrapPlayer() end })
CombatMiscSection2:AddDropdown("TrapType2", { Title = "Trap Type", Values = { "Stone Trap", "Ruby Trap", "Zenyte Trap" }, Default = 1, Callback = function(Value) getgenv().configs.TrapType = Value end })

-- ===== FARMING TAB =====
local TreeFarmSection2 = Tabs.Farming:AddSection("Tree Farm")
TreeFarmSection2:AddToggle("ConiferFarm2", { Title = "Conifer Farm (equip any tool)", Default = false, Callback = function(Value) getgenv().configs.ConiferFarm = Value ConiferFarm() end })

local BossSettingsSection2 = Tabs.Farming:AddSection("Boss Farm Settings")
BossSettingsSection2:AddToggle("AutoRepairClub2", { Title = "Auto repair Ob Club (50%) (place chest)", Default = false, Callback = function(Value) getgenv().configs.AutoRepairClub = Value AutoRepairClub() end })
BossSettingsSection2:AddToggle("SoulKeyBossFarm2", { Title = "Use Soul Keys to farm bosses (inf farm)", Default = false, Callback = function(Value) getgenv().configs.UseSoulKeys = Value end })

local BossFarmsSection2 = Tabs.Farming:AddSection("Boss Farms (Disables kill aura)")
BossFarmsSection2:AddToggle("ObsidianBossFarm", { Title = "Obsidian Boss Farm", Default = false, Callback = function(Value) getgenv().configs.ObsidianBoss = Value ObsidianBoss() end })
BossFarmsSection2:AddToggle("ZenyteLuckyBoss", { Title = "Zenyte/Lucky Boss Farm", Default = false, Callback = function(Value) getgenv().configs.ZenLuckBoss = Value ZenLuckBoss() end })
BossFarmsSection2:AddToggle("SpiritBossFarm", { Title = "Spirit Boss Aura", Default = false, Callback = function(Value) getgenv().configs.SpiritBoss = Value SpiritBoss() end })

local NotAutoSection2 = Tabs.Farming:AddSection("NOT AUTO")
NotAutoSection2:AddToggle("LuckySlimeFarm", { Title = "Lucky Slime Farm", Default = false, Callback = function(Value) getgenv().configs.LuckySlime = Value LuckySlime() end })
NotAutoSection2:AddToggle("EvilSkeletonFarm", { Title = "Evil Skeleton Farm", Default = false, Callback = function(Value) getgenv().configs.EvilSkeleton = Value EvilSkeleton() end })
NotAutoSection2:AddToggle("OgreFarm", { Title = "Ogre Farm", Default = false, Callback = function(Value) getgenv().configs.Ogre = Value Ogre() end })
NotAutoSection2:AddToggle("CaptainSquidFarm", { Title = "Captain Squid Farm", Default = false, Callback = function(Value) getgenv().configs.Squid = Value Squid() end })

-- ===== TELEPORTS TAB =====
local EventsSection2 = Tabs.Teleports:AddSection("Events")
EventsSection2:AddButton({ Title = "Asteroid", Callback = function() if IsPlayerAlive(LocalPlayer) then local AstPos = Workspace:FindFirstChild('Asteroid', true) if AstPos then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(AstPos:GetPivot().Position + Vector3.new(0, 35, 0)) else Fluent:Notify({ Title = "No Asteroids", Content = "A sad sad day...", Duration = 3 }) end end end })
EventsSection2:AddButton({ Title = "Lucky Slime", Callback = function() if IsPlayerAlive(LocalPlayer) then local slime = Workspace:WaitForChild('Replicators'):FindFirstChild('Both'):FindFirstChild("Lucky Slime") if slime and slime:FindFirstChild('HumanoidRootPart') then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(slime.HumanoidRootPart.Position + Vector3.new(15, 0, 0)) else Fluent:Notify({ Title = "No Lucky Slime", Content = "A sad sad day...", Duration = 3 }) end end end })
EventsSection2:AddButton({ Title = "Mega Candy Rock", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1944.84009, -6.88914394, -3933.60352) end end })

local TradersSection2 = Tabs.Teleports:AddSection("Traders")
TradersSection2:AddButton({ Title = "Resource Trader", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4288, 43, -4014) end end })
TradersSection2:AddButton({ Title = "Armor/Weapon Trader", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(427, 12, -3451) end end })
TradersSection2:AddButton({ Title = "Ocean Trader", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1673, -290, -5659) end end })

local VolcanoSection2 = Tabs.Teleports:AddSection("Volcano")
VolcanoSection2:AddButton({ Title = "Volcano", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-842, 63, -3603) end end })
VolcanoSection2:AddButton({ Title = "Volcanic Furnace", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2614, -454, -5579) end end })

local CavesSection2 = Tabs.Teleports:AddSection("Caves")
CavesSection2:AddButton({ Title = "Zenyte Boss", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1741, -440, -4536) end end })
CavesSection2:AddButton({ Title = "Spirit Boss", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1427, -293, -4959) end end })
CavesSection2:AddButton({ Title = "Caves level 3", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1581, -502, -4649) end end })
CavesSection2:AddButton({ Title = "Caves level 2", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1559, -347, -4635) end end })
CavesSection2:AddButton({ Title = "Central Caves", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1532, -192, -4696) end end })

local IslandSection2 = Tabs.Teleports:AddSection("Islands")
IslandSection2:AddButton({ Title = "Ice Biome", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1961, -2, -3973) end end })
IslandSection2:AddButton({ Title = "Pet Island", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2889, 54, -6465) end end })
IslandSection2:AddButton({ Title = "Banaenae Island", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3400, 13, -4467) end end })
IslandSection2:AddButton({ Title = "Magic Island", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1292, 125, -7234) end end })
IslandSection2:AddButton({ Title = "Starter Island", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7507, 19, 7496) end end })
IslandSection2:AddButton({ Title = "Secret Island", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7139, 72, 18673) end end })

local LeaderboardSection2 = Tabs.Teleports:AddSection("Leaderboard")
LeaderboardSection2:AddButton({ Title = "Leaderboard Place", Callback = function() if IsPlayerAlive(LocalPlayer) then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5313, 4, -5508) end end })

-- ===== RESOURCES TAB =====
local OreSection2 = Tabs.Resources:AddSection("Ore Finding")
OreSection2:AddDropdown("OreType2", { Title = "Ore Type", Values = { "Lunar Rock", "Volcanic Rock", "Zenyte Rock", "Diamond Rock", "Gold Rock", "Ruby Rock", "Candy Rock", "Silver Rock", "Coal Rock", "Rock" }, Default = 10, Callback = function(Value) getgenv().OreType = Value end })
OreSection2:AddButton({ Title = "Ore Finder", Callback = function()
    local OrePositionTable = {}
    for _, ore in pairs(Workspace:GetDescendants()) do
        if ore.Name == getgenv().OreType then
            if ore:IsA('Model') and ore.PrimaryPart ~= nil then
                table.insert(OrePositionTable, ore.PrimaryPart.Position)
                break
            end
        end
    end
    if OrePositionTable[1] == nil then
        Fluent:Notify({ Title = "No " .. getgenv().OreType, Content = "There is no " .. getgenv().OreType, Duration = 3 })
    else
        if IsPlayerAlive(LocalPlayer) then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OrePositionTable[1] + Vector3.new(0, 5, 0))
        end
    end
end })

local MiscSection4 = Tabs.Resources:AddSection("Pathes, Shells, Slimes")
MiscSection4:AddDropdown("MiscItems2", { Title = "Item Type", Values = { "Watermelon Patch", "Potato Patch", "Carrot Patch", "Cabbage Patch", "Small Oyster", "Large Orange Shell", "Large Pink Shell", "Large White Shell", "Small Orange Shell", "Small Pink Shell", "Small White Shell", "Seaglass", "Orange Slime", "Green Slime", "Blue Slime" }, Default = 1, Callback = function(Value) getgenv().MiscItems = Value end })
MiscSection4:AddButton({ Title = "Find Item", Callback = function()
    local MiscPositionsTable = {}
    for _, misc in pairs(Workspace:GetDescendants()) do
        if misc.Name == getgenv().MiscItems then
            if misc:IsA('Model') and misc.PrimaryPart ~= nil then
                table.insert(MiscPositionsTable, misc.PrimaryPart.Position)
            end
        end
    end
    if MiscPositionsTable[1] == nil then
        Fluent:Notify({ Title = "No " .. getgenv().MiscItems, Content = "There is no " .. getgenv().MiscItems, Duration = 3 })
    else
        if IsPlayerAlive(LocalPlayer) then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(MiscPositionsTable[1] + Vector3.new(0, 5, 0))
        end
    end
end })

-- ===== CHESTS TAB =====
local ChestSpawnSection2 = Tabs.Chests:AddSection("Chest Spawning")
ChestSpawnSection2:AddButton({ Title = "Spawn Easy Treasure Chest (100 tokens)", Callback = function() RemoteEvents['BuyWorldEvent']:FireServer(1) end })
ChestSpawnSection2:AddButton({ Title = "Spawn Medium Treasure Chest (450 tokens)", Callback = function() RemoteEvents['BuyWorldEvent']:FireServer(2) end })
ChestSpawnSection2:AddButton({ Title = "Spawn Hard Treasure Chest (1000 tokens)", Callback = function() RemoteEvents['BuyWorldEvent']:FireServer(3) end })

local ChestOpenSection2 = Tabs.Chests:AddSection("Chest Opening")
ChestOpenSection2:AddButton({ Title = "Open Easy Chest", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(166, "Open") end })
ChestOpenSection2:AddButton({ Title = "Open Medium Chest", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(167, "Open") end })
ChestOpenSection2:AddButton({ Title = "Open Hard Chest", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(168, "Open") end })

local ChestFindSection2 = Tabs.Chests:AddSection("Chest Finding")
ChestFindSection2:AddButton({ Title = "Get Map Treasure", Callback = function()
    if IsPlayerAlive(LocalPlayer) then
        local oldpos = LocalPlayer.Character.HumanoidRootPart.CFrame
        local myroot = LocalPlayer.Character.HumanoidRootPart
        local function GetAllTreasure()
            for _, chest in pairs(Workspace:GetDescendants()) do
                if string.find(chest.Name, 'Treasure Chest') then
                    local chestpos = chest:GetPivot().Position
                    repeat task.wait()
                        if chest.Parent then
                            myroot.CFrame = CFrame.new(chestpos + Vector3.new(0, 1, 0))
                            RemoteEvents['ItemInteracted']:FireServer(chest, "Pickup")
                        end
                    until not chest.Parent
                end
            end
            myroot.CFrame = oldpos
        end
        GetAllTreasure()
    end
end })

local ClueSection2 = Tabs.Chests:AddSection("Clue Helper")
ClueSection2:AddButton({ Title = "Clue is a text", Callback = function()
    local Steps = require(ReplicatedStorage:WaitForChild('References'):WaitForChild('SharedData'):WaitForChild('Clues'):WaitForChild('Steps'))
    local currentclue = LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Menus')["Clue Scroll"]:FindFirstChild('Content'):FindFirstChild('Riddle')
    local loadout = currentclue.Parent.Loadout.Text
    local cluetable = {}
    local CLUETYPE = nil
    local loadoutsubbed = string.gsub(loadout, 'Must wear:  ', '')
    for _, riddle in pairs(Steps) do
        if riddle.Riddle ~= nil then
            if currentclue.Text == riddle.Riddle then
                CLUETYPE = riddle.Name
            end
        end
    end
    if CLUETYPE ~= nil then
        for _, clue in pairs(Workspace:GetDescendants()) do
            if clue.Name == CLUETYPE then
                if clue:IsA('Model') then
                    if clue.PrimaryPart ~= nil then
                        table.insert(cluetable, clue.PrimaryPart.Position)
                    end
                else
                    table.insert(cluetable, clue.Position)
                end
            end
        end
    end
    if cluetable[1] ~= nil then
        if IsPlayerAlive(LocalPlayer) then
            LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame = CFrame.new(cluetable[1] + Vector3.new(0, 20, 0))
            Fluent:Notify({ Title = "Must wear (if so):", Content = loadoutsubbed, Duration = 7 })
        end
    else
        Fluent:Notify({ Title = "Clue not found", Content = "Your clue is not on the map", Duration = 3 })
    end
end })
ClueSection2:AddButton({ Title = "Clue is an image", Callback = function()
    local Steps = require(ReplicatedStorage:WaitForChild('References'):WaitForChild('SharedData'):WaitForChild('Clues'):WaitForChild('Steps'))
    local CurrentClueImage = LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Menus')["Clue Scroll"]:FindFirstChild('Content'):FindFirstChild('ImageLabel').Image
    local loadout = LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Menus')["Clue Scroll"]:FindFirstChild('Content'):FindFirstChild('Loadout').Text
    local CLUELOCATION = nil
    local loadoutsubbed = string.gsub(loadout, 'Must wear: ', '')
    for _, image in pairs(Steps) do
        if image.Image then
            if CurrentClueImage == image.Image then
                CLUELOCATION = image.Location
                break
            end
        end
    end
    if CLUELOCATION then
        if IsPlayerAlive(LocalPlayer) then
            LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame = CFrame.new(CLUELOCATION + Vector3.new(0, 15, 0))
            if not LocalPlayer.Character:FindFirstChild('Shovel') then
                RemoteEvents['InventoryInteraction']:FireServer(169, 'Equip')
            end
            task.wait(0.4)
            RemoteEvents['ToolAction']:FireServer(CLUELOCATION)
            Fluent:Notify({ Title = "Must wear (if so):", Content = loadoutsubbed, Duration = 7 })
        end
    else
        Fluent:Notify({ Title = "Clue not found", Content = "Your clue is not on the map", Duration = 3 })
    end
end })

-- ===== LOCALPLAYER TAB =====
local PlayerModSection2 = Tabs.LocalPlayer:AddSection("Player Modifications")
PlayerModSection2:AddToggle("InfJump2", { Title = "Inf-Jump", Default = false, Callback = function(Value) getgenv().configs.InfJump = Value InfJump() end })
PlayerModSection2:AddToggle("AntiRagDoll2", { Title = "Anti-Ragdoll", Default = false, Callback = function(Value)
    getgenv().configs.AntiRagDoll = Value
    if getgenv().configs.AntiRagDoll then
        if not getgenv().RagDollBypass then
            getgenv().RagDollBypass = LocalPlayer.Character:WaitForChild('Humanoid').StateChanged:Connect(function(state)
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
end })
PlayerModSection2:AddInput("PlayerTp2", { Title = "Player TP", Default = "", Placeholder = "Username here", Callback = function(Value)
    if Value == "" then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if string.find(plr.Name:lower(), Value:lower()) or string.find(plr.DisplayName:lower(), Value:lower()) then
                if IsPlayerAlive(LocalPlayer) and IsPlayerAlive(plr) then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position)
                    Fluent:Notify({ Title = "Success", Content = "Tped to: " .. plr.Name, Duration = 3 })
                end
            end
        end
    end
end })

-- ===== SPEED MODS =====
local SpeedModSection = Tabs.LocalPlayer:AddSection("Speed Mods")

-- Quick Speed Toggle
SpeedModSection:AddToggle("QuickSpeedToggle", {
    Title = "Quick Speed (Hold Key)",
    Default = false,
    Callback = function(Value)
        getgenv().QuickSpeedToggle = Value
    end
})

SpeedModSection:AddKeybind("QuickSpeedKey", {
    Title = "Quick Speed Key",
    Default = "B",
    Callback = function(Key)
        getgenv().QuickSpeedKey = Key
    end
})

SpeedModSection:AddSlider("QuickSpeedMultiplier", {
    Title = "Quick Speed Multiplier",
    Min = 1,
    Max = 20,
    Default = 1,
    Rounding = 0,
    Callback = function(Value)
        getgenv().QuickSpeedMultiplier = Value
    end
})

-- Quick Speed Handler (chạy khi toggle bật)
task.spawn(function()
    while task.wait() do
        if getgenv().QuickSpeedToggle then
            if UserInputService:IsKeyDown(getgenv().QuickSpeedKey) and not UserInputService:GetFocusedTextBox() then
                if IsPlayerAlive(LocalPlayer) then
                    local moveDir = LocalPlayer.Character.Humanoid.MoveDirection
                    if moveDir.Magnitude > 0 then
                        LocalPlayer.Character:TranslateBy(moveDir * (getgenv().QuickSpeedMultiplier * 0.5))
                    end
                end
            end
        end
    end
end)

-- Sneaky Speed (Extra Speed) - CHỈ TĂNG TỐC KHI DI CHUYỂN LÙI (S)
SpeedModSection:AddToggle("SneakySpeed", {
    Title = "Sneaky Speed (Backward Speed)",
    Default = false,
    Callback = function(Value)
        getgenv().configs.ExtraSpeed = Value
        if Value then
            task.spawn(function()
                while getgenv().configs.ExtraSpeed do
                    task.wait()
                    if IsPlayerAlive(LocalPlayer) then
                        local hum = LocalPlayer.Character.Humanoid
                        if hum then
                            -- Kiểm tra nếu đang di chuyển lùi (S) - MoveDirection.Z > 0
                            if hum.MoveDirection.Z > 0 then
                                hum.WalkSpeed = 21
                            else
                                hum.WalkSpeed = 16
                            end
                        end
                    end
                end
            end)
        else
            if IsPlayerAlive(LocalPlayer) then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end
    end
})

-- Swim Speed
SpeedModSection:AddSlider("SwimSpeed", {
    Title = "Swim Speed",
    Min = 10,
    Max = 100,
    Default = 14,
    Rounding = 0,
    Callback = function(Value)
        local Constants = require(ReplicatedStorage:WaitForChild('References'):WaitForChild('SharedData'):WaitForChild('CONSTANTS'))
        Constants.WALK_SPEEDS.SWIM = Value
    end
})

-- Mod Glider Speed
if MyInventory:FindFirstChild("Glider") or MyInventory:FindFirstChild("Easter Glider") then
    SpeedModSection:AddSlider("GliderModSpeed", {
        Title = "Glider Speed",
        Min = 30,
        Max = 300,
        Default = 30,
        Rounding = 0,
        Callback = function(Value)
            getgenv().GliderModSpeed = Value
            if getgenv().GliderModToggle then
                local GliderModule = require(LocalPlayer:WaitForChild('PlayerScripts'):WaitForChild('Main'):WaitForChild('ToolController'):WaitForChild('ToolObject'):WaitForChild('Controllers'):WaitForChild('Glider'))
                setconstant(GliderModule.Step, 9, tonumber(Value))
            end
        end
    })

    SpeedModSection:AddToggle("GliderModToggle", {
        Title = "Enable Glider Speed Mod",
        Default = false,
        Callback = function(Value)
            getgenv().GliderModToggle = Value
            local GliderModule = require(LocalPlayer:WaitForChild('PlayerScripts'):WaitForChild('Main'):WaitForChild('ToolController'):WaitForChild('ToolObject'):WaitForChild('Controllers'):WaitForChild('Glider'))
            if Value == true then
                setconstant(GliderModule.Step, 9, tonumber(getgenv().GliderModSpeed))
            else
                setconstant(GliderModule.Step, 9, 30)
            end
        end
    })
end

local MiscModSection2 = Tabs.LocalPlayer:AddSection("Misc Mods")
MiscModSection2:AddButton({ Title = "Get Map Candy (OP)", Callback = function()
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
end })
MiscModSection2:AddButton({ Title = "Restore Candy Mesh (not invisible)", Callback = function()
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
end })
MiscModSection2:AddButton({ Title = "Drive in water", Callback = function()
    local Cart = require(LocalPlayer:WaitForChild('PlayerScripts'):WaitForChild('Main'):WaitForChild('Vehicle'):WaitForChild('Cart'))
    Cart.TerrainCheck = function() return false end
end })

-- ===== DUPE TAB =====
local DupeSection2 = Tabs.Dupe:AddSection("Real Duplication Glitch (data does not save)")
DupeSection2:AddButton({ Title = "Stop data (dupe)", Callback = function() RemoteEvents['SetSettings']:FireServer(Workspace) Fluent:Notify({ Title = "Data Stopped", Content = "Drop anything you want :)", Duration = 5 }) end })
DupeSection2:AddButton({ Title = "Rejoin Current Server", Callback = function() Fluent:Notify({ Title = "Rejoining", Content = "Rejoining the server", Duration = 1 }) TeleportService:Teleport(game.PlaceId, LocalPlayer) end })
DupeSection2:AddInput("RepeatDropItem", { Title = "Loop Item Drop Name:", Default = "", Placeholder = "Inventory Item", Callback = function(Value)
    if Value == "" then return end
    for _, item in pairs(MyInventory:GetChildren()) do
        if string.find(item.Name:lower(), Value:lower()) then
            ItemIndexed = item
            Fluent:Notify({ Title = "Item Selected:", Content = item.Name, Duration = 3 })
            return
        end
    end
    Fluent:Notify({ Title = "Invalid Item", Content = "Item not found", Duration = 3 })
end })
DupeSection2:AddToggle("LoopDropItem", { Title = "Loop Item Drop", Default = false, Callback = function(Value)
    getgenv().configs.AmountToLoopDrop = Value
    if getgenv().configs.AmountToLoopDrop == true then
        if ItemIndexed and ItemIndexed:FindFirstChild('Top'):FindFirstChild('NameLabel') then
            repeat task.wait()
                if IsPlayerAlive(LocalPlayer) then
                    if ItemIndexed.Parent then
                        RemoteEvents['InventoryInteraction']:FireServer(SWITCHEDITEMSTABLE[ItemIndexed.Name], 'Drop')
                    end
                end
            until not ItemIndexed.Parent or not getgenv().configs.AmountToLoopDrop or not IsPlayerAlive(LocalPlayer)
        end
    end
end })

-- ===== AUTOSELL TAB =====
local AutoSellSection2 = Tabs.AutoSell:AddSection("AutoSell (Does not account for pet token multipliers)")
local sellItemsList = {
    { name = "SellSilverBar", title = "4 Silver Bar = 1 Token", item = "Silver Bar", amount = 4, id = 14 },
    { name = "SellSlimeBall", title = "40 Slime Ball = 1 Token", item = "Slime Ball", amount = 40, id = 15 },
    { name = "SellGoldBar", title = "2 Gold Bar = 1 Token", item = "Gold Bar", amount = 2, id = 16 },
    { name = "SellRuby", title = "1 Ruby = 3 Token", item = "Ruby", amount = 1, id = 17 },
    { name = "SellDiamond", title = "1 Diamond = 4 Token", item = "Diamond", amount = 1, id = 18 },
    { name = "SellSoul", title = "1 Soul = 5 Token", item = "Soul", amount = 1, id = 22 },
    { name = "SellZenyte", title = "1 Zenyte = 6 Token", item = "Zenyte", amount = 1, id = 19 },
    { name = "SellVolcanicOre", title = "1 Volcanic Ore = 15 Token", item = "Volcanic Ore", amount = 1, id = 23 },
    { name = "SellObsidian", title = "1 Obsidian = 20 Token", item = "Obsidian", amount = 1, id = 24 },
    { name = "SellLunar", title = "1 Lunar Ore = 25 Token", item = "Lunar Ore", amount = 1, id = 25 },
    { name = "SellMoonstone", title = "1 Moonstone = 30 Token", item = "Moonstone", amount = 1, id = 26 }
}
for _, item in pairs(sellItemsList) do
    AutoSellSection2:AddToggle(item.name, {
        Title = item.title,
        Default = false,
        Callback = function(Value)
            _G[item.name] = Value
            while _G[item.name] and task.wait(0.5) do
                if _G[item.name] then
                    local SoulCheck = (item.item == "Soul" and getgenv().configs.UseSoulKeys)
                    local SellAmount = SoulCheck and 11 or item.amount
                    SellItem(item.item, SellAmount, item.id)
                end
            end
        end
    })
end

local ArmorSection2 = Tabs.AutoSell:AddSection("Armor Trader")
local armorItemsList = {
    { title = "Ruby Shield = 50 Token", id = 27 }, { title = "Diamond Shield = 100 Token", id = 28 },
    { title = "Zenyte Shield = 150 Token", id = 29 }, { title = "Obsidian Shield = 350 Token", id = 30 },
    { title = "Ruby Helmet = 15 Token", id = 31 }, { title = "Ruby Body = 15 Token", id = 32 },
    { title = "Ruby Legs = 15 Token", id = 33 }, { title = "Ruby Boots = 15 Token", id = 34 },
    { title = "Diamond Helmet = 27 Token", id = 35 }, { title = "Diamond Body = 27 Token", id = 36 },
    { title = "Diamond Legs = 27 Token", id = 37 }, { title = "Diamond Boots = 27 Token", id = 38 },
    { title = "Zenyte Helmet = 45 Token", id = 39 }, { title = "Zenyte Body = 45 Token", id = 40 },
    { title = "Zenyte Legs = 45 Token", id = 41 }, { title = "Zenyte Boots = 45 Token", id = 42 },
    { title = "Obsidian Helmet = 115 Token", id = 43 }, { title = "Obsidian Body = 115 Token", id = 44 },
    { title = "Obsidian Legs = 115 Token", id = 45 }, { title = "Obsidian Boots = 115 Token", id = 46 },
    { title = "Moonstone Helmet = 175 Token", id = 47 }, { title = "Moonstone Body = 175 Token", id = 48 },
    { title = "Moonstone Legs = 175 Token", id = 49 }, { title = "Moonstone Boots = 175 Token", id = 50 },
    { title = "Springy Boots", id = 51 }
}
for _, item in pairs(armorItemsList) do
    ArmorSection2:AddButton({ Title = item.title, Callback = function() RemoteEvents['TradeTrader']:FireServer("Armour Trader", item.id) end })
end

local WeaponSection2 = Tabs.AutoSell:AddSection("Weapon Trader")
local weaponItemsList = {
    { title = "Silver Sword = 1 Token", id = 11 }, { title = "Gold Sword = 2 Token", id = 12 },
    { title = "Gold Bow = 3 Token", id = 13 }, { title = "Ruby Sword = 10 Token", id = 14 },
    { title = "Diamond Sword = 18 Token", id = 15 }, { title = "Zenyte Sword = 30 Token", id = 17 },
    { title = "Diamond Crossbow = 36 Token", id = 16 }, { title = "Zenyte Crossbow = 45 Token", id = 18 },
    { title = "Obsidian Club = 80 Token", id = 19 }, { title = "Moonstone Sword = 130 Token", id = 20 }
}
for _, item in pairs(weaponItemsList) do
    WeaponSection2:AddButton({ Title = item.title, Callback = function() RemoteEvents['TradeTrader']:FireServer("Weapon Trader", item.id) end })
end

-- ===== VISUALS TAB =====
local EspSection2 = Tabs.Visuals:AddSection("ESP")
EspSection2:AddToggle("PlayerEsp2", { Title = "ESP", Default = false, Callback = function(Value) getgenv().configs.PlayerEsp = Value PlayerEsp() end })

local VisualsSection3 = Tabs.Visuals:AddSection("Visuals")
VisualsSection3:AddSlider("TimeOfDay", { Title = "Time Of Day", Min = 0.1, Max = 24, Default = Lighting.ClockTime, Rounding = 1, Callback = function(Value) _G.ClockTime = Value if _G.ClockTimeChanged then Lighting.ClockTime = Value end end })
VisualsSection3:AddToggle("ToggleTimeOfDay", { Title = "Lock Time of Day", Default = false, Callback = function(Value)
    _G.ClockTimeChanged = Value
    if Value and _G.ClockTime then
        Lighting.ClockTime = _G.ClockTime
        if not ClockTimeChanged then
            ClockTimeChanged = Lighting.Changed:Connect(function(prop)
                if not _G.ClockTimeChanged then ClockTimeChanged:Disconnect() ClockTimeChanged = nil return end
                if prop == 'ClockTime' then Lighting.ClockTime = _G.ClockTime end
            end)
        end
    else
        if ClockTimeChanged then ClockTimeChanged:Disconnect() ClockTimeChanged = nil end
    end
end })
VisualsSection3:AddSlider("Brightness", { Title = "Brightness", Min = 0.1, Max = 15, Default = Lighting.Brightness, Rounding = 1, Callback = function(Value) _G.Brightness = Value if _G.BrightnessChanged then Lighting.Brightness = Value end end })
VisualsSection3:AddToggle("ToggleBrightness", { Title = "Lock Brightness", Default = false, Callback = function(Value)
    _G.BrightnessChanged = Value
    if Value and _G.Brightness then
        Lighting.Brightness = _G.Brightness
        if not BrightnessChanged then
            BrightnessChanged = Lighting.Changed:Connect(function(prop)
                if not _G.BrightnessChanged then BrightnessChanged:Disconnect() BrightnessChanged = nil return end
                if prop == 'Brightness' then Lighting.Brightness = _G.Brightness end
            end)
        end
    else
        if BrightnessChanged then BrightnessChanged:Disconnect() BrightnessChanged = nil end
    end
end })
VisualsSection3:AddSlider("Saturation", { Title = "Saturation", Min = 0.1, Max = 3, Default = Lighting:WaitForChild('ColorCorrection').Saturation, Rounding = 1, Callback = function(Value) _G.Saturation = Value if _G.SaturationToggle then Lighting:WaitForChild('ColorCorrection').Saturation = Value end end })
VisualsSection3:AddToggle("ToggleSaturation", { Title = "Lock Saturation", Default = false, Callback = function(Value) _G.SaturationToggle = Value if Value and _G.Saturation then Lighting:WaitForChild('ColorCorrection').Saturation = _G.Saturation end end })
VisualsSection3:AddSlider("Contrast", { Title = "Contrast", Min = 0.1, Max = 3, Default = Lighting:WaitForChild('ColorCorrection').Contrast, Rounding = 1, Callback = function(Value) _G.Contrast = Value if _G.ContrastToggle then Lighting:WaitForChild('ColorCorrection').Contrast = Value end end })
VisualsSection3:AddToggle("ToggleContrast", { Title = "Lock Contrast", Default = false, Callback = function(Value) _G.ContrastToggle = Value if Value and _G.Contrast then Lighting:WaitForChild('ColorCorrection').Contrast = _G.Contrast end end })
VisualsSection3:AddSlider("FogEnd", { Title = "Fog Density", Min = 0.1, Max = 15, Default = Lighting:WaitForChild('Atmosphere').Density, Rounding = 1, Callback = function(Value) _G.FogEnd = Value if _G.FogEndToggle then Lighting:WaitForChild('Atmosphere').Density = Value end end })
VisualsSection3:AddToggle("ToggleFogEnd", { Title = "Lock Fog Density", Default = false, Callback = function(Value) _G.FogEndToggle = Value if Value and _G.FogEnd then Lighting:WaitForChild('Atmosphere').Density = _G.FogEnd end end })
VisualsSection3:AddSlider("WaterTransparency", { Title = "Water Transparency", Min = 0, Max = 31, Default = Workspace:WaitForChild('Terrain').WaterTransparency, Rounding = 1, Callback = function(Value) _G.WaterTransparency = Value if _G.WaterTransparencyToggle then Workspace:WaitForChild('Terrain').WaterTransparency = Value end end })
VisualsSection3:AddToggle("ToggleWaterTransparency", { Title = "Lock Water Transparency", Default = false, Callback = function(Value) _G.WaterTransparencyToggle = Value if Value and _G.WaterTransparency then Workspace:WaitForChild('Terrain').WaterTransparency = _G.WaterTransparency end end })
VisualsSection3:AddColorPicker("WaterColor", { Title = "Water Color", Default = Color3.fromRGB(Workspace:WaitForChild('Terrain').WaterColor.R*255, Workspace:WaitForChild('Terrain').WaterColor.G*255, Workspace:WaitForChild('Terrain').WaterColor.B*255), Callback = function(Value) Workspace:WaitForChild('Terrain').WaterColor = Value end })

-- ===== CREDITS TAB =====
local CreditSection2 = Tabs.Credits:AddSection("Credits")
CreditSection2:AddParagraph({ Title = "Made By", Content = "Chung" })
CreditSection2:AddParagraph({ Title = "Credit", Content = "Chungdz" })

-- ===== LƯU CONFIG =====
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("IslandTribes")
SaveManager:SetFolder("IslandTribes/saves")
SaveManager:BuildConfigSection(Window)
InterfaceManager:BuildInterfaceSection(Window)
Window:SelectTab(1)

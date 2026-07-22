local cloneref = cloneref or function(obj) return obj end
local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Workspace = cloneref(game:GetService("Workspace"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local LocalPlayer = Players.LocalPlayer

getgenv().configs = getgenv().configs or {}
getgenv().configs.ChestType = "Any"
getgenv().ItemToPutInChest = ""
getgenv().AmountOfChestInserts = 1

local MenusFolder = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Menus")

local RemoteEvents = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events")
local UpdateStorageRemote = RemoteEvents:WaitForChild("UpdateStorageChest")
local SetSettingsRemote = RemoteEvents:WaitForChild("SetSettings")

local ALLITEMS = {
    [1] = "Stick", [2] = "Small Raft", [3] = "Small Campfire", [4] = "Wood Boots", [5] = "Wooden Harvester", 
    [6] = "Wood Helmet", [7] = "Wooden Club", [8] = "Leather Bag", [9] = "Wood Body", [10] = "Wood Legs", 
    [11] = "Wood Storage Chest", [12] = "Wood Bridge", [13] = "Wood Wall", [14] = "Teepee", [15] = "Plant Box", 
    [16] = "Hardleather Bag", [17] = "Stone Boots", [18] = "Stone Harvester", [19] = "Wooden Sword", [20] = "Large Campfire", 
    [21] = "Stone Helmet", [22] = "Party Raft", [23] = "Wood Gate", [24] = "Reinforced Bag", [25] = "Stone Body", 
    [26] = "Stone Legs", [27] = "Stone Storage Chest", [28] = "Furnace", [29] = "Silver Boots", [30] = "Wooden Bow", 
    [31] = "Arrow", [32] = "Stone Wall", [33] = "Silver Helmet", [34] = "Stone Sword", [35] = "Fishing Rod", 
    [36] = "Stone Gate", [37] = "Silver Bag", [38] = "Silver Harvester", [39] = "Silver Body", [40] = "Silver Legs", 
    [41] = "Silver Storage Chest", [42] = "Ladder", [43] = "Gold Boots", [44] = "Silver Sword", [45] = "Stone Land Bridge", 
    [46] = "Silver Wall", [47] = "Gold Helmet", [48] = "Bed", [49] = "Stone Bridge", [50] = "Silver Gate", 
    [51] = "Golden Harvester", [52] = "Gold Body", [53] = "Gold Legs", [54] = "Gold Storage Chest", [55] = "Golden Bag", 
    [56] = "Ruby Boots", [57] = "Golden Sword", [58] = "Gold Wall", [59] = "Ruby Helmet", [60] = "Tent Raft", 
    [61] = "Golden Bow", [62] = "Gold Gate", [63] = "Ruby Harvester", [64] = "Ruby Body", [65] = "Ruby Legs", 
    [66] = "Ruby Storage Chest", [67] = "Diamond Boots", [68] = "Ruby Sword", [69] = "Ruby Bag", [70] = "Diamond Harvester", 
    [71] = "Diamond Helmet", [72] = "Ruby Wall", [73] = "Diamond Body", [74] = "Diamond Legs", [75] = "Ruby Gate", 
    [76] = "Diamond Storage Chest", [77] = "Ruby Bow", [78] = "Diamond Wall", [79] = "Diamond Gate", [80] = "Diamond Bag", 
    [81] = "Small Log", [82] = "Big Log", [83] = "Small Rock", [84] = "Large Rock", [85] = "Raw Fish", 
    [86] = "Cooked Fish", [87] = "Raw Meat", [88] = "Cooked Meat", [89] = "Silver Ore", [90] = "Silver Bar", 
    [91] = "Gold Ore", [92] = "Gold Bar", [93] = "Unrefined Ruby", [94] = "Ruby", [95] = "Unrefined Diamond", 
    [96] = "Diamond", [97] = "Redberry", [98] = "Coconut", [99] = "Watermelon", [100] = "Watermelon Seeds", 
    [101] = "Carrot", [102] = "Carrot Seeds", [103] = "Raw Potato", [104] = "Potato Seeds", [105] = "Banana", 
    [106] = "Leaves", [107] = "Leather", [108] = "Feather", [109] = "Feather Stack", [110] = "Arrow Stack", 
    [111] = "Freshy Chest", [112] = "Stone Supplies", [113] = "Wooden Warrior Pack", [114] = "Feather Pack", [115] = "Arrow Pack", 
    [116] = "Silver Warrior Pack", [117] = "Fisherman's Pack", [118] = "Golden Archer Pack", [119] = "Ruby Hero Pack", [120] = "Infinite Campfire", 
    [121] = "Bowling Pins", [122] = "Cabbage", [123] = "Cabbage Seeds", [124] = "Torch", [125] = "Tiki Torch", 
    [126] = "Baked Potato", [127] = "Small Wood Base", [128] = "Medium Wood Base", [129] = "Large Wood Base", [130] = "Small Stone Base", 
    [131] = "Medium Stone Base", [132] = "Large Stone Base", [133] = "Repair Hammer", [134] = "Unrefined Zenyte", [135] = "Zenyte", 
    [136] = "Totem", [137] = "Caveberry", [138] = "Slime Ball", [139] = "Slime Helmet", [140] = "Slime Body", 
    [141] = "Slime Legs", [142] = "Slime Boots", [143] = "Slimy Pack", [144] = "Zenyte Helmet", [145] = "Zenyte Body", 
    [146] = "Zenyte Storage Chest", [147] = "Zenyte Legs", [148] = "Zenyte Boots", [149] = "Zenyte Wall", [150] = "Zenyte Gate", 
    [151] = "Zenyte Bag", [152] = "Slime Club", [153] = "Zenyte Harvester", [154] = "Diamond Sword", [155] = "Wooden Mine Cart", 
    [156] = "Party Cart", [157] = "Silver Mine Cart", [158] = "Ruby Mine Cart", [159] = "Zenyte Mine Cart", [160] = "Coal", 
    [161] = "Infinite Furnace", [162] = "Beginner Wand", [163] = "Clue Scroll (Easy)", [164] = "Clue Scroll (Medium)", [165] = "Clue Scroll (Hard)", 
    [166] = "Treasure Chest (Easy)", [167] = "Treasure Chest (Medium)", [168] = "Treasure Chest (Hard)", [169] = "Shovel", [170] = "Clue Bottle (Easy)", 
    [171] = "Clue Bottle (Medium)", [172] = "Clue Bottle (Hard)", [173] = "Lucky Sword", [174] = "Lucky Bow", [175] = "Lucky Helmet", 
    [176] = "Lucky Body", [177] = "Lucky Legs", [178] = "Lucky Boots", [179] = "Lucky Harvester", [180] = "Lucky Fruit", 
    [181] = "Candy", [182] = "Kerosene Lamp", [183] = "Sleigh", [184] = "Magical Sleigh", [185] = "Grinch's Sleigh", 
    [186] = "Candy Bag", [187] = "Pile of Candy", [188] = "Candy Pack", [189] = "Explorer Energy", [190] = "Cave Door Key (d)", 
    [191] = "Key Handle (d)", [192] = "Key Shaft (d)", [193] = "Cave Door Key (z)", [194] = "Key Handle (z)", [195] = "Key Shaft (z)", 
    [196] = "Stone Anvil", [197] = "Silver Crossbow", [198] = "Diamond Crossbow", [199] = "Zenyte Crossbow", [200] = "Soul", 
    [201] = "Soul Helmet", [202] = "Soul Body", [203] = "Soul Legs", [204] = "Soul Boots", [205] = "Zenyte Sword", 
    [206] = "Wooden Shield", [207] = "Silver Shield", [208] = "Golden Shield", [209] = "Ruby Shield", [210] = "Diamond Shield", 
    [211] = "Zenyte Shield", [212] = "Golden Anvil", [213] = "Diamond Anvil", [214] = "Cave Key Pack", [215] = "OP Sword", 
    [216] = "Soul Sword", [217] = "Soul Bag", [218] = "Soul Shield", [219] = "Lucky Shield", [220] = "Soul Key", 
    [221] = "Pirate Ship", [222] = "Springy Boots", [223] = "Volcanic Ore", [224] = "Obsidian", [225] = "Obsidian Helmet", 
    [226] = "Obsidian Body", [227] = "Obsidian Legs", [228] = "Obsidian Boots", [229] = "Volcanic Furnace", [230] = "Obsidian Club", 
    [231] = "Obsidian Wall", [232] = "Obsidian Gate", [233] = "Obsidian Storage Chest", [234] = "Harpoon Turret", [235] = "Obsidian Shield", 
    [236] = "Obsidian Bag", [237] = "Instakill Sword", [238] = "Pearl Helmet", [239] = "Pearl Body", [240] = "Pearl Legs", 
    [241] = "Pearl Boots", [242] = "Raw Seaweed", [243] = "Cooked Seaweed", [244] = "Pink Shell", [245] = "White Shell", 
    [246] = "Orange Shell", [247] = "Pearl", [248] = "Seaglass", [249] = "Seaglass Helmet", [250] = "Seaglass Body", 
    [251] = "Seaglass Legs", [252] = "Seaglass Boots", [253] = "White Shell Sword", [254] = "Pink Shell Sword", [255] = "Orange Shell Sword", 
    [256] = "White Shell Harvester", [257] = "Pink Shell Harvester", [258] = "Orange Shell Harvester", [259] = "Shell Helmet", [260] = "Shell Body", 
    [261] = "Shell Legs", [262] = "Flippers", [263] = "Poison Seaweed", [264] = "Stone Trap", [265] = "Ruby Trap", 
    [266] = "Zenyte Trap", [267] = "Pink Egg", [268] = "Purple Egg", [269] = "Red Egg", [270] = "Yellow Egg", 
    [271] = "Easter Candy", [272] = "Easter Glider", [273] = "Repairio Spellbook", [274] = "Warrior Energy", [275] = "Protector Energy", 
    [276] = "Magic Portal", [277] = "Healing Aura", [278] = "Electric Aura", [279] = "Hunger Aura", [280] = "Book of Exploration (I)", 
    [281] = "Book of Exploration (II)", [282] = "Book of Exploration (III)", [283] = "Book of Protection (I)", [284] = "Book of Protection (II)", [285] = "Book of Protection (III)", 
    [286] = "Book of Combat (I)", [287] = "Book of Combat (II)", [288] = "Book of Combat (III)", [289] = "Apprentice Wand", [290] = "Adept Staff", 
    [291] = "Master Staff", [292] = "Transcended Staff", [293] = "Visionary Staff", [294] = "Wool", [295] = "Book", 
    [296] = "Magical Book", [297] = "Obsidian Harvester", [298] = "Magic Repair Table (I)", [299] = "Magic Repair Table (II)", [300] = "Magic Repair Table (III)", 
    [301] = "Glider", [302] = "Imbue Spellbook", [303] = "Shieldio Spellbook", [304] = "Hungaria Spellbook", [305] = "Baseio Retreatio Spellbook", 
    [306] = "Healia Spellbook", [307] = "Deadia Protectia Spellbook", [308] = "Baseio Destroyio Spellbook", [309] = "Oofio Spellbook", [310] = "Freezio Spellbook", 
    [311] = "Starvio Spellbook", [312] = "Electricia Spellbook", [313] = "Portalio Spellbook", [314] = "Protectio Claimio Spellbook", [315] = "Warrio Claimio Spellbook", 
    [316] = "Explorer Energy Pack", [317] = "Protector Energy Pack", [318] = "Warrior Energy Pack", [319] = "Explorer Energy Stack", [320] = "Protector Energy Stack", 
    [321] = "Warrior Energy Stack", [322] = "Infinite Bag", [323] = "Deflectio Projectio Spellbook", [324] = "Seed Pack", [325] = "Fruit Pack", 
    [326] = "Diamond Hero Pack", [327] = "Zenyte Warrior Pack", [328] = "Box of Redberries", [329] = "Box of Coconuts", [330] = "Box of Bananas", 
    [331] = "Box of Watermelons", [332] = "Potato Seed Box", [333] = "Cabbage Seed Box", [334] = "Carrot Seed Box", [335] = "Watermelon Seed Box", 
    [336] = "Halloween Pumpkin", [337] = "Jack-o'-lantern", [338] = "Weak Pet Net", [339] = "Sturdy Pet Net", [340] = "Strong Pet Net", 
    [341] = "Unbreakable Pet Net", [342] = "Christmas Present", [343] = "Snowball", [344] = "Obsidian Floor", [345] = "Pile of Snowballs", 
    [346] = "Snowball Pack", [347] = "Silver Snowball", [348] = "Golden Snowball", [349] = "Ruby Snowball", [350] = "Diamond Snowball", 
    [351] = "Zenyte Snowball", [352] = "Obsidian Snowball", [353] = "Candy Snowball", [354] = "Starter Sword", [355] = "Starter Harvester", 
    [356] = "Starter Helmet", [357] = "Starter Body", [358] = "Starter Legs", [359] = "Starter Boots", [360] = "Lunar Ore", 
    [361] = "Moonstone", [362] = "Lunario Enchantio Spellbook", [363] = "Moonstone Helmet", [364] = "Moonstone Body", [365] = "Moonstone Legs", 
    [366] = "Moonstone Boots", [367] = "Moonstone Shield", [368] = "Moonstone Harvester", [369] = "Moonstone Sword", [370] = "Moonstone Bag", 
    [371] = "Potion Cauldron", [372] = "Candy Potion", [373] = "Moonstone Storage Chest", [374] = "Moonstone Wall", [375] = "Moonstone Gate", 
    [376] = "Moonstone Crossbow", [377] = "Lunar Arrow", [378] = "Pumpkin", [379] = "Pumpkin Shield", [380] = "Pumpkin Bag", 
    [381] = "Pumpkin Seeds", [382] = "Treasure Chest Pack"
}

local SWITCHEDITEMSTABLE = {}
for id, name in pairs(ALLITEMS) do
    SWITCHEDITEMSTABLE[name] = id
end

local function IsPlayerAlive(player)
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local function GetClosestFilteredChest()
    local replicators = Workspace:FindFirstChild("Replicators")
    if not replicators then return nil end
    local CheckPassiveOrNonPassive = replicators:FindFirstChild('NonPassive') and 'NonPassive' or 'Passive'
    
    local closest = nil
    local range = math.huge
    
    if IsPlayerAlive(LocalPlayer) then
        local HRP = LocalPlayer.Character.HumanoidRootPart
        for _, chest in pairs(replicators:WaitForChild(CheckPassiveOrNonPassive):GetChildren()) do
            if string.find(chest.Name:lower(), 'storage') and chest:FindFirstChildOfClass('MeshPart') then
                if getgenv().configs.ChestType == 'Any' or string.find(chest.Name:lower(), getgenv().configs.ChestType:lower()) then
                    local dist = (HRP.Position - chest:FindFirstChildOfClass('MeshPart').Position).Magnitude
                    if dist < range then
                        range = dist
                        closest = chest
                    end
                end
            end
        end
    end
    return closest
end

if _G.CustomPurpleBarUI then _G.CustomPurpleBarUI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomPurpleBarUI_Root"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
_G.CustomPurpleBarUI = ScreenGui
pcall(function() ScreenGui.Parent = cloneref(game:GetService("CoreGui")) end)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(0.705, 0, 0.115, 0)
TopBar.Position = UDim2.new(0.151, 0, 0.178, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopBar.Active = true
TopBar.Parent = ScreenGui

local TopBarCorner = Instance.new("UICorner", TopBar)
TopBarCorner.CornerRadius = UDim.new(0, 6)

local TopBarStroke = Instance.new("UIStroke", TopBar)
TopBarStroke.Color = Color3.fromRGB(48, 16, 77)
TopBarStroke.Thickness = 3
TopBarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0.797, -15, 0, 10) 
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20 
CloseBtn.Parent = ScreenGui

local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(1, 0)

local CloseStroke = Instance.new("UIStroke", CloseBtn)
CloseStroke.Color = Color3.fromRGB(255, 255, 255)
CloseStroke.Thickness = 2

local function CreateBarComponent(class, name, text, xPosScale)
    local element = Instance.new(class)
    element.Size = UDim2.new(1/6, 0, 1, 0)
    element.Position = UDim2.new(xPosScale, 0, 0, 0)
    element.BackgroundTransparency = 1
    element.Text = text
    element.TextColor3 = Color3.fromRGB(255, 255, 255)
    element.Font = Enum.Font.SourceSansBold
    element.TextSize = 14
    element.Parent = TopBar
    return element
end

local DupeButton = CreateBarComponent("TextButton", "DupeBtn", "Dupe", 0/6)
local StoreButton = CreateBarComponent("TextButton", "StoreBtn", "Store", 1/6)
local UnstoreButton = CreateBarComponent("TextButton", "UnstoreBtn", "Unstore", 2/6)
local AmountBox = CreateBarComponent("TextButton", "AmountBtn", "Amount: 1", 3/6)
local ChestButton = CreateBarComponent("TextButton", "ChestDropdownBtn", "Chest: Any", 4/6)
local ItemButton = CreateBarComponent("TextButton", "ItemDropdownBtn", "Item: ...", 5/6)

local function CreateDropdownBase(parentBtn)
    local Menu = Instance.new("Frame")
    Menu.Size = UDim2.new(0, 100, 0, 200)
    Menu.Position = UDim2.new(0, 0, 1, 5)
    Menu.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Menu.Visible = false
    Menu.ZIndex = 5
    Menu.Parent = parentBtn
    
    local MenuCorner = Instance.new("UICorner", Menu)
    MenuCorner.CornerRadius = UDim.new(0, 6)
    
    local MenuStroke = Instance.new("UIStroke", Menu)
    MenuStroke.Color = Color3.fromRGB(48, 16, 77)
    MenuStroke.Thickness = 3
    MenuStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, 0, 1, 0)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 4
    Scroll.ZIndex = 6
    Scroll.Parent = Menu
    Instance.new("UIListLayout", Scroll)
    
    return Menu, Scroll
end

local ChestDropdownMenu, ChestMenuScroll = CreateDropdownBase(ChestButton)
local ItemDropdownMenu, ItemMenuScroll = CreateDropdownBase(ItemButton)

for _, option in ipairs({'Any', 'Wood', 'Stone', 'Silver', 'Gold', 'Ruby', 'Diamond', 'Zenyte', 'Obsidian', 'Moonstone'}) do
    local btn = Instance.new("TextButton", ChestMenuScroll)
    btn.Size = UDim2.new(1, 0, 0, 30); btn.Text = option; btn.BackgroundTransparency = 0.9; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.ZIndex = 6
    btn.MouseButton1Click:Connect(function() 
        getgenv().configs.ChestType = option; ChestButton.Text = "Chest: " .. option; ChestDropdownMenu.Visible = false 
    end)
end

local AmountMenu = Instance.new("Frame")
AmountMenu.Size = UDim2.new(0, 100, 0, 200)
AmountMenu.Position = UDim2.new(0, 0, 1, 5)
AmountMenu.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AmountMenu.Visible = false
AmountMenu.ZIndex = 5
AmountMenu.Parent = AmountBox

local AmountMenuCorner = Instance.new("UICorner", AmountMenu)
AmountMenuCorner.CornerRadius = UDim.new(0, 6)

local AmountMenuStroke = Instance.new("UIStroke", AmountMenu)
AmountMenuStroke.Color = Color3.fromRGB(48, 16, 77)
AmountMenuStroke.Thickness = 3
AmountMenuStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local TopLabel = Instance.new("TextLabel")
TopLabel.Size = UDim2.new(1, 0, 0, 20); TopLabel.Position = UDim2.new(0, 0, 0, 5)
TopLabel.BackgroundTransparency = 1; TopLabel.Text = "200"; TopLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TopLabel.Font = Enum.Font.SourceSansBold; TopLabel.TextSize = 14; TopLabel.ZIndex = 6; TopLabel.Parent = AmountMenu

local BottomLabel = Instance.new("TextLabel")
BottomLabel.Size = UDim2.new(1, 0, 0, 20); BottomLabel.Position = UDim2.new(0, 0, 1, -25)
BottomLabel.BackgroundTransparency = 1; BottomLabel.Text = "1"; BottomLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
BottomLabel.Font = Enum.Font.SourceSansBold; BottomLabel.TextSize = 14; BottomLabel.ZIndex = 6; BottomLabel.Parent = AmountMenu

local SliderTrack = Instance.new("Frame")
SliderTrack.Size = UDim2.new(0, 6, 0, 140)
SliderTrack.Position = UDim2.new(0.5, -3, 0.5, -70)
SliderTrack.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SliderTrack.BorderSizePixel = 0
SliderTrack.ZIndex = 6
SliderTrack.Parent = AmountMenu

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(1, 0, 0, 0) 
SliderFill.Position = UDim2.new(0, 0, 1, 0) 
SliderFill.AnchorPoint = Vector2.new(0, 1)
SliderFill.BackgroundColor3 = Color3.fromRGB(48, 16, 77)
SliderFill.BorderSizePixel = 0
SliderFill.ZIndex = 7
SliderFill.Parent = SliderTrack

local SliderKnob = Instance.new("Frame")
SliderKnob.Size = UDim2.new(0, 16, 0, 16)
SliderKnob.Position = UDim2.new(0.5, -8, 1, -8)
SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderKnob.ZIndex = 8
SliderKnob.Parent = SliderTrack

local KnobCorner = Instance.new("UICorner", SliderKnob)
KnobCorner.CornerRadius = UDim.new(1, 0)

local SliderInteractArea = Instance.new("TextButton")
SliderInteractArea.Size = UDim2.new(1, 0, 1, 0)
SliderInteractArea.BackgroundTransparency = 1
SliderInteractArea.Text = ""
SliderInteractArea.ZIndex = 9
SliderInteractArea.Parent = AmountMenu

local draggingAmount = false

local function updateSlider(input)
    local relativeY = input.Position.Y - SliderTrack.AbsolutePosition.Y
    local percent = math.clamp(1 - (relativeY / SliderTrack.AbsoluteSize.Y), 0, 1)
    
    local value = math.floor(1 + (percent * 199) + 0.5)
    getgenv().AmountOfChestInserts = value
    AmountBox.Text = "Amount: " .. value
    
    SliderFill.Size = UDim2.new(1, 0, percent, 0)
    SliderKnob.Position = UDim2.new(0.5, -8, 1 - percent, -8)
end

SliderInteractArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingAmount = true
        updateSlider(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingAmount = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingAmount and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSlider(input)
    end
end)

local function RebuildItemDropdown()
    for _, child in pairs(ItemMenuScroll:GetChildren()) do 
        if child:IsA("TextButton") then child:Destroy() end 
    end
    
    local ItemsToPutInChest = {}
    local added = {}

    local InventoryFrame = MenusFolder:FindFirstChild("Inventory")
    local InventorySubFrame = InventoryFrame and InventoryFrame:FindFirstChild("Inventory")
    local ActiveList = InventorySubFrame and InventorySubFrame:FindFirstChild("List")

    if ActiveList then
        for _, itemFrame in pairs(ActiveList:GetChildren()) do
            if SWITCHEDITEMSTABLE[itemFrame.Name] then

                if not added[itemFrame.Name] then
                    added[itemFrame.Name] = true
                    table.insert(ItemsToPutInChest, itemFrame.Name)
                end
            end
        end
    end
    
    table.sort(ItemsToPutInChest)

    for _, itemName in ipairs(ItemsToPutInChest) do
        local btn = Instance.new("TextButton", ItemMenuScroll)
        btn.Size = UDim2.new(1, 0, 0, 30) 
        btn.Text = itemName 
        btn.BackgroundTransparency = 0.9
        btn.TextColor3 = Color3.fromRGB(255, 255, 255) 
        btn.ZIndex = 6
        
        btn.MouseButton1Click:Connect(function() 
            getgenv().ItemToPutInChest = itemName 
            ItemButton.Text = "Item: " .. itemName 
            ItemDropdownMenu.Visible = false 
        end)
    end
    
    ItemMenuScroll.CanvasSize = UDim2.new(0, 0, 0, #ItemsToPutInChest * 30)
end

RebuildItemDropdown()

local TargetInventoryFrame = MenusFolder:WaitForChild("Inventory", 5)
local TargetInventorySubFrame = TargetInventoryFrame and TargetInventoryFrame:WaitForChild("Inventory", 5)
local TargetActiveList = TargetInventorySubFrame and TargetInventorySubFrame:WaitForChild("List", 5)

if TargetActiveList then
    if getgenv().InventoryAddedConnection then getgenv().InventoryAddedConnection:Disconnect() end
    if getgenv().InventoryRemovedConnection then getgenv().InventoryRemovedConnection:Disconnect() end
    
    getgenv().InventoryAddedConnection = TargetActiveList.ChildAdded:Connect(function(child)
        task.wait(0.1) 
        RebuildItemDropdown()
    end)
    getgenv().InventoryRemovedConnection = TargetActiveList.ChildRemoved:Connect(function(child)
        task.wait(0.1) 
        RebuildItemDropdown()
    end)
end

CloseBtn.MouseButton1Click:Connect(function()
    if _G.CustomPurpleBarUI then _G.CustomPurpleBarUI:Destroy() end
end)

StoreButton.MouseButton1Click:Connect(function()
    local chest = GetClosestFilteredChest()
    if chest then for i=1, getgenv().AmountOfChestInserts do UpdateStorageRemote:FireServer(chest, true, SWITCHEDITEMSTABLE[getgenv().ItemToPutInChest]) end end
end)

UnstoreButton.MouseButton1Click:Connect(function()
    local chest = GetClosestFilteredChest()
    if chest then for i=1, getgenv().AmountOfChestInserts do UpdateStorageRemote:FireServer(chest, false, SWITCHEDITEMSTABLE[getgenv().ItemToPutInChest]) end end
end)

AmountBox.MouseButton1Click:Connect(function() AmountMenu.Visible = not AmountMenu.Visible end)
ChestButton.MouseButton1Click:Connect(function() ChestDropdownMenu.Visible = not ChestDropdownMenu.Visible end)
ItemButton.MouseButton1Click:Connect(function() RebuildItemDropdown(); ItemDropdownMenu.Visible = not ItemDropdownMenu.Visible end)

DupeButton.MouseButton1Click:Connect(function()
    if DupeButton.Text == "Dupe: Active" then return end
    
    for i = 1, 10 do
        getgenv().olddata = game:GetService("ReplicatedStorage").References.Comm.Events.SetSettings
        game:GetService("ReplicatedStorage").References.Comm.Events.SetSettings:FireServer(getgenv().olddata)
    end
    
    DupeButton.Text = "Dupe: Active"
end)

local DragHandle = Instance.new("Frame")
DragHandle.Size = UDim2.new(0.1, 0, 0, 8) 
DragHandle.Position = UDim2.new(0.5, 0, 1, -3)
DragHandle.AnchorPoint = Vector2.new(0.5, 0.5)
DragHandle.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
DragHandle.BackgroundTransparency = 0.5
DragHandle.BorderSizePixel = 0
DragHandle.Parent = TopBar
DragHandle.Active = true
DragHandle.ZIndex = TopBar.ZIndex + 10

local dragging = false
local dragStart, startPos

DragHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = TopBar.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        TopBar.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

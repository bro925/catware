local repo = 'https://raw.githubusercontent.com/bro925/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'catware - Blox Fruits',
    Center = true,
    AutoShow = true,
    TabPadding = 0
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    Farming = Window:AddTab('Farming'),
    Visuals = Window:AddTab('Visuals'),
    Movement = Window:AddTab('Movement'),
    Player = Window:AddTab('Player'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- // ============================================================== Variables ============================================================== \\ --

local charFolder = workspace:FindFirstChild("Characters")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local NetModule = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"))
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local CommE = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommE")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LightingService = game:GetService("Lighting")

local plr = game.Players.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local character2 = charFolder:FindFirstChild(plr.Name)

local First_Sea = false
local Second_Sea = false
local Third_Sea = false
local placeId = game.PlaceId
if placeId == 2753915549 then First_Sea = true
elseif placeId == 4442272183 then Second_Sea = true
elseif placeId == 7449423635 then Third_Sea = true
end

local swordList = {
    "Cutlass","Katana","Dual Katana","Triple Katana","Iron Mace","Shark Saw",
    "Twin Hooks","Dragon Trident","Dual-Headed Blade","Flail","Gravity Blade",
    "Longsword","Pipe","Soul Cane","Trident","Wardens Sword","Bisento",
    "Buddy Sword","Canvander","Dark Dagger","Dragonheart","Fox Lamp","Koko",
    "Midnight Blade","Oroshi","Pole (1st Form)","Pole (2nd Form)","Rengoku",
    "Saber","Saishi","Shark Anchor","Shizu","Spikey Trident","Tushita",
    "Yama","Cursed Dual Katana","Dark Blade","Hallow Scythe","True Triple Katana"
}

local quests = {
    ["[Lv.1] Bandit"] = {"BanditQuest1", 1, "First"},
    ["[Lv.10] Monkey"] = {"JungleQuest", 1, "First"},
    ["[Lv.15] Gorilla"] = {"JungleQuest", 2, "First"},
    ["[Lv.25] The Gorilla King [Boss]"] = {"JungleQuest", 3, "First"},
    ["[Lv.30] Pirate"] = {"BuggyQuest1", 1, "First"},
    ["[Lv.40] Brute"] = {"BuggyQuest1", 2, "First"},
    ["[Lv.55] Chef [Boss]"] = {"BuggyQuest1", 3, "First"},
    ["[Lv.60] Desert Bandit"] = {"DesertQuest", 1, "First"},
    ["[Lv.75] Desert Officer"] = {"DesertQuest", 2, "First"},
    ["[Lv.90] Snow Bandit"] = {"SnowQuest", 1, "First"},
    ["[Lv.100] Snowman"] = {"SnowQuest", 2, "First"},
    ["[Lv.110] Yeti [Boss]"] = {"SnowQuest", 3, "First"},
    ["[Lv.120] Chief Petty Officer"] = {"MarineQuest2", 1, "First"},
    ["[Lv.130] Vice Admiral [Boss]"] = {"MarineQuest2", 2, "First"},
    ["[Lv.150] Sky Bandit"] = {"SkyQuest", 1, "First"},
    ["[Lv.175] Dark Master"] = {"SkyQuest", 2, "First"},
    ["[Lv.190] Prisoner"] = {"PrisonerQuest", 1, "First"},
    ["[Lv.210] Dangerous Prisoner"] = {"PrisonerQuest", 2, "First"},
    ["[Lv.220] Warden [Boss]"] = {"ImpelQuest", 1, "First"},
    ["[Lv.230] Chief Warden [Boss]"] = {"ImpelQuest", 2, "First"},
    ["[Lv.240] Swan [Boss]"] = {"ImpelQuest", 3, "First"},
    ["[Lv.250] Toga Warrior"] = {"ColosseumQuest", 1, "First"},
    ["[Lv.275] Gladiator"] = {"ColosseumQuest", 2, "First"},
    ["[Lv.300] Military Soldier"] = {"MagmaQuest", 1, "First"},
    ["[Lv.325] Military Spy"] = {"MagmaQuest", 2, "First"},
    ["[Lv.350] Magma Admiral [Boss]"] = {"MagmaQuest", 3, "First"},
    ["[Lv.375] Fishman Warrior"] = {"FishmanQuest", 1, "First"},
    ["[Lv.400] Fishman Commando"] = {"FishmanQuest", 2, "First"},
    ["[Lv.425] Fishman Lord [Boss]"] = {"FishmanQuest", 3, "First"},
    ["[Lv.450] God's Guard"] = {"SkyExp1Quest", 1, "First"},
    ["[Lv.475] Shanda"] = {"SkyExp1Quest", 2, "First"},
    ["[Lv.500] Wysper [Boss]"] = {"SkyExp1Quest", 3, "First"},
    ["[Lv.525] Royal Squad"] = {"SkyExp2Quest", 1, "First"},
    ["[Lv.550] Royal Soldier"] = {"SkyExp2Quest", 2, "First"},
    ["[Lv.575] Thunder God"] = {"SkyExp2Quest", 3, "First"},
    ["[Lv.625] Galley Pirate"] = {"FountainQuest", 1, "First"},
    ["[Lv.650] Galley Captain"] = {"FountainQuest", 2, "First"},
    ["[Lv.675] Cyborg [Boss]"] = {"FountainQuest", 3, "First"},
    ["[Lv.700] Raider"] = {"Area1Quest", 1, "Second"},
    ["[Lv.725] Mercenary"] = {"Area1Quest", 2, "Second"},
    ["[Lv.750] Diamond [Boss]"] = {"Area1Quest", 3, "Second"},
    ["[Lv.775] Swan Pirate"] = {"Area2Quest", 1, "Second"},
    ["[Lv.800] Factory Staff"] = {"Area2Quest", 2, "Second"},
    ["[Lv.850] Jeremy [Boss]"] = {"Area2Quest", 3, "Second"},
    ["[Lv.875] Marine Lieutenant"] = {"MarineQuest3", 1, "Second"},
    ["[Lv.900] Marine Captain"] = {"MarineQuest3", 2, "Second"},
    ["[Lv.925] Fajita [Boss]"] = {"MarineQuest3", 3, "Second"},
    ["[Lv.925] Zombie"] = {"ZombieQuest", 1, "Second"},
    ["[Lv.950] Vampire"] = {"ZombieQuest", 2, "Second"},
    ["[Lv.1000] Snow Trooper"] = {"SnowMountainQuest", 1, "Second"},
    ["[Lv.1025] Winter Warrior"] = {"SnowMountainQuest", 2, "Second"},
    ["[Lv.1100] Lab Subordinate"] = {"IceSideQuest", 1, "Second"},
    ["[Lv.1125] Horned Warrior"] = {"IceSideQuest", 2, "Second"},
    ["[Lv.1100] Smoke Admiral [Boss]"] = {"IceSideQuest", 3, "Second"},
    ["[Lv.1175] Magma Ninja"] = {"FireSideQuest", 1, "Second"},
    ["[Lv.1200] Lava Pirate"] = {"FireSideQuest", 2, "Second"},
    ["[Lv.1250] Ship Officer"] = {"ShipQuest1", 1, "Second"},
    ["[Lv.1275] Ship Steward"] = {"ShipQuest1", 2, "Second"},
    ["[Lv.1300] Ship Engineer"] = {"ShipQuest2", 1, "Second"},
    ["[Lv.1325] Ship Deckhand"] = {"ShipQuest2", 2, "Second"},
    ["[Lv.1350] Arctic Warrior"] = {"FrostQuest", 1, "Second"},
    ["[Lv.1375] Snow Bandit"] = {"FrostQuest", 2, "Second"},
    ["[Lv.1400] Awakened Ice Admiral [Boss]"] = {"FrostQuest", 3, "Second"},
    ["[Lv.1425] Sea Soldier"] = {"ForgottenQuest", 1, "Second"},
    ["[Lv.1450] Water Fighter"] = {"ForgottenQuest", 2, "Second"},
    ["[Lv.1475] Tide Keeper [Boss]"] = {"ForgottenQuest", 3, "Second"},
    ["[Lv.1500] Pirate Billionaire"] = {"PortQuest", 1, "Third"},
    ["[Lv.1525] Pirate Millionaire"] = {"PortQuest", 2, "Third"},
    ["[Lv.1550] Stone [Boss]"] = {"PortQuest", 3, "Third"},
    ["[Lv.1600] Dragon Crew Warrior"] = {"AmazonQuest", 1, "Third"},
    ["[Lv.1625] Dragon Crew Archer"] = {"AmazonQuest", 2, "Third"},
    ["[Lv.1675] Island Empress [Boss]"] = {"AmazonQuest2", 3, "Third"},
    ["[Lv.1700] Female Warrior"] = {"AmazonQuest2", 1, "Third"},
    ["[Lv.1725] Giant Islander"] = {"AmazonQuest2", 2, "Third"},
    ["[Lv.1750] Kilo Admiral [Boss]"] = {"MarineTreeQuest", 3, "Third"},
    ["[Lv.1775] Marine Captain"] = {"MarineTreeQuest", 1, "Third"},
    ["[Lv.1800] Marine Commodore"] = {"MarineTreeQuest", 2, "Third"},
    ["[Lv.1825] Fishman Warrior"] = {"TurtleQuest1", 1, "Third"},
    ["[Lv.1850] Fishman Captain"] = {"TurtleQuest1", 2, "Third"},
    ["[Lv.1875] Captain Elephant [Boss]"] = {"TurtleQuest1", 3, "Third"},
    ["[Lv.1900] Forest Pirate"] = {"TurtleQuest2", 1, "Third"},
    ["[Lv.1925] Mythical Pirate"] = {"TurtleQuest2", 2, "Third"},
    ["[Lv.1950] Beautiful Pirate [Boss]"] = {"TurtleQuest2", 3, "Third"},
    ["[Lv.1975] Jungle Pirate"] = {"MusketeerQuest", 1, "Third"},
    ["[Lv.2000] Musketeer Pirate"] = {"MusketeerQuest", 2, "Third"},
    ["[Lv.2025] Reborn Skeleton"] = {"HauntedQuest1", 1, "Third"},
    ["[Lv.2050] Living Zombie"] = {"HauntedQuest1", 2, "Third"},
    ["[Lv.2100] Demonic Soul"] = {"HauntedQuest2", 1, "Third"},
    ["[Lv.2125] Posessed Mummy"] = {"HauntedQuest2", 2, "Third"},
    ["[Lv.2150] Soul Reaper [Boss]"] = {"HauntedQuest2", 3, "Third"},
    ["[Lv.2150] Peanut Scout"] = {"PeanutQuest", 1, "Third"},
    ["[Lv.2175] Peanut President"] = {"PeanutQuest", 2, "Third"},
    ["[Lv.2200] Ice Cream Chef"] = {"IceCreamQuest", 1, "Third"},
    ["[Lv.2225] Ice Cream Commander"] = {"IceCreamQuest", 2, "Third"},
    ["[Lv.2100] Cake Queen [Boss]"] = {"IceCreamQuest", 3, "Third"},
    ["[Lv.2275] Cookie Crafter"] = {"CakeQuest1", 1, "Third"},
    ["[Lv.2300] Cake Guard"] = {"CakeQuest1", 2, "Third"},
    ["[Lv.2325] Baking Staff"] = {"CakeQuest2", 1, "Third"},
    ["[Lv.2350] Cake Warrior"] = {"CakeQuest2", 2, "Third"},
    ["[Lv.2375] Candy Rebel"] = {"ChocQuest2", 2, "Third"},
    ["[Lv.2400] Candy Pirate"] = {"CandyQuest1", 1, "Third"},
    ["[Lv.2425] Snow Demon"] = {"CandyQuest1", 2, "Third"},
    ["[Lv.2450] Isle Outlaw"] = {"TikiQuest1", 1, "Third"},
}

local request = http_request or request
local getServers

-- // ============================================================== Helpers ============================================================== \\ --

local partCache = setmetatable({}, {__mode = "v"})
local function getTargetPart(model)
    if partCache[model] and partCache[model].Parent then return partCache[model] end
    for _, part in ipairs(model:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            partCache[model] = part
            return part
        end
    end
    local fallback = model:FindFirstChildOfClass("BasePart")
    partCache[model] = fallback
    return fallback
end

local function attack(targetModel)
    local targetPart = getTargetPart(targetModel)
    if targetPart then
        NetModule:RemoteEvent("RegisterAttack"):FireServer(0)
        NetModule:RemoteEvent("RegisterHit"):FireServer(targetPart, {})
    end
end

local function attackTRex(targetHrp)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end
    local direction = (targetHrp.Position - hrp.Position).Unit
    local tRexFolder = character:FindFirstChild("T-Rex-T-Rex")
    if not tRexFolder then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool.Name:find("T%-Rex") then tRexFolder = tool end
    end
    if not tRexFolder then return end
    local remote = tRexFolder:FindFirstChild("LeftClickRemote")
    if not remote then return end

    remote:FireServer(vector.create(direction.X, direction.Y, direction.Z), 3)
end

local function attackTRexCustom(targetHrp, direction)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end
    
    local tRexFolder = character:FindFirstChild("T-Rex-T-Rex")
    if not tRexFolder then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool.Name == "T-Rex-T-Rex" then tRexFolder = tool end
    end
    if not tRexFolder then return end
    
    local remote = tRexFolder:FindFirstChild("LeftClickRemote")
    if not remote then return end
    
    remote:FireServer(vector.create(direction.X, direction.Y, direction.Z), 3)
end

local function attackKitsune(targetHrp)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end
    local direction = (targetHrp.Position - hrp.Position).Unit
    local kitsuneFolder = character:FindFirstChild("Kitsune-Kitsune")
    if not kitsuneFolder then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool.Name:find("Kitsune-Kitsune") then kitsuneFolder = tool end
    end
    if not kitsuneFolder then return end
    local remote = kitsuneFolder:FindFirstChild("LeftClickRemote")
    if not remote then return end

    remote:FireServer(vector.create(direction.X, direction.Y, direction.Z), 4, true)
end

local function attackKitsuneCustom(targetHrp, direction)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end
    
    local kitsuneFolder = character:FindFirstChild("Kitsune-Kitsune")
    if not kitsuneFolder then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool.Name:find("Kitsune-Kitsune") then kitsuneFolder = tool end
    end
    if not kitsuneFolder then return end
    
    local remote = kitsuneFolder:FindFirstChild("LeftClickRemote")
    if not remote then return end
    
    remote:FireServer(vector.create(direction.X, direction.Y, direction.Z), 4, true)
end

local function isUsingTRexFruit()
    local char = plr.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tool.Name:find("T%-Rex") then return true end
    local data = plr:FindFirstChild("Data")
    if not data then return false end
    for _, obj in ipairs(data:GetChildren()) do
        if obj:IsA("StringValue") and obj.Value == "T-Rex-T-Rex" then return true end
    end
    return false
end

local function isUsingKitsuneFruit()
    local char = plr.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tool.Name:find("Kitsune-Kitsune") then return true end
    local data = plr:FindFirstChild("Data")
    if not data then return false end
    for _, obj in ipairs(data:GetChildren()) do
        if obj:IsA("StringValue") and obj.Value == "Kitsune-Kitsune" then return true end
    end
    return false
end

local function isSword(name)
    for _, sword in ipairs(swordList) do
        if name == sword then return true end
    end
    return false
end

-- // ============================================================== Combat Tab ============================================================== \\ --

-- ===== Kill Aura =====
local KillAuraBox = Tabs.Combat:AddLeftGroupbox('Kill Aura')

local killAuraEnabled = false
local auraRange = 50
local auraSpeed = 20
local auraSwitchDelay = 0
local auraTargetTypes = {}
local auraCircleEnabled = false
local spoofWeaponEnabled = false
local spoofWeaponType = "Melee"
local currentTargetIndex = 1
local instaKillMode = false

-- circle
local circleAdornment = Instance.new("CylinderHandleAdornment")
circleAdornment.Name = "AuraVisual"
circleAdornment.Transparency = 0.3
circleAdornment.Color3 = Color3.fromRGB(157, 115, 255)
circleAdornment.Height = 0.1
circleAdornment.AlwaysOnTop = true
circleAdornment.ZIndex = 10
circleAdornment.Parent = game:GetService("CoreGui")

local function updateCircle()
    local shouldShow = killAuraEnabled and auraCircleEnabled and character and character:FindFirstChild("HumanoidRootPart")
    if shouldShow then
        circleAdornment.Adornee = character.HumanoidRootPart
        circleAdornment.Radius = auraRange
        circleAdornment.InnerRadius = auraRange - 0.5
        circleAdornment.CFrame = CFrame.Angles(math.rad(90), 0, 0) * CFrame.new(0, 0, 3.5)
    else
        circleAdornment.Adornee = nil
    end
end

task.spawn(function() while task.wait() do updateCircle() end end)

local function targetsStunned(targets)
    for _, target in ipairs(targets) do
        local stunVal = target:FindFirstChild("Stun")
        if not stunVal or stunVal.Value <= 0 then
            return false
        end
    end
    return #targets > 0
end

KillAuraBox:AddToggle('KillAuraEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Automatically attack nearby entities',
}):AddKeyPicker('KillAuraKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Kill Aura',
    SyncToggleState = true,
})

KillAuraBox:AddDropdown('KillAuraTargets', {
    Text = 'Targets',
    Values = {'Mobs', 'Players', 'Sea Beasts'},
    Default = {},
    Multi = true,
    Tooltip = 'Select which targets to attack',
})

KillAuraBox:AddSlider('KillAuraRange', {
    Text = 'Aura Range',
    Default = 50,
    Min = 1,
    Max = 500,
    Rounding = 0,
    Suffix = ' studs',
})

KillAuraBox:AddSlider('KillAuraSpeed', {
    Text = 'Attack Speed',
    Default = 20,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Suffix = ' APS',
})

KillAuraBox:AddSlider('KillAuraSwitchDelay', {
    Text = 'Switch Delay',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Suffix = 's',
})

KillAuraBox:AddToggle('KillAuraSpoofWeapon', {
    Text = 'Spoof Weapon',
    Default = false,
    Tooltip = 'Attack without holding a weapon',
})

local SpoofDepbox = KillAuraBox:AddDependencyBox()
SpoofDepbox:AddDropdown('KillAuraSpoofType', {
    Text = 'Weapon Type',
    Values = {'Melee', 'Sword', 'Demon Fruit'},
    Default = 1,
    Tooltip = 'Type to spoof as',
})
SpoofDepbox:SetupDependencies({ {Toggles.KillAuraSpoofWeapon, true} })

KillAuraBox:AddToggle('KillAuraVisualCircle', {
    Text = 'Visual Circle',
    Default = false,
    Tooltip = 'Shows the range circle',
})

KillAuraBox:AddToggle('KillAuraInstaKill', {
    Text = 'Insta-Kill',
    Default = false,
    Tooltip = "Conqueror's Haki",
})

Options.KillAuraTargets:OnChanged(function()
    auraTargetTypes = Options.KillAuraTargets.Value
end)

Toggles.KillAuraEnabled:OnChanged(function()
    killAuraEnabled = Toggles.KillAuraEnabled.Value
    if killAuraEnabled then
        task.spawn(function()
            local enemiesFolder = workspace:FindFirstChild("Enemies")
            local charactersFolder = workspace:FindFirstChild("Characters")
            local seaBeastsFolder = workspace:FindFirstChild("SeaBeasts")
            local lastTargetScan = 0
            local cachedTargets = {}

            while killAuraEnabled do
                local startTime = os.clock()
                local delayTime = math.max(auraSwitchDelay, 1 / math.max(auraSpeed, 1))
                local char = plr.Character

                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    local hrp = char:FindFirstChild("HumanoidRootPart")

                    if hum and hum.Health > 0 and hrp then
                        if instaKillMode then
                            if startTime - lastTargetScan > 0.1 then
                                if auraTargetTypes and auraTargetTypes.Mobs and enemiesFolder then
                                    for _, target in ipairs(enemiesFolder:GetChildren()) do
                                        if target.Name == "Terrorshark" then
                                            continue
                                        end
                                        
                                        local targetHum = target:FindFirstChildOfClass("Humanoid")
                                        if targetHum and targetHum.Health > 0 then
                                            local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                            if targetHrp and (hrp.Position - targetHrp.Position).Magnitude < 1000 then
                                                targetHum.Health = 0
                                                targetHum.MaxHealth = 0
                                            end
                                        end
                                    end
                                end
                                
                                lastTargetScan = startTime
                            end
                        else
                            local currentTool = char:FindFirstChildOfClass("Tool")

                            local hasTRexTool = currentTool and currentTool.Name == "T-Rex-T-Rex"
                            local usingTRex = hasTRexTool and isUsingTRexFruit()

                            local hasKitsuneTool = currentTool and currentTool.Name == "Kitsune-Kitsune"
                            local usingKitsune = hasKitsuneTool and isUsingKitsuneFruit()

                            local canAttackNormally = (not (usingTRex or usingKitsune)) and (spoofWeaponEnabled or (currentTool and currentTool.ToolTip ~= "Gun"))

                            if usingTRex or usingKitsune or canAttackNormally then
                                if startTime - lastTargetScan > 0.3 then
                                    cachedTargets = {}
                                    
                                    local function scanFolder(folder, skipSelf)
                                        if not folder then return end
                                        for _, target in ipairs(folder:GetChildren()) do
                                            if skipSelf and target == char then continue end
                                            local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                            local targetHum = target:FindFirstChild("Humanoid")
                                            if targetHrp and targetHum and targetHum.Health > 0 then
                                                if (hrp.Position - targetHrp.Position).Magnitude < auraRange then
                                                    table.insert(cachedTargets, target)
                                                end
                                            end
                                        end
                                    end
                                    
                                    if auraTargetTypes then
                                        if auraTargetTypes.Mobs then
                                            scanFolder(enemiesFolder, false)
                                        end
                                        
                                        if auraTargetTypes.Players then
                                            scanFolder(charactersFolder, true)
                                        end
                                    end
                                    
                                    if auraTargetTypes and auraTargetTypes['Sea Beasts'] and seaBeastsFolder and (usingTRex or usingKitsune) then
                                        for _, beast in ipairs(seaBeastsFolder:GetChildren()) do
                                            if beast:IsA("Model") and beast.Name:sub(1, 8) == "SeaBeast" then
                                                local beastHrp = beast:FindFirstChild("HumanoidRootPart")
                                                if beastHrp then
                                                    table.insert(cachedTargets, beast)
                                                end
                                            end
                                        end
                                    end
                                    
                                    lastTargetScan = startTime
                                end

                                if #cachedTargets > 0 then
                                    if currentTargetIndex > #cachedTargets then currentTargetIndex = 1 end
                                    local target = cachedTargets[currentTargetIndex]
                                    local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                    
                                    local isSeaBeast = target.Name:sub(1, 8) == "SeaBeast"

                                    if targetHrp then
                                        if isSeaBeast then
                                            if usingKitsune then
                                                attackKitsune(targetHrp)
                                            elseif usingTRex then
                                                attackTRex(targetHrp)
                                            end
                                        elseif targetsStunned(cachedTargets) then
                                            if usingTRex then
                                                attackTRexCustom(targetHrp, Vector3.new(0, -1, 0))
                                            elseif usingKitsune then
                                                attackKitsuneCustom(targetHrp, Vector3.new(0, -1, 0))
                                            elseif canAttackNormally then
                                                attack(target)
                                            end
                                        else
                                            if usingKitsune then
                                                attackKitsune(targetHrp)
                                            elseif usingTRex then
                                                attackTRex(targetHrp)
                                            elseif canAttackNormally then
                                                attack(target)
                                            end
                                        end
                                    elseif canAttackNormally then
                                        attack(target)
                                    end

                                    currentTargetIndex = currentTargetIndex + 1
                                end
                            end
                        end
                    end
                end

                task.wait(delayTime)
            end
        end)
    end
end)

Options.KillAuraRange:OnChanged(function() auraRange = Options.KillAuraRange.Value end)
Options.KillAuraSpeed:OnChanged(function() auraSpeed = Options.KillAuraSpeed.Value end)
Options.KillAuraSwitchDelay:OnChanged(function() auraSwitchDelay = Options.KillAuraSwitchDelay.Value end)
Toggles.KillAuraSpoofWeapon:OnChanged(function() spoofWeaponEnabled = Toggles.KillAuraSpoofWeapon.Value end)
Options.KillAuraSpoofType:OnChanged(function() spoofWeaponType = Options.KillAuraSpoofType.Value end)
Toggles.KillAuraVisualCircle:OnChanged(function() auraCircleEnabled = Toggles.KillAuraVisualCircle.Value end)
Toggles.KillAuraInstaKill:OnChanged(function() instaKillMode = Toggles.KillAuraInstaKill.Value end)

-- ===== Aimbot =====
local AimbotBox = Tabs.Combat:AddRightGroupbox('Aimbot')

local aimbotEnabled = false
local aimbotFOV = 150
local aimbotTargetType = "Mobs"
local aimbotCurrentTarget = nil
local aimbotHighlightEnabled = false
local aimbotHighlight = nil
local camera = workspace.CurrentCamera

local aimbotCircle = Drawing.new("Circle")
aimbotCircle.Visible = false
aimbotCircle.Thickness = 1.5
aimbotCircle.Color = Color3.fromRGB(255, 255, 255)
aimbotCircle.Transparency = 1
aimbotCircle.Filled = false
aimbotCircle.NumSides = 200
aimbotCircle.Radius = aimbotFOV

local function getMouseScreenPos() return UserInputService:GetMouseLocation() end

local function worldToScreen(pos)
    local sp, onScreen = camera:WorldToViewportPoint(pos)
    return Vector2.new(sp.X, sp.Y), onScreen, sp.Z
end

local function getBestTarget()
    local mousePos = getMouseScreenPos()
    local bestTarget, bestDist = nil, math.huge
    local folders = {}
    
    if aimbotTargetType == "Players" then
        folders = {workspace:FindFirstChild("Characters")}
    elseif aimbotTargetType == "Mobs" then
        folders = {workspace:FindFirstChild("Enemies")}
    elseif aimbotTargetType == "Both" then
        folders = {workspace:FindFirstChild("Enemies"), workspace:FindFirstChild("Characters")}
    end
    
    for _, folder in ipairs(folders) do
        if not folder then continue end
        for _, target in ipairs(folder:GetChildren()) do
            local hrp = target:FindFirstChild("HumanoidRootPart")
            local hum = target:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 and target ~= plr.Character then
                local screenPos, onScreen, depth = worldToScreen(hrp.Position)
                if onScreen and depth > 0 then
                    local distToCursor = (screenPos - mousePos).Magnitude
                    if distToCursor <= aimbotFOV then
                        local distToPlayer = plr:DistanceFromCharacter(hrp.Position)
                        if distToPlayer < bestDist then
                            bestDist = distToPlayer
                            bestTarget = hrp
                        end
                    end
                end
            end
        end
    end
    return bestTarget
end

local function clearHighlight()
    if aimbotHighlight and aimbotHighlight.Parent then 
        aimbotHighlight:Destroy() 
    end
    aimbotHighlight = nil
end

local function applyHighlight(target)
    local model = target and target.Parent
    if not model then return end
    clearHighlight()
    local existing = model:FindFirstChildOfClass("Highlight")
    if existing then existing:Destroy() end
    local hl = Instance.new("Highlight")
    hl.FillColor = Color3.fromRGB(255, 0, 0)
    hl.OutlineColor = Color3.fromRGB(255, 0, 0)
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = model
    aimbotHighlight = hl
end

task.spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg, false)
    gg.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if aimbotEnabled and aimbotCurrentTarget and (method == "FireServer" or method == "InvokeServer") then
            local args = table.pack(...)
            local modified = false
            for i = 1, args.n do
                if typeof(args[i]) == "Vector3" then
                    args[i] = aimbotCurrentTarget.Position
                    modified = true
                elseif typeof(args[i]) == "CFrame" then
                    local orig = args[i]
                    args[i] = CFrame.new(aimbotCurrentTarget.Position) * (orig - orig.Position)
                    modified = true
                end
            end
            if modified then return old(self, table.unpack(args, 1, args.n)) end
        end
        return old(self, ...)
    end)
    setreadonly(gg, true)
end)

task.spawn(function()
    local lastTarget = nil
    local lastUpdate = 0
    
    while task.wait() do
        local mousePos = getMouseScreenPos()
        
        if aimbotEnabled then
            aimbotCircle.Visible = true
            aimbotCircle.Position = mousePos
            aimbotCircle.Radius = aimbotFOV
            
            local currentTime = tick()
            if currentTime - lastUpdate > 0.1 then
                local target = getBestTarget()
                if target then
                    local screenPos, onScreen = worldToScreen(target.Position)
                    if onScreen then
                        aimbotCurrentTarget = target
                        if aimbotHighlightEnabled and target ~= lastTarget then
                            applyHighlight(target)
                            lastTarget = target
                        end
                    else
                        aimbotCurrentTarget = nil
                    end
                else
                    aimbotCurrentTarget = nil
                    if lastTarget ~= nil then 
                        clearHighlight() 
                        lastTarget = nil 
                    end
                end
                lastUpdate = currentTime
            end
        else
            aimbotCircle.Visible = false
            aimbotCurrentTarget = nil
            clearHighlight()
            lastTarget = nil
        end
        
        if not aimbotHighlightEnabled then 
            clearHighlight() 
            lastTarget = nil 
        end
    end
end)

-- UI Elements
AimbotBox:AddToggle('AimbotEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Silently aims at entities (only for skills tho)',
}):AddKeyPicker('AimbotKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Aimbot',
    SyncToggleState = true,
})

AimbotBox:AddLabel('FOV Color'):AddColorPicker('AimbotFOVColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'FOV Circle Color',
    Transparency = 0,
})

Options.AimbotFOVColor:OnChanged(function()
    aimbotCircle.Color = Options.AimbotFOVColor.Value
end)

AimbotBox:AddDropdown('AimbotTargets', {
    Text = 'Targets',
    Values = {'Mobs', 'Players', 'Both'},
    Default = 1,
    Tooltip = 'Who to target',
})

AimbotBox:AddSlider('AimbotFOV', {
    Text = 'FOV Size',
    Default = 150,
    Min = 10,
    Max = 800,
    Rounding = 0,
    Suffix = ' px',
})

AimbotBox:AddToggle('AimbotHighlight', {
    Text = 'Highlight Target',
    Default = false,
    Tooltip = 'Highlight the current aimbot target',
})

-- callbacks
Toggles.AimbotEnabled:OnChanged(function() 
    aimbotEnabled = Toggles.AimbotEnabled.Value
    if not aimbotEnabled then
        aimbotCurrentTarget = nil
        clearHighlight()
    end
end)

Options.AimbotTargets:OnChanged(function() 
    aimbotTargetType = Options.AimbotTargets.Value 
end)

Options.AimbotFOV:OnChanged(function() 
    aimbotFOV = Options.AimbotFOV.Value 
    aimbotCircle.Radius = aimbotFOV
end)

Toggles.AimbotHighlight:OnChanged(function()
    aimbotHighlightEnabled = Toggles.AimbotHighlight.Value
    if not aimbotHighlightEnabled then 
        clearHighlight() 
    end
end)

-- ===== Fast Attack =====
local FastAttackBox = Tabs.Combat:AddLeftGroupbox('Fast Attack')

local fastAttackEnabled = false
local fastAttackConnection
local attackDistance = 10
local oldAttackSpeed = 1

FastAttackBox:AddToggle('FastAttack', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Attack faster',
}):AddKeyPicker('FastAttackKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Fast Attack',
    SyncToggleState = true,
})

Toggles.FastAttack:OnChanged(function()
    fastAttackEnabled = Toggles.FastAttack.Value
    if fastAttackEnabled then
        if character then oldAttackSpeed = character:GetAttribute("AttackSpeedMultiplier") or 1 end
        fastAttackConnection = RunService.Stepped:Connect(function()
            if not fastAttackEnabled then
                if fastAttackConnection then fastAttackConnection:Disconnect() end
                return
            end
            character:SetAttribute("AttackSpeedMultiplier", 5)
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                if not (character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0) then return end
                local tool = character:FindFirstChildOfClass("Tool")
                if tool and tool.ToolTip ~= "Gun" then
                    local nearest, nearestDist = nil, math.huge
                    for _, folder in pairs({workspace.Enemies, workspace.Characters}) do
                        for _, enemy in pairs(folder:GetChildren()) do
                            local hrp = enemy:FindFirstChild("HumanoidRootPart")
                            local hum = enemy:FindFirstChild("Humanoid")
                            if hrp and hum and hum.Health > 0 and enemy ~= character then
                                local dist = plr:DistanceFromCharacter(hrp.Position)
                                if dist < attackDistance and dist < nearestDist then
                                    nearestDist = dist
                                    nearest = enemy
                                end
                            end
                        end
                    end
                    if nearest then
                        pcall(function()
                            NetModule:RemoteEvent("RegisterAttack"):FireServer(0)
                            NetModule:RemoteEvent("RegisterHit"):FireServer(getTargetPart(nearest), {})
                        end)
                    end
                end
            end
        end)
    else
        if fastAttackConnection then fastAttackConnection:Disconnect() fastAttackConnection = nil end
        if character then character:SetAttribute("AttackSpeedMultiplier", oldAttackSpeed) end
    end
end)

-- ===== No Fruit M1 Cooldown =====
local NoFruitM1Box = Tabs.Combat:AddRightGroupbox('No Fruit M1 Cooldown')

local noFM1Enabled = false
local noFM1Connection
local defaultFM1Speed = 0

NoFruitM1Box:AddToggle('NoFruitM1', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Removes fruit M1 attack cooldown',
}):AddKeyPicker('NoFruitM1Keybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'No Fruit M1 Cooldown',
    SyncToggleState = true,
})

Toggles.NoFruitM1:OnChanged(function()
    noFM1Enabled = Toggles.NoFruitM1.Value
    if noFM1Enabled then
        if character2 then
            local val = character2:GetAttribute("FruitTAPCooldown")
            if val then defaultFM1Speed = val end
        end
        noFM1Connection = RunService.Heartbeat:Connect(function()
            if not noFM1Enabled then if noFM1Connection then noFM1Connection:Disconnect() end return end
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("FruitTAPCooldown", 1) end
        end)
    else
        if noFM1Connection then noFM1Connection:Disconnect() noFM1Connection = nil end
        if character2 then character2:SetAttribute("FruitTAPCooldown", defaultFM1Speed) end
    end
end)

-- ===== Sword Reach =====
local SwordReachBox = Tabs.Combat:AddLeftGroupbox('Sword Reach')

local rangeEnabled = false
local rangeX, rangeY, rangeZ = 50, 50, 50
local originalSizes = {}
local hitboxConnection2

SwordReachBox:AddToggle('SwordReach', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Extend sword hitboxes',
}):AddKeyPicker('SwordReachKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Sword Reach',
    SyncToggleState = true,
})

SwordReachBox:AddSlider('SwordReachX', { Text = 'X Reach', Default = 50, Min = 1, Max = 100, Rounding = 0 })
SwordReachBox:AddSlider('SwordReachY', { Text = 'Y Reach', Default = 50, Min = 1, Max = 100, Rounding = 0 })
SwordReachBox:AddSlider('SwordReachZ', { Text = 'Z Reach', Default = 50, Min = 1, Max = 100, Rounding = 0 })

Toggles.SwordReach:OnChanged(function()
    rangeEnabled = Toggles.SwordReach.Value
    if not rangeEnabled then
        for part, size in pairs(originalSizes) do
            if part and part.Parent then part.Size = size end
        end
        originalSizes = {}
        if hitboxConnection2 then hitboxConnection2:Disconnect() end
    else
        hitboxConnection2 = RunService.Heartbeat:Connect(function()
            if not rangeEnabled then return end
            local tool = character:FindFirstChildOfClass("Tool")
            if tool and isSword(tool.Name) then
                local weaponModel = character:FindFirstChild("EquippedWeapon")
                if weaponModel then
                    for _, part in ipairs(weaponModel:GetDescendants()) do
                        if part.Name == "Handle" and part:IsA("BasePart") then
                            if not originalSizes[part] then originalSizes[part] = part.Size end
                            part.Size = Vector3.new(rangeX, rangeY, rangeZ)
                            part.CanCollide = false
                            part.Massless = true
                        end
                    end
                end
            end
        end)
    end
end)
Options.SwordReachX:OnChanged(function() rangeX = Options.SwordReachX.Value end)
Options.SwordReachY:OnChanged(function() rangeY = Options.SwordReachY.Value end)
Options.SwordReachZ:OnChanged(function() rangeZ = Options.SwordReachZ.Value end)

-- ===== Hitboxes =====
local IncreaseHitboxBox = Tabs.Combat:AddRightGroupbox('Hitboxes')

local hitboxEnabled = false
local hitboxTargetType = "Mobs"
local hitboxX, hitboxY, hitboxZ = 10, 10, 10
local originalHeadSizes = {}
local hitboxConnection3

IncreaseHitboxBox:AddToggle('IncreaseHitbox', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Increase hitboxes',
}):AddKeyPicker('IncreaseHitboxKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Increase Hitbox',
    SyncToggleState = true,
})

IncreaseHitboxBox:AddDropdown('HitboxTargets', {
    Text = 'Targets',
    Values = {'Mobs', 'Players', 'Both'},
    Default = 1,
})
IncreaseHitboxBox:AddSlider('HitboxX', { Text = 'X Size', Default = 10, Min = 1, Max = 100, Rounding = 0 })
IncreaseHitboxBox:AddSlider('HitboxY', { Text = 'Y Size', Default = 10, Min = 1, Max = 100, Rounding = 0 })
IncreaseHitboxBox:AddSlider('HitboxZ', { Text = 'Z Size', Default = 10, Min = 1, Max = 100, Rounding = 0 })

Toggles.IncreaseHitbox:OnChanged(function()
    hitboxEnabled = Toggles.IncreaseHitbox.Value
    if hitboxEnabled then
        hitboxConnection3 = RunService.Heartbeat:Connect(function()
            if not hitboxEnabled then return end
            local folders = hitboxTargetType == "Players" and {workspace.Characters}
                or hitboxTargetType == "Mobs" and {workspace.Enemies}
                or {workspace.Enemies, workspace.Characters}
            for _, folder in ipairs(folders) do
                for _, target in ipairs(folder:GetChildren()) do
                    local head = target:FindFirstChild("Head")
                    if head and target ~= plr.Character then
                        if not originalHeadSizes[head] then 
                            originalHeadSizes[head] = head.Size 
                        end
                        head.Size = Vector3.new(hitboxX, hitboxY, hitboxZ)
                        head.CanCollide = false
                        head.Massless = true
                        head.Transparency = 0.5
                    end
                end
            end
        end)
    else
        if hitboxConnection3 then hitboxConnection3:Disconnect() hitboxConnection3 = nil end
        for head, size in pairs(originalHeadSizes) do
            if head and head.Parent then 
                head.Size = size
                head.CanCollide = true
                head.Massless = false
            end
        end
        originalHeadSizes = {}
    end
end)
Options.HitboxTargets:OnChanged(function() hitboxTargetType = Options.HitboxTargets.Value end)
Options.HitboxX:OnChanged(function() hitboxX = Options.HitboxX.Value end)
Options.HitboxY:OnChanged(function() hitboxY = Options.HitboxY.Value end)
Options.HitboxZ:OnChanged(function() hitboxZ = Options.HitboxZ.Value end)

-- // ============================================================== Farming Tab ============================================================== \\ --

-- ===== Chest Farm =====
local ChestFarmBox = Tabs.Farming:AddLeftGroupbox('Chest Farm')

local chestFarmEnabled = false
local horizontalSpeed = 200
local boostEnabled = false
local noclipEnabled = false
local bodyVelocity
local cachedChests = {}
local currentChest = nil
local chestConnection = nil
local watchChest
local getSpawnedChests

local function setPlayerMotion(velocity)
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart
    if not bodyVelocity or bodyVelocity.Parent ~= hrp then
        if bodyVelocity then bodyVelocity:Destroy() end
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.P = 10000
        bodyVelocity.Parent = hrp
    end
    bodyVelocity.Velocity = velocity
end

local function enableNoclip()
    noclipEnabled = true
    coroutine.wrap(function()
        while noclipEnabled and character do
            RunService.Stepped:Wait()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end)()
end

ChestFarmBox:AddToggle('ChestFarmEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Collects every chest available',
}):AddKeyPicker('ChestFarmKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Chest Farm',
    SyncToggleState = true,
})

ChestFarmBox:AddSlider('ChestFarmSpeed', {
    Text = 'Speed',
    Default = 200,
    Min = 1,
    Max = 215,
    Rounding = 0,
})

ChestFarmBox:AddToggle('ChestFarmBoost', {
    Text = 'Boost',
    Default = false,
    Tooltip = "Boosts chest farm's speed",
})

Toggles.ChestFarmEnabled:OnChanged(function()
    chestFarmEnabled = Toggles.ChestFarmEnabled.Value
    if chestFarmEnabled then
        task.spawn(function()
            enableNoclip()
            while chestFarmEnabled do
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if not currentChest or not currentChest.Parent or not currentChest:FindFirstChildOfClass("TouchTransmitter") then
                        cachedChests = getSpawnedChests()
                        local nearest, dist = nil, math.huge
                        for _, chest in ipairs(cachedChests) do
                            local d = (hrp.Position - chest.Position).Magnitude
                            if d < dist then dist = d nearest = chest end
                        end
                        if nearest then watchChest(nearest) end
                    end
                    if currentChest and currentChest.Parent then
                        local delta = currentChest.Position - hrp.Position
                        if delta.Magnitude < 3 then
                            hrp.CFrame = currentChest.CFrame
                            setPlayerMotion(Vector3.zero)
                        else
                            setPlayerMotion(delta.Unit * horizontalSpeed)
                        end
                    else
                        setPlayerMotion(Vector3.zero)
                    end
                end
                task.wait()
            end
        end)
    else
        noclipEnabled = false
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    end
end)

Options.ChestFarmSpeed:OnChanged(function() horizontalSpeed = Options.ChestFarmSpeed.Value end)

Toggles.ChestFarmBoost:OnChanged(function()
    boostEnabled = Toggles.ChestFarmBoost.Value
    if boostEnabled then
        coroutine.wrap(function()
            while boostEnabled and chestFarmEnabled and character and character:FindFirstChild("HumanoidRootPart") do
                wait(2.67)
                if bodyVelocity and bodyVelocity.Parent then
                    local cv = bodyVelocity.Velocity
                    bodyVelocity.Velocity = Vector3.new(
                        cv.X + (cv.X > 0 and 800 or -800), 0,
                        cv.Z + (cv.Z > 0 and 800 or -800)
                    )
                    wait(0.67)
                    bodyVelocity.Velocity = cv
                end
            end
        end)()
    end
end)

plr.CharacterAdded:Connect(function(newChar)
    character = newChar
    task.wait()
    character2 = charFolder:FindFirstChild(plr.Name)
    if chestFarmEnabled then
        Toggles.ChestFarmEnabled:SetValue(false)
        task.wait(0.5)
        Toggles.ChestFarmEnabled:SetValue(true)
    end
end)

-- ===== Legendary Sword Dealer Detector =====
local DealerBox = Tabs.Farming:AddLeftGroupbox('Legendary Sword Dealer Detector')

local dealerEnabled = false
local dealerSpawned = false
local dealerPosition = nil
local DEFAULT_POS = Vector3.new(0, -1000, 0)

local function checkDealer()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    local dealerInWorkspace = npcsFolder and npcsFolder:FindFirstChild("Legendary Sword Dealer")
    
    if dealerInWorkspace then
        local hrp = dealerInWorkspace:FindFirstChild("HumanoidRootPart")
        if hrp then
            dealerPosition = hrp.Position
            return true, "workspace"
        end
        return true, "workspace"
    end
    
    local dealerInReplicated = ReplicatedStorage:FindFirstChild("NPCs") and 
                               ReplicatedStorage.NPCs:FindFirstChild("Legendary Sword Dealer")
    
    if dealerInReplicated then
        local hrp = dealerInReplicated:FindFirstChild("HumanoidRootPart")
        if hrp then
            local isDefault = (hrp.Position - DEFAULT_POS).Magnitude < 0.1
            if not isDefault then
                dealerPosition = hrp.Position
                return true, "replicated"
            end
        end
    end
    
    dealerPosition = nil
    return false, "unknown"
end

local statusLabel = DealerBox:AddLabel("Status: Disabled")

DealerBox:AddToggle('DealerDetector', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Get notified when the Legendary Sword Dealer spawns',
})

Toggles.DealerDetector:OnChanged(function()
    dealerEnabled = Toggles.DealerDetector.Value
    
    if dealerEnabled then
        statusLabel:SetText("Status: Checking...")
        local spawned = checkDealer()
        if spawned then
            dealerSpawned = true
            if dealerPosition then
                local distance = plr:DistanceFromCharacter(dealerPosition)
                statusLabel:SetText(string.format('Status: SPAWNED! (%.1fm)', distance))
            else
                statusLabel:SetText("Status: SPAWNED!")
            end
        end
    else
        statusLabel:SetText("Status: Disabled")
        dealerSpawned = false
        dealerPosition = nil
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        
        if dealerEnabled then
            local spawned = checkDealer()
            
            if spawned and not dealerSpawned then
                dealerSpawned = true
                
                if dealerPosition then
                    local distance = plr:DistanceFromCharacter(dealerPosition)
                    statusLabel:SetText(string.format('Status: SPAWNED! (%.1fm)', distance))
                else
                    statusLabel:SetText("Status: SPAWNED!")
                end
                
                for i = 1, 20 do
                    Library:Notify("[LSDDetector] >> The Dealer has spawned!", 15)
                end
                
            elseif not spawned and dealerSpawned then
                dealerSpawned = false
                dealerPosition = nil
                statusLabel:SetText("Status: Checking...")
                Library:Notify("[LSDDetector] >> The Dealer has despawned :(", 15)
                
            elseif spawned and dealerSpawned and dealerPosition then
                local distance = plr:DistanceFromCharacter(dealerPosition)
                statusLabel:SetText(string.format('Status: SPAWNED! (%.1fm)', distance))
            end
        end
    end
end)

DealerBox:AddButton({
    Text = 'Check',
    Func = function()
        local spawned = checkDealer()
        if spawned and dealerPosition then
            local distance = plr:DistanceFromCharacter(dealerPosition)
            Library:Notify(string.format("[LSDDetector] >> The Dealer has spawned! (%.1fm)", distance), 5)
        elseif spawned then
            Library:Notify("[LSDDetector] >> The Dealer has spawned!", 15)
        else
            Library:Notify("[LSDDetector] >> The Dealer hasn't spawned", 10)
        end
    end,
})

-- ===== Bring Mobs =====
local BringMobsBox = Tabs.Farming:AddRightGroupbox('Bring Mobs')

local bringMobsEnabled = false
local bringBossesEnabled = false
local bringRange = 300
local bringDistance = 6

BringMobsBox:AddToggle('BringMobs', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Pull nearby mobs to you',
}):AddKeyPicker('BringMobsKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Bring Mobs',
    SyncToggleState = true,
})

local BringBossesDepbox = BringMobsBox:AddDependencyBox()
BringBossesDepbox:AddToggle('BringBosses', {
    Text = 'Bring Bosses',
    Default = false,
    Tooltip = 'Also bring Bosses',
})
BringBossesDepbox:SetupDependencies({ {Toggles.BringMobs, true} })

BringMobsBox:AddSlider('BringDistance', {
    Text = 'Bring Distance',
    Default = 6,
    Min = 3,
    Max = 15,
    Rounding = 1,
    Suffix = ' studs',
})

Toggles.BringMobs:OnChanged(function() bringMobsEnabled = Toggles.BringMobs.Value end)
Toggles.BringBosses:OnChanged(function() bringBossesEnabled = Toggles.BringBosses.Value end)
Options.BringDistance:OnChanged(function() bringDistance = Options.BringDistance.Value end)

local function teleportMob(mRoot, targetPos)
    if not mRoot then return end
    
    mRoot.AssemblyLinearVelocity = Vector3.zero
    mRoot.AssemblyAngularVelocity = Vector3.zero
    
    mRoot.CFrame = CFrame.new(targetPos)
    
    local rootPart = mRoot.Parent:FindFirstChild("RootPart")
    if rootPart and rootPart ~= mRoot then
        rootPart.AssemblyLinearVelocity = Vector3.zero
        rootPart.AssemblyAngularVelocity = Vector3.zero
        rootPart.CFrame = CFrame.new(targetPos)
    end
    
    task.wait()
    mRoot.AssemblyLinearVelocity = Vector3.zero
    mRoot.AssemblyAngularVelocity = Vector3.zero
end

task.spawn(function()
    local lastPullTimes = {}
    
    while task.wait(0.1) do
        if bringMobsEnabled and character and character:FindFirstChild("HumanoidRootPart") then
            local root = character.HumanoidRootPart
            local currentTime = tick()
            
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                local mRoot = mob:FindFirstChild("HumanoidRootPart")
                local mHum = mob:FindFirstChild("Humanoid")
                
                if mRoot and mHum and mHum.Health > 0 then
                    local dist = (mRoot.Position - root.Position).Magnitude
                    
                    if dist <= bringRange then
                        local isBoss = mob:GetAttribute("IsBoss") == true
                        
                        if not isBoss or bringBossesEnabled then
                            local targetPos = root.Position + (root.CFrame.LookVector * bringDistance)
                            
                            local currentDistToTarget = (mRoot.Position - targetPos).Magnitude
                            
                            if currentDistToTarget > 3 then
                                local lastPull = lastPullTimes[mob] or 0
                                if currentTime - lastPull > 0.2 then
                                    teleportMob(mRoot, targetPos)
                                    lastPullTimes[mob] = currentTime
                                end
                            end
                        end
                    end
                end
            end
            
            for mob, time in pairs(lastPullTimes) do
                if not mob or not mob.Parent then
                    lastPullTimes[mob] = nil
                end
            end
        end
    end
end)

-- ===== Quests =====
local QuestBox = Tabs.Farming:AddRightGroupbox('Quests')

local currentSeaQuests = {}
for name, data in pairs(quests) do
    if (First_Sea and data[3] == "First") or (Second_Sea and data[3] == "Second") or (Third_Sea and data[3] == "Third") then
        currentSeaQuests[name] = data
    end
end

local questList = {}
for name in pairs(currentSeaQuests) do table.insert(questList, name) end
table.sort(questList, function(a, b)
    return (tonumber(a:match("%d+")) or 0) < (tonumber(b:match("%d+")) or 0)
end)

local selectedQuestData = nil
QuestBox:AddDropdown('QuestSelect', {
    Text = 'Select Quest',
    Values = questList,
    Default = 1,
    Tooltip = 'Choose a quest to start',
})
Options.QuestSelect:OnChanged(function() selectedQuestData = currentSeaQuests[Options.QuestSelect.Value] end)
selectedQuestData = currentSeaQuests[questList[1]]

QuestBox:AddButton({
    Text = 'Start Quest',
    Tooltip = 'Accept selected quest',
    Func = function()
        if selectedQuestData then
            CommF:InvokeServer("StartQuest", selectedQuestData[1], selectedQuestData[2])
            Library:Notify("Started Quest!", 5)
        else
            Library:Notify("Select a quest first!", 5)
        end
    end,
})

-- // ============================================================== Visuals Tab ============================================================== \\ --
local CameraBox = Tabs.Visuals:AddLeftGroupbox('Camera')
local camEnabled = false
local colorCorrectionObjects = {"GlobalColorCorrection", "RainCorrection", "SubmergedColorCorrection", "SeaTerrorCC"}

CameraBox:AddToggle('Camera', {
    Text = 'Enabled',
    Default = false,
    Tooltip = "Modifies your camera's behavior",
}):AddKeyPicker('CameraKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Camera',
    SyncToggleState = true,
})

CameraBox:AddToggle('DisableColorCorrection', {
    Text = 'Disable Color Correction',
    Default = false,
    Tooltip = 'Disables color correction?'
})

CameraBox:AddToggle('RevertSky', {
    Text = 'Old Skybox',
    Default = false,
    Tooltip = "Revert to Roblox's old skybox (also removes fog for some reason)"
})

task.spawn(function()
    while true do
        task.wait()
        
        -- color correction
        local colorCorrectionEnabled = Toggles.Camera.Value and Toggles.DisableColorCorrection.Value
        
        for _, ccName in ipairs(colorCorrectionObjects) do
            local cc = LightingService:FindFirstChild(ccName)
            if cc then
                if colorCorrectionEnabled then
                    if cc.Parent ~= workspace then
                        cc.Parent = workspace
                    end
                else
                    if cc.Parent ~= LightingService then
                        cc.Parent = LightingService
                    end
                end
            end
        end
        
        -- old skybox
        local skyEnabled = Toggles.Camera.Value and Toggles.RevertSky.Value
        local sky = LightingService:FindFirstChild("Sky")
        if sky then
            if skyEnabled then
                if sky.Parent ~= workspace then
                    sky.Parent = workspace
                end
            else
                if sky.Parent ~= LightingService then
                    sky.Parent = LightingService
                end
            end
        end
    end
end)

local FullbrightBox = Tabs.Visuals:AddRightGroupbox('Fullbright')
local originalBrightness = LightingService.Brightness

FullbrightBox:AddToggle('Fullbright', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Brights up the game to see better',
}):AddKeyPicker('FBKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Fullbright',
    SyncToggleState = true,
})

FullbrightBox:AddSlider('BrightnessSlider', {
    Text = 'Brightness',
    Default = 4,
    Min = 0,
    Max = 5,
    Rounding = 0,
})

task.spawn(function()
    while true do
        local fullbrightEnabled = Toggles.Fullbright.Value
        local targetBrightness = Options.BrightnessSlider.Value
        
        if fullbrightEnabled then
            if LightingService.Brightness ~= targetBrightness then
                LightingService.Brightness = targetBrightness
            end
        else
            if LightingService.Brightness ~= originalBrightness then
                LightingService.Brightness = originalBrightness
            end
        end
        
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if not Toggles.Fullbright.Value then
            originalBrightness = LightingService.Brightness
        end
        task.wait(1)
    end
end)

-- ===== Kitsune Color =====
local KitsuneColorBox = Tabs.Visuals:AddLeftGroupbox('Kitsune Color')
local kitsuneColorEnabled = false
local originalColor1 = nil
local rainbowHue = 0
local rainbowSpeed = 1

KitsuneColorBox:AddToggle('KitsuneColor', {
    Text = 'Enabled',
    Default = false,
    Tooltip = "Changes the Kitsune Fruit's Color",
})

KitsuneColorBox:AddLabel('Color'):AddColorPicker('KitsuneColorPicker', {
    Default = Color3.fromRGB(150, 0, 0),
    Title = 'Kitsune Color',
    Transparency = 0,
})

KitsuneColorBox:AddToggle('KitsuneRainbow', {
    Text = 'Rainbow Color',
    Default = false,
    Tooltip = 'lgbt',
})

local RainbowDepbox = KitsuneColorBox:AddDependencyBox()
RainbowDepbox:AddSlider('KitsuneRainbowSpeed', {
    Text = 'Rainbow Speed',
    Default = 1,
    Min = 0.5,
    Max = 5,
    Rounding = 1,
    Suffix = 'x',
})
RainbowDepbox:SetupDependencies({ {Toggles.KitsuneRainbow, true} })

task.spawn(function()
    local lastTime = tick()
    
    while true do
        if Toggles.KitsuneRainbow.Value and Toggles.KitsuneColor.Value then
            local currentTime = tick()
            local deltaTime = currentTime - lastTime
            lastTime = currentTime
            
            rainbowHue = (rainbowHue + (rainbowSpeed * deltaTime * 0.5)) % 1
            
            local rainbowColor = Color3.fromHSV(rainbowHue, 1, 1)
            
            local kitsuneFolder = plr:FindFirstChild("KitsuneFruitVFXColor")
            if kitsuneFolder then
                local shifted = kitsuneFolder:FindFirstChild("Shifted")
                if shifted then
                    shifted:SetAttribute("Shifted_Color1", rainbowColor)
                end
            end
        else
            lastTime = tick()
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        task.wait()
        
        local kitsuneEnabled = Toggles.KitsuneColor.Value
        local rainbowEnabled = Toggles.KitsuneRainbow.Value
        local kitsuneFolder = plr:FindFirstChild("KitsuneFruitVFXColor")
        
        if kitsuneFolder then
            local shifted = kitsuneFolder:FindFirstChild("Shifted")
            
            if shifted then
                if originalColor1 == nil and shifted:GetAttribute("Shifted_Color1") then
                    originalColor1 = shifted:GetAttribute("Shifted_Color1")
                end
                
                if kitsuneEnabled then
                    if not rainbowEnabled then
                        local selectedColor = Options.KitsuneColorPicker.Value
                        shifted:SetAttribute("Shifted_Color1", selectedColor)
                    end
                else
                    if originalColor1 then
                        shifted:SetAttribute("Shifted_Color1", originalColor1)
                    end
                end
            end
        end
    end
end)

Options.KitsuneRainbowSpeed:OnChanged(function()
    rainbowSpeed = Options.KitsuneRainbowSpeed.Value
end)

-- // ============================================================== Movement Tab ============================================================== \\ --

-- ===== Dash Distance =====
local DashBox = Tabs.Movement:AddLeftGroupbox('Dash Distance')

local dashEnabled = false
local dashDistance = 100
local defaultDashLength = 0

DashBox:AddToggle('DashDistance', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Increases dash distance',
}):AddKeyPicker('DashDistanceKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Dash Distance',
    SyncToggleState = true,
})

DashBox:AddSlider('DashDistanceSlider', {
    Text = 'Distance',
    Default = 100,
    Min = 0,
    Max = 500,
    Rounding = 0,
})

Toggles.DashDistance:OnChanged(function()
    dashEnabled = Toggles.DashDistance.Value
    local c2 = charFolder:FindFirstChild(plr.Name)
    if dashEnabled then
        if c2 then defaultDashLength = c2:GetAttribute("DashLength") or 0 end
    else
        if c2 then c2:SetAttribute("DashLength", defaultDashLength) end
    end
end)
Options.DashDistanceSlider:OnChanged(function()
    dashDistance = Options.DashDistanceSlider.Value
    if dashEnabled then
        local c2 = charFolder:FindFirstChild(plr.Name)
        if c2 then c2:SetAttribute("DashLength", dashDistance) end
    end
end)

task.spawn(function()
    while task.wait() do
        if dashEnabled then
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("DashLength", dashDistance) end
        end
    end
end)

-- ===== Speed Boost =====
local SpeedBox = Tabs.Movement:AddLeftGroupbox('Speed Boost')

local speedBoostEnabled = false
local speedBoostValue = 2
local defaultSpeedMult = 1

SpeedBox:AddToggle('SpeedBoost', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Increases movement speed',
}):AddKeyPicker('SpeedBoostKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Speed Boost',
    SyncToggleState = true,
})

SpeedBox:AddSlider('SpeedBoostSlider', {
    Text = 'Speed Multiplier',
    Default = 2,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Suffix = 'x',
})

Toggles.SpeedBoost:OnChanged(function()
    speedBoostEnabled = Toggles.SpeedBoost.Value
    local c2 = charFolder:FindFirstChild(plr.Name)
    if speedBoostEnabled then
        if c2 then defaultSpeedMult = c2:GetAttribute("SpeedMultiplier") or 1 end
    else
        if c2 then c2:SetAttribute("SpeedMultiplier", defaultSpeedMult) end
    end
end)
Options.SpeedBoostSlider:OnChanged(function()
    speedBoostValue = Options.SpeedBoostSlider.Value
    if speedBoostEnabled then
        local c2 = charFolder:FindFirstChild(plr.Name)
        if c2 then c2:SetAttribute("SpeedMultiplier", speedBoostValue) end
    end
end)

task.spawn(function()
    while task.wait() do
        if speedBoostEnabled then
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("SpeedMultiplier", speedBoostValue) end
        end
    end
end)

-- ===== SlyPort =====
local SlyPortBox = Tabs.Movement:AddLeftGroupbox('SlyPort')

local slyPortEnabled = false

local function getNearestPlayer()
    local nearest = nil
    local nearestDist = math.huge
    local charactersFolder = workspace:FindFirstChild("Characters")
    if not charactersFolder then return nil end
    
    for _, target in ipairs(charactersFolder:GetChildren()) do
        if target ~= plr.Character then
            local hrp = target:FindFirstChild("HumanoidRootPart")
            local hum = target:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = plr:DistanceFromCharacter(hrp.Position)
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = target
                end
            end
        end
    end
    return nearest
end

SlyPortBox:AddToggle('SlyPortEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'look behind you...',
}):AddKeyPicker('SlyPortKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'SlyPort',
    SyncToggleState = true,
})

Toggles.SlyPortEnabled:OnChanged(function()
    if Toggles.SlyPortEnabled.Value then
        local char = plr.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local target = getNearestPlayer()
        if not target then 
            Library:Notify("No nearby players found!", 3)
            Toggles.SlyPortEnabled:SetValue(false)
            return 
        end
        
        local targetHrp = target:FindFirstChild("HumanoidRootPart")
        if not targetHrp then 
            Toggles.SlyPortEnabled:SetValue(false)
            return 
        end
        
        local offset = targetHrp.CFrame.LookVector * -2
        local newPos = targetHrp.Position + offset + Vector3.new(0, 0, 0)
        
        hrp.CFrame = CFrame.new(newPos)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        
        Library:Notify("Teleported behind "..target.Name, 3)
        Toggles.SlyPortEnabled:SetValue(false)
    end
end)

-- ===== Boat Fly =====
local BoatFlyBox = Tabs.Movement:AddRightGroupbox('Boat Fly')

local boatFlyEnabled = false
local boatFlyHSpeed = 100
local boatFlyVSpeed = 100
local boatNoclipEnabled = false
local boatCONTROL = {F=0,B=0,L=0,R=0,U=0,D=0}
local boatBV, boatBG = nil, nil
local boatFlyConnection, flyKeyDown, flyKeyUp, seatWeldConnection, noclipConnection = nil, nil, nil, nil, nil
local currentSeat, currentBoat, boatRoot = nil, nil, nil
local waitingForBoat = false

local function getPlayerSeatAndBoat()
    local boatsFolder = workspace:FindFirstChild("Boats")
    if not boatsFolder then return nil, nil end
    local char = plr.Character
    if not char then return nil, nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return nil, nil end
    for _, boat in ipairs(boatsFolder:GetChildren()) do
        for _, v in ipairs(boat:GetDescendants()) do
            if v:IsA("VehicleSeat") and v.Occupant == hum then return v, boat end
            if v:IsA("Seat") then
                local sw = v:FindFirstChild("SeatWeld")
                if sw and sw.Part1 and sw.Part1:IsDescendantOf(char) then return v, boat end
            end
        end
    end
    return nil, nil
end

local function getBoatRoot(boat)
    for _, part in ipairs(boat:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsA("Seat") and not part:IsA("VehicleSeat") then return part end
    end
    return currentSeat
end

local function keepSeated()
    if not currentSeat or not plr.Character then return end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum.Sit == false then hum.Sit = true end
    local sw = currentSeat:FindFirstChild("SeatWeld")
    if not sw then
        sw = Instance.new("Weld")
        sw.Name = "SeatWeld"
        sw.Part0 = currentSeat
        sw.Part1 = plr.Character:FindFirstChild("HumanoidRootPart")
        sw.C0 = CFrame.new(0,0,0)
        sw.C1 = CFrame.new(0,0,0)
        sw.Parent = currentSeat
    else
        sw.Part1 = plr.Character:FindFirstChild("HumanoidRootPart")
    end
end

local function applyNoclip()
    if not boatNoclipEnabled or not currentBoat then return end
    
    for _, part in ipairs(currentBoat:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    
    if plr.Character then
        for _, part in ipairs(plr.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    for _, child in ipairs(currentBoat:GetDescendants()) do
        if child:IsA("VehicleSeat") or child:IsA("Seat") then
            if child.Occupant and child.Occupant.Parent then
                local otherChar = child.Occupant.Parent
                for _, part in ipairs(otherChar:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end

local function stopBoatFly(keepEnabled)
    if boatBV and boatBV.Parent then boatBV:Destroy() end
    if boatBG and boatBG.Parent then boatBG:Destroy() end
    boatBV, boatBG = nil, nil
    if boatFlyConnection then boatFlyConnection:Disconnect() boatFlyConnection = nil end
    if flyKeyDown then flyKeyDown:Disconnect() flyKeyDown = nil end
    if flyKeyUp then flyKeyUp:Disconnect() flyKeyUp = nil end
    if seatWeldConnection then seatWeldConnection:Disconnect() seatWeldConnection = nil end
    if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    boatCONTROL = {F=0,B=0,L=0,R=0,U=0,D=0}
    currentSeat, currentBoat, boatRoot = nil, nil, nil
    
    if not keepEnabled and boatFlyEnabled then
        boatFlyEnabled = false
        Toggles.BoatFly:SetValue(false)
    end
end

local function startBoatFly()
    currentSeat, currentBoat = getPlayerSeatAndBoat()
    
    if currentSeat and currentBoat then
        boatRoot = getBoatRoot(currentBoat)
        if not boatRoot then return false end
        
        if currentSeat:IsA("VehicleSeat") then
            currentSeat.HeadsUpDisplay = false
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
        
        boatBV = Instance.new("BodyVelocity")
        boatBV.MaxForce = Vector3.new(9e9,9e9,9e9)
        boatBV.Velocity = Vector3.zero
        boatBV.Parent = boatRoot
        
        boatBG = Instance.new("BodyGyro")
        boatBG.MaxTorque = Vector3.new(9e9,9e9,9e9)
        boatBG.P = 5000
        boatBG.D = 400
        boatBG.CFrame = boatRoot.CFrame
        boatBG.Parent = boatRoot
        
        keepSeated()
        seatWeldConnection = RunService.Heartbeat:Connect(keepSeated)
        
        flyKeyDown = UserInputService.InputBegan:Connect(function(input, processed)
            if processed or not boatFlyEnabled then return end
            if input.KeyCode == Enum.KeyCode.W then boatCONTROL.F = 1
            elseif input.KeyCode == Enum.KeyCode.S then boatCONTROL.B = 1
            elseif input.KeyCode == Enum.KeyCode.A then boatCONTROL.L = 1
            elseif input.KeyCode == Enum.KeyCode.D then boatCONTROL.R = 1
            elseif input.KeyCode == Enum.KeyCode.C then boatCONTROL.U = 1
            elseif input.KeyCode == Enum.KeyCode.V then boatCONTROL.D = 1 end
        end)
        
        flyKeyUp = UserInputService.InputEnded:Connect(function(input, processed)
            if processed or not boatFlyEnabled then return end
            if input.KeyCode == Enum.KeyCode.W then boatCONTROL.F = 0
            elseif input.KeyCode == Enum.KeyCode.S then boatCONTROL.B = 0
            elseif input.KeyCode == Enum.KeyCode.A then boatCONTROL.L = 0
            elseif input.KeyCode == Enum.KeyCode.D then boatCONTROL.R = 0
            elseif input.KeyCode == Enum.KeyCode.C then boatCONTROL.U = 0
            elseif input.KeyCode == Enum.KeyCode.V then boatCONTROL.D = 0 end
        end)
        
        noclipConnection = RunService.Heartbeat:Connect(applyNoclip)
        
        boatFlyConnection = RunService.Heartbeat:Connect(function()
            if not boatFlyEnabled then return end
            
            local seat, boat = getPlayerSeatAndBoat()
            
            if not seat or not boat then
                stopBoatFly(true)
                waitingForBoat = true
                return
            end
            
            if waitingForBoat then
                waitingForBoat = false
                startBoatFly()
                return
            end
            
            if boat ~= currentBoat then
                currentBoat = boat
                currentSeat = seat
                boatRoot = getBoatRoot(boat)
                if boatBV then boatBV.Parent = boatRoot end
                if boatBG then boatBG.Parent = boatRoot end
            end
            
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.zero
            
            if boatCONTROL.F == 1 then moveDir = moveDir + cam.CFrame.LookVector end
            if boatCONTROL.B == 1 then moveDir = moveDir - cam.CFrame.LookVector end
            if boatCONTROL.R == 1 then moveDir = moveDir + cam.CFrame.RightVector end
            if boatCONTROL.L == 1 then moveDir = moveDir - cam.CFrame.RightVector end
            
            local hMove = Vector3.new(moveDir.X, 0, moveDir.Z)
            if hMove.Magnitude > 0 then hMove = hMove.Unit * boatFlyHSpeed end
            
            local vVel = 0
            if boatCONTROL.U == 1 then vVel = boatFlyVSpeed end
            if boatCONTROL.D == 1 then vVel = -boatFlyVSpeed end
            
            boatBV.Velocity = hMove + Vector3.new(0, vVel, 0)
            
            local look = cam.CFrame.LookVector
            local flatLook = Vector3.new(look.X, 0, look.Z).Unit
            
            if hMove.Magnitude > 0 then
                boatBG.CFrame = CFrame.lookAt(Vector3.zero, hMove)
            else
                boatBG.CFrame = CFrame.lookAt(Vector3.zero, flatLook)
            end
        end)
        
        return true
    end
    
    return false
end

BoatFlyBox:AddToggle('BoatFly', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Fly. but on a boat',
}):AddKeyPicker('BoatFlyKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Boat Fly',
    SyncToggleState = true,
})

BoatFlyBox:AddSlider('BoatFlyHSpeed', { Text = 'Horizontal Speed', Default = 100, Min = 10, Max = 800, Rounding = 0 })
BoatFlyBox:AddSlider('BoatFlyVSpeed', { Text = 'Vertical Speed', Default = 100, Min = 5, Max = 800, Rounding = 0 })
BoatFlyBox:AddToggle('BoatNoclip', { Text = 'Boat NoClip', Default = false })
BoatFlyBox:AddLabel('Hold [C] to go up')
BoatFlyBox:AddLabel('Hold [V] to go down')

Toggles.BoatFly:OnChanged(function()
    boatFlyEnabled = Toggles.BoatFly.Value
    waitingForBoat = false
    
    if boatFlyEnabled then
        if not startBoatFly() then
            waitingForBoat = true
            Library:Notify("[BoatFly] >> get on a boat bro", 6)
            
            task.spawn(function()
                while boatFlyEnabled and waitingForBoat do
                    if startBoatFly() then
                        waitingForBoat = false
                        break
                    end
                    task.wait(0.5)
                end
            end)
        end
    else
        stopBoatFly(false)
        waitingForBoat = false
    end
end)

Options.BoatFlyHSpeed:OnChanged(function() boatFlyHSpeed = Options.BoatFlyHSpeed.Value end)
Options.BoatFlyVSpeed:OnChanged(function() boatFlyVSpeed = Options.BoatFlyVSpeed.Value end)
Toggles.BoatNoclip:OnChanged(function() 
    boatNoclipEnabled = Toggles.BoatNoclip.Value
end)

-- // ============================================================== Player Tab ============================================================== \\ --

-- ===== Save Energy =====
local SaveEnergyBox = Tabs.Player:AddLeftGroupbox('Save Energy')

local saveEnergyEnabled = false
local blockDashEnergy = false
local blockGeppoEnergy = false
local blockDJEnergy = false

task.spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg, false)
    local prev = old
    gg.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" and rawequal(self, CommE) then
            local args = table.pack(...)
            if args[1] == "Dodge" then
                if blockDashEnergy and args[2] == nil and type(args[3]) == "number" then return end
                if blockGeppoEnergy and args[2] == "Geppo" then return end
            end
            
            if args[1] == "DoubleJump" then
                if blockDJEnergy and args[2] == false then return end
            end
        end
        return prev(self, ...)
    end)
    setreadonly(gg, true)
end)

SaveEnergyBox:AddToggle('SaveEnergy', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Blocks certain actions from consuming your energy',
}):AddKeyPicker('SaveEnergyKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Save Energy',
    SyncToggleState = true,
})

local SaveEnergyDepbox = SaveEnergyBox:AddDependencyBox()
SaveEnergyDepbox:AddToggle('BlockDashEnergy', { Text = 'Dashing', Default = false })
SaveEnergyDepbox:AddToggle('BlockDJEnergy', { Text = 'Double Jump', Default = false })
SaveEnergyDepbox:AddToggle('BlockGeppoEnergy', { Text = 'Geppos', Default = false })
SaveEnergyDepbox:SetupDependencies({ {Toggles.SaveEnergy, true} })

Toggles.SaveEnergy:OnChanged(function()
    saveEnergyEnabled = Toggles.SaveEnergy.Value
    if not saveEnergyEnabled then blockDashEnergy = false blockGeppoEnergy = false blockDJEnergy = false end
end)
Toggles.BlockDashEnergy:OnChanged(function() blockDashEnergy = Toggles.BlockDashEnergy.Value end)
Toggles.BlockGeppoEnergy:OnChanged(function() blockGeppoEnergy = Toggles.BlockGeppoEnergy.Value end)
Toggles.BlockDJEnergy:OnChanged(function() blockDJEnergy = Toggles.BlockDJEnergy.Value end)

-- ===== No Soru Cooldown =====
local NoSoruBox = Tabs.Player:AddLeftGroupbox('No Soru Cooldown')

local soruEnabled = false
local soruConnection
local defaultCooldown = 0

NoSoruBox:AddToggle('NoSoru', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Removes Soru cooldown',
}):AddKeyPicker('NoSoruKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'No Soru Cooldown',
    SyncToggleState = true,
})

Toggles.NoSoru:OnChanged(function()
    soruEnabled = Toggles.NoSoru.Value
    if soruEnabled then
        if character2 then
            local s = character2:GetAttribute("FlashstepCooldown")
            if s then defaultCooldown = s end
        end
        soruConnection = RunService.Heartbeat:Connect(function()
            if not soruEnabled then if soruConnection then soruConnection:Disconnect() end return end
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("FlashstepCooldown", 1) end
        end)
    else
        if soruConnection then soruConnection:Disconnect() soruConnection = nil end
        if character2 then character2:SetAttribute("FlashstepCooldown", defaultCooldown) end
    end
end)

-- ===== Chest Reach =====
local ChestRangeBox = Tabs.Player:AddRightGroupbox('Chest Reach')

local originalChestSizes = {}
ChestRangeBox:AddToggle('ChestRange', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Open chests from far away',
}):AddKeyPicker('ChestRangeKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Chest Range',
    SyncToggleState = true,
})

Toggles.ChestRange:OnChanged(function()
    local v = Toggles.ChestRange.Value
    task.wait()
    if v then
        local mapFolder = workspace:FindFirstChild("Map")
        if mapFolder then
            for _, obj in ipairs(mapFolder:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name == "Chest1" or obj.Name == "Chest2" or obj.Name == "Chest3") then
                    if not originalChestSizes[obj] then originalChestSizes[obj] = obj.Size end
                    if obj.Size.X ~= 100 then obj.Size = Vector3.new(100,100,100) end
                end
            end
        end
    else
        for chest, size in pairs(originalChestSizes) do
            if chest and chest.Parent then chest.Size = size end
        end
        table.clear(originalChestSizes)
    end
end)

-- ===== Unbreakable =====
local UnbreakableBox = Tabs.Player:AddRightGroupbox('Unbreakable')

local unbreakableEnabled = false
local defaultUnbreakable = nil

UnbreakableBox:AddToggle('Unbreakable', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Prevent your skills from getting interupted',
}):AddKeyPicker('UnbreakableKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Unbreakable',
    SyncToggleState = true,
})

Toggles.Unbreakable:OnChanged(function()
    unbreakableEnabled = Toggles.Unbreakable.Value
    local c2 = charFolder:FindFirstChild(plr.Name)
    if unbreakableEnabled then
        if c2 then defaultUnbreakable = c2:GetAttribute("UnbreakableAll") c2:SetAttribute("UnbreakableAll", true) end
    else
        if c2 then c2:SetAttribute("UnbreakableAll", defaultUnbreakable) end
    end
end)

task.spawn(function()
    while task.wait() do
        if unbreakableEnabled then
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("UnbreakableAll", true) end
        end
    end
end)

-- // ============================================================== Misc Tab ============================================================== \\ --

-- ===== Shop =====
local ShopBox = Tabs.Misc:AddLeftGroupbox('Shop')
ShopBox:AddButton({
    Text = 'Roll Fruit',
    Tooltip = 'gambling $$$',
    Func = function()
        CommF:InvokeServer("Cousin", "Buy", "DLCBoxData")
    end,
})

-- ===== Fruit Shop =====
local FruitShopBox = Tabs.Misc:AddLeftGroupbox('Fruit Shop')

local container = FruitShopBox.Container
local layout = container:FindFirstChildOfClass("UIListLayout")

local function clearDynamicContent()
    if not container then return end
    
    for _, child in ipairs(container:GetChildren()) do
        if child ~= layout then
            child:Destroy()
        end
    end
end

local function fetchFruitData(isAdvanced)
    isAdvanced = isAdvanced or false
    local success, data = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("GetFruits", isAdvanced)
    end)
    
    if success and data then
        return data
    end
    return nil
end

local function buyFruit(fruitName, isAdvanced)
    isAdvanced = isAdvanced or false
    
    local success, result = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("PurchaseRawFruit", fruitName, isAdvanced)
    end)
    
    if success then
        Library:Notify("Purchased " .. fruitName .. "!", 5)
    else
        Library:Notify("Failed to purchase " .. fruitName .. "!", 5)
    end
end

local function create()
    clearDynamicContent()
    
    local refreshBtn = FruitShopBox:AddButton({
        Text = 'Refresh Stock',
        Func = function()
            create()
            Library:Notify("Refreshed Fruit Stock!", 5)
        end
    })

    FruitShopBox:AddDivider()
    
    -- normal stock
    local normalStock = fetchFruitData(false)
    if normalStock then
        local hasNormalStock = false
        for _, fruit in ipairs(normalStock) do
            if fruit.OnSale and not fruit.Offsale then
                hasNormalStock = true
                break
            end
        end
        
        if hasNormalStock then
            FruitShopBox:AddLabel("Stock (Normal)")
            
            for _, fruit in ipairs(normalStock) do
                if fruit.OnSale and not fruit.Offsale then
                    local btn = FruitShopBox:AddButton({
                        Text = fruit.Name,
                        Func = function()
                            Library:Notify(string.format("%s\nPrice: %d Beli\nRarity: %s", 
                                fruit.Name, fruit.Price,
                                fruit.Rarity == 0 and "Common" or
                                fruit.Rarity == 1 and "Uncommon" or
                                fruit.Rarity == 2 and "Rare" or
                                fruit.Rarity == 3 and "Legendary" or
                                fruit.Rarity == 4 and "Mythical" or "Unknown"), 5)
                        end,
                    })
                    
                    btn:AddButton({
                        Text = "Buy Fruit",
                        Func = function()
                            buyFruit(fruit.Name, false)
                        end,
                        DoubleClick = true,
                    })
                end
            end
        end
    end
    
    -- advanced stock
    local advancedStock = fetchFruitData(true)
    if advancedStock then
        local hasAdvancedStock = false
        for _, fruit in ipairs(advancedStock) do
            if fruit.OnSale and not fruit.Offsale then
                hasAdvancedStock = true
                break
            end
        end
        
        if hasAdvancedStock then
            FruitShopBox:AddDivider()
            FruitShopBox:AddLabel("Stock (Advanced)")
            
            for _, fruit in ipairs(advancedStock) do
                if fruit.OnSale and not fruit.Offsale then
                    local btn = FruitShopBox:AddButton({
                        Text = fruit.Name,
                        Func = function()
                            Library:Notify(string.format("%s\nPrice: %d Beli\nRarity: %s", 
                                fruit.Name, fruit.Price,
                                fruit.Rarity == 0 and "Common" or
                                fruit.Rarity == 1 and "Uncommon" or
                                fruit.Rarity == 2 and "Rare" or
                                fruit.Rarity == 3 and "Legendary" or
                                fruit.Rarity == 4 and "Mythical" or "Unknown"), 5)
                        end,
                    })
                    
                    btn:AddButton({
                        Text = "Buy Fruit",
                        Func = function()
                            buyFruit(fruit.Name, true)
                        end,
                        DoubleClick = true,
                    })
                end
            end
        end
    end
    
    FruitShopBox:Resize()
end

create()

-- ===== Trolling =====
local TrollingBox = Tabs.Misc:AddRightGroupbox('Trolling')

local selectedTpBoat = nil
local boatMap = {}

local function getBoatList()
    local list = {}
    boatMap = {}
    local boatsFolder = workspace:FindFirstChild("Boats")
    if not boatsFolder then return list end
    for _, boat in ipairs(boatsFolder:GetChildren()) do
        local ownerVal = boat:FindFirstChild("Owner")
        local owner = ownerVal and tostring(ownerVal.Value) or "Unknown"
        local label = boat.Name.." ("..owner..")"
        table.insert(list, label)
        boatMap[label] = boat
    end
    return list
end

local function getAvailableSeat(boat)
    for _, v in ipairs(boat:GetDescendants()) do
        if (v:IsA("Seat") or v:IsA("VehicleSeat")) and not v:FindFirstChild("SeatWeld") then return v end
    end
    return nil
end

local initialBoatList = getBoatList()
if #initialBoatList == 0 then initialBoatList = {"None"} end

TrollingBox:AddDivider()
TrollingBox:AddLabel("Boat Teleport")

TrollingBox:AddDropdown('BoatTpSelect', {
    Text = 'Select Boat',
    Values = initialBoatList,
    Default = 1,
    Tooltip = 'Pick a boat to teleport',
})
Options.BoatTpSelect:OnChanged(function() selectedTpBoat = Options.BoatTpSelect.Value end)
selectedTpBoat = initialBoatList[1]

TrollingBox:AddButton({
    Text = 'Refresh Boat List',
    Func = function()
        local newList = getBoatList()
        if #newList == 0 then newList = {"None"} end
        Options.BoatTpSelect:SetValues(newList)
        Options.BoatTpSelect:SetValue(newList[1])
        selectedTpBoat = newList[1]
        Library:Notify("Refreshed boat list!", 3)
    end,
})

TrollingBox:AddButton({
    Text = 'Teleport Boat',
    Func = function()
        if not selectedTpBoat or selectedTpBoat == "None" then
            Library:Notify("Select a boat first!", 5) return
        end
        local boat = boatMap[selectedTpBoat]
        if not boat or not boat.Parent then Library:Notify("Boat not found!", 5) return end
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if not hrp or not hum then Library:Notify("Character not ready!", 5) return end
        local seat = getAvailableSeat(boat)
        if not seat then Library:Notify("No available seats!", 5) return end
        if (seat.Position - hrp.Position).Magnitude < 1000 then
            Library:Notify("Boat is too close! Must be at least 1000 studs away.", 5) return
        end
        hrp.CFrame = seat.CFrame
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        task.spawn(function()
            local attempts = 0
            repeat task.wait(0.1) attempts = attempts + 1 until hum.SeatPart ~= nil or attempts >= 15
            if hum.SeatPart then Library:Notify("Teleported boat!", 5)
            else Library:Notify("Failed to sit, try again!", 5) end
        end)
    end,
})

-- ===== Teams =====
local TeamsBox = Tabs.Misc:AddRightGroupbox('Teams')
TeamsBox:AddButton({
    Text = 'Join Marines',
    Tooltip = 'Switches to the Marines team',
    Func = function()
        CommF:InvokeServer("SetTeam", "Marines")
    end,
})
TeamsBox:AddButton({
    Text = 'Join Pirates',
    Tooltip = 'Switches to the Pirates team',
    Func = function()
        CommF:InvokeServer("SetTeam", "Pirates")
    end,
})

-- ===== Server =====
local ServerBox = Tabs.Misc:AddRightGroupbox('Server')

getServers = function(placeId)
    local servers = {}
    local cursor = ""
    repeat
        local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"..cursor
        local success, res = pcall(function() return request({Url = url, Method = "GET"}) end)
        if success and res and res.Body then
            local ok, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
            if ok and data and data.data then
                for _, server in ipairs(data.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server)
                    end
                end
                cursor = data.nextPageCursor and ("&cursor="..data.nextPageCursor) or nil
            else break end
        else break end
        task.wait()
    until not cursor
    return servers
end

ServerBox:AddButton({
    Text = 'Server Hop (Normal)',
    Func = function()
        local servers = getServers(game.PlaceId)
        if #servers == 0 then Library:Notify("No servers found!", 5) return end
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)].id)
    end,
})

ServerBox:AddButton({
    Text = 'Server Hop (Lowest)',
    Func = function()
        local servers = getServers(game.PlaceId)
        if #servers == 0 then Library:Notify("No servers found!", 5) return end
        table.sort(servers, function(a,b) return a.playing < b.playing end)
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[1].id)
    end,
})

ServerBox:AddButton({
    Text = 'Rejoin Server',
    Func = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end,
})

-- // ============================================================== Utils ============================================================== \\ --

getSpawnedChests = function()
    local spawnedChests = {}
    local mapFolder = workspace:FindFirstChild("Map")
    if not mapFolder then return spawnedChests end
    local function search(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("BasePart") and (child.Name == "Chest3" or child.Name == "Chest2" or child.Name == "Chest1") then
                local hasTouchInterest = false
                for _, obj in ipairs(child:GetChildren()) do
                    if obj:IsA("TouchTransmitter") then hasTouchInterest = true break end
                end
                if hasTouchInterest then
                    local count = 0
                    local kept = false
                    for _, obj in ipairs(child:GetChildren()) do
                        if obj.ClassName == "TouchInterest" or obj:IsA("TouchTransmitter") then
                            count = count + 1
                            if kept then obj:Destroy() else kept = true end
                        end
                    end
                    table.insert(spawnedChests, child)
                end
            end
            if #child:GetChildren() > 0 then search(child) end
        end
    end
    search(mapFolder)
    return spawnedChests
end

watchChest = function(chest)
    if chestConnection then chestConnection:Disconnect() chestConnection = nil end
    currentChest = chest
    chestConnection = chest.ChildRemoved:Connect(function(child)
        if child:IsA("TouchTransmitter") or child.ClassName == "TouchInterest" then
            currentChest = nil
        end
    end)
end

-- // ============================================================== UI Settings ============================================================== \\ --

Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('catware - %s fps - %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

Library.KeybindFrame.Visible = true;

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton({ Text = 'Unload', Func = function() Library:Unload() end })
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'LeftAlt', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder('catware')
SaveManager:SetFolder('catware/bloxfruits')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()

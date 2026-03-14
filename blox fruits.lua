local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bro925/test/refs/heads/main/bro.lua"))()

local Wm = library:Watermark("catware | rank: " .. library.rank)
local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
coroutine.wrap(function()
    while wait(1) do
        FpsWm:Text("fps: " .. library.fps)
    end
end)()

local Notif = library:InitNotifications()
library.title = "catware - Blox Fruits | Build 030126"

coroutine.wrap(function()
    library:Introduction()
end)()

wait(1)
local Init = library:Init()

-- // ============================================================== variables n other shit ============================================================== \\ --
local charFolder = workspace:FindFirstChild("Characters")

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local NetModule = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"))
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local CommE = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommE")
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")

local RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RegisterHit = Net:WaitForChild("RE/RegisterHit")

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local request = http_request or request
local getServers

local plr = game.Players.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local character2 = charFolder:FindFirstChild(plr.Name)

-- seas
local First_Sea = false
local Second_Sea = false
local Third_Sea = false
local placeId = game.PlaceId

if placeId == 2753915549 then First_Sea = true
elseif placeId == 4442272183 then Second_Sea = true
elseif placeId == 7449423635 then Third_Sea = true
end

-- sword list
local swordList = {
    "Cutlass", "Katana", "Dual Katana", "Triple Katana", "Iron Mace", "Shark Saw",
    "Twin Hooks", "Dragon Trident", "Dual-Headed Blade", "Flail", "Gravity Blade",
    "Longsword", "Pipe", "Soul Cane", "Trident", "Wardens Sword", "Bisento",
    "Buddy Sword", "Canvander", "Dark Dagger", "Dragonheart", "Fox Lamp", "Koko",
    "Midnight Blade", "Oroshi", "Pole (1st Form)", "Pole (2nd Form)", "Rengoku",
    "Saber", "Saishi", "Shark Anchor", "Shizu", "Spikey Trident", "Tushita",
    "Yama", "Cursed Dual Katana", "Dark Blade", "Hallow Scythe", "True Triple Katana"
}

-- quests
-- format: ["display name"] = {RemoteQuestName, QuestLevelIndex, Sea}
local quests = {
    -- sea 1
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

    -- sea 2
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

    -- sea 3
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
    ["[Lv.2450] Isle Outlaw"] = {"TikiQuest1", 1, "Third"}
}


-- // ============================================================== Combat Tab ============================================================== \\ --
local combat = Init:NewTab("Combat")
local mainS = combat:NewSection("Main")
local killAuraEnabled = false
local auraRange = 50
local auraSpeed = 20
local auraSwitchDelay = 0
local auraTargetType = "Mobs"
local auraKey = Enum.KeyCode.Y
local auraCircleEnabled = false
local spoofWeaponEnabled = false
local spoofWeaponType = "Melee"
local currentTargetIndex = 1
local instaKillMode = false

-- visual circle
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

local bodyParts = {
    "UpperTorso", "LowerTorso", "Head",
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    "RightUpperLeg", "RightLowerLeg", "RightFoot"
}

local partCache = setmetatable({}, {__mode = "v"})

local function getTargetPart(model)
    if partCache[model] and partCache[model].Parent then
        return partCache[model]
    end
    
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

local function fireHit(targetModel)
    local targetPart = getTargetPart(targetModel)
    if targetPart then
        NetModule:RemoteEvent("RegisterAttack"):FireServer(0)
        NetModule:RemoteEvent("RegisterHit"):FireServer(targetPart, {})
    end
end

local function isUsingTRexFruit()
    local data = plr:FindFirstChild("Data")
    if not data then return false end
    for _, obj in ipairs(data:GetChildren()) do
        if obj:IsA("StringValue") and obj.Value == "T-Rex-T-Rex" then
            return true
        end
    end
    return false
end

local function fireTRexAttack(targetHrp)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end

    local direction = (targetHrp.Position - hrp.Position).Unit
    local tRexFolder = character:FindFirstChild("T-Rex-T-Rex")
    if not tRexFolder then return end
    local remote = tRexFolder:FindFirstChild("LeftClickRemote")
    if not remote then return end

    local args = {
        vector.create(direction.X, direction.Y, direction.Z),
        1
    }
    remote:FireServer(table.unpack(args))
end

local function getSWeapon()
    local backpack = plr:FindFirstChild("Backpack")
    if not backpack then return nil end
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:GetAttribute("WeaponType") == spoofWeaponType then
            return tool
        end
    end
    return nil
end

killAuraToggle = combat:NewToggle("Kill Aura", false, function(v)
    killAuraEnabled = v
    if v then
        Notif:Notify("Enabled Kill Aura", 5, "success")
        task.spawn(function()
            local enemiesFolder = workspace:FindFirstChild("Enemies")
            local charactersFolder = workspace:FindFirstChild("Characters")
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
                                if enemiesFolder then
                                    for _, target in ipairs(enemiesFolder:GetChildren()) do
                                        local targetHum = target:FindFirstChildOfClass("Humanoid")
                                        if targetHum and targetHum.Health > 0 then
                                            local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                            if targetHrp and (hrp.Position - targetHrp.Position).Magnitude < 1000 then
                                                targetHum.Health = 0
                                            end
                                        end
                                    end
                                end
                                lastTargetScan = startTime
                            end
                        else
                            local currentTool = char:FindFirstChildOfClass("Tool")
                            local usingTRex = isUsingTRexFruit()

                            local canAttack = (currentTool and currentTool.ToolTip ~= "Gun") or spoofWeaponEnabled
                            local usingDemonFruit = spoofWeaponEnabled and spoofWeaponType == "Demon Fruit"

                            if usingDemonFruit and usingTRex then
                                canAttack = true
                            end
                            
                            if canAttack then
                                if startTime - lastTargetScan > 0.3 then
                                    cachedTargets = {}
                                    
                                    if auraTargetType == "Mobs" and enemiesFolder then
                                        for _, target in ipairs(enemiesFolder:GetChildren()) do
                                            local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                            local targetHum = target:FindFirstChild("Humanoid")
                                            if targetHrp and targetHum and targetHum.Health > 0 then
                                                if (hrp.Position - targetHrp.Position).Magnitude < auraRange then
                                                    table.insert(cachedTargets, target)
                                                end
                                            end
                                        end
                                    elseif auraTargetType == "Players" and charactersFolder then
                                        for _, target in ipairs(charactersFolder:GetChildren()) do
                                            if target ~= char then
                                                local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                                local targetHum = target:FindFirstChild("Humanoid")
                                                if targetHrp and targetHum and targetHum.Health > 0 then
                                                    if (hrp.Position - targetHrp.Position).Magnitude < auraRange then
                                                        table.insert(cachedTargets, target)
                                                    end
                                                end
                                            end
                                        end
                                    elseif auraTargetType == "Both" then
                                        if enemiesFolder then
                                            for _, target in ipairs(enemiesFolder:GetChildren()) do
                                                local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                                local targetHum = target:FindFirstChild("Humanoid")
                                                if targetHrp and targetHum and targetHum.Health > 0 then
                                                    if (hrp.Position - targetHrp.Position).Magnitude < auraRange then
                                                        table.insert(cachedTargets, target)
                                                    end
                                                end
                                            end
                                        end
                                        if charactersFolder then
                                            for _, target in ipairs(charactersFolder:GetChildren()) do
                                                if target ~= char then
                                                    local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                                    local targetHum = target:FindFirstChild("Humanoid")
                                                    if targetHrp and targetHum and targetHum.Health > 0 then
                                                        if (hrp.Position - targetHrp.Position).Magnitude < auraRange then
                                                            table.insert(cachedTargets, target)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    
                                    lastTargetScan = startTime
                                end
                                
                                if #cachedTargets > 0 then
                                    if currentTargetIndex > #cachedTargets then 
                                        currentTargetIndex = 1 
                                    end
                                    
                                    local target = cachedTargets[currentTargetIndex]
                                    local targetHrp = target:FindFirstChild("HumanoidRootPart")

                                    if usingDemonFruit and usingTRex and targetHrp then
                                        fireTRexAttack(targetHrp)
                                    elseif spoofWeaponEnabled then
                                        fireHit(target)
                                    elseif currentTool then
                                        fireHit(target)
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
    else
        Notif:Notify("Disabled Kill Aura", 5, "error")
    end
end)
killAuraToggle:AddKeybind(auraKey)

local auraTargetSelect = combat:NewSelector("Targets", "Select who to target", {"Players", "Mobs", "Both"}, function(v)
    auraTargetType = v
end)

local auraRangeSlider = combat:NewSlider("Aura Range", " Studs", false, "/", {min = 1, max = 60, default = 50}, function(v)
    auraRange = v
end)

local auraSpeedSlider = combat:NewSlider("Attack Speed", " Attack/s", false, "/", {min = 1, max = 100, default = 20}, function(v)
    auraSpeed = v
end)

local auraSwitchSlider = combat:NewSlider("Switch Delay", " Second", false, "/", {min = 0, max = 1, default = 0}, function(v)
    auraSwitchDelay = v
end)

local spoofToggle = combat:NewToggle("Spoof Weapon", false, function(v)
    spoofWeaponEnabled = v
end)

local spoofTypeSelect = combat:NewSelector("Weapon Type", "Select a weapon", {"Melee", "Sword", "Demon Fruit"}, function(v)
    spoofWeaponType = v
end)

local auraCircleToggle = combat:NewToggle("Visual Circle", false, function(v)
    auraCircleEnabled = v
end)

local instaKillToggle = combat:NewToggle("Insta-Kill", false, function(v)
    instaKillMode = v
end)

task.spawn(function()
    while task.wait() do
        updateCircle()
    end
end)

task.spawn(function()
    while task.wait() do
        local s = killAuraEnabled
        local sw = spoofWeaponEnabled
        auraTargetSelect[s and "Show" or "Hide"](auraTargetSelect)
        auraRangeSlider[s and "Show" or "Hide"](auraRangeSlider)
        auraSpeedSlider[s and "Show" or "Hide"](auraSpeedSlider)
        auraSwitchSlider[s and "Show" or "Hide"](auraSwitchSlider)
        auraCircleToggle[s and "Show" or "Hide"](auraCircleToggle)
        spoofToggle[s and "Show" or "Hide"](spoofToggle)
        spoofTypeSelect[(s and sw) and "Show" or "Hide"](spoofTypeSelect)
        instaKillToggle[s and "Show" or "Hide"](instaKillToggle)
    end
end)

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

local function getMouseScreenPos()
    return UserInputService:GetMouseLocation()
end

local function worldToScreen(pos)
    local screenPos, onScreen = camera:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen, screenPos.Z
end

local function getBestTarget()
    local mousePos = getMouseScreenPos()
    local bestTarget = nil
    local bestDist = math.huge

    local folders = aimbotTargetType == "Players" and {workspace.Characters}
        or aimbotTargetType == "Mobs" and {workspace.Enemies}
        or {workspace.Enemies, workspace.Characters}

    for _, folder in ipairs(folders) do
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
            if modified then
                return old(self, table.unpack(args, 1, args.n))
            end
        end
        return old(self, ...)
    end)
    setreadonly(gg, true)
end)

task.spawn(function()
    local lastTarget = nil
    while task.wait() do
        local mousePos = getMouseScreenPos()

        if aimbotEnabled then
            aimbotCircle.Visible = true
            aimbotCircle.Position = mousePos
            aimbotCircle.Radius = aimbotFOV
        else
            aimbotCircle.Visible = false
            aimbotCurrentTarget = nil
        end

        if aimbotEnabled then
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

            if not aimbotHighlightEnabled then
                clearHighlight()
                lastTarget = nil
            end
        else
            clearHighlight()
            lastTarget = nil
        end
    end
end)

local aimbotToggle = combat:NewToggle("Aimbot", false, function(v)
    aimbotEnabled = v
    if v then
        Notif:Notify("Enabled Aimbot", 5, "success")
    else
        aimbotCircle.Visible = false
        aimbotCurrentTarget = nil
        clearHighlight()
        Notif:Notify("Disabled Aimbot", 5, "error")
    end
end)

local aimbotTargetSel = combat:NewSelector("Aimbot Targets", "Select targets", {"Players", "Mobs", "Both"}, function(v)
    aimbotTargetType = v
end)

local aimbotFOVSlider = combat:NewSlider("FOV Size", " px", false, "/", {min = 10, max = 800, default = 150}, function(v)
    aimbotFOV = v
end)

local aimbotHighlightToggle = combat:NewToggle("Highlight Target", false, function(v)
    aimbotHighlightEnabled = v
    if not v then clearHighlight() end
end)

task.spawn(function()
    while task.wait() do
        local a = aimbotEnabled
        aimbotTargetSel[a and "Show" or "Hide"](aimbotTargetSel)
        aimbotFOVSlider[a and "Show" or "Hide"](aimbotFOVSlider)
        aimbotHighlightToggle[a and "Show" or "Hide"](aimbotHighlightToggle)
    end
end)

local otherS = combat:NewSection("Other")
local function isSword(name)
    for _, sword in ipairs(swordList) do
        if name == sword then return true end
    end
    return false
end

local fastAttackEnabled = false
local fastAttackConnection
local attackDistance = 10
local oldAttackSpeed = 1

local fastAttack = combat:NewToggle("Fast Attack", false, function(value)
    fastAttackEnabled = value
    if value then
        if character then
            oldAttackSpeed = character:GetAttribute("AttackSpeedMultiplier") or 1
        end

        Notif:Notify("Enabled Fast Attack", 5, "success")

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
                    local targetFolders = {workspace.Enemies, workspace.Characters}

                    for _, folder in pairs(targetFolders) do
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
        if fastAttackConnection then
            fastAttackConnection:Disconnect()
            fastAttackConnection = nil
        end

        if character then
            character:SetAttribute("AttackSpeedMultiplier", oldAttackSpeed)
        end

        Notif:Notify("Disabled Fast Attack", 5, "error")
    end
end)

local noFM1Enabled = false
local noFM1Connection
local defaultFruitM1Speed = 0
local noFruitM1Cooldown = combat:NewToggle("No Fruit M1 Cooldown", false, function(value)
    noFM1Enabled = value
    
    if value then
        if character2 then
            local defaultFruitM1Speed = character2:GetAttribute("FruitTAPCooldown")
            if defaultFruitM1Speed then
                defaultFM1Speed = defaultFruitM1Speed
            end
        end

        Notif:Notify("Enabled No Fruit M1 Cooldown", 5, "success")
        
        noFM1Connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not noFM1Enabled then 
                if noFM1Connection then noFM1Connection:Disconnect() end
                return 
            end

            if charFolder then
                local character2 = charFolder:FindFirstChild(plr.Name)
                if character2 then
                    character2:SetAttribute("FruitTAPCooldown", 1)
                end
            end
        end)
    else
        if noFM1Connection then
            noFM1Connection:Disconnect()
            noFM1Connection = nil
        end
        
        if character2 then
            character2:SetAttribute("FruitTAPCooldown", defaultFM1Speed)
        end
        
        Notif:Notify("Disabled No Fruit M1 Cooldown", 5, "error")
    end
end)

local rangeEnabled = false
local rangeX, rangeY, rangeZ = 50, 50, 50
local originalSizes = {}
local hitboxConnection
local extendRange = combat:NewToggle("Sword Reach", false, function(v)
    rangeEnabled = v
    if not v then
        Notif:Notify("Disabled Sword Reach", 5, "error")
        for part, size in pairs(originalSizes) do
            if part and part.Parent then
                part.Size = size
            end
        end
        originalSizes = {}
        if hitboxConnection then hitboxConnection:Disconnect() end
    else
        Notif:Notify("Enabled Sword Reach", 5, "success")
        hitboxConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not rangeEnabled then return end
            
            local tool = character:FindFirstChildOfClass("Tool")
            if tool and isSword(tool.Name) then
                local weaponModel = character:FindFirstChild("EquippedWeapon")
                if weaponModel then
                    for _, part in ipairs(weaponModel:GetDescendants()) do
                        if part.Name == "Handle" and part:IsA("BasePart") then
                            if not originalSizes[part] then
                                originalSizes[part] = part.Size
                            end
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

local sliderX = combat:NewSlider("X Reach", "", true, "/", {min = 1, max = 100, default = 50}, function(v) rangeX = v end)
local sliderY = combat:NewSlider("Y Reach", "", true, "/", {min = 1, max = 100, default = 50}, function(v) rangeY = v end)
local sliderZ = combat:NewSlider("Z Reach", "", true, "/", {min = 1, max = 100, default = 50}, function(v) rangeZ = v end)

task.spawn(function()
    while task.wait() do
        if rangeEnabled then
            sliderX:Show() sliderY:Show() sliderZ:Show()
        else
            sliderX:Hide() sliderY:Hide() sliderZ:Hide()
        end
    end
end)

local hitboxEnabled = false
local hitboxTargetType = "Mobs"
local hitboxX, hitboxY, hitboxZ = 10, 10, 10
local originalHeadSizes = {}
local hitboxConnection

local hitboxToggle = combat:NewToggle("Increase Hitbox", false, function(v)
    hitboxEnabled = v
    if v then
        Notif:Notify("Enabled Increase Hitbox", 5, "success")
        hitboxConnection = RunService.Heartbeat:Connect(function()
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
                    end
                end
            end
        end)
    else
        if hitboxConnection then hitboxConnection:Disconnect() hitboxConnection = nil end
        for head, size in pairs(originalHeadSizes) do
            if head and head.Parent then
                head.Size = size
            end
        end
        originalHeadSizes = {}
        Notif:Notify("Disabled Increase Hitbox", 5, "error")
    end
end)

local hitboxTargetSel = combat:NewSelector("Targets", "Select targets", {"Players", "Mobs", "Both"}, function(v)
    hitboxTargetType = v
end)

local hitboxSliderX = combat:NewSlider("X Size", "", false, "/", {min = 1, max = 100, default = 10}, function(v) hitboxX = v end)
local hitboxSliderY = combat:NewSlider("Y Size", "", false, "/", {min = 1, max = 100, default = 10}, function(v) hitboxY = v end)
local hitboxSliderZ = combat:NewSlider("Z Size", "", false, "/", {min = 1, max = 100, default = 10}, function(v) hitboxZ = v end)

task.spawn(function()
    while task.wait() do
        local h = hitboxEnabled
        hitboxTargetSel[h and "Show" or "Hide"](hitboxTargetSel)
        hitboxSliderX[h and "Show" or "Hide"](hitboxSliderX)
        hitboxSliderY[h and "Show" or "Hide"](hitboxSliderY)
        hitboxSliderZ[h and "Show" or "Hide"](hitboxSliderZ)
    end
end)

-- // ============================================================== Farming Tab ============================================================== \\ --
local farm = Init:NewTab("Farming")
local chestf = farm:NewSection("Chest Farm")

-- vars
local chestFarmEnabled = false
local horizontalSpeed = 200
local boostEnabled = false
local noclipEnabled = false
local bodyVelocity

-- threads
local farmThread
local boostThread

-- chest stuff
local cachedChests = {}
local lastChestScan = 0
local currentChest = nil
local chestConnection = nil
local watchChest

local enabled = farm:NewToggle("Enabled", false, function(value)
    chestFarmEnabled = value
    if value then
        Notif:Notify("Enabled Chest Farm", 5, "success")
        
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
                            if d < dist then
                                dist = d
                                nearest = chest
                            end
                        end

                        if nearest then
                            watchChest(nearest)
                        end
                    end

                    if currentChest and currentChest.Parent then
                        local delta = currentChest.Position - hrp.Position
                        local direction = delta.Unit
                        
                        if delta.Magnitude < 3 then
                            hrp.CFrame = currentChest.CFrame
                            setPlayerMotion(Vector3.zero)
                        else
                            setPlayerMotion(direction * horizontalSpeed)
                        end
                    else
                        setPlayerMotion(Vector3.zero)
                    end
                end
                task.wait()
            end
        end)
    else
        Notif:Notify("Disabled Chest Farm", 5, "error")
        noclipEnabled = false
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
    end
end)

local speed = farm:NewSlider("Speed", "", true, "/", {min = 1, max = 215, default = 200}, function(value)
    horizontalSpeed = value
    if chestFarmEnabled and bodyVelocity and bodyVelocity.Parent then
        local currentDir = bodyVelocity.Velocity.Unit
        bodyVelocity.Velocity = currentDir * horizontalSpeed
    end
end)

local boost = farm:NewToggle("Boost", false, function(value)
    boostEnabled = value
    if value then
        Notif:Notify("Enabled Boost", 5, "success")
        
        boostThread = coroutine.wrap(function()
            while boostEnabled and chestFarmEnabled and character and character:FindFirstChild("HumanoidRootPart") do
                wait(2.67)
                if bodyVelocity and bodyVelocity.Parent then
                    local currentVelocity = bodyVelocity.Velocity
                    local boostedVelocity = Vector3.new(
                        currentVelocity.X + (currentVelocity.X > 0 and 800 or -800),
                        0,
                        currentVelocity.Z + (currentVelocity.Z > 0 and 800 or -800)
                    )
                    bodyVelocity.Velocity = boostedVelocity
                    wait(0.67)
                    bodyVelocity.Velocity = currentVelocity
                end
            end
        end)()
        boostThread()
        
    else
        Notif:Notify("Disabled Boost", 5, "error")
    end
end)

plr.CharacterAdded:Connect(function(newChar)
    character = newChar
    if chestFarmEnabled then
        wait(1)
        enabled:Change()
        wait(0.5)
        enabled:Change()
    end
end)

local generalS = farm:NewSection("General")
local bringMobsEnabled = false
local bringBossesEnabled = false
local bringRange = 300
local bringMobsToggle = farm:NewToggle("Bring Mobs", false, function(v)
    bringMobsEnabled = v
end)

local bringBossesToggle = farm:NewToggle("Bring Bosses", false, function(v)
    bringBossesEnabled = v
end)

task.spawn(function()
    while task.wait() do
        if bringMobsEnabled then
            bringBossesToggle:Show()
        else
            bringBossesToggle:Hide()
        end
    end
end)

local sethiddenproperty = sethiddenproperty or function(...) return ... end

task.spawn(function()
    while task.wait(0.2) do
        if bringMobsEnabled and character and character:FindFirstChild("HumanoidRootPart") then
            pcall(sethiddenproperty, game.Players.LocalPlayer, "SimulationRadius", math.huge)

            local root = character.HumanoidRootPart

            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                local mRoot = mob:FindFirstChild("HumanoidRootPart")
                local mHum = mob:FindFirstChild("Humanoid")

                if mRoot and mHum and mHum.Health > 0 then
                    local dist = (mRoot.Position - root.Position).Magnitude
                    if dist <= bringRange then

                        local isBoss = mob:GetAttribute("IsBoss") == true
                        if not isBoss or (isBoss and bringBossesEnabled) then
                            local targetPos = root.Position + Vector3.new(0, 0, 10)
                            local targetCFrame = CFrame.lookAt(targetPos, targetPos + Vector3.new(0, 1, 0))
                            
                            mRoot.CFrame = targetCFrame
                            mRoot.CanCollide = false

                            mRoot.AssemblyLinearVelocity = Vector3.zero
                            mRoot.AssemblyAngularVelocity = Vector3.zero

                            mHum:ChangeState(11)
                            mHum:ChangeState(14)
                            mHum:ChangeState(Enum.HumanoidStateType.Running)
                        end
                    end
                end
            end
        end
    end
end)

local questS = farm:NewSection("Quests")
local currentSeaQuests = {}

for name, data in pairs(quests) do
    if (First_Sea and data[3] == "First") or 
       (Second_Sea and data[3] == "Second") or 
       (Third_Sea and data[3] == "Third") then
        currentSeaQuests[name] = data
    end
end

local questList = {}
for name, _ in pairs(currentSeaQuests) do table.insert(questList, name) end
table.sort(questList, function(a, b)
    local lvA = tonumber(a:match("%d+")) or 0
    local lvB = tonumber(b:match("%d+")) or 0
    return lvA < lvB
end)

local selectedQuestData = nil

farm:NewSelector("Select Quest", "-", questList, function(current)
    selectedQuestData = currentSeaQuests[current]
end)

farm:NewButton("Start Quest", function()
    if selectedQuestData then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", selectedQuestData[1], selectedQuestData[2])
        Notif:Notify("Started Quest!", 6, "success")
    else
        Notif:Notify("Select a quest first!", 6, "error")
    end
end)

-- // ============================================================== Movement Tab ============================================================== \\ --
local movement = Init:NewTab("Movement")

local dashEnabled = false
local dashDistance = 100
local defaultDashLength = 0

local dashToggle = movement:NewToggle("Dash Distance", false, function(v)
    dashEnabled = v
    if v then
        local char2 = charFolder:FindFirstChild(plr.Name)
        if char2 then
            defaultDashLength = char2:GetAttribute("DashLength") or 0
        end
        Notif:Notify("Enabled Dash Distance", 5, "success")
    else
        local char2 = charFolder:FindFirstChild(plr.Name)
        if char2 then
            char2:SetAttribute("DashLength", defaultDashLength)
        end
        Notif:Notify("Disabled Dash Distance", 5, "error")
    end
end)

local dashSlider = movement:NewSlider("Distance", "", false, "/", {min = 0, max = 500, default = 100}, function(v)
    dashDistance = v
    if dashEnabled then
        local char2 = charFolder:FindFirstChild(plr.Name)
        if char2 then
            char2:SetAttribute("DashLength", dashDistance)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if dashEnabled then
            local char2 = charFolder:FindFirstChild(plr.Name)
            if char2 then
                char2:SetAttribute("DashLength", dashDistance)
            end
        end
        dashSlider[dashEnabled and "Show" or "Hide"](dashSlider)
    end
end)

local speedBoostEnabled = false
local speedBoostValue = 1
local defaultSpeedMult = 0

local speedBoostToggle = movement:NewToggle("Speed Boost", false, function(v)
    speedBoostEnabled = v
    if v then
        local char2 = charFolder:FindFirstChild(plr.Name)
        if char2 then
            defaultSpeedMult = char2:GetAttribute("SpeedMultiplier") or 1
        end
        Notif:Notify("Enabled Speed Boost", 5, "success")
    else
        local char2 = charFolder:FindFirstChild(plr.Name)
        if char2 then
            char2:SetAttribute("SpeedMultiplier", defaultSpeedMult)
        end
        Notif:Notify("Disabled Speed Boost", 5, "error")
    end
end)

local speedBoostSlider = movement:NewSlider("Speed Multiplier", "x", false, "/", {min = 1, max = 10, default = 2}, function(v)
    speedBoostValue = v
    if speedBoostEnabled then
        local char2 = charFolder:FindFirstChild(plr.Name)
        if char2 then
            char2:SetAttribute("SpeedMultiplier", speedBoostValue)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if speedBoostEnabled then
            local char2 = charFolder:FindFirstChild(plr.Name)
            if char2 then
                char2:SetAttribute("SpeedMultiplier", speedBoostValue)
            end
        end
        speedBoostSlider[speedBoostEnabled and "Show" or "Hide"](speedBoostSlider)
    end
end)

local boatFlyEnabled = false
local boatFlyHSpeed = 50
local boatFlyVSpeed = 30
local boatNoclipEnabled = false
local boatFlyKey = Enum.KeyCode.G

local boatCONTROL = {F = 0, B = 0, L = 0, R = 0, U = 0, D = 0}

local boatBV = nil
local boatBG = nil
local boatFlyConnection = nil
local flyKeyDown = nil
local flyKeyUp = nil
local seatWeldConnection = nil

local currentSeat = nil
local currentBoat = nil
local boatRoot = nil

local function getPlayerSeatAndBoat()
    local boatsFolder = workspace:FindFirstChild("Boats")
    if not boatsFolder then return nil, nil end
    local char = plr.Character
    if not char then return nil, nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return nil, nil end

    for _, boat in ipairs(boatsFolder:GetChildren()) do
        for _, v in ipairs(boat:GetDescendants()) do
            if v:IsA("VehicleSeat") and v.Occupant == hum then
                return v, boat
            end
            if v:IsA("Seat") then
                local sw = v:FindFirstChild("SeatWeld")
                if sw and sw.Part1 and sw.Part1:IsDescendantOf(char) then
                    return v, boat
                end
            end
        end
    end
    return nil, nil
end

local function getBoatRoot(boat)
    for _, part in ipairs(boat:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsA("Seat") and not part:IsA("VehicleSeat") then
            return part
        end
    end
    return currentSeat
end

local function keepSeated()
    if not currentSeat or not plr.Character then return end
    
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum.Sit == false then
        hum.Sit = true
    end
    
    local sw = currentSeat:FindFirstChild("SeatWeld")
    if not sw then
        sw = Instance.new("Weld")
        sw.Name = "SeatWeld"
        sw.Part0 = currentSeat
        sw.Part1 = plr.Character:FindFirstChild("HumanoidRootPart")
        sw.C0 = CFrame.new(0, 0, 0)
        sw.C1 = CFrame.new(0, 0, 0)
        sw.Parent = currentSeat
    else
        sw.Part1 = plr.Character:FindFirstChild("HumanoidRootPart")
    end
end

local function stopBoatFly()
    if boatBV and boatBV.Parent then boatBV:Destroy() end
    if boatBG and boatBG.Parent then boatBG:Destroy() end
    boatBV = nil
    boatBG = nil
    
    if boatFlyConnection then 
        boatFlyConnection:Disconnect()
        boatFlyConnection = nil
    end
    if flyKeyDown then 
        flyKeyDown:Disconnect()
        flyKeyDown = nil
    end
    if flyKeyUp then 
        flyKeyUp:Disconnect()
        flyKeyUp = nil
    end
    if seatWeldConnection then
        seatWeldConnection:Disconnect()
        seatWeldConnection = nil
    end
    
    boatCONTROL = {F = 0, B = 0, L = 0, R = 0, U = 0, D = 0}
    currentSeat = nil
    currentBoat = nil
    boatRoot = nil
end

local function startBoatFly()
    stopBoatFly()
    
    currentSeat, currentBoat = getPlayerSeatAndBoat()
    if not currentSeat or not currentBoat then
        if Notif then Notif:Notify("Not sitting in a boat!", 5, "error") end
        boatFlyEnabled = false
        return
    end

    boatRoot = getBoatRoot(currentBoat)
    if not boatRoot then
        if Notif then Notif:Notify("Could not find boat root!", 5, "error") end
        boatFlyEnabled = false
        return
    end

    if currentSeat:IsA("VehicleSeat") then
        currentSeat.HeadsUpDisplay = false
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end
    
    boatBV = Instance.new("BodyVelocity")
    boatBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    boatBV.Velocity = Vector3.zero
    boatBV.Parent = boatRoot
    
    boatBG = Instance.new("BodyGyro")
    boatBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
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

    boatFlyConnection = RunService.Heartbeat:Connect(function()
        if not boatFlyEnabled then return end
        
        local seat, boat = getPlayerSeatAndBoat()
        if not seat or not boat then
            stopBoatFly()
            boatFlyEnabled = false
            if Notif then Notif:Notify("Left boat, disabling fly", 3, "error") end
            return
        end
        
        if boat ~= currentBoat then
            currentBoat = boat
            currentSeat = seat
            boatRoot = getBoatRoot(boat)
            if boatBV then boatBV.Parent = boatRoot end
            if boatBG then boatBG.Parent = boatRoot end
        end
        
        if boatNoclipEnabled and currentBoat then
            for _, part in ipairs(currentBoat:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
        
        local camera = workspace.CurrentCamera
        local moveDir = Vector3.zero
        
        if boatCONTROL.F == 1 then moveDir = moveDir + camera.CFrame.LookVector end
        if boatCONTROL.B == 1 then moveDir = moveDir - camera.CFrame.LookVector end
        if boatCONTROL.R == 1 then moveDir = moveDir + camera.CFrame.RightVector end
        if boatCONTROL.L == 1 then moveDir = moveDir - camera.CFrame.RightVector end
        
        local horizontalMove = Vector3.new(moveDir.X, 0, moveDir.Z)
        if horizontalMove.Magnitude > 0 then
            horizontalMove = horizontalMove.Unit * boatFlyHSpeed
        end

        local verticalVel = 0
        if boatCONTROL.U == 1 then verticalVel = boatFlyVSpeed end
        if boatCONTROL.D == 1 then verticalVel = -boatFlyVSpeed end
        
        boatBV.Velocity = horizontalMove + Vector3.new(0, verticalVel, 0)

        local look = camera.CFrame.LookVector
        local flatLook = Vector3.new(look.X, 0, look.Z).Unit

        if horizontalMove.Magnitude > 0 then
            boatBG.CFrame = CFrame.lookAt(Vector3.zero, horizontalMove)
        else
            boatBG.CFrame = CFrame.lookAt(Vector3.zero, flatLook)
        end
    end)
end

if movement then
    local boatFlyToggle = movement:NewToggle("Boat Fly", false, function(v)
        boatFlyEnabled = v
        if v then
            task.spawn(function()
                wait(0.1)
                startBoatFly()
            end)
            if Notif then Notif:Notify("Enabled Boat Fly", 5, "success") end
        else
            stopBoatFly()
            if Notif then Notif:Notify("Disabled Boat Fly", 5, "error") end
        end
    end)
    boatFlyToggle:AddKeybind(boatFlyKey)

    local boatHSpeedSlider = movement:NewSlider("Horizontal Speed", "", false, "/", {min = 10, max = 800, default = 100}, function(v)
        boatFlyHSpeed = v
    end)

    local boatVSpeedSlider = movement:NewSlider("Vertical Speed", "", false, "/", {min = 5, max = 800, default = 100}, function(v)
        boatFlyVSpeed = v
    end)

    local boatNoclipToggle = movement:NewToggle("Boat NoClip", false, function(v)
        boatNoclipEnabled = v
    end)

    local boatFlyLabel1 = movement:NewLabel("Hold [C] to go up")
    local boatFlyLabel2 = movement:NewLabel("Hold [V] to go down")
    
    boatHSpeedSlider:Hide()
    boatVSpeedSlider:Hide()
    boatNoclipToggle:Hide()
    boatFlyLabel1:Hide()
    boatFlyLabel2:Hide()
    
    task.spawn(function()
        while task.wait() do
            if boatFlyEnabled then
                boatHSpeedSlider:Show()
                boatVSpeedSlider:Show()
                boatNoclipToggle:Show()
                boatFlyLabel1:Show()
                boatFlyLabel2:Show()
            else
                boatHSpeedSlider:Hide()
                boatVSpeedSlider:Hide()
                boatNoclipToggle:Hide()
                boatFlyLabel1:Hide()
                boatFlyLabel2:Hide()
            end
        end
    end)
end


-- // ============================================================== Player Tab ============================================================== \\ --
local player = Init:NewTab("Player")

local infEnergyEnabled = false
local energyConnection
local defaultMax, defaultMin, defaultVal = 0, 0, 0
local infEnergy = player:NewToggle("Infinite Energy", false, function(value)
    infEnergyEnabled = value
    
    local function getEnergy()
        local char = charFolder:FindFirstChild(plr.Name)
        return char and char:FindFirstChild("Energy")
    end

    if value then
        Notif:Notify("Enabled Infinite Energy", 5, "success")
        local energy = getEnergy()
        if energy and energy:IsA("IntConstrainedValue") then
            defaultVal, defaultMax, defaultMin = energy.Value, energy.MaxValue, energy.MinValue
        end

        energyConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not infEnergyEnabled then return end
            local e = getEnergy()
            if e then
                e.MaxValue = 99999999
                e.Value = 99999999
            end
        end)
    else
        Notif:Notify("Disabled Infinite Energy", 5, "error")
        if energyConnection then energyConnection:Disconnect() end
        local e = getEnergy()
        if e then
            e.MaxValue = defaultMax
            e.Value = defaultVal
        end
    end
end)

local soruEnabled = false
local soruConnection
local defaultCooldown = 0
local noSoru = player:NewToggle("No Soru Cooldown", false, function(value)
    soruEnabled = value
    
    if value then
        if character2 then
            local soru = character2:GetAttribute("FlashstepCooldown")
            if soru then
                defaultCooldown = soru
            end
        end

        Notif:Notify("Enabled No Soru Cooldown", 5, "success")
        
        soruConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not soruEnabled then 
                if soruConnection then soruConnection:Disconnect() end
                return 
            end

            if charFolder then
                local character2 = charFolder:FindFirstChild(plr.Name)
                if character2 then
                    character2:SetAttribute("FlashstepCooldown", 1)
                end
            end
        end)
    else
        if soruConnection then
            soruConnection:Disconnect()
            soruConnection = nil
        end
        
        if character2 then
            character2:SetAttribute("FlashstepCooldown", defaultCooldown)
        end
        
        Notif:Notify("Disabled No Soru Cooldown", 5, "error")
    end
end)

local originalChestSizes = {}
local increaseRangeState = false
player:NewToggle("Increase Chest Opening Range", false, function(v)
    increaseRangeState = v

    task.wait()
    if increaseRangeState then
        local mapFolder = workspace:FindFirstChild("Map")
        if mapFolder then
            for _, obj in ipairs(mapFolder:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name == "Chest1" or obj.Name == "Chest2" or obj.Name == "Chest3") then
                    if not originalChestSizes[obj] then
                        originalChestSizes[obj] = obj.Size
                    end

                    if obj.Size.X ~= 100 then
                        obj.Size = Vector3.new(100,100,100)
                    end
                end
            end
        end
    end    

    if not v then
        for chest, size in pairs(originalChestSizes) do
            if chest and chest.Parent then
                chest.Size = size
            end
        end
        table.clear(originalChestSizes)
    end
end)

local saveEnergyEnabled = false
local blockDashEnergy = false
local blockGeppoEnergy = false
local commEHook = nil
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
                if blockDashEnergy and args[2] == nil and type(args[3]) == "number" then
                    return
                end
                if blockGeppoEnergy and args[2] == "Geppo" then
                    return
                end
            end
        end
        return prev(self, ...)
    end)
    setreadonly(gg, true)
end)

local saveEnergyToggle = player:NewToggle("Save Energy", false, function(v)
    saveEnergyEnabled = v
    if v then
        Notif:Notify("Enabled Save Energy", 5, "success")
    else
        blockDashEnergy = false
        blockGeppoEnergy = false
        Notif:Notify("Disabled Save Energy", 5, "error")
    end
end)

local blockDashToggle = player:NewToggle("Stop Dash From Consuming Energy", false, function(v)
    blockDashEnergy = v
end)

local blockGeppoToggle = player:NewToggle("Stop Geppo From Consuming Energy", false, function(v)
    blockGeppoEnergy = v
end)

task.spawn(function()
    while task.wait() do
        local s = saveEnergyEnabled
        blockDashToggle[s and "Show" or "Hide"](blockDashToggle)
        blockGeppoToggle[s and "Show" or "Hide"](blockGeppoToggle)
    end
end)

local unbreakableEnabled = false
local defaultUnbreakable = nil

local unbreakableToggle = player:NewToggle("Unbreakable", false, function(v)
    unbreakableEnabled = v
    if v then
        local char2 = charFolder:FindFirstChild(plr.Name)
        if char2 then
            defaultUnbreakable = char2:GetAttribute("UnbreakableAll")
            char2:SetAttribute("UnbreakableAll", true)
        end
        Notif:Notify("Enabled Unbreakable", 5, "success")
    else
        local char2 = charFolder:FindFirstChild(plr.Name)
        if char2 then
            char2:SetAttribute("UnbreakableAll", defaultUnbreakable)
        end
        Notif:Notify("Disabled Unbreakable", 5, "error")
    end
end)

task.spawn(function()
    while task.wait() do
        if unbreakableEnabled then
            local char2 = charFolder:FindFirstChild(plr.Name)
            if char2 then
                char2:SetAttribute("UnbreakableAll", true)
            end
        end
    end
end)

-- // ============================================================== Misc Tab ============================================================== \\ --
local misc = Init:NewTab("Misc")
local shopS = misc:NewSection("Shop")

misc:NewButton("Roll Fruit", function()
    CommF:InvokeServer("Cousin", "Buy", "DLCBoxData")
end)

local serverS = misc:NewSection("Server")
misc:NewButton("Server Hop (Normal)", function()
    local servers = getServers(game.PlaceId)
    if #servers == 0 then return end

    local chosen = servers[math.random(1, #servers)]
    TeleportService:TeleportToPlaceInstance(game.PlaceId, chosen.id)
end)

misc:NewButton("Server Hop (Lowest)", function()
    local servers = getServers(game.PlaceId)
    if #servers == 0 then return end

    table.sort(servers, function(a, b)
        return a.playing < b.playing
    end)

    TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[1].id)
end)

misc:NewButton("Rejoin Server", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

-- // ============================================================== Teleport Tab ============================================================== \\ --
local teleport = Init:NewTab("Teleport")

local selectedTpBoat = nil
local boatMap = {}

local boatTpS = nil
local boatDropdown = nil
local refreshBoatBtn = nil
local teleportBoatBtn = nil

local function getBoatList()
    local list = {}
    boatMap = {}
    local boatsFolder = workspace:FindFirstChild("Boats")
    if not boatsFolder then return list end
    for _, boat in ipairs(boatsFolder:GetChildren()) do
        local ownerVal = boat:FindFirstChild("Owner")
        local owner = ownerVal and tostring(ownerVal.Value) or "Unknown"
        local label = boat.Name .. " (" .. owner .. ")"
        table.insert(list, label)
        boatMap[label] = boat
    end
    return list
end

local function getAvailableSeat(boat)
    for _, v in ipairs(boat:GetDescendants()) do
        if (v:IsA("Seat") or v:IsA("VehicleSeat")) and not v:FindFirstChild("SeatWeld") then
            return v
        end
    end
    return nil
end

local function rebuildBoatSection()
    if teleportBoatBtn then teleportBoatBtn:Remove() end
    if refreshBoatBtn then refreshBoatBtn:Remove() end
    if boatDropdown then boatDropdown:Remove() end
    if boatTpS then boatTpS:Remove() end

    boatTpS = nil
    boatDropdown = nil
    refreshBoatBtn = nil
    teleportBoatBtn = nil

    boatTpS = teleport:NewSection("Boat Teleport")

    local newList = getBoatList()

    boatDropdown = teleport:NewSelector("Select Boat", "Pick a boat", newList, function(v)
        selectedTpBoat = v
    end)

    refreshBoatBtn = teleport:NewButton("Refresh Boat List", function()
        selectedTpBoat = nil
        rebuildBoatSection()
        Notif:Notify("Boat list refreshed!", 3, "success")
    end)

    teleportBoatBtn = teleport:NewButton("Teleport Boat", function()
        if not selectedTpBoat then
            Notif:Notify("Select a boat first!", 5, "error")
            return
        end

        local boat = boatMap[selectedTpBoat]
        if not boat or not boat.Parent then
            Notif:Notify("Boat not found!", 5, "error")
            return
        end

        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if not hrp or not hum then
            Notif:Notify("Character not ready!", 5, "error")
            return
        end

        local seat = getAvailableSeat(boat)
        if not seat then
            Notif:Notify("No available seats on this boat!", 5, "error")
            return
        end

        local dist = (seat.Position - hrp.Position).Magnitude
        if dist < 1000 then
            Notif:Notify("Boat is too close! Must be 1000+ studs away.", 5, "error")
            return
        end

        hrp.CFrame = seat.CFrame
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero

        task.spawn(function()
            local attempts = 0
            repeat
                task.wait(0.1)
                attempts = attempts + 1
            until hum.SeatPart ~= nil or attempts >= 15

            if hum.SeatPart then
                Notif:Notify("Teleported to boat!", 5, "success")
            else
                Notif:Notify("Failed to sit, try again!", 5, "error")
            end
        end)
    end)
end

rebuildBoatSection()

-- // ============================================================== Utils ============================================================== \\ --
function getSpawnedChests()
    local spawnedChests = {}
    local mapFolder = workspace:FindFirstChild("Map")
    if not mapFolder then return spawnedChests end
    
    local function search(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("BasePart") and (child.Name == "Chest3" or child.Name == "Chest2" or child.Name == "Chest1") then
                local hasTouchInterest = false
                local touchInterests = child:GetChildren()
                
                for _, obj in ipairs(touchInterests) do
                    if obj:IsA("TouchTransmitter") then
                        hasTouchInterest = true
                        break
                    end
                end
                
                if hasTouchInterest then
                    local touchInterestCount = 0
                    for _, obj in ipairs(touchInterests) do
                        if obj.ClassName == "TouchInterest" or obj:IsA("TouchTransmitter") then
                            touchInterestCount = touchInterestCount + 1
                        end
                    end
                    
                    if touchInterestCount > 1 then
                        local keptOne = false
                        for _, obj in ipairs(touchInterests) do
                            if (obj.ClassName == "TouchInterest" or obj:IsA("TouchTransmitter")) and not keptOne then
                                keptOne = true
                            elseif (obj.ClassName == "TouchInterest" or obj:IsA("TouchTransmitter")) and keptOne then
                                obj:Destroy()
                            end
                        end
                    end
                    table.insert(spawnedChests, child)
                end
            end
            
            if #child:GetChildren() > 0 then
                search(child)
            end
        end
    end
    
    search(mapFolder)
    return spawnedChests
end

watchChest = function(chest)
    if chestConnection then
        chestConnection:Disconnect()
        chestConnection = nil
    end

    currentChest = chest

    chestConnection = chest.ChildRemoved:Connect(function(child)
        if child:IsA("TouchTransmitter") or child.ClassName == "TouchInterest" then
            currentChest = nil
        end
    end)
end

function setPlayerMotion(velocity)
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

function enableNoclip()
    noclipEnabled = true
    coroutine.wrap(function()
        while noclipEnabled and character do
            game:GetService("RunService").Stepped:Wait()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)()
end

local function getTargets()
    local targetList = {}
    local primaryPart = nil
    
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        local hum = mob:FindFirstChild("Humanoid")
        local root = mob:FindFirstChild("HumanoidRootPart")
        
        if hum and root and hum.Health > 0 then
            local dist = (root.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if dist < attackRange then
                table.insert(targetList, {mob, root})
                primaryPart = root
            end
        end
    end
    return primaryPart, targetList
end

getServers = function(placeId)
    local servers = {}
    local cursor = ""

    repeat
        local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"..cursor
        local success, res = pcall(function()
            return request({Url = url, Method = "GET"})
        end)

        if success and res and res.Body then
            local successDecode, data = pcall(function()
                return HttpService:JSONDecode(res.Body)
            end)

            if successDecode and data and data.data then
                for _, server in ipairs(data.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server)
                    end
                end

                cursor = data.nextPageCursor and ("&cursor=" .. data.nextPageCursor) or nil
            else
                warn("Failed to decode server data or invalid response structure.")
                break
            end
        else
            warn("Failed to fetch server data from URL: " .. url)
            break
        end

        task.wait()
    until not cursor

    if #servers == 0 then
        warn("No servers found for placeId: " .. placeId)
    end

    return servers
end

plr.CharacterAdded:Connect(function(newChar)
    character = newChar
    task.wait()
    character2 = charFolder:FindFirstChild(plr.Name)
end)

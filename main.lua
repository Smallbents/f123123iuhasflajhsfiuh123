local Services = setmetatable({},{
	__index=function(self,Name)
		local Service = game:GetService(Name)
		rawset(self,Name,Service)
		return Service
	end,
})
Services.ReplicatedStorage.Remotes.Functions:InvokeServer({ getrenv()._G.Pass, "ChangeSetting", "MorphEnabled", true });
local Players = Services.Players
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui; PlayerGui.CharacterSelection.Character.Value = "Chara"; wait(1)
local Character = Player.Character or Player.CharacterAdded:Wait(); Character.Head:WaitForChild("HealthBar"):Destroy()
local Humanoid = Character.Humanoid
local Uis = Services.UserInputService
local Remotes = Services.ReplicatedStorage.Remotes
local Backpack = Player:WaitForChild("Backpack")
local Main = Backpack:WaitForChild("Main")
local CharaMoves = Main:WaitForChild("CharaMoves")
local ClickAnimations = CharaMoves:WaitForChild("ModuleScript"):WaitForChild("Animations").BladesCombat
local Knife = Character:WaitForChild("RealKnife")
local HateArm = Character:WaitForChild("HateArm")
local HeartLocket = Character:WaitForChild("HeartLocket")
local FullHateMode = Character:WaitForChild("FullHateMode")
local HateMode = Character:WaitForChild("HateMode")
local Karma = Character:WaitForChild("Karma")
local GameMetatable = getrawmetatable(game)
local NameCallMethod = GameMetatable.__namecall
local Pass = getrenv()._G.Pass
local waitBool = true
local RunspeedBypass = Instance.new("BoolValue")
local Face = Character.Head:FindFirstChild("face")
local animtracks = Humanoid:GetPlayingAnimationTracks()

local Settings = {
    Name = " [idk] ",
}

local CCS = {
    HitTime = 1,
    HitEffect = "HeavyHitEffect",
    Damage = 10, -- max 40 For knockback, max 10 for normal hits
    Type = "Normal", -- Can only be Knockback or Normal
    Velocity = 15,
    Sound = Services.ReplicatedStorage.Sounds["Punch2"],
    HurtAnimation = Services.ReplicatedStorage.Animations.HurtAnimations["Stunned"],
    HitTimeFin = 1,
    HitEffectFin = "HeavyHitEffect",
    DamageFin = 40, -- max 40 For knockback, max 10 for normal hits
    TypeFin = "Knockback", -- Can only be Knockback or Normal
    VelocityFin = 60,
    SoundFin = Services.ReplicatedStorage.Sounds["Punch2"],
    HurtAnimationFin = Services.ReplicatedStorage.Animations.HurtAnimations["Stunned"]
}; _G.ClickComboSettings = CCS

local Anims = {
    Hit1 = "5776230796",
    Hit2 = "5776233108",
    Hit3 = "5776230796",
    Hit4 = "5776233108",
    Hit5 = "5776230796",
    Hit6 = "5776243290",
    Idle = "8193912867",
    Run = "6998116360",
    Walk = "6373899601",
    Jump = "8100288787",
    Block = "7817084729",
} _G.AnimSettings = Anims

if Face then Face:remove()end
Services.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:Destroy()
Services.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
HateArm:Destroy();HeartLocket:Destroy();Knife:Destroy();FullHateMode:Destroy();HateMode:Destroy();Karma:Destroy();Character:WaitForChild("ForceField"):Destroy();game.Workspace.ServerEffects.ServerCooldown:Destroy()
CharaMoves:WaitForChild("Animations"):WaitForChild("Idle").AnimationId = "rbxassetid://"..Anims.Idle
CharaMoves:WaitForChild("Animations"):WaitForChild("Run").AnimationId = "rbxassetid://"..Anims.Run
CharaMoves:WaitForChild("Animations"):WaitForChild("Walk").AnimationId = "rbxassetid://"..Anims.Walk
CharaMoves:WaitForChild("Animations"):WaitForChild("Jump").AnimationId = "rbxassetid://"..Anims.Jump
CharaMoves:WaitForChild("Animations"):WaitForChild("Block").AnimationId = "rbxassetid://"..Anims.Block
-- BackPack Duplication
wait(2)
local module
local modulelocation
original = Main
clone = Main:Clone()
for _,v in pairs(original:GetDescendants()) do if v.Name == 'ModuleScript' then module = v modulelocation = v.Parent.Name end end
for _,v in pairs(clone:GetDescendants()) do if v.Name == 'ModuleScript' then v:Destroy() end end
for _,v in pairs(clone:GetDescendants()) do if v.Name == modulelocation then module.Parent = v end end
for _,v in pairs(PlayerGui.UI.Ui:GetChildren()) do er = string.lower(v.Name) if string.match(er,'move') then originalm = v clonem = v:Clone() end end
for _,v in pairs(PlayerGui:GetChildren()) do er = string.lower(v.Name) if string.find(er,'indicator') then clonem1 = v:Clone() originalm1 = v end end
for _,v in pairs(clone:GetDescendants()) do if v.Name == 'Extra' then eg = v end end
clonem1.Parent = eg
clonem.Parent = eg
originalm:Destroy()
originalm1:Destroy()
clone.Parent = Backpack
wait()
original:Destroy()
-- GodMode Shit
local v1 = {[1] = getrenv()._G.Pass,[2] = "Damage",[3] = math.huge,[4] = Character}
Remotes.Events:FireServer(v1)
Humanoid:GetPropertyChangedSignal("Health"):Connect(function() if Humanoid.Health == 0 then Humanoid.Health = 1 end end)
RunspeedBypass.Name = "Battling";RunspeedBypass.Parent = Character;wait(0.3);Backpack.Main.RunSpeed.Value = 100
RunspeedBypass.Name = "Battling";RunspeedBypass.Parent = Character;wait(0.3);Backpack.Main.WalkSpeed.Value = 10
Character.Head.Voice.SoundId = "rbxassetid://7006511900" -- Sound of your typwriter effect text [Doesn't replicate]
ClickAnimations.Light1.AnimationId = "rbxassetid://"..Anims.Hit1
ClickAnimations.Light2.AnimationId = "rbxassetid://"..Anims.Hit2
ClickAnimations.Light3.AnimationId = "rbxassetid://"..Anims.Hit3
ClickAnimations.Light4.AnimationId = "rbxassetid://"..Anims.Hit4
ClickAnimations.Light5.AnimationId = "rbxassetid://"..Anims.Hit5
ClickAnimations.Light6.AnimationId = "rbxassetid://"..Anims.Hit6

function Chatfunc(Message, Color)
    local ChatTable = {[1] = {[1] = Pass,[2] = "Chatted",[3] = Message,[4] = Color3.new(Color[1],Color[2],Color[3])}}
    Remotes.Events:FireServer(unpack(ChatTable))
end

function DamageEvent(table)
    local OldDamage = CCS.Damage
    local OldType = CCS.Type
    local OldVelocity = CCS.Velocity
    local OldHitEffect = CCS.HitEffect
    local OldHurtAnimation = CCS.HurtAnimation
    local OldSound = CCS.Sound
    CCS.Damage = table[1]
    CCS.Type = table[2]
    CCS.Velocity = table[3]
    CCS.HitEffect = table[4]
    CCS.Sound = Services.ReplicatedStorage.Sounds[table[5]]
    CCS.HurtAnimation = Services.ReplicatedStorage.Animations.HurtAnimations[table[6]]
    local args = {
        [1] = Pass,
            [2] = Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["HitTime"] = 1, 
                ["Type"] = "Knockback",
                ["HitEffect"] = "KnifeHitEffect", 
                ["CombatInv"] = true,
                ["HurtAnimation"] = Services.ReplicatedStorage.Animations.HurtAnimations["Stunned"], 
                ["Sound"] = Services.ReplicatedStorage.Sounds["ShieldBreak"],
                ["Damage"] = 10
            }
        }
    pcall(function()
        Remotes.Damage:InvokeServer(unpack(args))
    end)
    CCS.Damage = OldDamage
    CCS.Type = OldType
    CCS.Velocity = OldVelocity
    CCS.HitEffect = OldHitEffect
    CCS.Sound = OldSound
    CCS.HurtAnimation = OldHurtAnimation
end

function LoadAttackAnim(id, speed)
    local AnimInstance = Instance.new("Animation", Humanoid)
    AnimInstance.AnimationId = "rbxassetid://"..tostring(id)
    local LoadAnim = Humanoid:LoadAnimation(AnimInstance)
    LoadAnim:Play()
    LoadAnim:AdjustSpeed(speed)
    return {AnimInstance, LoadAnim}
end
function StopAnim(loadanim)
    loadanim:Stop()
end
function DestroyAnim(animinstance)
    animinstance:Destroy()
end

--spawn(function()repeat wait()for _,v in pairs(Character:GetChildren()) do if v.Name == 'DrainStamina' or v.Name == 'DrainSprint' or v.Name == 'Hit' or v.Name == 'Hitt' or v.Name == 'Damaged' or v.Name == 'Grounded' or v.Name == 'StayGrounded' or v.Name == 'KnockBack' or v.Name == 'Walled' then v:Destroy() end end until false end)
--spawn(function()repeat wait()for _,v in pairs(Character:GetChildren()) do if v.Name == 'DrainStamina' or v.Name == 'DrainSprint' or v.Name == 'Hit' or v.Name == 'Hitt' or v.Name == 'Damaged' or v.Name == 'Grounded' or v.Name == 'StayGrounded' or v.Name == 'KnockBack' or v.Name == 'Walled' then v:Destroy() end end until false end)
--spawn(function()repeat wait()for _,v in pairs(Character:GetChildren()) do if v.Name == 'DrainStamina' or v.Name == 'DrainSprint' or v.Name == 'Hit' or v.Name == 'Hitt' or v.Name == 'Damaged' or v.Name == 'Grounded' or v.Name == 'StayGrounded' or v.Name == 'KnockBack' or v.Name == 'Walled' then v:Destroy() end end until false end)
--spawn(function()repeat wait()for _,v in pairs(Character:GetChildren()) do if v.Name == 'DrainStamina' or v.Name == 'DrainSprint' or v.Name == 'Hit' or v.Name == 'Hitt' or v.Name == 'Damaged' or v.Name == 'Grounded' or v.Name == 'StayGrounded' or v.Name == 'KnockBack' or v.Name == 'Walled' then v:Destroy() end end until false end)

setreadonly(GameMetatable, false)
GameMetatable.__namecall =
    newcclosure(
    function(name, ...)
        local tabs = {...}
        if getnamecallmethod() == "InvokeServer" and tostring(name) == "Damage" then
            tabs[3]["HitTime"] = CCS.HitTime
            tabs[3]["HitEffect"] = CCS.HitEffect
            tabs[3]["Damage"] = CCS.Damage
            tabs[3]["Type"] = CCS.Type
            tabs[3]["HurtAnimation"] = CCS.HurtAnimation
            tabs[3]["Sound"] = CCS.Sound
            tabs[3]["Velocity"] = Character.HumanoidRootPart.CFrame.LookVector * CCS.Velocity
        end
        return NameCallMethod(name, unpack(tabs))
    end)
setreadonly(GameMetatable, true)
FinBool = true
spawn(function()
    repeat
        wait()
        if FinBool then
            local animtracks = Humanoid:GetPlayingAnimationTracks()
            for i,v in pairs(animtracks) do
                if v.Name == "Light6" then
                    FinBool = false
                    local OldDamage = CCS.Damage
                    local OldType = CCS.Type
                    local OldVelocity = CCS.Velocity
                    local OldHitEffect = CCS.HitEffect
                    local OldHurtAnimation = CCS.HurtAnimation
                    local OldSound = CCS.Sound
                    CCS.Damage = CCS.DamageFin
                    CCS.Type = CCS.TypeFin
                    CCS.Velocity = CCS.VelocityFin
                    CCS.HitEffect = CCS.HitEffectFin
                    CCS.Sound = CCS.SoundFin
                    CCS.HurtAnimation = CCS.HurtAnimationFin
                    wait(2)
                    CCS.Damage = OldDamage
                    CCS.Type = OldType
                    CCS.Velocity = OldVelocity
                    CCS.HitEffect = OldHitEffect
                    CCS.Sound = OldSound
                    CCS.HurtAnimation = OldHurtAnimation
                    FinBool = true
                end
            end
        end
    until false
end)


--[[
C: Barrage
V: Thwack
X: Uppercut
B: TestAnim
T: Trolled
f5: Rejoin
R: Teleport
]]

TestAnim = {
    TestingAnimation = 3722535516,
    Speed = 1
}_G.TestAnim = TestAnim

local Damages = {
    Thwack = {
        40, -- Damage [Max 40 on Type: Knockback, Max 10 on Type: Normal]
        "Knockback", -- Attack Type [Knockback, Normal]
        40, -- Velocity [Max 200]
        "HeavyHitEffect", --w HitEffect
        "BassDrop", -- HitSound
        "KnockUp" -- HurtAnimation
    },
    Uppercut = {
        40, -- Damage [Max 40 on Type: Knockback, Max 10 on Type: Normal]
        "Knockback", -- Attack Type [Knockback, Normal]
        70, -- Velocity [Max 200]
        "HeavyHitEffect", -- HitEffect
        "ShieldBreak", -- HitSound
        "KnockUp" -- HurtAnimation
    },
    Barrage = {
        10, -- Damage [Max 40 on Type: Knockback, Max 10 on Type: Normal]
        "Normal", -- Attack Type [Knockback, Normal]
        1, -- Velocity [Max 200]
        "BoneHitEffect", -- HitEffect
        "Punch2", -- HitSound
        "Stunned" -- HurtAnimation
    },
    BarrageFin = {
        40, -- Damage [Max 40 on Type: Knockback, Max 10 on Type: Normal]
        "Knockback", -- Attack Type [Knockback, Normal]
        100, -- Velocity [Max 200]
        "HeavyHitEffect", -- HitEffect
        "HateExplosion", -- HitSound
        "Hurt"..tostring(math.random(1,3)) -- HurtAnimation
    },
} _G.AttackSettings = Damages
local dead = false
Uis.InputBegan:Connect(function(Input)
  if Input.UserInputType ~= Enum.UserInputType.Keyboard then return end
  if Uis:GetFocusedTextBox() then return end
  key = Input.KeyCode
  if waitBool == true then
        if key == Enum.KeyCode.C then -- Barrage
            waitBool = false
            local anim = LoadAttackAnim(7019288804, 0.5)
            wait(0.5)
            for i=1,17 do
                DamageEvent(Damages.Barrage)
            end
            wait(1.2)
            DamageEvent(Damages.BarrageFin)
            wait(2)
            DestroyAnim(anim[1])
            waitBool = true
        end
        if key == Enum.KeyCode.V then -- Thwack
            waitBool = false
            Chatfunc("THWACK",{1,0,0})
            local anim = LoadAttackAnim(9073577387, 1.5)
            DamageEvent(Damages.Thwack)
            DestroyAnim(anim[1])
            waitBool = true
        end
        if key == Enum.KeyCode.X then -- Uppercut
            waitBool = false
            Chatfunc("UPPERCUT",{1,0,0})
            local anim = LoadAttackAnim(9553554972, 1)
            DamageEvent(Damages.Uppercut)
            wait(1)
            DestroyAnim(anim[1])
            waitBool = true
        end
        if key == Enum.KeyCode.B then -- TestAnim
            waitBool = false
            local anim = LoadAttackAnim(tostring(_G.TestAnim.TestingAnimation), tonumber(_G.TestAnim.Speed))
            wait(5)
            StopAnim(anim[2])
            DestroyAnim(anim[1])
            waitBool = true
        end
        if key == Enum.KeyCode.G then -- dead moment
        		coroutine.wrap(function()
local anim = LoadAttackAnim(5776384951,1)

Character.HumanoidRootPart.Anchored = true
          dead = true
 Chatfunc("bruh I'm Dead 💀",{1,1,1}) 
repeat wait() until key == Enum.KeyCode.G
          Character.HumanoidRootPart.Anchored = false  
          StopAnim(anim[2])
            DestroyAnim(anim[1])
          end
        end)
        end
        end
        if key == Enum.KeyCode.T then -- Trolled
            waitBool = false
            Chatfunc("Trolled!",{1,1,1})
            local anim = LoadAttackAnim(7813916666, 1.25)
            waitBool = true
        end
        if key == Enum.KeyCode.F5 then -- Rejoin
            local teleportToPlace = Services.TeleportService
            teleportToPlace:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)   
        end
        if key == Enum.KeyCode.R then -- Teleport
            if Backpack:WaitForChild("Main").LockOnScript.LockOn.Value == nil then
                local Mouse = Player:GetMouse()
                local cfr = Mouse.Hit
                Character:SetPrimaryPartCFrame(cfr * CFrame.new(0, 2, 0))
            else
                local Tcf = Backpack:WaitForChild("Main").LockOnScript.LockOn.Value:GetPrimaryPartCFrame()
                Character:SetPrimaryPartCFrame(Tcf * CFrame.new(0, 0, -3))
            end
        end
    end
end)

local Services = setmetatable({},{
	__index=function(self,Name)
		local Service = game:GetService(Name)
		rawset(self,Name,Service)
		return Service
	end,
})

local Players = Services.Players
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui; PlayerGui.CharacterSelection.Character.Value = "Chara"; wait(1)
local Character = Player.Character or Player.CharacterAdded:Wait(); Character.Head:WaitForChild("HealthBar"):Destroy()
local Humanoid = Character.Humanoid
local Uis = Services.UserInputService
local Remotes = Services.ReplicatedStorage.Remotes
local Backpack = Player:WaitForChild("Backpack")
local ClickAnimations = Backpack:WaitForChild("Main"):WaitForChild("CharaMoves"):WaitForChild("ModuleScript"):WaitForChild("Animations").BladesCombat
local Knife = Character:WaitForChild("RealKnife")
local HateArm = Character:WaitForChild("HateArm")
local HeartLocket = Character:WaitForChild("HeartLocket")
local FullHateMode = Character:WaitForChild("FullHateMode")
local HateMode = Character:WaitForChild("HateMode")
local Karma = Character:WaitForChild("Karma")
local GameMetatable = getrawmetatable(game)
local NameCallMethod = GameMetatable.__namecall
local Pass = getrenv()._G.Pass
local Mouse = Player:GetMouse()
local waitBool = true
local RunspeedBypass = Instance.new("BoolValue")
local Face = Character.Head:FindFirstChild("face")

local CCS = {
    HitTime = 1,
    HitEffect = "HeavyHitEffect",
    Damage = 10, -- max 40 For knockback, max 10 for normal hits
    Type = "Normal", -- Can only be Knockback or Normal
    Velocity = 15,
    Sound = Services.ReplicatedStorage.Sounds["Punch2"],
    HurtAnimation = Services.ReplicatedStorage.Animations.HurtAnimations["Stunned"]
}; _G.ClickComboSettings = CCS

local Damages = {
    Uppercut = {40,"Knockback",70,"HeavyHitEffect", "ShieldBreak", "KnockUp"},
    Barrage = {10,"Normal",1,"BoneHitEffect","Punch2","Stunned"},
    BarrageFin = {40,"Knockback",100,"HeavyHitEffect","HateExplosion","Hurt"..tostring(math.random(1,3))},
} _G.AttackSettings = Damages

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
    Block = "7813916666",
} _G.AnimSettings = Anims
if Face then
    Face:remove()
end
Services.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:Destroy()
Services.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
HateArm:Destroy();HeartLocket:Destroy();Knife:Destroy();FullHateMode:Destroy();HateMode:Destroy();Karma:Destroy();Character:WaitForChild("ForceField"):Destroy();game.Workspace.ServerEffects.ServerCooldown:Destroy()
Backpack:WaitForChild("Main").CharaMoves.Animations.Idle.AnimationId = "rbxassetid://"..Anims.Idle
Backpack:WaitForChild("Main").CharaMoves.Animations.Run.AnimationId = "rbxassetid://"..Anims.Run
Backpack:WaitForChild("Main").CharaMoves.Animations.Walk.AnimationId = "rbxassetid://"..Anims.Walk
Backpack:WaitForChild("Main").CharaMoves.Animations.Jump.AnimationId = "rbxassetid://"..Anims.Jump
Backpack:WaitForChild("Main").CharaMoves.Animations.Block.AnimationId = "rbxassetid://"..Anims.Block
wait(1)
-- BackPack Duplication
local module
local modulelocation
original = Backpack:WaitForChild("Main")
clone = Backpack:WaitForChild("Main"):Clone()
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
-- USE THIS: Chatfunc("gaming",{1,0,0})

function DamageEvent(damagestable)
    local OldDamage = CCS.Damage
    local OldType = CCS.Type
    local OldVelocity = CCS.Velocity
    local OldHitEffect = CCS.HitEffect
    local OldHurtAnimation = CCS.HurtAnimation
    local OldSound = CCS.Sound
    CCS.Damage = Damages.damagestable[1]
    CCS.Type = Damages.damagestable[2]
    CCS.Velocity = Damages.damagestable[3]
    CCS.HitEffect = Damages.damagestable[4]
    CCS.Sound = Services.ReplicatedStorage.Sounds[Damages.damagestable[5]]
    CCS.HurtAnimation = Services.ReplicatedStorage.Animations.HurtAnimations[Damages.damagestable[6]]
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
    AnimInstance:Destroy()
end


spawn(function()repeat wait()for _,v in pairs(Character:GetChildren()) do if v.Name == 'DrainStamina' or v.Name == 'DrainSprint' or v.Name == 'Hit' or v.Name == 'Hitt' or v.Name == 'Damaged' or v.Name == 'Grounded' or v.Name == 'StayGrounded' or v.Name == 'KnockBack' or v.Name == 'Walled' then v:Destroy() end end until false end)
spawn(function()repeat wait()for _,v in pairs(Character:GetChildren()) do if v.Name == 'DrainStamina' or v.Name == 'DrainSprint' or v.Name == 'Hit' or v.Name == 'Hitt' or v.Name == 'Damaged' or v.Name == 'Grounded' or v.Name == 'StayGrounded' or v.Name == 'KnockBack' or v.Name == 'Walled' then v:Destroy() end end until false end)
spawn(function()repeat wait()for _,v in pairs(Character:GetChildren()) do if v.Name == 'DrainStamina' or v.Name == 'DrainSprint' or v.Name == 'Hit' or v.Name == 'Hitt' or v.Name == 'Damaged' or v.Name == 'Grounded' or v.Name == 'StayGrounded' or v.Name == 'KnockBack' or v.Name == 'Walled' then v:Destroy() end end until false end)
spawn(function()repeat wait()for _,v in pairs(Character:GetChildren()) do if v.Name == 'DrainStamina' or v.Name == 'DrainSprint' or v.Name == 'Hit' or v.Name == 'Hitt' or v.Name == 'Damaged' or v.Name == 'Grounded' or v.Name == 'StayGrounded' or v.Name == 'KnockBack' or v.Name == 'Walled' then v:Destroy() end end until false end)

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

TestAnim = {
    TestingAnimation = "3722535516",
    Speed = 1
}_G.TestAnim = TestAnim



Mouse.KeyDown:Connect(function(key)
    if waitBool == true then
        if key == "c" then
            waitBool = false
            local AnimInstance = Instance.new("Animation", Humanoid)
            AnimInstance.AnimationId = "rbxassetid://7019288804"
            local LoadAnim = Humanoid:LoadAnimation(AnimInstance)
            LoadAnim:Play()
            LoadAnim:AdjustSpeed(0.5)
            local OldDamage = CCS.Damage
            local OldType = CCS.Type
            local OldVelocity = CCS.Velocity
            local OldHitEffect = CCS.HitEffect
            CCS.Damage = Damages.Barrage[1]
            CCS.Type = Damages.Barrage[2]
            CCS.Velocity = Damages.Barrage[3]
            CCS.HitEffect = Damages.Barrage[4]
            local Barrage = {
                [1] = Pass,
                [2] = Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 1, 
                    ["Type"] = "Knockback",
                    ["HitEffect"] = "KnifeHitEffect", 
                    ["CombatInv"] = true,
                    ["HurtAnimation"] = Services.ReplicatedStorage.Animations.HurtAnimations[Damages.Barrage[6]], 
                    ["Sound"] = Services.ReplicatedStorage.Sounds[Damages.Barrage[5]],
                    ["Damage"] = 10
                }
            }
            local BarrageFin = {
                [1] = Pass,
                [2] = Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 1, 
                    ["Type"] = "Knockback",
                    ["HitEffect"] = "KnifeHitEffect", 
                    ["CombatInv"] = true,
                    ["HurtAnimation"] = Services.ReplicatedStorage.Animations.HurtAnimations[Damages.BarrageFin[6]], 
                    ["Sound"] = Services.ReplicatedStorage.Sounds[Damages.BarrageFin[5]],
                    ["Damage"] = 10
                }
            }
            pcall(function()
                wait(0.5)
                for i=1,17 do
                    Remotes.Damage:InvokeServer(unpack(Barrage))
                end
                CCS.Damage = Damages.BarrageFin[1]
                CCS.Type = Damages.BarrageFin[2]
                CCS.Velocity = Damages.BarrageFin[3]
                CCS.HitEffect = Damages.BarrageFin[4]
                wait(1.2)
                Remotes.Damage:InvokeServer(unpack(BarrageFin))
            end)
            CCS.Damage = OldDamage
            CCS.Type = OldType
            CCS.Velocity = OldVelocity
            CCS.HitEffect = OldHitEffect
            wait(2)
            AnimInstance:Destroy()
            waitBool = true
        end
        if key == "v" then
            waitBool = false
            Chatfunc("THWACK",{1,0,0})
            LoadAttackAnim(9073577387, 1.5)
            _G.Damages.Thwack = {
                40, -- Damage [Max 40 on Type: Knockback, Max 10 on Type: Normal]
                "Knockback", -- Attack Type [Knockback, Normal]
                40, -- Velocity [Max 200]
                "HeavyHitEffect", -- HitEffect
                "ShieldBreak", -- HitSound
                "KnockUp" -- HurtAnimation
            }
            DamageEvent(Damages.Thwack)
            waitBool = true
        end
        if key == "x" then
            waitBool = false
            Chatfunc("UPPERCUT",{1,0,0})
            local AnimInstance = Instance.new("Animation", Humanoid)
            AnimInstance.AnimationId = "rbxassetid://9553554972"
            local LoadAnim = Humanoid:LoadAnimation(AnimInstance)
            LoadAnim:Play()
            LoadAnim:AdjustSpeed(1)
            local OldDamage = CCS.Damage
            local OldType = CCS.Type
            local OldVelocity = CCS.Velocity
            local OldHitEffect = CCS.HitEffect
            CCS.Damage = Damages.Uppercut[1]
            CCS.Type = Damages.Uppercut[2]
            CCS.Velocity = Damages.Uppercut[3]
            CCS.HitEffect = Damages.Uppercut[4]
            local args = {
                [1] = Pass,
                [2] = Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 1, 
                    ["Type"] = "Knockback",
                    ["HitEffect"] = "KnifeHitEffect", 
                    ["CombatInv"] = true,
                    ["HurtAnimation"] = Services.ReplicatedStorage.Animations.HurtAnimations[Damages.Uppercut[6]], 
                    ["Sound"] = Services.ReplicatedStorage.Sounds[Damages.Uppercut[5]],
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
            wait(1)
            AnimInstance:Destroy()
            waitBool = true
        end
        if key == "b" then
            waitBool = false
            local AnimInstance = Instance.new("Animation", Humanoid)

        AnimInstance.AnimationId = "rbxassetid://"..TestAnim.TestingAnimation
            local LoadAnim = Humanoid:LoadAnimation(AnimInstance)
            LoadAnim:Play()
            LoadAnim:AdjustSpeed(TestAnim.Speed)
            wait(5)
            LoadAnim:Stop()
            AnimInstance:Destroy()
            waitBool = true
        end
        if key == "t" then
            waitBool = false
            Chatfunc("Trolled!",{1,1,1})
            local AnimInstance = Instance.new("Animation", Humanoid)
            AnimInstance.AnimationId = "rbxassetid://7813916666"
            local LoadAnim = Humanoid:LoadAnimation(AnimInstance)
            LoadAnim:Play()
           LoadAnim:AdjustSpeed(1.25)
            waitBool = true
        end
        if key == "p" then
            local teleportToPlace = Services.TeleportService
		        teleportToPlace:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)   
        end
        if key == "r" then
            if Backpack:WaitForChild("Main").LockOnScript.LockOn.Value == nil then
                local cfr = Mouse.Hit
                Character:SetPrimaryPartCFrame(cfr * CFrame.new(0, 2, 0))
            else
                local Tcf = Backpack:WaitForChild("Main").LockOnScript.LockOn.Value:GetPrimaryPartCFrame()
                Character:SetPrimaryPartCFrame(Tcf * CFrame.new(0, 0, -3))
            end
        end
    end
end)
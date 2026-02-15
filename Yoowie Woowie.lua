-- YOOWIE WOOWIE

Player = game:GetService("Players").LocalPlayer
Character = Player.Character
hum = Character.Humanoid
LeftArm = Character["Left Arm"]
LeftLeg = Character["Left Leg"]
RightArm = Character["Right Arm"]
RightLeg = Character["Right Leg"]
Root = Character["HumanoidRootPart"]
Head = Character["Head"]
Torso = Character["Torso"]
Neck = Torso["Neck"]
mouse = Player:GetMouse()
walking = false
jumping = false
attacking = false
firsttime = false
tauntdebounce = false
position = nil
MseGuide = true
running = false
settime = 0
sine = 0
t = 0
ws = 14
jp = 88
hum.UseJumpPower = true
hum.JumpPower = jp
change = 1
combo1 = true
dancing = false
equip = false
dgs = 75
combo2 = false
switch1 = true
switch2 = false
firsttime2 = false
combo3 = false
gunallowance = false
shooting = true
RunSrv = game:GetService("RunService")
RenderStepped = game:GetService("RunService").RenderStepped
removeuseless = game:GetService("Debris")
running = false
position = position or "Idle"

screenGui = Instance.new("ScreenGui")
screenGui.Parent = script.Parent

local HEADLERP = Instance.new("ManualWeld")
HEADLERP.Parent = Head
HEADLERP.Part0 = Head
HEADLERP.Part1 = Head
HEADLERP.C0 = CFrame.new(0, -1.5, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local TORSOLERP = Instance.new("ManualWeld")
TORSOLERP.Parent = Root
TORSOLERP.Part0 = Torso
TORSOLERP.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local ROOTLERP = Instance.new("ManualWeld")
ROOTLERP.Parent = Root
ROOTLERP.Part0 = Root
ROOTLERP.Part1 = Torso
ROOTLERP.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local RIGHTARMLERP = Instance.new("ManualWeld")
RIGHTARMLERP.Parent = RightArm
RIGHTARMLERP.Part0 = RightArm
RIGHTARMLERP.Part1 = Torso
RIGHTARMLERP.C0 = CFrame.new(-1.5, 0, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local LEFTARMLERP = Instance.new("ManualWeld")
LEFTARMLERP.Parent = LeftArm
LEFTARMLERP.Part0 = LeftArm
LEFTARMLERP.Part1 = Torso
LEFTARMLERP.C0 = CFrame.new(1.5, 0, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local RIGHTLEGLERP = Instance.new("ManualWeld")
RIGHTLEGLERP.Parent = RightLeg
RIGHTLEGLERP.Part0 = RightLeg
RIGHTLEGLERP.Part1 = Torso
RIGHTLEGLERP.C0 = CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local LEFTLEGLERP = Instance.new("ManualWeld")
LEFTLEGLERP.Parent = LeftLeg
LEFTLEGLERP.Part0 = LeftLeg
LEFTLEGLERP.Part1 = Torso
LEFTLEGLERP.C0 = CFrame.new(0.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local function weldBetween(a, b)
	local weld = Instance.new("ManualWeld", a)
	weld.Part0 = a
	weld.Part1 = b
	weld.C0 = a.CFrame:inverse() * b.CFrame
	return weld
end

function MAKETRAIL(PARENT,POSITION1,POSITION2,LIFETIME,COLOR)
	A = Instance.new("Attachment", PARENT)
	A.Position = POSITION1
	A.Name = "A"
	B = Instance.new("Attachment", PARENT)
	B.Position = POSITION2
	B.Name = "B"
	tr1 = Instance.new("Trail", PARENT)
	tr1.Attachment0 = A
	tr1.Attachment1 = B
	tr1.Enabled = true
	tr1.Lifetime = LIFETIME
	tr1.TextureMode = "Static"
	tr1.LightInfluence = 0
	tr1.Color = COLOR
	tr1.Transparency = NumberSequence.new(0, 1)
end

coroutine.wrap(function()
	while wait() do
		hum.WalkSpeed = ws
	end
end)()
godmode = coroutine.wrap(function()
	for i,v in pairs(Character:GetChildren()) do
		if v:IsA("BasePart") and v ~= Root then
			v.Anchored = false
		end
	end
end)
godmode()

coroutine.wrap(function()
	for i,v in pairs(Character:GetChildren()) do
		if v.Name == "Animate" then v:Remove()
		end
	end
end)()

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"
script:WaitForChild("Heartbeat")

frame = 1 / 60
tf = 0
allowframeloss = false
tossremainder = false


lastframe = tick()
script.Heartbeat:Fire()


game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.Heartbeat:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.Heartbeat:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)

function swait(num)
	if num == 0 or num == nil then
		game:service("RunService").Stepped:wait(0)
	else
		for i = 0, num do
			game:service("RunService").Stepped:wait(0)
		end
	end
end

function SOUND(PARENT,ID,VOL,LOOP,REMOVE)
	so = Instance.new("Sound")
	so.Parent = PARENT
	so.SoundId = "rbxassetid://"..ID
	so.Volume = VOL
	so.Looped = LOOP

	so:Play()
	removeuseless:AddItem(so,REMOVE)
end

goldpart = Instance.new("Part",RightArm)
--goldpart.Size = Vector3.new(1.01,2.01,1.01)
--goldpart.BrickColor = BrickColor.new("Gold")
--goldpart.Material = "Neon"
--goldpart.CanCollide = false
--goldpart.Anchored = false
--goldpartweld = weldBetween(goldpart,RightArm)

goldpart2 = Instance.new("Part",RightLeg)
--goldpart2.Size = Vector3.new(1.01,2.01,1.01)
--goldpart2.BrickColor = BrickColor.new("Gold")
--goldpart2.Material = "Neon"
--goldpart2.CanCollide = false
--goldpart2.Anchored = false
--goldpartweld2 = weldBetween(goldpart2,RightLeg)

goldpart3 = Instance.new("Part",LeftLeg)
--goldpart3.Size = Vector3.new(1.01,2.01,1.01)
--goldpart3.BrickColor = BrickColor.new("Gold")
--goldpart3.Material = "Neon"
--goldpart3.CanCollide = false
--goldpart3.Anchored = false
--goldpartweld3 = weldBetween(goldpart3,LeftLeg)

goldpart4 = Instance.new("Part",LeftArm)
--goldpart4.Size = Vector3.new(1.01,2.01,1.01)
--goldpart4.BrickColor = BrickColor.new("Gold")
--goldpart4.Material = "Neon"
--goldpart4.CanCollide = false
--goldpart4.Anchored = false
--goldpartweld4 = weldBetween(goldpart4,LeftArm)

goldpart5 = Instance.new("Part",Torso)
--goldpart5.Size = Vector3.new(2.01,2.01,1.01)
--goldpart5.BrickColor = BrickColor.new("Gold")
--goldpart5.Material = "Neon"
--goldpart5.CanCollide = false
--goldpart5.Anchored = false
--goldpartweld5 = weldBetween(goldpart5,Torso)


Root.CFrame = Root.CFrame * CFrame.new(0,15,0)
hum.HipHeight = 10
spinny = 0
for i = 1, 400 do
spinny = spinny + 4
ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0+spinny),0),.4)
hum.HipHeight = hum.HipHeight - .025
swait()
end
for i = 1, 50 do
RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.3,1.05 + .15 * math.sin(sine/12),.2) * CFrame.Angles(math.rad(0),math.rad(12),math.rad(-40 - 6 * math.sin(sine/12))),.2)
LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.3,1.05 + .15 * math.sin(sine/12),.2) * CFrame.Angles(0,math.rad(-12),math.rad(40 + 6 * math.sin(sine/12))),.2)
ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.4)
swait()
end
for i = 1, 50 do
coroutine.wrap(function()
goldpart.Anchored = true
goldpart.Size = goldpart.Size + Vector3.new(.5,.5,.5)
goldpart.Transparency = goldpart.Transparency + .05
goldpart2.Anchored = true
goldpart2.Size = goldpart2.Size + Vector3.new(.5,.5,.5)
goldpart2.Transparency = goldpart2.Transparency + .05
goldpart3.Anchored = true
goldpart3.Size = goldpart3.Size + Vector3.new(.5,.5,.5)
goldpart3.Transparency = goldpart3.Transparency + .035
goldpart4.Anchored = true
goldpart4.Size = goldpart4.Size + Vector3.new(.5,.5,.5)
goldpart4.Transparency = goldpart4.Transparency + .05
goldpart5.Anchored = true
goldpart5.Size = goldpart5.Size + Vector3.new(.5,.5,.5)
goldpart5.Transparency = goldpart5.Transparency + .05
end)()
RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.3,1.05 + .15 * math.sin(sine/12),.2) * CFrame.Angles(math.rad(0),math.rad(12),math.rad(-40 - 6 * math.sin(sine/12))),.2)
LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.3,1.05 + .15 * math.sin(sine/12),.2) * CFrame.Angles(0,math.rad(-12),math.rad(40 + 6 * math.sin(sine/12))),.2)
ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.4)
swait()
end
coroutine.wrap(function()
goldpart:Remove()
goldpart2:Remove()
goldpart3:Remove()
goldpart4:Remove()
goldpart5:Remove()
end)()

local rayParams = RaycastParams.new()
rayParams.FilterDescendantsInstances = {Character}
rayParams.FilterType = Enum.RaycastFilterType.Blacklist

local result = workspace:Raycast(Root.Position, Vector3.new(0, -500, 0), rayParams)

if result then
    local groundY = result.Position.Y
    local targetY = groundY + (Root.Size.Y / 2)

    for i = 1, 40 do
        local currentPos = Root.Position 
		Root.CFrame = CFrame.new(currentPos.X, currentPos.Y + (targetY - currentPos.Y) * 0.2,currentPos.Z) * CFrame.Angles(0, math.rad(spinny), 0)
        swait()
    end
end

mouse.KeyDown:connect(function(Press)
	Press=Press:lower()
	if Press=='g' then
	if running then return end
		if dancing then
			dancing = false
		else
			dancing = true
            ws = 0
			change = .5
			attacking = true
			coroutine.wrap(function()
				while dancing do
			    for i = 1, 2 do
                HEADLERP.C0 = HEADLERP.C0:lerp(CFrame.new(0, -1.5, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.5)
                LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(0.5, 1, -1) * CFrame.Angles(math.rad(-110), math.rad(0), math.rad(90)), 0.5)
                RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-0.5, 1, -1) * CFrame.Angles(math.rad(-110), math.rad(0), math.rad(-90)), 0.5)
                ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.5)
                RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10)), 0.5)
                LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(10)), 0.5)
                swait()
                end
                for i = 1, 2 do
                HEADLERP.C0 = HEADLERP.C0:lerp(CFrame.new(0, -1.5, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.5)
                LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(0.5, 1, -1) * CFrame.Angles(math.rad(-50), math.rad(-20), math.rad(90)), 0.06)
                RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-0.5, 1, -1) * CFrame.Angles(math.rad(-50), math.rad(20), math.rad(-90)), 0.06)
                ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.5)
                RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10)), 0.5)
                LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(10)), 0.5)
                swait()
                end
				swait()
				end
				ws = 14
				ROOTLERP.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				attacking = false
			end)()
		end
	end
end)

mouse.KeyDown:connect(function(Press)
	Press=Press:lower()
	if Press=='q' then
	if running then return end
		if dancing then
			dancing = false
		else
			dancing = true
            ws = 5
			change = .5
			attacking = true
			coroutine.wrap(function()
				while dancing do
				for i = 1, 3 do
			    HEADLERP.C0 = HEADLERP.C0:lerp(CFrame.new(0, -1.5, -0) * CFrame.Angles(math.rad(0), math.rad(70), math.rad(0)), 0.4)
			    LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.5, 0, -.9) * CFrame.Angles(math.rad(-140), math.rad(0), math.rad(90)), 0.8)
			    RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.5, 1.85, -.26) * CFrame.Angles(math.rad(-19), math.rad(0), math.rad(-90)), 0.8)
			    ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(70), math.rad(0)), 0.8)
			    RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.4, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-3)), 0.8)
			    LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.4, 2.0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(3)), 0.8)
				swait()
				end
				for i = 1, 3 do
				HEADLERP.C0 = HEADLERP.C0:lerp(CFrame.new(0, -1.5, -0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)), 0.4)
				LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.5, 1.85, -.26) * CFrame.Angles(math.rad(-19), math.rad(0), math.rad(90)), 0.8)
				RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.5, 0, -.9) * CFrame.Angles(math.rad(-140), math.rad(0), math.rad(-90)), 0.8)
				ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)), 0.8)
				RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.4, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-3)), 0.8)
				LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.4, 2.0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(3)), 0.8)
				swait()
                end
				swait()
				end
				ws = 14
				ROOTLERP.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				attacking = false
			end)()
		end
	end
end)

mouse.KeyDown:connect(function(Press)
	Press=Press:lower()
	if Press=='f' then
	if running then return end
		if dancing then
			dancing = false
		else
			dancing = true
			ws = 0
			change = .5
			attacking = true
			coroutine.wrap(function()
				while dancing do
				HEADLERP.C1 = HEADLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(-60),0),.6)
				LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,1,0) * CFrame.Angles(math.rad(197),math.rad(3),math.rad(10)), 0.4)
				RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,1,0) * CFrame.Angles(math.rad(197),math.rad(-3),math.rad(-10)), 0.4)
				swait()
                end
				ws = 14
				ROOTLERP.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				LEFTARMLERP.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				RIGHTARMLERP.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				attacking = false
			end)()
		end
	end
end)

mouse.KeyDown:connect(function(Press)
Press=Press:lower()
if Press=='t' then
if running then return end
if mouse.Target ~= nil then
attacking = true
removeuseless:AddItem(tps,2)
g1 = Instance.new("BodyGyro", Root)
g1.D = 175
g1.P = 20000
g1.MaxTorque = Vector3.new(0,9000,0)
g1.CFrame = CFrame.new(Root.Position,mouse.Hit.p)
removeuseless:AddItem(g1,.05)
Root.CFrame = CFrame.new(mouse.Hit.p) * CFrame.new(0,3.3,0)
wait(.1)
attacking = false
end
end
end)

mouse.KeyDown:connect(function(Press)
	Press=Press:lower()
	if Press=='y' then
		if dancing then
			dancing = false
		else
		    yay = Instance.new("Sound",Torso)
			yay.SoundId = "rbxassetid://3"
			yay.Volume = 1
			yay.Pitch = 1.2
			yay:Play()
			dancing = true
			ws = 0
			change = .5
			attacking = true
			coroutine.wrap(function()
				while dancing do
				LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1,-.2,.4) * CFrame.Angles(math.rad(-88 + 2 * math.sin(sine/12)),math.rad(76 - 1 * math.sin(sine/12)),math.rad(0)), 0.2)
                RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.7,-.2,.33) * CFrame.Angles(math.rad(-80 + 2 * math.sin(sine/12)),math.rad(-94 + 1 * math.sin(sine/12)),math.rad(0)), 0.2)
                ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2 + -.1 * math.sin(sine/16), 0) * CFrame.Angles(math.rad(0), math.rad(25), math.rad(0)),.2)
                RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),0,0),.2)
                RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-.4, 2 - .1 * math.sin(sine/16), .2) * CFrame.Angles(math.rad(-5), math.rad(30 + 0 * math.sin(sine/16)), math.rad(-5)), 0.2)
                LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.1)
                LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.55, 2.0 - .1 * math.sin(sine/16), .31) * CFrame.Angles(math.rad(5), math.rad(-20 + 0 * math.sin(sine/16)), math.rad(5)), 0.2)
				swait()
				end
				ws = 14
				yay:Remove()
				ROOTLERP.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				attacking = false
			end)()
		end
	end
end)

mouse.KeyDown:connect(function(Press)
	Press=Press:lower()
	if Press=='e' then
		if dancing then
			dancing = false
		else
		    man = Instance.new("Sound",Torso)
			man.SoundId = "rbxassetid://1"
			man.Volume = 1
			man:Play()
			dancing = true
			ws = 0
			change = .5
			attacking = true
			coroutine.wrap(function()
				while dancing do
				ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2 + -.1 * math.sin(sine/12), 0) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0)),.1)
				RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,.6,-.5) * CFrame.Angles(math.rad(32),math.rad(5 - 1 * math.sin(sine/12)),math.rad(40 - 2 * math.sin(sine/12))), 0.1)
				RIGHTARMLERP.C1 = RIGHTARMLERP.C1:lerp(CFrame.new(-.2,1.2,-.3),.1)
				LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,.6,-.5) * CFrame.Angles(math.rad(30),math.rad(-5 + 1 * math.sin(sine/12)),math.rad(-40 + 2 * math.sin(sine/12))), 0.1)
				LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(.2,1.2,-.3),.1)
				RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),0,0),.1)
				RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2 - .1 * math.sin(sine/12), 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10)), 0.1)
				LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.1)
				LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0 - .1 * math.sin(sine/12), 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(10)), 0.1)
				swait()
				end
				ws = 14
				man:Remove()
				ROOTLERP.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				RIGHTARMLERP.C1 = (CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
				LEFTARMLERP.C1 = (CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
				RIGHTLEGLERP.C1 = (CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
				LEFTLEGLERP.C1 = (CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)))
				attacking = false
			end)()
		end
	end
end)

mouse.KeyDown:connect(function(Press)
	Press=Press:lower()
	if Press=='r' then
		if dancing then
			dancing = false
		else
		    hi = Instance.new("Sound",Torso)
			hi.SoundId = "rbxassetid://1"
			hi.Volume = 1
			hi:Play()
			dancing = true
			ws = 0
			change = .5
			attacking = true
			coroutine.wrap(function()
				while dancing do
				ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2 + -.1 * math.sin(sine/12), 0) * CFrame.Angles(math.rad(6 * -math.sin(sine/12)),math.rad(0),math.rad(0)),.1)
				LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,0.5,0.4) * CFrame.Angles(math.rad(8.4),math.rad(-24.5),math.rad(19.2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.12)
                RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.1,1.4,0) * CFrame.Angles(math.rad(170.6),math.rad(-0.9),math.rad(31.1))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.12)
			    RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2 - .1 * math.sin(sine/12), 0) * CFrame.Angles(math.rad(6 * -math.sin(sine/12)), math.rad(0), math.rad(-10)), 0.1)
			    LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0 - .1 * math.sin(sine/12), 0) * CFrame.Angles(math.rad(6 * -math.sin(sine/12)), math.rad(0), math.rad(10)), 0.1)
				swait()
				end
				ws = 14
				hi:Remove()
				ROOTLERP.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
				attacking = false
			end)()
		end
	end
end)

mouse.KeyDown:connect(function(Press)
	Press=Press:lower()
	if Press=='u' then
		if dancing then
			dancing = false
		else
			dancing = true
			ws = 6
			change = .5
			attacking = true
			jellyfishjam = Instance.new("Sound",Torso)
			jellyfishjam.SoundId = "rbxassetid://1"
			jellyfishjam.Volume = 8
			jellyfishjam.Looped = true
			jellyfishjam.TimePosition = 14.8
			jellyfishjam:Play()
			coroutine.wrap(function()
				while dancing do
					for i = 1, 15 do
						if not dancing then break end
						ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(.5,-.4 + .1 * math.sin(sine/4),0) * CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sine/8)),math.rad(20)),.25)
						RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.3)
						LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(-50 - 3 * math.sin(sine/12)),math.rad(-3 + 1 * math.sin(sine/12))), .3)
						RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(0.25, 2.05,-0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-35)), 0.25)
						LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.31, 2.05,-0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(14)), 0.25)
						swait()
					end
					for i = 1, 15 do
						if not dancing then break end
						ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(0,-.1 * math.sin(sine/4),0) * CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sine/8)),math.rad(0)),.25)
						RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.3)
						LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(-50 - 3 * math.sin(sine/12)),math.rad(-3 + 1 * math.sin(sine/12))), .3)
						RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.25, .7,1.5) * CFrame.Angles(math.rad(72), math.rad(25), math.rad(-2)), 0.25)
						LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0, 0) * CFrame.Angles(0, math.rad(0), math.rad(10)), 0.25)
						swait()
					end
					for i = 1, 15 do
						if not dancing then break end
						ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(-.5,-.4 + .1 * math.sin(sine/4),0) * CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sine/8)),math.rad(-20)),.25)
						RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.3)
						LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(-50 - 3 * math.sin(sine/12)),math.rad(-3 + 1 * math.sin(sine/12))), .3)
						RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2 , 0) * CFrame.Angles(0, math.rad(0), math.rad(-10)), 0.25)
						LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(-0.25, 2.05,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(35)), 0.25)
						swait()
					end
					for i = 1, 15 do
						if not dancing then break end
						ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(-.5,-.1,0) * CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sine/8)),math.rad(0)),.25)
						RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.3)
						LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(-50 - 3 * math.sin(sine/12)),math.rad(-3 + 1 * math.sin(sine/12))), .3)
						RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.31, 2.05,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-14)), 0.3)
						LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.25, .7,1.5) * CFrame.Angles(math.rad(72), math.rad(-25), math.rad(-2)), 0.25)
						swait()
					end
					swait()
				end
				ws = 14
				attacking = false
			end)()
		end
	end
end)

function ray(pos, dir, rang, ignoredesc)
	return workspace:FindPartOnRay(Ray.new(pos, dir.unit * rang), ignoredesc)
end

function ray2(startpos, endpos, distance, ignore)
	local dir = CFrame.new(startpos,endpos).lookVector
	return ray(startpos, dir, distance, ignore)
end

checks1 = coroutine.wrap(function()
	while true do 

	hf = ray(Root.Position,(CFrame.new(Root.Position, Root.Position + Vector3.new(0,-1,0))).lookVector,9,Character)

		if Root.Velocity.Y > 1 then
			position = "Jump"
		elseif Root.Velocity.Y < -1 then
			position = "Falling"
		elseif Root.Velocity.Magnitude < 2 then
			position = "Idle"
		elseif running and Root.Velocity.Magnitude > 2 then
			position = "Running"
		elseif Root.Velocity.Magnitude > 2 then
			position = "Walking"
		end

		wait()
	end
end)
checks1()

function ray(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function ray2(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CFrame.new(StartPos,EndPos).lookVector
	return ray(StartPos, DIRECTION, Distance, Ignore)
end

OrgnC0 = Neck.C0
local movelimbs = coroutine.wrap(function()
	while RunSrv.RenderStepped:wait() do
		TrsoLV = Torso.CFrame.lookVector
		Dist = nil
		Diff = nil
		if not MseGuide then
			print("Failed to recognize")
		else
			local _, Point = Workspace:FindPartOnRay(Ray.new(Head.CFrame.p, mouse.Hit.lookVector), Workspace, false, true)
			Dist = (Head.CFrame.p-Point).magnitude
			Diff = Head.CFrame.Y-Point.Y
			local _, Point2 = Workspace:FindPartOnRay(Ray.new(LeftArm.CFrame.p, mouse.Hit.lookVector), Workspace, false, true)
			Dist2 = (LeftArm.CFrame.p-Point).magnitude
			Diff2 = LeftArm.CFrame.Y-Point.Y
			HEADLERP.C0 = CFrame.new(0, -1.5, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
			Neck.C0 = Neck.C0:lerp(OrgnC0*CFrame.Angles((math.tan(Diff/Dist)*1), 0, (((Head.CFrame.p-Point).Unit):Cross(Torso.CFrame.lookVector)).Y*1), .1)
		end
	end
end)
movelimbs()
immortal = {}
for i,v in pairs(Character:GetDescendants()) do
	if v:IsA("BasePart") and v.Name ~= "lmagic" and v.Name ~= "rmagic" then
		if v ~= Root and v ~= Torso and v ~= Head and v ~= RightArm and v ~= LeftArm and v ~= RightLeg and v.Name ~= "lmagic" and v.Name ~= "rmagic" and v ~= LeftLeg then
			v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		end
		table.insert(immortal,{v,v.Parent,v.Material,v.Color,v.Transparency})
	elseif v:IsA("JointInstance") then
		table.insert(immortal,{v,v.Parent,nil,nil,nil})
	end
end
for e = 1, #immortal do
	if immortal[e] ~= nil then
		local STUFF = immortal[e]
		local PART = STUFF[1]
		local PARENT = STUFF[2]
		local MATERIAL = STUFF[3]
		local COLOR = STUFF[4]
		local TRANSPARENCY = STUFF[5]
		if levitate then
			if PART.ClassName == "Part" and PART ~= Root and PART.Name ~= eyo1 and PART.Name ~= eyo2 and PART.Name ~= "lmagic" and PART.Name ~= "rmagic" then
				PART.Material = MATERIAL
				PART.Color = COLOR
			end
			PART.AncestryChanged:connect(function()
				PART.Parent = PARENT
			end)
		else
			if PART.ClassName == "Part" and PART ~= Root and PART.Name ~= "lmagic" and PART.Name ~= "rmagic" then
				PART.Material = MATERIAL
				PART.Color = COLOR
			end
			PART.AncestryChanged:connect(function()
				PART.Parent = PARENT
			end)
		end
	end
end
function immortality()
	for e = 1, #immortal do
		if immortal[e] ~= nil then
			local STUFF = immortal[e]
			local PART = STUFF[1]
			local PARENT = STUFF[2]
			local MATERIAL = STUFF[3]
			local COLOR = STUFF[4]
			local TRANSPARENCY = STUFF[5]
			if PART.ClassName == "Part" and PART == Root then
				PART.Material = MATERIAL
				PART.Color = COLOR
			end
			if PART.Parent ~= PARENT then
				hum:Remove()
				PART.Parent = PARENT
				hum = Instance.new("Humanoid",Character)
			end
		end
	end
end

spinny = 0
local anims = coroutine.wrap(function()
	while true do
		settime = 0.05
		sine = sine + change
		if position == "Jump" and attacking == false then
			change = 1
			spin = false
			spinny = spinny - 18
			LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.1)
			RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),0,0),.1)
			LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.4)
			ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(spinny), math.rad(0), math.rad(0)), 0.4)
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,.14 + .02 * math.sin(sine/12),-.125) * CFrame.Angles(math.rad(28 + 5 * math.sin(sine/12)),math.rad(0),math.rad(10)), 0.2)
			RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,.14 + .02 * math.sin(sine/12),-.125) * CFrame.Angles(math.rad(28 + 5 * math.sin(sine/12)),math.rad(0),math.rad(-10)), 0.2)
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.5, 1., .9) * CFrame.Angles(math.rad(20), math.rad(0), math.rad(0)), 0.4)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5, 1.0, .9) * CFrame.Angles(math.rad(20), math.rad(0), math.rad(0)), 0.4)
elseif position == "Falling" and not attacking then
change = 1
LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,.94 + .02 * math.sin(sine/12),-0) * CFrame.Angles(math.rad(28 + 5 * math.sin(sine/12)),math.rad(0),math.rad(45)), 0.2)
RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,.94 + .02 * math.sin(sine/12),-0) * CFrame.Angles(math.rad(28 + 5 * math.sin(sine/12)),math.rad(0),math.rad(-45)), 0.2)
ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(20), math.rad(0), math.rad(0)), 0.09)
RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.54, 1.4 + .1 * math.sin(sine/12), .4) * CFrame.Angles(math.rad(9 + 2 * math.cos(sine/12)), math.rad(0), math.rad(0)), 0.25)
LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.54, 2 + .02 * math.sin(sine/12), 0.2 + .1 * math.sin(sine/12)) * CFrame.Angles(math.rad(25 + 5 * math.sin(sine/12)), math.rad(20), math.rad(0)), 0.25)
elseif position == "Walking" and not attacking then
change = 1
walking = true
ws = 29
local plant2 = hum.MoveDirection*Torso.CFrame.LookVector
local plant3 = hum.MoveDirection*Torso.CFrame.RightVector
local plant = plant2.Z + plant2.X
local plant4 = plant3.Z + plant3.X
LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.3 - .3 * math.sin(sine/8),.45 -.45 * math.sin(sine/8),-.3 + .26*math.sin(sine/8)) * CFrame.Angles(math.rad(75*-math.sin(sine/8)),math.rad(30 + 40*math.sin(sine/8)),math.rad(10, math.sin(-20 * math.sin(sine/4)))),.3)
RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.3 - .3 * math.sin(sine/8),.45 +.45 * math.sin(sine/8),-.3 - .26*math.sin(sine/8)) * CFrame.Angles(math.rad(75*math.sin(sine/8)),math.rad(-30 + 40*math.sin(sine/8)),math.rad(-10, math.sin(-20 * math.sin(sine/4)))),.3)
ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.3 + 0.31*math.sin(sine/3), 0) * CFrame.Angles(math.rad(plant-plant/5)*-20, math.rad(-plant4 - -plant4/5*math.sin(sine/6))*35, math.rad(-plant4 - plant4*15) + Root.RotVelocity.Y / 30) * CFrame.Angles(0,math.rad(12 * -math.cos(sine/6)), 0),.1)
RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.52, 1.62 - .54 * math.cos(sine/6)/2.8,.2 - .5 * math.sin(sine/6)) * CFrame.Angles(math.rad(-20 * -plant - plant*math.sin(sine/6)*60), math.rad(-plant4 - -plant4/5*math.sin(sine/6)*40),math.rad(-plant4 - plant4*math.sin(sine/6)*20)), 0.3)
LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.52, 1.62 + .54 * math.cos(sine/6)/2.8,.2 + .5 * math.sin(sine/6)) * CFrame.Angles(math.rad(-20 * -plant - plant*math.sin(sine/6)*-60), math.rad(-plant4 - -plant4/5*math.sin(sine/6)*40), math.rad(-plant4 - -plant4*math.sin(sine/6)*20)), 0.3)
elseif position == "Idle" and not attacking then
change = 1
LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.3,1.05 + .15 * math.sin(sine/12),.2) * CFrame.Angles(0,math.rad(-12),math.rad(40 + 6 * math.sin(sine/12))),.2)
RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.3,1.05 + .15 * math.sin(sine/12),.2) * CFrame.Angles(math.rad(0),math.rad(12),math.rad(-40 - 6 * math.sin(sine/12))),.2)
ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2 + -.1 * math.sin(sine/16), 0) * CFrame.Angles(math.rad(0), math.rad(30), math.rad(0)),.2)
RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),0,0),.2)
RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-.4, 2 - .1 * math.sin(sine/16), .2) * CFrame.Angles(math.rad(-5), math.rad(30 + 0 * math.sin(sine/16)), math.rad(-5)), 0.2)
LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.1)
LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.55, 2.0 - .1 * math.sin(sine/16), .31) * CFrame.Angles(math.rad(5), math.rad(-20 + 0 * math.sin(sine/16)), math.rad(5)), 0.2)
ROOTLERP.C1 = ROOTLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.2)
LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.3,1.05 + .15 * math.sin(sine/12),.2) * CFrame.Angles(0,math.rad(-12),math.rad(40 + 6 * math.sin(sine/12))),.2)
RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.3,1.05 + .15 * math.sin(sine/12),.2) * CFrame.Angles(math.rad(0),math.rad(12),math.rad(-40 - 6 * math.sin(sine/12))),.2)
end
swait()
end
end)
anims()
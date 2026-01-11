--//====================================================\\--
--||                       BASIS
--\\====================================================//--

local MODULE = game:GetObjects("rbxassetid://5970744588")[1].Karambit
local PLAYER = game.Players.LocalPlayer
local CHARACTER = PLAYER.Character
local HUM = CHARACTER.Humanoid
local REMOTE = MODULE.Event

local ROOT = HUM.Torso
local HEAD = CHARACTER.Head
local TORSO = CHARACTER.Torso
local RIGHTARM = CHARACTER["Right Arm"]
local LEFTARM = CHARACTER["Left Arm"]
local RIGHTLEG = CHARACTER["Right Leg"]
local LEFTLEG = CHARACTER["Left Leg"]
local ROOTJOINT = ROOT["RootJoint"]
local NECK = TORSO["Neck"]
local RIGHTSHOULDER = TORSO["Right Shoulder"]
local LEFTSHOULDER = TORSO["Left Shoulder"]
local RIGHTHIP = TORSO["Right Hip"]
local LEFTHIP = TORSO["Left Hip"]
local MOUSEPOS = ROOT.Position

IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor

--//====================================================\\--
--||                  BACKGROUND VALUES
--\\====================================================//--

local ANIM_SPEED = 3
local MOUSE = PLAYER:GetMouse()

MOUSE.Button1Down:Connect(function()
	if ATTACKING then return end
	MOUSEHOLD = true
	Melee()
end)

MOUSE.Button1Up:Connect(function()
	MOUSEHOLD = false
end)

local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end

	if input.KeyCode == Enum.KeyCode.Z then
		KEYHOLD = true
		end

elseif input.KeyCode == Enum.KeyCode.Z then

	if HUM.WalkSpeed <= 25 then
		HUM.WalkSpeed = 32
	else
		HUM.WalkSpeed = 20
	end

elseif input.KeyCode == Enum.KeyCode.E then
	if not ATTACKING then
		SPIN()
	end
end)

local FRAME_SPEED = 1 / 60
local CHANGE = 2 / ANIM_SPEED
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local KEYHOLD = false
local MOUSEHOLD = false
local SINE = 0
local ATTACKING = false
local Debris = game:GetService("Debris")
local Effects = IT("Folder",CHARACTER)
Effects.Name = "FXFolder"
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))


--//====================================================\\--
--||                     HEARTBEAT
--\\====================================================//--

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = FRAME_SPEED
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				ArtificialHB:Fire()
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

function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

--//====================================================\\--
--||                       CLERP
--\\====================================================//--

function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then 
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end
 
function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end
 
function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = ACOS(-cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((t - 1) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end

--//====================================================\\--
--||                     FUNCTIONS
--\\====================================================//--

function WeldParts(A,B)
	local WLD = IT("ManualWeld")
	WLD.Part0 = A
	WLD.Part1 = B
	WLD.C1 = B.CFrame:inverse() * A.CFrame
	WLD.Parent = A
	return WLD
end

--NewSound({ID = 0,PARENT = ROOT,VOLUME = 0.5,PITCH = 1,LOOP = false,MAXDISTANCE = 1000,EMITTERSIZE = 10,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
function NewSound(TABLE)
	local ID = "rbxassetid://"..(TABLE.ID or 0)
	local PARENT = (TABLE.PARENT or ROOT)
	local VOLUME = (TABLE.VOLUME or 0.5)
	local PITCH = (TABLE.PITCH or 1)
	local LOOP = (TABLE.LOOP or false)
	local MAXDISTANCE = (TABLE.MAXDISTANCE or 100)
	local EMITTERSIZE = (TABLE.EMITTERSIZE or 10)
	local PLAYING = (TABLE.PLAYING or true)
	local PLAYONREMOVE = (TABLE.PLAYONREMOVE or false)
	local DOESDEBRIS = (TABLE.DOESDEBRIS or true)
	if ID ~= "rbxassetid://0" then
		local SOUND = IT("Sound",PARENT)
		SOUND.SoundId = ID
		SOUND.Volume = VOLUME
		SOUND.Pitch = PITCH
		SOUND.Looped = LOOP
		SOUND.MaxDistance = MAXDISTANCE
		SOUND.EmitterSize = EMITTERSIZE
		SOUND.PlayOnRemove = PLAYONREMOVE
		if DOESDEBRIS == true and PLAYING == true and LOOP == false then
			Debris:AddItem(SOUND,SOUND.TimeLength+5)
		end
		if PLAYING == true then
			SOUND:Play()
		end
		return SOUND
	end
end

function OofOuchBlood(LOCATION,TO,AMOUNT)
	local P = CreatePart(3, Effects, "Granite", 0, 1, BRICKC("Pearl"), "Blood", VT(0,0,0), true)
	P.CFrame = CF(LOCATION,TO)
	local BLOOD = MODULE.Blood:Clone()
	BLOOD.Parent = P
	BLOOD:Emit(AMOUNT)
	Debris:AddItem(P,2)
end

function AttachmentCFrame(A)
	return A.Parent.CFrame*CF(A.Position)
end

function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos,EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end

function ManSlaughter(MAN)
	if MAN then
		local ROOT = MAN:FindFirstChild("HumanoidRootPart")
		if ROOT then
			--ROOT:Remove()
		end
		local MANHUM = MAN:FindFirstChildOfClass("Humanoid")
		if MANHUM then
			--MANHUM.BreakJointsOnDeath = false
			--MANHUM.Health = 0
		end
		if MAN:FindFirstChild("R6Ragdoll") == nil and MAN:FindFirstChild("R15Ragdoll") == nil then
			if MAN:FindFirstChild("UpperTorso") then
				--local SCRIPT = script.R15Ragdoll:Clone()
				--SCRIPT.Parent = MAN
				--SCRIPT.Disabled = false
			else
				--local SCRIPT = script.R6Ragdoll:Clone()
				--SCRIPT.Parent = MAN
				--SCRIPT.Disabled = false
			end
			local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
			if TORSO then
				--NewSound({ID = 146594648,PARENT = TORSO,VOLUME = 1,PITCH = MRANDOM(8,12)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			end
		end
		--MAN:BreakJoints()
		if MAN:FindFirstChild("Slaughtered") == nil then
			local MARK = IT("Folder",MAN)
			MARK.Name = "Slaughtered"
		else
			if MAN:FindFirstChild("Slaughtered") then
				local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
				if TORSO then
					--TORSO.RotVelocity = VT(0,MRANDOM(-25,25),0)
				end
			end
		end
	end
end

function Concuss(HUMAN,TIME)
	coroutine.resume(coroutine.create(function()
		if HUMAN then
			if HUMAN:FindFirstChild("ConcussTime") == nil then
				local MARK = nil
				if HUMAN.Parent:FindFirstChild("Slaughtered") == nil then
					MARK = IT("Folder",HUMAN.Parent)
					MARK.Name = "Slaughtered"
				end
				local TIMER = IT("NumberValue",HUMAN)
				TIMER.Name = "ConcussTime"
				TIMER.Value = TIME
				HUMAN.PlatformStand = true
				repeat
					wait(0.25)
					TIMER.Value = TIMER.Value - 0.25
				until TIMER.Value <= 0
				HUMAN.PlatformStand = false
				if MARK then
					MARK:Remove()
				end
			else
				if HUMAN:FindFirstChild("ConcussTime").Value < TIME then
					HUMAN:FindFirstChild("ConcussTime").Value = TIME
				end
			end
		end
	end))
end

function ApplyDamageTo(HUM,DAMAGE)
	if HUM.Health >= 0 then
		HUM.Health = HUM.Health - DAMAGE
		if HUM.Health <= 0 then
			--ManSlaughter(HUM.Parent)
		end
	end
end

function AreaOfEffect(AREA,RANGE,MIN,MAX,RETURN)
	local HIT = {}
	for index, CHILD in pairs(workspace:GetChildren()) do
		if CHILD:FindFirstChildOfClass("Humanoid") and CHILD ~= CHARACTER then
			local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
			local ROOT = HUMAN.Torso
			if ROOT then
				if (ROOT.Position - AREA).Magnitude <= RANGE then
					if RETURN == true then
						table.insert(HIT,{CHILD,HUMAN,ROOT})
					else
						--ApplyDamageTo(HUMAN,MRANDOM(MIN,MAX))
					end
				end
			end
		end
	end
	if RETURN == true then
		return HIT
	end
end

function ConnectDamage(PART,MIN,MAX)
	local HITS = {}
	local TOUCH = PART.Touched:Connect(function(HITP)
		if HITP.Parent then
			if HITP.Parent:FindFirstChildOfClass("Humanoid") then
				local HUMAN = HITP.Parent:FindFirstChildOfClass("Humanoid")
				local PASS = true
				for E = 1, #HITS do
					if HITS[E] == HUMAN then
						PASS = false
						break
					end
				end
				if PASS == true and HUM ~= HUMAN then
					--ApplyDamageTo(HUMAN,MRANDOM(MIN,MAX))
					table.insert(HITS,HUMAN)
				end
			end
		end
	end)
	return TOUCH
end

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = ROOT.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

--WACKYEFFECT({EffectType = "", Size = VT(1,1,1), Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = CF(), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
function WACKYEFFECT(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or VT(1,1,1))
	local ENDSIZE = (Table.Size2 or VT(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or ROOT.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLOR = (Table.Color or C3(1,1,1))
	local TIME = (Table.Time or 45)
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPITCH = (Table.SoundPitch or nil)
	local SOUNDVOLUME = (Table.SoundVolume or nil)
	local USEBOOMERANGMATH = (Table.UseBoomerangMath or false)
	local BOOMERANG = (Table.Boomerang or 0)
	local SIZEBOOMERANG = (Table.SizeBoomerang or 0)
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND = nil
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = NewSound({ID = SOUNDID,PARENT = EFFECT,VOLUME = SOUNDVOLUME,PITCH = SOUNDPITCH,LOOP = false,MAXDISTANCE = 200,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, VT(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
		end
		if MSH ~= nil then
			local BOOMR1 = 1+BOOMERANG/50
			local BOOMR2 = 1+SIZEBOOMERANG/50
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				if USEBOOMERANGMATH == true then
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)*BOOMR1
				else
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)
				end
			end
			local GROWTH = nil
			if USEBOOMERANGMATH == true then
				GROWTH = (SIZE - ENDSIZE)*(BOOMR2+1)
			else
				GROWTH = (SIZE - ENDSIZE)
			end
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			if USEBOOMERANGMATH == true then
				for LOOP = 1, TIME+1 do
					Swait()
					MSH.Scale = MSH.Scale - (VT((GROWTH.X)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Y)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Z)*((1 - (LOOP/TIME)*BOOMR2)))*BOOMR2)/TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-(MOVESPEED)*((1 - (LOOP/TIME)*BOOMR1)))
						EFFECT.CFrame = CF(EFFECT.Position)*ANGLES(RAD(ORI.X),RAD(ORI.Y),RAD(ORI.Z))
					end
				end
			else
				for LOOP = 1, TIME+1 do
					Swait()
					MSH.Scale = MSH.Scale - GROWTH/TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
						EFFECT.CFrame = CF(EFFECT.Position)*ANGLES(RAD(ORI.X),RAD(ORI.Y),RAD(ORI.Z))
					end
				end
			end
			EFFECT.Transparency = 1
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end
	end))
end

function CameraShake(AREA,RANGE,SHAKE,TIMER)
	for index, CHILD in pairs(workspace:GetChildren()) do
		if CHILD:FindFirstChildOfClass("Humanoid") then
			local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
			local ROOT = HUMAN.Torso
			if ROOT and game.Players:GetPlayerFromCharacter(CHILD) then
				if (ROOT.Position - AREA).Magnitude <= RANGE then
					if CHILD:FindFirstChild("CamShake") then
						Debris:AddItem(CHILD:FindFirstChild("CamShake"),0.05)
					end
					local CAMSHAKE = script.CamShake:Clone()
					CAMSHAKE.Parent = CHILD
					local TIMER_V = IT("NumberValue",CAMSHAKE)
					TIMER_V.Name = "Timer"
					TIMER_V.Value = TIMER
					local SHAKE_V = IT("NumberValue",CAMSHAKE)
					SHAKE_V.Name = "Shake"
					SHAKE_V.Value = SHAKE
					CAMSHAKE.Disabled = false
					Debris:AddItem(CAMSHAKE,15)
				end
			end
		end
	end
end

--Debree({Delay = 1.5,Variant = "",Location = ROOT.Position,Color = C3(1,1,1),Size = 1,Distance = 1,Material = "Slate",Scatter = 1,Amount = 1,DebreeCount = 1})
function Debree(Table)
	local KindOf = (Table.Variant or "Ring")
	local Position = (Table.Location or ROOT.Position)
	local Coloration = (Table.Color or C3(1,1,1))
	local Texture = (Table.Material or "Slate")
	local Fling = (Table.Scatter or 1)
	local Number = (Table.Amount or 1)
	local Rocks = (Table.DebreeCount or 1)
	local Range = (Table.Distance or 1)
	local Scale = (Table.Size or 1)
	local Timer = (Table.Delay or 1.5)
	coroutine.resume(coroutine.create(function()
		local ScaleVector = VT(Scale,Scale,Scale)
		local Boulders = {}
		Position = CF(Position)
		if KindOf == "Ring" or KindOf == "Both" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),Range)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				BOULDER.Color = Coloration
				table.insert(Boulders,BOULDER)
			end
		end
		if KindOf == "Loose" or KindOf == "Both" then
			for RockValue = 1, Rocks do
				local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale-(Scale/2)),math.ceil(Scale-(Scale/2))),0.7)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, false)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				BOULDER.Velocity = CF(BOULDER.Position-VT(0,4,0),BOULDER.CFrame*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))*CF(0,5,0).p).lookVector*MRANDOM(Fling-(Fling/1.5),Fling+(Fling/1.5))
				BOULDER.Color = Coloration
				table.insert(Boulders,BOULDER)
			end
		end
		if KindOf == "Random" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),MRANDOM(0,Range))
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				BOULDER.Color = Coloration
				table.insert(Boulders,BOULDER)
			end
		end
		wait(Timer)
		for E = 1, 45 do
			Swait()
			for A = 1, #Boulders do
				Boulders[A].Transparency = Boulders[A].Transparency + 1/45
			end
		end
		for A = 1, #Boulders do
			Boulders[A]:Destroy()
		end
	end))
end

function Chatter(Text,Timer)
	local chat = coroutine.wrap(function()
		if CHARACTER:FindFirstChild("SpeechBoard")~= nil then
			CHARACTER:FindFirstChild("SpeechBoard"):destroy()
		end
		local naeeym2 = IT("BillboardGui",CHARACTER)
		naeeym2.Size = UD2(0,100,0,40)
		naeeym2.StudsOffset = Vector3.new(0,2,0)
		naeeym2.Adornee = HEAD
		naeeym2.Name = "SpeechBoard"
		naeeym2.AlwaysOnTop = true
		local tecks2 = IT("TextLabel",naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = "Legacy"
		tecks2.TextSize = 15
		tecks2.TextStrokeTransparency = 0
		tecks2.TextColor3 = Color3.new(1,1,1)
		tecks2.TextStrokeColor3 = Color3.new(0,0,0)
		tecks2.Size = UDim2.new(1,0,0.5,0)
		for i = 1,string.len(Text),1 do
			if naeeym2.Parent ~= CHARACTER then 
				break
			end
			NewSound({ID = 418252437,PARENT = HEAD,VOLUME = 1,PITCH = MRANDOM(8,12)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			tecks2.Text = string.sub(Text,1,i)
			wait(Timer)
		end
		wait(1)
		naeeym2:Destroy()
	end)
	chat()
end

--//====================================================\\--
--||                     CHARACTER
--\\====================================================//--

local KARAMBIT = MODULE.Tool
KARAMBIT.Parent = CHARACTER
for _,v in ipairs(KARAMBIT:GetDescendants()) do
	if v:IsA("BasePart") then
		v.Transparency = 1
	end
end
KARAMBIT:SetPrimaryPartCFrame(RIGHTARM.CFrame*CF(0,-1,0))
local PARTS = {}
for index, CHILD in pairs(KARAMBIT:GetChildren()) do
	if CHILD ~= KARAMBIT.PrimaryPart then
		local WELD = WeldParts(KARAMBIT.PrimaryPart,CHILD)
		table.insert(PARTS,{CHILD,WELD})
	end
	CHILD.Anchored = false
end
local GRIP = IT("Motor6D")
GRIP.Part0 = RIGHTARM
GRIP.Part1 = KARAMBIT.PrimaryPart
GRIP.C0 = CF(0,-1,0)
GRIP.Parent = RIGHTARM
local GC0 = GRIP.C0
local SPIN = 0
local COMBO = 1
local EQUIPPED = true
local TRAIL = KARAMBIT.PrimaryPart.Trail
local HANDLE = KARAMBIT.PrimaryPart
local GUI = MODULE.ControlsGUI
GUI.Parent = PLAYER.PlayerGui
GUI.ToggleButton.MouseButton1Click:Connect(function()
	if GUI.ToggleButton.Controls.Visible == false then
		GUI.ToggleButton.Controls.Visible = true
	elseif GUI.ToggleButton.Controls.Visible == true then
		GUI.ToggleButton.Controls.Visible = false
	end
end)

--//====================================================\\--
--||                     ABILITIES
--\\====================================================//--

function Melee()
	if EQUIPPED == true then
		local GYRO = IT("BodyGyro")
		GYRO.D = 200
		GYRO.P = 5000
		GYRO.MaxTorque = VT(0,4000000,0)
		GYRO.CFrame = CF(ROOT.Position,MOUSE.Hit.p)
		GYRO.Parent = ROOT
		ATTACKING = true
		coroutine.resume(coroutine.create(function()
			repeat
				Swait()
				GYRO.CFrame = CF(ROOT.Position,MOUSE.Hit.p)
			until ATTACKING == false
			GYRO:Remove()
		end))
		local MELEEAREA = function(BEEF,KNOCKBACK)
			local DIDHIT = false
			NewSound({ID = 1,PARENT = ROOT,VOLUME = 1,PITCH = MRANDOM(8,12)/8,LOOP = false,MAXDISTANCE = 125,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for index, CHILD in pairs(workspace:GetChildren()) do
				if CHILD:FindFirstChildOfClass("Humanoid") and CHILD ~= CHARACTER then
					local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
					local TORS = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
					if TORS then
						if (TORS.Position - ROOT.CFrame*CF(0,0,-1.5).p).Magnitude <= 4 then
							DIDHIT = true
							NewSound({ID = 2,PARENT = TORS,VOLUME = 3,PITCH = MRANDOM(8,12)/10,LOOP = false,MAXDISTANCE = 125,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
							--HUMAN.Health = HUMAN.Health - (DAMAGEMULTIPLIER*BEEF)
							--local BV = IT("BodyVelocity")
							--BV.MaxForce = BV.MaxForce * 500
							--BV.Velocity = CF(ROOT.Position,TORS.Position+VT(0,0.5,0)).lookVector*((KNOCKBACK+(BEEF/2))*DAMAGEMULTIPLIER)
							--BV.Parent = TORS
							Debris:AddItem(BV,0.05)
							OofOuchBlood(TORS.Position,ROOT.Position,math.ceil(BEEF/4))
							if HUMAN.Health <= 100 then
								--ManSlaughter(CHILD)
							end
						end
					end
				end
			end
			if DIDHIT == true then
				CameraShake(ROOT.CFrame*CF(0,0,-1.5).p,4,1*DAMAGEMULTIPLIER,2)
			end
		end
		TRAIL.Enabled = true
		if COMBO == 1 then
			for i=0, 0.2, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 0.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(25)), 0.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(15), RAD(90 - 2.5 * COS(SINE / 12))) * RIGHTSHOULDERC0, 0.75 / ANIM_SPEED)
				GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(25),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(50), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
			end
			MELEEAREA(15,2)
			for i=0, 0.3, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(50)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(-50)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(15), RAD(-15 - 2.5 * COS(SINE / 12))) * CF(0,-1,0) * ANGLES(RAD(0),RAD(90),RAD(0)) * RIGHTSHOULDERC0, 1.25 / ANIM_SPEED)
				GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(40), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			COMBO = 2
		elseif COMBO == 2 then
			for i=0, 0.2, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(50)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(-50)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(15), RAD(-15 - 2.5 * COS(SINE / 12))) * CF(0,-1,0) * ANGLES(RAD(0),RAD(90),RAD(0)) * RIGHTSHOULDERC0, 1.75 / ANIM_SPEED)
				GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(40), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			MELEEAREA(22,2)
			for i=0, 0.3, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(15), RAD(90 - 2.5 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1.25 / ANIM_SPEED)
				GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(5),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(50), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			COMBO = 3
		elseif COMBO == 3 then
			for i=0, 0.1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 0.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(25)), 0.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(15), RAD(35 - 2.5 * COS(SINE / 12))) * RIGHTSHOULDERC0, 0.75 / ANIM_SPEED)
				GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(50), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
			end
			MELEEAREA(35,10)
			for i=0, 0.4, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0.1 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(50)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(-50)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(125), RAD(15), RAD(-15 - 2.5 * COS(SINE / 12))) * CF(0,-1,0) * ANGLES(RAD(0),RAD(90),RAD(0)) * RIGHTSHOULDERC0, 1.25 / ANIM_SPEED)
				GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(-50),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(40), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1.1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(5), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			COMBO = 1
		end
		GYRO:Remove()
		TRAIL.Enabled = false
		ATTACKING = false
	end
end
function Climb()
	if EQUIPPED == true then
		COMBO = 1
		local RELEASE = false
		MOUSEPOS = MOUSE.Hit.p
local HIT1 = CastProperRay(ROOT.Position,VT(MOUSEPOS.X,ROOT.Position.Y,MOUSEPOS.Z),3,CHARACTER)
		if HIT1 then
			if HIT1.Anchored == true and HIT1.Parent:FindFirstChildOfClass("Humanoid") == nil then
				ATTACKING = true
				ROOT.Anchored = true
				ROOT.CFrame = CF(POS1,POS1+NORMAL1)*CF(0,0,-0.7)*ANGLES(0,RAD(180),0)
				repeat
					if KEYHOLD == true then
						local HIT,POS,NORMAL = CastProperRay(ROOT.Position + VT(0,2.6,0),CF(ROOT.Position + VT(0,2.6,0))*ANGLES(0,RAD(ROOT.Orientation.Y),0)*CF(0,0,-1).p,1,CHARACTER)
						local ROOF = CastProperRay(ROOT.Position,ROOT.Position+VT(0,5,0),3.5,CHARACTER)
						if HIT and ROOF == nil then
							ROOT.CFrame = CF(POS,POS+NORMAL)*CF(0,-2.6,-0.7)*ANGLES(0,RAD(180),0)
							for i=0, 0.1, 0.1 / ANIM_SPEED do
								Swait()
								ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(-15), RAD(0)), 1.5 / ANIM_SPEED)
								NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20 - 2.5 * COS(SINE / 12)), RAD(15), RAD(0)), 1.5 / ANIM_SPEED)
								RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(-15), RAD(15 - 2.5 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
								GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(180),RAD(0),RAD(180)), 1.5 / ANIM_SPEED)
								LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 1.5, 0) * ANGLES(RAD(170), RAD(-15), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
								RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
								LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							end
							for i=0, 0.25, 0.1 / ANIM_SPEED do
								Swait()
								ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(-15), RAD(0)), 1.5 / ANIM_SPEED)
								NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20 - 2.5 * COS(SINE / 12)), RAD(15), RAD(0)), 1.5 / ANIM_SPEED)
								RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 1.5, 0) * ANGLES(RAD(-160), RAD(-15), RAD(15 - 2.5 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
								GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(180),RAD(0),RAD(180)), 1.5 / ANIM_SPEED)
								LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(170), RAD(-15), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
								RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
								LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							end
							NewSound({ID = 1,PARENT = RIGHTARM,VOLUME = 0.5,PITCH = MRANDOM(8,12)/8,LOOP = false,MAXDISTANCE = 125,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
							for i = 1, 10 do
								Swait()
								ROOT.CFrame = ROOT.CFrame*CF(0,0.1,0)
								ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(15), RAD(0)), 1.5 / ANIM_SPEED)
								NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20 - 2.5 * COS(SINE / 12)), RAD(-15), RAD(0)), 1.5 / ANIM_SPEED)
								RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 1.5-(i/10), 0) * ANGLES(RAD(180), RAD(15), RAD(15 - 2.5 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1)
								GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(180),RAD(0),RAD(180)), 1.5 / ANIM_SPEED)
								LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(170), RAD(15), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
								RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
								LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							end
						else
							RELEASE = true
							if ROOF == nil then
								for i = 1, 10 do
									Swait()
									ROOT.CFrame = ROOT.CFrame*CF(0,-0.1,0)
									ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(15), RAD(0)), 1.5 / ANIM_SPEED)
									NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20 - 2.5 * COS(SINE / 12)), RAD(-15), RAD(0)), 1.5 / ANIM_SPEED)
									RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5+(i/10), 0) * ANGLES(RAD(180), RAD(15), RAD(15 - 2.5 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1)
									GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(180),RAD(0),RAD(180)), 1.5 / ANIM_SPEED)
									LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(-15), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
									RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
									LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
								end
								for i = 1, 35 do
									Swait()
									ROOT.CFrame = ROOT.CFrame*CF(0,(35-i)/75,0)
									ROOTJOINT.C0 = Clerp(ROOTJOINT.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / ANIM_SPEED)
									NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20), RAD(0), RAD(0)), 1 / ANIM_SPEED)
									RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-2), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1 / ANIM_SPEED)
									GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
									LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-2), RAD(0), RAD(10)) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
									RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.4, -0.6) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-20)), 1 / ANIM_SPEED)
									LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 1 / ANIM_SPEED)
								end
								--local BV = IT("BodyVelocity")
								--BV.MaxForce = BV.MaxForce * 500
								--BV.Velocity = ROOT.CFrame.lookVector*35
								--BV.Parent = ROOT
								Debris:AddItem(BV,0.05)
							end
						end
					else
						Swait()
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(15), RAD(0)), 1.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(115)) * ANGLES(RAD(10 - 2.5 * COS(SINE / 12)), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(180), RAD(15), RAD(15)) * RIGHTSHOULDERC0, 1)
						GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(180),RAD(0),RAD(180)), 1.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(-15), RAD(-15 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 + 0.025 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 + 0.025 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					end
				until RELEASE == true
				ROOT.Velocity = VT(0,5,0)
				ROOT.Anchored = false
			end
			ATTACKING = false
		end
	end
end
function Throw()
	local DETECTKILL = function(HIT,POS,FORCE)
		if HIT.Parent:FindFirstChildOfClass("Humanoid") then
			if HIT.Parent:FindFirstChildOfClass("Humanoid").Health > 100 then
				--local BV = IT("BodyVelocity")
				--BV.MaxForce = BV.MaxForce * 500
				--BV.Velocity = CF(ROOT.Position,HIT.Position+VT(0,5,0)).lookVector*(FORCE or 25)
				--BV.Parent = HIT
				Debris:AddItem(BV,0.05)
				OofOuchBlood(POS,ROOT.Position,150)
			else
				OofOuchBlood(POS,ROOT.Position,2)
			end
			--ManSlaughter(HIT.Parent)
			NewSound({ID = 1489924400,PARENT = HIT,VOLUME = 1,PITCH = MRANDOM(9,11)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
		elseif HIT.Parent.Parent:FindFirstChildOfClass("Humanoid") then
			if HIT.Parent.Parent:FindFirstChildOfClass("Humanoid").Health > 100 then
				OofOuchBlood(POS,ROOT.Position,150)
			else
				OofOuchBlood(POS,ROOT.Position,2)
			end
			--ManSlaughter(HIT.Parent.Parent)
			NewSound({ID = 1,PARENT = HIT,VOLUME = 1,PITCH = MRANDOM(9,11)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
		else
			--Debree({Delay = 1.5,Variant = "Loose",Location = POS,Color = HIT.Color,Size = 0.2,Distance = 1,Material = HIT.Material,Scatter = 60,Amount = 1,DebreeCount = 4})
		end
	end
	if EQUIPPED == true then
		EQUIPPED = false
		COMBO = 1
		ATTACKING = true
		local GYRO = IT("BodyGyro")
		GYRO.D = 200
		GYRO.P = 5000
		GYRO.MaxTorque = VT(0,4000000,0)
		GYRO.CFrame = CF(ROOT.Position,MOUSE.Hit.p)
		GYRO.Parent = ROOT
		coroutine.resume(coroutine.create(function()
			repeat
				Swait()
				GYRO.CFrame = CF(ROOT.Position,MOUSE.Hit.p)
			until ATTACKING == false
			GYRO:Remove()
		end))
		for i=1, 12 do
			Swait()
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 0.5 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(25)), 0.5 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(25+i)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
			GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(90),RAD(0)), 0.5 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(25), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 0.5 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-65), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
		end
		for i=0, 0.1, 0.1 / ANIM_SPEED do
			Swait()
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 2.5 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(25)), 2.5 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
			GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(90),RAD(0)) * ANGLES(RAD(45),RAD(0),RAD(0)), 2.5 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(25), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 2.5 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-65), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
		end
		coroutine.resume(coroutine.create(function()
			NewSound({ID = 1,PARENT = HANDLE,VOLUME = 5,PITCH = MRANDOM(9,11)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			GRIP.Parent = nil
			KARAMBIT.Parent = Effects
			HANDLE.Anchored = true
			HANDLE.CFrame = CF(CF(HANDLE.Position)*ANGLES(0,RAD(ROOT.Orientation.Y),RAD(90)).p,MOUSEPOS)
			TRAIL.Enabled = true
			local CFR = CF(HANDLE.Position,MOUSEPOS)
			for i = 1, 64 do
				Swait()
				HANDLE.CFrame = CFR
				local FACE,POS = Raycast(CFR.p,CFR.lookVector,6,CHARACTER)
				local FLOOR = Raycast(CFR.p,CF(CFR.p,CFR.p-VT(0,1,0)).lookVector,0.2,CHARACTER)
				CFR = CFR*CF(0,-i/1200,-4.05)
				HANDLE.CFrame = CFR*ANGLES(0,0,RAD(90))*ANGLES(RAD(i*25),0,0)
				if FACE then
					DETECTKILL(FACE,POS,35)
					break
				elseif FLOOR then
					break
				end
			end
			for index, CHILD in pairs(KARAMBIT:GetChildren()) do
				CHILD.CanCollide = true
				CHILD.Velocity = VT(0,0,0)
			end
			TRAIL.Enabled = false
			HANDLE.Anchored = false
			KARAMBIT.Parent = workspace
			while true do
				Swait()
				if ((ROOT.Position-VT(0,2.5,0) - HANDLE.Position).Magnitude <= 3 or HANDLE.Parent ~= KARAMBIT or KARAMBIT.Parent ~= workspace) and ATTACKING == false then
					break
				end
			end
			ATTACKING = true
			ROOT.Anchored = true
			for i=0, 0.3, 0.1 / ANIM_SPEED do
				Swait()
				ROOT.CFrame = Clerp(ROOT.CFrame,CF(ROOT.Position,VT(HANDLE.Position.X,ROOT.Position.Y,HANDLE.Position.Z)),0.2)
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(0), RAD(-5)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
			end
			NewSound({ID = 1,PARENT = HANDLE,VOLUME = 5,PITCH = MRANDOM(9,11)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			HANDLE.Parent = KARAMBIT
			GRIP.Parent = RIGHTARM
			for index, CHILD in pairs(KARAMBIT:GetChildren()) do
				CHILD.CanCollide = false
			end
			for E = 1, #PARTS do
				PARTS[E][1].Parent = KARAMBIT
				PARTS[E][2].Parent = HANDLE
			end
			EQUIPPED = true
			KARAMBIT.Parent = CHARACTER
			for i=0, 0.15, 0.1 / ANIM_SPEED do
				Swait()
				ROOT.CFrame = Clerp(ROOT.CFrame,CF(ROOT.Position,VT(HANDLE.Position.X,ROOT.Position.Y,HANDLE.Position.Z)),0.2)
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(0), RAD(-5)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
			end
			ATTACKING = false
			ROOT.Anchored = false
		end))
		for i=0, 0.4, 0.1 / ANIM_SPEED do
			Swait()
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(65)), 2.5 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(-65)), 2.5 / ANIM_SPEED)
			RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(85), RAD(0), RAD(-70))*CF(0,-0.5,0) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(25), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 2.5 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(35), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2.5 / ANIM_SPEED)
		end
		ATTACKING = false
	end
end

--//====================================================\\--
--||                       WRAP
--\\====================================================//--

REMOTE.OnServerEvent:Connect(function(PLR,V1,V2)
	if PLR == PLAYER and SPIN == 0 then
		if ANIM ~= "Sit" then
			--if V1 == "MousePositionUpdate" then
				--MOUSEPOS = V2
			if V1 == "KeyUp" then
				KEYHOLD = false
			elseif V1 == "MouseUp" then
				MOUSEHOLD = false
			end
			if ATTACKING == false then
				if V1 == "MouseDown" then
					MOUSEHOLD = true
					Melee()
				elseif V1 == "KeyDown" then
					KEYHOLD = true
					if V2 == "q" then
						if HUM.WalkSpeed <= 25 then
							HUM.WalkSpeed = 32
						else
							HUM.WalkSpeed = 20
						end
					elseif V2 == "z" then
						Climb()
					elseif V2 == "x" then
						Throw()
					end
				end
			end
		end
		if V1 == "KeyDown" and V2 == "t" and ATTACKING == false and EQUIPPED == true then
			SPIN = 22
			NewSound({ID = 1,PARENT = HEAD,VOLUME = 1.2,PITCH = 0.8,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
		end
	end
end)

HUM.HealthChanged:Connect(function()
	HUM.PlatformStand = false
	HUM.MaxHealth = 3000
	HUM.Health = 3000
	HUM.Name = PLAYER.UserId
end)
HUM.PlatformStand = false
HUM.MaxHealth = 3000
HUM.Health = 3000
HUM.Name = PLAYER.UserId
script.Parent = PLAYER.Backpack
HUM.WalkSpeed = 20
while true do
	Swait()
	SINE = SINE + CHANGE
	if CHARACTER:FindFirstChild("Animate") then
		CHARACTER:FindFirstChild("Animate"):Destroy()
	end
	if CHARACTER:FindFirstChild("Sound") then
		CHARACTER:FindFirstChild("Sound"):Destroy()
	end
	for _,v in next, HUM:GetPlayingAnimationTracks() do
		v:Stop();
	end
	local TORSOVELOCITY = (ROOT.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = ROOT.Velocity.y
	local HITFLOOR = Raycast(ROOT.Position, (CF(ROOT.Position, ROOT.Position + VT(0, -1, 0))).lookVector, 4+HUM.HipHeight, CHARACTER)
	local WALKSPEEDVALUE = 5-(1*(HUM.WalkSpeed/16))
	local SITTING = HUM.Sit
	local ADD = HUM.WalkSpeed*2
	if ANIM == "Walk" and TORSOVELOCITY > 1 and ATTACKING == false and SITTING == false then
		ROOTJOINT.C1 = Clerp(ROOTJOINT.C1, ROOTC0 * CF(0, 0, -0.05 * COS(SINE / (WALKSPEEDVALUE / 2))) * ANGLES(RAD(0), RAD(0) - ROOT.RotVelocity.Y / 35, RAD(0)), 2 * (HUM.WalkSpeed / 16) / ANIM_SPEED)
		NECK.C1 = Clerp(NECK.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - HEAD.RotVelocity.Y / 30), 0.2 * (HUM.WalkSpeed / 16) / ANIM_SPEED)
		RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 0.875 - 0.3 * SIN(SINE / WALKSPEEDVALUE), -0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ -0.25 * SIN(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0) - RIGHTLEG.RotVelocity.Y / 35, RAD(0), RAD((35+ADD) * COS(SINE / WALKSPEEDVALUE))), 0.6 / ANIM_SPEED)
		LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 0.875 + 0.3 * SIN(SINE / WALKSPEEDVALUE), 0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ 0.25 * SIN(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0) + LEFTLEG.RotVelocity.Y / 35, RAD(0), RAD((35+ADD) * COS(SINE / WALKSPEEDVALUE))), 0.6 / ANIM_SPEED)
	elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) or ATTACKING == true or SITTING == true then
		ROOTJOINT.C1 = Clerp(ROOTJOINT.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		NECK.C1 = Clerp(NECK.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
		LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
	end
	if SITTING == false then
		if HITFLOOR then
			if TORSOVELOCITY < 1 and HITFLOOR ~= nil then
				ANIM = "Idle"
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
					if SPIN == 0 then
						if EQUIPPED == true then
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(15), RAD(15 - 2.5 * COS(SINE / 12))) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
						else
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(2.5 - 2.5 * COS(SINE / 12))) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
						end
						GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
					end
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-2.5 + 2.5 * COS(SINE / 12))) * LEFTSHOULDERC0, 0.5 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
				end
			elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
				ANIM = "Walk"
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.05) * ANGLES(RAD(HUM.WalkSpeed/2), RAD(0), RAD(15*COS(SINE / WALKSPEEDVALUE))), 0.25 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-HUM.WalkSpeed/2 - 2 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(-15*COS(SINE / WALKSPEEDVALUE))), 0.25 / ANIM_SPEED)
					if SPIN == 0 then
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD((8+(ADD*1.25)) * COS(SINE / WALKSPEEDVALUE)), RAD(0), RAD(-22 * COS(SINE / (WALKSPEEDVALUE/2)))) * RIGHTSHOULDERC0, 0.75 / ANIM_SPEED)
						GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
					end
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-(8+(ADD*1.25)) * COS(SINE / WALKSPEEDVALUE)), RAD(0), RAD(22 * COS(SINE / (WALKSPEEDVALUE/2)))) * LEFTSHOULDERC0, 0.75 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(90-15*COS(SINE / WALKSPEEDVALUE)), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(-15)), 0.25 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90-15*COS(SINE / WALKSPEEDVALUE)), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(15)), 0.25 / ANIM_SPEED)
				end
			end
		else
			if TORSOVERTICALVELOCITY > 0 then
				ANIM = "Jump"
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20), RAD(0), RAD(0)), 1 / ANIM_SPEED)
					if SPIN == 0 then
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-2), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1 / ANIM_SPEED)
						GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
					end
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-2), RAD(0), RAD(10)) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.4, -0.6) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-20)), 1 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 1 / ANIM_SPEED)
			    end
			else
				ANIM = "Fall"
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(20), RAD(0), RAD(0)), 1 / ANIM_SPEED)
					if SPIN == 0 then
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-2), RAD(0), RAD(60)) * RIGHTSHOULDERC0, 1 / ANIM_SPEED)
						GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
					end
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-2), RAD(0), RAD(-60)) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.5, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 1 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1 / ANIM_SPEED)
				end
			end
		end
	else
		ANIM = "Sit"
		if ATTACKING == false then
			ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.5) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
			NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
			if SPIN == 0 then
				if EQUIPPED == true then
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(15), RAD(10)) * RIGHTSHOULDERC0, 1.25 / ANIM_SPEED)
				else
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.65, 0) * ANGLES(RAD(50), RAD(10), RAD(-45))*CF(0,-0.25,0) * RIGHTSHOULDERC0, 1.25 / ANIM_SPEED)
				end
				GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
			end
			LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.65, 0) * ANGLES(RAD(50), RAD(-10), RAD(45))*CF(0,-0.25,0) * LEFTSHOULDERC0, 1.25 / ANIM_SPEED)
			RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.25, -1) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.25 / ANIM_SPEED)
			LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -0.25, -1) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.25 / ANIM_SPEED)
		end
	end
	if SPIN > 0 then
		RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0.2) * ANGLES(RAD(35+(SPIN/3)), RAD(15), RAD(-5)) * RIGHTSHOULDERC0, 1.25 / ANIM_SPEED)
		GRIP.C0 = Clerp(GRIP.C0,GC0 * CF(0,0,0) * ANGLES(RAD((22-SPIN)*16),RAD(0),RAD(0)), 2.5 / ANIM_SPEED)
		SPIN = SPIN - 1
	else
		SPIN = 0
	end
end
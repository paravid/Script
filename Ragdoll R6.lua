-- Ragdoll R6
-- Made By: Kanujinho
-- i lazy to make more fun scripts or converts. soo i made this
-- i recommend to use a reanimation like "Oxide" to make this FE

-- Enjoy!

local userInputService = game:GetService("UserInputService")
local ragdolled = false
local allowRagdollMovement = false
local spasmEnabled = false
local helicopterMode = false

local char = game.Players.LocalPlayer.Character
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local lastY = hrp.Position.Y
local falling = false
local fallStartY = nil

userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then

		if input.KeyCode == Enum.KeyCode.B then
			allowRagdollMovement = not allowRagdollMovement
		end

		if input.KeyCode == Enum.KeyCode.Space then
			if ragdolled and allowRagdollMovement then
				local hrp = char:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.Velocity = hrp.Velocity + Vector3.new(0, 45, 0)
				end
			end
		end

        if input.KeyCode == Enum.KeyCode.V then
            helicopterMode = not helicopterMode

            if helicopterMode then
                task.spawn(function()
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    while helicopterMode do
                        if hrp then
                            hrp.RotVelocity = Vector3.new(0, 45, 0)
                        end
                        task.wait(0.02)
                    end
                    if hrp then
                        hrp.RotVelocity = Vector3.new(0,0,0)
                    end
                end)
            end
        end

        if input.KeyCode == Enum.KeyCode.Z then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                task.spawn(function()
                    for i = 1, 10 do
                        hrp.RotVelocity = Vector3.new(20, 0, 0)
                        hrp.Velocity = hrp.Velocity + hrp.CFrame.LookVector * 3
                        task.wait(0.03)
                    end
                end)
            end
        end

        if input.KeyCode == Enum.KeyCode.X then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                task.spawn(function()
                    for i = 1, 10 do
                        hrp.RotVelocity = Vector3.new(-20, 0, 0)
                        hrp.Velocity = hrp.Velocity - hrp.CFrame.LookVector * 3
                        task.wait(0.03)
                    end
                end)
            end
        end

        if input.KeyCode == Enum.KeyCode.C then
            spasmEnabled = not spasmEnabled

            if spasmEnabled then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                task.spawn(function()
                    while spasmEnabled do
                        if hrp then
                            hrp.RotVelocity = Vector3.new(
                                math.random(-35,35),
                                math.random(-35,35),
                                math.random(-35,35)
                            )
                        end
                        task.wait(0.02)
                    end
                    if hrp then
                        hrp.RotVelocity = Vector3.new(0,0,0)
                    end
                end)
            end
        end

		if input.KeyCode == Enum.KeyCode.R then
			ragdolled = not ragdolled

			if ragdolled then
				local char = game.Players.LocalPlayer.Character
				char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

				char.Torso["Right Hip"].Parent = game.ReplicatedStorage
				char.Torso["Left Hip"].Parent = game.ReplicatedStorage
				char.Torso["Left Shoulder"].Parent = game.ReplicatedStorage
				char.Torso["Right Shoulder"].Parent = game.ReplicatedStorage

				char["Left Arm"].Part.CanCollide = true
				char["Right Arm"].Part.CanCollide = true
				char["Left Leg"].Part.CanCollide = true
				char["Right Leg"].Part.CanCollide = true

				char.Humanoid.Sit = false
				char.Humanoid.PlatformStand = true

			else
				local char = game.Players.LocalPlayer.Character
				char.Humanoid.Sit = false

				game.ReplicatedStorage["Right Hip"].Parent = char.Torso
				game.ReplicatedStorage["Left Hip"].Parent = char.Torso
				game.ReplicatedStorage["Left Shoulder"].Parent = char.Torso
				game.ReplicatedStorage["Right Shoulder"].Parent = char.Torso

				char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
				wait()
				char.Humanoid.Sit = false
				wait()

				local hrp = char:WaitForChild("HumanoidRootPart")
				hrp.Velocity = Vector3.new(0,0,0)
				hrp.RotVelocity = Vector3.new(0,0,0)
				hrp.CFrame = CFrame.new(hrp.Position)

				char.Humanoid.PlatformStand = false

				char["Left Arm"].Part.CanCollide = false
				wait()
				char["Right Arm"].Part.CanCollide = false
				wait()
				char["Left Leg"].Part.CanCollide = false
				wait()
				char["Right Leg"].Part.CanCollide = false
			end
		end
	end
end)


local part = Instance.new("Part", game.Players.LocalPlayer.Character)
part.Transparency = 1
part.Size = Vector3.new(1, 1, 1)
part.CanCollide = true
local w1 = Instance.new("Weld", part)
w1.Part0 = game.Players.LocalPlayer.Character["Left Arm"]
w1.Part1 = part
w1.C1 = CFrame.new(0,0,0)
wait(0.1)
game.Players.LocalPlayer.Character.Part.Parent = game.Players.LocalPlayer.Character["Left Arm"]
wait()

local part = Instance.new("Part", game.Players.LocalPlayer.Character)
part.Transparency = 1
part.Size = Vector3.new(1, 1, 1)
part.CanCollide = true
local w1 = Instance.new("Weld", part)
w1.Part0 = game.Players.LocalPlayer.Character["Right Arm"]
w1.Part1 = part
w1.C1 = CFrame.new(0,0,0)
wait(0.1)
game.Players.LocalPlayer.Character.Part.Parent = game.Players.LocalPlayer.Character["Right Arm"]
wait()

local part = Instance.new("Part", game.Players.LocalPlayer.Character)
part.Transparency = 1
part.Size = Vector3.new(1, 1, 1)
part.CanCollide = true
local w1 = Instance.new("Weld", part)
w1.Part0 = game.Players.LocalPlayer.Character["Left Leg"]
w1.Part1 = part
w1.C1 = CFrame.new(0,0,0)
wait(0.1)
game.Players.LocalPlayer.Character.Part.Parent = game.Players.LocalPlayer.Character["Left Leg"]
wait()

local part = Instance.new("Part", game.Players.LocalPlayer.Character)
part.Transparency = 1
part.Size = Vector3.new(1, 1, 1)
part.CanCollide = true
local w1 = Instance.new("Weld", part)
w1.Part0 = game.Players.LocalPlayer.Character["Right Leg"]
w1.Part1 = part
w1.C1 = CFrame.new(0,0,0)
wait(0.1)
game.Players.LocalPlayer.Character.Part.Parent = game.Players.LocalPlayer.Character["Right Leg"]

game:GetService("UserInputService").InputBegan:connect(onKeyPress)
LocalPlayer = game:GetService("Players").LocalPlayer
function Iterate(instance, func)
	for i, v in next, instance:GetChildren() do
		func(v)
	end
end

limbs = {
	["Right Leg"] = true;
	["Right Arm"] = true;
	["Left Leg"] = true;
	["Left Arm"] = true;
}

Iterate(LocalPlayer.Character, function(v)
	if v:IsA("BasePart") then
		local attachment = Instance.new("Attachment")
		attachment.Parent = v
		attachment.Name = (v.Name .. "[Attachment]")
		if limbs[v.Name] then
			attachment.Position = Vector3.new(0, v.Size.Y/2, 0)
		elseif v.Name == "Head" then
			attachment.Position = Vector3.new(0, -v.Size.Y/2, 0)
			attachment.Rotation = Vector3.new(0, 0, -90)
		end
	end
end)

local leftLegAttachment = Instance.new("Attachment")
leftLegAttachment.Position = Vector3.new(-.5, -1, 0)
leftLegAttachment.Rotation = Vector3.new(0, -90, 0)
local rightLegAttachment = Instance.new("Attachment")
rightLegAttachment.Position = Vector3.new(.5, -1, 0)
rightLegAttachment.Rotation = Vector3.new(0, -90, 0)
rightLegAttachment.Parent, leftLegAttachment.Parent = LocalPlayer.Character.Torso, LocalPlayer.Character.Torso

jointAttachments = {
	['Head'] = { ['Attachment0'] = LocalPlayer.Character.Torso['NeckAttachment']; ['Attachment1'] = LocalPlayer.Character.Head['Head[Attachment]']; };
	['Left Arm'] = { ['Attachment0'] = LocalPlayer.Character.Torso['LeftCollarAttachment']; ['Attachment1'] = LocalPlayer.Character['Left Arm']['Left Arm[Attachment]']; };
	['Right Arm'] = { ['Attachment0'] = LocalPlayer.Character.Torso['RightCollarAttachment']; ['Attachment1'] = LocalPlayer.Character['Right Arm']['Right Arm[Attachment]']; };
	['Left Leg'] = { ['Attachment0'] = leftLegAttachment; ['Attachment1'] = LocalPlayer.Character['Left Leg']['Left Leg[Attachment]']; };
	['Right Leg'] = { ['Attachment0'] = rightLegAttachment; ['Attachment1'] = LocalPlayer.Character['Right Leg']['Right Leg[Attachment]']; };
}

LocalPlayer.Character.Humanoid.PlatformStand = true

Iterate(LocalPlayer.Character, function(v)
	if v:IsA("BasePart") then
		if jointAttachments[v.Name] then
			local ballSocketJoint = Instance.new("BallSocketConstraint")
			ballSocketJoint.Parent = v
			ballSocketJoint.Radius = 0.15
			ballSocketJoint.Attachment0, ballSocketJoint.Attachment1 = jointAttachments[v.Name]['Attachment0'], jointAttachments[v.Name]['Attachment1']

			local spring = Instance.new("SpringConstraint")
			spring.Parent = v
			spring.Attachment0 = jointAttachments[v.Name]['Attachment0']
			spring.Attachment1 = jointAttachments[v.Name]['Attachment1']
			spring.Stiffness = 180
			spring.Damping = 25
		end
	end
end)


game:GetService("RunService").Heartbeat:Connect(function()
	local newY = hrp.Position.Y

	if newY < lastY - 0.4 and hum.FloorMaterial == Enum.Material.Air then
		if not falling then
			falling = true
			fallStartY = newY
		end
	end

	if falling and hum.FloorMaterial ~= Enum.Material.Air then
		local fallDistance = fallStartY - newY

		if fallDistance > 18 then
			ragdolled = true
		elseif fallDistance > 10 then
			if not ragdolled then
				hrp.CFrame = hrp.CFrame * CFrame.Angles(math.rad(28),0,math.rad(9))
				task.spawn(function()
					wait(0.35)
					hrp.CFrame = CFrame.new(hrp.Position)
				end)
			end
		end

		falling = false
		fallStartY = nil
	end

	lastY = newY

	if ragdolled and allowRagdollMovement then
		local dir = hum.MoveDirection
		hrp.Velocity = Vector3.new(dir.X * 18, hrp.Velocity.Y, dir.Z * 18)
	end
end)
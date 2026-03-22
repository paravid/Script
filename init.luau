-- :: Services

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- :: Variables

local Signals: {RBXScriptSignal} = {}
local LocalPlayer = Players.LocalPlayer
local Mouse: Mouse = LocalPlayer:GetMouse()

local Main
local CMDMain
local CMDDescription
local CMDTextDescription

local CMDListScrollFrame
local CommandsFolder
local ExampleCommand

local Resizer
local ListDrag
local CMDList_1
local CMDSearchBar
local SearchIcon
local SearchInput
local CMDCloseGui

local Drag_1
local ExecutionBarInput
local OpenButton
local CloseGui

local Dragging = false

local AddCommand,DescriptionStepped,HoveredCommand
local Commands; Commands = {
	[{"commands","cmds"}] = {
		Arguments = {},
		Description = "Opens the command list.",
		Function = function()
			CMDMain.Visible = true
		end,
	},
}

local GuiParent = gethui and gethui() or pcall(game.GetService, game, "CoreGui") and game.CoreGui or LocalPlayer:WaitForChild("PlayerGui")
local Music = GuiParent:FindFirstChild("freesmart.xyz_songs") or Instance.new("Sound", GuiParent)
Music.Looped = true
Music:Stop()
Music.SoundId = ""
Music.Name = "freesmart.xyz_songs"
local ExecutionCentre = Instance.new("ScreenGui"); do
	ExecutionCentre.Name = "ExecutionCentre"
	ExecutionCentre.ResetOnSpawn = false

	if GuiParent:FindFirstChild("ExecutionCentre") then
		GuiParent:FindFirstChild("ExecutionCentre"):Destroy()
	end

	Main = Instance.new("Frame"); do
		Main.BackgroundColor3 = Color3.fromRGB(44,44,44)
		Main.Name = "ExecutionCentreMain"
		Main.Position = UDim2.new(0,225,0,309)
		Main.Size = UDim2.new(0,320,0,83)
		Main.Visible = false

		local ExecMainCorner = Instance.new("UICorner"); do
			ExecMainCorner.CornerRadius = UDim.new(0,4)
			ExecMainCorner.Name = "ExecMainCorner"
			ExecMainCorner.Parent = Main
		end

		local Title = Instance.new("TextLabel"); do
			Title.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Title.BackgroundTransparency = 1
			Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular ,Enum.FontStyle.Normal)
			Title.FontSize = Enum.FontSize.Size18
			Title.Name = "Title"
			Title.Position = UDim2.new(0.037,0,0.05,0)
			Title.Size = UDim2.new(0,200,0,26)
			Title.Text = "freesmart.xyz, v1.2.1"
			Title.TextColor3 = Color3.fromRGB(231,231,231)
			Title.TextSize = 16
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.Parent = Main
		end

		local MainStroke = Instance.new("UIStroke"); do
			MainStroke.Color = Color3.fromRGB(15,15,15)
			MainStroke.Name = "MainStroke"
			MainStroke.Transparency = 0.75
			MainStroke.Parent = Main
		end

		local ExecutionBar = Instance.new("Frame"); do
			ExecutionBar.BackgroundColor3 = Color3.fromRGB(40,40,40)
			ExecutionBar.Name = "ExecutionBar"
			ExecutionBar.Position = UDim2.new(0.0313,0,0.443,0)
			ExecutionBar.Size = UDim2.new(0,299,0,37)

			local ExecutionBarCorner = Instance.new("UICorner"); do
				ExecutionBarCorner.CornerRadius = UDim.new(0,4)
				ExecutionBarCorner.Name = "ExecutionBarCorner"
				ExecutionBarCorner.Parent = ExecutionBar
			end

			local ExecutionBarStroke = Instance.new("UIStroke"); do
				ExecutionBarStroke.Color = Color3.fromRGB(20,20,20)
				ExecutionBarStroke.Name = "ExecutionBarStroke"
				ExecutionBarStroke.Parent = ExecutionBar
			end

			ExecutionBarInput = Instance.new("TextBox"); do
				ExecutionBarInput.BackgroundColor3 = Color3.fromRGB(255,255,255)
				ExecutionBarInput.BackgroundTransparency = 1
				ExecutionBarInput.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular ,Enum.FontStyle.Normal)
				ExecutionBarInput.FontSize = Enum.FontSize.Size14
				ExecutionBarInput.Name = "ExecutionBarInput"
				ExecutionBarInput.PlaceholderText = "Input here. Prefix: ;"
				ExecutionBarInput.Position = UDim2.new(0.1642,0,0.1892,0)
				ExecutionBarInput.Size = UDim2.new(0,222,0,23)
				ExecutionBarInput.Text = ""
				ExecutionBarInput.TextColor3 = Color3.fromRGB(216,216,216)
				ExecutionBarInput.TextSize = 14
				ExecutionBarInput.TextXAlignment = Enum.TextXAlignment.Left
				ExecutionBarInput.Parent = ExecutionBar
			end

			local ExecutionBarIcon = Instance.new("ImageLabel"); do
				ExecutionBarIcon.BackgroundColor3 = Color3.fromRGB(255,255,255)
				ExecutionBarIcon.BackgroundTransparency = 1
				ExecutionBarIcon.Image = "rbxasset://textures/PluginManagement/back.png"
				ExecutionBarIcon.Name = "ExecutionBarIcon"
				ExecutionBarIcon.Position = UDim2.new(0.036,0,0.135,0)
				ExecutionBarIcon.Rotation = 180
				ExecutionBarIcon.Size = UDim2.new(0,27,0,27)
				ExecutionBarIcon.Parent = ExecutionBar
			end
			ExecutionBar.Parent = Main
		end

		local Shadow = Instance.new("ImageLabel"); do
			Shadow.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Shadow.BackgroundTransparency = 1
			Shadow.Image = "rbxasset://textures/StudioUIEditor/resizeHandleDropShadow.png"
			Shadow.ImageColor3 = Color3.fromRGB(0,0,0)
			Shadow.ImageTransparency = 0.4
			Shadow.Name = "Shadow"
			Shadow.Position = UDim2.new(-0.18,0,-0.262,0)
			Shadow.Size = UDim2.new(0,443,0,129)
			Shadow.Visible = false
			Shadowandex = -1
			Shadow.Parent = Main
		end

		CloseGui = Instance.new("ImageButton"); do
			CloseGui.BackgroundColor3 = Color3.fromRGB(255,255,255)
			CloseGui.BackgroundTransparency = 1
			CloseGui.Image = "rbxasset://textures/DeveloperFramework/AssetPreview/close_button.png"
			CloseGui.Name = "CloseGui"
			CloseGui.Position = UDim2.new(0.9052,0,0.0891,0)
			CloseGui.Size = UDim2.new(0,19,0,19)
			CloseGui.Parent = Main
		end

		local TopBarApp = Instance.new("ScreenGui"); do
			--TopBarApp.AutoLocalize = false
			TopBarApp.DisplayOrder = 6
			TopBarApp.IgnoreGuiInset = true
			TopBarApp.ResetOnSpawn = false
			TopBarApp.Name = "TopBarApp"

			local TopBarFrame = Instance.new("Frame"); do
				TopBarFrame.BackgroundTransparency = 1
				TopBarFrame.Name = "TopBarFrame"
				TopBarFrame.Position = UDim2.new(0,0,0,-36)
				TopBarFrame.Size = UDim2.new(1,0,0,36)

				local RightFrame = Instance.new("Frame"); do
					RightFrame.AnchorPoint = Vector2.new(1,0)
					RightFrame.BackgroundTransparency = 1
					RightFrame.Name = "RightFrame"
					RightFrame.Position = UDim2.new(1,-16,0,0)
					RightFrame.Size = UDim2.new(1,-16,1,0)

					local MoreMenu = Instance.new("Frame"); do
						MoreMenu.BackgroundTransparency = 1
						MoreMenu.LayoutOrder = 2
						MoreMenu.Name = "MoreMenu"
						MoreMenu.Size = UDim2.new(0,32,1,0)

						OpenButton = Instance.new("ImageButton"); do
							OpenButton.AnchorPoint = Vector2.new(0,1)
							OpenButton.BackgroundTransparency = 1
							OpenButton.Image = "rbxasset://textures/ui/TopBar/iconBase.png"
							OpenButton.Name = "OpenButton"
							OpenButton.Position = UDim2.new(0,-40,1,0)
							OpenButton.Size = UDim2.new(0,32,0,32)
							OpenButton.Visible = true

							local Icon = Instance.new("ImageLabel"); do
								Icon.AnchorPoint = Vector2.new(0.5,0.5)
								Icon.BackgroundTransparency = 1
								Icon.Image = "rbxasset://textures/ui/InspectMenu/ico_alert_tilt@3x.png"
								Icon.Name = "Icon"
								Icon.Position = UDim2.new(0.5,0,0.5,0)
								Icon.Size = UDim2.new(0,24,0,24)
								Icon.Parent = OpenButton
							end

							local StateOverlay = Instance.new("ImageLabel"); do
								StateOverlay.BackgroundTransparency = 1
								StateOverlay.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_2x_10.png"
								StateOverlay.ImageRectOffset = Vector2.new(460,260)
								StateOverlay.ImageRectSize = Vector2.new(34,34)
								StateOverlay.ImageTransparency = 1
								StateOverlay.Name = "StateOverlay"
								StateOverlay.ScaleType = Enum.ScaleType.Slice
								StateOverlay.Size = UDim2.new(1,0,1,0)
								StateOverlay.SliceCenter = Rect.new(16,16,16,16)
								StateOverlay.SliceScale = 0.5
								StateOverlay.ZIndex = 2
								StateOverlay.Parent = OpenButton
							end
							OpenButton.Parent = MoreMenu
						end
						MoreMenu.Parent = RightFrame
					end

					local Layout = Instance.new("UIListLayout"); do
						Layout.FillDirection = Enum.FillDirection.Horizontal
						Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
						Layout.Name = "Layout"
						Layout.Padding = UDim.new(0,12)
						Layout.SortOrder = Enum.SortOrder.LayoutOrder
						Layout.VerticalAlignment = Enum.VerticalAlignment.Center
						Layout.Parent = RightFrame
					end
					RightFrame.Parent = TopBarFrame
				end
				TopBarFrame.Parent = ExecutionCentre
			end
			TopBarApp.Parent = Main
		end

		local CMDList = Instance.new("ScreenGui"); do
			CMDList.Name = "CMDList"
			CMDList.ResetOnSpawn = false

			CMDMain = Instance.new("Frame"); do
				CMDMain.BackgroundColor3 = Color3.fromRGB(44,44,44)
				CMDMain.ClipsDescendants = true
				CMDMain.Visible = false
				CMDMain.Name = "CMDMain"
				CMDMain.Position = UDim2.new(0.1152,0,0.4395,0)
				CMDMain.Size = UDim2.new(0,320,0,320)

				local CMDMainCorner = Instance.new("UICorner"); do
					CMDMainCorner.CornerRadius = UDim.new(0,4)
					CMDMainCorner.Name = "CMDMainCorner"
					CMDMainCorner.Parent = CMDMain
				end

				local CMDTitle = Instance.new("TextLabel"); do
					CMDTitle.BackgroundColor3 = Color3.fromRGB(255,255,255)
					CMDTitle.BackgroundTransparency = 1
					CMDTitle.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular ,Enum.FontStyle.Normal)
					CMDTitle.FontSize = Enum.FontSize.Size18
					CMDTitle.Name = "CMDTitle"
					CMDTitle.Position = UDim2.new(0,12,0,6)
					CMDTitle.Size = UDim2.new(0,200,0,26)
					CMDTitle.Text = "Commands"
					CMDTitle.TextColor3 = Color3.fromRGB(231,231,231)
					CMDTitle.TextSize = 16
					CMDTitle.TextXAlignment = Enum.TextXAlignment.Left
					CMDTitle.Parent = CMDMain
				end

				local CMDMainStroke = Instance.new("UIStroke"); do
					CMDMainStroke.Color = Color3.fromRGB(15,15,15)
					CMDMainStroke.Name = "CMDMainStroke"
					CMDMainStroke.Transparency = 0.75
					CMDMainStroke.Parent = CMDMain
				end

				CMDList_1 = Instance.new("Frame"); do
					CMDList_1.BackgroundColor3 = Color3.fromRGB(40,40,40)
					CMDList_1.ClipsDescendants = true
					CMDList_1.Name = "CMDList"
					CMDList_1.Position = UDim2.new(0,10,0,39)
					CMDList_1.Size = UDim2.new(0,300,0,205)
					CMDList_1.ZIndex = 2

					local CMDListCorner = Instance.new("UICorner"); do
						CMDListCorner.CornerRadius = UDim.new(0,4)
						CMDListCorner.Name = "CMDListCorner"
						CMDListCorner.Parent = CMDList_1
					end

					CMDListScrollFrame = Instance.new("ScrollingFrame"); do
						CMDListScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
						CMDListScrollFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
						CMDListScrollFrame.BackgroundTransparency = 1
						CMDListScrollFrame.BorderSizePixel = 0
						CMDListScrollFrame.CanvasSize = UDim2.new(0,0,0,0)
						CMDListScrollFrame.Name = "CMDListScrollFrame"
						CMDListScrollFrame.Position = UDim2.new(0.0338,0,0.036,0)
						CMDListScrollFrame.ScrollBarThickness = 2
						CMDListScrollFrame.Size = UDim2.new(0,279,0,175)
						CMDListScrollFrame.ZIndex = 2

						CommandsFolder = Instance.new("Folder"); do
							CommandsFolder.Name = "CommandsFolder"

							local CommandListLayout = Instance.new("UIListLayout"); do
								CommandListLayout.Name = "CommandListLayout"
								CommandListLayout.Padding = UDim.new(0,5)
								CommandListLayout.Parent = CommandsFolder
							end

							ExampleCommand = Instance.new("TextLabel"); do
								ExampleCommand.BackgroundColor3 = Color3.fromRGB(255,255,255)
								ExampleCommand.BackgroundTransparency = 1
								ExampleCommand.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular ,Enum.FontStyle.Normal)
								ExampleCommand.FontSize = Enum.FontSize.Size14
								ExampleCommand.Name = "Command"
								ExampleCommand.Size = UDim2.new(0,259,0,17)
								ExampleCommand.Text = "• Label"
								ExampleCommand.TextColor3 = Color3.fromRGB(231,231,231)
								ExampleCommand.TextSize = 14
								ExampleCommand.TextXAlignment = Enum.TextXAlignment.Left
								ExampleCommand.Visible = false
								ExampleCommand.ZIndex = 2
								ExampleCommand.Parent = CommandsFolder
							end
							CommandsFolder.Parent = CMDListScrollFrame
						end
						CMDListScrollFrame.Parent = CMDList_1
					end

					local CMDListStroke = Instance.new("UIStroke"); do
						CMDListStroke.Color = Color3.fromRGB(20,20,20)
						CMDListStroke.Name = "CMDListStroke"
						CMDListStroke.Parent = CMDList_1
					end
					CMDList_1.Parent = CMDMain
				end

				CMDSearchBar = Instance.new("Frame"); do
					CMDSearchBar.BackgroundColor3 = Color3.fromRGB(40,40,40)
					CMDSearchBar.Name = "CMDSearchBar"
					CMDSearchBar.Position = UDim2.new(0,10,0,253)
					CMDSearchBar.Size = UDim2.new(0,299,0,37)

					local SearchBarCorner = Instance.new("UICorner"); do
						SearchBarCorner.CornerRadius = UDim.new(0,4)
						SearchBarCorner.Name = "SearchBarCorner"
						SearchBarCorner.Parent = CMDSearchBar
					end

					local SearchBarStroke = Instance.new("UIStroke"); do
						SearchBarStroke.Color = Color3.fromRGB(20,20,20)
						SearchBarStroke.Name = "SearchBarStroke"
						SearchBarStroke.Parent = CMDSearchBar
					end

					SearchInput = Instance.new("TextBox"); do
						SearchInput.BackgroundColor3 = Color3.fromRGB(255,255,255)
						SearchInput.BackgroundTransparency = 1
						SearchInput.ClearTextOnFocus = false
						SearchInput.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular ,Enum.FontStyle.Normal)
						SearchInput.FontSize = Enum.FontSize.Size14
						SearchInput.Name = "SearchInput"
						SearchInput.PlaceholderText = "Search.. (not working rn too lazy)"
						SearchInput.Position = UDim2.new(0.1642,0,0.1892,0)
						SearchInput.Size = UDim2.new(0,222,0,23)
						SearchInput.Text = ""
						SearchInput.TextColor3 = Color3.fromRGB(216,216,216)
						SearchInput.TextSize = 14
						SearchInput.TextXAlignment = Enum.TextXAlignment.Left
						SearchInput.Parent = CMDSearchBar
					end

					SearchIcon = Instance.new("ImageLabel"); do
						SearchIcon.BackgroundColor3 = Color3.fromRGB(255,255,255)
						SearchIcon.BackgroundTransparency = 1
						SearchIcon.Image = "rbxasset://textures/AnimationEditor/button_search.png"
						SearchIcon.Name = "SearchIcon"
						SearchIcon.Position = UDim2.new(0.036,0,0.135,0)
						SearchIcon.Size = UDim2.new(0,27,0,27)
						SearchIcon.Parent = CMDSearchBar
					end
					CMDSearchBar.Parent = CMDMain
				end

				CMDCloseGui = Instance.new("ImageButton"); do
					CMDCloseGui.BackgroundColor3 = Color3.fromRGB(255,255,255)
					CMDCloseGui.BackgroundTransparency = 1
					CMDCloseGui.Image = "rbxasset://textures/DeveloperFramework/AssetPreview/close_button.png"
					CMDCloseGui.Name = "CMDCloseGui"
					CMDCloseGui.Position = UDim2.new(0,289,0,9)
					CMDCloseGui.Size = UDim2.new(0,19,0,19)
					CMDCloseGui.Parent = CMDMain
				end

				local CMDCredits = Instance.new("TextLabel"); do
					CMDCredits.AnchorPoint = Vector2.new(0.5,1)
					CMDCredits.BackgroundColor3 = Color3.fromRGB(255,255,255)
					CMDCredits.BackgroundTransparency = 1
					CMDCredits.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular ,Enum.FontStyle.Normal)
					CMDCredits.FontSize = Enum.FontSize.Size12
					CMDCredits.Name = "CMDCredits"
					CMDCredits.Position = UDim2.new(0.5,4,1,-5)
					CMDCredits.Size = UDim2.new(0,294,0,14)
					CMDCredits.Text = "made by timedmarch and gelatekforever"
					CMDCredits.TextColor3 = Color3.fromRGB(143, 142, 142)
					CMDCredits.TextSize = 12
					CMDCredits.TextXAlignment = Enum.TextXAlignment.Left
					CMDCredits.TextYAlignment = Enum.TextYAlignment.Top
					CMDCredits.Parent = CMDMain
				end

				Resizer = Instance.new("Frame"); do
					Resizer.AnchorPoint = Vector2.new(0,1)
					Resizer.BackgroundColor3 = Color3.fromRGB(255,255,255)
					Resizer.BackgroundTransparency = 1
					Resizer.Name = "Resizer"
					Resizer.Position = UDim2.new(0,0,1,0)
					Resizer.Size = UDim2.new(1,0,0,5)
					Resizer.ZIndex = 5
					Resizer.Parent = CMDMain
				end

				local CMDShadow = Instance.new("ImageLabel"); do
					CMDShadow.AnchorPoint = Vector2.new(0.5,0.5)
					CMDShadow.BackgroundColor3 = Color3.fromRGB(255,255,255)
					CMDShadow.BackgroundTransparency = 1
					CMDShadow.Image = "rbxasset://textures/StudioUIEditor/resizeHandleDropShadow.png"
					CMDShadow.ImageColor3 = Color3.fromRGB(0,0,0)
					CMDShadow.ImageTransparency = 0.4
					CMDShadow.Name = "CMDShadow"
					CMDShadow.Position = UDim2.new(0.5,0,0.5,0)
					CMDShadow.Size = UDim2.new(1.4,7,1.4,0)
					CMDShadow.Visible = false
					CMDShadow.ZIndex = -1
					CMDShadow.Parent = CMDMain
				end

				ListDrag = Instance.new("Frame"); do
					ListDrag.BackgroundColor3 = Color3.fromRGB(255,255,255)
					ListDrag.BackgroundTransparency = 1
					ListDrag.Name = "Drag"
					ListDrag.Size = UDim2.new(0,318,0,30)
					ListDrag.Parent = CMDMain
				end
				CMDMain.Parent = ExecutionCentre
			end

			CMDDescription = Instance.new("Frame"); do
				CMDDescription.BackgroundColor3 = Color3.fromRGB(44,44,44)
				CMDDescription.Name = "CMDDescription"
				CMDDescription.Position = UDim2.new(0.1158,0,0.4706,0)
				CMDDescription.Size = UDim2.new(0,215,0,22)
				CMDDescription.Visible = false
				CMDDescription.ZIndex = 3

				local CMDDescriptionCorner = Instance.new("UICorner"); do
					CMDDescriptionCorner.CornerRadius = UDim.new(0,4)
					CMDDescriptionCorner.Name = "CMDDescriptionCorner"
					CMDDescriptionCorner.Parent = CMDDescription
				end

				local CMDDescriptionStroke = Instance.new("UIStroke"); do
					CMDDescriptionStroke.Color = Color3.fromRGB(15,15,15)
					CMDDescriptionStroke.Name = "CMDDescriptionStroke"
					CMDDescriptionStroke.Parent = CMDDescription
				end

				CMDTextDescription = Instance.new("TextLabel"); do
					CMDTextDescription.BackgroundColor3 = Color3.fromRGB(255,255,255)
					CMDTextDescription.BackgroundTransparency = 1
					CMDTextDescription.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular ,Enum.FontStyle.Normal)
					CMDTextDescription.FontSize = Enum.FontSize.Size14
					CMDTextDescription.Name = "CMDTextDescription"
					CMDTextDescription.Position = UDim2.new(0.0359,0,0,0)
					CMDTextDescription.Size = UDim2.new(0.9641,0,0.8636,0)
					CMDTextDescription.Text = "Executes script on client."
					CMDTextDescription.TextColor3 = Color3.fromRGB(188,188,188)
					CMDTextDescription.TextScaled = true
					CMDTextDescription.TextSize = 14
					CMDTextDescription.TextWrap = true
					CMDTextDescription.TextWrapped = true
					CMDTextDescription.TextXAlignment = Enum.TextXAlignment.Left
					CMDTextDescription.ZIndex = 3

					local UITextSizeConstraint = Instance.new("UITextSizeConstraint"); do
						UITextSizeConstraint.MaxTextSize = 13
						UITextSizeConstraint.Parent = CMDTextDescription
					end
					CMDTextDescription.Parent = CMDDescription
				end
				CMDDescription.Parent = ExecutionCentre
			end
			CMDList.Parent = Main
		end

		Drag_1 = Instance.new("Frame"); do
			Drag_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Drag_1.BackgroundTransparency = 1
			Drag_1.Name = "Drag"
			Drag_1.Size = UDim2.new(0,318,0,30)
			Drag_1.Parent = Main
		end

		Main.Parent = ExecutionCentre
	end
	ExecutionCentre.Parent = GuiParent
end

-- :: Functions

local function ExecuteCommand(Text)
	local Arguments = string.split(Text," ")
	local Command = Arguments[1]; table.remove(Arguments,1)

	for i,v in pairs(Commands) do
		if table.find(i,string.lower(Command)) then
			v.Function(Arguments)
		end
	end
end

AddCommand = function(name,arguments,description,func,addtotable)
	if addtotable then
		Commands[{name}] = {
			Arguments = unpack(arguments),
			Description = description,
			Function = func
		}
	end

	local CommandLabel = ExampleCommand:Clone(); do
		local Arguments = ""; do
			for _,v in pairs(arguments) do
				Arguments ..= " <" .. v .. "> "
			end
		end

		CommandLabel.Text = "• " .. name .. Arguments
		CommandLabel.Name = name
		CommandLabel.Visible = true
		CommandLabel.Parent = CommandsFolder

		CommandLabel.MouseEnter:Connect(function()
			if DescriptionStepped then DescriptionStepped:Disconnect() end
			if HoveredCommand == CommandLabel then return end

			HoveredCommand = CommandLabel
			CMDDescription.Visible = true

			CMDTextDescription.Text = description

			DescriptionStepped = RunService.RenderStepped:Connect(function()
				local MousePosition = UserInputService:GetMouseLocation()

				CMDDescription.Position = UDim2.new(0,MousePosition.X+11,0,MousePosition.Y-25)
			end)
		end)

		CommandLabel.MouseLeave:Connect(function()
			if HoveredCommand ~= CommandLabel then return end
			if DescriptionStepped then DescriptionStepped:Disconnect() end

			CMDDescription.Visible = false
			HoveredCommand = nil
		end)
	end
end

-- :: Code

do -- // CmdList
	Resizer.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch and not Dragging then
			local OriginalSize = CMDMain.Size
			local MousePosition = UserInputService:GetMouseLocation()
			local RenderStepped
			Dragging = true
			Mouse.Icon = "rbxasset://textures/Cursors/mouseIconCameraTrack.png"

			SearchIcon.Active = false
			SearchInput.Active = false
			CMDCloseGui.Active = false

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					RenderStepped:Disconnect()
					Mouse.Icon = ""
					Dragging = false
					SearchIcon.Active = true
					SearchInput.Active = true
					CMDCloseGui.Active = true
				end
			end)

			RenderStepped = RunService.RenderStepped:Connect(function(Alpha)
				local delta = (MousePosition - UserInputService:GetMouseLocation())
				local yGoal = (OriginalSize.Y.Offset - delta.Y)
				yGoal = yGoal <= 50 and 50 or yGoal > 320 and 320 or yGoal

				CMDMain.Size = UDim2.new(0,320,0,yGoal)
				Mouse.Icon = "rbxasset://textures/Cursors/mouseIconCameraTrack.png"

				CMDSearchBar.Visible = yGoal >= 310
				CMDList_1.Visible = yGoal >= 51
				CMDList_1.Size = yGoal >= 310 and UDim2.new(0,300,0,205) or UDim2.new(0,300,0,240)
			end)
		end
	end)

	ListDrag.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch and not Dragging then
			local OriginalPosition = CMDMain.AbsolutePosition
			local MousePosition = UserInputService:GetMouseLocation()
			local RenderStepped
			Dragging = true
			Mouse.Icon = "rbxasset://textures/Cursors/mouseIconCameraTrack.png"

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					RenderStepped:Disconnect()
					Mouse.Icon = ""
					Dragging = false
				end
			end)

			RenderStepped = RunService.RenderStepped:Connect(function(Alpha)
				local delta = (MousePosition - UserInputService:GetMouseLocation())

				CMDMain.Position = UDim2.new(0,(OriginalPosition.X - delta.X),0,(OriginalPosition.Y - delta.Y))
				Mouse.Icon = "rbxasset://textures/Cursors/mouseIconCameraTrack.png"
			end)
		end
	end)

	Resizer.MouseEnter:Connect(function()
		if Dragging then return end
		Mouse.Icon = "rbxasset://textures/Cursors/mouseIconCameraTrack.png"
	end)

	Resizer.MouseLeave:Connect(function()
		if Dragging then return end
		Mouse.Icon = ""
	end)

	CMDCloseGui.Activated:Connect(function()
		CMDMain.Visible = false
	end)
end

do -- // Execution Bar
	Drag_1.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch and not Dragging then
			local OriginalPosition = Main.AbsolutePosition
			local MousePosition = UserInputService:GetMouseLocation()
			local RenderStepped
			Dragging = true
			Mouse.Icon = "rbxasset://textures/Cursors/mouseIconCameraTrack.png"

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					RenderStepped:Disconnect()
					Mouse.Icon = ""
					Dragging = false
				end
			end)

			RenderStepped = RunService.RenderStepped:Connect(function(Alpha)
				local delta = (MousePosition - UserInputService:GetMouseLocation())

				Main.Position = UDim2.new(0,(OriginalPosition.X - delta.X),0,(OriginalPosition.Y - delta.Y))
				Mouse.Icon = "rbxasset://textures/Cursors/mouseIconCameraTrack.png"
			end)
		end
	end)

	OpenButton.Activated:Connect(function()
		OpenButton.Visible = false
		Main.Visible = true
	end)

	CloseGui.Activated:Connect(function()
		OpenButton.Visible = true
		Main.Visible = false
	end)

	ExecutionBarInput.FocusLost:Connect(function(enter)
		if enter then ExecuteCommand(ExecutionBarInput.Text) end

		ExecutionBarInput.Text = ""
	end)
end

-- Start

local Prefix = Enum.KeyCode.Semicolon
local HoldingControl = nil
local HoldingAlt = nil
local AnimationPlayer = nil
local RespawnHandler = nil
local BreakOnSuccess = nil

local KeyAliasMap = {
	["-"] = Enum.KeyCode.Minus,
	["="] = Enum.KeyCode.Equals,
	["["] = Enum.KeyCode.LeftBracket,
	["]"] = Enum.KeyCode.RightBracket,
	[";"] = Enum.KeyCode.Semicolon,
	["'"] = Enum.KeyCode.Quote,
	[","] = Enum.KeyCode.Comma,
	["."] = Enum.KeyCode.Period,
	["/"] = Enum.KeyCode.Slash,
	["\\"] = Enum.KeyCode.BackSlash,
	["`"] = Enum.KeyCode.Backquote,
	["ctrl"] = Enum.KeyCode.LeftControl,
	["lctrl"] = Enum.KeyCode.LeftControl,
	["rctrl"] = Enum.KeyCode.RightControl,
	["shift"] = Enum.KeyCode.LeftShift,
	["lshift"] = Enum.KeyCode.LeftShift,
	["rshift"] = Enum.KeyCode.RightShift,
	["alt"] = Enum.KeyCode.LeftAlt,
	["lalt"] = Enum.KeyCode.LeftAlt,
	["ralt"] = Enum.KeyCode.RightAlt,
	["esc"] = Enum.KeyCode.Escape,
	["del"] = Enum.KeyCode.Delete,
}

local function FindKeyCode(UserInput)
	if not UserInput then return nil end
	local LowerInput = string.lower(UserInput)

	if KeyAliasMap[LowerInput] then
		return KeyAliasMap[LowerInput]
	end

	for _, KeyCode in Enum.KeyCode:GetEnumItems() do
		if string.lower(KeyCode.Name) == LowerInput then
			return KeyCode
		end
	end

	return nil
end

local Animations = {
    ['Freestylin'] = 4432024917,
    ['Floss'] = 4812941481,
    ['SmoothMoves'] = 4900539662,
    ['Aerostepping'] = 4776588732,
    ['ElectroSwing'] = 3485013176,
    ['MinecraftParrot'] = 4300228160,
    ['CaramellDansen'] = 6607554805,
    ['Breakdown'] = 4558409610,
    ['OrangeJustice'] = 3262592866,
    ['Smug'] = 3450125501,
    ['Crabby'] = 3643129020,
    ['Conga'] = 4572096542,
    ['DreamFeet'] = 4300218011,
    ['KazotskyKick'] = 4846209506,
    ['Radical'] = 4686555525,
    ['TakeTheL'] = 4827299133,
    ['Laughing'] = 4846000379,
    ['Drip'] = 4959380041,
    ['Pushups'] = 99504427539243,
	["randomdance1"] = 131539514978219, 
	["randomdance2"] = 8875904299, 
	["Sitting"] = 4842017973, 
	["BillyBounce"] = 6607119436, 
	["ZeroTwo"] = 7867380116, 
	["randomdance6"] = 16361564081, 
	["randomdance7"] = 133424881252105, 
	["randomdance8"] = 103315003879013, 
	["randomdance9"] = 9158896160, 
	["randomdance10"] = 97351316825183, 
	["randomdance11"] = 108043820618942, 
	["randomdance12"] = 13499921607, 
	["randomdance13"] = 82852186670121, 
	["randomdance14"] = 87138990788698, 
	["randomdance15"] = 124210157097622, 
	["randomdance16"] = 84420676303496, 
	["randomdance17"] = 127993598199806, 
	["randomdance18"] = 15093185505, 
	["randomdance19"] = 126465263971242, 
	["randomdance20"] = 14125486837, 
	["randomdance21"] = 16143414597, 
	["randomdance22"] = 94845993692069, 
	["randomdance23"] = 8772535190, 
	["randomdance24"] = 98543006822769, 
	["randomdance25"] = 87342159331194, 
	["randomdance26"] = 131658043622270, 
	["randomdance27"] = 104525136565640, 
	["randomdance28"] = 15039779727, 
	["randomdance29"] = 81930504118048, 
	["randomdance30"] = 110124478952785, 
	["randomdance31"] = 8915458946, 
	["randomdance32"] = 14125474952, 
	["randomdance33"] = 9191168242, 
	["randomdance34"] = 10687500605, 
	["randomdance35"] = 18985649800, 
	["randomdance36"] = 15115509387, 
	["randomdance37"] = 12474374184, 
	["randomdance38"] = 84447598378239, 
	["randomdance39"] = 14321704772, 
	["randomdance40"] = 117448332356578, 
	["randomdance41"] = 108398552144945, 
	["randomdance42"] = 18985726113, 
	["randomdance43"] = 130485792890829, 
	["randomdance44"] = 105422344378204, 
	["randomdance45"] = 88802480011454, 
	["randomdance46"] = 118257285014988, 
	["randomdance47"] = 116375125220834, 
	["randomdance48"] = 16362073134, 
	["randomdance49"] = 137514700106313, 
	["randomdance50"] = 18985529359, 
	["randomdance51"] = 117913564677190, 
	["randomdance52"] = 13542472660, 
	["randomdance53"] = 13845017130, 
	["randomdance54"] = 12852328987, 
	["randomdance55"] = 135378496779908, 
	["randomdance56"] = 10049457548, 
	["randomdance57"] = 18985751348, 
	["randomdance58"] = 18986687692, 
	["randomdance59"] = 72763573055833, 
	["randomdance60"] = 103736630097329, 
	["randomdance61"] = 113378850180481, 
	["randomdance62"] = 13579968035, 
	["randomdance63"] = 117685575636093, 
	["randomdance64"] = 117523961224024, 
	["randomdance65"] = 12581348761, 
	["randomdance66"] = 100191491062118, 
	["SpookyDance"] = 15231364673, 
	["randomdance68"] = 7828640127, 
	["randomdance69"] = 97992194141034, 
	["randomdance70"] = 137714761719347, 
	["randomdance71"] = 14125434919, 
	["randomdance72"] = 136475793242647, 
	["randomdance73"] = 106836244406405, 
	["randomdance74"] = 14630791982, 
	["randomdance75"] = 90486645096597, 
	["randomdance76"] = 119766959566102, 
	["randomdance77"] = 95986910060034, 
	["randomdance78"] = 7584192714, 
	["randomdance79"] = 15200323140, 
	["randomdance80"] = 81783637427821, 
	["randomdance81"] = 92187683724153, 
	["randomdance82"] = 13703701856, 
	["randomdance83"] = 90127032448242, 
	["randomdance84"] = 99826998720059, 
	["randomdance85"] = 15509944325, 
	["randomdance86"] = 104837571180061, 
	["randomdance87"] = 8550316999, 
	["randomdance88"] = 131559207454945, 
	["randomdance89"] = 137721173051346, 
	["randomdance90"] = 83266223088944, 
	["randomdance91"] = 107274746267860, 
	["randomdance92"] = 15039780593, 
	["randomdance93"] = 70636200474507, 
	["randomdance94"] = 135867676375598, 
	["randomdance95"] = 133760897579422, 
	["randomdance96"] = 13357063395, 
	["randomdance97"] = 13447037105, 
	["randomdance98"] = 132200906002694, 
	["randomdance99"] = 18986591475, 
	["randomdance100"] = 117514472098189, 
	["randomdance101"] = 108623438531351, 
	["randomdance102"] = 97173269581035, 
	["randomdance103"] = 91260130273371, 
	["randomdance104"] = 131562546189485, 
	["randomdance105"] = 14536793751, 
	["randomdance106"] = 96474371768104, 
	["randomdance107"] = 103599268167271, 
	["randomdance108"] = 136342468582970, 
	["randomdance109"] = 138949323409799, 
	["randomdance110"] = 13524047720, 
	["randomdance111"] = 112386701635558, 
	["randomdance112"] = 92293593057392, 
	["randomdance113"] = 104680253809276, 
	["randomdance114"] = 86319138773534, 
	["randomdance115"] = 8755445499, 
	["randomdance116"] = 84378678518832, 
	["randomdance117"] = 129136529911079, 
	["randomdance118"] = 106694699283623, 
	["randomdance119"] = 12331326670, 
	["randomdance120"] = 127134835827066, 
	["randomdance121"] = 121535445943256, 
	["randomdance122"] = 113243764075476, 
	["randomdance123"] = 94565891001065, 
	["randomdance124"] = 109272563401201, 
	["randomdance125"] = 124324933161835, 
	["randomdance126"] = 76540361217730, 
	["randomdance127"] = 81542849315640, 
	["randomdance128"] = 18986200915, 
	["randomdance129"] = 139889845987864, 
	["randomdance130"] = 116007172577928, 
	["randomdance131"] = 135126535467732, 
	["randomdance132"] = 117019555075601, 
	["randomdance133"] = 76975616044095, 
	["randomdance134"] = 107578737342278, 
	["randomdance135"] = 14281766612, 
	["StarPower"] = 107860942769438, 
	["randomdance137"] = 108594846549173, 
	["randomdance138"] = 139932788215900, 
	["randomdance139"] = 77426216275542, 
	["randomdance140"] = 86947150862846, 
	["randomdance141"] = 16361576857, 
	["randomdance142"] = 16729354942, 
	["randomdance143"] = 135117654875702, 
	["randomdance144"] = 124044710949643, 
	["randomdance145"] = 89128798282561, 
	["randomdance146"] = 8004387067, 
	["randomdance147"] = 8328359953, 
	["randomdance148"] = 92110306103230, 
	["randomdance149"] = 131084375511969, 
	["randomdance150"] = 12843537499, 
	["randomdance151"] = 128389643372098, 
	["randomdance152"] = 85680826440027, 
	["randomdance153"] = 124646390933027, 
	["randomdance154"] = 15049488553, 
	["randomdance155"] = 72460213504303, 
	["randomdance156"] = 14887006269, 
	["randomdance157"] = 12698847826, 
	["randomdance158"] = 14487794376, 
	["randomdance159"] = 96406877786147, 
	["randomdance160"] = 111366982175574, 
	["randomdance161"] = 14037662848, 
	["randomdance162"] = 84587788869282, 
	["randomdance163"] = 117632426193831, 
	["randomdance164"] = 93232228687989, 
	["randomdance165"] = 134166870573340, 
	["randomdance166"] = 109990576374190, 
	["randomdance167"] = 75462948983147, 
	["randomdance168"] = 114136127698808, 
	["randomdance169"] = 101571523474068, 
	["randomdance170"] = 11434028691, 
	["randomdance171"] = 91347516355671, 
	["randomdance172"] = 97072681531610, 
	["ClubPenguin"] = 8772459775, 
	["randomdance174"] = 125834337223799, 
	["randomdance175"] = 13305408503, 
	["randomdance176"] = 126880865139406, 
	["randomdance177"] = 95530034966573, 
	["randomdance178"] = 86485871533985, 
	["randomdance179"] = 13894522815, 
	["randomdance180"] = 101831164587635, 
	["randomdance181"] = 13272181711, 
	["randomdance182"] = 98916367562022, 
	["randomdance183"] = 15605418190, 
	["randomdance184"] = 137765549462705, 
	["randomdance185"] = 102033341518359, 
	["randomdance186"] = 130070981484912, 
	["randomdance187"] = 10048786578, 
	["randomdance188"] = 121698579993174, 
	["randomdance189"] = 118766274919427, 
	["randomdance190"] = 90421367029471, 
	["randomdance191"] = 14721291184, 
	["randomdance192"] = 85531796453437, 
	["randomdance193"] = 18986357892, 
	["randomdance194"] = 121267065315946, 
	["randomdance195"] = 123141771338905, 
	["randomdance196"] = 121255731270377, 
	["randomdance197"] = 111038494387073, 
	["randomdance198"] = 89892022491639, 
	["randomdance199"] = 97699704852712, 
	["randomdance200"] = 13843669201, 
	["randomdance201"] = 111249002064299, 
	["randomdance202"] = 70376423342136, 
	["randomdance203"] = 74512050800520, 
	["randomdance204"] = 92069955401837, 
	["randomdance205"] = 129584064125006, 
	["randomdance206"] = 13456829762, 
	["randomdance207"] = 14684864488, 	
}

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Prefix then
		ExecutionBarInput:CaptureFocus() task.wait()
		ExecutionBarInput.Text = ""
	end
	
	if input.KeyCode == Enum.KeyCode.LeftControl then
		HoldingControl = true
	end

	if input.KeyCode == Enum.KeyCode.LeftAlt then
		HoldingAlt = true
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.LeftControl then
		HoldingControl = nil
	end

	if input.KeyCode == Enum.KeyCode.LeftAlt then
		HoldingAlt = nil
	end
end)

local function Reanimate(Noclip)
	print[[

Reanimation Actived
Reanimation Status: WORKING✅
This Works Only in: Mic Up

Enjoy!
]]

local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local workspace = game.Workspace
local mouse = plr:GetMouse()
local camera = workspace.CurrentCamera
local Character = plr.Character
local hum = Character.Humanoid

local function onCharacter(char)
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")

    local hb
    hb = game:GetService("RunService").Heartbeat:Connect(function()
        if root and root.Parent then
            lastCFrame = root.CFrame
        else
            hb:Disconnect()
        end
    end)
end

if plr.Character then
    onCharacter(plr.Character)
end

local v3_net, v3_808 = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)    
                function getNetlessVelocity(realPartVelocity)
                    local mag = realPartVelocity.Magnitude
                    if mag > 0 then
                        local unit = realPartVelocity.Unit
                        if (unit.Y > 0.0) or (unit.Y < -0.0) then
                            return unit * (0.0 / unit.Y)
                        end
                    end
                    return v3_net + realPartVelocity * v3_808
                end
    local args = {
        "Ball"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("event_rag"):FireServer(unpack(args))

                local simradius = "shp" 
                local simrad = 0 
                local healthHide = false 
                local reclaim = true 

                local novoid = true 
                local physp = nil 

                local noclipAllParts = false 
                local antiragdoll = false 
                local newanimate = false 
                local discharscripts = false 
                local R15toR6 = true 
                local hatcollide = false 
                local humState16 = true 
                local addtools = false 
                local hedafterneck = true 
                local loadtime = game:GetService("Players").RespawnTime + 0.5 
                local method = 3 


                local alignmode = 4 
                local flingpart = "HumanoidRootPart" 

                local lp = game:GetService("Players").LocalPlayer
                local rs, ws, sg = game:GetService("RunService"), game:GetService("Workspace"), game:GetService("StarterGui")    local stepped, heartbeat, renderstepped = rs.Stepped, rs.Heartbeat, rs.RenderStepped
                local twait, tdelay, rad, inf, abs, clamp = task.wait, task.delay, math.rad, math.huge, math.abs, math.clamp
                local cf, v3 = CFrame.new, Vector3.new
                local angles = CFrame.Angles
                local v3_0, cf_0 = v3(0, 0, 0), cf(0, 0, 0)

                local c = lp.Character
                if not (c and c.Parent) then
                    return
                end
            
                c:GetPropertyChangedSignal("Parent"):Connect(function()
                    if not (c and c.Parent) then
                        c = nil
                    end
                end)
            
                local clone, destroy, getchildren, getdescendants, isa = c.Clone, c.Destroy, c.GetChildren, c.GetDescendants, c.IsA
            
                function gp(parent, name, className)
                    if typeof(parent) == "Instance" then
                        for i, v in pairs(getchildren(parent)) do
                            if (v.Name == name) and isa(v, className) then
                                return v
                            end
                        end
                    end
                    return nil
                end
            
                local fenv = getfenv()
            
                local shp = fenv.sethiddenproperty or fenv.set_hidden_property or fenv.set_hidden_prop or fenv.sethiddenprop
                local ssr = fenv.setsimulationradius or fenv.set_simulation_radius or fenv.set_sim_radius or fenv.setsimradius or fenv.setsimrad or fenv.set_sim_rad
            
                healthHide = healthHide and ((method == 0) or (method == 3)) and gp(c, "Head", "BasePart")
            
                local reclaim, lostpart = reclaim and c.PrimaryPart, nil
            
                function align(Part0, Part1)
                
                    local att0 = Instance.new("Attachment")
                    att0.Position, att0.Orientation, att0.Name = v3_0, v3_0, "att0_" .. Part0.Name
                    local att1 = Instance.new("Attachment")
                    att1.Position, att1.Orientation, att1.Name = v3_0, v3_0, "att1_" .. Part1.Name
                
                    if alignmode == 4 then
                    
                        local hide = false
                        if Part0 == healthHide then
                            healthHide = false
                            tdelay(0, function()
                                while twait(2.9) and Part0 and c do
                                    hide = #Part0:GetConnectedParts() == 1
                                    twait(0.1)
                                    hide = false
                                end
                            end)
                        end
                    
                        local rot = rad(0.05)
                        local con0, con1 = nil, nil
                        con0 = stepped:Connect(function()
                            if not (Part0 and Part1) then return con0:Disconnect() and con1:Disconnect() end
                            Part0.RotVelocity = Part1.RotVelocity
                        end)
                        local lastpos = Part0.Position
                        con1 = heartbeat:Connect(function(delta)
                            if not (Part0 and Part1 and att1) then return con0:Disconnect() and con1:Disconnect() end
                            if (not Part0.Anchored) and (Part0.ReceiveAge == 0) then
                                if lostpart == Part0 then
                                    lostpart = nil
                                end
                                rot = -rot
                                local newcf = Part1.CFrame * att1.CFrame * angles(0, 0, rot)
                                if Part1.Velocity.Magnitude > 0.01 then
                                    Part0.Velocity = getNetlessVelocity(Part1.Velocity)
                                else
                                    Part0.Velocity = getNetlessVelocity((newcf.Position - lastpos) / delta)
                                end
                                lastpos = newcf.Position
                                if lostpart and (Part0 == reclaim) then
                                    newcf = lostpart.CFrame
                                elseif hide then
                                    newcf += v3(0, 3000, 0)
                                end
                                if novoid and (newcf.Y < ws.FallenPartsDestroyHeight + 0.1) then
                                    newcf += v3(0, ws.FallenPartsDestroyHeight + 0.1 - newcf.Y, 0)
                                end
                                Part0.CFrame = newcf
                            elseif (not Part0.Anchored) and (abs(Part0.Velocity.X) < 45) and (abs(Part0.Velocity.Y) < 25) and (abs(Part0.Velocity.Z) < 45) then
                                lostpart = Part0
                            end
                        end)
                    
                    else
                    
                        Part0.CustomPhysicalProperties = physp
                        if (alignmode == 1) or (alignmode == 2) then
                            local ape = Instance.new("AlignPosition")
                            ape.MaxForce, ape.MaxVelocity, ape.Responsiveness = inf, inf, inf
                            ape.ReactionForceEnabled, ape.RigidityEnabled, ape.ApplyAtCenterOfMass = false, true, false
                            ape.Attachment0, ape.Attachment1, ape.Name = att0, att1, "AlignPositionRtrue"
                            ape.Parent = att0
                        end
                    
                        if (alignmode == 2) or (alignmode == 3) then
                            local apd = Instance.new("AlignPosition")
                            apd.MaxForce, apd.MaxVelocity, apd.Responsiveness = inf, inf, inf
                            apd.ReactionForceEnabled, apd.RigidityEnabled, apd.ApplyAtCenterOfMass = false, false, false
                            apd.Attachment0, apd.Attachment1, apd.Name = att0, att1, "AlignPositionRfalse"
                            apd.Parent = att0
                        end
                    
                        local ao = Instance.new("AlignOrientation")
                        ao.MaxAngularVelocity, ao.MaxTorque, ao.Responsiveness = inf, inf, inf
                        ao.PrimaryAxisOnly, ao.ReactionTorqueEnabled, ao.RigidityEnabled = false, false, false
                        ao.Attachment0, ao.Attachment1 = att0, att1
                        ao.Parent = att0
                    
                        local con0, con1 = nil, nil
                        local vel = Part0.Velocity
                        con0 = renderstepped:Connect(function()
                            if not (Part0 and Part1) then return con0:Disconnect() and con1:Disconnect() end
                            Part0.Velocity = vel
                        end)
                        local lastpos = Part0.Position
                        con1 = heartbeat:Connect(function(delta)
                            if not (Part0 and Part1) then return con0:Disconnect() and con1:Disconnect() end
                            vel = Part0.Velocity
                            if Part1.Velocity.Magnitude > 0.01 then
                                Part0.Velocity = getNetlessVelocity(Part1.Velocity)
                            else
                                Part0.Velocity = getNetlessVelocity((Part0.Position - lastpos) / delta)
                            end
                            lastpos = Part0.Position
                        end)
                    
                    end
                
                    att0:GetPropertyChangedSignal("Parent"):Connect(function()
                        Part0 = att0.Parent
                        if not isa(Part0, "BasePart") then
                            att0 = nil
                            if lostpart == Part0 then
                                lostpart = nil
                            end
                            Part0 = nil
                        end
                    end)
                    att0.Parent = Part0
                
                    att1:GetPropertyChangedSignal("Parent"):Connect(function()
                        Part1 = att1.Parent
                        if not isa(Part1, "BasePart") then
                            att1 = nil
                            Part1 = nil
                        end
                    end)
                    att1.Parent = Part1
                end
            
                function respawnrequest()
                    local ccfr, c = ws.CurrentCamera.CFrame, lp.Character
                    lp.Character = nil
                    lp.Character = c
                    local con = nil
                    con = ws.CurrentCamera.Changed:Connect(function(prop)
                        if (prop ~= "Parent") and (prop ~= "CFrame") then
                            return
                        end
                        ws.CurrentCamera.CFrame = ccfr
                        con:Disconnect()
                    end)
                end
            
                local destroyhum = (method == 4) or (method == 5)
                local breakjoints = (method == 0) or (method == 4)
                local antirespawn = (method == 0) or (method == 2) or (method == 3)
            
                hatcollide = hatcollide and (method == 0)
            
                addtools = addtools and lp:FindFirstChildOfClass("Backpack")
            
                if type(simrad) ~= "number" then simrad = 1000 end
                if shp and (simradius == "shp") then
                    tdelay(0, function()
                        while c do
                            shp(lp, "SimulationRadius", simrad)
                            heartbeat:Wait()
                        end
                    end)
                elseif ssr and (simradius == "ssr") then
                    tdelay(0, function()
                        while c do
                            ssr(simrad)
                            heartbeat:Wait()
                        end
                    end)
                end
            
                if antiragdoll then
                    antiragdoll = function(v)
                        if isa(v, "HingeConstraint") or isa(v, "BallSocketConstraint") then
                            v.Parent = nil
                        end
                    end
                    for i, v in pairs(getdescendants(c)) do
                        antiragdoll(v)
                    end
                    c.DescendantAdded:Connect(antiragdoll)
                end
            
                if antirespawn then

                end
            
                if method == 0 then
                    twait(loadtime)
                    if not c then
                        return
                    end
                end
            
                if discharscripts then
                    for i, v in pairs(getdescendants(c)) do
                        if isa(v, "LocalScript") then
                            v.Disabled = true
                        end
                    end
                elseif newanimate then
                    local animate = gp(c, "Animate", "LocalScript")
                    if animate and (not animate.Disabled) then
                        animate.Disabled = true
                    else
                        newanimate = false
                    end
                end
            
                if addtools then
                    for i, v in pairs(getchildren(addtools)) do
                        if isa(v, "Tool") then
                            v.Parent = c
                        end
                    end
                end
            
                pcall(function()
                    settings().Physics.AllowSleep = false
                    settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
                end)
            
                local OLDscripts = {}
            
                for i, v in pairs(getdescendants(c)) do
                    if v.ClassName == "Script" then
                        OLDscripts[v.Name] = true
                    end
                end
            
                local scriptNames = {}
            
                for i, v in pairs(getdescendants(c)) do
                    if isa(v, "BasePart") then
                        local newName, exists = tostring(i), true
                        while exists do
                            exists = OLDscripts[newName]
                            if exists then
                            newName = newName .. "_"    
                        end
                    end
                    table.insert(scriptNames, newName)
                    Instance.new("Script", v).Name = newName
                end
            end
    
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum then
                for i, v in pairs(hum:GetPlayingAnimationTracks()) do
                    v:Stop()
                end
            end
            c.Archivable = true
            local cl = clone(c)
            if hum and humState16 then
                hum:ChangeState(Enum.HumanoidStateType.Physics)
                if destroyhum then
                    twait(1.6)
                end
            end
            if destroyhum then
                pcall(destroy, hum)
            end
    
            if not c then
                return
            end
    
            local head, torso, root = gp(c, "Head", "BasePart"), gp(c, "Torso", "BasePart") or gp(c, "UpperTorso", "BasePart"), gp(c, "HumanoidRootPart", "BasePart")
            if hatcollide then
                pcall(destroy, torso)
                pcall(destroy, root)
                pcall(destroy, c:FindFirstChildOfClass("BodyColors") or gp(c, "Health", "Script"))
            end
    
            local model = Instance.new("Model", c)
            model:GetPropertyChangedSignal("Parent"):Connect(function()
                if not (model and model.Parent) then
                    model = nil
                end
            end)
    
            for i, v in pairs(getchildren(c)) do
                if v ~= model then
                    if addtools and isa(v, "Tool") then
                        for i1, v1 in pairs(getdescendants(v)) do
                            if v1 and v1.Parent and isa(v1, "BasePart") then
                                local bv = Instance.new("BodyVelocity")
                                bv.Velocity, bv.MaxForce, bv.P, bv.Name = v3_0, v3(1000, 1000, 1000), 1250, "bv_" .. v.Name
                                bv.Parent = v1
                            end
                        end
                    end
                    v.Parent = model
                end
            end
    
            if breakjoints then
                model:BreakJoints()
            else
                if head and torso then
                    for i, v in pairs(getdescendants(model)) do
                        if isa(v, "JointInstance") then
                            local save = false
                            if (v.Part0 == torso) and (v.Part1 == head) then
                                save = true
                            end
                            if (v.Part0 == head) and (v.Part1 == torso) then
                                save = true
                            end
                            if save then
                                if hedafterneck then
                                    hedafterneck = v
                                end
                            else
                                pcall(destroy, v)
                            end
                        end
                    end
                end
                if method == 3 then
                    task.delay(loadtime, pcall, model.BreakJoints, model)
                end
            end
    
            cl.Parent = ws
            for i, v in pairs(getchildren(cl)) do
                v.Parent = c
            end
            pcall(destroy, cl)
    
            local uncollide, noclipcon = nil, nil
            if noclipAllParts then
                uncollide = function()
                    if c then
                        for i, v in pairs(getdescendants(c)) do
                            if isa(v, "BasePart") then
                                v.CanCollide = false
                            end
                        end
                    else
                        noclipcon:Disconnect()
                    end
                end
            else
                uncollide = function()
                    if model then
                        for i, v in pairs(getdescendants(model)) do
                            if isa(v, "BasePart") then
                                v.CanCollide = false
                            end
                        end
                    else
                        noclipcon:Disconnect()
                    end
                end
            end
            noclipcon = stepped:Connect(uncollide)
            uncollide()
    
            for i, scr in pairs(getdescendants(model)) do
                if (scr.ClassName == "Script") and table.find(scriptNames, scr.Name) then
                    local Part0 = scr.Parent
                    if isa(Part0, "BasePart") then
                        for i1, scr1 in pairs(getdescendants(c)) do
                            if (scr1.ClassName == "Script") and (scr1.Name == scr.Name) and (not scr1:IsDescendantOf(model)) then
                                local Part1 = scr1.Parent
                                if (Part1.ClassName == Part0.ClassName) and (Part1.Name == Part0.Name) then
                                    align(Part0, Part1)
                                    pcall(destroy, scr)
                                    pcall(destroy, scr1)
                                    break
                                end
                            end
                        end
                    end
                end
            end
    
            for i, v in pairs(getdescendants(c)) do
                if v and v.Parent and (not v:IsDescendantOf(model)) then
                    if isa(v, "Decal") then
                        v.Transparency = 1
                    elseif isa(v, "BasePart") then
                        v.Transparency = 1
                        v.Anchored = false
                    elseif isa(v, "ForceField") then
                        v.Visible = false
                    elseif isa(v, "Sound") then
                        v.Playing = false
                    elseif isa(v, "BillboardGui") or isa(v, "SurfaceGui") or isa(v, "ParticleEmitter") or isa(v, "Fire") or isa(v, "Smoke") or isa(v, "Sparkles") then
                        v.Enabled = false
                    end
                end
            end
    
            if newanimate then
                local animate = gp(c, "Animate", "LocalScript")
                if animate then
                    animate.Disabled = false
                end
            end
    
            if addtools then
                for i, v in pairs(getchildren(c)) do
                    if isa(v, "Tool") then
                        v.Parent = addtools
                    end
                end
            end
    
            local hum0, hum1 = model:FindFirstChildOfClass("Humanoid"), c:FindFirstChildOfClass("Humanoid")
            if hum0 then
                hum0:GetPropertyChangedSignal("Parent"):Connect(function()
                    if not (hum0 and hum0.Parent) then
                        hum0 = nil
                    end
                end)
            end
            if hum1 then
                hum1:GetPropertyChangedSignal("Parent"):Connect(function()
                    if not (hum1 and hum1.Parent) then
                        hum1 = nil
                    end
                end)
            
                ws.CurrentCamera.CameraSubject = hum1
                local camSubCon = nil
                function camSubFunc()
                    camSubCon:Disconnect()
                    if c and hum1 then
                        ws.CurrentCamera.CameraSubject = hum1
                    end
                end
                camSubCon = renderstepped:Connect(camSubFunc)
                if hum0 then
                    hum0:GetPropertyChangedSignal("Jump"):Connect(function()
                        if hum1 then
                            hum1.Jump = hum0.Jump
                        end
                    end)
                else
                    
                end
            end
    
            local rb = Instance.new("BindableEvent", c)
            rb.Event:Connect(function()
                pcall(destroy, rb)
                sg:SetCore("ResetButtonCallback", true)
                if destroyhum then
                    if c then c:BreakJoints() end
                    return
                end
                if model and hum0 and (hum0.Health > 0) then
                    model:BreakJoints()
                    hum0.Health = 0
                end
                if antirespawn then
                    
                end
            end)
            sg:SetCore("ResetButtonCallback", rb)
    
            tdelay(0, function()
                while c do
                    if hum0 and hum1 then
                        hum1.Jump = hum0.Jump
                    end
                    wait()
                end
                sg:SetCore("ResetButtonCallback", true)
            end)
    
            R15toR6 = R15toR6 and hum1 and (hum1.RigType == Enum.HumanoidRigType.R15)
            if R15toR6 then
                local part = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "UpperTorso", "BasePart") or gp(c, "LowerTorso", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
                if part then
                    local cfr = part.CFrame
                    local R6parts = { 
                        head = {
                            Name = "Head",
                            Size = v3(2, 1, 1),
                            R15 = {
                                Head = 0
                            }
                        },
                        torso = {
                            Name = "Torso",
                            Size = v3(2, 2, 1),
                            R15 = {
                                UpperTorso = 0.2,
                                LowerTorso = -0.8
                            }
                        },
                        root = {
                            Name = "HumanoidRootPart",
                            Size = v3(2, 2, 1),
                            R15 = {
                                HumanoidRootPart = 0
                            }
                        },
                        leftArm = {
                            Name = "Left Arm",
                            Size = v3(1, 2, 1),
                            R15 = {
                                LeftHand = -0.849,
                                LeftLowerArm = -0.174,
                                LeftUpperArm = 0.415
                            }
                        },
                        rightArm = {
                            Name = "Right Arm",
                            Size = v3(1, 2, 1),
                            R15 = {
                                RightHand = -0.849,
                                RightLowerArm = -0.174,
                                RightUpperArm = 0.415
                            }
                        },
                        leftLeg = {
                            Name = "Left Leg",
                            Size = v3(1, 2, 1),
                            R15 = {
                                LeftFoot = -0.85,
                                LeftLowerLeg = -0.29,
                                LeftUpperLeg = 0.49
                            }
                        },
                        rightLeg = {
                            Name = "Right Leg",
                            Size = v3(1, 2, 1),
                            R15 = {
                                RightFoot = -0.85,
                                RightLowerLeg = -0.29,
                                RightUpperLeg = 0.49
                            }
                        }
                    }
                                for i, v in pairs(getchildren(c)) do
                        if isa(v, "BasePart") then
                            for i1, v1 in pairs(getchildren(v)) do
                                if isa(v1, "Motor6D") then
                                    v1.Part0 = nil
                                end
                            end
                        end
                    end
                    part.Archivable = true
                    for i, v in pairs(R6parts) do
                        local part = clone(part)
                        part:ClearAllChildren()
                        part.Name, part.Size, part.CFrame, part.Anchored, part.Transparency, part.CanCollide, part.Massless = v.Name, v.Size, cfr, false, 1, false, false
                        for i1, v1 in pairs(v.R15) do
                            local R15part = gp(c, i1, "BasePart")
                            local att = gp(R15part, "att1_" .. i1, "Attachment")
                            if R15part then
                                local weld = Instance.new("Weld")
                                weld.Part0, weld.Part1, weld.C0, weld.C1, weld.Name = part, R15part, cf(0, v1, 0), cf_0, "Weld_" .. i1
                                weld.Parent = R15part
                                R15part.Massless, R15part.Name = true, "R15_" .. i1
                                R15part.Parent = part
                                if att then
                                    att.Position = v3(0, v1, 0)
                                    att.Parent = part
                                end
                            end
                        end
                        part.Parent = c
                        R6parts[i] = part
                    end
                    local R6joints = {
                        neck = {
                            Parent = R6parts.torso,
                            Name = "Neck",
                            Part0 = R6parts.torso,
                            Part1 = R6parts.head,
                            C0 = cf(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                            C1 = cf(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
                        },
                        rootJoint = {
                            Parent = R6parts.root,
                            Name = "RootJoint" ,
                            Part0 = R6parts.root,
                            Part1 = R6parts.torso,
                            C0 = cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                            C1 = cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
                        },
                        rightShoulder = {
                            Parent = R6parts.torso,
                            Name = "Right Shoulder",
                            Part0 = R6parts.torso,
                            Part1 = R6parts.rightArm,
                            C0 = cf(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
                            C1 = cf(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                        },
                        leftShoulder = {
                            Parent = R6parts.torso,
                            Name = "Left Shoulder",
                            Part0 = R6parts.torso,
                            Part1 = R6parts.leftArm,
                            C0 = cf(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                            C1 = cf(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                        },
                        rightHip = {
                            Parent = R6parts.torso,
                            Name = "Right Hip",
                            Part0 = R6parts.torso,
                            Part1 = R6parts.rightLeg,
                            C0 = cf(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
                            C1 = cf(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                        },
                        leftHip = {
                            Parent = R6parts.torso,
                            Name = "Left Hip" ,
                            Part0 = R6parts.torso,
                            Part1 = R6parts.leftLeg,
                            C0 = cf(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                            C1 = cf(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                        }
                    }
                    for i, v in pairs(R6joints) do
                        local joint = Instance.new("Motor6D")
                        for prop, val in pairs(v) do
                            joint[prop] = val
                        end
                        R6joints[i] = joint
                    end
                    if hum1 then
                        hum1.RigType, hum1.HipHeight = Enum.HumanoidRigType.R6, 0
                    end
                end
            end
            function getJoint(name)
                for i,v in next,R6joints do
                    if v.Name==name then
                        return v
                    end
                end
                return {C0=cf_0,C1=cf_0}
            end
            local torso1 = torso
            torso = gp(c, "Torso", "BasePart") or ((not R15toR6) and gp(c, torso.Name, "BasePart"))
            if (typeof(hedafterneck) == "Instance") and head and torso and torso1 then
                local conNeck, conTorso, conTorso1 = nil, nil, nil
                local aligns = {}
                function enableAligns()
                    conNeck:Disconnect()
                    conTorso:Disconnect()
                    conTorso1:Disconnect()
                    for i, v in pairs(aligns) do
                        v.Enabled = true
                    end
                end
                conNeck = hedafterneck.Changed:Connect(function(prop)
                    if table.find({"Part0", "Part1", "Parent"}, prop) then
                        enableAligns()
                    end
                end)
                conTorso = torso:GetPropertyChangedSignal("Parent"):Connect(enableAligns)
                conTorso1 = torso1:GetPropertyChangedSignal("Parent"):Connect(enableAligns)
                for i, v in pairs(getdescendants(head)) do
                    if isa(v, "AlignPosition") or isa(v, "AlignOrientation") then
                        i = tostring(i)
                        aligns[i] = v
                        v:GetPropertyChangedSignal("Parent"):Connect(function()
                            aligns[i] = nil
                        end)
                        v.Enabled = false
                    end
                end
            end
    
            local flingpart0 = gp(model, flingpart, "BasePart") or gp(gp(model, flingpart, "Accessory"), "Handle", "BasePart")
            local flingpart1 = gp(c, flingpart, "BasePart") or gp(gp(c, flingpart, "Accessory"), "Handle", "BasePart")
    
            local fling = function() end
            if flingpart0 and flingpart1 then
                flingpart0:GetPropertyChangedSignal("Parent"):Connect(function()
                    if not (flingpart0 and flingpart0.Parent) then
                        flingpart0 = nil
                        fling = function() end
                    end
                end)
                flingpart0.Archivable = true
                flingpart1:GetPropertyChangedSignal("Parent"):Connect(function()
                    if not (flingpart1 and flingpart1.Parent) then
                        flingpart1 = nil
                        fling = function() end
                    end
                end)
                local att0 = gp(flingpart0, "att0_" .. flingpart0.Name, "Attachment")
                local att1 = gp(flingpart1, "att1_" .. flingpart1.Name, "Attachment")
                if att0 and att1 then
                    att0:GetPropertyChangedSignal("Parent"):Connect(function()
                        if not (att0 and att0.Parent) then
                            att0 = nil
                            fling = function() end
                        end
                    end)
                    att1:GetPropertyChangedSignal("Parent"):Connect(function()
                        if not (att1 and att1.Parent) then
                            att1 = nil
                            fling = function() end
                        end
                    end)
                    local lastfling = nil
                    local mouse = lp:GetMouse()
                    fling = function(target, duration, rotVelocity)
                        if typeof(target) == "Instance" then
                            if isa(target, "BasePart") then
                                target = target.Position
                            elseif isa(target, "Model") then
                                target = gp(target, "HumanoidRootPart", "BasePart") or gp(target, "Torso", "BasePart") or gp(target, "UpperTorso", "BasePart") or target:FindFirstChildWhichIsA("BasePart")
                                if target then
                                    target = target.Position
                                else
                                    return
                                end
                            elseif isa(target, "Humanoid") then
                                target = target.Parent
                                if not (target and isa(target, "Model")) then
                                    return
                                end
                                target = gp(target, "HumanoidRootPart", "BasePart") or gp(target, "Torso", "BasePart") or gp(target, "UpperTorso", "BasePart") or target:FindFirstChildWhichIsA("BasePart")
                                if target then
                                    target = target.Position
                                else
                                    return
                                end
                            else
                                return
                            end
                        elseif typeof(target) == "CFrame" then
                            target = target.Position
                        elseif typeof(target) ~= "Vector3" then
                            target = mouse.Hit
                            if target then
                                target = target.Position
                            else
                                return
                            end
                        end
                        if target.Y < ws.FallenPartsDestroyHeight + 5 then
                            target = v3(target.X, ws.FallenPartsDestroyHeight + 5, target.Z)
                        end
                        lastfling = target
                        if type(duration) ~= "number" then
                            duration = tonumber(duration) or 0.5
                        end
                        if typeof(rotVelocity) ~= "Vector3" then
                            rotVelocity = v3(0, 0, 0)
                        end
                        if not (target and flingpart0 and flingpart1 and att0 and att1) then
                            return
                        end
                        flingpart0.Archivable = true
                        local flingpart = clone(flingpart0)
                        flingpart.Transparency = 1
                        flingpart.CanCollide = false
                        flingpart.Name = "flingpart_" .. flingpart0.Name
                        flingpart.Anchored = true
                        flingpart.Velocity = v3_0
                        flingpart.RotVelocity = v3_0
                        flingpart.Position = target
                        flingpart:GetPropertyChangedSignal("Parent"):Connect(function()
                            if not (flingpart and flingpart.Parent) then
                                flingpart = nil
                            end
                        end)
                        flingpart.Parent = flingpart1
                        if flingpart0.Transparency > 0.5 then
                            flingpart0.Transparency = 0.5
                        end
                        att1.Parent = flingpart
                        local con = nil
                        local rotchg = v3(0, rotVelocity.Unit.Y * -1000, 0)
                        con = heartbeat:Connect(function(delta)
                            if target and (lastfling == target) and flingpart and flingpart0 and flingpart1 and att0 and att1 then
                                flingpart.Orientation += rotchg * delta
                                flingpart0.RotVelocity = rotVelocity
                            else
                                con:Disconnect()
                            end
                        end)
                        if alignmode ~= 4 then
                            local con = nil
                            con = renderstepped:Connect(function()
                                if flingpart0 and target then
                                    flingpart0.RotVelocity = v3_0
                                else
                                    con:Disconnect()
                                end
                            end)
                        end
                        twait(duration)
                        if lastfling ~= target then
                            if flingpart then
                                if att1 and (att1.Parent == flingpart) then
                                    att1.Parent = flingpart1
                                end
                                pcall(destroy, flingpart)
                            end
                            return
                        end
                        target = nil
                        if not (flingpart and flingpart0 and flingpart1 and att0 and att1) then
                            return
                        end
                        flingpart0.RotVelocity = v3_0
                        att1.Parent = flingpart1
                        pcall(destroy, flingpart)
                    end

        local plrs = game:GetService("Players")
        local c = plrs.LocalPlayer.Character
        if not c then return end
        local ws = game:GetService("Workspace")
        local raycast = ws.Raycast
        c.AncestryChanged:Connect(function()
            if not c:IsDescendantOf(ws) then
                c = nil
            end
        end)
        local rs = game:GetService("RunService")
        local stepped, renderstepped, heartbeat = rs.Stepped, rs.RenderStepped, rs.Heartbeat
        function gp(parent, name, classname)
            if typeof(parent) == "Instance" then
                for i, v in pairs(parent:GetChildren()) do
                    if (v.Name == name) and v:IsA(classname) then
                        return v
                    end
                end
            end
            return nil
        end
    
        local mrandom, schar, supper = math.random, string.char, string.upper

    
        function addjoint(v)
            table.insert(staticjoints, {C0 = v.C0, C1 = v.C1, Part0 = v.Part0, Part1 = v.Part1})
        end
        for i, v in pairs(c:GetDescendants()) do
            if v:IsA("JointInstance") then 
                pcall(addjoint, v)
            end
        end
    
        for i, v in pairs(c:GetChildren()) do
            if v:IsA("Accessory") then
                local handle = gp(v, "Handle", "BasePart")
                handle.Parent = c
                v:Destroy()
            end
        end
        local staticjoints = {}
        function animjoint(name, parent, Part0, Part1, fakejoint)
            fakejoint.C0 = CFrame.new()
            fakejoint.C1 = CFrame.new()
            local joint = gp(parent, name, "Motor6D")
            if joint then
                for i, v in pairs(staticjoints) do
                    if (v.Part0 == Part0) and (v.Part1 == Part1) then
                        staticjoints[i] = nil
                        break
                    end
                end
                fakejoint.C0 = joint.C0
                fakejoint.C1 = joint.C1
                joint:Destroy()
                joint = nil
            end
            local fix = nil
            local con = nil
            fix = function()
                if not c then
                    return con:Disconnect()
                end
                if not joint then 
                    joint = Instance.new("Weld")
                    joint.Changed:Connect(fix)
                    joint.Destroying:Connect(function() joint = nil fix() end)
                end
                if joint.Part0 ~= Part0 then
                    joint.Part0 = Part0
                end
                if joint.Part1 ~= Part1 then
                    joint.Part1 = Part1
                end
                if joint.C0 ~= fakejoint.C0 then
                    joint.C0 = fakejoint.C0
                end
                if joint.C1 ~= fakejoint.C1 then
                    joint.C1 = fakejoint.C1
                end
                if joint.Name ~= name then
                    joint.Name = name
                end
                if joint.Parent ~= parent then
                    joint.Parent = parent
                end
            end
            con = stepped:Connect(fix)
        end

        local RootJoint = {}
        local RightShoulder = {}
        local LeftShoulder = {}
        local RightHip = {}
        local LeftHip = {}
        local Neck = {}
    

        for i, v in pairs(c:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") then
                for i, v in pairs(v:GetDescendants()) do
                    if v:IsA("JointInstance") then
                        for i, v1 in pairs(staticjoints) do
                            if (v.Part0 == v1.Part0) and (v.Part1 == v1.Part1) then
                                staticjoints[i] = nil
                            end
                        end
                    end
                end
            end
        end

    
        for i, v in pairs(staticjoints) do
            local Part0, Part1, C0, C1 = v.Part0, v.Part1, v.C0, v.C1
            local fix, con, joint = nil, nil, nil
            fix = function()
                if not c then
                    return con:Disconnect()
                end
                if not joint then 
                    joint = Instance.new("Weld")
                    joint.Changed:Connect(fix)
                    joint.Destroying:Connect(function() joint = nil fix() end)
                end
                if joint.Part0 ~= Part0 then
                    joint.Part0 = Part0
                end
                if joint.Part1 ~= Part1 then
                    joint.Part1 = Part1
                end
                if joint.C0 ~= C0 then
                    joint.C0 = C0
                end
                if joint.C1 ~= C1 then
                    joint.C1 = C1
                end
                if joint.Name ~= name then
                    joint.Name = name
                end
                if joint.Parent ~= c then
                    joint.Parent = c
                end
            end
            con = stepped:Connect(fix)
        end

    
        local cf, v3 = CFrame.new, Vector3.new
        local v3_0, v3_101, v3_010, v3_d, v3_u = v3(0, 0, 0), v3(1, 0, 1), v3(0, 1, 0), v3(0, -10000, 0), v3(0, 10000, 0)
        local vel, raycastresult, onground = v3_0, nil, true
    
        local raycastparams = RaycastParams.new()
        raycastparams.FilterType = Enum.RaycastFilterType.Blacklist
        local rayfilter = {}
        local characters = {}
        function refreshrayfilter()
            for i, v in pairs(rayfilter) do
                if not table.find(characters, v) then
                    rayfilter[i] = nil
                end
            end
            for i, v in pairs(characters) do
                if not table.find(rayfilter, v) then
                    table.insert(rayfilter, v)
                end
            end
            raycastparams.FilterDescendantsInstances = rayfilter
        end
        function oncharacter(plr, c)
            characters[plr] = c
            refreshrayfilter()
        end
        function onplayer(v)
            oncharacter(v, v.Character)
            v.CharacterAdded:Connect(function(c)
                oncharacter(v, c)
            end)
        end
        for i, v in pairs(plrs:GetPlayers()) do onplayer(v) end
        plrs.PlayerAdded:Connect(onplayer)
        plrs.PlayerRemoving:Connect(function(v)
            oncharacter(v, nil)
        end)
    
        local legcfR, legcfL, legvec = cf(1, -1.5, 0), cf(-1, -1.5, 0), v3(0, -1.5, 0)
        function raycastlegs()
            local rY, lY = raycast(ws, (cfr * legcfR).Position, legvec, raycastparams), raycast(ws, (cfr * legcfL).Position, legvec, raycastparams)
            return rY and (rY.Position.Y - (cfr.Y - 3)) or 0, lY and (lY.Position.Y - (cfr.Y - 3)) or 0
        end
    
        local euler, sin, sine, abs, clamp = CFrame.fromEulerAnglesXYZ, math.sin, 0, math.abs, math.clamp
        local con = nil
        plr.Character.Humanoid.AutomaticScalingEnabled = false
        plr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=180435571"
        plr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=180435571"
        plr.Character.Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=180426354"
        plr.Character.Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=180426354"
        plr.Character.Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=125750702"
        plr.Character.Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=180436148"
        
        end

        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local Joints = {
            ["Torso"] = plr.Character.HumanoidRootPart["RootJoint"],
            ["Right Arm"] =  plr.Character.Torso["Right Shoulder"],
            ["Left Arm"] =  plr.Character.Torso["Left Shoulder"],
            ["Head"] =  plr.Character.Torso["Neck"],
            ["Left Leg"] =  plr.Character.Torso["Left Hip"],
            ["Right Leg"] =  plr.Character.Torso["Right Hip"]
        }

        for jointName, joint in pairs(Joints) do
            if joint then
                if jointName == "Left Arm" then
                    joint.C0 = joint.C0 + Vector3.new(-widthChange * 0.5, 0, 0) 
                elseif jointName == "Right Arm" then
                    joint.C0 = joint.C0 + Vector3.new(widthChange * 0.5, 0, 0) 
                elseif jointName == "Left Leg" then
                    joint.C0 = joint.C0 + Vector3.new(-widthChange * 0.5, 0, 0) 
                elseif jointName == "Right Leg" then
                    joint.C0 = joint.C0 + Vector3.new(widthChange * 0.5, 0, 0) 
                end
            else 
        end
    end

        game.Workspace.Gravity = 196.2
        local cf = CFrame.new
        local Joints = {
            ["Torso"] = plr.Character.HumanoidRootPart["RootJoint"],
            ["Right Arm"] = plr.Character.Torso["Right Shoulder"],
            ["Left Arm"] = plr.Character.Torso["Left Shoulder"],
            ["Head"] = plr.Character.Torso["Neck"],
            ["Left Leg"] = plr.Character.Torso["Left Hip"],
            ["Right Leg"] = plr.Character.Torso["Right Hip"]
        }


        local OriginalCFrames = {
            ["Torso"] = {
                C0 = cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                C1 = cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
            },
            ["Right Arm"] = {
                C0 = cf(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
                C1 = cf(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            },
            ["Left Arm"] = {
                C0 = cf(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                C1 = cf(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            },
            ["Head"] = {
                C0 = cf(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                C1 = cf(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
            },
            ["Left Leg"] = {
                C0 = cf(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                C1 = cf(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            },
            ["Right Leg"] = {
                C0 = cf(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
                C1 = cf(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            }
        }


        for jointName, joint in pairs(Joints) do
            if joint then
                joint.C0 = OriginalCFrames[jointName].C0
                joint.C1 = OriginalCFrames[jointName].C1
            end
        end

        local Animator = Instance.new('Animator', plr.Character.Humanoid)
        wait(0.05)
        plr.Character.Animate.Enabled = true
        wait(0.01)
        plr.Character.Humanoid.AutomaticScalingEnabled = false
        plr.Character.Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=180435571"
        plr.Character.Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=180435571"
        plr.Character.Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=180426354"
        plr.Character.Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=180426354"
        plr.Character.Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=125750702"
        plr.Character.Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=180436148"
    end
	
        AnimationActive = false
        StopAnim = true

        if connection then
            connection:Disconnect()
            connection = nil
        end

        local character = plr.Character or plr.CharacterAdded:Wait()
        local humanoid = character:FindFirstChild("Humanoid")
        local animate = character:FindFirstChild("Animate")

        if humanoid then
            local animator = humanoid:FindFirstChild("Animator")
            if animator then animator:Destroy() end
            humanoid.AutomaticScalingEnabled = false
        end

        if animate then
            animate.Enabled = false
        end


        local joints = {
            ["Torso"] = character.HumanoidRootPart:FindFirstChild("RootJoint"),
            ["Right Arm"] = character.Torso:FindFirstChild("Right Shoulder"),
            ["Left Arm"] = character.Torso:FindFirstChild("Left Shoulder"),
            ["Head"] = character.Torso:FindFirstChild("Neck"),
            ["Left Leg"] = character.Torso:FindFirstChild("Left Hip"),
            ["Right Leg"] = character.Torso:FindFirstChild("Right Hip")
        }

        local cf = CFrame.new
        local originalCFrames = {
            ["Torso"] = { C0 = cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), C1 = cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0) },
            ["Right Arm"] = { C0 = cf(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = cf(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) },
            ["Left Arm"] = { C0 = cf(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = cf(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) },
            ["Head"] = { C0 = cf(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), C1 = cf(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0) },
            ["Left Leg"] = { C0 = cf(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = cf(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) },
            ["Right Leg"] = { C0 = cf(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = cf(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) }
        }

        for jointName, joint in pairs(joints) do
            if joint then
                joint.C0 = originalCFrames[jointName].C0
                joint.C1 = originalCFrames[jointName].C1
                joint.Transform = CFrame.new() 
            end
        end


        local newAnimator = Instance.new("Animator")
        newAnimator.Parent = humanoid
        wait(0.05)
        StopAnim = false
        AnimationActive = true
        if animate then
            animate.Enabled = true
            local defaultAnimId = "http://www.roblox.com/asset/?id=180435571"
            animate.idle.Animation1.AnimationId = defaultAnimId
            animate.idle.Animation2.AnimationId = defaultAnimId
            animate.walk:FindFirstChildOfClass("Animation").AnimationId = defaultAnimId
            animate.run:FindFirstChildOfClass("Animation").AnimationId = defaultAnimId
            animate.jump:FindFirstChildOfClass("Animation").AnimationId = defaultAnimId
            animate.fall:FindFirstChildOfClass("Animation").AnimationId = defaultAnimId
        end
            wait(0.1)

            local character = plr.Character or plr.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
            local RootJoint = HumanoidRootPart["RootJoint"]
            local RightShoulder = character.Torso["Right Shoulder"]
            local LeftShoulder = character.Torso["Left Shoulder"]
            local Neck = character.Torso["Neck"]
            local LeftHip = character.Torso["Left Hip"]
            local RightHip = character.Torso["Right Hip"]

        if plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid:FindFirstChild("Animator") then
            plr.Character.Humanoid.Animator:Destroy()
        end
        if plr.Character:FindFirstChild("Animate") then
            plr.Character.Animate.Enabled = false
        end
            local animate = plr.Character:FindFirstChild("Animate")
        if animate then animate.Enabled = false end
                if connection then 
                    connection:Disconnect() 
end
end

Commands[{"respawn", "prespawn"}] = {
	Arguments = {},
	Description = "respawns you with replicatesignal",
	Function = function()
		if not replicatesignal then
			return
		end
		
		replicatesignal(LocalPlayer.ConnectDiedSignalBackend)
		
		task.wait(Players.RespawnTime + 0.25)
		
		IsPerma = false
	end
}

Commands[{"load", "loadstrings"}] = {
	Arguments = {"code"},
	Description = "executes code, simple",
	Function = function(Args)
		local Merge = table.concat(Args or {}, " ")
		if Merge then
			return loadstring(Merge)()
		end
	end
}

Commands[{"rspy", "remotespy"}] = {
	Arguments = {},
	Description = "runs simplespy by 78n",
	Function = function()
		loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
	end
}

Commands[{"Infinite Yield", "explorer"}] = {
	Arguments = {},
	Description = "runs infinite yield by Edge, Zwolf, Moon, Hunter, Toon, Peyton, ATP.",
	Function = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end
}

Commands[{"dex", "explorer"}] = {
	Arguments = {},
	Description = "runs dex explorer by moon and the other guy",
	Function = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end
}

Commands[{"saveinstance", "saveplace", "dumpgame"}] = {
	Arguments = {"safeMode"},
	Description = "uses synsaveins to save place, safemode kicks you to bypass ac",
	Function = function(Args)
		local SafeMode = Args[1]
		SafeMode = string.lower(SafeMode or "") == "true" or string.lower(SafeMode or "") == "y" and true or false

		local Params = {
			RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
			SSI = "saveinstance",
		}
		
		local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
		
		local CustomOptions = { SafeMode = SafeMode }
		
		synsaveinstance(CustomOptions)
	end
}

Commands[{"clickgoto", "cgoto", "cg"}] = {
	Arguments = {},
	Description = "multiuse, ctrl+scroll-click anywhere to be tped",
	Function = function()
		local Character = LocalPlayer.Character

		if Signals['ClickGoto'] then
			Signals['ClickGoto']:Disconnect()
			Signals['ClickGoto'] = nil
			return
		end

		Signals['ClickGoto'] = UserInputService.InputBegan:Connect(function(Input)
			print(
				HoldingControl and Input.UserInputType == Enum.UserInputType.MouseButton3,
				Input.UserInputType == Enum.UserInputType.MouseButton3,
				HoldingControl
			)

			if HoldingControl and Input.UserInputType == Enum.UserInputType.MouseButton3 then
				local RootPart = Character:FindFirstChild("HumanoidRootPart")

				if not RootPart then
					return
				end
				
				RootPart.CFrame = CFrame.new(Mouse.Hit.Position) * CFrame.new(0, 2, 0)
			end
		end)
	end,
}

Commands[{"goto", "tp"}] = {
	Arguments = {"PlayerName"},
	Description = "detection on all devices.",
	Function = function(Args)
		local Character = LocalPlayer.Character
		local Name = Args[1]

		for _, Player: Player in Players:GetPlayers() do
			if string.match(Player.Name:lower(), Name) or string.match(Player.DisplayName:lower(), Name) then
				local Target = Player.Character

				if not Target then
					return
				end

				local RootPart = Character:FindFirstChild("HumanoidRootPart")

				if not RootPart then
					return
				end
				
				local _RootPart = Target.PrimaryPart
				if not _RootPart then
					return
				end

				for _ = 0, 6 do
					RootPart.CFrame = _RootPart.CFrame
				end

				break
			end
		end
	end,
}

Commands[{"r6", "reanim"}] = {
	Arguments = {"noclip"},
	Description = "loads r6 reanimate, requires ragdoll",
	Function = function(Args)
		local Noclip = (Args[1] == "true" or Args[1] == "yes" or Args[1] == "y") and true or false)
		Reanimate(Noclip)
	end
}

Commands[{"mute", "muteanimsongs"}] = {
	Arguments = {},
	Description = "mutes animation songs",
	Function = function()
		Music.Volume = Music.Volume == 0 and 0.5 or 0
	end
}
Commands[{"unmute", "muteanimsongs"}] = {
	Arguments = {},
	Description = "unmutes animation songs",
	Function = function()
		Music.Volume = .5
	end
}

Commands[{"prefix", "pr"}] = {
	Arguments = {"newPrefix"},
	Description = "changes prefix (default is ;)",
	Function = function(Args)
		local NewKeyName = Args[1]
		local FoundKeyCode = FindKeyCode(NewKeyName)

		if FoundKeyCode then
			Prefix = FoundKeyCode
			ExecutionBarInput.PlaceholderText = `Input here. Prefix: {NewKeyName}`
		end
	end
}

local ClaimPart = nil
local ClaimPartInUse = nil
local ClaimPartSelection = nil

Commands[{"claimpart", "findpart", "scanpart", "sp"}] = {
	Arguments = {"isBruteforced"},
	Description = "looks for unclaimed part, bruteforce makes it claim a part manually (might be dtc).",
	Function = function(Args)
		local BruteForce = Args[1] or ""
		BruteForce = string.lower(BruteForce) 
		BruteForce = BruteForce == "true" or BruteForce == "yes" or BruteForce == "y" and true or false
		
		if BruteForce then
			print(`[freesmart.xyz] bruteforce scan for a part started, might take a bit`)
		end

		if ClaimPart then
			ClaimPart = nil;

			if ClaimPartSelection and ClaimPartSelection.Parent then
				ClaimPartSelection:Destroy()
			end
		end

		local PartsToBruteForce = {}
		local FoundParts = {}

		for _, Part in workspace:GetDescendants() do
			local function ScanForJoints(Model)
				local Flagged;

				for _, Joint in Model:GetDescendants() do
					if Joint:IsA("JointInstance") or Joint:IsA("WeldConstraint") or Joint:IsA("Weld") or Joint:IsA("ManualWeld") then
						if Joint.Part0 == Part or Joint.Part1 == Part then
							Flagged = true
							break
						end
					elseif Joint:IsA("BallSocketConstraint") then
						Flagged = true
						break
					end
				end

				return Flagged
			end

			local function ScanForFundamentals(Parent)
				if not Parent or Parent == workspace then
					return false
				end

				if Parent and Players:FindFirstChild(Parent.Name) then
					return true
				end
	
				if Parent and Parent:FindFirstChild("HumanoidRootPart") then
					return true
				end
	
				if Parent and Parent:IsA("Model") then
					if Parent.PrimaryPart then
						return true
					end
	
					if ScanForJoints(Parent) then
						return true
					end
				end
			end

			if not Part:IsA("Part") then
				continue
			end

			if Part.Anchored or not Part.CanCollide or ScanForJoints(Part) then
				continue
			end

			local Parent = Part.Parent

			if ScanForFundamentals(Parent) then
				continue
			end

			local Descendant = Parent.Parent and Parent.Parent -- luau

			if ScanForFundamentals(Descendant) then
				continue
			end

			if Part.ReceiveAge == 0 then
				ClaimPart = Part
				FoundParts[#FoundParts+1] = Part
			else
				if BruteForce then
					PartsToBruteForce[#PartsToBruteForce+1] = Part
				end
			end
		end

		local Root = LocalPlayer.Character.PrimaryPart
		local PrimaryPos = Root.CFrame * CFrame.new(0, 2, 0)

		if BruteForce then
			for _, Part in PartsToBruteForce do
				Root.CFrame = Part.CFrame * CFrame.new(10, 10, math.random(-10, 10))
				task.wait()
				Root.Anchored = true
				task.wait(0.08)
				Root.Anchored = false
				Root.CFrame = PrimaryPos
				Root.Anchored = true
				Root.Anchored = false
				if Part.ReceiveAge == 0 then
					FoundParts[#FoundParts+1] = Part

					if #FoundParts == 10 then
						break
					end
					
					continue
				end
			end

			table.clear(PartsToBruteForce)
		end

		local LastMagnitude = 0
		local CurrentPart;

		for _, v in FoundParts do
			local CurrentMagnitude = v.Size.Magnitude

			if CurrentMagnitude > LastMagnitude then
				LastMagnitude = CurrentMagnitude
				CurrentPart = v
			end
		end

		if not CurrentPart then
			warn(`[freesmart.xyz] failed to locate an unanchored part with collisions, sorry :-(`)
			return
		end

		if BruteForce and Root and CurrentPart then
			local PrimaryPos = Root.CFrame
			Root.CFrame = CurrentPart.CFrame * CFrame.new(10, 10, math.random(-10, 10))
			task.wait()
			Root.Anchored = true

			task.wait(0.16)
			Root.Anchored = false
			CurrentPart.AssemblyLinearVelocity = Vector3.zero
			CurrentPart.AssemblyAngularVelocity = Vector3.zero
			CurrentPart.CFrame = PrimaryPos * CFrame.new(0, 0, 10)
			Root.CFrame = PrimaryPos
			Root.Anchored = true
			Root.Anchored = false
		end

		ClaimPart = CurrentPart
		ClaimPartSelection = Instance.new("SelectionBox", ClaimPart)
		ClaimPartSelection.Adornee = ClaimPart

		warn(`[freesmart.xyz] located largest part: {CurrentPart:GetFullName()}`)
	end
}

Commands[{"isclaimed", "ispartclaimed"}] = {
	Arguments = {},
	Description = "prints true/false if claimpart exists and is claimed",
	Function = function()
		local Check = ClaimPart and ClaimPart.ReceiveAge == 0
		print(Check)
	end
}

Commands[{"stopclaim", "declaim", "unclaim", "delclaim"}] = {
	Arguments = {},
	Description = "Removes the Claim from the ClaimPart ",
	Function = function()
		ClaimPart = nil;
		if ClaimPartSelection and ClaimPartSelection.Parent then
			ClaimPartSelection:Destroy()
		end
	end
}

Commands[{"claimfling", "cpfling"}] = {
	Arguments = {},
	Description = "(Requires ClaimPart) CTRL + ScrollClick to fling someoneone",
	Function = function()
		if Signals['ClaimFlingLoop'] then
			Signals['ClaimFlingLoop']:Disconnect()
			Signals['ClaimFlingLoop'] = nil

			return
		end

		if not ClaimPart or ClaimPart and not ClaimPart.ReceiveAge == 0 then
			warn(`[freesmart.xyz] ClaimPart is not existant.`)
		end

		Signals['ClaimFlingLoop'] = UserInputService.InputBegan:Connect(function(Input)
			if HoldingControl and Input.UserInputType == Enum.UserInputType.MouseButton3 then
				if not ClaimPart or ClaimPart and not ClaimPart.ReceiveAge == 0 then
					warn(`[freesmart.xyz] ClaimPart is not existant.`)

					return
				end

				local ___ =  Mouse.Target
				local _1 = ___ and ___.Parent

				local Target = ___ and (_1 and _1:IsA("Model") and _1 or _1.Parent:IsA("Model") and _1.Parent)
				
				if not Target then
					return
				end

				local _RootPart = Target.PrimaryPart
				if not _RootPart then
					return
				end

				ClaimPartInUse = true

				for _ = 0, 32 do
					ClaimPart.AssemblyLinearVelocity = Vector3.new(1,1,1) * 1200
					ClaimPart.CFrame = _RootPart.CFrame + Vector3.new(0, math.random(-2, 2), 0) + _RootPart.AssemblyLinearVelocity / 2

					task.wait()
				end
				
				ClaimPartInUse = false
			end
		end)
	end
}

Signals[#Signals+1] = RunService.PostSimulation:Connect(function()
	if not ExecutionCentre or ExecutionCentre.Parent == nil then
		for Index, Signal in Signals do
			Signal:Disconnect()
			Signals[Index] = nil
		end

		return
	end

	if ClaimPartInUse then
		return
	end

	if not ClaimPart then
		return
	end

	local Character = LocalPlayer.Character

	if not Character and Character.PrimaryPart then
		return
	end

	pcall(sethiddenproperty, LocalPlayer, "SimulationRadius", 1000)
	
	if ClaimPart.ReceiveAge == 0 then
		ClaimPart.AssemblyLinearVelocity = Vector3.new(30, 30, 30)
		ClaimPart.CFrame = Character.PrimaryPart.CFrame * CFrame.new(0, 20, 0)
	else
		ClaimPart = nil
		warn(`[freesmart.xyz] lost ownership for ClaimPart.`)
	end
end)

for i,v in pairs(Commands) do
	AddCommand(i[1],v.Arguments,v.Description,nil,false)
end

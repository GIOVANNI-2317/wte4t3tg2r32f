local plr = game:GetService("Players").LocalPlayer
	local replicatedStorage = game:GetService("ReplicatedStorage")
	local tweenService = game:GetService("TweenService")
	local userInputService = game:GetService("UserInputService")

	local screenGui = Instance.new("ScreenGui", plr.PlayerGui)
	local instantCathcActived = Instance.new("BoolValue", screenGui)
	instantCathcActived.Name = "actived"
	instantCathcActived.Value = false

	local frame = Instance.new("Frame", screenGui)
	frame.Size = UDim2.new(0.245, 0, 0.328, 0)
	frame.Position = UDim2.new(0.217, 0, 0.162, 0)
	frame.BackgroundColor3 = Color3.fromRGB(59, 59, 59)

	local stroke = Instance.new("UIStroke", frame)
	stroke.Color = Color3.fromRGB(0, 0, 0)
	stroke.Thickness = 2.3

	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, 8)

	local label = Instance.new("TextLabel", frame)
	label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold)
	label.Size = UDim2.new(1, 0, 0.24, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.Text = "Fisch Modded Hacks V 1.0"
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 15
	label.BackgroundTransparency = 1

	local button = Instance.new("TextButton", frame)
	button.Position = UDim2.new(0.129, 0, 0.448, 0)
	button.Size = UDim2.new(0.742, 0, 0.363, 0)
	button.Text = "Instant Catch"
	button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold)
	button.BackgroundTransparency = 0.5
	button.TextSize = 30
	
	local cornerButton = corner:Clone()
	cornerButton.Parent = button
	
	local closeButton = Instance.new("TextButton", frame)
	closeButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold)
	closeButton.Text = "X"
	closeButton.Position = UDim2.new(0.853, 0,0, 0)
	closeButton.Size = UDim2.new(0.145, 0,0.233, 0)
	closeButton.TextSize = 30
	closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
	closeButton.BackgroundTransparency = 1
	
	closeButton.MouseButton1Click:Connect(function()
		screenGui:Destroy()
	end)

	local function changeColor()
		if instantCathcActived.Value == false then
			button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		else
			button.BackgroundColor3 = Color3.fromRGB(60, 255, 0)
		end
	end

	instantCathcActived.Changed:Connect(changeColor)
	changeColor()

	local dragging = false
	local dragStart, startPos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)

	frame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	userInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			local tween = tweenService:Create(frame, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = newPos})
			tween:Play()
		end
	end)
	
	local hackValue = replicatedStorage:WaitForChild("playerstats"):WaitForChild(plr.Name):FindFirstChild("Settings"):FindFirstChild("instantCatchEnabled")
	if hackValue then
		button.Activated:Connect(function()
			if instantCathcActived then
				hackValue.Value = false
				instantCathcActived = false
				button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			else
				hackValue.Value = true
				instantCathcActived = true
				button.BackgroundColor3 = Color3.fromRGB(60, 255, 0)
			end
		end)
	else
		warn("Instant Catch Value not found")
	end
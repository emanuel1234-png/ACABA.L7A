-- InfiniteJumpScript.lua
-- Coloque isso como LocalScript em StarterPlayerScripts

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function waitForHumanoid()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    while not humanoid do
        character = player.Character or player.CharacterAdded:Wait()
        humanoid = character:FindFirstChildOfClass("Humanoid")
        task.wait(0.1)
    end
    return humanoid
end

local humanoid = waitForHumanoid()

local infiniteJumpEnabled = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "InfiniteJumpGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.5, -75, 0.8, 0)
button.Text = "Infinite Jump OFF"
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.BorderSizePixel = 0
button.TextScaled = true
button.Font = Enum.Font.SourceSansBold
button.Parent = screenGui

-- RGB Loop
task.spawn(function()
	while true do
		for i = 0, 255, 2 do
			button.BackgroundColor3 = Color3.fromHSV(i/255, 1, 1)
			task.wait(0.01)
		end
	end
end)

-- Toggle infinite jump
button.MouseButton1Click:Connect(function()
	infiniteJumpEnabled = not infiniteJumpEnabled
	if infiniteJumpEnabled then
		button.Text = "Infinite Jump ON"
	else
		button.Text = "Infinite Jump OFF"
	end
end)

-- Infinite jump logic
UIS.JumpRequest:Connect(function()
	if infiniteJumpEnabled then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

print("✅ Infinite Jump Script Loaded!")

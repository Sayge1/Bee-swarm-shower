local TweenService = game:GetService("TweenService")
local Players = game.Players
local Player = Players.LocalPlayer
a = 0
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumRoot = Character:WaitForChild("HumanoidRootPart")
workspace = game:GetService("Workspace")
particles = workspace.Particles
local backlog = {}
game:GetService('RunService').Heartbeat:connect(function()
    if a == 0 then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 70 end
end)    
particles.ChildAdded:Connect(function(child)
    if child.Name == "WarningDisk" then
        table.insert(backlog, child)
    end
end)
while true do
    local object = backlog[1]
    if not object then
        particles.ChildAdded:Wait()
        continue
    end
    goal = {CFrame = object.CFrame}
    local tweeninfo = TweenInfo.new(0.05, Enum.EasingStyle.Sine,Enum.EasingDirection.Out, 0, false, 0)
    local tween = TweenService:Create(HumRoot, tweeninfo, goal)
    tween:Play()
    a = 1
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
    table.remove(backlog, 1)
    repeat
        task.wait(0.01)
    until object.Parent == nil
    a = 0
end

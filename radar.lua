-- Radar Script by Blissful#4992

local function Radar(state)
    if not state then
        -- Désactiver le radar
        for _, obj in ipairs(getgc(true)) do
            if typeof(obj) == "Instance" and obj:IsA("Drawing") then
                obj:Remove()
            end
        end
        return
    end

    -- Activer le radar
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Mouse = Player:GetMouse()
    local Camera = game:GetService("Workspace").CurrentCamera
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")

    local RadarInfo = {
        Position = Vector2.new(200, 200),
        Radius = 100,
        Scale = 1,
        RadarBack = Color3.fromRGB(10, 10, 10),
        RadarBorder = Color3.fromRGB(75, 75, 75),
        LocalPlayerDot = Color3.fromRGB(255, 255, 255),
        PlayerDot = Color3.fromRGB(60, 170, 255),
        Team = Color3.fromRGB(0, 255, 0),
        Enemy = Color3.fromRGB(255, 0, 0),
        Team_Check = true
    }

    local function NewCircle(Transparency, Color, Radius, Filled, Thickness)
        local c = Drawing.new("Circle")
        c.Transparency = Transparency
        c.Color = Color
        c.Visible = false
        c.Thickness = Thickness
        c.Position = Vector2.new(0, 0)
        c.Radius = Radius
        c.NumSides = math.clamp(Radius * 55 / 100, 10, 75)
        c.Filled = Filled
        return c
    end

    local RadarBackground = NewCircle(0.9, RadarInfo.RadarBack, RadarInfo.Radius, true, 1)
    RadarBackground.Visible = true
    RadarBackground.Position = RadarInfo.Position

    local RadarBorder = NewCircle(0.75, RadarInfo.RadarBorder, RadarInfo.Radius, false, 3)
    RadarBorder.Visible = true
    RadarBorder.Position = RadarInfo.Position

    local function GetRelative(pos)
        local char = Player.Character
        if char and char.PrimaryPart then
            local pmpart = char.PrimaryPart
            local camerapos = Vector3.new(Camera.CFrame.Position.X, pmpart.Position.Y, Camera.CFrame.Position.Z)
            local newcf = CFrame.new(pmpart.Position, camerapos)
            local r = newcf:PointToObjectSpace(pos)
            return r.X, r.Z
        else
            return 0, 0
        end
    end

    local function PlaceDot(plr)
        local PlayerDot = NewCircle(1, RadarInfo.PlayerDot, 3, true, 1)

        local function Update()
            local connection
            connection = RunService.RenderStepped:Connect(function()
                local char = plr.Character
                if char and char:FindFirstChild("Humanoid") and char.PrimaryPart and char:FindFirstChild("Humanoid").Health > 0 then
                    local scale = RadarInfo.Scale
                    local relx, rely = GetRelative(char.PrimaryPart.Position)
                    local newpos = RadarInfo.Position - Vector2.new(relx * scale, rely * scale)

                    if (newpos - RadarInfo.Position).magnitude < RadarInfo.Radius - 2 then
                        PlayerDot.Radius = 3
                        PlayerDot.Position = newpos
                        PlayerDot.Visible = true
                    else
                        local dist = (RadarInfo.Position - newpos).magnitude
                        local calc = (RadarInfo.Position - newpos).unit * (dist - RadarInfo.Radius)
                        local inside = Vector2.new(newpos.X + calc.X, newpos.Y + calc.Y)
                        PlayerDot.Radius = 2
                        PlayerDot.Position = inside
                        PlayerDot.Visible = true
                    end

                    if RadarInfo.Team_Check then
                        if plr.TeamColor == Player.TeamColor then
                            PlayerDot.Color = RadarInfo.Team
                        else
                            PlayerDot.Color = RadarInfo.Enemy
                        end
                    end
                else
                    PlayerDot.Visible = false
                    if not Players:FindFirstChild(plr.Name) then
                        PlayerDot:Remove()
                        connection:Disconnect()
                    end
                end
            end)
        end

        coroutine.wrap(Update)()
    end

    for _, v in pairs(Players:GetPlayers()) do
        if v.Name ~= Player.Name then
            PlaceDot(v)
        end
    end

    Players.PlayerAdded:Connect(function(v)
        if v.Name ~= Player.Name then
            PlaceDot(v)
        end
    end)
end

return Radar

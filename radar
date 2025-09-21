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
    local workspace = game:GetService("Workspace")
    local player = game:GetService("Players").LocalPlayer
    local camera = workspace.CurrentCamera

    local Box_Color = Color3.fromRGB(3, 143, 254)
    local Box_Thickness = 2
    local Box_Transparency = 1
    local Tracers = false
    local Tracer_Color = Color3.fromRGB(255, 0, 0)
    local Tracer_Thickness = 2
    local Tracer_Transparency = 1
    local Shifter_Color = Color3.fromRGB(3, 143, 254)
    local Autothickness = true
    local Team_Check = false
    local red = Color3.fromRGB(240, 20, 20)
    local green = Color3.fromRGB(90, 215, 25)

    local function Lerp(a, b, t)
        return a + (b - a) * t
    end

    local function NewLine()
        local line = Drawing.new("Line")
        line.Visible = false
        line.From = Vector2.new(0, 0)
        line.To = Vector2.new(1, 1)
        line.Color = Box_Color
        line.Thickness = Box_Thickness
        line.Transparency = Box_Transparency
        return line
    end

    for _, v in pairs(game.Players:GetChildren()) do
        local lines = {
            line1 = NewLine(),
            line2 = NewLine(),
            line3 = NewLine(),
            line4 = NewLine(),
            line5 = NewLine(),
            line6 = NewLine(),
            line7 = NewLine(),
            line8 = NewLine(),
            line9 = NewLine(),
            line10 = NewLine(),
            line11 = NewLine(),
            line12 = NewLine(),
            Tracer = NewLine()
        }

        lines.Tracer.Color = Tracer_Color
        lines.Tracer.Thickness = Tracer_Thickness
        lines.Tracer.Transparency = Tracer_Transparency

        local Shifter = Drawing.new("Quad")
        Shifter.Visible = false
        Shifter.Color = Shifter_Color
        Shifter.Thickness = Box_Thickness
        Shifter.Filled = false
        Shifter.Transparency = Box_Transparency

        local function ESP()
            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Name ~= player.Name and v.Character.Humanoid.Health > 0 then
                    -- Logique pour dessiner les boîtes 3D et les traceurs
                    -- (Code principal ici, identique à votre code existant)
                else
                    for _, line in pairs(lines) do
                        line.Visible = false
                    end
                    Shifter.Visible = false
                    if not game.Players:FindFirstChild(v.Name) then
                        connection:Disconnect()
                    end
                end
            end)
        end

        coroutine.wrap(ESP)()
    end
end

return Radar

-- shim for missing executor functions
-- kinda ass on touch interest and click detector stuff but theres not much else i can do

if not fireproximityprompt then
    getgenv().fireproximityprompt = function(prompt)
        if prompt and prompt:IsA("ProximityPrompt") then
            prompt:InputHoldBegin()
            prompt:InputHoldEnd()
        end
    end
end

if not firetouchinterest then
    local inprogess = false
    getgenv().firetouchinterest = function(part, touch)
        if inprogress then return end
        if part and part:IsA("BasePart") and touch and touch:IsA("BasePart") then
            inprogess = true
            local anchor, collide, trans, cf = part.CFrame, part.CanCollide, part.Anchored, part.Transparency
            part.Anchored, part.CanCollide, part.Transparency, part.CFrame = true, false, 1, touch.CFrame
            task.wait()
            part.Anchored, part.CanCollide, part.Transparency, part.CFrame = anchor, collide, trans, cf
            inprogess = false
        end
    end
end

if not fireclickdetector then -- credits to: https://raw.githubusercontent.com/astacodes/Luau-ENV/refs/heads/main/Instance.lua
    local RunService = game:GetService("RunService")
    local VirtualUser = game:GetService("VirtualUser")

    getgenv().fireclickdetector = function(detector, distance)
        local oldParent, oldMax = detector.Parent, detector.MaxActivationDistance
        local tmp = Instance.new("Part", workspace)
        tmp.Size, tmp.Anchored, tmp.CanCollide, tmp.Transparency = Vector3.new(30,30,30), true, false, 1
        detector.Parent, detector.MaxActivationDistance = tmp, math.huge
        local conn
        conn = RunService.Heartbeat:Connect(function()
            local cam = workspace.CurrentCamera
            tmp.CFrame = cam.CFrame * CFrame.new(0,0,-20) + cam.CFrame.LookVector
            VirtualUser:ClickButton1(Vector2.new(20,20), cam.CFrame)
        end)
        detector.MouseClick:Once(function()
            conn:Disconnect()
            detector.Parent, detector.MaxActivationDistance = oldParent, oldMax
            tmp:Destroy()
        end)
    end
end

if not getcallbackvalue then
    getgenv().getcallbackvalue = function(i, p)
        if i and type(p) == "string" then
            local s, v = pcall(function() return i[p] end)
            if s and type(v) == "function" then return v end
        end
        return function() end
    end
end

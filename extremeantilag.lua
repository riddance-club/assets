local Lighting = game:GetService("Lighting")

Lighting.GlobalShadows = false
Lighting.FogStart = 0
Lighting.FogEnd = 9e9
Lighting.Brightness = 2
Lighting.ClockTime = 14
Lighting.Ambient = Color3.fromRGB(255, 255, 255)
Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
Lighting.ExposureCompensation = 0

settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04

local Terrain = workspace:FindFirstChildWhichIsA("Terrain")
if Terrain then
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 1
end

local function optimizeInstance(v)
	if v:IsA("BasePart") then
		v.CastShadow = false
		v.Material = Enum.Material.SmoothPlastic
		v.Reflectance = 0
		v.BackSurface = Enum.SurfaceType.Smooth
		v.BottomSurface = Enum.SurfaceType.Smooth
		v.FrontSurface = Enum.SurfaceType.Smooth
		v.LeftSurface = Enum.SurfaceType.Smooth
		v.RightSurface = Enum.SurfaceType.Smooth
		v.TopSurface = Enum.SurfaceType.Smooth
		if v:IsA("MeshPart") then
			v.TextureID = ""
		end
	elseif v:IsA("Decal") or v:IsA("Texture") then
		v.Transparency = 1
		v.Texture = ""
	elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
		v.Enabled = false
		v.Lifetime = NumberRange.new(0)
	elseif v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("PostEffect") or v:IsA("Light") or v:IsA("Highlight") or v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("Beam") then
		v.Enabled = false
	elseif v:IsA("SurfaceAppearance") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("Accessory") then
		v:Destroy()
	elseif v:IsA("SpecialMesh") then
		v.TextureId = ""
	end
end

for _, v in pairs(game:GetDescendants()) do
	  pcall(optimizeInstance, v)
end

workspace.DescendantAdded:Connect(optimizeInstance)
Lighting.DescendantAdded:Connect(optimizeInstance)

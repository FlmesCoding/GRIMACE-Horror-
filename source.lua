
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "NexusX - GRIMACE [Horror]", HidePremium = false, SaveConfig = true, ConfigFolder = "NexusX"})

local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://9405923687",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Movement"
})

-- Walkspeed slider
Section:AddSlider({
    Name = "Walkspeed",
    Min = 0,
    Max = 100,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "walkspeed",
    Callback = function(Value)
        coroutine.wrap(function()
            while true do
                wait(0.1) -- Wait for 0.1 seconds
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
            end
        end)()
    end    
})

local Section2 = Tab:AddSection({
    Name = "Visuals"
})

local keyESPs = {}
local keys = {
	{object = game:GetService("Workspace").Items["Pink Key"].Key.Key, color = Color3.fromRGB(255, 105, 180)},
	{object = game:GetService("Workspace").Items["Green Key"]:GetChildren()[2].Key, color = Color3.fromRGB(0, 255, 0)},
	{object = game:GetService("Workspace").Items["Green Key"].Key.Key, color = Color3.fromRGB(0, 255, 0)},
	{object = game:GetService("Workspace").Items["Blue Key"].Key.Key, color = Color3.fromRGB(0, 0, 255)},
	{object = game:GetService("Workspace").Items["Red Key"]:GetChildren()[2].Key, color = Color3.fromRGB(255, 0, 0)},
	{object = game:GetService("Workspace").Items["Red Key"].Key.Key, color = Color3.fromRGB(255, 0, 0)},
	{object = game:GetService("Workspace").Items["White Key"].Key.Key, color = Color3.fromRGB(255, 255, 255)},
	{object = game:GetService("Workspace").Items["Yellow Key"].Key.Key, color = Color3.fromRGB(255, 255, 0)},
}

Section2:AddToggle({
	Name = "Keys",
	Default = false,
	Callback = function(Value)
		if Value then -- Turn on ESP
			for _, keyData in ipairs(keys) do
				local esp = Instance.new("BillboardGui")
				esp.Adornee = keyData.object
				esp.AlwaysOnTop = true
				esp.Size = UDim2.new(0, 200, 0, 50)
				esp.Parent = keyData.object

				local textLabel = Instance.new("TextLabel")
				textLabel.Size = UDim2.new(1, 0, 1, 0)
				textLabel.BackgroundTransparency = 1
				textLabel.TextColor3 = keyData.color
				textLabel.Text = keyData.object.Name
				textLabel.Parent = esp

				table.insert(keyESPs, esp)
			end
		else -- Turn off ESP
			for _, esp in ipairs(keyESPs) do
				esp:Destroy()
			end
			keyESPs = {}
		end
	end    
})




local collectibleESPs = {}

Section2:AddToggle({
	Name = "Shakes",
	Default = false,
	Callback = function(Value)
		local collectibles = game:GetService("Workspace").Collectibles:GetChildren()
		
		if Value then -- Turn on ESP
			for _, collectible in ipairs(collectibles) do
				if collectible:IsA("MeshPart") then
					local esp = Instance.new("BillboardGui")
					esp.Adornee = collectible
					esp.AlwaysOnTop = true
					esp.Size = UDim2.new(0, 200, 0, 50)
					esp.Parent = collectible

					local textLabel = Instance.new("TextLabel")
					textLabel.Size = UDim2.new(1, 0, 1, 0)
					textLabel.BackgroundTransparency = 1
					textLabel.TextColor3 = Color3.new(1, 1, 1) -- White text
					textLabel.Text = collectible.Name
					textLabel.Parent = esp

					table.insert(collectibleESPs, esp)
				end
			end
		else -- Turn off ESP
			for _, esp in ipairs(collectibleESPs) do
				esp:Remove()
			end
			collectibleESPs = {}
		end
	end    
})


local doorESPs = {}

local doors = {
	"Pink Key",
	"Red Key",
	"Green Key",
	"Blue Key",
}

Section2:AddToggle({
	Name = "Doors",
	Default = false,
	Callback = function(Value)
		local workspaceDoors = game:GetService("Workspace").Doors
		
		if Value then -- Turn on ESP
			for _, doorName in ipairs(doors) do
				local door = workspaceDoors[doorName].Door
				if door then
					local esp = Instance.new("BillboardGui")
					esp.Adornee = door
					esp.AlwaysOnTop = true
					esp.Size = UDim2.new(0, 200, 0, 50)
					esp.Parent = door

					local textLabel = Instance.new("TextLabel")
					textLabel.Size = UDim2.new(1, 0, 1, 0)
					textLabel.BackgroundTransparency = 1
					textLabel.TextColor3 = keys[doorName] or Color3.new(1, 1, 1) -- Use same color as key or default to white
					textLabel.Text = doorName
					textLabel.Parent = esp

					table.insert(doorESPs, esp)
				end
			end
		else -- Turn off ESP
			for _, esp in ipairs(doorESPs) do
				esp:Remove()
			end
			doorESPs = {}
		end
	end    
})



local entityESP = nil

Section2:AddToggle({
	Name = "Grimace",
	Default = false,
	Callback = function(Value)
		local entity = game:GetService("Workspace").Entity
		if not entity then
			print("No Entity found in Workspace!")
			return
		end
		
		if Value then -- Turn on ESP
			entityESP = Instance.new("BillboardGui")
			entityESP.Adornee = entity
			entityESP.AlwaysOnTop = true
			entityESP.Size = UDim2.new(0, 200, 0, 50)
			entityESP.Parent = entity

			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, 0, 1, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.TextColor3 = Color3.new(1, 1, 1) -- White text
			textLabel.Text = "Entity"
			textLabel.Parent = entityESP
		else -- Turn off ESP
			if entityESP then
				entityESP:Remove()
				entityESP = nil
			end
		end
	end    
})

OrionLib:Init()

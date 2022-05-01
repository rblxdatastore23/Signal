	Signal = loadstring(game:GetService("HttpService"):GetAsync("https://gist.githubusercontent.com/RealEthanPlayzDev/c66c91006d75fc89c43171a372587bdb/raw/ad3baf63fa320e14edf83e18d92b07ce549d5256/RESignal.luau"))()
        local Mouse = {}
        local Camera = {}
        mouse = Mouse;
	mouse.Hit = CFrame.new()
	mouse.Origin = CFrame.new()
        Camera.CFrame = CFrame.new();
Camera.FieldOfView = 70;
Camera.Focus = CFrame.new()
Camera.CameraType = Enum.CameraType.Fixed
Camera.CameraSubject = nil;
Camera.ViewportSize = Vector2.new();
Camera.Changed = Signal.new(1)

	mouse.UnitRay = Ray.new(Vector3.new(0,0,0),Vector3.new(-1,0,0))
	mouse.X = 0
	mouse.Y = 0
	mouse.Target = nil
	mouse.TargetFilter = nil
	mouse.Button1Down = Signal.new(1)
	mouse.Button1Up = Signal.new(1)
	mouse.Button1Down = Signal.new(1)	
	mouse.Button1Up = Signal.new(1)
	mouse.Idle = Signal.new(1)
	mouse.Move = Signal.new(1)
        mouse.WheelBackward = Signal.new(1)
        mouse.WheelForward = Signal.new(1) 

        mouse.KeyDown = Signal.new(1);
        mouse.KeyUp = Signal.new(1);
	local update_mouse = Instance.new("RemoteFunction", owner.Character)
	update_mouse.Name = "Mouse_Handler"
local update_camera = Instance.new("RemoteFunction", owner.Character)
	update_camera.Name = "Camera_Handler"
	local update_mouse_func = Instance.new("RemoteFunction", owner.Character)
	update_mouse_func.Name = "Mouse_Func"
local update_camera_func = Instance.new("RemoteFunction", owner.Character)
	update_camera_func.Name = "Cam_Func"
	update_mouse.OnServerInvoke = function(Player,Data)
		for i,v in pairs(Data) do
			for ii,vv in pairs(mouse) do
				if i == ii then
					mouse[i] = v
				end
			end
		end
		return mouse
	end
update_camera.OnServerInvoke = function(Player,Data)
		for i,v in pairs(Data) do
			for ii,vv in pairs(Camera) do
				if i == ii then
					Camera[i] = v
				end
			end
		end
		return Camera
	end
	update_mouse_func.OnServerInvoke = function(Player,...)
		local A = table.pack(...)
	Func = A[1]
		if mouse[Func] ~= nil and type(mouse[Func]) == "table" then
			if x ~= nil then
			mouse[Func]:Fire(unpack(A, 2, table.maxn(A)))
			else
			mouse[Func]:Fire()
			end
		end
	end
update_camera_func.OnServerInvoke = function(Player,...)
	local A = table.pack(...)
	Func = A[1]
	
		if Camera[Func] ~= nil and type(Camera[Func]) == "table" then
			if x ~= nil then
			Camera[Func]:Fire(unpack(A, 2, table.maxn(A)))
			else
			Camera[Func]:Fire()
			end
		end
	end

NLS([[
local update_mouse = owner.Character:WaitForChild("Mouse_Handler",10^99)
local update_camera = owner.Character:WaitForChild("Camera_Handler",10^99)
local update_mouse_func = owner.Character:WaitForChild("Mouse_Func",10^99)
local update_camera_func = owner.Character:WaitForChild("Cam_Func",10^99)
local mouse = owner:GetMouse()
local camera = workspace.CurrentCamera
if update_mouse then
game:GetService("RunService").RenderStepped:Connect(function()
local mouse_table = update_mouse:InvokeServer({X = mouse.X,Y = mouse.Y,UnitRay = mouse.UnitRay,Origin = mouse.Origin,Hit = mouse.Hit,Target = mouse.Target,TargetFilter = mouse.TargetFilter})
local camera_table = update_camera:InvokeServer({CFrame = camera.CFrame, FieldOfView = camera.FieldOfView, Focus = camera.Focus, CameraType = camera.CameraType, CameraSubject = camera.CameraSubject, ViewportSize = camera.ViewportSize})
end)
end
mouse.Button1Down:Connect(function()
update_mouse_func:InvokeServer("Button1Down")
end)
mouse.Button1Up:Connect(function()
update_mouse_func:InvokeServer("Button1Up")
end)
mouse.Button2Down:Connect(function()
update_mouse_func:InvokeServer("Button2Down")
end)
mouse.Button2Up:Connect(function()
update_mouse_func:InvokeServer("Button2Up")
end)
mouse.Move:Connect(function()
update_mouse_func:InvokeServer("Move")
end)
mouse.Idle:Connect(function()
update_mouse_func:InvokeServer("Idle")
end)
mouse.WheelBackward:Connect(function()
update_mouse_func:InvokeServer("WheelBackward")
end)
mouse.WheelForward:Connect(function()
update_mouse_func:InvokeServer("WheelForward")
end)
mouse.KeyUp:Connect(function(Key)
update_mouse_func:InvokeServer("KeyUp",Key)
end)
mouse.KeyDown:Connect(function(Key)
update_mouse_func:InvokeServer("KeyDown",Key)
end)
camera.Changed:Connect(function(...) update_camera_func:InvokeServer("Changed", ...) end)
]],owner.PlayerGui)
return mouse, Camera

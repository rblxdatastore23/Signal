	if _G.Signal ~= nil then
	Signal = _G.Signal
	end
        local mouse = {}

	mouse.Hit = CFrame.new()
	mouse.Origin = CFrame.new()
	mouse.UnitRay = Ray.new(Vector3.new(0,0,0),Vector3.new(-1,0,0))
	mouse.X = 0
	mouse.Y = 0
	mouse.Target = nil
	mouse.TargetFilter = nil
	mouse.Button1Down = Signal.new()
	mouse.Button1Up = Signal.new()
	mouse.Button1Down = Signal.new()	
	mouse.Button1Up = Signal.new()
	mouse.Idle = Signal.new()
	mouse.Move = Signal.new()
	local update_mouse = Instance.new("RemoteFunction",owner.Character)
	update_mouse.Name = "Mouse_Handler"
	local update_mouse_func = Instance.new("RemoteFunction",owner.Character)
	update_mouse_func.Name = "Mouse_Func"

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
	update_mouse_func.OnServerInvoke = function(Player,Func)
		if mouse[Func] ~= nil and type(mouse[Func]) == "table" then
			mouse[Func]:Fire()
		end
	end

NLS([[
local update_mouse = owner.Character:WaitForChild("Mouse_Handler",10^99)
local update_mouse_func = owner.Character:WaitForChild("Mouse_Func",10^99)
local mouse = owner:GetMouse()
if update_mouse then
game:GetService("RunService").Stepped:Connect(function()
local mouse_table = update_mouse:InvokeServer({X = mouse.X,Y = mouse.Y,UnitRay = mouse.UnitRay,Origin = mouse.Origin,Hit = mouse.Hit,Target = mouse.Target,TargetFilter = mouse.TargetFilter})
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
]],owner.PlayerGui)
return mouse

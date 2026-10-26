local L=game:GetService("Lighting")
local U=game:GetService("UserInputService")
local C=L:FindFirstChild("CustomColorCorrection") or Instance.new("ColorCorrectionEffect",L)
C.Name="CustomColorCorrection"

local G=Instance.new("ScreenGui")
G.Name="KibbyPanel"
G.Parent=(gethui and gethui()) or game:GetService("CoreGui")

local F=Instance.new("Frame",G)
F.Size=UDim2.fromOffset(310,260)
F.Position=UDim2.new(.5,-155,.5,-130)
F.BackgroundColor3=Color3.fromRGB(20,20,27)
F.Active=true
Instance.new("UICorner",F).CornerRadius=UDim.new(0,10)
Instance.new("UIDragDetector",F)

local function button(text,y)
 local b=Instance.new("TextButton",F)
 b.Position=UDim2.fromOffset(10,y)
 b.Size=UDim2.fromOffset(290,30)
 b.BackgroundColor3=Color3.fromRGB(35,35,46)
 b.TextColor3=Color3.fromRGB(225,225,235)
 b.Font=Enum.Font.Gotham
 b.TextSize=13
 b.Text=text
 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
 return b
end

local title=button("KIBBY PANEL",5)
title.Font=Enum.Font.GothamBold
title.BackgroundColor3=Color3.fromRGB(55,45,75)

local function slider(name,y,fn)
 local b=button(name.."  |  2.5 / 5",y)
 b.MouseButton1Click:Connect(function()
  local v=2.5
  local box=Instance.new("TextBox",F)
  box.Position=UDim2.fromOffset(70,y+30)
  box.Size=UDim2.fromOffset(170,28)
  box.BackgroundColor3=Color3.fromRGB(40,40,52)
  box.TextColor3=Color3.new(1,1,1)
  box.PlaceholderText="Enter 0–5"
  box.Text=""
  box.FocusLost:Connect(function()
   v=math.clamp(tonumber(box.Text) or 2.5,0,5)
   fn(v)
   b.Text=name.."  |  "..v.." / 5"
   box:Destroy()
  end)
 end)
end

slider("Brightness",42,function(v) C.Brightness=(v-2.5)/2.5 end)
slider("Contrast",77,function(v) C.Contrast=v/2.5-1 end)
slider("Saturation",112,function(v) C.Saturation=v/2.5-1 end)

local colors={Color3.new(1,1,1),Color3.fromRGB(255,170,190),Color3.fromRGB(170,200,255),Color3.fromRGB(180,255,200)}
local i=1
button("Change Tint",147).MouseButton1Click:Connect(function()
 i=i%#colors+1
 C.TintColor=colors[i]
end)

local key=Enum.KeyCode.RightShift
local bind=button("Toggle Key: RightShift",182)
local waiting=false
bind.MouseButton1Click:Connect(function()
 waiting=true
 bind.Text="Press any key..."
end)

U.InputBegan:Connect(function(input,processed)
 if waiting and input.UserInputType==Enum.UserInputType.Keyboard then
  key=input.KeyCode
  bind.Text="Toggle Key: "..key.Name
  waiting=false
 elseif not processed and input.KeyCode==key then
  F.Visible=not F.Visible
 end
end)

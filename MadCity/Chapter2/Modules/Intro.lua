local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")

local blur = Instance.new("BlurEffect", game.Lighting)
blur.Size = 0

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

if not isfolder("Audio") then
    makefolder("Audio")
end

local songPath = "Audio/RubyHub_IntroSound.mp3"

if not isfile(songPath) then
    local success, content = pcall(function()
        return game:HttpGet('https://github.com/aymarko/MadCity-Related/raw/refs/heads/main/RubyHub_IntroSound.mp3')
    end)
    
    if success then
        writefile(songPath, content)
    end
end

local sound = Instance.new("Sound")
sound.Parent = game.Workspace
sound.Volume = 10

if isfile(songPath) then
    local audioAsset = getcustomasset(songPath)
    sound.SoundId = audioAsset
end

sound:Play()


local frames = {
    "113616397450765", "113721642504853", "128535637484055", "83791463181225", "86204986669970",
    "79153456781381", "129965526741923", "86347265176957", "121895208874589", "133515000822799",
    "134652694836524", "107576170290221", "80356244731476", "134094134610253", "99514221782400",
    "132390176876295", "118781489305613", "133958161546576", "102417361783190", "125435018646290",
    "116731841683482", "113963670618033", "98297127471217", "87860734856839", "124402794675967",
    "78486241325313", "111595726141108", "99760416608379", "89211561753519", "104813081112457",
    "100070997872319", "102186833062915", "112032903936569", "80551546442332", "121858023906119",
    "95381363726771", "93020885534862", "80994608121452", "125199732635337", "88328649401978",
    "108101659967674", "138767423950365", "111803605793754", "77946126539866", "111605264288433",
    "117375359104887", "81150739072386", "127583588815642", "70823826431518", "108878233710097",
    "113610525005858", "102068961433925", "113065386447058", "94520155331360", "111026756570537",
    "119657419818967", "89229448650129", "77879124396472", "119757168913450", "104743914170617",
    "132606469669487", "89596616842063", "99286731968108", "129573230033068", "81020624328066",
    "87169245216975", "95565301524275", "125822392989202", "136486407394698", "107075732465846",
    "102737382706816", "114672830482269", "103469272345597", "71071129948125", "73070889950237",
    "91338093785749", "139310248629523", "128304221544850", "74308763248101", "117722546756873",
    "130680293692812", "100909884482987", "93934081890932", "115366620401315", "82721507125623",
    "110494616491682", "104784974315872", "107766691380429", "136288813203242", "76222210904599",
    "131365815867108", "105509015454109", "139613628611676", "103266603861155", "120100862385768",
    "113716130239136", "128760877735271", "94621523698432", "117802834500269", "121136482552655",
    "111538982763190", "82727394176229", "120082042096892", "129693434491234", "124281299778686",
    "103627958150685", "89059418340805", "118152327571398", "110590788842684", "135559270985412",
    "133182294811079", "73621285347640", "137426605231936", "108729609276576", "73487996545174",
    "101578030785418", "118954752197248", "134396144960101", "113007270443902", "138111338271814",
    "76795417309718", "82717263395195", "101733796079271", "84136228392416", "91724745592162",
    "115564147156933", "133416212684517", "84086511568075", "71178755821516", "109495705403953",
    "111538537306228", "124270194808743", "71654606763569", "124873946765062", "79192376753203",
    "119985513809381", "140474823132873", "118087741136190", "76027748403521", "87949629582384",
    "91458954959422", "131524616997412", "120867099544054", "133202993416900", "129231618049594",
    "128940027405491", "96730046334140", "106096196877698", "72664584522645", "97570286233425",
    "100139160690483", "72590191621790", "80060226315046", "85478943606880", "80665491900367",
    "83435986416187", "97550825068754", "84715858407407", "105627259516353", "103119297520846",
    "108511078540099", "85467929780587", "96201295701282", "77977493550026", "86490206212936",
    "72548222545995", "115763614397603", "113669818092141", "121194537546411", "76152963387221",
    "116478020750977", "131418407879711", "137765009388246", "99597603973468"
}

local allFrameAssets = {}
for i = 1, #frames do
	table.insert(allFrameAssets, "rbxassetid://" .. frames[i])
end

local success, err = pcall(function()
	ContentProvider:PreloadAsync(allFrameAssets)
end)

task.wait(0.5)

local frame_data = {}
local currentImageLabel = {
	Size = UDim2.new(0, 0, 0, 0)
}

for i = 1, #frames do
	local frame = Instance.new("ImageLabel")
	local UICorner = Instance.new("UICorner")
	frame.Parent = ScreenGui
	frame.BackgroundColor3 = Color3.new(1, 1, 1)
	frame.BackgroundTransparency = 0
	frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Rotation = 0
	frame.Size = UDim2.new(0, 0, 0, 0)
	frame.ImageTransparency = 0
	frame.Image = "rbxassetid://" .. frames[i]
	frame.ZIndex = 1
	UICorner.CornerRadius = UDim.new(0.1, 0)
	UICorner.Parent = frame
	frame_data[i] = frame
	frame.BackgroundTransparency = 1
	frame.ImageTransparency = 1
end

for i = 1, #frames do
	if frame_data[i] then
		frame_data[i].ImageTransparency = 0
	end
end
task.wait(0.05)
for i = 1, #frames do
	if frame_data[i] then
		frame_data[i].ImageTransparency = 1
	end
end
task.wait(0.05)

local heartbeatConnection
heartbeatConnection = RunService.Heartbeat:Connect(function()
	local targetSize = currentImageLabel.Size
	for i = 1, #frame_data do
		if frame_data[i] and frame_data[i].Size ~= targetSize then
			frame_data[i].Size = targetSize
		end
	end
end)

local LoadingBarContainer = Instance.new("Frame")
LoadingBarContainer.Parent = ScreenGui
LoadingBarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LoadingBarContainer.BackgroundTransparency = 1
LoadingBarContainer.Position = UDim2.new(0.5, 0, 0.5, (263 / 2) + 20)
LoadingBarContainer.Size = UDim2.new(0, 0, 0, 0)
LoadingBarContainer.BorderSizePixel = 0
LoadingBarContainer.AnchorPoint = Vector2.new(0.5, 0)

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(1, 0)
containerCorner.Parent = LoadingBarContainer

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingBarContainer
LoadingBar.BackgroundColor3 = Color3.new(1, 1, 1)
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BorderSizePixel = 0

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = LoadingBar

local PercentageLabel = Instance.new("TextLabel")
PercentageLabel.Parent = ScreenGui
PercentageLabel.BackgroundTransparency = 1
PercentageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentageLabel.Font = Enum.Font.GothamBlack
PercentageLabel.TextSize = 16
PercentageLabel.Position = UDim2.new(0.5, -150, 0.5, (263 / 2) + 32)
PercentageLabel.Size = UDim2.new(0, 300, 0, 30)
PercentageLabel.Text = "0%"
PercentageLabel.TextTransparency = 1
PercentageLabel.TextXAlignment = Enum.TextXAlignment.Center

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = ScreenGui
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.Font = Enum.Font.GothamBlack
InfoLabel.TextSize = 20
InfoLabel.Position = UDim2.new(0.5, -150, 0.5, (263 / 2) + 50)
InfoLabel.Size = UDim2.new(0, 300, 0, 50)
InfoLabel.Text = ""
InfoLabel.TextTransparency = 1
InfoLabel.TextXAlignment = Enum.TextXAlignment.Center

local logs = {
	"Checking for updates...",
	"Getting services...",
	"Initializing modules..."
}

local frameUpdateRate = 0.025
local maxFramesToShow = #frames - 10
local totalFrameTime = maxFramesToShow * frameUpdateRate

local frameAnimationComplete = false
local currentFrame = 1

task.spawn(function()
	while currentFrame <= maxFramesToShow and ScreenGui.Parent do
		for i = 1, #frames do
			if frame_data[i] then
				if i == currentFrame then
					frame_data[i].ImageTransparency = 0
				else
					frame_data[i].ImageTransparency = 1
				end
			end
		end
		currentFrame = currentFrame + 1
		task.wait(frameUpdateRate)
	end
	frameAnimationComplete = true
end)

for i = 1, 15 do
	currentImageLabel.Size = UDim2.new(0, 303 * (i / 15), 0, 263 * (i / 15))
	task.wait(0.02)
end

for i = 1, 60, 3 do
	blur.Size = i
	task.wait(0.01)
end

for i = 1, 15 do
	LoadingBarContainer.Size = UDim2.new(0, 300 * (i / 15), 0, 8 * (i / 15))
	LoadingBarContainer.Position = UDim2.new(0.5, 0, 0.5, (263 / 2) + 20)
	task.wait(0.02)
end

for i = 1, 8 do
	LoadingBarContainer.BackgroundTransparency = 1 - (0.7 * i / 8)
	PercentageLabel.TextTransparency = 1 - (i / 8)
	task.wait(0.015)
end

local totalSteps = #logs * 16
local stepDuration = totalFrameTime / totalSteps

for i, msg in ipairs(logs) do
	InfoLabel.Text = msg
	InfoLabel.TextTransparency = 1
	
	for j = 1, 8 do
		InfoLabel.TextTransparency = InfoLabel.TextTransparency - 0.125
		local progress = ((i - 1) * 16 + j) / totalSteps
		
		TweenService:Create(LoadingBar, TweenInfo.new(stepDuration, Enum.EasingStyle.Linear), {
			Size = UDim2.new(progress, 0, 1, 0)
		}):Play()
		
		local targetColor = Color3.fromRGB(250, 27, 117)
		local startColor = Color3.new(1, 1, 1)
		LoadingBar.BackgroundColor3 = startColor:Lerp(targetColor, progress)
		
		PercentageLabel.Text = math.floor(progress * 100) .. "%"
		
		task.wait(stepDuration)
	end
	
	for k = 1, 8 do
		local progress = ((i - 1) * 16 + 8 + k) / totalSteps
		
		TweenService:Create(LoadingBar, TweenInfo.new(stepDuration, Enum.EasingStyle.Linear), {
			Size = UDim2.new(progress, 0, 1, 0)
		}):Play()
		
		local targetColor = Color3.fromRGB(250, 27, 117)
		local startColor = Color3.new(1, 1, 1)
		LoadingBar.BackgroundColor3 = startColor:Lerp(targetColor, progress)
		
		PercentageLabel.Text = math.floor(progress * 100) .. "%"
		task.wait(stepDuration)
	end
end

TweenService:Create(LoadingBar, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
	Size = UDim2.new(1, 0, 1, 0)
}):Play()
LoadingBar.BackgroundColor3 = Color3.fromRGB(250, 27, 117)
PercentageLabel.Text = "100%"

InfoLabel.Text = "Done!"
InfoLabel.TextTransparency = 1

for i = 1, 8 do
	InfoLabel.TextTransparency = InfoLabel.TextTransparency - 0.125
	task.wait(0.02)
end

task.wait(1)

for i = 1, 8 do
	InfoLabel.TextTransparency = InfoLabel.TextTransparency + 0.125
	LoadingBarContainer.BackgroundTransparency = LoadingBarContainer.BackgroundTransparency + 0.125
	LoadingBar.BackgroundTransparency = i / 8
	PercentageLabel.TextTransparency = PercentageLabel.TextTransparency + 0.125
	task.wait(0.01)
end

InfoLabel:Destroy()
LoadingBarContainer:Destroy()
PercentageLabel:Destroy()

heartbeatConnection:Disconnect()

local visibleFrame = nil
for i = 1, #frame_data do
	if frame_data[i] and frame_data[i].ImageTransparency < 1 then
		visibleFrame = frame_data[i]
		break
	end
end

local fadeSteps = 20
for i = 1, fadeSteps do
	local progress = i / fadeSteps
	
	if visibleFrame then
		visibleFrame.ImageTransparency = progress
	end
	
	blur.Size = 60 * (1 - progress)
	
	task.wait(0.02)
end

for i = 1, #frame_data do
	if frame_data[i] then
		frame_data[i]:Destroy()
	end
end
table.clear(frame_data)

task.wait(0.2)
ScreenGui:Destroy()
sound:Stop()

task.wait(0.5)
blur:Destroy()

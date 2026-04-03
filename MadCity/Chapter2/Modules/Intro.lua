local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")

local blur = Instance.new("BlurEffect", game.Lighting)
blur.Size = 0

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

if not isfolder("RubyHub") then makefolder("RubyHub") end
if not isfolder("RubyHub/Intro") then makefolder("RubyHub/Intro") end
if not isfolder("RubyHub/Intro/Audio") then makefolder("RubyHub/Intro/Audio") end
if not isfolder("RubyHub/Intro/Frames") then makefolder("RubyHub/Intro/Frames") end

local songPath = "RubyHub/Intro/Audio/RubyHub_IntroSound.mp3"

if not isfile(songPath) then
    local success, content = pcall(function()
        return game:HttpGet('https://github.com/aymarko/RubyHub/raw/main/MadCity/Chapter2/Assets/IntroSound.mp3')
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

local BASE_URL = "https://raw.githubusercontent.com/aymarko/RubyHub/main/MadCity/Chapter2/Assets/Intro/"

local cachedFrameAssets = table.create(#frames)
local toDownload = {}

for i, id in ipairs(frames) do
    local fileName = "frame_" .. string.format("%03d", i) .. ".png"
    local filePath = "RubyHub/Intro/Frames/" .. fileName
    if isfile(filePath) then
        cachedFrameAssets[i] = getcustomasset(filePath)
    else
        cachedFrameAssets[i] = "rbxassetid://" .. id
        table.insert(toDownload, {index = i, id = id, path = filePath, url = BASE_URL .. fileName})
    end
end

if #toDownload > 0 then
    task.spawn(function()
        local MAX_CONCURRENT = 4
        local active = 0
        local done = 0
        local total = #toDownload

        local function downloadNext(item)
            active += 1
            task.spawn(function()
                local ok, data = pcall(function()
                    return game:HttpGet(item.url)
                end)
                local isImage = ok and data and #data > 4 and (
                    data:sub(1, 4) == "\137PNG" or
                    data:sub(1, 2) == "\255\216"
                )
                if isImage then
                    writefile(item.path, data)
                    cachedFrameAssets[item.index] = getcustomasset(item.path)
                end
                active -= 1
                done += 1
            end)
        end

        local idx = 1
        while done < total do
            while active < MAX_CONCURRENT and idx <= total do
                downloadNext(toDownload[idx])
                idx += 1
            end
            task.wait(0.05)
        end
    end)
end

sound:Play()

local success, err = pcall(function()
	ContentProvider:PreloadAsync(cachedFrameAssets)
end)

task.wait(0.5)

local videoFrame = Instance.new("Frame")
videoFrame.Parent = ScreenGui
videoFrame.BackgroundTransparency = 1
videoFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
videoFrame.AnchorPoint = Vector2.new(0.5, 0.5)
videoFrame.Size = UDim2.new(0, 0, 0, 0)

local frame_data = table.create(#frames)
for i = 1, #frames do
	local lbl = Instance.new("ImageLabel")
	lbl.Parent = videoFrame
	lbl.BackgroundTransparency = 1
	lbl.Size = UDim2.new(1, 0, 1, 0)
	lbl.Image = cachedFrameAssets[i]
	lbl.ImageTransparency = 1
	lbl.ZIndex = 1
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.1, 0)
	corner.Parent = lbl
	frame_data[i] = lbl
end

for i = 1, #frame_data do
	frame_data[i].ImageTransparency = 0
end
task.wait(0.05)
for i = 1, #frame_data do
	frame_data[i].ImageTransparency = 1
end
task.wait(0.05)

local currentFrame = 1
local activeLabel = nil

local VIDEO_WIDTH = 303
local VIDEO_HEIGHT = 263
local VIDEO_HALF = VIDEO_HEIGHT / 2
local BAR_WIDTH = VIDEO_WIDTH
local BAR_HEIGHT = 7
local BAR_BELOW_VIDEO = 22

local LoadingBarContainer = Instance.new("Frame")
LoadingBarContainer.Parent = ScreenGui
LoadingBarContainer.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
LoadingBarContainer.BackgroundTransparency = 1
LoadingBarContainer.Position = UDim2.new(0.5, 0, 0.5, VIDEO_HALF + BAR_BELOW_VIDEO)
LoadingBarContainer.Size = UDim2.new(0, 0, 0, 0)
LoadingBarContainer.BorderSizePixel = 0
LoadingBarContainer.AnchorPoint = Vector2.new(0.5, 0)

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(1, 0)
containerCorner.Parent = LoadingBarContainer

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingBarContainer
LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BorderSizePixel = 0

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = LoadingBar

local frameUpdateRate = 0.025
local maxFramesToShow = #frames - 10
local totalFrameTime = maxFramesToShow * frameUpdateRate

local frameAnimationComplete = false

task.spawn(function()
	while currentFrame <= maxFramesToShow and ScreenGui.Parent do
		local lbl = frame_data[currentFrame]
		if lbl then
			if activeLabel then activeLabel.ImageTransparency = 1 end
			lbl.ImageTransparency = 0
			activeLabel = lbl
		end
		currentFrame = currentFrame + 1
		task.wait(frameUpdateRate)
	end
	frameAnimationComplete = true
end)

for i = 1, 15 do
	videoFrame.Size = UDim2.new(0, VIDEO_WIDTH * (i / 15), 0, VIDEO_HEIGHT * (i / 15))
	task.wait(0.02)
end

for i = 1, 60, 3 do
	blur.Size = i
	task.wait(0.01)
end

for i = 1, 15 do
	LoadingBarContainer.Size = UDim2.new(0, BAR_WIDTH * (i / 15), 0, BAR_HEIGHT * (i / 15))
	LoadingBarContainer.Position = UDim2.new(0.5, 0, 0.5, VIDEO_HALF + BAR_BELOW_VIDEO)
	task.wait(0.02)
end

for i = 1, 8 do
	LoadingBarContainer.BackgroundTransparency = 1 - (0.55 * i / 8)
	task.wait(0.015)
end

TweenService:Create(LoadingBar, TweenInfo.new(totalFrameTime, Enum.EasingStyle.Linear), {
	Size = UDim2.new(1, 0, 1, 0),
}):Play()
task.wait(totalFrameTime)

task.wait(1)

for i = 1, 8 do
	LoadingBarContainer.BackgroundTransparency = LoadingBarContainer.BackgroundTransparency + 0.125
	LoadingBar.BackgroundTransparency = i / 8
	task.wait(0.01)
end

LoadingBarContainer:Destroy()

local fadeSteps = 20
for i = 1, fadeSteps do
	local progress = i / fadeSteps
	if activeLabel then activeLabel.ImageTransparency = progress end
	blur.Size = 60 * (1 - progress)
	task.wait(0.02)
end

videoFrame:Destroy()

task.wait(0.2)
ScreenGui:Destroy()
sound:Stop()

task.wait(0.5)
blur:Destroy()

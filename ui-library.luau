local library_object do
    local workspace = game:GetService("Workspace")
    local user_input_service = game:GetService("UserInputService")
    local players = game:GetService("Players")
    local core_gui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
    local http_service = game:GetService("HttpService")
    local tween_service = game:GetService("TweenService")
    local run_service = game:GetService("RunService")

    gethui = gethui or function()
        return core_gui
    end

    local local_player = players.LocalPlayer
    local camera = workspace.CurrentCamera
    local mouse = local_player:GetMouse()

    local from_rgb = Color3.fromRGB
    local from_hsv = Color3.fromHSV
    local from_hex = Color3.fromHex

    local rgb_sequence = ColorSequence.new
    local rgb_sequence_keypoint = ColorSequenceKeypoint.new
    local num_sequence = NumberSequence.new
    local num_sequence_keypoint = NumberSequenceKeypoint.new

    local u_dim2_new = UDim2.new
    local u_dim_new = UDim.new
    local vector2_new = Vector2.new

    local math_clamp = math.clamp
    local math_floor = math.floor
    local math_abs = math.abs
    local math_sin = math.sin

    local table_insert = table.insert
    local table_find = table.find
    local table_remove = table.remove
    local table_concat = table.concat
    local table_clone = table.clone
    local table_unpack = table.unpack

    local string_format = string.format
    local string_find = string.find
    local string_g_sub = string.gsub
    local string_lower = string.lower

    local instance_new = Instance.new

    local rect_new = Rect.new
    
    library_object = {
        Theme =  { },

        MenuKeybind = tostring(Enum.KeyCode.RightControl), 
        Flags = { },

        Tween = {
            Time = 0.25,
            Style = Enum.EasingStyle.Quart,
            Direction = Enum.EasingDirection.Out
        },

        Folders = {
            Directory = "jade workspace",
            Configs = "bitchbot/Configs",
            Assets = "bitchbot/Assets",
        },

        Images = {
            -- https://github.com/saliva-dot/ui-object/blob/main/images/saturation.png
            ["Saturation"] = {"Saturation.png", "https://raw.githubusercontent.com/saliva-dot/ui-object/main/images/saturation.png" },
            ["Value"] = { "Value.png", "https://raw.githubusercontent.com/saliva-dot/ui-object/main/images/value.png" },
            ["Hue"] = { "Hue.png", "https://raw.githubusercontent.com/saliva-dot/ui-object/main/images/horizontalhue.png" },
            ["Checkers"] = { "Checkers.jpg", "https://raw.githubusercontent.com/saliva-dot/ui-object/main/images/checkers.jpg" },
        },

        -- Ignore below
        Pages = { },
        Sections = { },

        Connections = { },
        Threads = { },

        ThemeMap = { },
        ThemeItems = { },

        OpenFrames = { },

        SetFlags = { },

        UnnamedConnections = 0,
        UnnamedFlags = 0,

        Holder = nil,
        NotifHolder = nil,
        UnusedHolder = nil,
        Font = nil,
        KeyList = nil
    }

    library_object.__index = library_object

    library_object.Sections.__index = library_object.Sections
    library_object.Pages.__index = library_object.Pages

    local keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    local themes = {
        ["Preset"] = {
            ["Background"] = from_rgb(39, 39, 44),
            ["Inline"] = from_rgb(61, 60, 65),
            ["Outline"] = from_rgb(61, 60, 65),
            ["Page Background"] = from_rgb(49, 48, 52),
            ["Border"] = from_rgb(31, 25, 36),
            ["Accent"] = from_rgb(139, 69, 182),
            ["Text Border"] = from_rgb(0, 0, 0),
            ["Light Accent"] = from_rgb(139, 94, 216),
            ["Element"] = from_rgb(39, 39, 44),
            ["Text"] = from_rgb(230, 230, 230),
            ["Inactive Text"] = from_rgb(185, 185, 185)
        }
    }

    library_object.Theme = table_clone(themes["Preset"])

    -- Folders
    for index, value in library_object.Folders do 
        if not isfolder(value) then
            makefolder(value)
        end
    end

    -- Images
    for index, value in library_object.Images do 
        local image_data = value

        local image_name = image_data[1]
        local image_link = image_data[2]
        
        if not isfile(library_object.Folders.Assets .. "/" .. image_name) then
            writefile(library_object.Folders.Assets .. "/" .. image_name, game:HttpGet(image_link))
        end
    end

    -- Tweening
    local tween = { } do
        tween.__index = tween

        tween.Create = function(self, item, info, goal, is_raw_item)
            item = is_raw_item and item or item.Instance
            info = info or TweenInfo.new(library_object.Tween.Time, library_object.Tween.Style, library_object.Tween.Direction)

            local new_tween = {
                Tween = tween_service:Create(item, info, goal),
                Info = info,
                Goal = goal,
                Item = item
            }

            new_tween.Tween:Play()

            setmetatable(new_tween, tween)

            return new_tween
        end

        tween.GetProperty = function(self, item)
            item = item or self.Item 

            if item:IsA("Frame") then
                return { "BackgroundTransparency" }
            elseif item:IsA("TextLabel") or item:IsA("TextButton") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif item:IsA("ImageLabel") or item:IsA("ImageButton") then
                return { "BackgroundTransparency", "ImageTransparency" }
            elseif item:IsA("ScrollingFrame") then
                return { "BackgroundTransparency", "ScrollBarImageTransparency" }
            elseif item:IsA("TextBox") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif item:IsA("UIStroke") then 
                return { "Transparency" }
            end
        end

        tween.FadeItem = function(self, item, property, visibility, speed)
            local item = item or self.Item 

            local old_transparency = item[property]
            item[property] = visibility and 1 or old_transparency

            local new_tween = tween:Create(item, TweenInfo.new(speed or library_object.Tween.Time, library_object.Tween.Style, library_object.Tween.Direction), {
                [property] = visibility and old_transparency or 1
            }, true)

            library_object:Connect(new_tween.Tween.Completed, function()
                if not visibility then 
                    task.wait()
                    item[property] = old_transparency
                end
            end)

            return new_tween
        end

        tween.Get = function(self)
            if not self.Tween then 
                return
            end

            return self.Tween, self.Info, self.Goal
        end

        tween.Pause = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Pause()
        end

        tween.Play = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Play()
        end

        tween.Clean = function(self)
            if not self.Tween then 
                return
            end

            tween:Pause()
            self = nil
        end
    end

    -- Instances
    local instances = { } do
        instances.__index = instances

        instances.Create = function(self, class, properties)
            local new_item = {
                Instance = instance_new(class),
                Properties = properties,
                Class = class
            }

            setmetatable(new_item, instances)

            for property, value in new_item.Properties do
                new_item.Instance[property] = value
            end

            return new_item
        end

        instances.Border = function(self)
            if not self.Instance then 
                return
            end

            local item = self.Instance
            local ui_stroke = instances:Create("UIStroke", {
                Parent = item,
                Color = library_object.Theme.Border,
                Thickness = 1,
                LineJoinMode = Enum.LineJoinMode.Miter
            })

            ui_stroke:AddToTheme({Color = "Border"})

            return ui_stroke
        end

        instances.FadeItem = function(self, visibility, speed)
            local item = self.Instance

            if visibility == true then 
                item.Visible = true
            end

            local descendants = item:GetDescendants()
            table_insert(descendants, item)

            local new_tween

            for index, value in descendants do 
                local transparency_property = tween:GetProperty(value)

                if not transparency_property then 
                    continue
                end

                if type(transparency_property) == "table" then 
                    for _, property in transparency_property do 
                        new_tween = tween:FadeItem(value, property, not visibility, speed)
                    end
                else
                    new_tween = tween:FadeItem(value, transparency_property, not visibility, speed)
                end
            end
        end

        instances.AddToTheme = function(self, properties)
            if not self.Instance then 
                return
            end

            library_object:AddToTheme(self, properties)
        end

        instances.ChangeItemTheme = function(self, properties)
            if not self.Instance then 
                return
            end

            library_object:ChangeItemTheme(self, properties)
        end

        instances.Connect = function(self, event, callback, name)
            if not self.Instance then 
                return
            end

            if not self.Instance[event] then 
                return
            end

            return library_object:Connect(self.Instance[event], callback, name)
        end

        instances.Tween = function(self, info, goal)
            if not self.Instance then 
                return
            end

            return tween:Create(self, info, goal)
        end

        instances.Disconnect = function(self, name)
            if not self.Instance then 
                return
            end

            return library_object:Disconnect(name)
        end

        instances.Clean = function(self)
            if not self.Instance then 
                return
            end

            self.Instance:Destroy()
            self = nil
        end

        instances.MakeDraggable = function(self)
            if not self.Instance then 
                return
            end

            local gui = self.Instance

            local dragging = false 
            local drag_start
            local start_position 

            local set = function(input)
                local drag_delta = input.Position - drag_start
                self:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = u_dim2_new(start_position.X.Scale, start_position.X.Offset + drag_delta.X, start_position.Y.Scale, start_position.Y.Offset + drag_delta.Y)})
            end

            self:Connect("InputBegan", function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true

                    drag_start = input.Position
                    start_position = gui.Position

                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)

            library_object:Connect(user_input_service.InputChanged, function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        set(input)
                    end
                end
            end)

            return dragging
        end

        instances.MakeResizeable = function(self, minimum, maximum)
            if not self.Instance then 
                return
            end

            local gui = self.Instance

            local resizing = false 
            local start = u_dim2_new()
            local delta = u_dim2_new()
            local resize_max = gui.Parent.AbsoluteSize - gui.AbsoluteSize

            local resize_button = instances:Create("ImageButton", {
				Parent = gui,
                Image = "",
				AnchorPoint = vector2_new(1, 1),
				BorderColor3 = from_rgb(0, 0, 0),
				Size = u_dim2_new(0, 10, 0, 10),
				Position = u_dim2_new(1, -4, 1, -4),
                Name = "\0",
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
                ZIndex = 5,
				AutoButtonColor = false,
                Visible = true,
			})  resize_button:AddToTheme({ImageColor3 = "Accent"})

            resize_button:Connect("InputBegan", function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then

                    resizing = true

                    start = gui.Size - u_dim2_new(0, input.Position.X, 0, input.Position.Y)

                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            resizing = false
                        end
                    end)
                end
            end)

            library_object:Connect(user_input_service.InputChanged, function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    if resizing then
                        resize_max = maximum or gui.Parent.AbsoluteSize - gui.AbsoluteSize

                        delta = start + u_dim2_new(0, input.Position.X, 0, input.Position.Y)
                        delta = u_dim2_new(0, math.clamp(delta.X.Offset, minimum.X, resize_max.X), 0, math.clamp(delta.Y.Offset, minimum.Y, resize_max.Y))

                        tween:Create(gui, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = delta}, true)
                    end
                end
            end)

            return resizing
        end

        instances.OnHover = function(self, callback)
            if not self.Instance then
                return
            end
            
            return library_object:Connect(self.Instance.MouseEnter, callback)
        end

        instances.OnHoverLeave = function(self, callback)
            if not self.Instance then 
                return
            end
            
            return library_object:Connect(self.Instance.MouseLeave, callback)
        end
    end

    -- Custom font
    local custom_font = { } do
        function custom_font:New(name, weight, style, data)
            if isfile(library_object.Folders.Assets .. "/" .. name .. ".json") then
                return Font.new(getcustomasset(library_object.Folders.Assets .. "/" .. name .. ".json"))
            end

            if not isfile(library_object.Folders.Assets .. "/" .. name .. ".ttf") then 
                writefile(library_object.Folders.Assets .. "/" .. name .. ".ttf", game:HttpGet(data.Url))
            end

            local font_data = {
                name = name,
                faces = { {
                    name = "Regular",
                    weight = weight,
                    style = style,
                    assetId = getcustomasset(library_object.Folders.Assets .. "/" .. Name .. ".ttf")
                } }
            }

            writefile(library_object.Folders.Assets .. "/" .. Name .. ".json", http_service:JSONEncode(font_data))
            return Font.new(getcustomasset(library_object.Folders.Assets .. "/" .. Name .. ".json"))
        end

        function custom_font:Get(name)
            if isfile(library_object.Folders.Assets .. "/" .. name .. ".json") then
                return Font.new(getcustomasset(library_object.Folders.Assets .. "/" .. name .. ".json"))
            end
        end

        custom_font:New("ProggyClean", 200, "Regular", {
            Url = "https://github.com/saliva-dot/ui-object/raw/refs/heads/main/fonts/ProggyClean.ttf"
        })

        library_object.Font = custom_font:Get("ProggyClean")
    end

    library_object.Holder = instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        DisplayOrder = 2,
        ResetOnSpawn = false
    })

    library_object.UnusedHolder = instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Enabled = false,
        ResetOnSpawn = false
    })

    library_object.NotifHolder = instances:Create("Frame", {
        Parent = library_object.Holder.Instance,
        Name = "\0",
        BorderColor3 = from_rgb(0, 0, 0),
        AnchorPoint = vector2_new(1, 0),
        BackgroundTransparency = 1,
        Position = u_dim2_new(1, 0, 0, 0),
        Size = u_dim2_new(0, 0, 1, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = from_rgb(255, 255, 255)
    })

    instances:Create("UIListLayout", {
        Parent = library_object.NotifHolder.Instance,
        Name = "\0",
        Padding = u_dim_new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right
    })

    instances:Create("UIPadding", {
        Parent = library_object.NotifHolder.Instance,
        Name = "\0",
        PaddingTop = u_dim_new(0, 10),
        PaddingBottom = u_dim_new(0, 10),
        PaddingRight = u_dim_new(0, 10),
        PaddingLeft = u_dim_new(0, 10)
    })

    library_object.Unload = function(self)
        for index, value in self.Connections do 
            value.Connection:Disconnect()
        end

        for index, value in self.Threads do 
            coroutine.close(value)
        end

        if self.Holder then 
            self.Holder:Clean()
        end

        library_object = nil 
        getgenv().library_object = nil
    end

    library_object.GetImage = function(self, image)
        local image_data = self.Images[image]

        if not image_data then 
            return
        end

        return getcustomasset(self.Folders.Assets .. "/" .. image_data[1])
    end

    library_object.Round = function(self, number, float)
        local multiplier = 1 / (float or 1)
        return math_floor(number * multiplier) / multiplier
    end

    library_object.Thread = function(self, callback)
        local new_thread = coroutine.create(callback)
        
        coroutine.wrap(function()
            coroutine.resume(new_thread)
        end)()

        table_insert(self.Threads, new_thread)
        return new_thread
    end
    
    library_object.SafeCall = function(self, callback, ...)
        local arguements = { ... }
        local success, Result = pcall(callback, table_unpack(arguements))

        if not success then
            warn(result)
            return false
        end

        return success
    end

    library_object.Connect = function(self, event, callback, name)
        name = name or string_format("Connection%s%s", self.UnnamedConnections + 1, http_service:GenerateGUID(false))

        local new_connection = {
            Event = event,
            Callback = callback,
            Name = name,
            Connection = nil
        }

        library_object:Thread(function()
            new_connection.Connection = event:Connect(callback)
        end)

        table_insert(self.Connections, new_connection)
        return new_connection
    end

    library_object.Disconnect = function(self, name)
        for _, connection in self.Connections do 
            if connection.Name == name then
                connection.Connection:Disconnect()
                break
            end
        end
    end

    library_object.NextFlag = function(self)
        local flag_number = self.UnnamedFlags + 1
        return string_format("flag_number_%s_%s", flag_number, http_service:GenerateGUID(false))
    end

    library_object.AddToTheme = function(self, item, properties)
        item = item.Instance or item 

        local theme_data = {
            Item = item,
            Properties = properties,
        }

        for property, value in theme_data.Properties do
            if type(value) == "string" then
                item[property] = self.Theme[value]
            else
                item[property] = value()
            end
        end

        table_insert(self.ThemeItems, theme_data)
        self.ThemeMap[item] = theme_data
    end

    library_object.GetConfig = function(self)
        local config = { } 

        local success, Result = library_object:SafeCall(function()
            for index, value in library_object.Flags do 
                if type(value) == "table" and value.Key then
                    config[index] = {Key = tostring(value.Key), Mode = value.Mode}
                elseif type(value) == "table" and value.Color then
                    config[index] = {Color = "#" .. Value.Color, Alpha = value.Alpha}
                else
                    config[index] = value
                end
            end
        end)

        return http_service:JSONEncode(config)
    end

    library_object.LoadConfig = function(self, config)
        local decoded = http_service:JSONDecode(config)

        local success, Result = library_object:SafeCall(function()
            for index, value in decoded do 
                local set_function = library_object.SetFlags[index]

                if not set_function then
                    continue
                end

                if type(value) == "table" and value.Key then 
                    set_function(value)
                elseif type(value) == "table" and value.Color then
                    set_function(value.Color, value.Alpha)
                else
                    set_function(value)
                end
            end
        end)

        return success, result
    end

    library_object.DeleteConfig = function(self, config)
        if isfile(library_object.Folders.Configs .. "/" .. Config) then 
            delfile(library_object.Folders.Configs .. "/" .. Config)
        end
    end

    library_object.SaveConfig = function(self, config)
        if isfile(library_object.Folders.Configs .. "/" .. Config .. ".json") then
            writefile(library_object.Folders.Configs .. "/" .. Config .. ".json", library_object:GetConfig())
        end
    end

    library_object.RefreshConfigsList = function(self, element)
        local current_list = { }
        local list = { }

        local config_folder_name = string_g_sub(library_object.Folders.Configs, library_object.Folders.Directory .. "/", "")

        for index, value in listfiles(library_object.Folders.Configs) do
            local file_name = string_g_sub(value, library_object.Folders.Directory .. "\\" .. config_folder_name .. "\\", "")
            list[index] = file_name
        end

        local is_new = #list ~= current_list

        if not is_new then
            for index = 1, #list do
                if list[index] ~= current_list[index] then
                    is_new = true
                    break
                end
            end
        else
            current_list = list
            element:Refresh(current_list)
        end
    end

    library_object.ChangeItemTheme = function(self, item, properties)
        item = item.Instance or item

        if not self.ThemeMap[item] then 
            return
        end

        self.ThemeMap[item].Properties = properties
        self.ThemeMap[item] = self.ThemeMap[item]
    end

    library_object.ChangeTheme = function(self, theme, color)
        self.Theme[theme] = color

        for _, item in self.ThemeItems do
            for property, value in item.Properties do
                if type(value) == "string" and value == theme then
                    item.Item[property] = color
                end
            end
        end
    end

    library_object.IsMouseOverFrame = function(self, frame, x_offset, y_offset)
        frame = frame.Instance
        x_offset = x_offset or 0 
        y_offset = y_offset or 0

        local mouse_position = vector2_new(mouse.X + x_offset, mouse.Y + y_offset)

        return mouse_position.X >= frame.AbsolutePosition.X and mouse_position.X <= frame.AbsolutePosition.X + frame.AbsoluteSize.X 
        and mouse_position.Y >= frame.AbsolutePosition.Y and mouse_position.Y <= frame.AbsolutePosition.Y + frame.AbsoluteSize.Y
    end

    library_object.Notification = function(self, text, duration, color)
        local items = { } do
            items["Notification"] = instances:Create("Frame", {
                Parent = self.NotifHolder.Instance,
                Name = "\0",
                BorderColor3 = from_rgb(31, 25, 36),
                BorderSizePixel = 2,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = from_rgb(39, 39, 44)
            })  items["Notification"]:AddToTheme({BackgroundColor3 = "Background", BorderColor3 = "Border"})

            items["UIStroke"] = instances:Create("UIStroke", {
                Parent = items["Notification"].Instance,
                Name = "\0",
                Color = from_rgb(61, 60, 65),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  items["UIStroke"]:AddToTheme({Color = "Outline"})

            instances:Create("UIPadding", {
                Parent = items["Notification"].Instance,
                Name = "\0",
                PaddingTop = u_dim_new(0, 5),
                PaddingBottom = u_dim_new(0, 5),
                PaddingRight = u_dim_new(0, 10),
                PaddingLeft = u_dim_new(0, 5)
            })

            items["Text"] = instances:Create("TextLabel", {
                Parent = items["Notification"].Instance,
                Name = "\0",
                FontFace = library_object.Font,
                TextColor3 = from_rgb(230, 230, 230),
                BorderColor3 = from_rgb(0, 0, 0),
                Text = text,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 12,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })  items["Text"]:AddToTheme({TextColor3 = "Text"})

            items["UIStroke2"] = instances:Create("UIStroke", {
                Parent = items["Text"].Instance,
                Name = "\0",
                LineJoinMode = Enum.LineJoinMode.Miter
            })  items["UIStroke2"]:AddToTheme({Color = "Text Border"})

            items["Liner"] = instances:Create("Frame", {
                Parent = items["Notification"].Instance,
                Name = "\0",
                AnchorPoint = vector2_new(1, 0),
                Position = u_dim2_new(1, 10, 0, -5),
                BorderColor3 = from_rgb(0, 0, 0),
                Size = u_dim2_new(0, 1, 1, 10),
                BorderSizePixel = 0,
                BackgroundColor3 = color
            }) 
        end

        for index, value in items do 
            local transparency_property = tween:GetProperty(value.Instance)  

            if not transparency_property then 
                continue
            end

            if type(transparency_property) == "table" then 
                for _, property in transparency_property do 
                    if index == "Text" and property == "BackgroundTransparency" then 
                        continue
                    end

                    value.Instance[property] = 1
                end
            else
                value.Instance[transparency_property] = 1
            end
        end

        local old_size = items["Notification"].Instance.AbsoluteSize
        items["Notification"].Instance.Size = u_dim2_new(0, 0, 0, 0)
        items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.None

        library_object:Thread(function()
            items["Notification"]:Tween(nil, {Size = u_dim2_new(0, old_size.X, 0, old_size.Y)})
            task.wait(0.1)
            for index, value in items do 
                local transparency_property = tween:GetProperty(value.Instance)  
                
                if not transparency_property then 
                    continue
                end

                if type(transparency_property) == "table" then 
                    for _, property in transparency_property do 
                        if index == "Text" and property == "BackgroundTransparency" then 
                            continue
                        end

                        value:Tween(nil, {[property] = 0})
                    end
                else
                    value:Tween(nil, {[transparency_property] = 0})
                end
            end

            task.delay(duration + 0.1, function()
                for index, value in items do 
                    local transparency_property = tween:GetProperty(value.Instance)  
                    
                    if not transparency_property then 
                        continue
                    end

                    if type(transparency_property) == "table" then 
                        for _, property in transparency_property do 
                            value:Tween(nil, {[property] = 1})
                        end
                    else
                        value:Tween(nil, {[transparency_property] = 1})
                    end
                end
                task.wait(0.1)
                items["Notification"]:Tween(nil, {Size = u_dim2_new(0, 0, 0, 0)})
                task.wait(0.5)
                items["Notification"]:Clean()
            end)
        end)
    end

    library_object.CreateColorpicker = function(self, data)
        local colorpicker = {
            Hue = 0,
            Saturation = 0,
            Value = 0,

            Alpha = 0,

            Color = from_rgb(0, 0, 0),
            HexValue = "ffffff",
            LastColor = from_rgb(0, 0, 0),

            HoveringColor = from_rgb(0, 0, 0),
            IsOpen = false,

            Flag = data.Flag
        }

        local items = { } do
            items["ColorpickerButton"] = instances:Create("TextButton", {
                Parent = data.Parent.Instance,
                Name = "\0",
                FontFace = library_object.Font,
                TextColor3 = from_rgb(0, 0, 0),
                BorderColor3 = from_rgb(61, 60, 65),
                Text = "",
                AutoButtonColor = false,
                Size = u_dim2_new(0, 28, 0, 12),
                BorderSizePixel = 2,
                TextSize = 14,
                BackgroundColor3 = from_rgb(255, 71, 34)
            })  items["ColorpickerButton"]:AddToTheme({BorderColor3 = "Outline"})

            instances:Create("UIStroke", {
                Parent = items["ColorpickerButton"].Instance,
                Name = "\0",
                Color = from_rgb(31, 25, 36),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            items["CheckersImage"] = instances:Create("ImageLabel", {
                Parent = items["ColorpickerButton"].Instance,
                Name = "\0",
                ScaleType = Enum.ScaleType.Tile,
                ImageTransparency = 1,
                BorderColor3 = from_rgb(0, 0, 0),
                Image = library_object:GetImage("Checkers"),
                BackgroundTransparency = 1,
                Size = u_dim2_new(1, 0, 1, 0),
                TileSize = u_dim2_new(0, 6, 0, 6),
                BorderSizePixel = 0,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })

            items["ColorpickerWindow"] = instances:Create("Frame", {
                Parent = library_object.Holder.Instance,
                Name = "\0",
                Position = u_dim2_new(0, items["ColorpickerButton"].Instance.AbsolutePosition.X, 0, items["ColorpickerButton"].Instance.AbsolutePosition.Y + 26),
                BorderColor3 = from_rgb(31, 25, 36),
                Size = u_dim2_new(0, 211, 0, 207),
                BorderSizePixel = 2,
                BackgroundColor3 = from_rgb(39, 39, 44),
                Visible = false
            })  items["ColorpickerWindow"]:AddToTheme({BorderColor3 = "Border", BackgroundColor3 = "Background"})

            items["ColorpickerWindow"]:MakeDraggable()
            items["ColorpickerWindow"]:MakeResizeable(vector2_new(211, 207), vector2_new(9999, 9999))

            instances:Create("UIStroke", {
                Parent = items["ColorpickerWindow"].Instance,
                Name = "\0",
                Color = from_rgb(61, 60, 65),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Outline"})

            items["Palette"] = instances:Create("TextButton", {
                Parent = items["ColorpickerWindow"].Instance,
                Name = "\0",
                FontFace = library_object.Font,
                TextColor3 = from_rgb(0, 0, 0),
                BorderColor3 = from_rgb(61, 60, 65),
                Text = "",
                AutoButtonColor = false,
                Position = u_dim2_new(0, 8, 0, 8),
                Size = u_dim2_new(1, -40, 1, -55),
                BorderSizePixel = 2,
                TextSize = 14,
                BackgroundColor3 = from_rgb(255, 71, 34)
            })  items["Palette"]:AddToTheme({BorderColor3 = "Outline"})

            instances:Create("UIStroke", {
                Parent = items["Palette"].Instance,
                Name = "\0",
                Color = from_rgb(31, 25, 36),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            items["Value"] = instances:Create("ImageLabel", {
                Parent = items["Palette"].Instance,
                Name = "\0",
                BorderColor3 = from_rgb(0, 0, 0),
                Image = library_object:GetImage("Value"),
                BackgroundTransparency = 1,
                Size = u_dim2_new(1, 0, 1, 0),
                ZIndex = 3,
                BorderSizePixel = 0,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })

            items["Saturation"] = instances:Create("ImageLabel", {
                Parent = items["Palette"].Instance,
                Name = "\0",
                BorderColor3 = from_rgb(0, 0, 0),
                Image = library_object:GetImage("Saturation"),
                BackgroundTransparency = 1,
                Size = u_dim2_new(1, 0, 1, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })

            items["PaletteDragger"] = instances:Create("Frame", {
                Parent = items["Palette"].Instance,
                Name = "\0",
                Size = u_dim2_new(0, 2, 0, 2),
                Position = u_dim2_new(0, 12, 0, 12),
                BorderColor3 = from_rgb(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })

            instances:Create("UIStroke", {
                Parent = items["PaletteDragger"].Instance,
                Name = "\0",
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            })

            items["HueOutline"] = instances:Create("Frame", {
                Parent = items["ColorpickerWindow"].Instance,
                Name = "\0",
                AnchorPoint = vector2_new(1, 0),
                Position = u_dim2_new(1, -8, 0, 8),
                BorderColor3 = from_rgb(61, 60, 65),
                Size = u_dim2_new(0, 15, 1, -55),
                BorderSizePixel = 2,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })  items["HueOutline"]:AddToTheme({BorderColor3 = "Outline"})

            items["Hue"] = instances:Create("ImageButton", {
                Parent = items["HueOutline"].Instance,
                Name = "\0",
                BorderColor3 = from_rgb(61, 60, 65),
                AutoButtonColor = false,
                Image = "",
                Size = u_dim2_new(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })

            instances:Create("UIGradient", {
                Parent = items["Hue"].Instance,
                Name = "\0",
                Rotation = 90,
                Color = rgb_sequence{rgb_sequence_keypoint(0, from_rgb(255, 0, 0)), rgb_sequence_keypoint(0.17, from_rgb(255, 255, 0)), rgb_sequence_keypoint(0.33, from_rgb(0, 255, 0)), rgb_sequence_keypoint(0.5, from_rgb(0, 255, 255)), rgb_sequence_keypoint(0.67, from_rgb(0, 0, 255)), rgb_sequence_keypoint(0.83, from_rgb(255, 0, 255)), rgb_sequence_keypoint(1, from_rgb(255, 0, 0))}
            })

            instances:Create("UIStroke", {
                Parent = items["HueOutline"].Instance,
                Name = "\0",
                Color = from_rgb(31, 25, 36),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            items["HueDragger"] = instances:Create("Frame", {
                Parent = items["HueOutline"].Instance,
                Name = "\0",
                Size = u_dim2_new(1, -2, 0, 1),
                Position = u_dim2_new(0, 1, 0, 12),
                BorderColor3 = from_rgb(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })

            instances:Create("UIStroke", {
                Parent = items["HueDragger"].Instance,
                Name = "\0",
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            })

            items["Alpha"] = instances:Create("TextButton", {
                Parent = items["ColorpickerWindow"].Instance,
                Name = "\0",
                FontFace = library_object.Font,
                TextColor3 = from_rgb(0, 0, 0),
                BorderColor3 = from_rgb(61, 60, 65),
                Text = "",
                AutoButtonColor = false,
                AnchorPoint = vector2_new(0, 1),
                Position = u_dim2_new(0, 8, 1, -25),
                Size = u_dim2_new(1, -16, 0, 15),
                BorderSizePixel = 2,
                TextSize = 14,
                BackgroundColor3 = from_rgb(255, 71, 34)
            })  items["Alpha"]:AddToTheme({BorderColor3 = "Outline"})

            instances:Create("UIStroke", {
                Parent = items["Alpha"].Instance,
                Name = "\0",
                Color = from_rgb(31, 25, 36),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            items["Checkers"] = instances:Create("ImageLabel", {
                Parent = items["Alpha"].Instance,
                Name = "\0",
                ScaleType = Enum.ScaleType.Tile,
                BorderColor3 = from_rgb(0, 0, 0),
                TileSize = u_dim2_new(0, 6, 0, 6),
                Image = library_object:GetImage("Checkers"),
                BackgroundTransparency = 1,
                Size = u_dim2_new(1, 0, 1, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })

            instances:Create("UIGradient", {
                Parent = items["Checkers"].Instance,
                Name = "\0",
                Rotation = 0,
                Transparency = num_sequence{num_sequence_keypoint(0, 1), num_sequence_keypoint(0.37, 0.5), num_sequence_keypoint(1, 0)}
            })

            items["AlphaDragger"] = instances:Create("Frame", {
                Parent = items["Alpha"].Instance,
                Name = "\0",
                Position = u_dim2_new(0, 8, 0, 1),
                BorderColor3 = from_rgb(0, 0, 0),
                Size = u_dim2_new(0, 1, 1, -2),
                BorderSizePixel = 0,
                ZIndex = 4,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })

            instances:Create("UIStroke", {
                Parent = items["AlphaDragger"].Instance,
                Name = "\0",
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            })

            items["ConfirmButton"] = instances:Create("TextButton", {
                Parent = items["ColorpickerWindow"].Instance,
                Name = "\0",
                FontFace = library_object.Font,
                TextColor3 = from_rgb(230, 230, 230),
                BorderColor3 = from_rgb(0, 0, 0),
                Text = "[Confirm]",
                AutoButtonColor = false,
                AnchorPoint = vector2_new(0, 1),
                Size = u_dim2_new(0.5, -8, 0, 15),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Position = u_dim2_new(0, 8, 1, -3),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })  items["ConfirmButton"]:AddToTheme({TextColor3 = "Text"})

            instances:Create("UIStroke", {
                Parent = items["ConfirmButton"].Instance,
                Name = "\0",
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Text Border"})

            items["CloseButton"] = instances:Create("TextButton", {
                Parent = items["ColorpickerWindow"].Instance,
                Name = "\0",
                FontFace = library_object.Font,
                TextColor3 = from_rgb(230, 230, 230),
                BorderColor3 = from_rgb(0, 0, 0),
                Text = "[Cancel]",
                AutoButtonColor = false,
                AnchorPoint = vector2_new(1, 1),
                Size = u_dim2_new(0.5, -8, 0, 15),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Right,
                Position = u_dim2_new(1, -8, 1, -3),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })  items["CloseButton"]:AddToTheme({TextColor3 = "Text"})

            instances:Create("UIStroke", {
                Parent = items["CloseButton"].Instance,
                Name = "\0",
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Text Border"})
        end 

        local debounce = false
        local render_stepped

        local sliding_palette = false 
        local sliding_hue = false 
        local sliding_alpha = false

        function colorpicker:SetOpen(bool)
            if debounce then 
                return 
            end

            self.IsOpen = bool 
            
            debounce = true 

            if self.IsOpen then 
                items["ColorpickerWindow"].Instance.Visible = true

                render_stepped = run_service.RenderStepped:Connect(function()
                    items["ColorpickerWindow"].Instance.Position = u_dim2_new(0, items["ColorpickerButton"].Instance.AbsolutePosition.X, 0, items["ColorpickerButton"].Instance.AbsolutePosition.Y + 26)
                end)    

                for index, value in library_object.OpenFrames do 
                    if value ~= self and value.Hue then
                        value:SetOpen(false)
                    end
                end

                library_object.OpenFrames[self] = self
            else
                if render_stepped then 
                    render_stepped:Disconnect()
                    render_stepped = nil
                end

                if library_object.OpenFrames[self] then 
                    library_object.OpenFrames[self] = nil
                end
            end

            local descendants = items["ColorpickerWindow"].Instance:GetDescendants()
            table_insert(descendants, items["ColorpickerWindow"].Instance)

            local new_tween

            for _,value in descendants do
                local transparency_property = tween:GetProperty(value)

                if not transparency_property then 
                    continue
                end

                if type(transparency_property) == "table" then 
                    for _, property in transparency_property do 
                        new_tween = tween:FadeItem(value, property, self.IsOpen, data.Window.FadeSpeed)
                    end
                else
                    new_tween = tween:FadeItem(value, transparency_property, self.IsOpen, data.Window.FadeSpeed)
                end
            end

            library_object:Connect(new_tween.Tween.Completed, function()
                debounce = false
                items["ColorpickerWindow"].Instance.Visible = self.IsOpen
            end)
        end

        function colorpicker:Get()
            return self.Color, self.Alpha 
        end

        function colorpicker:SlidePalette(input)
            if not input or not sliding_palette then 
                return
            end

            local value_x = math_clamp(1 - (input.Position.X - items["Palette"].Instance.AbsolutePosition.X) / items["Palette"].Instance.AbsoluteSize.X, 0, 1)
            local value_y = math_clamp(1 - (input.Position.Y - items["Palette"].Instance.AbsolutePosition.Y) / items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

            self.Saturation = value_x
            self.Value = value_y

            local slide_x = math_clamp((input.Position.X - items["Palette"].Instance.AbsolutePosition.X) / items["Palette"].Instance.AbsoluteSize.X, 0, 0.985)
            local slide_y = math_clamp((input.Position.Y - items["Palette"].Instance.AbsolutePosition.Y) / items["Palette"].Instance.AbsoluteSize.Y, 0, 0.985)

            items["PaletteDragger"]:Tween(TweenInfo.new(0.21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = u_dim2_new(slide_x, 0, slide_y, 0)})
            self:Update()
        end

        function colorpicker:SlideHue(input)
            if not input or not sliding_hue then 
                return
            end

            local value_y = math_clamp((input.Position.Y - items["Hue"].Instance.AbsolutePosition.Y) / items["Hue"].Instance.AbsoluteSize.Y, 0, 1)

            self.Hue = value_y

            local slide_y = math_clamp((input.Position.Y - items["Hue"].Instance.AbsolutePosition.Y) / items["Hue"].Instance.AbsoluteSize.Y, 0, 0.985)

            items["HueDragger"]:Tween(TweenInfo.new(0.21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = u_dim2_new(0, 1, slide_y, 0)})
            self:Update()
        end

        function colorpicker:SlideAlpha(input)
            if not input or not sliding_alpha then 
                return 
            end
            
            local value_x = math_clamp((input.Position.X - items["Alpha"].Instance.AbsolutePosition.X) / items["Alpha"].Instance.AbsoluteSize.X, 0, 1)

            self.Alpha = value_x

            local slide_x = math_clamp((input.Position.X - items["Alpha"].Instance.AbsolutePosition.X) / items["Alpha"].Instance.AbsoluteSize.X, 0, 0.99)

            items["AlphaDragger"]:Tween(TweenInfo.new(0.21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = u_dim2_new(slide_x, 0, 0, 1)})
            self:Update(true)
        end

        function colorpicker:Update(is_from_alpha)
            local hue, saturation, value = self.Hue, self.Saturation, self.Value
            local color = from_hsv(hue, saturation, value)

            self.HoveringColor = color
            self.HexValue = color:ToHex()

            items["ColorpickerButton"]:Tween(nil, {BackgroundColor3 = color})
            items["Palette"]:Tween(nil, {BackgroundColor3 = from_hsv(hue, 1, 1)})
            items["CheckersImage"].Instance.ImageTransparency = 1 - self.Alpha

            if not is_from_alpha then 
                items["Alpha"]:Tween(nil, {BackgroundColor3 = color})
            end
        end

        function colorpicker:Set(color, alpha)
            if type(color) == "string" then 
                color = from_hex(color)
            elseif type(color) == "table" then
                color = from_rgb(color[1], color[2], color[3])
                alpha = color[4]
            end

            self.Hue, self.Saturation, self.Value = color:ToHSV()
            self.Alpha = alpha or 0

            self.Color = color

            self.HexValue = self.Color:ToHex()

            self.LastColor = self.Color

            library_object.Flags[self.Flag] = {
                Alpha = self.Alpha,
                Color = self.HexValue
            }

            local color_position_x = math_clamp(1 - self.Saturation, 0, 0.985)
            local color_position_y = math_clamp(1 - self.Value, 0, 0.985)

            local alpha_position_x = math_clamp(self.Alpha, 0, 0.985)

            local hue_position_y = math_clamp(self.Hue, 0, 0.99)

            items["PaletteDragger"]:Tween(TweenInfo.new(0.21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = u_dim2_new(color_position_x, 0, color_position_y, 0)})
            items["HueDragger"]:Tween(TweenInfo.new(0.21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = u_dim2_new(0, 1, hue_position_y, 0)})
            items["AlphaDragger"]:Tween(TweenInfo.new(0.21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = u_dim2_new(alpha_position_x, 0, 0, 1)})

            if data.Callback then 
                library_object:SafeCall(data.Callback, self.Color, self.Alpha)
            end

            self:Update()
        end

        items["ColorpickerButton"]:Connect("MouseButton1Down", function()
            colorpicker:SetOpen(not colorpicker.IsOpen)
        end)

        items["Palette"]:Connect("InputBegan", function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                sliding_palette = true 

                colorpicker:SlidePalette(input)
            end
        end)

        items["Palette"]:Connect("InputEnded", function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                sliding_palette = false
            end
        end)

        items["Hue"]:Connect("InputBegan", function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                sliding_hue = true 

                colorpicker:SlideHue(input)
            end
        end)

        items["Hue"]:Connect("InputEnded", function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                sliding_hue = false
            end
        end)

        items["Alpha"]:Connect("InputBegan", function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                sliding_alpha = true 

                colorpicker:SlideAlpha(input)
            end
        end)

        items["Alpha"]:Connect("InputEnded", function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                sliding_alpha = false
            end
        end)

        library_object:Connect(user_input_service.InputChanged, function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then 
                if sliding_palette then 
                    colorpicker:SlidePalette(input)
                end

                if sliding_hue then 
                    colorpicker:SlideHue(input)
                end

                if sliding_alpha then 
                    colorpicker:SlideAlpha(input)
                end
            end
        end)

        library_object:Connect(user_input_service.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if library_object:IsMouseOverFrame(items["ColorpickerWindow"]) then
                    return 
                end

                if debounce then 
                    return 
                end

                colorpicker:SetOpen(false)
            end
        end)
    
        items["ConfirmButton"]:Connect("MouseButton1Down", function()
            colorpicker:Set(colorpicker.HoveringColor, colorpicker.Alpha)
            colorpicker.LastColor = colorpicker.Color
            colorpicker:SetOpen(false)
        end)

        items["CloseButton"]:Connect("MouseButton1Down", function()
            colorpicker:Set(colorpicker.LastColor, colorpicker.Alpha)
            colorpicker:SetOpen(false)
        end)

        if data.Default then 
            colorpicker:Set(data.Default, data.Alpha)
        end

        library_object.SetFlags[colorpicker.Flag] = function(value, alpha)
            colorpicker:Set(value, alpha)
        end

        return colorpicker, items 
    end

    library_object.CreateKeybind = function(self, data)
        local keybind = {
            IsOpen = false,
            Flag = data.Flag,

            Key = nil,
            Value = "",

            Toggled = false,
            IsPicking = false
        }

        local items = { } do
            items["KeyButton"] = instances:Create("TextButton", {
                Parent = data.Parent.Instance,
                Name = "\0",
                AnchorPoint = vector2_new(0, 0),
                Position = u_dim2_new(0, 0, 0, 0),
                Size = u_dim2_new(0, 0, 0, 15),
                FontFace = library_object.Font,
                Text = "None",
                TextSize = 12,
                AutomaticSize = Enum.AutomaticSize.X, 
                TextColor3 = from_rgb(230, 230, 230),
                TextStrokeTransparency = 1,
                BackgroundColor3 = from_rgb(39, 39, 44),
                BorderSizePixel = 2, 
                AutoButtonColor = false,
                BorderColor3 = from_rgb(61, 60, 65)
            })  items["KeyButton"]:AddToTheme({TextColor3 = "Text", BorderColor3 = "Outline", BackgroundColor3 = "Element"})

            instances:Create("UIStroke", {
                Parent = items["KeyButton"].Instance,
                Name = "\0",
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = from_rgb(31, 25, 36)
            }):AddToTheme({Color = "Border"})

            instances:Create("UIStroke", {
                Parent = items["KeyButton"].Instance,
                Name = "\0",
                LineJoinMode = Enum.LineJoinMode.Miter,
            }):AddToTheme({Color = "Text Border"})

            instances:Create("UIPadding", {
                Parent = items["KeyButton"].Instance,
                Name = "\0",
                PaddingLeft = u_dim_new(0, 3),
                PaddingRight = u_dim_new(0, 4),
            })

            items["Window"] = instances:Create("Frame", {
                Parent = library_object.Holder.Instance,
                BorderColor3 = from_rgb(10, 10, 10),
                AnchorPoint = vector2_new(0, 0),
                Name = "\0",
                Position = u_dim2_new(0, items["KeyButton"].Instance.AbsolutePosition.X, 0, items["KeyButton"].Instance.AbsolutePosition.Y + 25),
                Size = u_dim2_new(0, 50, 0, 48),
                BorderSizePixel = 2,
                Visible = false,
                BackgroundColor3 = from_rgb(15, 15, 20)
            })  items["Window"]:AddToTheme({BackgroundColor3 = "Background", BorderColor3 = "Border"})
            
            instances:Create("UIStroke", {
                Parent = items["Window"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Name = "\0",
                Color = from_rgb(27, 27, 32)
            }):AddToTheme({Color = "Outline"})
            
            items["Toggle"] = instances:Create("TextButton", {
                Parent = items["Window"].Instance,
                FontFace = library_object.Font,
                TextColor3 = from_rgb(230, 230, 230),
                BorderColor3 = from_rgb(0, 0, 0),
                Text = "Toggle",
                AutoButtonColor = false,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = u_dim2_new(0, 1, 0, 0),
                Size = u_dim2_new(1, 0, 0, 15),
                TextSize = 12,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })  items["Toggle"]:AddToTheme({TextColor3 = "Text"})
            
            instances:Create("UIStroke", {
                Parent = items["Toggle"].Instance,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Name = "\0"
            }):AddToTheme({Color = "Text Border"})
            
            items["Hold"] = instances:Create("TextButton", {
                Parent = items["Window"].Instance,
                FontFace = library_object.Font,
                TextColor3 = from_rgb(215, 215, 215),
                BorderColor3 = from_rgb(0, 0, 0),
                Text = "Hold",
                AutoButtonColor = false,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = u_dim2_new(0, 1, 0, 15),
                Size = u_dim2_new(1, 0, 0, 15),
                TextSize = 12,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })  items["Hold"]:AddToTheme({TextColor3 = "Text"})
            
            instances:Create("UIStroke", {
                Parent = items["Hold"].Instance,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Name = "\0"
            }):AddToTheme({Color = "Text Border"})
            
            items["Always"] = instances:Create("TextButton", {
                Parent = items["Window"].Instance,
                FontFace = library_object.Font,
                TextColor3 = from_rgb(215, 215, 215),
                BorderColor3 = from_rgb(0, 0, 0),
                Text = "Always",
                AutoButtonColor = false,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = u_dim2_new(0, 1, 0, 30),
                Size = u_dim2_new(1, 0, 0, 15),
                TextSize = 12,
                BackgroundColor3 = from_rgb(255, 255, 255)
            })  items["Always"]:AddToTheme({TextColor3 = "Text"})
             
            instances:Create("UIStroke", {
                Parent = items["Always"].Instance,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Name = "\0"
            }):AddToTheme({Color = "Text Border"})
        end

        local modes = {
            ["Toggle"] = items["Toggle"],
            ["Hold"] = items["Hold"],
            ["Always"] = items["Always"]
        }

        function keybind:Get()
            return keybind.Toggled, keybind.Key
        end

        function keybind:Set(key)
            if string_find(tostring(key), "Enum") then 
                self.Key = tostring(key)

                key = key.Name == "Backspace" and "None" or key.Name

                local key_string = keys[self.Key] or string_g_sub(key, "Enum.", "") or "None"
                local text_to_display = string_g_sub(string_g_sub(key_string, "KeyCode.", ""), "UserInputType.", "") or "None"

                self.Value = text_to_display
                items["KeyButton"].Instance.Text = text_to_display

                library_object.Flags[self.Flag] = {
                    Mode = self.Mode,
                    Key = self.Key,
                    Toggled = self.Toggled
                }

                if data.Callback then 
                    library_object:SafeCall(data.Callback, self.Toggled)
                end
            elseif type(key) == "table" then
                local real_key = key.Key == "Backspace" and "None" or key.Key
                self.Key = tostring(key.Key)

                if key.Mode then
                    self.Mode = key.Mode
                    self:SetMode(key.Mode)
                else
                    self.Mode = "Toggle"
                    self:SetMode("Toggle")
                end

                local key_string = keys[self.Key] or string_g_sub(tostring(real_key), "Enum.", "") or real_key
                local text_to_display = key_string and string_g_sub(string_g_sub(key_string, "KeyCode.", ""), "UserInputType.", "") or "None"

                text_to_display = string_g_sub(string_g_sub(key_string, "KeyCode.", ""), "UserInputType.", "")

                self.Value = text_to_display
                items["KeyButton"].Instance.Text = text_to_display

                if data.Callback then 
                    library_object:SafeCall(data.Callback, self.Toggled)
                end
            elseif table_find({"Toggle", "Hold", "Always"}, key) then
                self.Mode = key
                self:SetMode(keybind.Mode)

                if data.Callback then 
                    library_object:SafeCall(data.Callback, self.Toggled)
                end
            end

            self.Picking = false
        end

        function keybind:SetMode(mode)
            for index, value in modes do 
                if index == mode then 
                    value:ChangeItemTheme({TextColor3 = "Accent"})
                    value:Tween(nil, {TextColor3 = library_object.Theme.Accent})
                else
                    value:ChangeItemTheme({TextColor3 = "Text"})
                    value:Tween(nil, {TextColor3 = library_object.Theme.Text})
                end
            end

            library_object.Flags[self.Flag] = {
                Mode = self.Mode,
                Key = self.Key,
                Toggled = self.Toggled
            }

            if data.Callback then 
                library_object:SafeCall(data.Callback, self.Toggled)
            end
        end

        local debounce = false
        local render_stepped

        function keybind:SetOpen(bool)
            if debounce then
                return 
            end

            self.IsOpen = bool

            debounce = true

            if self.IsOpen then 
                items["Window"].Instance.Visible = true

                render_stepped = run_service.RenderStepped:Connect(function()
                    items["Window"].Instance.Position = u_dim2_new(0, items["KeyButton"].Instance.AbsolutePosition.X, 0, items["KeyButton"].Instance.AbsolutePosition.Y + 25)
                end)

                for index, value in library_object.OpenFrames do 
                    if value ~= self and value.Key then 
                        value:SetOpen(false)
                    end
                end

                library_object.OpenFrames[self] = self
            else
                if render_stepped then 
                    render_stepped:Disconnect()
                    render_stepped = nil
                end

                if library_object.OpenFrames[self] then 
                    library_object.OpenFrames[self] = nil
                end
            end

            local descendants = items["Window"].Instance:GetDescendants()
            table_insert(descendants, items["Window"].Instance)

            local new_tween

            for _,value in descendants do 
                local transparency_property = tween:GetProperty(value)

                if not transparency_property then 
                    continue 
                end

                if type(transparency_property) == "table" then 
                    for _, property in transparency_property do 
                        new_tween = tween:FadeItem(value, property, self.IsOpen, data.Window.FadeSpeed)
                    end
                else
                    new_tween = tween:FadeItem(value, transparency_property, self.IsOpen, data.Window.FadeSpeed)
                end
            end

            library_object:Connect(new_tween.Tween.Completed, function()
                debounce = false
                items["Window"].Instance.Visible = self.IsOpen
            end)
        end

        function keybind:Press(bool)
            if self.Mode == "Toggle" then 
                self.Toggled = not self.Toggled
            elseif self.Mode == "Hold" then 
                self.Toggled = bool
            elseif self.Mode == "Always" then 
                self.Toggled = true
            end

            library_object.Flags[data.Flag] = {
                Mode = self.Mode,
                Key = self.Key,
                Toggled = self.Toggled
            }

            if data.Callback then 
                library_object:SafeCall(data.Callback, self.Toggled)
            end
        end

        items["KeyButton"]:Connect("MouseButton1Click", function()
            if keybind.Picking then 
                return
            end

            keybind.Picking = true
            items["KeyButton"].Instance.Text = "..."

            local input_began 
            input_began = user_input_service.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then 
                    keybind:Set(input.KeyCode)
                else
                    keybind:Set(input.UserInputType)
                end

                input_began:Disconnect()
                input_began = nil
            end)
        end)

        library_object:Connect(user_input_service.InputBegan, function(input)
            if tostring(input.KeyCode) == keybind.Key or tostring(input.UserInputType) == keybind.Key and not keybind.Value == "None" then
                if keybind.Mode == "Toggle" then 
                    keybind:Press()
                elseif keybind.Mode == "Hold" then 
                    keybind:Press(true)
                elseif keybind.Mode == "Always" then 
                    keybind:Press(true)
                end
            end
        end)

        library_object:Connect(user_input_service.InputEnded, function(input)
            if tostring(input.KeyCode) == keybind.Key or tostring(input.UserInputType) == keybind.Key and not keybind.Value == "None"  then
                if keybind.Mode == "Hold" then 
                    keybind:Press(false)
                elseif keybind.Mode == "Always" then 
                    keybind:Press(true)
                end
            end
        end)

        items["KeyButton"]:Connect("MouseButton2Down", function()
            keybind:SetOpen(not keybind.IsOpen)
        end)

        items["Toggle"]:Connect("MouseButton1Down", function()
            keybind.Mode = "Toggle"
            keybind:SetMode("Toggle")
        end)

        items["Hold"]:Connect("MouseButton1Down", function()
            keybind.Mode = "Hold"
            keybind:SetMode("Hold")
        end)

        items["Always"]:Connect("MouseButton1Down", function()
            keybind.Mode = "Always"
            keybind:SetMode("Always")
        end)

        if data.Default then
            keybind.Mode = data.Mode or "Toggle"
            keybind:SetMode(keybind.Mode)
            keybind:Set({Key = data.Default, Mode = data.Mode})
        end

        library_object.SetFlags[keybind.Flag] = function(value)
            keybind:Set(value)
        end

        return keybind, items 
    end

    do
        library_object.Window = function(self, data)
            data = data or { }

            local window = {
                Name = data.Name or data.name or "bitchbot",
                FadeSpeed = data.FadeSpeed or data.fadespeed or 0.25,
                Size = data.Size or data.size or u_dim2_new(0, 763, 0, 530),

                Pages = { },
                Items = { },

                IsOpen = false
            }

            local items = { } do
                items["MainFrame"] = instances:Create("Frame", {
                    Parent = library_object.Holder.Instance,
                    Name = "\0",
                    AnchorPoint = vector2_new(0, 0),
                    Position = u_dim2_new(0, camera.ViewportSize.X / 2.5, 0, camera.ViewportSize.Y / 2.5),
                    BorderColor3 = from_rgb(31, 25, 36),
                    Size = window.Size,
                    BorderSizePixel = 2,
                    Visible = false,
                    BackgroundColor3 = from_rgb(39, 39, 44)
                })  items["MainFrame"]:AddToTheme({BackgroundColor3 = "Background", BorderColor3 = "Border"})

                items["MainFrame"]:MakeDraggable()
                items["MainFrame"]:MakeResizeable(vector2_new(window.Size.X.Offset, window.Size.Y.Offset), vector2_new(9999, 9999))

                instances:Create("UIStroke", {
                    Parent = items["MainFrame"].Instance,
                    Name = "\0",
                    Color = from_rgb(61, 60, 65),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Outline"})

                items["Inline"] = instances:Create("Frame", {
                    Parent = items["MainFrame"].Instance,
                    Name = "\0",
                    Position = u_dim2_new(0, 4, 0, 4),
                    BorderColor3 = from_rgb(61, 60, 65),
                    Size = u_dim2_new(1, -8, 1, -8),
                    BorderSizePixel = 2,
                    BackgroundColor3 = from_rgb(61, 60, 65)
                })  items["Inline"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Outline"})

                instances:Create("UIStroke", {
                    Parent = items["Inline"].Instance,
                    Name = "\0",
                    Color = from_rgb(31, 25, 36),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                items["AccentBackground"] = instances:Create("Frame", {
                    Parent = items["Inline"].Instance,
                    Name = "\0",
                    Position = u_dim2_new(0, 1, 0, 1),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(139, 69, 182)
                })  items["AccentBackground"]:AddToTheme({BackgroundColor3 = "Accent"})

                instances:Create("UIStroke", {
                    Parent = items["AccentBackground"].Instance,
                    Name = "\0",
                    Color = from_rgb(139, 94, 216),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Light Accent"})

                items["Title"] = instances:Create("TextLabel", {
                    Parent = items["AccentBackground"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = window.Name,
                    Size = u_dim2_new(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(0, 10, 0, 2),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Title"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Title"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                items["NormalBackground"] = instances:Create("Frame", {
                    Parent = items["AccentBackground"].Instance,
                    Name = "\0",
                    Position = u_dim2_new(0, 5, 0, 20),
                    BorderColor3 = from_rgb(31, 25, 36),
                    Size = u_dim2_new(1, -10, 1, -25),
                    BorderSizePixel = 2,
                    BackgroundColor3 = from_rgb(39, 39, 44)
                })  items["NormalBackground"]:AddToTheme({BackgroundColor3 = "Background", BorderColor3 = "Border"})

                instances:Create("UIStroke", {
                    Parent = items["NormalBackground"].Instance,
                    Name = "\0",
                    Color = from_rgb(61, 60, 65),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Outline"})

                items["Content"] = instances:Create("Frame", {
                    Parent = items["NormalBackground"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(0, 0, 0, 42),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, 0, 1, -42),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                items["Pages"] = instances:Create("Frame", {
                    Parent = items["NormalBackground"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(0, 1, 0, 1),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, -2, 0, 40),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                instances:Create("UIListLayout", {
                    Parent = items["Pages"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = u_dim_new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                window.Items = items
            end

            local debounce = false

            function window:SetOpen(bool)
                if debounce then 
                    return 
                end

                self.IsOpen = bool 

                debounce = true

                if self.IsOpen then 
                    items["MainFrame"].Instance.Visible = true
                end

                local descendants = items["MainFrame"].Instance:GetDescendants()
                table_insert(descendants, items["MainFrame"].Instance)

                local new_tween

                for _,value in descendants do 
                    local transparency_property = tween:GetProperty(value)

                    if not transparency_property then 
                        continue
                    end

                    if type(transparency_property) == "table" then 
                        for _, property in transparency_property do 
                            new_tween = tween:FadeItem(value, property, self.IsOpen, self.FadeSpeed)
                        end
                    else
                        new_tween = tween:FadeItem(value, transparency_property, self.IsOpen, self.FadeSpeed)
                    end
                end

                library_object:Connect(new_tween.Tween.Completed, function()
                    debounce = false
                    items["MainFrame"].Instance.Visible = self.IsOpen
                end)
            end

            function window:SetText(text)
                text = tostring(text)

                items["Title"].Instance.Text = text
            end

            library_object:Connect(user_input_service.InputBegan, function(input, gpe)
                if gpe then 
                    return 
                end

                if tostring(input.KeyCode) == library_object.MenuKeybind or tostring(input.UserInputType) == library_object.MenuKeybind then
                    window:SetOpen(not window.IsOpen)
                end
            end)

            window:SetOpen(true)
            return setmetatable(window, self)
        end

        library_object.Page = function(self, data)
            data = data or { }

            local page = {
                Window = self,

                Name = data.Name or data.name or "Page",
                Columns = data.Columns or data.columns or 3,

                Active = false,

                Items = { },
                ColumnsData = { }
            }

            local items = { } do
                items["Inactive"] = instances:Create("TextButton", {
                    Parent = page.Window.Items["Pages"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(0, 0, 0),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = u_dim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = from_rgb(49, 48, 52)
                })  items["Inactive"]:AddToTheme({BackgroundColor3 = "Page Background"})

                items["UIStroke"] = instances:Create("UIStroke", {
                    Parent = items["Inactive"].Instance,
                    Name = "\0",
                    Color = from_rgb(61, 60, 65),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })  items["UIStroke"]:AddToTheme({Color = "Outline"})

                items["Hide"] = instances:Create("Frame", {
                    Parent = items["Inactive"].Instance,
                    Name = "\0",
                    AnchorPoint = vector2_new(0, 1),
                    Position = u_dim2_new(0, 0, 1, 1),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(61, 60, 65)
                })  items["Hide"]:AddToTheme({BackgroundColor3 = "Outline"})

                items["Text"] = instances:Create("TextLabel", {
                    Parent = items["Inactive"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = page.Name,
                    AnchorPoint = vector2_new(0.5, 0.5),
                    Size = u_dim2_new(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(0.5, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Text"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Text"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                items["HideUpper"] = instances:Create("Frame", {
                    Parent = items["Inactive"].Instance,
                    Name = "\0",
                    AnchorPoint = vector2_new(1, 0),
                    Position = u_dim2_new(1, 0, 0, -1),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, 2, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(61, 60, 65)
                })  items["HideUpper"]:AddToTheme({BackgroundColor3 = "Outline"})

                items["HideLeft"] = instances:Create("Frame", {
                    Parent = items["Inactive"].Instance,
                    Name = "\0",
                    AnchorPoint = vector2_new(1, 0),
                    Position = u_dim2_new(1, 1, 0, -1),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(0, 1, 1, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(61, 60, 65)
                })  items["HideLeft"]:AddToTheme({BackgroundColor3 = "Outline"})

                items["PageContent"] = instances:Create("Frame", {
                    Parent = page.Window.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    Visible = false,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                instances:Create("UIListLayout", {
                    Parent = items["PageContent"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill
                })

                for index = 1, page.Columns do 
                    local new_column = instances:Create("ScrollingFrame", {
                        Parent = items["PageContent"].Instance,
                        Name = "\0",
                        ScrollBarImageColor3 = from_rgb(0, 0, 0),
                        Active = true,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        ScrollBarThickness = 0,
                        BackgroundTransparency = 1,
                        Size = u_dim2_new(1, 0, 1, 0),
                        BackgroundColor3 = from_rgb(255, 255, 255),
                        BorderColor3 = from_rgb(0, 0, 0),
                        BorderSizePixel = 0,
                        CanvasSize = u_dim2_new(0, 0, 0, 0)
                    })

                    instances:Create("UIListLayout", {
                        Parent = new_column.Instance,
                        Name = "\0",
                        Padding = u_dim_new(0, 12),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    instances:Create("UIPadding", {
                        Parent = new_column.Instance,
                        Name = "\0",
                        PaddingTop = u_dim_new(0, 12),
                        PaddingBottom = u_dim_new(0, 12),
                        PaddingRight = u_dim_new(0, 12),
                        PaddingLeft = u_dim_new(0, 12)
                    })

                    page.ColumnsData[index] = new_column
                end

                page.Items = items
            end

            local debounce = false

            function page:Turn(bool)
                if debounce then 
                    return 
                end

                self.Active = bool 

                debounce = true 

                if self.Active then
                    items["PageContent"].Instance.Visible = true 
                    items["PageContent"].Instance.Parent = page.Window.Items["Content"].Instance

                    items["UIStroke"]:ChangeItemTheme({Color = "Background"})
                    items["Inactive"]:ChangeItemTheme({BackgroundColor3 = "Background"})
                    items["Hide"]:ChangeItemTheme({BackgroundColor3 = "Background"})

                    items["UIStroke"]:Tween(nil, {Color = library_object.Theme.Background})
                    items["Inactive"]:Tween(nil, {BackgroundColor3 = library_object.Theme.Background})
                    items["Hide"]:Tween(nil, {BackgroundColor3 = library_object.Theme.Background})
                else
                    items["PageContent"].Instance.Parent = library_object.UnusedHolder.Instance

                    items["UIStroke"]:ChangeItemTheme({Color = "Outline"})
                    items["Inactive"]:ChangeItemTheme({BackgroundColor3 = "Page Background"})
                    items["Hide"]:ChangeItemTheme({BackgroundColor3 = "Outline"})

                    items["UIStroke"]:Tween(nil, {Color = library_object.Theme.Outline})
                    items["Inactive"]:Tween(nil, {BackgroundColor3 = library_object.Theme["Page Background"]})
                    items["Hide"]:Tween(nil, {BackgroundColor3 = library_object.Theme.Outline})
                end

                local descendants = items["PageContent"].Instance:GetDescendants()
                table_insert(descendants, items["PageContent"].Instance)

                local new_tween 

                for _,value in descendants do 
                    local transparency_property = tween:GetProperty(value)

                    if not transparency_property then
                        continue 
                    end

                    if type(transparency_property) == "table" then 
                        for _, property in transparency_property do 
                            new_tween = tween:FadeItem(value, property, self.Active, page.Window.FadeSpeed)
                        end
                    else
                        new_tween = tween:FadeItem(value, transparency_property, self.Active, page.Window.FadeSpeed)
                    end
                end

                library_object:Connect(new_tween.Tween.Completed, function()
                    debounce = false
                    items["PageContent"].Instance.Visible = self.Active
                end)
            end

            items["Inactive"]:Connect("MouseButton1Down", function()
                for index, value in page.Window.Pages do 
                    value:Turn(value == page)
                end
            end)

            if #page.Window.Pages == 0 then 
                page:Turn(true)
            end

            table_insert(page.Window.Pages, page)
            return setmetatable(page, library_object.Pages)
        end

        library_object.Pages.Section = function(self, data)
            data = data or { }

            local section = {
                Window = self.Window,
                Page = self,

                Name = data.Name or data.name or "Section",
                Side = data.Side or data.side or 1,

                Items = { }
            }

            local items = { } do
                items["Section"] = instances:Create("Frame", {
                    Parent = section.Page.ColumnsData[section.Side].Instance,
                    Name = "\0",
                    Size = u_dim2_new(1, 0, 0, 25),
                    BorderColor3 = from_rgb(31, 25, 36),
                    BorderSizePixel = 2,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = from_rgb(39, 39, 44)
                })  items["Section"]:AddToTheme({BackgroundColor3 = "Background", BorderColor3 = "Border"})

                instances:Create("UIStroke", {
                    Parent = items["Section"].Instance,
                    Name = "\0",
                    Color = from_rgb(61, 60, 65),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Outline"})

                items["Text"] = instances:Create("TextLabel", {
                    Parent = items["Section"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = section.Name,
                    Size = u_dim2_new(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(0, 2, 0, -13),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Text"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Text"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                instances:Create("UIPadding", {
                    Parent = items["Section"].Instance,
                    Name = "\0",
                    PaddingBottom = u_dim_new(0, 8)
                })

                items["Content"] = instances:Create("Frame", {
                    Parent = items["Section"].Instance,
                    Name = "\0",
                    BorderColor3 = from_rgb(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(0, 8, 0, 8),
                    Size = u_dim2_new(1, -16, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                instances:Create("UIListLayout", {
                    Parent = items["Content"].Instance,
                    Name = "\0",
                    Padding = u_dim_new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                section.Items = items
            end

            return setmetatable(section, library_object.Sections)
        end

        library_object.Sections.Toggle = function(self, data)
            data = data or { }

            local toggle = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = data.Name or data.name or "Toggle",
                Flag = data.Flag or data.flag or library_object:NextFlag(),
                Default = data.Default or data.default or false,
                Callback = data.Callback or data.callback or function() end,

                Value = false,
            }

            local items = { } do 
                items["Toggle"] = instances:Create("TextButton", {
                    Parent = toggle.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(0, 0, 0),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = u_dim2_new(1, 0, 0, 15),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                items["Indicator"] = instances:Create("Frame", {
                    Parent = items["Toggle"].Instance,
                    Name = "\0",
                    AnchorPoint = vector2_new(0, 0.5),
                    Position = u_dim2_new(0, 0, 0.5, 0),
                    BorderColor3 = from_rgb(61, 60, 65),
                    Size = u_dim2_new(0, 12, 0, 12),
                    BorderSizePixel = 2,
                    BackgroundColor3 = from_rgb(39, 39, 44)
                })  items["Indicator"]:AddToTheme({BackgroundColor3 = "Element", BorderColor3 = "Outline"})

                instances:Create("UIStroke", {
                    Parent = items["Indicator"].Instance,
                    Name = "\0",
                    Color = from_rgb(31, 25, 36),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                items["Inline"] = instances:Create("Frame", {
                    Parent = items["Indicator"].Instance,
                    Name = "\0",
                    Position = u_dim2_new(0, 1, 0, 1),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(39, 39, 44)
                })  items["Inline"]:AddToTheme({BackgroundColor3 = "Element"})

                items["Text"] = instances:Create("TextLabel", {
                    Parent = items["Toggle"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = toggle.Name,
                    AnchorPoint = vector2_new(0, 0.5),
                    Size = u_dim2_new(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(0, 22, 0.5, 1),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Text"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Text"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                items["SubElements"] = instances:Create("Frame", {
                    Parent = items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = from_rgb(0, 0, 0),
                    AnchorPoint = vector2_new(1, 0),
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(1, 0, 0, 0),
                    Size = u_dim2_new(0, 0, 0, 20),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                instances:Create("UIListLayout", {
                    Parent = items["SubElements"].Instance,
                    Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = u_dim_new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            function toggle:Get()
                return self.Value 
            end

            function toggle:SetVisibility(bool)
                items["Toggle"].Instance.Visible = bool 
            end

            function toggle:Colorpicker(data)
                data = data or { }

                local colorpicker = {
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,

                    Name = data.Name or data.name or "Colorpicker",
                    Flag = data.Flag or data.flag or library_object:NextFlag(),
                    Default = data.Default or data.default or from_rgb(255, 255, 255),
                    Alpha = data.Alpha or data.alpha or 0,
                    Callback = data.Callback or data.callback or function(value) end,
                }

                local new_colorpicker, ColorpickerItems = library_object:CreateColorpicker({
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,
                    Name = colorpicker.Name,
                    Flag = colorpicker.Flag,
                    Default = colorpicker.Default,
                    Alpha = colorpicker.Alpha,
                    Callback = colorpicker.Callback,
                    Parent = items["SubElements"]   
                })

                return new_colorpicker
            end

            function toggle:Keybind(data)
                data = data or { }

                local keybind = {
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,

                    Name = data.Name or data.name or "Keybind",
                    Flag = data.Flag or data.flag or library_object:NextFlag(),
                    Default = data.Default or data.default or Enum.KeyCode.Z,
                    Callback = data.Callback or data.callback or function() end,
                    Mode = data.Mode or data.mode or "Toggle",
                }

                local new_keybind, KeybindItems = library_object:CreateKeybind({
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,
                    Name = keybind.Name,
                    Flag = keybind.Flag,
                    Default = keybind.Default,
                    Callback = keybind.Callback,
                    Mode = keybind.Mode,
                    Parent = items["SubElements"]
                })

                return new_keybind
            end

            function toggle:Set(bool)
                self.Value = bool
                library_object.Flags[self.Flag] = bool 

                if self.Value then 
                    items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Light Accent", BorderColor3 = "Outline"})
                    items["Inline"]:ChangeItemTheme({BackgroundColor3 = "Accent"})

                    items["Indicator"]:Tween(nil, {BackgroundColor3 = library_object.Theme["Light Accent"]})
                    items["Inline"]:Tween(nil, {BackgroundColor3 = library_object.Theme.Accent})
                else
                    items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Element", BorderColor3 = "Outline"})
                    items["Inline"]:ChangeItemTheme({BackgroundColor3 = "Element"})

                    items["Indicator"]:Tween(nil, {BackgroundColor3 = library_object.Theme.Element})
                    items["Inline"]:Tween(nil, {BackgroundColor3 = library_object.Theme.Element})
                end

                if self.Callback then 
                    library_object:SafeCall(self.Callback, self.Value)
                end
            end

            items["Toggle"]:Connect("MouseButton1Down", function()
                toggle:Set(not toggle.Value)
            end)

            toggle:Set(toggle.Default)

            library_object.SetFlags[toggle.Flag] = function(value)
                toggle:Set(value)
            end

            return toggle 
        end

        library_object.Sections.Button = function(self)
            local button = {
                Window = self.Window,
                Page = self.Page,
                Section = self,
            }

            local items = { } do
                items["Button"] = instances:Create("Frame", {
                    Parent = button.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                items["Holder"] = instances:Create("Frame", {
                    Parent = items["Button"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(0, 15, 0, 0),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, -30, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                instances:Create("UIListLayout", {
                    Parent = items["Holder"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = u_dim_new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            function button:NewButton(data)
                data = data or { }

                local new_button = {
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,

                    Name = data.Name or data.name or "Button",
                    Callback = data.Callback or data.callback or function() end,
                }

                local sub_items = { } do
                    sub_items["NewButton"] = instances:Create("TextButton", {
                        Parent = items["Holder"].Instance,
                        Name = "\0",
                        FontFace = library_object.Font,
                        TextColor3 = from_rgb(0, 0, 0),
                        BorderColor3 = from_rgb(61, 60, 65),
                        Text = "",
                        AutoButtonColor = false,
                        Size = u_dim2_new(1, 0, 1, 0),
                        BorderSizePixel = 2,
                        TextSize = 14,
                        BackgroundColor3 = from_rgb(139, 94, 216)
                    })  sub_items["NewButton"]:AddToTheme({BackgroundColor3 = "Light Accent", BorderColor3 = "Outline"})

                    instances:Create("UIStroke", {
                        Parent = sub_items["NewButton"].Instance,
                        Name = "\0",
                        Color = from_rgb(31, 25, 36),
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    }):AddToTheme({Color = "Border"})

                    sub_items["Inline"] = instances:Create("TextButton", {
                        Parent = sub_items["NewButton"].Instance,
                        Name = "\0",
                        FontFace = library_object.Font,
                        TextColor3 = from_rgb(0, 0, 0),
                        BorderColor3 = from_rgb(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        Position = u_dim2_new(0, 1, 0, 1),
                        Size = u_dim2_new(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        TextSize = 14,
                        BackgroundColor3 = from_rgb(139, 69, 182)
                    })  sub_items["Inline"]:AddToTheme({BackgroundColor3 = "Accent"})

                    sub_items["Text"] = instances:Create("TextLabel", {
                        Parent = sub_items["Inline"].Instance,
                        Name = "\0",
                        FontFace = library_object.Font,
                        TextColor3 = from_rgb(230, 230, 230),
                        BorderColor3 = from_rgb(0, 0, 0),
                        Text = new_button.Name,
                        BackgroundTransparency = 1,
                        Size = u_dim2_new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        TextSize = 12,
                        BackgroundColor3 = from_rgb(255, 255, 255)
                    })  sub_items["Text"]:AddToTheme({TextColor3 = "Text"})

                    instances:Create("UIStroke", {
                        Parent = sub_items["Text"].Instance,
                        Name = "\0",
                        LineJoinMode = Enum.LineJoinMode.Miter
                    }):AddToTheme({Color = "Text Border"})
                end

                sub_items["Inline"]:Connect("MouseButton1Down", function()
                    library_object:SafeCall(new_button.Callback)
                end)

                return new_button
            end

            return button
        end

        library_object.Sections.Slider = function(self, data)
            data = data or { }

            local slider = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = data.Name or data.name or "Slider",
                Flag = data.Flag or data.flag or library_object:NextFlag(),
                Default = data.Default or data.default or 0,
                Min = data.Min or data.min or 0,
                Max = data.Max or data.max or 100,
                Decimals = data.Decimals or data.decimals or 1,
                Suffix = data.Suffix or data.suffix or "",
                Callback = data.Callback or data.callback or function() end,

                Value = 0,
                Sliding = false
            }

            local items = { } do
                items["Slider"] = instances:Create("Frame", {
                    Parent = slider.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, 0, 0, 33),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                items["Text"] = instances:Create("TextLabel", {
                    Parent = items["Slider"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = slider.Name,
                    BackgroundTransparency = 1,
                    Size = u_dim2_new(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Text"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Text"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                items["RealSlider"] = instances:Create("TextButton", {
                    Parent = items["Slider"].Instance,
                    AutoButtonColor = false,
                    Text = "",
                    Name = "\0",
                    AnchorPoint = vector2_new(0, 1),
                    Position = u_dim2_new(0, 0, 1, 0),
                    BorderColor3 = from_rgb(61, 60, 65),
                    Size = u_dim2_new(1, 0, 0, 12),
                    BorderSizePixel = 2,
                    BackgroundColor3 = from_rgb(39, 39, 44)
                })  items["RealSlider"]:AddToTheme({BorderColor3 = "Outline", BackgroundColor3 = "Element"})

                instances:Create("UIStroke", {
                    Parent = items["RealSlider"].Instance,
                    Name = "\0",
                    Color = from_rgb(31, 25, 36),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                items["Accent"] = instances:Create("Frame", {
                    Parent = items["RealSlider"].Instance,
                    Name = "\0",
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(0.4000000059604645, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(139, 69, 182)
                })  items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})

                items["Value"] = instances:Create("TextLabel", {
                    Parent = items["RealSlider"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = "0.4s",
                    BackgroundTransparency = 1,
                    Size = u_dim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Value"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Value"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})
            end

            function slider:Get()
                return self.Value
            end

            function slider:SetVisibility(bool)
                items["Slider"].Instance.Visible = bool
            end

            function slider:Set(value)
                self.Value = math_clamp(library_object:Round(value, self.Decimals), self.Min, self.Max)

                library_object.Flags[self.Flag] = self.Value

                items["Accent"]:Tween(TweenInfo.new(0.21, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = u_dim2_new((self.Value - self.Min) / (self.Max - self.Min), 0, 1, 0)})
                items["Value"].Instance.Text = string_format("%s%s", tostring(self.Value), self.Suffix)

                if self.Callback then 
                    library_object:SafeCall(self.Callback, self.Value)
                end
            end

            items["RealSlider"]:Connect("InputBegan", function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    slider.Sliding = true 

                    local size_x = (input.Position.X - items["RealSlider"].Instance.AbsolutePosition.X) / items["RealSlider"].Instance.AbsoluteSize.X
                    local value = ((slider.Max - slider.Min) * size_x) + slider.Min

                    slider:Set(value)
                end
            end)

            items["RealSlider"]:Connect("InputEnded", function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    slider.Sliding = false
                end
            end)

            library_object:Connect(user_input_service.InputChanged, function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    if slider.Sliding then
                        local size_x = (input.Position.X - items["RealSlider"].Instance.AbsolutePosition.X) / items["RealSlider"].Instance.AbsoluteSize.X
                        local value = ((slider.Max - slider.Min) * size_x) + slider.Min

                        slider:Set(value)
                    end
                end
            end)

            if slider.Default then 
                slider:Set(slider.Default)
            end
        
            library_object.SetFlags[slider.Flag] = function(value)
                slider:Set(value)
            end

            return slider
        end

        library_object.Sections.Dropdown = function(self, data)
            data = data or { }  

            local dropdown = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = data.Name or data.name or "Dropdown",
                Flag = data.Flag or data.flag or library_object:NextFlag(),
                Items = data.Items or data.items or { "One", "Two", "Three" },
                Default = data.Default or data.default or nil,
                Callback = data.Callback or data.callback or function() end,
                Multi = data.Multi or data.multi or false,

                Value = { },
                Options = { },

                IsOpen = false
            }

            local items = { } do
                items["Dropdown"] = instances:Create("Frame", {
                    Parent = dropdown.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, 0, 0, 38),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                items["Text"] = instances:Create("TextLabel", {
                    Parent = items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = dropdown.Name,
                    BackgroundTransparency = 1,
                    Size = u_dim2_new(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Text"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Text"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                items["RealDropdown"] = instances:Create("TextButton", {
                    Parent = items["Dropdown"].Instance,
                    AutoButtonColor = false,
                    Text = "",
                    Name = "\0",
                    AnchorPoint = vector2_new(0, 1),
                    Position = u_dim2_new(0, 0, 1, 0),
                    BorderColor3 = from_rgb(61, 60, 65),
                    Size = u_dim2_new(1, 0, 0, 15),
                    BorderSizePixel = 2,
                    BackgroundColor3 = from_rgb(39, 39, 44)
                })  items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element", BorderColor3 = "Outline"})

                instances:Create("UIStroke", {
                    Parent = items["RealDropdown"].Instance,
                    Name = "\0",
                    Color = from_rgb(31, 25, 36),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                items["Value"] = instances:Create("TextLabel", {
                    Parent = items["RealDropdown"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = "--",
                    Size = u_dim2_new(1, -25, 1, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = u_dim2_new(0, 2, 0, 0),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Value"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Value"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                instances:Create("Frame", {
                    Parent = items["Value"].Instance,
                    Name = "\0",
                    AnchorPoint = vector2_new(1, 0),
                    Position = u_dim2_new(1, 0, 0, 0),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(0, 1, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(31, 25, 36)
                }):AddToTheme({BackgroundColor3 = "Border"})

                items["OpenIcon"] = instances:Create("TextLabel", {
                    Parent = items["RealDropdown"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = ">",
                    AnchorPoint = vector2_new(1, 0),
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(1, -4, 0, 0),
                    Size = u_dim2_new(0, 15, 0, 15),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["OpenIcon"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["OpenIcon"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                items["OptionHolder"] = instances:Create("Frame", {
                    Parent = library_object.Holder.Instance,
                    Name = "\0",
                    Visible = false,
                    BorderColor3 = from_rgb(61, 60, 65),
                    Position = u_dim2_new(0, items["RealDropdown"].Instance.AbsolutePosition.X, 0, items["RealDropdown"].Instance.AbsolutePosition.Y + 20),
                    Size = u_dim2_new(0, items["RealDropdown"].Instance.AbsoluteSize.X, 0, 0),
                    BorderSizePixel = 2,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = from_rgb(39, 39, 44)
                })  items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Background", BorderColor3 = "Outline"})

                instances:Create("UIStroke", {
                    Parent = items["OptionHolder"].Instance,
                    Name = "\0",
                    Color = from_rgb(31, 25, 36),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                instances:Create("UIPadding", {
                    Parent = items["OptionHolder"].Instance,
                    Name = "\0",
                    PaddingTop = u_dim_new(0, 5),
                    PaddingBottom = u_dim_new(0, 5),
                    PaddingRight = u_dim_new(0, 5),
                    PaddingLeft = u_dim_new(0, 5)
                })

                instances:Create("UIListLayout", {
                    Parent = items["OptionHolder"].Instance,
                    Name = "\0",
                    Padding = u_dim_new(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            function dropdown:Get()
                return dropdown.Value
            end

            function dropdown:SetVisibility(bool)
                items["Dropdown"].Instance.Visible = bool
            end
            
            function dropdown:Set(option)
                if self.Multi then 
                    if type(option) ~= "table" then 
                        return 
                    end

                    self.Value = option
                    library_object.Flags[self.Flag] = option

                    for index, value in option do
                        local option_data = self.Options[value]

                        if not option_data then
                            continue
                        end

                        option_data.Selected = true
                        option_data:Toggle("Active")
                    end

                    local text_to_display = #self.Value == 0 and "--" or table_concat(self.Value, ", ")
                    items["Value"].Instance.Text = text_to_display
                else
                    local option_data = self.Options[option]

                    if not option_data then
                        return
                    end

                    for index, value in self.Options do 
                        if value ~= option_data then 
                            value.Selected = false
                            value:Toggle("Inactive")
                        else
                            value.Selected = true
                            value:Toggle("Active")
                        end
                    end

                    self.Value = option_data.Name
                    library_object.Flags[self.Flag] = option_data.Name

                    items["Value"].Instance.Text = option_data.Name
                end

                if self.Callback then 
                    library_object:SafeCall(self.Callback, self.Value)
                end
            end

            function dropdown:AddOption(option)
                local option_button = instances:Create("TextButton", {
                    Parent = items["OptionHolder"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = option,
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = u_dim2_new(1, 0, 0, 15),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  option_button:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = option_button.Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                local option_data = {
                    Name = option,
                    Selected = false,
                    Button = option_button,
                }

                function option_data:Toggle(status)
                    if status == "Active" then 
                        self.Button:ChangeItemTheme({TextColor3 = "Accent"})
                        self.Button:Tween(nil, {TextColor3 = library_object.Theme.Accent})
                    else
                        self.Button:ChangeItemTheme({TextColor3 = "Text"}) 
                        self.Button:Tween(nil, {TextColor3 = library_object.Theme.Text})
                    end
                end

                function option_data:Set()
                    if not dropdown.IsOpen then 
                        return 
                    end

                    self.Selected = not self.Selected

                    if dropdown.Multi then 
                        local index = table_find(dropdown.Value, self.Name)

                        if index then 
                            table_remove(dropdown.Value, index)
                        else
                            table_insert(dropdown.Value, self.Name)
                        end

                        library_object.Flags[dropdown.Flag] = dropdown.Value

                        self:Toggle(index and "Inactive" or "Active")

                        local text_to_display = #dropdown.Value == 0 and "--" or table_concat(dropdown.Value, ", ")
                        items["Value"].Instance.Text = text_to_display
                    else
                        if self.Selected then 
                            for index, value in dropdown.Options do 
                                if value ~= self then 
                                    value.Selected = false
                                    value:Toggle("Inactive")
                                end
                            end

                            self:Toggle("Active")

                            library_object.Flags[dropdown.Flag] = self.Name
                            dropdown.Value = self.Name

                            items["Value"].Instance.Text = self.Name
                        else
                            self:Toggle("Inactive")

                            library_object.Flags[dropdown.Flag] = nil
                            dropdown.Value = nil

                            items["Value"].Instance.Text = "--"
                        end
                    end

                    if dropdown.Callback then 
                        library_object:SafeCall(dropdown.Callback, dropdown.Value)
                    end 
                end

                option_data.Button:Connect("MouseButton1Down", function()
                    option_data:Set()
                end)

                self.Options[option_data.Name] = option_data
                return option_data
            end

            function dropdown:Remove(option)
                if self.Options[option] then 
                    self.Options[option].Button:Clean()
                    self.Options[option] = nil
                end
            end

            function dropdown:Clear()
                for index, value in self.Options do 
                    self:Remove(value.Name)
                end
            end

            function dropdown:Refresh(list)
                dropdown:Clear()

                for index, value in list do 
                    dropdown:AddOption(value)
                end
            end

            local debounce = false
            local render_stepped

            function dropdown:SetOpen(bool)
                if debounce then
                    return
                end

                self.IsOpen = bool 

                debounce = true 

                if self.IsOpen then 
                    items["OptionHolder"].Instance.Visible = true
                    items["OpenIcon"]:Tween(nil, {Rotation = 90})

                    render_stepped = run_service.RenderStepped:Connect(function()
                        items["OptionHolder"].Instance.Position = u_dim2_new(0, items["RealDropdown"].Instance.AbsolutePosition.X, 0, items["RealDropdown"].Instance.AbsolutePosition.Y + 20)
                        items["OptionHolder"].Instance.Size = u_dim2_new(0, items["RealDropdown"].Instance.AbsoluteSize.X, 0, 0)
                    end)

                    for index, value in library_object.OpenFrames do 
                        if value ~= self and value.Options then 
                            value:SetOpen(false)
                        end
                    end

                    library_object.OpenFrames[self] = self
                else
                    if library_object.OpenFrames[self] then 
                        library_object.OpenFrames[self] = nil
                    end

                    items["OpenIcon"]:Tween(nil, {Rotation = 0})

                    if render_stepped then 
                        render_stepped:Disconnect()
                        render_stepped = nil
                    end
                end

                local descendants = items["OptionHolder"].Instance:GetDescendants()
                table_insert(descendants, items["OptionHolder"].Instance)

                local new_tween 

                for _,value in descendants do 
                    local transparency_property = tween:GetProperty(value)

                    if not transparency_property then 
                        continue
                    end

                    if type(transparency_property) == "table" then 
                        for _, property in transparency_property do 
                            new_tween = tween:FadeItem(value, property, self.IsOpen, dropdown.Window.FadeSpeed)
                        end
                    else
                        new_tween = tween:FadeItem(value, transparency_property, self.IsOpen, dropdown.Window.FadeSpeed)
                    end
                end

                library_object:Connect(new_tween.Tween.Completed, function()
                    debounce = false
                    items["OptionHolder"].Instance.Visible = self.IsOpen
                end)
            end

            items["RealDropdown"]:Connect("MouseButton1Down", function()
                dropdown:SetOpen(not dropdown.IsOpen)
            end)

            library_object:Connect(user_input_service.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                    if library_object:IsMouseOverFrame(items["OptionHolder"]) then
                        return
                    end

                    if debounce then 
                        return 
                    end

                    dropdown:SetOpen(false)
                end                    
            end)

            for index, value in dropdown.Items do 
                dropdown:AddOption(value)
            end

            if dropdown.Default then 
                dropdown:Set(dropdown.Default)
            end

            library_object.SetFlags[dropdown.Flag] = function(value)
                dropdown:Set(value)
            end

            return dropdown 
        end

        library_object.Sections.Label = function(self, text, alignment)
            local label = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = text or "Label",
                Alignment = alignment or "Left"
            }

            local items = { } do
                items["Label"] = instances:Create("Frame", {
                    Parent = label.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = u_dim2_new(1, 0, 0, 20),
                    BorderColor3 = from_rgb(0, 0, 0),
                    ZIndex = 1,
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                items["Text"] = instances:Create("TextLabel", {
                    Parent = items["Label"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(255, 255, 255),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = label.Name,
                    TextXAlignment = Enum.TextXAlignment[label.Alignment],
                    AutomaticSize = Enum.AutomaticSize.X,
                    AnchorPoint = vector2_new(0, 0.5),
                    Size = u_dim2_new(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    ZIndex = 1,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Text"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Text"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter,
                }):AddToTheme({Color = "Text Border"})

                items["SubElements"] = instances:Create("Frame", {
                    Parent = items["Label"].Instance,
                    Name = "\0",
                    BorderColor3 = from_rgb(0, 0, 0),
                    AnchorPoint = vector2_new(1, 0),
                    BackgroundTransparency = 1,
                    Position = u_dim2_new(1, 0, 0, 0),
                    Size = u_dim2_new(0, 0, 0, 20),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                instances:Create("UIListLayout", {
                    Parent = items["SubElements"].Instance,
                    Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = u_dim_new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end

            function label:Colorpicker(data)
                data = data or { }

                local colorpicker = {
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,

                    Name = data.Name or data.name or "Colorpicker",
                    Flag = data.Flag or data.flag or library_object:NextFlag(),
                    Default = data.Default or data.default or from_rgb(255, 255, 255),
                    Alpha = data.Alpha or data.alpha or 0,
                    Callback = data.Callback or data.callback or function(value) end,
                }

                local new_colorpicker, ColorpickerItems = library_object:CreateColorpicker({
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,
                    Name = colorpicker.Name,
                    Flag = colorpicker.Flag,
                    Default = colorpicker.Default,
                    Alpha = colorpicker.Alpha,
                    Callback = colorpicker.Callback,
                    Parent = items["SubElements"]   
                })

                return new_colorpicker
            end

            function label:Keybind(data)
                data = data or { }

                local keybind = {
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,

                    Name = data.Name or data.name or "Keybind",
                    Flag = data.Flag or data.flag or library_object:NextFlag(),
                    Default = data.Default or data.default or Enum.KeyCode.Z,
                    Callback = data.Callback or data.callback or function() end,
                    Mode = data.Mode or data.mode or "Toggle",
                }

                local new_keybind, KeybindItems = library_object:CreateKeybind({
                    Window = self.Window,
                    Page = self.Page,
                    Section = self,
                    Name = keybind.Name,
                    Flag = keybind.Flag,
                    Default = keybind.Default,
                    Callback = keybind.Callback,
                    Mode = keybind.Mode,
                    Parent = items["SubElements"]
                })

                return new_keybind
            end

            return label
        end

        library_object.Sections.Textbox = function(self, data)
            data = data or { }

            local textbox = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = data.Name or data.name or "Textbox",
                Placeholder = data.Placeholder or data.placeholder or "...",
                Flag = data.Flag or data.flag or library_object:NextFlag(),
                Default = data.Default or data.default or "",
                Callback = data.Callback or data.callback or function() end,

                Value = "",
            }

            local items = { } do
                items["Textbox"] = instances:Create("Frame", {
                    Parent = textbox.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = from_rgb(0, 0, 0),
                    Size = u_dim2_new(1, 0, 0, 38),
                    BorderSizePixel = 0,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })

                items["Text"] = instances:Create("TextLabel", {
                    Parent = items["Textbox"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    TextColor3 = from_rgb(230, 230, 230),
                    BorderColor3 = from_rgb(0, 0, 0),
                    Text = textbox.Name,
                    BackgroundTransparency = 1,
                    Size = u_dim2_new(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = from_rgb(255, 255, 255)
                })  items["Text"]:AddToTheme({TextColor3 = "Text"})

                instances:Create("UIStroke", {
                    Parent = items["Text"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})

                items["Input"] = instances:Create("TextBox", {
                    Parent = items["Textbox"].Instance,
                    Name = "\0",
                    FontFace = library_object.Font,
                    AnchorPoint = vector2_new(0, 1),
                    PlaceholderColor3 = from_rgb(185, 185, 185),
                    PlaceholderText = textbox.Placeholder,
                    TextSize = 12,
                    Size = u_dim2_new(1, 0, 0, 15),
                    ClipsDescendants = true,
                    BorderColor3 = from_rgb(61, 60, 65),
                    Text = "",
                    Position = u_dim2_new(0, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextColor3 = from_rgb(230, 230, 230),
                    ClearTextOnFocus = false,
                    BorderSizePixel = 2,
                    BackgroundColor3 = from_rgb(39, 39, 44)
                })  items["Input"]:AddToTheme({TextColor3 = "Text", PlaceholderColor3 = "Inactive Text", BackgroundColor3 = "Element", BorderColor3 = "Outline"})

                instances:Create("UIStroke", {
                    Parent = items["Input"].Instance,
                    Name = "\0",
                    Color = from_rgb(31, 25, 36),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                instances:Create("UIPadding", {
                    Parent = items["Input"].Instance,
                    Name = "\0",
                    PaddingLeft = u_dim_new(0, 5)
                })

                instances:Create("UIStroke", {
                    Parent = items["Input"].Instance,
                    Name = "\0",
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Text Border"})
            end

            function textbox:Get()
                return self.Value
            end

            function textbox:Set(text)
                text = tostring(text)

                items["Input"].Instance.Text = text
                self.Value = text
                library_object.Flags[self.Flag] = text

                items["Input"]:ChangeItemTheme({TextColor3 = "Text", PlaceholderColor3 = "Inactive Text", BackgroundColor3 = "Element", BorderColor3 = "Outline"})
                items["Input"]:Tween(nil, {TextColor3 = library_object.Theme.Text})

                if textbox.Callback then
                    library_object:SafeCall(textbox.Callback, self.Value)
                end
            end

            function textbox:SetVisibility(bool)
                items["Textbox"].Instance.Visible = bool
            end

            items["Input"]:Connect("Focused", function()
                items["Input"]:ChangeItemTheme({TextColor3 = "Accent", PlaceholderColor3 = "Inactive Text", BackgroundColor3 = "Element", BorderColor3 = "Outline"})
                items["Input"]:Tween(nil, {TextColor3 = library_object.Theme.Accent})
            end)

            items["Input"]:Connect("FocusLost", function()
                textbox:Set(items["Input"].Instance.Text)
            end)

            if textbox.Default then 
                textbox:Set(textbox.Default)
            end

            library_object.SetFlags[textbox.Flag] = function(value)
                textbox:Set(value)
            end

            return textbox
        end
    end
end

return library_object

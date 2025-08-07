local ui = require("./ui")

local Fusion = require("../roblox_packages/fusion")

type UsedAs<T> = Fusion.UsedAs<T>
type Array<T> = { T }
type Dictionary<T> = { [string]: T }

local defaultcomponents = {}

function defaultcomponents.AspectRatio(Scope: Fusion.Scope<typeof(Fusion)>, Parent: Instance, AspectRatio: number)
	return ui.CreateObject(Scope, "UIAspectRatioConstraint", {
		AspectRatio = AspectRatio,
		Parent = Parent,
	})
end

function defaultcomponents.VerticalBottomStackLayout(Scope: Fusion.Scope<typeof(Fusion)>)
    return ui.CreateObject(Scope, "UIListLayout", {
		Padding = UDim.new(0, 0),
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		HorizontalFlex = Enum.UIFlexAlignment.None,
		ItemLineAlignment = Enum.ItemLineAlignment.Automatic,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		VerticalFlex = Enum.UIFlexAlignment.None,
	})
end

function defaultcomponents.VerticalCenterStackLayout(Scope: Fusion.Scope<typeof(Fusion)>)
    return ui.CreateObject(Scope, "UIListLayout", {
            Padding = UDim.new(0.05, 0),
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            HorizontalFlex = Enum.UIFlexAlignment.None,
            ItemLineAlignment = Enum.ItemLineAlignment.Automatic,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            VerticalFlex = Enum.UIFlexAlignment.None,
	})
end

function defaultcomponents.Frame(
	Scope: Fusion.Scope<typeof(Fusion)>,
	Properties: Dictionary<any>?,
	Children: Array<any>?,
	Events: Dictionary<any>?
)
	local DefaultProps = {
		BackgroundColor3 = Color3.fromRGB(44, 44, 44),
		BackgroundTransparency = 0.5,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
	}

	local DefaultChildren = {
		ui.CreateObject(Scope, "UICorner", {
			CornerRadius = UDim.new(0.1, 0),
		}),
	}

	local FinalizedProperties = ui.Merge(DefaultProps, Properties)
	local FinalizedChildren = ui.Merge(DefaultChildren, Children)

	return ui.CreateObject(Scope, "Frame", FinalizedProperties, FinalizedChildren, Events)
end

function defaultcomponents.ImageButton(
	Scope: Fusion.Scope<typeof(Fusion)>,
	Properties: Dictionary<any>?,
	Children: Array<any>?,
	Events: Dictionary<any>?
)
	local DefaultProps = {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
	}

	local DefaultChildren = {
		ui.CreateObject(Scope, "UICorner", {
			CornerRadius = UDim.new(0.1, 0),
		}),
	}

	local FinalizedProperties = ui.Merge(DefaultProps, Properties)
	local FinalizedChildren = ui.Merge(DefaultChildren, Children)

	return ui.CreateObject(Scope, "ImageButton", FinalizedProperties, FinalizedChildren, Events)
end

function defaultcomponents.ImageLabel(
	Scope: Fusion.Scope<typeof(Fusion)>,
	Properties: Dictionary<any>?,
	Children: Array<any>?,
	Events: Dictionary<any>?
)
	local DefaultProps = {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
	}

	local DefaultChildren = {
		ui.CreateObject(Scope, "UICorner", {
			CornerRadius = UDim.new(0.1, 0),
		}),
	}

	local FinalizedProperties = ui.Merge(DefaultProps, Properties)
	local FinalizedChildren = ui.Merge(DefaultChildren, Children)

	return ui.CreateObject(Scope, "ImageLabel", FinalizedProperties, FinalizedChildren, Events)
end

function defaultcomponents.TextButton(
	Scope: Fusion.Scope<typeof(Fusion)>,
	Properties: Dictionary<any>?,
	Children: Array<any>?,
	Events: Dictionary<any>?
)
	local DefaultProps = {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		TextColor3 = Color3.new(1, 1, 1),
		Font = Enum.Font.RobotoMono,
		TextScaled = true,
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
	}

	local DefaultChildren = {
		ui.CreateObject(Scope, "UICorner", {
			CornerRadius = UDim.new(0.1, 0),
		}),
		ui.CreateObject(Scope, "UIStroke", {
			Color = Color3.fromRGB(56, 56, 56),
			Thickness = 4,
			Transparency = 0.6,
		}),
	}

	local FinalizedProperties = ui.Merge(DefaultProps, Properties)
	local FinalizedChildren = ui.Merge(DefaultChildren, Children)

	return ui.CreateObject(Scope, "TextButton", FinalizedProperties, FinalizedChildren, Events)
end

function defaultcomponents.TextLabel(
	Scope: Fusion.Scope<typeof(Fusion)>,
	Properties: Dictionary<any>?,
	Children: Array<any>?,
	Events: Dictionary<any>?
)
	local DefaultProps = {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		TextColor3 = Color3.new(1, 1, 1),
		Font = Enum.Font.RobotoMono,
		TextScaled = true,
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
	}

	local DefaultChildren = {
		ui.CreateObject(Scope, "UICorner", {
			CornerRadius = UDim.new(0.1, 0),
		}),
		ui.CreateObject(Scope, "UIStroke", {
			Color = Color3.fromRGB(56, 56, 56),
			Thickness = 4,
			Transparency = 0.6,
		}),
	}

	local FinalizedProperties = ui.Merge(DefaultProps, Properties)
	local FinalizedChildren = ui.Merge(DefaultChildren, Children)

	return ui.CreateObject(Scope, "TextLabel", FinalizedProperties, FinalizedChildren, Events)
end

function defaultcomponents.Button(
	Scope: Fusion.Scope<typeof(Fusion)>,
	Properties: Dictionary<any>?,
	Children: Array<any>?
)
	local DefaultProps = {
		BackgroundColor3 = Color3.fromRGB(44, 44, 44),
		BackgroundTransparency = 0.5,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromScale(1.2, 1.2),
		Position = UDim2.fromScale(0.5, 0.5),
	}

	local ScaleValue, DampValue, SpeedValue = Scope:Value(1), Scope:Value(0.2), Scope:Value(20)
	local SpringAnimation = Scope:Spring(ScaleValue, SpeedValue, DampValue)

	local TransparencyValue = Scope:Value(1)

	local Button = defaultcomponents.ImageButton(Scope, ui.Merge(DefaultProps, Properties), Children, {
		MouseEnter = function()
			DampValue:set(0.4)
			SpeedValue:set(20)
			ScaleValue:set(1.2)
			TransparencyValue:set(0)
		end,
		MouseLeave = function()
			DampValue:set(0.4)
			SpeedValue:set(20)
			ScaleValue:set(1)
			TransparencyValue:set(1)
		end,
		MouseButton1Down = function()
			DampValue:set(0.6)
			SpeedValue:set(30)
			ScaleValue:set(0.8)
		end,
		MouseButton1Click = function()
			DampValue:set(0.2)
			SpeedValue:set(30)
			ScaleValue:set(1.2)
		end,
	})

	Scope:Hydrate(Button.UIScale)({
		Scale = SpringAnimation,
	})

	Scope:Hydrate(Button.TextLabel.UIScale)({
		Scale = SpringAnimation,
	})

	return Button
end

function defaultcomponents.ButtonLayout(Scope: Fusion.Scope<typeof(Fusion)>) --, Parent: Instance)
	local Frame = defaultcomponents.Frame(Scope, {
		Size = UDim2.fromScale(0.035, 0.5),
		Position = UDim2.fromScale(0.02, 0.5),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
	}, {
        defaultcomponents.VerticalCenterStackLayout(Scope)
    })

	defaultcomponents.AspectRatio(Scope, Frame, 0.125)

	return Frame
end

function defaultcomponents.Bar(Scope: Fusion.Scope<typeof(Fusion)>, BarProgress: Fusion.Value<number>?): Instance
	local FrameHolder = defaultcomponents.Frame(Scope, {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
	})

	local VisualBar = defaultcomponents.Frame(Scope, {
		Parent = FrameHolder,
		Size = UDim2.fromScale(0.963, 0.662),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
	})

	local BarHolder = defaultcomponents.Frame(Scope, {
		Parent = VisualBar,
		Size = UDim2.fromScale(0.969, 0.6),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
	}, {}, {})

	local Bar = defaultcomponents.Frame(Scope, {
		Parent = BarHolder,
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0, 0.5),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.fromRGB(84, 129, 255),
	})

    local TargetSize

    if BarProgress then
        TargetSize = BarProgress
    else
        TargetSize = Scope:Value(1)
    end

	local SizeSpring = Scope:Spring(TargetSize, 10, 0.5)

	local VelocityCompute = Scope:Computed(function(use)
		use(SizeSpring)
		return (-0.1 * SizeSpring._activeLatestV[1]) + 1
	end)

	local SizeCompute = Scope:Computed(function(use)
		return UDim2.fromScale(use(SizeSpring), use(VelocityCompute))
	end)

	Scope:Hydrate(Bar)({
		Size = SizeCompute,
	})

	defaultcomponents.AspectRatio(Scope, VisualBar, 12.951)
	defaultcomponents.AspectRatio(Scope, FrameHolder, 8.905)
	defaultcomponents.AspectRatio(Scope, BarHolder, 20.917)
    
	return FrameHolder
end

function defaultcomponents.BarLayout(Scope: Fusion.Scope<typeof(Fusion)>): Instance
	local Frame = defaultcomponents.Frame(Scope, {
		Size = UDim2.fromScale(0.42, 0.084),
		Position = UDim2.fromScale(0, 1),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
	}, {
        defaultcomponents.VerticalBottomStackLayout,
	})

	defaultcomponents.AspectRatio(Scope, Frame, 8.905)

	return Frame
end


return defaultcomponents

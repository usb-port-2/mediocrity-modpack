import funkin.backend.system.framerate.Framerate;

var redirectStates:Map<FlxState, String> = [
    TitleState => "CustomMenu",
    MainMenuState => "CustomMenu",
    FreeplayState => "CustomFreeplay"
];

function new()
	Framerate.debugMode = 0;

function preStateSwitch()
	for (redirectState in redirectStates.keys()) 
		if (Std.isOfType(FlxG.game._requestedState, redirectState)) {
			FlxG.mouse.visible = redirectStates.get(redirectState) == "CustomMenu";
			FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
		}
import funkin.backend.utils.NativeAPI;
import lime.graphics.Image;
import funkin.backend.system.Main;
import funkin.backend.utils.ShaderResizeFix;

var redirectStates:Map<FlxState, String> = [
    TitleState => "CustomMenu",
    MainMenuState => "CustomMenu",
    FreeplayState => "CustomFreeplay"
];

function preStateSwitch() {
    for (redirectState in redirectStates.keys()) 
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}
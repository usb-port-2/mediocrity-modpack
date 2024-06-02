import funkin.backend.utils.NativeAPI;
import lime.graphics.Image;
import funkin.backend.system.Main;
import funkin.backend.utils.ShaderResizeFix;
import funkin.savedata.FunkinSave;
import funkin.backend.system.framerate.Framerate;

var idfk:Array<HighscoreChange> = [];

var redirectStates:Map<FlxState, String> = [
    TitleState => "CustomMenu",
    MainMenuState => "CustomMenu",
    FreeplayState => "CustomFreeplay"
];

function new()
	Framerate.debugMode = 0;

function preStateSwitch() {
	/*if(FunkinSave.getSongHighscore("Sloppy Toppy", "Hard", idfk).score == 0){
		PlayState.loadSong("Sloppy Toppy", "Hard");
		FlxG.switchState(new PlayState());
	} else {*/
		for (redirectState in redirectStates.keys()) 
			if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
	//}
}
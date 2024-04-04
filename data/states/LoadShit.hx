import funkin.options.Options;
import funkin.backend.MusicBeatState;

// Care here (the only coder on the mod :3), Grinch wanted loading screens but cne loads basically instantly so I just added this shitty thing that loads nothing but looks nice
// Yeah idk
// If you want to skip loading just remove "startDelay: FlxG.random.float(0.1, 1.0);"

// waste 1.5-2.5 seconds simulator 2024

var graphic = new FlxSprite().loadGraphic(Paths.image("menus/load/load_" + FlxG.random.int(1, 7))).screenCenter();
function create(){
	// MISC
	MusicBeatState.skipTransOut = true;
	FlxG.camera.fade(FlxColor.BLACK, 1, true);
	CoolUtil.playMenuSong();
	window.title = "MEDIOCRITY. | Loading...";
	if(Options.gameplayShaders)
		FlxG.camera.addShader(new CustomShader("monitor"));
        graphic.antialiasing = Options.antialiasing;
		add(graphic);
	var red = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
	red.alpha = 0; 
	insert(0, red); // i didn't want this to be visible, looked ass
	FlxTween.tween(red, {alpha: 1}, 1, {
		onComplete: function(a) FlxG.switchState(new PlayState()),
		startDelay: FlxG.random.float(1.5, 2.5)
	});
}
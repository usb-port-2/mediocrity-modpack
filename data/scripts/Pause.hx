import funkin.options.Options;
import funkin.options.OptionsMenu;

var stuff:Array<FlxSprite> = [];
var select:Int = 0;

menuItems = [""];

var songInfo = [
	"Blazed" => ["SONG: Mr. Maestro", "ART: Muleta (unfortunately)", "CODE: Care"],
	"Manipulation" => ["SONG: Jamal", "ART: Muleta & GrinchDaDude", "CODE: Care"],
	"Expectations" => ["I am sexually attracted to\nskibidi toilet in a weird way,\nI don't know why, I think that\nit is his face because oh my- his human form are whatever \"male_09\" or some form of him in a human body is so hot.","",""]
];
function postCreate() {
	camPause = new FlxCamera();
	camPause.bgColor = 0;
	FlxG.cameras.add(camPause, false);
	window.title = "MEDIOCRITY. | Paused: " + PlayState.SONG.meta.name;
	for(a in 0...4){
		var options = new FlxSprite().loadGraphic(Paths.image("menus/pause/" + (PlayState.SONG.meta.name == "Manipulation" && PlayState.instance.dad.color == 0xFF0000 ? "0" : a)));
		options.camera = camPause;
		options.screenCenter();
		options.setPosition(a == 0 || a == 2 ? 0 - options.width : FlxG.width, (FlxG.height/5 * (a+1)) - options.height/2);
		options.alpha = 0;
        options.antialiasing = Options.antialiasing;
		FlxTween.tween(options, {alpha: 1, x: FlxG.width/4 - options.width/2}, 0.5, {
			ease: FlxEase.quartInOut,
			startDelay: (a+1)/10
		});
		stuff.push(options);
		add(stuff[a]);
	}

	add(portrait = new FlxSprite().loadGraphic(Paths.image("menus/pause/New Folder/" + (PlayState.SONG.meta.name != "manipulation" ? PlayState.SONG.meta.name : "manipulation_" + (PlayState.instance.dad.color == 0xFF0000 ? "2" : "1")))));
	portrait.camera = camPause;
    portrait.antialiasing = Options.antialiasing;
	add(sidebar = new FlxSprite().loadGraphic(Paths.image("menus/pause/bar")));
	sidebar.x = FlxG.width - sidebar.width;
	sidebar.camera = camPause;
    sidebar.antialiasing = Options.antialiasing;
	for(num => a in songInfo[PlayState.SONG.meta.name]){
		add(info = new FlxText(sidebar.x + 150 - (num * 30), 500 + (55 * num), 0, a).setFormat(Paths.font(StringTools.startsWith(a, "I am") ? "papyrus.ttf" : "vcr.ttf"), 50, PlayState.instance.dad.color));
		//info.x = FlxG.width - sidebar.width;
		info.camera = camPause;
		info.antialiasing = Options.antialiasing;
	}
	add(songTitle = new FlxText(FlxG.width*2, 5, 0, PlayState.SONG.meta.name).setFormat(Paths.font("vcr.ttf"), 75, PlayState.instance.dad.color));
	songTitle.camera = camPause;
    songTitle.antialiasing = Options.antialiasing;
	FlxTween.tween(songTitle, {x: FlxG.width - songTitle.width - 10}, 0.5, {ease: FlxEase.quartInOut});

	grpMenuShit.clear();
    changeSelection(0);
}

function update(elapsed){
	if((controls.UP_P || controls.DOWN_P)) changeSelection(controls.UP_P ? -1 : 1);
	if(controls.ACCEPT){
		if(PlayState.SONG.meta.name == "Manipulation" && PlayState.instance.dad.color == 0xFF0000){
			window.title = "MEDIOCRITY. | Playing: " + PlayState.SONG.meta.name;
			close();
		} else {
			switch(select){
				case 0:
					window.title = "MEDIOCRITY. | Playing: " + PlayState.SONG.meta.name;
					close();
				case 1:
					parentDisabler.reset();
					PlayState.instance.registerSmoothTransition();
					FlxG.resetState();
				case 2:
					FlxG.switchState(new OptionsMenu());
				case 3:
					CoolUtil.playMenuSong();
					FlxG.switchState(new ModState("CustomFreeplay"));
			}
		}
	}
}

function changeSelection(a:Int){
	select = FlxMath.wrap(select + a, 0, stuff.length-1);
	for(num => a in stuff){
		FlxTween.num(a.scale.x, num == select ? 0.9 : 0.85, 0.1, {}, function(uh) a.scale.set(uh, uh));
	}
}
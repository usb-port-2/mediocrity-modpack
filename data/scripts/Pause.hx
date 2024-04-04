import funkin.options.Options;
import funkin.options.OptionsMenu;

var stuff:Array<FlxSprite> = [];
var select:Int = 0;

menuItems = [""];

function postCreate() {
	camPause = new FlxCamera();
	camPause.bgColor = 0;
	FlxG.cameras.add(camPause, false);
	window.title = "MEDIOCRITY. | Paused: " + PlayState.SONG.meta.name;
	add(sidebar = new FlxSprite().loadGraphic(Paths.image("menus/freeplay/sidebar")));
	sidebar.flipX = true;
	sidebar.x = FlxG.width - sidebar.width;
	sidebar.camera = camPause;
    sidebar.antialiasing = Options.antialiasing;
	for(a in 0...4){
		var options = new FlxSprite().loadGraphic(Paths.image("menus/pause/" + (PlayState.SONG.meta.name == "Manipulation" && PlayState.instance.dad.color == 0xFF0000 ? "0" : a)));
		options.camera = camPause;
		options.screenCenter();
		options.setPosition(a == 0 || a == 2 ? 0 - options.width : FlxG.width, (FlxG.height/5 * (a+1)) - options.height/2);
		options.alpha = 0;
        options.antialiasing = Options.antialiasing;
		FlxTween.tween(options, {alpha: 1, x: FlxG.width/4 * 2}, 0.5, {
			ease: FlxEase.quartInOut,
			startDelay: (a+1)/10
		});
		stuff.push(options);
		add(stuff[a]);
	}
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
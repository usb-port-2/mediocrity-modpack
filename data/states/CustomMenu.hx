import funkin.options.OptionsMenu;
import funkin.options.Options;
import funkin.menus.ModSwitchMenu;

	var buttons:Array<FlxSprite> = [];

	function create(){
		CoolUtil.playMenuSong();
		window.title = "MEDIOCRITY.";
		for(a in [
			new FlxSprite().loadGraphic(Paths.image("menus/BG")).screenCenter(),
			logo = new FlxSprite(211, -61.5).loadGraphic(Paths.image("menus/main/logo")),
			banner = new FlxSprite(27, 327).loadGraphic(Paths.image("menus/main/banner"))
		]){
			a.antialiasing = Options.antialiasing;
			add(a);
		}
		for(num => b in ["play", "freeplay", "credits", "options"]){
			var button = new FlxSprite(banner.x + [100, 400, 700, 1000][num], banner.y + [225, 240, 240, 185][num]);
			button.frames = Paths.getSparrowAtlas("menus/main/" + b);
			button.scale.set([0.55, 0.5, 0.4, 0.5][num], [0.55, 0.5, 0.4, 0.5][num]);
			for(c in ["unselected", "transition"])
				button.animation.addByPrefix(c, c, 24, false);
			button.animation.play('unselected');
			button.updateHitbox();
			button.antialiasing = Options.antialiasing;
			if(b == "play") button.alpha = 0.7;
			buttons.push(button);
			add(buttons[buttons.length-1]);
		}
		add(lock = new FlxSprite(banner.x + 140, banner.y + 230).loadGraphic(Paths.image("menus/main/lock")));
		if(Options.gameplayShaders)
			FlxG.camera.addShader(new CustomShader("monitor"));
	}

	function update(elapsed){
			if (controls.SWITCHMOD) {
				openSubState(new ModSwitchMenu());
				persistentUpdate = true;
				persistentDraw = true;
			}
		if(FlxG.mouse.justPressed)
			for(a in buttons)
				if(a.animation.curAnim.name == "transition")
					switch(buttons.indexOf(a)){
						case 0: trace("nuh uh");
						case 1: FlxG.switchState(new ModState("CustomFreeplay"));
						case 2: FlxG.switchState(new ModState("CustomCredits"));
						case 3: FlxG.switchState(new OptionsMenu());
					}
		for(a in buttons){
			if(FlxG.mouse.overlaps(a) && a.animation.curAnim.name != "transition")
				a.animation.play('transition');
			if(!FlxG.mouse.overlaps(a) && a.animation.curAnim.name != "unselected")
				a.animation.play('unselected');
		}
	}

	function beatHit(curBeat:Int){
		FlxTween.num(1.05, 1, 0.35, {}, function(a) logo.scale.set(a, a));
	}
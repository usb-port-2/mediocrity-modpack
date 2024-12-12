import funkin.options.OptionsMenu;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;

var buttons:Array<FunkinSprite> = [];

function create(){
	CoolUtil.playMenuSong();
	window.title = "MEDIOCRITY.";
	for(a in [
		new FlxSprite().loadGraphic(Paths.image("menus/BG")).screenCenter(),
		logo = new FlxSprite(0, 720/11).loadGraphic(Paths.image("menus/main/logo")),
		banner = new FlxSprite(27, 327).loadGraphic(Paths.image("menus/main/banner"))
	]) add(a).antialiasing = Options.antialiasing;
	logo.screenCenter(FlxAxes.X);

	for(b in 0...4){
		buttons.push(new FunkinSprite(banner.x + [100, 400, 700, 1000][b], banner.y + [225, 240, 240, 185][b]));
		buttons[b].frames = Paths.getSparrowAtlas("menus/main/" + ["play", "freeplay", "credits", "options"][b]);
		for(c in ["unselected", "transition"]) buttons[b].animation.addByPrefix(c, c, 24, false);
		buttons[b].animation.play('unselected');
		buttons[b].updateHitbox();
		buttons[b].alpha = b == 0 ? 0.7 : 1;
		add(buttons[b]).antialiasing = Options.antialiasing;
	}

	add(new FlxSprite(banner.x + 140, banner.y + 230).loadGraphic(Paths.image("menus/main/lock")));
	if(Options.gameplayShaders)
		FlxG.camera.addShader(new CustomShader("monitor"));
}

function update(elapsed){
	logo.scale.x = logo.scale.y = lerp(logo.scale.x, 1, 0.0825);

	if (controls.SWITCHMOD || FlxG.keys.justPressed.SEVEN) {
		openSubState(controls.SWITCHMOD ? new ModSwitchMenu() : new EditorPicker());
		persistentUpdate = !(persistentDraw = true);
	}
	for (a in 0...buttons.length) {
		if (buttons[a].animation.curAnim.name == "transition" && FlxG.mouse.justPressed)
			switch (a) {
				case 0:
					PlayState.loadSong("expectations", "skibidirizz");
					FlxG.switchState(new PlayState());
				case 1: FlxG.switchState(new ModState("CustomFreeplay"));
				case 2: FlxG.switchState(new ModState("CustomCredits"));
				case 3: FlxG.switchState(new OptionsMenu());
			}
		if(FlxG.mouse.overlaps(buttons[a]) && buttons[a].animation.curAnim.name != "transition")
			buttons[a].animation.play('transition');
		if(!FlxG.mouse.overlaps(buttons[a]) && buttons[a].animation.curAnim.name != "unselected")
			buttons[a].animation.play('unselected');
	}
}

function beatHit() logo.scale.x = logo.scale.y = 1.05;
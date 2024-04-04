import funkin.options.Options;

var texts:Array<FlxText> = [];
var icons:Array<FlxSprite> = [];
var curSelect:Int = 0;

function create(){
	// MISC
	CoolUtil.playMenuSong();
	window.title = "MEDIOCRITY.";
	if(Options.gameplayShaders)
		FlxG.camera.addShader(new CustomShader("monitor"));
    for(num => a in [
		new FlxSprite().loadGraphic(Paths.image("menus/BG")).screenCenter(),
        new FlxSprite().loadGraphic(Paths.image("menus/freeplay/sidebar")),
        new FlxSprite().loadGraphic(Paths.image("menus/freeplay/sidebar"))
	]){
        a.antialiasing = Options.antialiasing;
		if(num == 2){
		a.flipX = a.flipY = true;
		a.x = FlxG.width - a.width;
		}
		add(a);
    }
	// Pisscum
	for(num => b in CoolUtil.coolTextFile(Paths.txt('credits'))){
        var text = new FlxText(100, 150 * num + 15, 0, b.split(":")[0] + "\n" + b.split(":")[1]).setFormat(Paths.font("VCR.ttf"), 50, FlxColor.WHITE).screenCenter(FlxAxes.X);
        text.antialiasing = Options.antialiasing;
		text.alignment = "center";
	text.color = FlxColor.WHITE;
        texts.push(text);
        add(texts[texts.length - 1]);
    }
	for(num => b in CoolUtil.coolTextFile(Paths.txt('credits'))){
        var icon = new FlxSprite().loadGraphic(Paths.image("menus/credits/" + b.split(":")[0]));
        icons.push(icon);
        add(icons[icons.length - 1]);
    }
	changeSelect(0);
}

function update(elapsed){
    if(controls.BACK) FlxG.switchState(new ModState("CustomMenu"));
	if(controls.UP_P || controls.DOWN_P) changeSelect(controls.UP_P ? -1 : 1);
}

function changeSelect(a:Int){
	curSelect = FlxMath.wrap(curSelect + a, 0, texts.length-1);
	for(num => a in texts){
		FlxTween.color(a, 0.25, FlxColor.WHITE, num == curSelect ? FlxColor.RED : FlxColor.WHITE, {ease: FlxEase.quadInOut});
		FlxTween.tween(a, {y: FlxG.height / 5 * (num - curSelect + 2), x: (FlxG.width / 11 * (num - curSelect + 5)) - a.width/4}, 0.25, {ease: FlxEase.quadInOut});
		FlxTween.tween(icons[num], {y: FlxG.height / 5 * (num - curSelect + 2), x: (FlxG.width / 11 * (num - curSelect + (num == 0 || num == 1|| num == 5 || num == 10 || num == 13 ? 6 + (num == 10 || num == 13 || num == 1 ? 0 : 0.5) : 5))) - a.width - icons[num].width/2}, 0.25, {ease: FlxEase.quadInOut});
	}
}
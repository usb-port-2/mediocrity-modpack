var shader = new CustomShader("TVStatic");
var frame = new FlxSprite().loadGraphic(Paths.image("stages/TV/frame")).screenCenter();
var red:Bool;
var bopThisShit:Bool = false;
var uiText:Array<FlxText> = [];
var healthText:FlxText;

function create(){
	camGame.fade(FlxColor.BLACK, 0.0000001);
	allowGitaroo = red = false;
	bg.alpha = dad.alpha = 1;
    frame.camera = camHUD;
	insert(0, frame);
	if(Options.gameplayShaders){
		shader.data.strengthMulti.value = [0.5, 0.5];
		shader.data.imtoolazytonamethis.value = [0.3, 0.3];
		for(a in [shader, new CustomShader("monitor")])
			camGame.addShader(a);
	}
}

function postCreate(){
    iconP1.visible = iconP2.visible = healthBar.visible = healthBarBG.visible = scoreTxt.visible = missesTxt.visible = accuracyTxt.visible = false;
	for(a in strumLines.members[1]) a.x += 80;
    for(a in strumLines.members[0])
		a.visible = false;

	var gradient = new FlxSprite().loadGraphic(Paths.image("stages/TV/gradient")).screenCenter();
    gradient.camera = camHUD;
	gradient.alpha = 0.5;
    add(gradient);
	camGame.zoom = defaultCamZoom = 0.6;
	for(z in [
		new FlxText(bg.x - 120, bg.y - 140, 0, "SCORE:\nTIME:\nMISSES:").setFormat(Paths.font("sonic2hud.ttf"), 50, FlxColor.YELLOW),
		new FlxText(bg.x - 120, bg.y + 730, 0, "HEALTH:").setFormat(Paths.font("sonic2hud.ttf"), 50, FlxColor.YELLOW),
		healthText = new FlxText(bg.x + ("HEALTH:".length * 12.5), bg.y + 730, 0).setFormat(Paths.font("sonic2hud.ttf"), 50, FlxColor.WHITE)
	]){
		z.scrollFactor.set(0, 0);
		add(z);
	}
	for(num => a in ["SCORE", "TIME", "MISSES"]){
		uiText.push(new FlxText(bg.x - 120 + ((a + ": ").length * 25), bg.y + (num*57.5) - 140, 0, a == "TIME" ? "0:00" : "0").setFormat(Paths.font("sonic2hud.ttf"), 50, FlxColor.WHITE));
		uiText[num].scrollFactor.set(0, 0);
		add(uiText[num]);
	}
}

function stepHit(curStep) if(curStep == 1418) bopThisShit = true;
function beatHit(curBeat:Int){
	if(bopThisShit){
		camGame.angle = (curBeat % 2 == 0 ? -5 : 5);
		FlxTween.cancelTweensOf(camGame);
		FlxTween.tween(camGame, {angle: 0}, 0.5, {ease: FlxEase.quadInOut});
	}
	switch(curBeat){
		case 0:
			camGame.fade(FlxColor.BLACK, 1, true);
			FlxTween.num(0, 0.25, 20, {}, function(twn) bg.alpha = twn);
			FlxTween.num(0, 1, 20.5, {}, function(twn) dad.alpha = twn);
			FlxTween.num(0.1, 0.6, 20, {onComplete: function(idk){
				camGame.flash(FlxColor.WHITE, 1);
				dad.idleSuffix = "-alt";
				bg.alpha = 1;
			}});
		case 241:
			camGame.fade(FlxColor.RED, 1);
			frame.loadGraphic(Paths.image("stages/TV/frame-red"));
		case 243: // beeping
		case 250:
			camGame.fade(FlxColor.BLACK, 0.0000001);
			frame.loadGraphic(Paths.image("stages/TV/frame"));
			FlxTween.num(1, 0, 5, {}, function(twn){
				for(a in strumLines.members[1]) a.alpha = twn;
			});
		case 252:
			dad.idleSuffix = "-happy";
		case 299: // phase 2
			camGame.fade(FlxColor.BLACK, 1, true);
			frame.loadGraphic(Paths.image("stages/TV/frame-red-but-darker-too"));
			for(a in strumLines.members[1]) a.alpha = 1;
			overlay.alpha = 0.75;
		case 300:
			camGame.flash(FlxColor.RED, 0.5);
		case 402:
			bopThisShit = false;
			camGame.flash(FlxColor.WHITE, 0.5);
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {angle: 360}, 0.75, {
				ease: FlxEase.quadInOut,
				onComplete: function(twn) bopThisShit = true
				});
		case 419: bopThisShit = false;
		case 478:
			camGame.flash(FlxColor.RED, 0.5);
			camHUD.flash(FlxColor.WHITE, 0.5);
			dad.color = bg.color = overlay.color = 0xFF0000;
			red = true;
		case 546:
			camGame.flash(FlxColor.RED, 0.5);
			frame.loadGraphic(Paths.image("stages/TV/frame-red"));
			defaultCamZoom = 1;
			FlxTween.tween(camHUD, {zoom: 3, alpha: 0}, 1.0);
		case 548:
			canPause = false;
			camGame.fade(FlxColor.BLACK, 10);
			FlxTween.num(1, 0.3, 10, {}, function(a) camGame.zoom = defaultCamZoom = a);
	}
}

	function update(elapsed){
		healthText.text = Std.string(Std.int(health * 50));
		uiText[1].text = Std.int(Std.int((inst.length - Conductor.songPosition) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((inst.length - Conductor.songPosition) / 1000) % 60), 2); // what
		if(Options.gameplayShaders) shader.data.iTime.value = [Conductor.songPosition / 100];
	}
	function postUpdate() {
		for(a in 0...2){
			switch(strumLines.members[a].characters[0].getAnimName()) {
				case "singLEFT": camFollow.x -= 30;
				case "singDOWN": camFollow.y += 30;
				case "singUP": camFollow.y -= 30;
				case "singRIGHT": camFollow.x += 30;
			}
		}
		if(!red && !bopThisShit){
			if(strumLines.members[curCameraTarget].characters[0].getAnimName() == "idle" || strumLines.members[curCameraTarget].characters[0].getAnimName() == "idle-alt")
				defaultCamZoom = 0.575;
			else 
				defaultCamZoom = 0.625;
		}
	}

function onPlayerHit() uiText[0].text = Std.string(songScore);
function onPlayerMiss() uiText[2].text = Std.string(misses);
function onDadHit(e){
	var drain = FlxG.random.float(0.02, 0.04);
	if(health > drain) health -= (red ? FlxG.random.float(0.02, 0.04) : 0.01);
	if(red) camGame.zoom += 0.025;
	FlxTween.cancelTweensOf(healthText);
	FlxTween.color(healthText, 0.5, FlxColor.RED, FlxColor.WHITE, {ease: FlxEase.quadInOut});
}

function onGameOver(e){
	camGame.fade(FlxColor.RED, 1, true);
	e.deathCharID = "death-manipulation";
}
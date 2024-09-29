import Sys;
import flixel.FlxG;
import flixel.util.FlxGradient;
import sys.net.Host;

var invert = new CustomShader("invert");
var angle:Float = 0.0;
var grey = new CustomShader("greyscale");
var kiddo = new FlxSprite(425).loadGraphic(Paths.image("kiddo"));

var brainrot = [
	"what if nmi was\nFREAKY\nand gave sloppy toppy",
	"what if nmi was\nSLOPPY\nand gave freaky toppy",
	"play skibidi of ohios\n    (myths of yamaha",
	"i fw you heavy vro",
	"i fw you vro",
	"NYEH HEH HEH\nI THE GREA",
	"THE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES\nTHE VOICES"
	"sex",
	"Foolish skibidi... don't you mew?\nI am the sigma ohio rizzler",
	"garden of banban " + FlxG.random.int(1, 99) + " is peak",
	"femboy nmi.\nthat is all.",
	"fnf mediocrity frfr",
	"dm femboy pics to @usb_port_2\n    to get some back",
	"bitch",
	"Sonic.SKIBIDI: I am GYATT!\nI’m gonna edge ya!",
	":3",
	"nice pc name, " + Host.localhost().toUpperCase() + "!",
	"nice username, " + Sys.environment()["USERNAME"].toUpperCase() + "!",
	"nice ip address, "
	+ FlxG.random.int(0, 256)
	+ "."
	+ FlxG.random.int(0, 256)
	+ "."
	+ FlxG.random.int(0, 256)
	+ "."
	+ FlxG.random.int(0, 256)
	+ "!*
    \n\n\n\n\n\n\n\n\n\n\n\n\n                                                                                                  * for legal reasons this is a fake ip",
	"Oouughh… I’m leaking…~",
	":jorking_it:",
	"fnf is so cool\n   i wish autism existed irl",
	"FAGGOT",
	"TRANSGENDER RIGHTS",
	"FUCK TERFS",
	"nmi is trans - AND PROUD",
	"nmi is bi - AND PROUD",
	"nmi is trans and bi",
	"Peanut Butter & Cheese"
];

function postCreate() {
	PauseSubState.script = '';

	defaultCamZoom = defaultZoom = 0.9;
	insert(members.indexOf(dad), back = new FlxSprite().makeGraphic(1024 * 2.5, 768 * 2.5).screenCenter());
	kiddo.frames = Paths.getSparrowAtlas("kiddo");
    kiddo.animation.addByPrefix('idle', 'nene', 24, true);
    kiddo.animation.play('idle');
    kiddo.scale.set(0.5, 0.5);
    insert(members.indexOf(dad), kiddo);
	add(gradient = FlxGradient.createGradientFlxSprite(1024 * 2.5, 768 * 2.5, [FlxColor.TRANSPARENT, FlxColor.TRANSPARENT, FlxColor.BLACK]).screenCenter());
	insert(0, text = new FunkinText(5, 5, 0, brainrot[FlxG.random.int(0, brainrot.length - 1)], 30, true));
	for (a in [back, gradient])
		a.scrollFactor.set(0, 0);
	text.camera = camHUD;
	for (a in [scoreTxt, missesTxt, accuracyTxt, text])
		a.font = Paths.font("papyrus.ttf");

	camZoomingStrength = camHUD.alpha = 0;

	healthBar.shader = grey;
}

function onNoteCreation(e)
	e.note.shader = grey;
function onStrumCreation(e)
	e.strum.shader = grey;

function update(elapsed){
	camGame.angle = FlxMath.lerp(camGame.angle, angle, 0.04);
	if(FlxG.keys.justPressed.NINE)
		changeIcon();
}

function postUpdate(elapsed){
	angle = ["singLEFT", "singRIGHT"].contains(strumLines.members[curCameraTarget].characters[0].getAnimName()) ? strumLines.members[curCameraTarget].characters[0].getAnimName() == "singLEFT" ? -1 : 1 : 0;
	camFollow.y += ["singDOWN", "singUP"].contains(strumLines.members[curCameraTarget].characters[0].getAnimName()) ? strumLines.members[curCameraTarget].characters[0].getAnimName() == "singDOWN" ? 30 : -30 : 0;
}

function onNoteHit(e){
	if([0, 3].contains(e.direction))
		camGame.angle = e.direction == 0 ? -0.15 : 0.15;
}


function stepHit(curStep:Int) {
	switch (curStep) {
		case 0:
			text.setPosition(10, 10);
		case 124 | 126:
			camGame.zoom = defaultCamZoom += 0.1;
			camGame.angle = curStep == 124 ? -10 : 5;
		case 128:
			camGame.angle = 0;
			camZoomingStrength = camZoomingInterval = 1;
			defaultCamZoom -= 0.2;
			camGame.flash(FlxColor.WHITE, 0.5);
			FlxTween.tween(camHUD, {alpha: 1}, 0.5);
		case 152 | 156 | 168 | 172 | 192 | 248 | 252 | 256 | 264 | 268 | 280 | 284 | 296 | 304 | 316 | 328 | 332 | 368 | 384 | 392 | 400 | 422 | 448 | 454 |
			462 | 528 | 542 | 608 | 612:
			defaultCamZoom -= 0.1;
		case 204 | 220 | 236 | 320 | 344 | 348 | 360 | 408 | 411 | 414 | 416 | 432 | 512 | 522 | 538 | 544 | 560 | 576 | 636:
			defaultCamZoom += 0.1;
		case 162 | 178 | 226 | 256 | 274 | 290 | 300 | 308 | 338 | 354 | 364 | 372 | 388 | 396 | 404 | 436 | 466 | 548 | 564 | 579 | 615:
			defaultCamZoom = defaultZoom;
		case 1152:
			for (a in [camHUD, back, gradient])
				FlxTween.tween(a, {alpha: 0}, 2);
		case 1216:
			for (a in [gradient, text, scoreTxt, missesTxt, accuracyTxt, healthBarBG])
				a.shader = invert;
			FlxTween.num(0, 1, 2.5, {}, function(num) invert.invert = num);
		case 1282:
			for (a in [camHUD, gradient])
				FlxTween.tween(a, {alpha: 1}, 2);
	}
}

function beatHit(curBeat:Int){
	for(a in [iconP2, iconP1]){
		a.angle = curBeat % 2 == 0 ? 10 : -10;
		FlxTween.cancelTweensOf(a);
		FlxTween.tween(a, {angle: 0}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.circOut});
	}
}

function onNoteHit(e){
	e.showSplash = false;
    //FlxTween.num(0.5, 0, 0.5, {}, function(num) glowShader.distortion = num);

}

function onGameOver(e){
	e.cancel();
    FlxG.switchState(new PlayState());
}

function onSubstateOpen() window.title = "MEDIOCRITY. | Paused: " + SONG.meta.name;
function onSubstateClose() window.title = "MEDIOCRITY. | Playing: " + SONG.meta.name + "??";
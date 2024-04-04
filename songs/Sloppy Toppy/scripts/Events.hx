import funkin.backend.MusicBeatState;

var gayText = new FlxText(0, 0, 0, "").setFormat(Paths.font("vcr.ttf"), 50, FlxColor.BLACK);
var back = new FlxSprite(-250, -250).makeGraphic(2000, 1000);

function postCreate(){
    window.title = "MEDIOCRITY. | Playing: " + SONG.meta.name + "??";
	MusicBeatState.skipTransIn = true;
	MusicBeatState.skipTransOut = true;
    insert(0, back);
    gayText.camera = camHUD;
    add(gayText);
    for(b in strumLines)
        for(c in b){
            c.alpha = 1;
	    c.shader = new CustomShader("greyscale");
	}
	healthBar.shader = new CustomShader("greyscale");
}
function beatHit(curBeat:Int){
    switch(curBeat){
        case 289:
            for(a in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt])
                FlxTween.tween(a, {alpha: 0}, 1);
            for(b in strumLines)
                for(c in b)
                    FlxTween.tween(c, {alpha: 0}, 1);
        case 292:
            for(b in strumLines)
                for(c in b)
                    c.x += 2000;
        case 296: updateText("Heh...");
        case 297: updateText("That was pretty");
        case 299: updateText("MEDIOCRE,");
        case 301: updateText("wasn't it?");
        case 302: updateText("...");
        case 305: updateText("Well,");
        case 307:
            updateText("Well, let's");
            FlxTween.color(back, 1, FlxColor.WHITE, FlxColor.BLACK);
            FlxTween.color(gayText, 1, FlxColor.BLACK, FlxColor.WHITE);
            FlxTween.tween(dad, {alpha: 0}, 1, {startDelay: 0.3});
            FlxTween.tween(boyfriend, {alpha: 0}, 1, {startDelay: 0.3});
        case 308: updateText("Well, let's change that...");
        case 309: updateText("Shall");
        case 310: updateText("Shall we?");
        case 311: FlxTween.tween(gayText, {alpha: 0}, 1);
    }
}

function updateText(shiz:String){
    gayText.text = shiz;
    gayText.screenCenter(FlxAxes.X);
    gayText.y = FlxG.height - 100;
}

function onNoteCreation(e){
	e.note.shader = new CustomShader("greyscale");
}

function onGameOver(e){
	e.cancel();
    FlxG.switchState(new PlayState());
}

function onSubstateOpen() window.title = "MEDIOCRITY. | Paused: " + SONG.meta.name;
function onSubstateClose() window.title = "MEDIOCRITY. | Playing: " + SONG.meta.name + "??";
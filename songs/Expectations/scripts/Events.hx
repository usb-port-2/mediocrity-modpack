var shader = new CustomShader("greyscale");
var fish = new CustomShader("fisheye");
var invert = new CustomShader("invert");

var bop:Bool = false;

function postCreate() {
    for(a in [shader])
        FlxG.game.addShader(a);
    defaultCamZoom = 1;
    invert.invert = 1;
}

function destroy() {
    for(a in [shader, invert])
        FlxG.game.removeShader(a); 
}

function update() {
    //shader.iTime = Conductor.songPosition;
}

function onDadHit(e) {
    if(e.character == strumLines.members[0].characters[0]) {
        if(health - 0.023 > 0)
            health -= 0.023;
    } else {
        health += 0.023;
    }
}

function stepHit(curStep:Int) {
    switch(curStep) {
        case 0:
            FlxTween.num(defaultCamZoom, 1.1, (Conductor.stepCrochet / 1000) * 274, {}, function(a) defaultCamZoom = camGame.zoom = a);
        case 274:
            camHUD.flash(FlxColor.WHITE, (Conductor.stepCrochet / 1000) * 16);
            FlxG.game.removeShader(shader);
            camGame.addShader(fish);
            fish.MAX_POWER = 0.15;
            defaultCamZoom = 1;
            bop = true;
        case 840:
            FlxTween.num(defaultCamZoom, defaultCamZoom + 0.5, (Conductor.stepCrochet / 1000) * 8, {}, function(a) defaultCamZoom = camGame.zoom = a);
            camHUD.fade(FlxColor.BLACK, (Conductor.stepCrochet / 1000) * 4);
        case 850:
            camHUD.fade(FlxColor.WHITE, 0);
            FlxG.game.addShader(invert);
        case 900:
            FlxTween.num(defaultCamZoom, defaultCamZoom - 0.5, (Conductor.stepCrochet / 1000) * 30, {}, function(a) defaultCamZoom = camGame.zoom = a);
            camHUD.fade(FlxColor.WHITE, (Conductor.stepCrochet / 1000) * 15, true);

    }
}

function beatHit(curBeat:Int) {
    if(bop){
        for(a in [iconP1, iconP2]){
			a.angle = curBeat % 2 == 0 ? 25 : -25;
			FlxTween.cancelTweensOf(a);
			FlxTween.tween(a, {angle: 0}, 0.5, {ease: FlxEase.circOut});
        }
        for(b in strumLines)
            for(c in b){
                c.angle = curBeat % 2 == 0 ? (c.strumID % 2 == 0 ? 5 : -5) : (c.strumID % 2 == 0 ? -5 : 5);
                FlxTween.cancelTweensOf(c);
                FlxTween.tween(c, {angle: 0}, 0.5, {ease: FlxEase.circOut});
            }
    }

}
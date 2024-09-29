if(SONG.meta.name != "Sloppy Toppy" && SONG.meta.name != "Sloppier Toppy"){
    PauseSubState.script = 'data/scripts/pause';

    var drunk = new CustomShader('drunk');
    var countdown = new FlxSprite();
    var countMap = [
        -4 => "3",
        -3 => "2",
        -2 => "1",
        -1 => "go"
    ];

    function postCreate(){
        for(a in strumLines) for(b in a) b.alpha = 0;
        window.title = "MEDIOCRITY. | Playing: " + SONG.meta.name;
        countdown.camera = camHUD;
        countdown.alpha = 0;
        add(countdown);
        if(Options.gameplayShaders && SONG.meta.name == "Blazed"){
            camGame.addShader(new CustomShader("blur"));
            camGame.addShader(drunk);
            camHUD.addShader(drunk);
        drunk.strength = 0.5;
        drunk.time = 0.0;
        }
    }

    if(Options.gameplayShaders && SONG.meta.name == "Blazed"){
        function update(){
            drunk.time = ((Conductor.songPosition / 1000) * (Conductor.bpm / 60) + ((Conductor.stepCrochet / 1000) * 16)); // stolen from gorefield, sorry!
        }
    }
	function onNoteCreation(e) {e.noteSprite = 'game/notes/custom';}
	function onStrumCreation(e) {e.sprite = 'game/notes/custom';}
    function onCountdown(event) event.cancel();
    function beatHit(curBeat:Int){
        if(curBeat < 0){
            countdown.loadGraphic(Paths.image("game/countdown/" + countMap[curBeat]));
            countdown.screenCenter();
            FlxG.sound.play(Paths.sound("countdown/" + countMap[curBeat]), 0.7);
            FlxTween.cancelTweensOf(countdown);
            countdown.alpha = 1;
            FlxTween.tween(countdown, {alpha: 0}, 0.75, {ease: FlxEase.quadInOut});
        }
        if(curBeat == 1){
        for(a in strumLines) {
            var counter:Int = 0;
            for(b in a) {
                FlxTween.tween(b, {alpha: 1}, 1.0, {startDelay: counter/5});
                counter++;
            }
        }
            countdown.destroy();
            remove(countdown);
        }
    }
    function onGameOver(e){
        if(SONG.meta.name == "Blazed") FlxG.camera.fade(FlxColor.BLACK, 1, true);
        e.lossSFX = "womp womp";
        e.retrySFX = "";
    }
}
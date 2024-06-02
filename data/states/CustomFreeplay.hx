import funkin.options.Options;

    var texts:Array<FlxSprite> = [];
    var curSelect:Int = 0;

    function create(){
        window.title = "MEDIOCRITY.";
        CoolUtil.playMenuSong();
        for(a in [
            new FlxSprite().loadGraphic(Paths.image("menus/BG")).screenCenter(),
            new FlxSprite().loadGraphic(Paths.image("menus/freeplay/sidebar"))
            box = new FlxSprite(700)
        ]){
            a.antialiasing = Options.antialiasing;
            add(a);
        }
        for(b in CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'))){
            var text = new FlxSprite().loadGraphic(Paths.image("menus/freeplay/" + b));
            text.antialiasing = Options.antialiasing;
            texts.push(text);
            add(texts[texts.length - 1]);
        }
        if(Options.gameplayShaders)
            FlxG.camera.addShader(new CustomShader("monitor"));
        changeSelection(0);
    }

    function update(elapsed){
        if(controls.BACK) FlxG.switchState(new ModState("CustomMenu"));
        if(controls.UP_P || controls.DOWN_P) changeSelection(controls.UP_P ? -1 : 1);
        if(controls.ACCEPT){
            PlayState.loadSong(CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'))[curSelect], "Hard");
        FlxG.switchState(new ModState("LoadShit"));
            //FlxG.switchState(new PlayState());
        }
    }

    function beatHit(curBeat:Int){
        FlxTween.num(1.05, 1, 0.35, {}, function(a) box.scale.set(a, a));
    }

    function changeSelection(a:Int){
        curSelect = FlxMath.wrap(curSelect + a, 0, texts.length - 1);
        box.loadGraphic(Paths.image("menus/freeplay/portraits/" + CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'))[curSelect])).screenCenter(FlxAxes.Y);
        for(num => a in texts){
            FlxTween.tween(a, {x: curSelect == num ? 30 : 15, y: FlxG.height/5 * (num - curSelect + 2)}, 0.25, {ease: FlxEase.quadInOut});
            FlxTween.num(a.scale.x, curSelect == num ? 1 : 0.8, 0.25, {ease: FlxEase.quadInOut}, function(ass) a.scale.set(ass, ass));
        }
    }
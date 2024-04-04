window.title = "MEDIOCRITY.";
if(Options.gameplayShaders)
    FlxG.camera.addShader(new CustomShader("monitor"));
FlxG.camera.addShader(new CustomShader("greyscale"));
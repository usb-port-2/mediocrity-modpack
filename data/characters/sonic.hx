function onGetCamPos(e) {
    e.x = PlayState.instance.strumLines.members[0].characters[0].getMidpoint().x;
    e.y = PlayState.instance.strumLines.members[0].characters[0].getMidpoint().y/1.25;
}
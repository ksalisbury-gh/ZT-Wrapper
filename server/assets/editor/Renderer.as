class Renderer
{
    var movieclips, readOnly, __get__preview_mc, currentPreview, __get__fg_mc, __get__bg_mc, scaler, text, id, scene, __get__root_mc;
    static var timeline, api;
    function Renderer(clips, readOnly)
    {
        movieclips = clips;
        this.readOnly = readOnly;
    } // End of the function
    function get preview_mc()
    {
        return (movieclips.preview_mc);
    } // End of the function
    function get root_mc()
    {
        return (movieclips.root_mc);
    } // End of the function
    function get bg_mc()
    {
        return (movieclips.bg_mc);
    } // End of the function
    function get fg_mc()
    {
        return (movieclips.fg_mc);
    } // End of the function
    function render()
    {
        var scene = Renderer.timeline.getCurrentScene();
        var _loc8 = Renderer.timeline.getSceneFrame(scene);
        var _loc4 = this.__get__preview_mc()[scene.clip + "_mc"];
        if (!scene)
        {
            this.clearPreview(currentPreview);
            this.clearBackground();
            return;
        } // end if
        if (!_loc4 || _loc4.getBytesLoaded() / _loc4.getBytesTotal() != 1)
        {
            this.clearPreview(currentPreview);
            this.clearBackground();
            this.showLoadingIcon();
            return;
        } // end if
        this.hideLoadingIcon();
        if (this.getCurrentPreview() != _loc4)
        {
            this.clearPreview(currentPreview);
            this.setCurrentPreview(_loc4);
            this.clearBackground();
        } // end if
        if (scene.actor == "starter")
        {
            return (this.renderStarter(scene, _loc8, _loc4));
        } // end if
        if (!Renderer.api.getActors(scene.clip).length)
        {
            return (this.renderTextcard(scene, _loc8, _loc4));
        } // end if
        if (!_loc4.fg_mc)
        {
            _loc4.attachMovie("foreground", "fg_mc", 6);
        } // end if
        this.setFrame(_loc4.fg_mc, _loc8);
        _loc4.fg_mc._visible = false;
        var _loc11 = this.getFirstInstance(_loc4.fg_mc);
        if (_loc11)
        {
            if (this.__get__fg_mc().mc.id != scene.location)
            {
                this.__get__fg_mc().attachMovie(scene.location + "_fg", "mc", 1);
                this.__get__fg_mc().mc.id = scene.location;
            } // end if
            this.__get__fg_mc().mc.cacheAsBitmap = true;
            this.mirrorClip(this.__get__fg_mc().mc, _loc11);
        }
        else
        {
            this.__get__fg_mc().mc.removeMovieClip();
        } // end else if
        var _loc12 = scene.actor;
        if (_loc4.actor_mc.id != Renderer.api.getLinkage("actor", scene))
        {
            _loc4.actor_mc.removeMovieClip();
            _loc4.attachMovie(Renderer.api.getLinkage("actor", scene), "actor_mc", 5);
            _loc4.actor_mc.id = Renderer.api.getLinkage("actor", scene);
            _loc4.actor_mc.audio_mc.stop();
        } // end if
        this.setFrame(_loc4.actor_mc, _loc8);
        var _loc13 = scene.actee;
        if (scene.actee && !Renderer.api.hasJointActors(scene) && _loc4.actee_mc.id != Renderer.api.getLinkage("actee", scene))
        {
            _loc4.actee_mc.removeMovieClip();
            _loc4.attachMovie(Renderer.api.getLinkage("actee", scene), "actee_mc", 4);
            _loc4.actee_mc.id = Renderer.api.getLinkage("actee", scene);
            _loc4.actee_mc.audio_mc.stop();
        } // end if
        this.setFrame(_loc4.actee_mc, _loc8);
        var _loc10 = scene.prop;
        var _loc9 = _loc4.actor_mc.prop_mc;
        if (!_loc9)
        {
            _loc9 = _loc4.actee_mc.prop_mc;
        } // end if
        _loc9.gotoAndStop(_loc10);
        _loc9._visible = true;
        if (_loc10 == "none" || !_loc10)
        {
            _loc9._visible = false;
        } // end if
        if (!_loc4.mg_mc)
        {
            _loc4.attachMovie("midground", "mg_mc", 2);
        } // end if
        this.setFrame(_loc4.mg_mc, _loc8);
        _loc4.mg_mc._visible = false;
        _loc11 = this.getFirstInstance(_loc4.mg_mc);
        if (_loc11)
        {
            if (this.__get__bg_mc().mid_mc.id != scene.location)
            {
                this.__get__bg_mc().attachMovie(scene.location + "_mg", "mid_mc", 2);
                this.__get__bg_mc().mid_mc.id = scene.location;
            } // end if
            this.__get__bg_mc().mid_mc.cacheAsBitmap = true;
            this.mirrorClip(this.__get__bg_mc().mid_mc, _loc11);
        }
        else
        {
            this.__get__bg_mc().mid_mc.removeMovieClip();
        } // end else if
        if (!_loc4.bg_mc)
        {
            _loc4.attachMovie("background", "bg_mc", 1);
        } // end if
        this.setFrame(_loc4.bg_mc, _loc8);
        _loc4.bg_mc._visible = false;
        _loc11 = this.getFirstInstance(_loc4.bg_mc);
        if (_loc11)
        {
            if (this.__get__bg_mc().back_mc.id != scene.location)
            {
                this.__get__bg_mc().attachMovie(scene.location + "_bg", "back_mc", 1);
                this.__get__bg_mc().back_mc.id = scene.location;
            } // end if
            this.__get__bg_mc().back_mc.cacheAsBitmap = true;
            this.mirrorClip(this.__get__bg_mc().back_mc, _loc11);
        }
        else
        {
            if (this.__get__bg_mc().back_mc.id != "solid")
            {
                this.__get__bg_mc().attachMovie("solid", "back_mc", 1);
            } // end if
            this.__get__bg_mc().back_mc.gotoAndStop(scene.location);
            if (scene.location == undefined)
            {
                this.__get__bg_mc().back_mc.stop();
                this.__get__bg_mc().back_mc._visible = false;
            } // end if
        } // end else if
        var _loc7 = Renderer.api.getTexts(scene.clip);
        for (var _loc5 = 0; _loc5 < int(_loc7.length); ++_loc5)
        {
            var _loc3 = _loc7[_loc5];
            var _loc2 = _loc4.actor_mc[_loc3];
            if (readOnly && _loc2.type == "input")
            {
                _loc2.type = "dynamic";
                _loc2.selectable = false;
            } // end if
            if (scene.text[_loc3] == undefined)
            {
                scene.text[_loc3] = "";
            } // end if
            if (!(_loc2.scaler instanceof Object))
            {
                _loc2.scaler = new TextScaler(_loc2, 72, 32);
            } // end if
            if (_loc2.text != scene.text[_loc3])
            {
                _loc2.text = scene.text[_loc3];
                _loc2.scaler.scaleToFit();
            } // end if
            _loc2.scene = scene;
            if (_loc2.id == _loc3)
            {
                continue;
            } // end if
            _loc2.id = _loc3;
            _loc2.root_mc = root_mc;
            _loc2.onChanged = function ()
            {
                scaler.scaleToFit();
                scene.writeText(id, text);
                if (onKillFocus)
                {
                    return;
                } // end if
                function onKillFocus()
                {
                    var _loc2 = text;
                    scene.writeText(id, _loc2);
                    root_mc.updateTextSceneDuration(scene, _loc2);
                    root_mc.pushUndoState();
                    delete this.onKillFocus;
                } // End of the function
            };
        } // end of for
        if (Renderer.timeline.enteredNewScene())
        {
            this.__get__root_mc().displaySentence();
        } // end if
    } // End of the function
    function renderTextcard(scene, frame, mc)
    {
        if (!mc.textcard_mc)
        {
            var _loc8 = "textcard";
            if (this.__get__root_mc().lang == "fr")
            {
                _loc8 = "textcard_fr";
            } // end if
            var _loc9 = mc.attachMovie(_loc8, "textcard_mc", 1);
            if (!_loc9)
            {
                mc.attachMovie("textcard", "textcard_mc", 1);
            } // end if
        } // end if
        this.setFrame(mc.textcard_mc, frame);
        var _loc6 = Renderer.api.getTexts(scene.clip);
        for (var _loc5 = 0; _loc5 < int(_loc6.length); ++_loc5)
        {
            var _loc3 = _loc6[_loc5];
            var _loc2 = mc.textcard_mc[_loc3];
            if (!(_loc2 instanceof TextField))
            {
                for (var _loc7 in mc.textcard_mc)
                {
                    _loc2 = mc.textcard_mc[_loc7][_loc3];
                    if (_loc2 instanceof TextField)
                    {
                        break;
                    } // end if
                } // end of for...in
            } // end if
            if (readOnly && _loc2.type == "input")
            {
                _loc2.type = "dynamic";
                _loc2.selectable = false;
            } // end if
            if (scene.text[_loc3] == undefined)
            {
                scene.text[_loc3] = "";
            } // end if
            if (!(_loc2.scaler instanceof Object))
            {
                _loc2.scaler = new TextScaler(_loc2, 72, 32);
            } // end if
            if (_loc2.text != scene.text[_loc3])
            {
                _loc2.text = scene.text[_loc3];
                _loc2.scaler.scaleToFit();
            } // end if
            _loc2.scene = scene;
            if (_loc2.id == _loc3)
            {
                continue;
            } // end if
            _loc2.id = _loc3;
            _loc2.root_mc = root_mc;
            _loc2.onChanged = function ()
            {
                scaler.scaleToFit();
                this.scene.writeText(id, text);
                if (onKillFocus)
                {
                    return;
                } // end if
                function onKillFocus()
                {
                    this.scene.writeText(id, text);
                    root_mc.pushUndoState();
                    delete this.onKillFocus;
                } // End of the function
            };
        } // end of for
        if (Renderer.timeline.enteredNewScene())
        {
            this.__get__root_mc().displaySentence();
        } // end if
    } // End of the function
    function renderStarter(scene, frame, mc)
    {
        if (!mc.starter_mc)
        {
            mc.attachMovie("starter", "starter_mc", 1);
        } // end if
        this.setFrame(mc.starter_mc, frame);
        for (var _loc4 in mc.starter_mc)
        {
            var _loc2 = mc.starter_mc[_loc4];
            if (_loc2._totalframes > 1)
            {
                _loc2.gotoAndStop(this.__get__root_mc().lang);
            } // end if
        } // end of for...in
    } // End of the function
    function clearPreview(previewClip_mc)
    {
        for (var _loc2 in previewClip_mc)
        {
            previewClip_mc[_loc2].removeMovieClip();
        } // end of for...in
    } // End of the function
    function setCurrentPreview(mc)
    {
        currentPreview = mc;
        return (currentPreview);
    } // End of the function
    function getCurrentPreview(mc)
    {
        return (currentPreview);
    } // End of the function
    function clearBackground()
    {
        for (var _loc2 in this.__get__bg_mc())
        {
            this.__get__bg_mc()[_loc2].removeMovieClip();
        } // end of for...in
        for (var _loc2 in this.__get__fg_mc())
        {
            this.__get__fg_mc()[_loc2].removeMovieClip();
        } // end of for...in
    } // End of the function
    function setFrame(anim_mc, frame)
    {
        var _loc3 = frame % anim_mc._totalframes + 1;
        anim_mc.gotoAndStop(_loc3);
        if (this.__get__root_mc().isPlaying())
        {
            this.startAudio(anim_mc.audio_mc, frame);
        }
        else
        {
            this.stopAudio(anim_mc.audio_mc);
        } // end else if
    } // End of the function
    function startAudio(audio_mc, frame)
    {
        if (audio_mc.isPlaying || !audio_mc)
        {
            return;
        } // end if
        audio_mc.isPlaying = true;
        var _loc2 = frame % audio_mc._totalframes + 1;
        audio_mc.gotoAndPlay(_loc2);
        audio_mc.play();
    } // End of the function
    function stopAudio(audio_mc)
    {
        audio_mc.isPlaying = false;
        audio_mc.stop();
    } // End of the function
    function getFirstInstance(target_mc)
    {
        for (var _loc2 in target_mc)
        {
            if (target_mc[_loc2] instanceof MovieClip)
            {
                return (target_mc[_loc2]);
            } // end if
        } // end of for...in
    } // End of the function
    function mirrorClip(target_mc, source_mc)
    {
        target_mc._x = source_mc._x;
        target_mc._y = source_mc._y;
        target_mc._xscale = source_mc._xscale;
        target_mc._yscale = source_mc._yscale;
        target_mc._rotation = source_mc._rotation;
    } // End of the function
    function showLoadingIcon()
    {
        this.__get__root_mc().loadingIcon_mc.play();
        this.__get__root_mc().loadingIcon_mc._visible = true;
    } // End of the function
    function hideLoadingIcon()
    {
        this.__get__root_mc().loadingIcon_mc._visible = false;
        this.__get__root_mc().loadingIcon_mc.stop();
    } // End of the function
} // End of Class

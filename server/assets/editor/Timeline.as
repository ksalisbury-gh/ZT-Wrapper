class Timeline
{
    var scenes, fps, pxPerSec, pxPerFrame, width, height, maxLength, currentFrame, currentIndex, maxSceneLength, movieclips, __get__timeline_mc, prevIndex, __get__clips_mc, __get__endclips_mc, __get__cells_mc, __get__dragContainer_mc, timeline, __get__root_mc, _xmouse, xgrab, _ymouse, ygrab, onRelease, onReleaseOutside, __get__playhead_mc, __get__scrubBar_mc, __get__prev_btn, __get__next_btn;
    static var renderer, api, locale;
    function Timeline(lngth, clips)
    {
        scenes = new Array();
        fps = 15;
        pxPerSec = 60;
        pxPerFrame = pxPerSec / fps;
        width = 660;
        height = 75;
        maxLength = Math.max(lngth, Math.floor(width / pxPerSec));
        currentFrame = 0;
        currentIndex = -1;
        maxSceneLength = 3;
        movieclips = clips;
        this.__get__timeline_mc().scrollRect = new flash.geom.Rectangle(0, 0, width, height);
        this.attachVisibleCells();
    } // End of the function
    function setCurrentIndex(i)
    {
        i = int(i);
        prevIndex = currentIndex;
        var _loc3 = i != prevIndex;
        currentIndex = i;
        return (_loc3);
    } // End of the function
    function setCurrentFrame(f)
    {
        f = int(f);
        f = Math.min(f, this.getLastFrame());
        var _loc3 = f != this.getCurrentFrame();
        currentFrame = f;
        if (_loc3)
        {
            this.updateSceneArrows();
            if (!scrub.interval)
            {
                this.updateScrubBar();
            } // end if
            if (!dragPlayhead.interval && !dragClip.interval)
            {
                this.updatePlayhead();
            } // end if
            Timeline.renderer.render();
        } // end if
        return (_loc3);
    } // End of the function
    function setCurrentTime(t)
    {
        return (this.setCurrentFrame(t * fps));
    } // End of the function
    function getCurrentTime()
    {
        return (currentFrame / fps);
    } // End of the function
    function getScene(i)
    {
        return (scenes[i]);
    } // End of the function
    function getSceneAtTime(seconds)
    {
        if (seconds >= this.getTotalTime())
        {
            return (this.getLastScene());
        } // end if
        for (var _loc3 = 0; _loc3 <= Math.floor(seconds); ++_loc3)
        {
            var _loc2 = this.getScene(_loc3);
            var _loc5 = _loc2.startTime;
            var _loc6 = _loc2.startTime + _loc2.duration;
            if (seconds >= _loc5 && seconds < _loc6)
            {
                return (_loc2);
            } // end if
        } // end of for
    } // End of the function
    function getSceneAtFrame(frame)
    {
        var _loc2 = frame / fps;
        return (this.getSceneAtTime(_loc2));
    } // End of the function
    function getCurrentScene()
    {
        return (this.getSceneAtFrame(this.getCurrentFrame()));
    } // End of the function
    function updateCurrentIndex()
    {
        return (this.setCurrentIndex(this.getCurrentScene().index));
    } // End of the function
    function getLastScene()
    {
        return (scenes[scenes.length - 1]);
    } // End of the function
    function getLastFrame()
    {
        var _loc2 = this.getTotalTime();
        if (_loc2 < 1)
        {
            return (0);
        } // end if
        return (_loc2 * fps - 1);
    } // End of the function
    function getTotalTime()
    {
        var _loc2 = this.getLastScene();
        if (!_loc2)
        {
            return (0);
        } // end if
        return (_loc2.startTime + _loc2.duration);
    } // End of the function
    function getCurrentFrame()
    {
        return (currentFrame);
    } // End of the function
    function getCurrentIndex()
    {
        return (currentIndex);
    } // End of the function
    function getSceneFrame(scene)
    {
        return (this.getCurrentFrame() - scene.frameOffset);
    } // End of the function
    function getTimelinePosition()
    {
        //return (this.clips_mc()._x);
    } // End of the function
    function get playhead_mc()
    {
        return (movieclips.playhead_mc);
    } // End of the function
    function get timeline_mc()
    {
        return (movieclips.timeline_mc);
    } // End of the function
    function get clips_mc()
    {
        return (movieclips.timeline_mc.clips_mc);
    } // End of the function
    function get cells_mc()
    {
        return (movieclips.timeline_mc.cells_mc);
    } // End of the function
    function get endclips_mc()
    {
        return (movieclips.timeline_mc.endclips_mc);
    } // End of the function
    function get dragContainer_mc()
    {
        movieclips.dragContainer_mc._x = 0;
        movieclips.dragContainer_mc._y = 0;
        return (movieclips.dragContainer_mc);
    } // End of the function
    function get scrubBar_mc()
    {
        return (movieclips.scrubBar_mc);
    } // End of the function
    function get root_mc()
    {
        return (movieclips.root_mc);
    } // End of the function
    function get prev_btn()
    {
        return (movieclips.prev_btn);
    } // End of the function
    function get next_btn()
    {
        return (movieclips.next_btn);
    } // End of the function
    function addScene(scene, index)
    {
        if (this.getTotalTime() + scene.duration > maxLength && this.__get__timeline_mc())
        {
            return (false);
        } // end if
        scenes.splice(index, 0, scene);
        this.updateSceneIndexes();
        this.updateSceneArrows();
        this.enableScrubbing();
        this.enablePlayback();
        return (scene);
    } // End of the function
    function removeScene(scene)
    {
        scenes.splice(scene.index, 1);
        this.updateSceneIndexes();
        this.updateSceneArrows();
        if (!scenes.length)
        {
            this.disableScrubbing();
            this.disablePlayback();
        } // end if
    } // End of the function
    function clear()
    {
        scenes = new Array();
        this.setCurrentIndex(-1);
        this.setCurrentFrame(-1);
        clearInterval(scrollTowardCenter.interval);
        delete scrollTowardCenter.interval;
        this.positionTimeline(0);
        this.render();
        Timeline.renderer.render();
    } // End of the function
    function updateSceneIndexes()
    {
        var _loc4 = 0;
        for (var _loc3 = 0; _loc3 < scenes.length; ++_loc3)
        {
            var _loc2 = this.getScene(_loc3);
            _loc2.updateIndex(_loc3);
            _loc2.updateFrameOffset(_loc4 * fps);
            if (_loc2.clip == this.getScene(_loc3 - 1).clip)
            {
                _loc2.updateFrameOffset(this.getScene(_loc3 - 1).frameOffset);
            } // end if
            _loc2.updateStartTime(_loc4);
            _loc4 = _loc4 + _loc2.duration;
        } // end of for
    } // End of the function
    function render()
    {
        if (!this.__get__timeline_mc())
        {
            return;
        } // end if
        this.clearClips();
        this.clearCells();
        this.attachVisibleCells();
        this.attachVisibleClips();
    } // End of the function
    function clearClips()
    {
        for (var _loc2 in this.__get__clips_mc())
        {
            this.__get__clips_mc()[_loc2].removeMovieClip();
        } // end of for...in
        for (var _loc2 in this.__get__endclips_mc())
        {
            this.__get__endclips_mc()[_loc2].removeMovieClip();
        } // end of for...in
    } // End of the function
    function clearCells()
    {
        for (var _loc2 in this.__get__cells_mc())
        {
            this.__get__cells_mc()[_loc2].removeMovieClip();
        } // end of for...in
    } // End of the function
    function attachVisibleCells(x)
    {
        if (!this.__get__timeline_mc())
        {
            return;
        } // end if
        var _loc5 = pxPerSec;
        if (x == undefined)
        {
            x = this.__get__cells_mc()._x;
        } // end if
        var _loc4 = Math.floor(-x / _loc5) - maxSceneLength;
        _loc4 = Math.max(0, _loc4);
        var _loc3 = Math.floor((width - x) / _loc5) + maxSceneLength;
        _loc3 = Math.min(_loc3, maxLength - 1);
        for (var _loc2 = _loc4; _loc2 <= _loc3; ++_loc2)
        {
            this.attachCell(_loc2);
        } // end of for
    } // End of the function
    function attachVisibleClips(x)
    {
        if (x == undefined)
        {
            x = this.__get__clips_mc()._x;
        } // end if
        var _loc3 = this.getVisibleClipIndexes(x);
        if (!_loc3)
        {
            return;
        } // end if
        for (var _loc2 = _loc3.imin; _loc2 <= _loc3.imax; ++_loc2)
        {
            if (this.__get__dragContainer_mc().drag_mc.scene == this.getScene(_loc2))
            {
                continue;
            } // end if
            this.attachClip(_loc2);
        } // end of for
    } // End of the function
    function getVisibleClipIndexes(x)
    {
        if (!this.getLastScene())
        {
            return (false);
        } // end if
        var _loc2 = -x / pxPerSec - maxSceneLength;
        var _loc6 = this.getSceneAtTime(_loc2).index;
        _loc6 = Math.max(0, int(_loc6));
        var _loc3 = (width - x) / pxPerSec + maxSceneLength;
        var _loc4 = this.getSceneAtTime(_loc3).index;
        return ({imin: _loc6, imax: _loc4});
    } // End of the function
    function attachCell(seconds)
    {
        var _loc4 = "cell" + seconds + "_mc";
        if (this.__get__cells_mc()[_loc4])
        {
            return;
        } // end if
        var _loc3 = this.__get__cells_mc().attachMovie("cell", _loc4, seconds);
        _loc3._x = pxPerSec * seconds;
        _loc3.label_txt.text = seconds;
    } // End of the function
    function attachClip(i, host_mc)
    {
        if (!host_mc)
        {
            host_mc = clips_mc;
        } // end if
        var _loc3 = this.getScene(i);
        if (host_mc["clip" + _loc3.index + "_mc"])
        {
            return;
        } // end if
        var _loc2 = host_mc.attachMovie("clip", "clip" + _loc3.index + "_mc", _loc3.index);
        _loc2._x = _loc3.startTime * pxPerSec;
        this.labelClip(_loc3, _loc2);
        _loc2.gotoAndStop("off" + i % 2);
        _loc2.bar_mc.gotoAndStop(Timeline.api.getCategory(_loc3.clip));
        this.attachThumb(_loc3, _loc2);
        _loc2.cacheAsBitmap = true;
        _loc2.scrollRect = new flash.geom.Rectangle(0, 0, pxPerSec * _loc3.duration - 1, height);
        _loc2.scene = _loc3;
        _loc2.timeline = this;
        _loc2.onPress = function ()
        {
            timeline.pressClip(this);
        };
        if (_loc3.index == currentIndex)
        {
            this.highlightClip(_loc2);
        } // end if
    } // End of the function
    function removeClip(i)
    {
        this.__get__clips_mc()["clip" + i + "_mc"].removeMovieClip();
    } // End of the function
    function highlightClip(clip_mc)
    {
        clip_mc.gotoAndStop(Timeline.api.getCategory(clip_mc.scene.clip));
        clip_mc.thumbWindow_mc.gotoAndStop("on");
        this.applyDropShadow(clip_mc.label_txt);
    } // End of the function
    function dehighlightAllClips()
    {
        for (var _loc2 in this.__get__clips_mc())
        {
            this.__get__clips_mc()[_loc2].gotoAndStop("off" + this.__get__clips_mc()[_loc2].scene.index % 2);
            this.__get__clips_mc()[_loc2].thumbWindow_mc.gotoAndStop("off");
            this.applyDropShadow(this.__get__clips_mc()[_loc2].label_txt);
        } // end of for...in
        for (var _loc2 in this.__get__endclips_mc())
        {
            this.__get__endclips_mc()[_loc2].gotoAndStop("off" + this.__get__clips_mc()[_loc2].scene.index % 2);
            this.__get__endclips_mc()[_loc2].thumbWindow_mc.gotoAndStop("off");
            this.applyDropShadow(this.__get__endclips_mc()[_loc2].label_txt);
        } // end of for...in
    } // End of the function
    function attachThumb(scene, clip_mc)
    {
        clip_mc.thumbWindow_mc._x = scene.duration * pxPerSec / 2;
        var _loc2 = clip_mc.thumbWindow_mc.thumb_mc.attachMovie(scene.clip, scene.clip + "_mc", 1);
        this.__get__root_mc().langToggle(_loc2);
        var _loc4 = 46;
        var _loc3 = 36;
        var _loc6 = _loc2._width - _loc4;
        var _loc5 = _loc2._height - _loc3;
        _loc2.cacheAsBitmap = true;
        _loc2.scrollRect = new flash.geom.Rectangle(_loc6 / 2, _loc5 / 2, _loc4, _loc3);
    } // End of the function
    function labelClip(scene, clip_mc)
    {
        clip_mc.label_txt.text = Timeline.locale.getLabel(scene);
        clip_mc.label_txt.autoSize = "center";
        clip_mc.label_txt._x = Math.max(0, (pxPerSec * scene.duration - clip_mc.label_txt._width) / 2);
        this.applyDropShadow(clip_mc.label_txt);
    } // End of the function
    function selectClip(clip_mc)
    {
        this.setCurrentFrame(clip_mc.scene.startTime * fps);
        this.updateCurrentIndex();
        this.maskPlayhead();
        this.dehighlightAllClips();
        this.highlightClip(clip_mc);
        if (this.enteredNewScene())
        {
            Timeline.renderer.render();
        } // end if
    } // End of the function
    function selectScene(i)
    {
        var _loc2 = this.__get__timeline_mc().clips_mc["clip" + i + "_mc"];
        this.selectClip(_loc2);
    } // End of the function
    function pressDelete(clip_mc)
    {
        this.__get__root_mc().stopPlayback();
        if (scrollTowardCenter.interval)
        {
            clearInterval(scrollTowardCenter.interval);
            delete scrollTowardCenter.interval;
            this.jumpToCenter();
        } // end if
        this.selectClip(clip_mc);
        this.dragClipOut(clip_mc);
        this.releaseDrag(clip_mc);
    } // End of the function
    function pressClip(clip_mc)
    {
        this.__get__root_mc().stopPlayback();
        if (clip_mc.thumbWindow_mc.delete_mc.hitTest(this.__get__root_mc()._xmouse, this.__get__root_mc()._ymouse, true))
        {
            return (this.pressDelete(clip_mc));
        } // end if
        this.selectClip(clip_mc);
        clip_mc.xgrab = clip_mc._xmouse;
        clip_mc.ygrab = clip_mc._ymouse;
        clip_mc.onMouseMove = function ()
        {
            var _loc3 = _xmouse - xgrab;
            var _loc2 = _ymouse - ygrab;
            var _loc4 = Math.sqrt(_loc3 * _loc3 + _loc2 * _loc2);
            var _loc5 = timeline.height / 3;
            if (_loc4 < _loc5)
            {
                return;
            } // end if
            timeline.startDraggingClip(this);
        };
        clip_mc.onRelease = clip_mc.onReleaseOutside = function ()
        {
            timeline.releaseClip(this);
            delete this.onRelease;
            delete this.onReleaseOutside;
        };
    } // End of the function
    function releaseClip(clip_mc)
    {
        if (!closeGap.interval)
        {
            this.render();
            this.center();
        } // end if
    } // End of the function
    function startDraggingClip(clip_mc)
    {
        var _loc5 = clip_mc.xgrab;
        var _loc4 = clip_mc.ygrab;
        var _loc2 = this.__get__dragContainer_mc().attachMovie("clip", "drag_mc", 1);
        _loc2._alpha = 0;
        _loc2._x = this.__get__dragContainer_mc()._xmouse - _loc5;
        _loc2._y = this.__get__dragContainer_mc()._ymouse - _loc4;
        _loc2.onRelease = _loc2.onReleaseOutside = function ()
        {
            timeline.releaseDrag(this);
        };
        _loc2._focusrect = false;
        Selection.setFocus(_loc2);
        _loc2.scene = clip_mc.scene;
        _loc2.timeline = this;
        _loc2.bar_mc.gotoAndStop(Timeline.api.getCategory(_loc2.scene.clip));
        this.attachThumb(_loc2.scene, _loc2);
        this.highlightClip(_loc2);
        this.labelClip(_loc2.scene, _loc2);
        _loc2.cacheAsBitmap = true;
        _loc2.scrollRect = new flash.geom.Rectangle(0, 0, clip_mc.scene.duration * pxPerSec, height);
        _loc2._alpha = 80;
        this.removeClip(clip_mc.scene.index);
        if (dragClip.interval)
        {
            clearInterval(dragClip.interval);
        } // end if
        dragClip.interval = setInterval(this, "dragClip", 35, _loc2, _loc5, _loc4);
    } // End of the function
    function dragClip(drag_mc, xgrab, ygrab)
    {
        drag_mc._x = this.__get__dragContainer_mc()._xmouse - xgrab;
        drag_mc._y = this.__get__dragContainer_mc()._ymouse - ygrab;
        var _loc6 = this.snapDragClip(drag_mc);
        if (!_loc6)
        {
            return (this.dragClipOut(drag_mc));
        } // end if
        this.scrollDragClip(drag_mc);
        this.positionPlayhead(drag_mc._x - this.__get__timeline_mc()._x - this.__get__clips_mc()._x);
        var _loc4 = this.getMoveIndex(drag_mc);
        var _loc3 = drag_mc.scene;
        if (_loc4 == _loc3.index)
        {
            return;
        } // end if
        if (_loc3.index == null)
        {
            this.addScene(_loc3, _loc4);
            this.highlightClip(drag_mc);
            var _loc5 = true;
        }
        else
        {
            this.removeScene(_loc3);
            this.addScene(_loc3, _loc4);
        } // end else if
        this.removeClip(_loc3.index);
        this.setCurrentIndex(_loc4);
        var _loc7 = this.setCurrentFrame(_loc3.startTime * fps);
        this.render();
        if (_loc5 && !_loc7)
        {
            this.__get__root_mc().displaySentence();
            Timeline.renderer.render();
        } // end if
        updateAfterEvent();
    } // End of the function
    function snapDragClip(drag_mc)
    {
        var _loc2 = {x: drag_mc._x, y: drag_mc._y};
        this.__get__clips_mc().globalToLocal(_loc2);
        var _loc4 = height / 3;
        if (Math.abs(_loc2.y) >= _loc4)
        {
            return (false);
        } // end if
        drag_mc._y = drag_mc._y - _loc2.y;
        return (true);
    } // End of the function
    function dragClipOut(drag_mc)
    {
        var _loc2 = drag_mc.scene;
        if (_loc2.index == null)
        {
            return;
        } // end if
        if (_loc2.index < this.getLastScene().index)
        {
            this.renderSplit(_loc2.index);
            var _loc5 = this.__get__clips_mc()._x - _loc2.duration * pxPerSec;
            if (closeGap.interval)
            {
                clearInterval(closeGap.interval);
            } // end if
            closeGap.interval = setInterval(this, "closeGap", 35, _loc5);
        }
        else
        {
            var _loc4 = true;
        } // end else if
        if (_loc4)
        {
            this.setCurrentFrame(this.getScene(_loc2.index - 1).startTime * fps);
        } // end if
        this.updatePlayhead();
        this.updateCurrentIndex();
        drag_mc.gotoAndStop("off0");
        this.applyDropShadow(drag_mc.label_txt);
        drag_mc.thumbWindow_mc.gotoAndStop("off");
        this.removeScene(_loc2);
        _loc2.index = null;
        if (_loc4)
        {
            this.render();
        } // end if
        this.__get__root_mc().displaySentence();
        Timeline.renderer.render();
    } // End of the function
    function scrollDragClip(drag_mc)
    {
        var _loc4 = width - pxPerSec * this.getTotalTime();
        var _loc3 = 0;
        var _loc2 = this.__get__timeline_mc()._parent._xmouse;
        if (_loc2 < this.__get__timeline_mc()._x)
        {
            this.scroll(10, _loc4, _loc3);
        }
        else if (_loc2 > this.__get__timeline_mc()._x + width)
        {
            var _loc6 = width - this.__get__clips_mc()._x;
            var _loc5 = _loc6 / pxPerSec;
            if (_loc5 < this.getTotalTime())
            {
                this.scroll(-10, _loc4, _loc3);
            } // end if
        } // end else if
    } // End of the function
    function getMoveIndex(drag_mc)
    {
        var _loc2;
        var _loc5 = drag_mc.scene;
        var _loc4 = (drag_mc._x - this.__get__timeline_mc()._x - this.__get__clips_mc()._x) / pxPerSec + _loc5.duration / 2;
        var _loc3 = this.getSceneAtTime(_loc4);
        var _loc6 = _loc3.startTime + _loc3.duration / 2;
        if (_loc5.index == null)
        {
            _loc2 = _loc3.index;
            _loc2 = _loc2 + (_loc4 > _loc6);
        }
        else
        {
            _loc2 = _loc5.index;
            var _loc7 = _loc3.index - _loc5.index;
            if (_loc7 > 0)
            {
                if (_loc4 > _loc6)
                {
                    ++_loc2;
                } // end if
            }
            else if (_loc7 < 0)
            {
                if (_loc4 < _loc6)
                {
                    --_loc2;
                } // end if
            } // end else if
        } // end else if
        return (_loc2);
    } // End of the function
    function releaseDrag(drag_mc)
    {
        clearInterval(dragClip.interval);
        delete dragClip.interval;
        drag_mc.removeMovieClip();
        this.updatePlayhead();
        this.updateScrubBar();
        if (!closeGap.interval)
        {
            this.render();
            this.center();
        } // end if
        Timeline.renderer.render();
        this.__get__root_mc().pushUndoState();
    } // End of the function
    function calcScrollTarget()
    {
        var _loc3 = this.__get__timeline_mc()._x + Math.floor(width / 2);
        var _loc4 = _loc3 - this.__get__playhead_mc()._x;
        var _loc2 = this.__get__clips_mc()._x + _loc4;
        _loc2 = Math.min(_loc2, 0);
        _loc2 = Math.max(width - maxLength * pxPerSec, _loc2);
        return (_loc2);
    } // End of the function
    function center()
    {
        var _loc2 = this.calcScrollTarget();
        if (_loc2 == this.__get__clips_mc()._x)
        {
            return;
        } // end if
        this.attachVisibleCells(_loc2);
        this.attachVisibleClips(_loc2);
        if (scrollTowardCenter.interval)
        {
            clearInterval(scrollTowardCenter.interval);
        } // end if
        scrollTowardCenter.interval = setInterval(this, "scrollTowardCenter", 35, _loc2);
    } // End of the function
    function positionTimeline(x)
    {
        this.__get__clips_mc()._x = x;
        this.__get__endclips_mc()._x = x;
        this.__get__cells_mc()._x = x;
    } // End of the function
    function jumpToCenter()
    {
        clearInterval(scrollTowardCenter.interval);
        delete scrollTowardCenter.interval;
        clearInterval(closeGap.interval);
        delete closeGap.interval;
        this.positionTimeline(this.calcScrollTarget());
        this.updatePlayhead();
        this.render();
    } // End of the function
    function scrollTowardCenter(x, skipRender)
    {
        if (!this.__get__timeline_mc())
        {
            return;
        } // end if
        if (x == undefined)
        {
            x = this.calcScrollTarget();
        } // end if
        var _loc3 = x - this.__get__clips_mc()._x;
        var _loc6 = 2;
        var _loc4 = Math.round(_loc3 / _loc6);
        if (Math.abs(_loc4) < pxPerFrame)
        {
            if (Math.abs(_loc3) > pxPerFrame)
            {
                _loc4 = pxPerFrame * Math.abs(_loc3) / _loc3;
            }
            else
            {
                this.positionTimeline(x);
                this.updatePlayhead();
                this.maskPlayhead();
                if (!skipRender)
                {
                    this.render();
                } // end if
                clearInterval(arguments.callee.interval);
                delete arguments.callee.interval;
                updateAfterEvent();
                return;
            } // end if
        } // end else if
        this.positionTimeline(this.getTimelinePosition() + _loc4);
        this.__get__playhead_mc()._x = this.__get__playhead_mc()._x + _loc4;
        this.maskPlayhead();
        updateAfterEvent();
    } // End of the function
    function scroll(step, xmin, xmax)
    {
        var _loc2 = this.__get__cells_mc()._x + step;
        if (Math.abs(xmin) > pxPerSec * (maxLength - 1))
        {
            xmin = xmin + (width - pxPerFrame);
        } // end if
        if (step > 0)
        {
            _loc2 = Math.min(_loc2, xmax);
        }
        else
        {
            _loc2 = Math.max(_loc2, xmin);
        } // end else if
        this.positionTimeline(_loc2);
    } // End of the function
    function pressPlayhead()
    {
        if (dragPlayhead.interval)
        {
            clearInterval(dragPlayhead.interval);
        } // end if
        var _loc2 = this.__get__playhead_mc()._xmouse;
        dragPlayhead.interval = setInterval(this, "dragPlayhead", 35, _loc2);
    } // End of the function
    function releasePlayhead()
    {
        clearInterval(dragPlayhead.interval);
        delete dragPlayhead.interval;
        this.snapPlayhead();
        this.center();
    } // End of the function
    function dragPlayhead(xgrab)
    {
        var _loc6 = this.getLastFrame();
        if (!_loc6)
        {
            return;
        } // end if
        var _loc5 = _loc6 * pxPerFrame;
        var _loc3 = 0;
        var _loc11 = width - this.__get__clips_mc()._x - pxPerFrame;
        var _loc16 = -this.__get__clips_mc()._x;
        var _loc13 = Math.min(_loc5, _loc11);
        var _loc15 = Math.max(_loc3, _loc16);
        var _loc8 = this.__get__clips_mc()._xmouse - xgrab;
        var _loc2 = Math.max(_loc15, Math.min(_loc8, _loc13));
        var _loc9 = this.positionPlayhead(_loc2);
        var _loc4 = false;
        if (_loc2 + this.__get__clips_mc()._x < pxPerSec / 2)
        {
            this.scroll(15, -_loc5, _loc3);
            _loc4 = -1;
        }
        else if (_loc2 + this.__get__clips_mc()._x > width - pxPerSec / 2)
        {
            this.scroll(-15, -_loc5, _loc3);
            _loc4 = 1;
        } // end else if
        if (!_loc9 && !_loc4)
        {
            return;
        } // end if
        var _loc7 = Math.floor(_loc2 / pxPerFrame);
        var _loc14 = this.setCurrentFrame(_loc7);
        if (!_loc14)
        {
            updateAfterEvent();
            return (false);
        } // end if
        var _loc12 = this.getSceneAtFrame(_loc7);
        var _loc17 = _loc12.index;
        var _loc10 = this.updateCurrentIndex();
        if (_loc10)
        {
            this.render();
            this.__get__root_mc().displaySentence();
        } // end if
        updateAfterEvent();
        return (true);
    } // End of the function
    function updatePlayhead()
    {
        var _loc2 = this.getCurrentFrame() * pxPerFrame;
        this.positionPlayhead(_loc2);
    } // End of the function
    function positionPlayhead(pixels)
    {
        var _loc2 = this.__get__timeline_mc()._x + this.__get__clips_mc()._x + pixels;
        var _loc3 = this.__get__playhead_mc()._x != _loc2;
        this.__get__playhead_mc()._x = _loc2;
        this.maskPlayhead();
        return (_loc3);
    } // End of the function
    function snapPlayhead()
    {
        var _loc2 = this.getCurrentFrame() * pxPerFrame;
        this.positionPlayhead(_loc2);
    } // End of the function
    function maskPlayhead()
    {
        if (this.__get__playhead_mc()._x < this.__get__timeline_mc()._x || this.__get__playhead_mc()._x > this.__get__timeline_mc()._x + width)
        {
            this.__get__playhead_mc()._visible = false;
        }
        else
        {
            this.__get__playhead_mc()._visible = true;
        } // end else if
    } // End of the function
    function updateScrubBar()
    {
        var _loc2 = this.__get__scrubBar_mc().scrubTrack_mc._width - this.__get__scrubBar_mc().thumb_mc._width + 2;
        this.__get__scrubBar_mc().thumb_mc._x = Math.round(_loc2 * this.getCurrentFrame() / this.getLastFrame());
        this.__get__scrubBar_mc().bar_mc._x = this.__get__scrubBar_mc().thumb_mc._x + this.__get__scrubBar_mc().thumb_mc._width / 2;
    } // End of the function
    function pressScrubBar()
    {
        var _loc2 = this.__get__scrubBar_mc().thumb_mc._xmouse;
        if (scrub.interval)
        {
            clearInterval(scrub.interval);
        } // end if
        scrub.interval = setInterval(this, "scrub", 35, _loc2);
    } // End of the function
    function scrub(xgrab)
    {
        var _loc5 = 0;
        var _loc3 = this.__get__scrubBar_mc().scrubTrack_mc._width - this.__get__scrubBar_mc().thumb_mc._width + 2;
        var _loc2 = this.__get__scrubBar_mc()._xmouse - xgrab;
        _loc2 = Math.max(_loc5, _loc2);
        _loc2 = Math.min(_loc2, _loc3);
        this.__get__scrubBar_mc().thumb_mc._x = _loc2;
        this.__get__scrubBar_mc().bar_mc._x = this.__get__scrubBar_mc().thumb_mc._x + this.__get__scrubBar_mc().thumb_mc._width / 2;
        var _loc4 = _loc2 / _loc3 * this.getLastFrame();
        this.setCurrentFrame(_loc4);
        this.jumpToCenter();
        if (this.updateCurrentIndex())
        {
            this.render();
            this.__get__root_mc().displaySentence();
        } // end if
        updateAfterEvent();
    } // End of the function
    function releaseScrubBar()
    {
        clearInterval(scrub.interval);
        delete scrub.interval;
        this.updateScrubBar();
    } // End of the function
    function disableScrubbing()
    {
        this.__get__scrubBar_mc().thumb_mc.enabled = false;
        this.__get__scrubBar_mc().thumb_mc.gotoAndStop("off");
        this.__get__playhead_mc().btn.enabled = false;
        this.__get__playhead_mc().btn2.enabled = false;
        this.__get__playhead_mc().gotoAndStop("off");
    } // End of the function
    function enableScrubbing()
    {
        this.__get__scrubBar_mc().thumb_mc.enabled = true;
        this.__get__scrubBar_mc().thumb_mc.gotoAndStop("up");
        this.__get__playhead_mc().btn.enabled = true;
        this.__get__playhead_mc().btn2.enabled = true;
        this.__get__playhead_mc().gotoAndStop("up");
    } // End of the function
    function renderSplit(index)
    {
        this.clearClips();
        var _loc3 = this.getVisibleClipIndexes(this.__get__clips_mc()._x);
        for (var _loc2 = _loc3.imin; _loc2 < index; ++_loc2)
        {
            this.attachClip(_loc2);
        } // end of for
        this.__get__endclips_mc()._x = this.__get__clips_mc()._x;
        for (var _loc2 = index + 1; _loc2 <= _loc3.imax; ++_loc2)
        {
            this.attachClip(_loc2, this.__get__endclips_mc());
        } // end of for
    } // End of the function
    function closeGap(x)
    {
        var _loc3 = x - this.__get__endclips_mc()._x;
        this.__get__endclips_mc()._x = this.__get__endclips_mc()._x + Math.floor(_loc3 / 2);
        if (this.__get__endclips_mc()._x <= x)
        {
            clearInterval(arguments.callee.interval);
            delete arguments.callee.interval;
            this.__get__endclips_mc()._x = x;
            this.render();
            if (!this.__get__dragContainer_mc().drag_mc)
            {
                this.center();
            } // end if
        } // end if
    } // End of the function
    function playback()
    {
        var _loc3 = this.setCurrentFrame(this.getCurrentFrame() + 1);
        if (!_loc3)
        {
            return (false);
        } // end if
        var _loc2 = this.updateCurrentIndex();
        if (_loc2)
        {
            this.render();
        } // end if
        if (scrollTowardCenter.interval)
        {
            clearInterval(scrollTowardCenter.interval);
            delete scrollTowardCenter.interval;
        } // end if
        this.scrollTowardCenter(null, true);
        return (true);
    } // End of the function
    function nextScene()
    {
        var _loc3 = this.getCurrentIndex() + 1;
        var _loc2 = this.getScene(_loc3);
        if (!_loc2)
        {
            _loc2 = this.getCurrentScene();
            this.setCurrentFrame((_loc2.startTime + _loc2.duration) * fps - 1);
        }
        else
        {
            this.setCurrentFrame(_loc2.startTime * fps);
            this.updateCurrentIndex();
            this.__get__root_mc().displaySentence();
        } // end else if
        if (!closeGap.interval)
        {
            this.render();
            this.center();
        } // end if
    } // End of the function
    function prevScene()
    {
        var _loc3 = this.getCurrentIndex();
        if (this.getCurrentFrame() == this.getCurrentScene().startTime * fps)
        {
            --_loc3;
        } // end if
        var _loc2 = this.getScene(_loc3);
        if (!_loc2)
        {
            return;
        } // end if
        this.setCurrentFrame(_loc2.startTime * fps);
        this.updateCurrentIndex();
        if (this.enteredNewScene())
        {
            this.__get__root_mc().displaySentence();
        } // end if
        if (!closeGap.interval)
        {
            this.render();
            this.center();
        } // end if
    } // End of the function
    function rewind()
    {
        this.__get__root_mc().stopPlayback();
        this.setCurrentFrame(0);
        this.updateCurrentIndex();
        this.jumpToCenter();
    } // End of the function
    function disablePlayback()
    {
        this.__get__root_mc().stopPlayback();
        this.disable(this.__get__root_mc().play_btn);
        this.disable(this.__get__root_mc().pause_btn);
        this.__get__root_mc().pause_btn._visible = true;
    } // End of the function
    function enablePlayback()
    {
        this.__get__root_mc().stopPlayback();
        this.enable(this.__get__root_mc().play_btn);
        this.__get__root_mc().pause_btn._visible = false;
    } // End of the function
    function gotoMiddleFrame()
    {
        var _loc2 = this.getCurrentScene();
        var _loc3 = _loc2.startTime * fps + Math.floor(_loc2.duration * fps / 2);
        this.setCurrentFrame(_loc3);
        this.updateCurrentIndex();
    } // End of the function
    function enteredNewScene()
    {
        return (currentIndex != prevIndex);
    } // End of the function
    function updateSceneArrows()
    {
        if (this.getCurrentFrame() > 0)
        {
            this.enable(this.__get__prev_btn());
            this.enable(this.__get__root_mc().rewind_btn);
        }
        else
        {
            this.disable(this.__get__prev_btn());
            this.disable(this.__get__root_mc().rewind_btn);
        } // end else if
        if (this.getCurrentFrame() < this.getLastFrame())
        {
            this.enable(this.__get__next_btn());
        }
        else
        {
            this.disable(this.__get__next_btn());
        } // end else if
    } // End of the function
    function applyDropShadow(target)
    {
        var _loc1 = new flash.filters.DropShadowFilter();
        _loc1.distance = 0;
        _loc1.alpha = 0.800000;
        target.filters = [_loc1];
    } // End of the function
    function disable(btn)
    {
        this.__get__root_mc().disable(btn);
    } // End of the function
    function enable(btn)
    {
        this.__get__root_mc().enable(btn);
    } // End of the function
} // End of Class

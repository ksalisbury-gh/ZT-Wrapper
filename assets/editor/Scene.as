class Scene
{
    var actee, actor, clip, location, prop, text, index, dur, startTime, frameOffset, __get__duration, __set__duration;
    static var timeline, api;
    function Scene(actee, actor, clip, location, prop, text, index, duration)
    {
        this.actee = actee;
        this.actor = actor;
        this.clip = clip;
        this.location = location;
        this.prop = prop;
        this.text = text;
        if (!this.text)
        {
            this.text = new Object();
        } // end if
        this.index = index;
        dur = duration;
    } // End of the function
    function updateIndex(i)
    {
        index = i;
    } // End of the function
    function updateStartTime(t)
    {
        startTime = t;
    } // End of the function
    function updateFrameOffset(f)
    {
        frameOffset = f;
    } // End of the function
    function get duration()
    {
        if (actor == "starter" && Scene.timeline.getLastScene() == this)
        {
            return (Scene.api.getDuration(clip) + 4);
        }
        else
        {
            return (dur);
        } // end else if
    } // End of the function
    function set duration(seconds)
    {
        dur = seconds;
        //return (this.duration());
        null;
    } // End of the function
    function writeText(textId, textContent)
    {
        text[textId] = textContent;
    } // End of the function
    function toString()
    {
        var _loc3 = "\t";
        var _loc2 = "";
        _loc2 = _loc2 + "Scene: {\r";
        if (actee != undefined)
        {
            _loc2 = _loc2 + (_loc3 + "actee: " + actee + "\n");
        } // end if
        if (actor != undefined)
        {
            _loc2 = _loc2 + (_loc3 + "actor: " + actor + "\n");
        } // end if
        if (clip != undefined)
        {
            _loc2 = _loc2 + (_loc3 + "clip: " + clip + "\n");
        } // end if
        if (location != undefined)
        {
            _loc2 = _loc2 + (_loc3 + "location: " + location + "\n");
        } // end if
        if (prop != undefined)
        {
            _loc2 = _loc2 + (_loc3 + "prop: " + prop + "\n");
        } // end if
        if (text != undefined && text.length)
        {
            _loc2 = _loc2 + (_loc3 + "text: " + text + "\n");
        } // end if
        if (index != undefined)
        {
            _loc2 = _loc2 + (_loc3 + "index: " + index + "\n");
        } // end if
        _loc2 = _loc2 + "};";
        return (_loc2);
    } // End of the function
} // End of Class

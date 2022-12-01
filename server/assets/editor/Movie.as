class Movie extends XML
{
    var ignoreWhite, firstChild, parseXML, createElement, createTextNode;
    static var api;
    function Movie(xml)
    {
        super(xml);
        ignoreWhite = true;
    } // End of the function
    function getScenes()
    {
        var _loc9 = new Array();
        var _loc3 = firstChild.childNodes.slice(0);
        if (_loc3.length > 0)
        {
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                var _loc4 = new Scene();
                if (_loc3[_loc2].attributes.actee)
                {
                    _loc4.actee = unescape(_loc3[_loc2].attributes.actee);
                } // end if
                if (_loc3[_loc2].attributes.actor)
                {
                    _loc4.actor = unescape(_loc3[_loc2].attributes.actor);
                } // end if
                if (_loc3[_loc2].attributes.clip)
                {
                    _loc4.clip = unescape(_loc3[_loc2].attributes.clip);
                } // end if
                if (_loc3[_loc2].attributes.location)
                {
                    _loc4.location = unescape(_loc3[_loc2].attributes.location);
                } // end if
                if (_loc3[_loc2].attributes.prop)
                {
                    _loc4.prop = unescape(_loc3[_loc2].attributes.prop);
                } // end if
                if (_loc3[_loc2].childNodes.length > 0)
                {
                    for (var _loc6 = 0; _loc6 < _loc3[_loc2].childNodes.length; ++_loc6)
                    {
                        var _loc5 = _loc3[_loc2].childNodes[_loc6];
                        switch (_loc5.nodeName)
                        {
                            case "text":
                            {
                                if (!_loc4.text)
                                {
                                    _loc4.text = new Object();
                                } // end if
                                var _loc7 = _loc5.firstChild.nodeValue;
                                if (_loc7)
                                {
                                    _loc4.text[unescape(_loc5.attributes.id)] = unescape(_loc7);
                                } // end if
                                break;
                            } 
                        } // End of switch
                    } // end of for
                } // end if
                if (_loc3[_loc2].attributes.duration)
                {
                    _loc4.duration = int(_loc3[_loc2].attributes.duration);
                } // end if
                var _loc8 = int(_loc3[_loc2].attributes.index);
                _loc9[_loc8] = _loc4;
            } // end of for
        } // end if
        return (_loc9);
    } // End of the function
    function getVersion()
    {
        if (firstChild.attributes.version != undefined)
        {
            return (int(firstChild.attributes.version));
        } // end if
    } // End of the function
    function setScenes(scenes)
    {
        this.parseXML("<movie></movie>");
        this.setVersion(Movie.api.getVersion());
        for (var _loc6 = 0; _loc6 < scenes.length; ++_loc6)
        {
            var _loc2 = scenes[_loc6];
            var _loc3 = this.createElement("scene");
            _loc3.attributes.clip = _loc2.clip;
            _loc3.attributes.index = _loc6;
            if (_loc2.actee != undefined)
            {
                _loc3.attributes.actee = _loc2.actee;
            } // end if
            if (_loc2.actor != undefined)
            {
                _loc3.attributes.actor = _loc2.actor;
            } // end if
            if (_loc2.location != undefined)
            {
                _loc3.attributes.location = _loc2.location;
            } // end if
            if (_loc2.prop != undefined)
            {
                _loc3.attributes.prop = _loc2.prop;
            } // end if
            if (_loc2.text != undefined)
            {
                for (var _loc8 in _loc2.text)
                {
                    var _loc5 = escape(_loc2.text[_loc8]);
                    var _loc4 = this.createElement("text");
                    _loc4.appendChild(this.createTextNode(_loc5));
                    _loc4.attributes.id = _loc8;
                    _loc3.appendChild(_loc4);
                } // end of for...in
            } // end if
            _loc3.attributes.duration = _loc2.duration;
            firstChild.appendChild(_loc3);
        } // end of for
    } // End of the function
    function setVersion(n)
    {
        if (n != undefined)
        {
            firstChild.attributes.version = int(n);
        } // end if
    } // End of the function
    function quicksort(nodes, compare)
    {
        var qsort = function (a, l, r)
        {
            var _loc2 = l;
            var _loc1 = r;
            var _loc5;
            var _loc4 = a[int((l + r) / 2)];
            do
            {
                if (compare(a[_loc2], _loc4))
                {
                    ++_loc2;
                    continue;
                } // end if
                while (compare(_loc4, a[_loc1]))
                {
                    --_loc1;
                } // end while
                if (_loc2 <= _loc1)
                {
                    _loc5 = a[_loc2];
                    a[_loc2++] = a[_loc1];
                    a[_loc1--] = _loc5;
                } // end if
            } while (_loc2 <= _loc1)
            if (l < _loc1)
            {
                qsort(a, l, _loc1);
            } // end if
            if (_loc2 < r)
            {
                qsort(a, _loc2, r);
            } // end if
        };
        qsort(nodes, 0, nodes.length - 1);
    } // End of the function
    function byIndex(a, b)
    {
        return (int(a.attributes.index) > int(b.attributes.index));
    } // End of the function
    var xmlDecl = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
    var contentType = "text/xml;charset=utf-8";
} // End of Class

class Api extends XML
{
    var ignoreWhite, parseXML, status, firstChild, categoriesByIndex, clipsByIndex, acteesByIndex, actorsByIndex, locationsByIndex, propsByIndex, acteesById, actorsById, locationsById, propsById, categoriesById, clipsByCategory, propertiesById, version, timelineLength, loaded;
    function Api(src)
    {
        super();
        ignoreWhite = true;
        this.init(src);
    } // End of the function
    function init(src)
    {
        this.parseXML(src);
        if (status != 0)
        {
            return (false);
        } // end if
        if (firstChild.nodeName.toLowerCase() != "api")
        {
            return (false);
        } // end if
        categoriesByIndex = new Array();
        clipsByIndex = new Array();
        acteesByIndex = new Array();
        actorsByIndex = new Array();
        locationsByIndex = new Array();
        propsByIndex = new Array();
        acteesById = new Object();
        actorsById = new Object();
        locationsById = new Object();
        propsById = new Object();
        categoriesById = new Object();
        clipsByCategory = new Object();
        propertiesById = new Object();
        version = int(firstChild.attributes.version);
        timelineLength = int(firstChild.attributes.timelineLength);
        if (!timelineLength)
        {
            timelineLength = 60;
        } // end if
        var _loc3 = firstChild.childNodes;
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            switch (_loc3[_loc2].nodeName)
            {
                case "actee":
                {
                    this.addActee(_loc3[_loc2]);
                    break;
                } 
                case "actor":
                {
                    this.addActor(_loc3[_loc2]);
                    break;
                } 
                case "category":
                {
                    this.addCategory(_loc3[_loc2]);
                    break;
                } 
                case "clip":
                {
                    this.addClip(_loc3[_loc2]);
                    break;
                } 
                case "location":
                {
                    this.addLocation(_loc3[_loc2]);
                    break;
                } 
                case "prop":
                {
                    this.addProp(_loc3[_loc2]);
                    break;
                } 
            } // End of switch
        } // end of for
        return (true);
    } // End of the function
    function onData(src)
    {
        loaded = this.init(src);
        this.onLoad(loaded);
    } // End of the function
    function onLoad(success)
    {
    } // End of the function
    function getTimelineLength()
    {
        return (timelineLength);
    } // End of the function
    function addActee(node)
    {
        acteesByIndex.push(unescape(node.attributes.id));
    } // End of the function
    function addActor(node)
    {
        actorsByIndex.push(unescape(node.attributes.id));
    } // End of the function
    function addCategory(node)
    {
        var _loc4 = unescape(node.attributes.id);
        categoriesByIndex.push(_loc4);
        clipsByCategory[_loc4] = new Array();
        for (var _loc2 = 0; _loc2 < node.childNodes.length; ++_loc2)
        {
            var _loc3 = unescape(node.childNodes[_loc2].attributes.id);
            clipsByCategory[_loc4].push(_loc3);
            categoriesById[_loc3] = _loc4;
        } // end of for
        this.quicksort(clipsByCategory[_loc4], alphabeticalCompare);
    } // End of the function
    function addClip(node)
    {
        var _loc2 = unescape(node.attributes.id);
        clipsByIndex.push(_loc2);
        acteesById[_loc2] = new Object();
        actorsById[_loc2] = new Object();
        locationsById[_loc2] = new Object();
        propsById[_loc2] = new Object();
        propertiesById[_loc2] = node;
    } // End of the function
    function addLocation(node)
    {
        locationsByIndex.push(unescape(node.attributes.id));
    } // End of the function
    function addProp(node)
    {
        propsByIndex.push(unescape(node.attributes.id));
    } // End of the function
    function quicksort(list, compare)
    {
        var _loc5 = function (a, l, r)
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
                list(a, l, _loc1);
            } // end if
            if (_loc2 < r)
            {
                list(a, _loc2, r);
            } // end if
        };
        _loc5(list, 0, list.length - 1);
    } // End of the function
    function alphabeticalCompare(a, b)
    {
        return (a.toUpperCase() < b.toUpperCase());
    } // End of the function
    function getActees(id, actor)
    {
        var _loc3 = this.getPropertiesById(id).actees.slice(0);
        if (actor)
        {
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                if (_loc3[_loc2].indexOf(actor) != -1)
                {
                    _loc3.splice(_loc2--, 1);
                } // end if
            } // end of for
        } // end if
        return (_loc3);
    } // End of the function
    function getActors(id)
    {
        return (this.getPropertiesById(id).actors.slice(0));
    } // End of the function
    function getCategory(id)
    {
        return (categoriesById[id]);
    } // End of the function
    function getCategories()
    {
        return (categoriesByIndex.slice(0));
    } // End of the function
    function getClipsByCategory(categoryId)
    {
        return (clipsByCategory[categoryId].slice(0));
    } // End of the function
    function getClips()
    {
        return (clipsByIndex.slice(0));
    } // End of the function
    function getDuration(id)
    {
        return (this.getPropertiesById(id).duration);
    } // End of the function
    function getFileName(id)
    {
        return (id + ".swf");
    } // End of the function
    function getLocations(id)
    {
        return (this.getPropertiesById(id).locations.slice(0));
    } // End of the function
    function getProperties(scene)
    {
        return ({actees: this.getActees(scene.clip, scene.actor), actors: this.getActors(scene.clip), categories: this.getCategories(scene.clip), duration: this.getDuration(scene.clip), filename: this.getFileName(scene.clip), locations: this.getLocations(scene.clip), props: this.getProps(scene.clip), texts: this.getTexts(scene.clip)});
    } // End of the function
    function getPropertiesById(id)
    {
        if (propertiesById[id] instanceof XMLNode)
        {
            var _loc7 = propertiesById[id];
            var _loc2 = {id: unescape(_loc7.attributes.id), duration: Number(_loc7.attributes.duration), jointActors: Boolean(_loc7.attributes.joint)};
            var _loc5 = _loc7.childNodes;
            for (var _loc3 = 0; _loc3 < _loc5.length; ++_loc3)
            {
                switch (_loc5[_loc3].nodeName)
                {
                    case "actor":
                    {
                        if (!_loc2.actors)
                        {
                            _loc2.actors = new Array();
                        } // end if
                        _loc2.actors.push(unescape(_loc5[_loc3].attributes.id));
                        actorsById[id][unescape(_loc5[_loc3].attributes.id)] = true;
                        break;
                    } 
                    case "actee":
                    {
                        if (!_loc2.actees)
                        {
                            _loc2.actees = new Array();
                        } // end if
                        _loc2.actees.push(unescape(_loc5[_loc3].attributes.id));
                        acteesById[id][unescape(_loc5[_loc3].attributes.id)] = true;
                        break;
                    } 
                    case "category":
                    {
                        if (!_loc2.categories)
                        {
                            _loc2.categories = new Array();
                        } // end if
                        _loc2.categories.push(unescape(_loc5[_loc3].attributes.id));
                        break;
                    } 
                    case "location":
                    {
                        if (!_loc2.locations)
                        {
                            _loc2.locations = new Array();
                        } // end if
                        _loc2.locations.push(unescape(_loc5[_loc3].attributes.id));
                        locationsById[id][unescape(_loc5[_loc3].attributes.id)] = true;
                        break;
                    } 
                    case "prop":
                    {
                        if (!_loc2.props)
                        {
                            _loc2.props = new Array();
                        } // end if
                        _loc2.props.push(unescape(_loc5[_loc3].attributes.id));
                        propsById[id][unescape(_loc5[_loc3].attributes.id)] = true;
                        break;
                    } 
                    case "default-actors":
                    {
                        _loc2.actors = actorsByIndex;
                        for (var _loc6 = 0; _loc6 < actorsByIndex.length; ++_loc6)
                        {
                            actorsById[id][actorsByIndex[_loc6]] = true;
                        } // end of for
                        break;
                    } 
                    case "default-actees":
                    {
                        _loc2.actees = acteesByIndex;
                        for (var _loc6 = 0; _loc6 < acteesByIndex.length; ++_loc6)
                        {
                            acteesById[id][acteesByIndex[_loc6]] = true;
                        } // end of for
                        break;
                    } 
                    case "default-locations":
                    {
                        _loc2.locations = locationsByIndex;
                        for (var _loc6 = 0; _loc6 < locationsByIndex.length; ++_loc6)
                        {
                            locationsById[id][locationsByIndex[_loc6]] = true;
                        } // end of for
                        break;
                    } 
                    case "default-props":
                    {
                        _loc2.props = propsByIndex;
                        for (var _loc6 = 0; _loc6 < propsByIndex.length; ++_loc6)
                        {
                            propsById[id][propsByIndex[_loc6]] = true;
                        } // end of for
                        break;
                    } 
                    case "text":
                    {
                        if (!_loc2.texts)
                        {
                            _loc2.texts = new Array();
                        } // end if
                        _loc2.texts.push(unescape(_loc5[_loc3].attributes.id));
                        break;
                    } 
                } // End of switch
            } // end of for
            propertiesById[id] = _loc2;
        } // end if
        return (propertiesById[id]);
    } // End of the function
    function getProps(id)
    {
        return (this.getPropertiesById(id).props.slice(0));
    } // End of the function
    function getTexts(id)
    {
        return (this.getPropertiesById(id).texts);
    } // End of the function
    function getVersion()
    {
        return (version);
    } // End of the function
    function isAllowedActee(id, actee)
    {
        return (acteesById[id][actee]);
    } // End of the function
    function isAllowedActor(id, actor)
    {
        return (actorsById[id][actor]);
    } // End of the function
    function isAllowedLocation(id, location)
    {
        return (locationsById[id][location]);
    } // End of the function
    function isAllowedProp(id, prop)
    {
        return (propsById[id][prop]);
    } // End of the function
    function hasJointActors(scene)
    {
        if (typeof(scene) == "string")
        {
            scene = {clip: scene};
        } // end if
        return (this.getPropertiesById(scene.clip).jointActors);
    } // End of the function
    function getLinkage(param, scene)
    {
        var _loc2 = param + "_" + scene[param];
        if (this.hasJointActors(scene))
        {
            _loc2 = "actor_" + scene.actor + "_" + scene.actee;
        } // end if
        return (_loc2);
    } // End of the function
} // End of Class

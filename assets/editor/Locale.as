class Locale
{
    var lang, actor, verb, location, actee, prop, holding;
    function Locale(lang)
    {
        this.lang = lang;
    } // End of the function
    function getActee(scene)
    {
        switch (lang)
        {
            case "fr":
            {
                return (this.getActeeFr(scene));
            } 
        } // End of switch
        return (this.getActeeEn(scene));
    } // End of the function
    function getActor(scene)
    {
        switch (lang)
        {
            case "fr":
            {
                return (this.getActorFr(scene));
            } 
        } // End of switch
        return (this.getActorEn(scene));
    } // End of the function
    function getLabel(id)
    {
        if (id instanceof Scene)
        {
            id = id.clip;
        } // end if
        switch (lang)
        {
            case "fr":
            {
                return (this.getLabelFr(id));
            } 
        } // End of switch
        return (this.getLabelEn(id));
    } // End of the function
    function getLocation(scene)
    {
        switch (lang)
        {
            case "fr":
            {
                return (this.getLocationFr(scene));
            } 
        } // End of switch
        return (this.getLocationEn(scene));
    } // End of the function
    function getProp(scene)
    {
        switch (lang)
        {
            case "fr":
            {
                return (this.getPropFr(scene));
            } 
        } // End of switch
        return (this.getPropEn(scene));
    } // End of the function
    function getHolding(scene)
    {
        switch (lang)
        {
            case "fr":
            {
                return (this.getHoldingFr(scene));
            } 
        } // End of switch
        return ("holding");
    } // End of the function
    function getSentence(scene)
    {
        var _loc2 = {actee: this.getActee(scene), actor: this.getActor(scene), location: this.getLocation(scene), prop: this.getProp(scene), verb: this.getVerb(scene), holding: this.getHolding(scene)};
        switch (scene.clip)
        {
            case "finds":
            case "gives":
            case "drops":
            case "examines":
            case "throws":
            {
                _loc2.toString = toStringFunctions[1];
                break;
            } 
            case "steals":
            case "plays":
            {
                _loc2.toString = toStringFunctions[2];
                break;
            } 
            case "panics":
            case "sleep_walks":
            {
                if (lang == "fr")
                {
                    _loc2.toString = toStringFunctions[4];
                }
                else
                {
                    _loc2.toString = toStringFunctions[0];
                } // end else if
                break;
            } 
            case "blimp":
            case "boom":
            case "card":
            case "cellphone":
            case "changing_channels":
            case "clapboard":
            case "computer":
            case "clock":
            case "crash":
            case "crowd":
            case "crystalball":
            case "cookie":
            case "earlier":
            case "idolbase":
            case "later":
            case "map":
            case "meanwhile":
            case "newspaper":
            case "notepad":
            case "package":
            case "poster":
            case "sandwich":
            case "textcard1":
            case "textcard2":
            case "textcard3":
            case "ticket":
            case "tv":
            case "topsecret":
            case "zimmercircles":
            {
                _loc2.toString = toStringFunctions[3];
                break;
            } 
            case "teleports_out":
            {
                _loc2.toString = toStringFunctions[5];
                break;
            } 
            default:
            {
                _loc2.toString = toStringFunctions[0];
                break;
            } 
        } // End of switch
        return (_loc2);
    } // End of the function
    function getVerb(scene)
    {
        switch (lang)
        {
            case "fr":
            {
                return (this.getVerbFr(scene));
            } 
        } // End of switch
        return (this.getVerbEn(scene));
    } // End of the function
    function translateForMenu(param, id)
    {
        switch (lang)
        {
            case "fr":
            {
                return (this.translateForMenuFr(param, id));
            } 
        } // End of switch
        return (this.translateForMenuEn(param, id));
    } // End of the function
    function getActeeEn(scene)
    {
        switch (scene.clip)
        {
            case "steals":
            {
                switch (scene.actee)
                {
                    case "edgar":
                    {
                        return ("from Edgar");
                    } 
                    case "eva":
                    {
                        return ("from Eva");
                    } 
                    case "thirteen":
                    {
                        return ("from 13");
                    } 
                    case "annoys":
                    case "begs":
                    case "discovers":
                    case "gives":
                    case "fetches":
                    case "hugs":
                    case "meets":
                    case "chases":
                } // End of switch
            } 
            case "leaves":
            {
                if (scene.actee !== "none")
                {
                    break;
                } // end if
                return ("nobody");
                return ("Edgar");
                return ("Eva");
                return ("13");
                return ("Edgar and Eva");
                return ("Edgar and 13");
                return ("Eva and 13");
            } 
        } // End of switch
        switch (scene.actee)
        {
            case "none":
            {
                return ("alone");
            } 
            case "edgar":
            {
                return ("with Edgar");
            } 
            case "eva":
            {
                return ("with Eva");
            } 
            case "thirteen":
            {
                return ("with 13");
            } 
            case "edgar_eva":
            {
                return ("with Edgar and Eva");
            } 
            case "edgar_thirteen":
            {
                return ("with Edgar and 13");
            } 
            case "eva_thirteen":
            {
                return ("with Eva and 13");
            } 
        } // End of switch
    } // End of the function
    function getActorEn(scene)
    {
        switch (scene.clip)
        {
            case "mmepsycho":
            {
                switch (scene.actor)
                {
                    case "edgar":
                    {
                        return ("Mme Psycho");
                    } 
                } // End of switch
            } 
            case "wizard":
            {
                switch (scene.actor)
                {
                    case "edgar":
                    {
                        return ("Wizard");
                    } 
                } // End of switch
            } 
            case "deliveryboy":
            {
                if (scene.actor !== "edgar")
                {
                    break;
                } // end if
                return ("Delivery Boy");
            } 
        } // End of switch
        switch (scene.actor)
        {
            case "edgar":
            {
                return ("Edgar");
            } 
            case "eva":
            {
                return ("Eva");
            } 
            case "thirteen":
            {
                return ("13");
            } 
        } // End of switch
    } // End of the function
    function getPropEn(scene)
    {
        switch (scene.prop)
        {
            case "none":
            {
                return ("nothing");
            } 
            case "camera":
            {
                return ("a video camera");
            } 
            case "stinky_sack":
            {
                return ("a stinky sack");
            } 
            case "potion":
            {
                return ("a potion");
            } 
            case "trophy":
            {
                return ("a trophy");
            } 
            case "present":
            {
                return ("a present");
            } 
            case "crystal":
            {
                return ("a crystal");
            } 
            case "mystery_box":
            {
                return ("a mystery box");
            } 
            case "bunny":
            {
                return ("a bunny");
            } 
            case "book":
            {
                return ("a book");
            } 
            case "helmet":
            {
                return ("a helmet");
            } 
            case "flowers":
            {
                return ("flowers");
            } 
            case "idol":
            {
                return ("an idol");
            } 
            case "letter":
            {
                return ("a letter");
            } 
            case "card":
            {
                return ("a card");
            } 
            case "map":
            {
                return ("a map");
            } 
            case "newspaper":
            {
                return ("a newspaper");
            } 
        } // End of switch
    } // End of the function
    function getLocationEn(scene)
    {
        var _loc1;
        switch (scene.location)
        {
            case "alley":
            {
                _loc1 = "in the alley";
                break;
            } 
            case "backyard":
            {
                _loc1 = "in the backyard";
                break;
            } 
            case "backstage":
            {
                _loc1 = "backstage";
                break;
            } 
            case "cave":
            {
                _loc1 = "in the cave";
                break;
            } 
            case "desert":
            {
                _loc1 = "in the desert";
                break;
            } 
            case "edgar_bedroom":
            {
                _loc1 = "in Edgar\'s bedroom";
                break;
            } 
            case "eva_bedroom":
            {
                _loc1 = "in Eva\'s bedroom";
                break;
            } 
            case "forest":
            {
                _loc1 = "in the forest";
                break;
            } 
            case "kitchen":
            {
                _loc1 = "in the kitchen";
                break;
            } 
            case "living_room":
            {
                _loc1 = "in the living room";
                break;
            } 
            case "museum":
            {
                _loc1 = "in the museum";
                break;
            } 
            case "outerspace":
            {
                _loc1 = "in outerspace";
                break;
            } 
            case "park":
            {
                _loc1 = "in the park";
                break;
            } 
            case "planet":
            {
                _loc1 = "on Zimbiru";
                break;
            } 
            case "restaurant":
            {
                _loc1 = "in the Chinese restaurant";
                break;
            } 
            case "salon":
            {
                _loc1 = "in the Psychic Salon";
                break;
            } 
            case "seventeenth_parallel":
            {
                _loc1 = "in the 17th parallel";
                break;
            } 
            case "sky":
            {
                _loc1 = "in the sky";
                break;
            } 
            case "stage":
            {
                _loc1 = "on the stage";
                break;
            } 
            case "store":
            {
                _loc1 = "in the Occult-o-mart";
                break;
            } 
            case "street":
            {
                _loc1 = "on the street";
                break;
            } 
            case "thirteenth_dimension":
            {
                _loc1 = "in the 13th dimension";
                break;
            } 
            case "jungle":
            {
                _loc1 = "in the jungle";
                break;
            } 
        } // End of switch
        switch (scene.clip)
        {
            case "teleports":
            {
                var _loc4 = _loc1.indexOf(" ");
                var _loc3;
                switch (scene.location)
                {
                    case "stage":
                    case "street":
                    {
                        _loc3 = "onto";
                        break;
                    } 
                    case "backstage":
                    {
                        _loc3 = "";
                        break;
                    } 
                    default:
                    {
                        _loc3 = "into";
                        break;
                    } 
                } // End of switch
                _loc1 = _loc3 + _loc1.substring(_loc4, _loc1.length);
                break;
            } 
            case "teleports_out":
            {
                _loc4 = _loc1.indexOf(" ");
                switch (scene.location)
                {
                    case "backstage":
                    {
                        _loc3 = "of ";
                        break;
                    } 
                    default:
                    {
                        _loc3 = "of";
                        break;
                    } 
                } // End of switch
                _loc1 = _loc3 + _loc1.substring(_loc4, _loc1.length);
                break;
            } 
            default:
            {
                break;
            } 
        } // End of switch
        return (_loc1);
    } // End of the function
    function getVerbEn(scene)
    {
        var _loc4;
        switch (scene.clip)
        {
            case "reads_aloud":
            case "reads2":
            {
                return ("reads aloud");
            } 
            case "crowd_surfs":
            {
                return ("crowd surfs");
            } 
            case "ride_wagon":
            {
                return ("rides a wagon");
            } 
            case "rocks":
            {
                return ("rocks out");
            } 
            case "plugs_ears":
            {
                var _loc2 = "his";
                if (this.getActorEn(scene) == "Eva")
                {
                    _loc2 = "her";
                } // end if
                return ("plugs " + _loc2 + " ears");
            } 
            case "wakes":
            {
                return ("wakes up");
            } 
            case "tease":
            {
                return ("teases");
            } 
            case "plays":
            {
                return ("plays with");
            } 
            case "angry":
            case "bored":
            case "confused":
            case "dizzy":
            case "happy":
            case "impressed":
            case "relieved":
            case "scared":
            case "surprised":
            case "suspicious":
            {
                return ("is " + scene.clip);
            } 
            case "talks2":
            case "talks3":
            case "talks4":
            {
                return ("talks");
            } 
            case "mmepsycho":
            {
                return ("Mme Psycho talks");
            } 
            case "deliveryboy":
            {
                return ("Delivery Boy talks");
            } 
            case "wizard":
            {
                return ("Wizard talks");
            } 
            case "alien":
            {
                return ("Alien talks");
            } 
            case "waitress":
            {
                return ("Waitress talks");
            } 
            case "sleep_walks":
            {
                return ("sleep walks");
            } 
            case "yells2":
            {
                return ("yells");
            } 
            case "dances2":
            {
                return ("dances");
            } 
            case "cellphone_call":
            {
                return ("talks on the phone");
            } 
            case "calls":
            {
                return ("makes a call");
            } 
            case "karatechop":
            {
                return ("karate-chops");
            } 
            case "teleports_out":
            {
                return ("teleports out");
            } 
            case "uses_computer":
            {
                return ("uses the computer");
            } 
            case "watches_tv":
            {
                return ("watches TV");
            } 
            case "admires":
            {
                return ("admires something");
            } 
            case "cooking":
            {
                return ("cooks");
            } 
            case "crying":
            {
                return ("cries");
            } 
            case "blimp":
            {
                return ("Blimp");
            } 
            case "boom":
            {
                return ("Boom");
            } 
            case "card":
            {
                return ("Card");
            } 
            case "cellphone":
            {
                return ("Cell Phone");
            } 
            case "changing_channels":
            {
                return ("TV");
            } 
            case "clapboard":
            {
                return ("Clapboard");
            } 
            case "clock":
            {
                return ("Clock");
            } 
            case "computer":
            {
                return ("Computer");
            } 
            case "crash":
            {
                return ("Crash");
            } 
            case "crowd":
            {
                return ("Crowd");
            } 
            case "crystalball":
            {
                return ("Crystal Ball");
            } 
            case "cookie":
            {
                return ("Fortune Cookie");
            } 
            case "earlier":
            {
                return ("Earlier");
            } 
            case "idolbase":
            {
                return ("Idol");
            } 
            case "later":
            {
                return ("Later");
            } 
            case "map":
            {
                return ("Map");
            } 
            case "meanwhile":
            {
                return ("Meanwhile");
            } 
            case "newspaper":
            {
                return ("Newspaper");
            } 
            case "notepad":
            {
                return ("Notepad");
            } 
            case "package":
            {
                return ("Package");
            } 
            case "poster":
            {
                return ("Poster");
            } 
            case "sandwich":
            {
                return ("Sandwich Board");
            } 
            case "textcard1":
            case "textcard2":
            case "textcard3":
            {
                return ("Text");
            } 
            case "ticket":
            {
                return ("Ticket");
            } 
            case "topsecret":
            {
                return ("Top Secret Document");
            } 
            case "tv":
            {
                return ("Television");
            } 
            case "zimmercircles":
            {
                return ("Zimmercircles");
            } 
        } // End of switch
        return (scene.clip);
        return (_loc4);
    } // End of the function
    function getLabelEn(id)
    {
        switch (id)
        {
            case "reads_aloud":
            case "reads2":
            {
                return ("Reads Aloud");
            } 
            case "crowd_surfs":
            {
                return ("Crowd Surfs");
            } 
            case "cooking":
            {
                return ("Cooks");
            } 
            case "ride_wagon":
            {
                return ("Rides Wagon");
            } 
            case "plugs_ears":
            {
                return ("Plugs Ears");
            } 
            case "cookie":
            {
                return ("Fortune");
            } 
            case "changing_channels":
            {
                return ("TV");
            } 
            case "crystalball":
            {
                return ("Crystal Ball");
            } 
            case "deliveryboy":
            {
                return ("Delivery Boy");
            } 
            case "mmepsycho":
            {
                return ("Mme Psycho");
            } 
            case "uses_computer":
            {
                return ("Uses Computer");
            } 
            case "crying":
            {
                return ("Cries");
            } 
            case "textcard1":
            case "textcard2":
            case "textcard3":
            {
                return ("Text");
            } 
            case "sandwich":
            {
                return ("Board");
            } 
            case "idolbase":
            {
                return ("Idol");
            } 
            case "topsecret":
            {
                return ("Top Secret");
            } 
            case "talks2":
            case "talks3":
            case "talks4":
            {
                return ("Talks");
            } 
            case "sleep_walks":
            {
                return ("Sleep Walks");
            } 
            case "yells2":
            {
                return ("Yells");
            } 
            case "dances2":
            {
                return ("Dances");
            } 
            case "karatechop":
            {
                return ("Karate-chop");
            } 
            case "cellphone_call":
            {
                return ("Cellphone");
            } 
            case "teleports_out":
            {
                return ("Teleports Out");
            } 
            case "watches_tv":
            {
                return ("Watches TV");
            } 
        } // End of switch
        return (id.charAt(0).toUpperCase() + id.substring(1, id.length));
    } // End of the function
    function translateForMenuEn(param, id, scene)
    {
        switch (param)
        {
            case "actor":
            {
                switch (id)
                {
                    case "edgar":
                    case "edgar_eva":
                    case "edgar_thirteen":
                    {
                        return ("Edgar");
                    } 
                    case "eva":
                    case "eva_edgar":
                    case "eva_thirteen":
                    {
                        return ("Eva");
                    } 
                    case "thirteen":
                    case "thirteen_edgar":
                    case "thirteen_eva":
                    {
                        return ("13");
                    } 
                } // End of switch
            } 
            case "actee":
            {
                switch (id)
                {
                    case "none":
                    {
                        return ("Nobody");
                    } 
                    case "edgar":
                    {
                        return ("Edgar");
                    } 
                    case "eva":
                    {
                        return ("Eva");
                    } 
                    case "thirteen":
                    {
                        return ("13");
                    } 
                    case "edgar_eva":
                    {
                        return ("Edgar and Eva");
                    } 
                    case "edgar_thirteen":
                    {
                        return ("Edgar and 13");
                    } 
                    case "eva_thirteen":
                    {
                        return ("Eva and 13");
                    } 
                } // End of switch
            } 
            case "location":
            {
                switch (id)
                {
                    case "living_room":
                    {
                        return ("Living Room");
                    } 
                    case "edgar_bedroom":
                    {
                        return ("Edgar\'s Bedroom");
                    } 
                    case "eva_bedroom":
                    {
                        return ("Eva\'s Bedroom");
                    } 
                    case "planet":
                    {
                        return ("Zimbiru");
                    } 
                    case "restaurant":
                    {
                        return ("Chinese Restaurant");
                    } 
                    case "seventeenth_parallel":
                    {
                        return ("17th Parallel");
                    } 
                    case "thirteenth_dimension":
                    {
                        return ("13th Dimension");
                    } 
                    case "store":
                    {
                        return ("Occult-o-mart");
                    } 
                } // End of switch
                return (id.charAt(0).toUpperCase() + id.substring(1, id.length));
            } 
            case "prop":
            {
                switch (id)
                {
                    case "none":
                    {
                        return ("Nothing");
                    } 
                    case "camera":
                    {
                        return ("Video Camera");
                    } 
                    case "stinky_sack":
                    {
                        return ("Stinky Sack");
                    } 
                    case "mystery_box":
                    {
                        return ("Mystery Box");
                    } 
                } // End of switch
                return (id.charAt(0).toUpperCase() + id.substring(1, id.length));
            } 
        } // End of switch
    } // End of the function
    function getActeeFr(scene)
    {
        switch (scene.clip)
        {
            case "gives":
            case "steals":
            {
                switch (scene.actee)
                {
                    case "none":
                    {
                        return (".....");
                    } 
                    case "edgar":
                    {
                        return ("à Edgar");
                    } 
                    case "eva":
                    {
                        return ("à Éva");
                    } 
                    case "thirteen":
                    {
                        return ("à 13");
                    } 
                    case "edgar_eva":
                    {
                        return ("à Edgar et Éva");
                    } 
                    case "edgar_thirteen":
                    {
                        return ("à Edgar et 13");
                    } 
                    case "eva_thirteen":
                    {
                        return ("à Éva et 13");
                    } 
                    case "annoys":
                    case "begs":
                    case "discovers":
                    case "chases":
                    case "fetches":
                    case "hugs":
                    case "meets":
                } // End of switch
            } 
            case "leaves":
            {
                switch (scene.actee)
                {
                    case "none":
                    {
                        return (".....");
                    } 
                    case "edgar":
                    {
                        return ("Edgar");
                    } 
                    case "eva":
                    {
                        return ("Éva");
                    } 
                    case "thirteen":
                    {
                        return ("13");
                    } 
                    case "edgar_eva":
                    {
                        return ("Edgar et Éva");
                    } 
                    case "edgar_thirteen":
                    {
                        return ("Edgar et 13");
                    } 
                    case "eva_thirteen":
                    {
                        return ("Éva et 13");
                    } 
                    case "panics":
                } // End of switch
            } 
            case "sleep_walks":
            {
                switch (scene.actee)
                {
                    case "none":
                    {
                        return (".....");
                    } 
                    case "edgar":
                    {
                        return ("et Edgar");
                    } 
                    case "eva":
                    {
                        return ("et Éva");
                    } 
                    case "thirteen":
                    {
                        return ("et 13");
                    } 
                    case "edgar_eva":
                    {
                        return ("Edgar et Éva");
                    } 
                    case "edgar_thirteen":
                    {
                        return ("Edgar et 13");
                    } 
                    case "eva_thirteen":
                    {
                        return ("Éva et 13");
                    } 
                } // End of switch
            } 
            case "exercises":
            {
                if (scene.actee == "none")
                {
                    if (scene.actor == "eva")
                    {
                        return ("seule");
                    } // end if
                    return ("seul");
                } // end if
            } 
        } // End of switch
        switch (scene.actee)
        {
            case "none":
            {
                return (".....");
            } 
            case "edgar":
            {
                return ("avec Edgar");
            } 
            case "eva":
            {
                return ("avec Éva");
            } 
            case "thirteen":
            {
                return ("avec 13");
            } 
            case "edgar_eva":
            {
                return ("avec Edgar et Éva");
            } 
            case "edgar_thirteen":
            {
                return ("avec Edgar et 13");
            } 
            case "eva_thirteen":
            {
                return ("avec Éva et 13");
            } 
        } // End of switch
    } // End of the function
    function getActorFr(scene)
    {
        var _loc1 = "";
        switch (scene.actor)
        {
            case "edgar":
            {
                _loc1 = "Edgar";
                break;
            } 
            case "eva":
            {
                _loc1 = "Éva";
                break;
            } 
            case "thirteen":
            {
                _loc1 = "13";
                break;
            } 
        } // End of switch
        if (scene.clip == "panics" || scene.clip == "sleep_walks")
        {
            switch (scene.actee)
            {
                case "edgar_eva":
                case "edgar_thirteen":
                case "eva_thirteen":
                {
                    _loc1 = _loc1 + ",";
                } 
            } // End of switch
            
        } // end if
        return (_loc1);
    } // End of the function
    function getPropFr(scene)
    {
        switch (scene.prop)
        {
            case "none":
            {
                switch (scene.clip)
                {
                    case "steals":
                    case "gives":
                    case "finds":
                    case "drops":
                    case "plays":
                    case "ride_wagon":
                    case "throws":
                    {
                        return ("rien");
                    } 
                } // End of switch
                return ("les main vides");
            } 
            case "stinky_sack":
            {
                return ("un sac puant");
            } 
            case "camera":
            {
                return ("une caméra");
            } 
            case "potion":
            {
                return ("une potion");
            } 
            case "trophy":
            {
                return ("un trophée");
            } 
            case "present":
            {
                return ("un cadeau");
            } 
            case "crystal":
            {
                return ("un cristal");
            } 
            case "mystery_box":
            {
                return ("une boîte mystérieuse");
            } 
            case "bunny":
            {
                return ("un lapin");
            } 
            case "book":
            {
                return ("un livre");
            } 
            case "helmet":
            {
                return ("un casque");
            } 
            case "flowers":
            {
                return ("des fleurs");
            } 
            case "idol":
            {
                return ("une statuette");
            } 
            case "letter":
            {
                return ("une lettre");
            } 
            case "card":
            {
                return ("une carte de fête");
            } 
            case "map":
            {
                return ("une carte");
            } 
            case "newspaper":
            {
                return ("un journal");
            } 
        } // End of switch
    } // End of the function
    function getLocationFr(scene)
    {
        if (scene.clip == "teleports_out")
        {
            switch (scene.location)
            {
                case "alley":
                {
                    return ("de la ruelle");
                } 
                case "backstage":
                {
                    return ("des coulisses");
                } 
                case "backyard":
                {
                    return ("de la cour");
                } 
                case "cave":
                {
                    return ("de la caverne");
                } 
                case "desert":
                {
                    return ("du désert");
                } 
                case "forest":
                {
                    return ("de la forêt");
                } 
                case "living_room":
                {
                    return ("de la maison");
                } 
                case "museum":
                {
                    return ("du musée");
                } 
                case "outerspace":
                {
                    return ("de l\'espace");
                } 
                case "park":
                {
                    return ("du parc");
                } 
                case "restaurant":
                {
                    return ("du restaurant");
                } 
                case "salon":
                {
                    return ("de chez Mme Psycho");
                } 
                case "seventeenth_parallel":
                {
                    return ("du 17e parallèle");
                } 
                case "sky":
                {
                    return ("du ciel");
                } 
                case "stage":
                {
                    return ("de l\'estrade");
                } 
                case "store":
                {
                    return ("de l\'Occulte & cie");
                } 
                case "street":
                {
                    return ("du trottoir");
                } 
                case "thirteenth_dimension":
                {
                    return ("de la 13e dimension");
                } 
                case "jungle":
                {
                    return ("de la jungle");
                } 
            } // End of switch
        } // end if
        var _loc1;
        switch (scene.location)
        {
            case "alley":
            {
                _loc1 = "dans la ruelle";
                break;
            } 
            case "backstage":
            {
                _loc1 = "dans les coulisses";
                break;
            } 
            case "backyard":
            {
                _loc1 = "dans la cour";
                break;
            } 
            case "cave":
            {
                _loc1 = "dans la caverne";
                break;
            } 
            case "desert":
            {
                _loc1 = "dans le désert";
                break;
            } 
            case "forest":
            {
                _loc1 = "dans la forêt";
                break;
            } 
            case "living_room":
            {
                _loc1 = "dans la maison";
                break;
            } 
            case "museum":
            {
                _loc1 = "dans le musée";
                break;
            } 
            case "outerspace":
            {
                _loc1 = "dans l\'espace";
                break;
            } 
            case "park":
            {
                _loc1 = "dans le parc";
                break;
            } 
            case "restaurant":
            {
                _loc1 = "dans le restaurant";
                break;
            } 
            case "salon":
            {
                _loc1 = "chez Mme Psycho";
                break;
            } 
            case "seventeenth_parallel":
            {
                _loc1 = "dans le 17e parallèle";
                break;
            } 
            case "sky":
            {
                _loc1 = "dans le ciel";
                break;
            } 
            case "stage":
            {
                _loc1 = "sur l\'estrade";
                break;
            } 
            case "store":
            {
                _loc1 = "chez Occulte & cie";
                break;
            } 
            case "street":
            {
                _loc1 = "sur le trottoir";
                break;
            } 
            case "thirteenth_dimension":
            {
                _loc1 = "dans la 13e dimension";
                break;
            } 
            case "jungle":
            {
                _loc1 = "dans la jungle";
                break;
            } 
        } // End of switch
        return (_loc1);
    } // End of the function
    function getVerbFr(scene)
    {
        switch (scene.clip)
        {
            case "announces":
            {
                return ("proclame");
            } 
            case "begs":
            {
                return ("supplie");
            } 
            case "cellphone_call":
            {
                return ("téléphone");
            } 
            case "lectures":
            {
                return ("réprimande");
            } 
            case "reads_aloud":
            case "reads2":
            {
                return ("lit");
            } 
            case "reports":
            {
                return ("annonce");
            } 
            case "sings":
            {
                return ("chante");
            } 
            case "talks":
            case "talks2":
            case "talks3":
            case "talks4":
            {
                return ("parle");
            } 
            case "thinks":
            {
                return ("pense");
            } 
            case "whispers":
            {
                return ("chuchote");
            } 
            case "yells":
            case "yells2":
            {
                return ("crie");
            } 
            case "protests":
            {
                return ("proteste");
            } 
            case "admires":
            {
                return ("admire quelque chose");
            } 
            case "annoys":
            {
                return ("énerve");
            } 
            case "blushes":
            {
                return ("rougie");
            } 
            case "celebrates":
            {
                return ("célèbre");
            } 
            case "chases":
            {
                return ("poursuit");
            } 
            case "crowd_surfs":
            {
                return ("surf la foule");
            } 
            case "dances":
            case "dances2":
            {
                return ("danse");
            } 
            case "discovers":
            {
                return ("découvre");
            } 
            case "drops":
            {
                return ("jette");
            } 
            case "eats":
            {
                return ("mange");
            } 
            case "examines":
            {
                return ("examine");
            } 
            case "exercises":
            {
                if (scene.actor == "eva")
                {
                    return ("fait de l\'exercice");
                }
                else
                {
                    return ("fait de l\'exercice");
                } // end else if
            } 
            case "faints":
            {
                return ("s\'évanouie");
            } 
            case "falls":
            {
                return ("tombe");
            } 
            case "fetches":
            {
                return ("va chercher");
            } 
            case "films":
            {
                return ("filme");
            } 
            case "finds":
            {
                if (scene.prop == "none")
                {
                    return ("ne trouve");
                }
                else
                {
                    return ("trouve");
                } // end else if
            } 
            case "flies":
            {
                return ("plane");
            } 
            case "floats":
            {
                return ("flotte");
            } 
            case "gives":
            {
                if (scene.prop == "none")
                {
                    return ("ne donne");
                }
                else
                {
                    return ("donne");
                } // end else if
            } 
            case "hides":
            {
                return ("se cache");
            } 
            case "hugs":
            {
                return ("embrasse");
            } 
            case "karatechop":
            {
                return ("donne un coup de karaté");
            } 
            case "lands":
            {
                return ("atterri");
            } 
            case "laughs":
            {
                return ("ri");
            } 
            case "leaves":
            {
                return ("quitte");
            } 
            case "levitates":
            {
                return ("lévite");
            } 
            case "meets":
            {
                return ("rencontre");
            } 
            case "panics":
            {
                if (scene.actee == "none")
                {
                    return ("panique");
                }
                else
                {
                    return ("paniquent");
                } // end else if
            } 
            case "plays":
            {
                if (scene.prop == "none")
                {
                    return ("ne joue avec");
                }
                else
                {
                    return ("joue avec");
                } // end else if
            } 
            case "ride_wagon":
            {
                return ("fait un tour de chariot");
            } 
            case "rocks":
            {
                return ("tripe");
            } 
            case "runs":
            {
                return ("court");
            } 
            case "seeks":
            {
                return ("cherche");
            } 
            case "sits":
            {
                return ("s\'assoit");
            } 
            case "sneaks":
            {
                return ("fouine");
            } 
            case "sleeps":
            {
                return ("dort");
            } 
            case "sleep_walks":
            {
                if (scene.actee == "none")
                {
                    return ("est somnambule");
                }
                else
                {
                    return ("sont somnambules");
                } // end else if
            } 
            case "stands":
            {
                return ("se tient debout");
            } 
            case "steals":
            {
                if (scene.prop == "none")
                {
                    return ("ne vole");
                }
                else
                {
                    return ("vole");
                } // end else if
            } 
            case "struts":
            {
                return ("se pavane");
            } 
            case "teleports":
            {
                return ("se téléporte");
            } 
            case "teleports_out":
            {
                return ("se téléporte hors");
            } 
            case "throws":
            {
                if (scene.prop == "none")
                {
                    return ("ne lance");
                }
                else
                {
                    return ("lance");
                } // end else if
            } 
            case "wakes":
            {
                return ("se réveille");
            } 
            case "walks":
            {
                return ("marche");
            } 
            case "watches_tv":
            {
                return ("écoute la télé");
            } 
            case "agrees":
            {
                return ("est d\'accord");
            } 
            case "angry":
            {
                if (scene.actor == "eva")
                {
                    return ("est fâchée");
                }
                else
                {
                    return ("est fâché");
                } // end else if
            } 
            case "bored":
            {
                return ("s\'ennuie");
            } 
            case "calls":
            {
                return ("fait un appel");
            } 
            case "confused":
            {
                return ("est perplexe");
            } 
            case "disagrees":
            {
                return ("n\'est pas d\'accord");
            } 
            case "dizzy":
            {
                if (scene.actor == "eva")
                {
                    return ("est étourdie");
                } // end if
                return ("est étourdi");
            } 
            case "happy":
            {
                if (scene.actor == "eva")
                {
                    return ("est heureuse");
                }
                else
                {
                    return ("est heureux");
                } // end else if
            } 
            case "impressed":
            {
                if (scene.actor == "eva")
                {
                    return ("est impressionnée");
                } // end if
                return ("est impressionné");
            } 
            case "plots":
            {
                return ("complote");
            } 
            case "plugs_ears":
            {
                return ("se bouche les oreilles");
            } 
            case "preens":
            {
                return ("se pomponne");
            } 
            case "relieved":
            {
                if (scene.actor == "eva")
                {
                    return ("est soulagée");
                } // end if
                return ("est soulagé");
            } 
            case "scared":
            {
                return ("a peur");
            } 
            case "surprised":
            {
                if (scene.actor == "eva")
                {
                    return ("est surprise");
                } // end if
                return ("est surpris");
            } 
            case "suspicious":
            {
                if (scene.actor == "eva")
                {
                    return ("est douteuse");
                } // end if
                return ("est douteux");
            } 
            case "tease":
            {
                return ("taquine");
            } 
            case "writes":
            {
                return ("écrit");
            } 
            case "zimmerizes":
            {
                return ("zimmerise");
            } 
            case "blimp":
            {
                return ("Ballon");
            } 
            case "boom":
            {
                return ("Boum");
            } 
            case "card":
            {
                return ("Carte de fête");
            } 
            case "changing_channels":
            {
                return ("Télé");
            } 
            case "clapboard":
            {
                return ("Claquette");
            } 
            case "clock":
            {
                return ("Horloge");
            } 
            case "crash":
            {
                return ("Krach");
            } 
            case "crowd":
            {
                return ("Foule");
            } 
            case "crystalball":
            {
                return ("Boule de cristal");
            } 
            case "cookie":
            {
                return ("Message");
            } 
            case "earlier":
            {
                return ("Plus tôt");
            } 
            case "idolbase":
            {
                return ("Statuette");
            } 
            case "later":
            {
                return ("Plus tard");
            } 
            case "map":
            {
                return ("Carte");
            } 
            case "meanwhile":
            {
                return ("Pendant ce temps");
            } 
            case "newspaper":
            {
                return ("Journal");
            } 
            case "notepad":
            {
                return ("Bloc-notes");
            } 
            case "poster":
            {
                return ("Poster");
            } 
            case "sandwich":
            {
                return ("Affiche");
            } 
            case "textcard1":
            case "textcard2":
            case "textcard3":
            {
                return ("Texte");
            } 
            case "ticket":
            {
                return ("Billet");
            } 
            case "topsecret":
            {
                return ("Top secret");
            } 
            case "tv":
            {
                return ("Télé");
            } 
            case "zimmercircles":
            {
                return ("Zimmercercle");
            } 
        } // End of switch
    } // End of the function
    function getLabelFr(id)
    {
        switch (id)
        {
            case "announces":
            {
                return ("Proclame");
            } 
            case "begs":
            {
                return ("Supplie");
            } 
            case "cellphone_call":
            {
                return ("Téléphone");
            } 
            case "lectures":
            {
                return ("Réprimande");
            } 
            case "reads_aloud":
            case "reads2":
            {
                return ("Lit");
            } 
            case "reports":
            {
                return ("Annonce");
            } 
            case "sings":
            {
                return ("Chante");
            } 
            case "talks":
            case "talks2":
            case "talks3":
            case "talks4":
            {
                return ("Parle");
            } 
            case "thinks":
            {
                return ("Pense");
            } 
            case "whispers":
            {
                return ("Chuchote");
            } 
            case "yells":
            case "yells2":
            {
                return ("Crie");
            } 
            case "protests":
            {
                return ("Proteste");
            } 
            case "admires":
            {
                return ("Admire");
            } 
            case "annoys":
            {
                return ("Énerve");
            } 
            case "blushes":
            {
                return ("Rougie");
            } 
            case "celebrates":
            {
                return ("Célèbre");
            } 
            case "chases":
            {
                return ("Poursuit");
            } 
            case "crowd_surfs":
            {
                return ("Surf la foule");
            } 
            case "dances":
            case "dances2":
            {
                return ("Danse");
            } 
            case "discovers":
            {
                return ("Découvre");
            } 
            case "drops":
            {
                return ("Jette");
            } 
            case "eats":
            {
                return ("Mange");
            } 
            case "examines":
            {
                return ("Examine");
            } 
            case "exercises":
            {
                return ("Exercice");
            } 
            case "faints":
            {
                return ("S\'évanouie");
            } 
            case "falls":
            {
                return ("Tombe");
            } 
            case "fetches":
            {
                return ("Va chercher");
            } 
            case "films":
            {
                return ("Filme");
            } 
            case "finds":
            {
                return ("Trouve");
            } 
            case "flies":
            {
                return ("Plane");
            } 
            case "floats":
            {
                return ("Flotte");
            } 
            case "gives":
            {
                return ("Donne");
            } 
            case "hides":
            {
                return ("Cache");
            } 
            case "hugs":
            {
                return ("Embrasse");
            } 
            case "karatechop":
            {
                return ("Karaté");
            } 
            case "lands":
            {
                return ("Atterri");
            } 
            case "laughs":
            {
                return ("Ri");
            } 
            case "leaves":
            {
                return ("Quitte");
            } 
            case "levitates":
            {
                return ("Lévite");
            } 
            case "meets":
            {
                return ("Rencontre");
            } 
            case "plays":
            {
                return ("Joue");
            } 
            case "panics":
            {
                return ("Panique");
            } 
            case "ride_wagon":
            {
                return ("Chariot");
            } 
            case "rocks":
            {
                return ("Tripe");
            } 
            case "runs":
            {
                return ("Court");
            } 
            case "seeks":
            {
                return ("Cherche");
            } 
            case "sits":
            {
                return ("S\'assoit");
            } 
            case "sneaks":
            {
                return ("Fouine");
            } 
            case "sleeps":
            {
                return ("Dort");
            } 
            case "sleep_walks":
            {
                return ("Somnambule");
            } 
            case "stands":
            {
                return ("Debout");
            } 
            case "steals":
            {
                return ("Vole");
            } 
            case "struts":
            {
                return ("Se pavane");
            } 
            case "teleports":
            {
                return ("Téléporte");
            } 
            case "teleports_out":
            {
                return ("Téléporte");
            } 
            case "throws":
            {
                return ("Lance");
            } 
            case "wakes":
            {
                return ("Réveille");
            } 
            case "walks":
            {
                return ("Marche");
            } 
            case "watches_tv":
            {
                return ("Écoute la télé");
            } 
            case "agrees":
            {
                return ("Est d\'accord");
            } 
            case "angry":
            {
                return ("Fâché");
            } 
            case "bored":
            {
                return ("S\'ennuie");
            } 
            case "calls":
            {
                return ("Fait un appel");
            } 
            case "confused":
            {
                return ("Perplexe");
            } 
            case "disagrees":
            {
                return ("N\'est pas d\'accord");
            } 
            case "dizzy":
            {
                return ("Étourdi");
            } 
            case "happy":
            {
                return ("Heureux");
            } 
            case "impressed":
            {
                return ("Impressionné");
            } 
            case "plots":
            {
                return ("Complote");
            } 
            case "plugs_ears":
            {
                return ("Se bouche les oreilles");
            } 
            case "preens":
            {
                return ("Pomponne");
            } 
            case "relieved":
            {
                return ("Soulagé");
            } 
            case "scared":
            {
                return ("Peur");
            } 
            case "surprised":
            {
                return ("Surpris");
            } 
            case "suspicious":
            {
                return ("Douteux");
            } 
            case "tease":
            {
                return ("Taquine");
            } 
            case "writes":
            {
                return ("Écrit");
            } 
            case "zimmerizes":
            {
                return ("Zimmerise");
            } 
            case "blimp":
            {
                return ("Ballon");
            } 
            case "boom":
            {
                return ("Boum");
            } 
            case "card":
            {
                return ("Carte de fête");
            } 
            case "changing_channels":
            {
                return ("Télé");
            } 
            case "clapboard":
            {
                return ("Claquette");
            } 
            case "clock":
            {
                return ("Horloge");
            } 
            case "crash":
            {
                return ("Krach");
            } 
            case "crowd":
            {
                return ("Foule");
            } 
            case "crystalball":
            {
                return ("Boule de cristal");
            } 
            case "cookie":
            {
                return ("Message");
            } 
            case "earlier":
            {
                return ("Plus tôt");
            } 
            case "idolbase":
            {
                return ("Statuette");
            } 
            case "later":
            {
                return ("Plus tard");
            } 
            case "map":
            {
                return ("Carte");
            } 
            case "meanwhile":
            {
                return ("Pendant ce temps");
            } 
            case "newspaper":
            {
                return ("Journal");
            } 
            case "notepad":
            {
                return ("Bloc-notes");
            } 
            case "poster":
            {
                return ("Poster");
            } 
            case "sandwich":
            {
                return ("Affiche");
            } 
            case "textcard1":
            case "textcard2":
            case "textcard3":
            {
                return ("Texte");
            } 
            case "ticket":
            {
                return ("Billet");
            } 
            case "topsecret":
            {
                return ("Top secret");
            } 
            case "tv":
            {
                return ("Télé");
            } 
            case "zimmercircles":
            {
                return ("Zimmercercle");
            } 
        } // End of switch
    } // End of the function
    function translateForMenuFr(param, id)
    {
        switch (param)
        {
            case "actor":
            {
                switch (id)
                {
                    case "edgar":
                    case "edgar_eva":
                    case "edgar_thirteen":
                    {
                        return ("Edgar");
                    } 
                    case "eva":
                    case "eva_edgar":
                    case "eva_thirteen":
                    {
                        return ("Éva");
                    } 
                    case "thirteen":
                    case "thirteen_edgar":
                    case "thirteen_eva":
                    {
                        return ("13");
                    } 
                } // End of switch
            } 
            case "actee":
            {
                switch (id)
                {
                    case "none":
                    {
                        return (".....");
                    } 
                    case "edgar":
                    {
                        return ("Edgar");
                    } 
                    case "eva":
                    {
                        return ("Éva");
                    } 
                    case "thirteen":
                    {
                        return ("13");
                    } 
                    case "edgar_eva":
                    {
                        return ("Edgar et Éva");
                    } 
                    case "edgar_thirteen":
                    {
                        return ("Edgar et 13");
                    } 
                    case "eva_thirteen":
                    {
                        return ("Éva et 13");
                    } 
                } // End of switch
            } 
            case "location":
            {
                switch (id)
                {
                    case "alley":
                    {
                        return ("Ruelle");
                    } 
                    case "backstage":
                    {
                        return ("Coulisses");
                    } 
                    case "backyard":
                    {
                        return ("Cour");
                    } 
                    case "cave":
                    {
                        return ("Caverne");
                    } 
                    case "desert":
                    {
                        return ("Désert");
                    } 
                    case "forest":
                    {
                        return ("Forêt");
                    } 
                    case "living_room":
                    {
                        return ("Maison");
                    } 
                    case "museum":
                    {
                        return ("Musée");
                    } 
                    case "outerspace":
                    {
                        return ("Espace");
                    } 
                    case "park":
                    {
                        return ("Parc");
                    } 
                    case "restaurant":
                    {
                        return ("Restaurant");
                    } 
                    case "salon":
                    {
                        return ("Mme Psycho");
                    } 
                    case "seventeenth_parallel":
                    {
                        return ("17e parallèle");
                    } 
                    case "sky":
                    {
                        return ("Ciel");
                    } 
                    case "stage":
                    {
                        return ("Estrade");
                    } 
                    case "store":
                    {
                        return ("Occulte & cie");
                    } 
                    case "street":
                    {
                        return ("Trottoir");
                    } 
                    case "thirteenth_dimension":
                    {
                        return ("13e dimension");
                    } 
                    case "jungle":
                    {
                        return ("Jungle");
                    } 
                } // End of switch
            } 
            case "prop":
            {
                if (id !== "none")
                {
                    break;
                } // end if
                return ("Rien");
                return ("Caméra");
                return ("Sac puant");
                return ("Potion");
                return ("Trophée");
                return ("Cadeau");
                return ("Cristal");
                return ("Boîte mystérieuse");
                return ("Lapin");
                return ("Livre");
                return ("Casque");
                return ("Fleurs");
                return ("Statuette");
                return ("Lettre");
                return ("Carte de fête");
                return ("Carte");
                return ("Journal");
            } 
        } // End of switch
    } // End of the function
    function getHoldingFr(scene)
    {
        switch (scene.prop)
        {
            case "none":
            {
                switch (scene.clip)
                {
                    case "ride_wagon":
                    {
                        return ("en ne tenant");
                    } 
                } // End of switch
                return ("");
            } 
        } // End of switch
        return ("en tenant");
    } // End of the function
    var toStringFunctions = [function ()
    {
        var _loc2 = "";
        if (actor)
        {
            _loc2 = _loc2 + ("<a href=\"asfunction:choose,actor\"><u>" + actor + "</u></a>");
        } // end if
        _loc2 = _loc2 + ("<font color=\"#FFFFFF\"> " + verb + "</font>");
        if (actee)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,actee\"><u>" + actee + "</u></a>");
        } // end if
        if (location)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,location\"><u>" + location + "</u></a>");
        } // end if
        if (prop)
        {
            _loc2 = _loc2 + ("<font color=\"#FFFFFF\"> " + holding + " </font><a href=\"asfunction:choose,prop\"><u>" + prop + "</u></a>");
        } // end if
        _loc2 = _loc2 + "<font color=\"#FFFFFF\">.</font>";
        return (_loc2);
    }, function ()
    {
        var _loc2 = "";
        if (actor)
        {
            _loc2 = _loc2 + ("<a href=\"asfunction:choose,actor\"><u>" + actor + "</u></a>");
        } // end if
        _loc2 = _loc2 + ("<font color=\"#FFFFFF\"> " + verb + "</font>");
        if (actee)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,actee\"><u>" + actee + "</u></a>");
        } // end if
        if (prop)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,prop\"><u>" + prop + "</u></a>");
        } // end if
        if (location)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,location\"><u>" + location + "</u></a>");
        } // end if
        _loc2 = _loc2 + "<font color=\"#FFFFFF\">.</font>";
        return (_loc2);
    }, function ()
    {
        var _loc2 = "";
        if (actor)
        {
            _loc2 = _loc2 + ("<a href=\"asfunction:choose,actor\"><u>" + actor + "</u></a>");
        } // end if
        _loc2 = _loc2 + ("<font color=\"#FFFFFF\"> " + verb + "</font>");
        if (prop)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,prop\"><u>" + prop + "</u></a>");
        } // end if
        if (actee)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,actee\"><u>" + actee + "</u></a>");
        } // end if
        if (location)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,location\"><u>" + location + "</u></a>");
        } // end if
        _loc2 = _loc2 + "<font color=\"#FFFFFF\">.</font>";
        return (_loc2);
    }, function ()
    {
        return ("<font color=\"#FFFFFF\"> " + verb + "</font>");
    }, function ()
    {
        var _loc2 = "";
        if (actor)
        {
            _loc2 = _loc2 + ("<a href=\"asfunction:choose,actor\"><u>" + actor + "</u></a>");
        } // end if
        if (actee)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,actee\"><u>" + actee + "</u></a>");
        } // end if
        _loc2 = _loc2 + ("<font color=\"#FFFFFF\"> " + verb + "</font>");
        if (location)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,location\"><u>" + location + "</u></a>");
        } // end if
        if (prop)
        {
            _loc2 = _loc2 + ("<font color=\"#FFFFFF\"> " + holding + " </font><a href=\"asfunction:choose,prop\"><u>" + prop + "</u></a>");
        } // end if
        _loc2 = _loc2 + "<font color=\"#FFFFFF\">.</font>";
        return (_loc2);
    }, function ()
    {
        var _loc2 = "";
        if (actor)
        {
            _loc2 = _loc2 + ("<a href=\"asfunction:choose,actor\"><u>" + actor + "</u></a>");
        } // end if
        _loc2 = _loc2 + ("<font color=\"#FFFFFF\"> " + verb + "</font>");
        if (location)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,location\"><u>" + location + "</u></a>");
        } // end if
        if (actee)
        {
            _loc2 = _loc2 + (" <a href=\"asfunction:choose,actee\"><u>" + actee + "</u></a>");
        } // end if
        if (prop)
        {
            _loc2 = _loc2 + ("<font color=\"#FFFFFF\"> " + holding + " </font><a href=\"asfunction:choose,prop\"><u>" + prop + "</u></a>");
        } // end if
        _loc2 = _loc2 + "<font color=\"#FFFFFF\">.</font>";
        return (_loc2);
    }];
} // End of Class

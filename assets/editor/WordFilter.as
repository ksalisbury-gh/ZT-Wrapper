class WordFilter
{
    var languages, delimiter, replacement, words;
    function WordFilter(active_language)
    {
        languages = new Array();
        delimiter = ",";
        replacement = "$!*#*&!?*#$*&*?!*#$*";
        languages.en = new String("anus,asshole,bastard,bitch,blowjob,boner,browneye,bullshit,clit,cock,cum,cunnilingus,cunt,dildo,dumbass,fag,faggot,fuck,gonads,gook,nigger,penis,pussy,shit,slut,twat,vibrator,wanker,whore,fart");
        languages.fr = new String("merde,putain,chier,zob,connard,pute,connasse,salope,salaud,fils de pute,fille de pute,chiotte,esgourde,roubignolle,couille,putasse,putassiére,bordel,jacqueter,jaffer,baiser,niquer,enculer,encule,enfoire,foutre,tabarnac,crisse,calisse,estie,ciboire,st-vierge,sacrament,sacrement,enfoirer,emmerder,emmerde");
        var _loc2 = new String();
        if (languages[active_language])
        {
            _loc2 = languages[active_language].toLowerCase();
        }
        else
        {
            for (var _loc3 in languages)
            {
                _loc2 = _loc2 + (languages[_loc3].toLowerCase() + delimiter);
            } // end of for...in
            _loc2 = _loc2.substring(0, _loc2.length - 1);
        } // end else if
        words = _loc2.split(delimiter);
    } // End of the function
    function filterWordsSimple(input)
    {
        return (input);
    } // End of the function
    function filterWords(input)
    {
        return (input);
    } // End of the function
} // End of Class

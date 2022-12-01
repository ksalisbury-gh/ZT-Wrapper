class TextScaler
{
    var tf, maxSize, minSize, fittedText, fittedFormat;
    function TextScaler(tf, maxSize, minSize)
    {
        this.tf = tf;
        this.maxSize = maxSize;
        this.minSize = minSize;
        this.scaleToFit();
    } // End of the function
    function scaleToFit()
    {
        if (tf == undefined || minSize == undefined || maxSize == undefined || tf.text.length == 0)
        {
            return;
        } // end if
        tf.multiline = true;
        tf.wordWrap = true;
        var _loc2 = tf.getTextFormat();
        _loc2.leading = 0;
        tf.setTextFormat(_loc2);
        _loc2.size = this.findInRange(maxSize, minSize, this, "fitsAtSize");
        tf.setTextFormat(_loc2);
        if (this.fitsAtSize(_loc2.size))
        {
            this.adjustLeading();
            this.save();
        }
        else
        {
            this.revert();
        } // end else if
    } // End of the function
    function onChanged()
    {
        this.scaleToFit();
    } // End of the function
    function cropToFit()
    {
        tf.text = tf.text.substring(0, this.findInRange(tf.text.length, 0, this, "fitsAtLength"));
    } // End of the function
    function adjustLeading()
    {
        var _loc2 = tf.getTextFormat();
        _loc2.leading = this.findInRange(_loc2.size / 3, 0, this, "fitsAtLeading");
        tf.setTextFormat(_loc2);
    } // End of the function
    function save()
    {
        fittedText = tf.text;
        fittedFormat = tf.getTextFormat();
    } // End of the function
    function revert()
    {
        if (!fittedText || !fittedFormat)
        {
            this.cropToFit();
            this.adjustLeading();
            this.save();
        }
        else
        {
            var _loc2 = Selection.getCaretIndex() - (tf.text.length - fittedText.length);
            tf.text = fittedText;
            tf.setTextFormat(fittedFormat);
            if (Selection.getFocus() == String(tf))
            {
                Selection.setSelection(_loc2, _loc2);
            } // end if
        } // end else if
    } // End of the function
    function findInRange(max, min, obj, method, range, size)
    {
        if (range == undefined)
        {
            range = max - min;
        } // end if
        if (size == undefined)
        {
            size = max;
        } // end if
        if (range == 0)
        {
            if (!obj[method](size))
            {
                --size;
            } // end if
            return (Math.max(min, Math.min(max, size)));
        } // end if
        obj[method](size) ? (size = size + range, size) : (size = size - range, size);
        if (range == 1)
        {
            return (this.findInRange(max, min, obj, method, 0, size));
        } // end if
        return (this.findInRange(max, min, obj, method, Math.ceil(range / 2), size));
    } // End of the function
    function fitsAtSize(size)
    {
        if (size < minSize || size > maxSize)
        {
            return (false);
        } // end if
        var _loc3 = tf._height;
        var _loc5 = tf.getTextFormat();
        var _loc2 = tf.getTextFormat();
        _loc2.size = size;
        tf.autoSize = "center";
        tf.setTextFormat(_loc2);
        var _loc6 = tf._height <= _loc3;
        tf.autoSize = false;
        tf._height = _loc3;
        tf.setTextFormat(_loc5);
        return (_loc6);
    } // End of the function
    function fitsAtLength(length)
    {
        var _loc4 = tf.text;
        var _loc2 = tf._height;
        tf.autoSize = "center";
        tf.text = tf.text.substring(0, length);
        var _loc3 = tf._height <= _loc2;
        tf.autoSize = false;
        tf._height = _loc2;
        tf.text = _loc4;
        return (_loc3);
    } // End of the function
    function fitsAtLeading(leading)
    {
        var _loc3 = tf._height;
        var _loc4 = tf.getTextFormat();
        var _loc2 = tf.getTextFormat();
        _loc2.leading = leading;
        tf.autoSize = "center";
        tf.setTextFormat(_loc2);
        var _loc5 = tf._height <= _loc3;
        tf.autoSize = false;
        tf._height = _loc3;
        tf.setTextFormat(_loc4);
        return (_loc5);
    } // End of the function
} // End of Class

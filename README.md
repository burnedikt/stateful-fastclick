# Stateful Fastclick #

Stateful fastclick is a simple, easy-to-use wrapper around the excellent [fastclick](https://github.com/ftlabs/fastclick)-library for eliminating the 300ms delay between a physical tap and the firing of a `click` event on mobile browsers. The aim is to not only make your application feel less laggy and more responsive but also provide instant visual feedback on any user interaction. This way, we get something similar to the ancient `:hover` and `:active` pseudo classes on touch-devices.

## Advanced ##

Please refer to [fastclick](https://github.com/ftlabs/fastclick) for further information

### Active and touched states

In order to provide visible feedback to any user navigating through your web application, this extended fastclick library sets two different CSS classes, depending on the current action.

1. While the user is tapping a clickable element (and holding the touch) the element gets the CSS class `fastclick-touched` which can be styled accordingly to provide visible feedback (this corresponds to the old `:hover` CSS pseudoclass on desktops)
2. As soon as the user stops tapping and a click event is fired, the additional class `fastclick-active` is set (this corresponds to the old `:active` CSS pseudeoclass on desktops)
3. As soon as the touch is canceled or the user drags a touch further than the threshold allowed by fastclick, both classes are removed again

__!! Important !!__

The CSS-classes named above are set on the fastclick-layer level. That means, the fastclick has to be instantiated on every clickable element separately for the active states to work correctly. This behaviour could be changed back to an on-element basis, but since
this modified lib is mainly used in the angular-fastlick library (https://github.com/benediktreiser/angular-fastclick), where the respective layer always is the element which has a click-handler attached, this works fine. By putting the active states back on the real element, we get weird optical feedback, as tapping a child element, will only highlight this child instead of the actual clickable parent element (which will handle the click event in the end).


#### Example styles (to be adjusted)

```html
<!doctype html>
<html>
<head>
<title>States</title>
<meta charset='utf-8' />

<meta name="viewport" content="initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name='apple-mobile-web-app-capable' content='yes' />
<style>
#clickable {
  color: black;
  background-color: white;
  border: 1px dotted black;
  width: 300px;
  height: 300px;
}
#clickable.fastclick-touched {
  background-color: red;
  color: green;
}
#clickable.fastclick-active {
  background-color: green;
  color: red;
}
</style>

<script src="../bower_components/fastclick/lib/fastclick.js"></script>
<script src="../dist/stateful-fastclick.js"></script>
<script>
  'use strict';
  window.addEventListener('load', function() {
    new window.StatefulFastclick(document.getElementById('clickable'));
  });
</script>
</head>
<body>
    <div id="clickable">
        This box's background- and text-color should change on touching / tapping / releasing
    </div>
</body>
</html>

```

## Tests ##

There are no automated tests. The files in `tests/` are manual reduced test cases. We've had a think about how best to test these cases, but they tend to be very browser/device specific and sometimes subjective which means it's not so trivial to test.

## Credits and collaboration ##

All credits go to FT Labs](http://labs.ft.com). All open source code released by FT Labs is licenced under the MIT licence. We welcome comments, feedback and suggestions.  Please feel free to raise an issue or pull request.
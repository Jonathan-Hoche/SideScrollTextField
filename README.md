# SideScrollTextField
## A Swift UIView class that offers a UITextField with customizable side scrolling text.

* Quick Start:
- Add the SideScrollTextField.swift file to your project.
- Add the PlaceIn.swift and PlaceOn.swift files to your project.
- Add a View in the storyboard and in the Identity inspector set it's Class to SideScrollTextField
- In Attributes inspector type some text.
- Add an outlet of the View to the appropriate ViewController
- In viewDidLoad type (replace "scroller" with your outlet name): 
~~~~ 
scroller.startScroll()
// NOTE: before starting again call...
scroller.stopScroll() 
~~~~
### Details
* The class is @IBDesignable.
* The properties are @IBInspectable. They all have a default value but you can customize them. You can:
- Enter the Text.
- Choose a font size. Or Have the font height as the size of its View. Or set a max & min size.
- Choose Direction of scrolling (left or right).
- Choose the number of times to repeat.
- Choose the scrolling speed as a fixed time or as number of pixels per second.
- Choose starting point from out of bounds or not.
- Choose the time to delay before starting and the time to delay at the end.
- Choose if the text scrolls only if it's too long.
- Choose if the text only repeats once it is out of bounds and choose the spacing between each repeat if it is does not.

These are the available @IBInspectable properties (read the comments to learn how they affect each other and the final scroll):
~~~~
var text: String = "" //FIRST OF ALL!!! You must set the text in the storyboard or programmatically. The didSet observer will get called and initilize the view correctly and add the textField as a subview.

var fontSizeAsView: Bool = false // true wiil ignore fontSizes and make the font size as big as the view (it's superview)

var fontSize: CGFloat = 17.0 // initial font size. will be ignored at runtime if maxFontSize OR minFontSize are bigger than 0. OR if fontSizeAsView = true

var maxFontSize: CGFloat = 0.0 // ignored when = 0 OR if fontSizeAsView = true

var minFontSize: CGFloat = 0.0 // ignored when = 0 OR if fontSizeAsView = true

var scrollLeft: Bool = true // false =  scroll right

var scrollOnlyWhenTooLong: Bool = false // only when the text is longer than the view (isTextFittingInView = false)

var scrollRepeat: Int = -1 // -1 = always. 0 = scrolls once with no repeat. 1...n = number of repeats.

var scrollTime: Double = 5 // seconds until scroll out of bounds and animation "round" finishes (0 = use scrollSpeed)
// EXAMPLE: scrollTime = 10 will finish the eniter animation in 10 seconds

var scrollSpeed: Int = 0 // movment in points(pixels) per second (only works if scrollTime is at 0)
// EXAMPLE: scrollSpeed = 10 will move 10 pixels every second ( the more pixels, the quicker the animation will end)

var repeatWhenOutOfBounds: Bool = true // text will repeat only when prior goes out of bounds

var repeatSpacing: Int = 50 // space between each repeat in points (ignored if repeatWhenOutOfBounds = true)

var delayAtStart: Double = 2 // delay in seconds before starting (only happens once if using repeatSpacing)

var delayAtEnd: Double = 0 // delay in seconds when each cycle ends (ignored if using repeatSpacing)

var startOutOfBounds: Bool = false // animation starts with the text out of bounds (text will be out of bounds even before start scroliing)
~~~~
### Note: SideScrollTextField class uses PlaceIn.swift and PlaceOn.swift files (UIView extensions)
* [placeIn-PlaceOn] - A group of Swift UIView extensions that simplify positioning a UIView within or around another UIView such as UILabel, UIButton etc...

The SideScrollTextField.swift file and PlaceIn.swift and PlaceOn.swift files are provided alongside an Xcode project with some interesting examples. Any feedback is welcome.
Check out Example 4 (Example4VC) in the Xcode project that uses the class completely programmatically and customizes the text field and the view borders as well as enabling the the text field for custom texts by user.

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax and http://dillinger.io) 
[link]: https://github.com/Jonathan-Hoche/SideScrollTextField
[placeIn-PlaceOn]: <https://github.com/Jonathan-Hoche/placeIn-placeOn#placein-placeon>

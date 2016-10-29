//MARKUP to provide documentation (eg. when you alt-click the type)
//MARKDOWN format used
//hotkey to bring up documentation quick help pane: alt-cmd-2
//description also pops up with auto-complete
//almost like block comment but extra start in the start /*, placed before object being documented
//the examples below use functions, but you can document TYPES as well

//BASICS
/**
Prints "hi" using `print()`.
It really does.
*/
func dostuff() {
    print("hi")
}
//this function documentation goes into the description
//the BACKTICK documents code (formats the stuff inside to look like code)
//the 2nd line continues the description (newline discarded like HTML)

//MARKDOWN
/**
This function does the following: 
* Prints
* Prints again
    * item1
    * item2
1. first step
1. first step
This text is *italicized*.
This text is **bold**.
# Heading1
## Heading2
### Heading3
Headings can be used to make sections inside the markdown.
You can [link](http://www.yahoo.com) text to a url with this format.  The http is required, and a browser will pop up.
[otherlink](dostuff)
*/
func dostuff2() {
    print("hi")
    print("item1, item2")
}
//asterisk with space = bulleted list
//indented asterisk with space = sublist (indent must be tab, not space)
//use 1. for numbered lists and they'll be automatmically numbered
//see other formatting within the documentation comment (Note that a lot of things require a space)

//OTHER FIELDS (beyond description)
/**
This function does stuff.  
- Returns: A happy greeting.
- Parameter x: the x value
- Parameter y: the y value
- Throws: LoadError.networkFailed, LoadError.writeFailed
- Precondition: You have to be cool to call this.
- Precondition: x > 0 && y > 0
- Complexity: O(1)
Putting text in between keywords gets it sucked into previous keyword).
- Authors: David Petrofsky
Putting text after keywords (gets sucked into previous keyword).
*/
func dostuff3(x: Int, y: Int) -> String {
    return "hi"
}
//have to use - and space before special keywords
//the keywords are not case sensitive
//the order in QuickHelp is predetermined, not determined by you
//obviously you don't have to use all of them
//alt-click dostuff3 above to see what the documentation looks like
//a lot of these fields end up inside the description with headers

//QUESTIONS
//Can you link within the comment, to other types/functions that are documented, etc?
//Can you document member variables, local variables, etc?
//Check out documentation for other formats (eg. ///) and other important things


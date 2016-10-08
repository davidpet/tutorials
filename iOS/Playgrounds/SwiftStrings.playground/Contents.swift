import Foundation       //required for some things like range()

//DECLARATIONS
var s : String = "hi"

//CONCATENATION
var t = s + "_" + s
//var t = s + 5     //can't directly concatenate like this
var u = s + String(5)       //works if use conversion
u += "bye"              //update existing string

//COMPARISON
s == "Hi"       //case sensitive comparison

//INTERPOLATION
//often cleaner to read than concatenation
let xx = 5
var v = "Greeting: \(s), you have \(xx) new messages"    //NOTE: it works for multiple data types
var q = "Your value is less than \(xx + 1)"     //value in \() is an EXPRESSION

//INSPECTING
s.characters.count          //string length
s.isEmpty                   //no characters
s.hasPrefix("pre")
s.hasSuffix("post")         //checking text before and after
s.range(of: "i")            //check if one string CONTAINS another (nil if doesn't)

//MANIPULATION
let uppercased = s.uppercased()
let lowercased = s.lowercased()

//JOINING
var joined = ["1", "2", "3"].joined()       //only works for Array<String> (inc. in code completion popup)
var joinedWithSpace = ["1", "2", "3"].joined(separator: " ")    //can specify separator instead of cramming directly together

//SPLITTING
let multiline = "\nabc\ndef\nghi\n"
let split = multiline.components(separatedBy: "\n")     //split into array (beginning and end separators become empty strings)

//LOADING FILES
if let thetext = try? String(contentsOfFile: "myfile.txt") {}       //if this file existed, it would be loaded as a string here
//other overloads of this initializer that take encodings, etc.

//QUESTIONS
//How to do case INSENSITIVE stuff?
//How to do multiline strings?
//How to do mutable string/strinbuilder?
//What is string.characters?  Seems to have array-like things but be readonly

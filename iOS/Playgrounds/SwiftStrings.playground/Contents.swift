import Foundation       //required for some things like range()

//DECLARATIONS
var s : String = "hi"               //MUTABLE string
var ss : StaticString = "yo"        //IMMUTABLE string (more optimal than constant strings for reading)
//NOTE: there are no raw string literals yet in Swift

//SPECIAL INITIALIZERS
var sep = String(repeating: "=", count: 100)    //100 = signs put together
var num = String(10)                //NUMBER
var num2 = String(10, radix: 16)    //HEX
var num3 = String(10, radix: 16, uppercase: true)

//CONVERSION
let val: Int? = Int("100")      //int initializer/convertor is optional in case invalid number string
let val2: Int? = Int("cat")
let val3: Int? = Int("  100   ")    //spacing DOES matter
let val4 = Int("100", radix: 16)    //converting from HEX

//VALUE TYPE
var sCopy = s
sCopy.remove(at: sCopy.startIndex)      //assigning a string to another string makes a copy
print(s)

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
if let pos = s.range(of: "i") {          //check if one string CONTAINS another (nil if doesn't)
    print(pos.lowerBound)           //examining the range
    print(pos.upperBound)           //EXCLUSIVE
}
"hi".contains("h")

//CHARACTERS
let chars = s.characters            //getting sequence of characters
let firstchar = chars.first!            //not an array but has methods to get stuff
for char in chars {                         //iterable by character
    print(type(of: char))                   //Character is a distinct type
    let pos = s.range(of: String(char))         //have to convert back to string to search in a string (or to use it as a string any other way such as contains())
    print(pos?.lowerBound)              //indexing the character found in the string
}
let char2: Character = "H"          //LITERAL (only ok if single character)
let widechars = s.utf16                 //legacy version for compatibility with apple libraries (objective-c)
let firstwidechar = widechars.first!        //similar to 'characters' but not quite the same

//MANIPULATION
let uppercased = s.uppercased()
let lowercased = s.lowercased()         //upper casing and lower casing
let spacey = "    hi you    "
let trimmed = spacey.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)  //trimming leading and trailing whitespace
let trimmed2 = spacey.trimmingCharacters(in: .whitespacesAndNewlines)               //don't forget you can ommit the parent
//NOTE: there are other character sets in NSCharacterSet and you can also create your own
let replaced = spacey.replacingOccurrences(of: " ", with: "")

//JOINING
var joined = ["1", "2", "3"].joined()       //only works for Array<String> (inc. in code completion popup)
var joinedWithSpace = ["1", "2", "3"].joined(separator: " ")    //can specify separator instead of cramming directly together

//SPLITTING
let multiline = "\nabc\ndef\nghi\n"
let split = multiline.components(separatedBy: "\n")     //split into array (beginning and end separators become empty strings)

//FILE I/O
if let thetext = try? String(contentsOfFile: "myfile.txt") {}       //if this file existed, it would be loaded as a string here
//other overloads of this initializer that take encodings, etc.
try? "s".write(toFile: "myfile.txt", atomically: true, encoding: .ascii)    //writing to a file

//REGULAR EXPRESSIONS
let input = "This is a string with some text."
let regex = try! NSRegularExpression(pattern: "(wi)(th)", options: .init(rawValue: 0))
let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
for match in matches {
}

//CONVENTIONS
//Use 'characters.count' for your own code and 'utf16.count' for Apple library code

//QUESTIONS
//How to do case INSENSITIVE stuff?
//How to do multiline strings?
//How to do mutable string/strinbuilder?
//What is string.characters?  Seems to have array-like things but be readonly (find out what it can do)
//String.remove() and why it works with pos.lowerBound [didn't include that part for now but saw in tutorial]
//Finish filling in the REGULAR EXPESSIONS section above and mirror to Cocoa Touch document
//Figure out these things (either here or in Cocoa Touch doc) for NSRegularExpression: can you do non-compiled? modifiers? capture groups (numbered and named)? backreferences and lookaheads? metacharacters and character classes? replacements?

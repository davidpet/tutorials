import Foundation       //required for some things like range()

//DECLARATIONS
var s : String = "hi"               //MUTABLE string
var ss : StaticString = "yo"        //IMMUTABLE string (more optimal than constant strings for reading)
//NOTE: there are no raw string literals yet in Swift
var newline = "\n"          //newline in Swift

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

//MULTILINE STRINGS
//just concatenate with + and keep opening and closing the quotes

//COMPARISON
s == "Hi"       //case sensitive comparison
s.caseInsensitiveCompare("hi") == .orderedSame      //case insensitive

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
let eq = char2 == "H"                   //can TEST value of character this way
let widechars = s.utf16                 //legacy version for compatibility with apple libraries (objective-c)
let firstwidechar = widechars.first!        //similar to 'characters' but not quite the same
//see SUBSTRINGS section below for more about indexing strings

//CHARACTER SETS
//see CharacterSet reference for static members of specific character sets
let cs = CharacterSet.alphanumerics
cs.contains("a")        //can test membership of characters, do set-like operations, etc.
cs.inverted.contains("_")       //use inverted to get the complementary character set
let mycs = CharacterSet(charactersIn: "abc")        //defining your own character set
mycs.contains("c")
mycs.contains("d")

//SUBSTRINGS
let longstring = "hi, this is a long string for testing substring extraction"
let startIndex: String.Index = longstring.startIndex        //strings have their own index type and a start index property representing the beginning
let endIndex = longstring.endIndex              //the index of the "past the end" position of the string
let secondIndex = longstring.index(after: startIndex)       //convenience method to get an index after a given index
//let secondIndex2 = startIndex + 1                     //no direct math allowed!!!
let lastChar = longstring.index(before: endIndex)           //get index right before given index
let sixthChar = longstring.index(startIndex, offsetBy: 5)           //this is how you do math
let actualSixthChar: Character = longstring[sixthChar]      //can treat string like an array of Character using String.Index (but not integer)
//longstring[5]             //not allowed
let prefix = longstring.substring(to: sixthChar)            //prefix string to exclusive upper bound
let suffix = longstring.substring(from: sixthChar)          //suffix string from start position
let middle = longstring[startIndex...sixthChar]         //use a range with [] to get middle substrings (NOTE: it is smart enough to know closed vs. open range)
let middleOpen = longstring[startIndex..<sixthChar]         //different result
//dealing with NSRange
let nsRange = NSRange(location: 0, length: 5)           //will often get an NSRange from an API (created here for demonstration purposes)
let convertedRange = longstring.index(startIndex, offsetBy: nsRange.location) ..< longstring.index(startIndex, offsetBy: nsRange.location + nsRange.length)
let middleOpen2 = longstring[convertedRange]        //could of course provide the range inline but it's a bit long and ugly
//see below for replacing substrings by range

//MANIPULATION
let uppercased = s.uppercased()
let lowercased = s.lowercased()         //upper casing and lower casing
let spacey = "    hi you    "
let trimmed = spacey.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)  //trimming leading and trailing whitespace
let trimmed2 = spacey.trimmingCharacters(in: .whitespacesAndNewlines)               //don't forget you can ommit the parent
//NOTE: there are other character sets in NSCharacterSet and you can also create your own
let replaced = spacey.replacingOccurrences(of: " ", with: "")
let replaced2 = spacey.replacingCharacters(in: spacey.startIndex..<spacey.index(spacey.startIndex, offsetBy: 4), with: "")  //using ugly range syntax to do range replacement
//NOTE: will only compile with open range for some reason
var spacey2 = spacey
spacey2.replaceSubrange(spacey.startIndex...spacey.index(spacey.startIndex, offsetBy: 3), with: "")     //mutable version that operates on original
//NOTE: there are many other overloads of replacing subranges to make it even more complicated

//JOINING
var joined = ["1", "2", "3"].joined()       //only works for Array<String> (inc. in code completion popup)
var joinedWithSpace = ["1", "2", "3"].joined(separator: " ")    //can specify separator instead of cramming directly together

//SPLITTING
let multiline = "\nabc\ndef\nghi\n"
let split = multiline.components(separatedBy: "\n")     //split into array (beginning and end separators become empty strings)
let split2 = multiline.components(separatedBy: CharacterSet.newlines)       //useful character sets as members of the CharacterSet struct
let split3 = multiline.components(separatedBy: CharacterSet.newlines.inverted)      //splitting by everything NOT in the character set

//FILE I/O
if let thetext = try? String(contentsOfFile: "myfile.txt") {}       //if this file existed, it would be loaded as a string here
//other overloads of this initializer that take encodings, etc.
try? "s".write(toFile: "myfile.txt", atomically: true, encoding: .ascii)    //writing to a file

//REGULAR EXPRESSIONS
//this is covered in the Cocoa Touch API reference too, but I wanted to show usage here because it's a bit obscure
let input = "This is a string with some text."
let regex = try! NSRegularExpression(pattern: "(wi)(th)", options: [])          //there is no regex literal in swift
let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))     //using utf16 because calling apple library code
for match in matches {
    var ranges = [NSRange]()
    let wholeMatch = match.rangeAt(0)           //capture groups (including 0 for whole match) are indexed through this method (if you didn't have groups, still need this)
    let wholeMatch2 = match.range               //same thing as above (a quicker way to get the whole match)
    ranges += [wholeMatch, wholeMatch2]
    
    for i in 1 ..< match.numberOfRanges {           //safe because we know we had groups in the regex
        let groupMatch = match.rangeAt(i)
        ranges.append(groupMatch)
    }
    
    print("Beginning regex printout")
    for range in ranges {                   //use the NSRange instances to index into the original string to see what the text is
        let start = input.index(input.startIndex, offsetBy: range.location)
        let end = input.index(input.startIndex, offsetBy: range.location + range.length)
        print(input[start..<end])
    }
    print("Ending regex printout")
}
let replacement = regex.stringByReplacingMatches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count), withTemplate: "$1")
//for other available operations (eg. executing blocks for each match), see Cocoa Touch reference
//for specific flags, options, regex metacharacters, etc. see the Cocoa Touch Reference for NSRegularExpression

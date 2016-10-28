import UIKit

//DECLARATIONS
var s = "hi"        //string variable
var S = "bye"       //symbols are CASE SENSITIVE
let t = "hi"        //string constant (optimized and catches programmer error)
let t2: String    //initializing a constant (or variable) can be deferred (eg. to select between values in if/else condition)
t2 = "hi"
let xx = 5, yy = 10, zz = "hi"    //multiple declarations on 1 line allowed (even mixed types)
//let xy = 100, let xz = 100       //let can only go out front
print(xx)
print(yy)

s = "bye"           //reassigning
//var s = "bye"     //cannot re-declare with var
//t = "bye"           //not allowed for constants

var name: String    //specifying type (note the spacing)
//print(name)       //can't use before initialized
name = "Bob"        //assigning the value (type must match)
var name2: String = "Joe"       //declare type and assign at same time

var name3: String = "hi", name4: String = "low" //multiple declarations together
var name5: String = "hi", name6: String = name5     //earlier declarations can be seen by later ones

//OPTIONALS
var opt : String?   //putting ? after type makes it optional (similar to nullable in C# - allows it to be nil)
//defaults to nil (instead of uninitialized)
opt = nil           //this was already true but just showing that nil is the empty value
opt = "hi"          //now the optional has a value
opt = nil           //can go back
opt = "hi"
print(opt!)         //! force unwrap the optional when the pure type is needed (runtime error if nil so only do when SURE)
//for safer way to unwrap optionals, see SwiftControlFlow playground (if-statement variation)
var opt2 : String! = "hi"   //using ! instead of ? after optional type makes it implicitly unwrapped optional
print(opt2!)                //can use implicitly unwrapped optional wherever you would use the raw type - it's like always using ! to unwrap (only safe if not nil)
                            //mostly only used when have to because of UI stuff (late bound) and old library stuff
print((opt2)!)      //! is an operator that takes an EXPRESSION

//OPTIONAL CHAINING
let val = opt?.uppercased()     //can insert ? before things like . and [] operators (even multiple times in a long line)
                                //if anything from left to right turns out nil the whole thing is nil -> if it makes it to the end, you get the result of the whole expression
                                //type of this value is String?

//COALESCING
let str = opt ?? ""         //unwrap in a way that nil turns into a valid value (just like C#)
let val2 = Int("100") ?? 0

//DATA TYPES
var thename: String = "Bob"
var theage: Int = 5
var theage2: UInt = 5                   //unsigned integer
var theage3: UInt32 = 5                 //int types like these available for interop with things like C standard lib functions
var latitude: Float = -18.633333333
var longitude: Double = -18.633333333       //recommended by Apple due to higher accuracy
var altitude = -18.63333                //becomes a Double even though Float would work
var success: Bool = true

//BUILT-IN CONSTANTS
Double.pi
Float.pi
Int.max
UInt.min

//TYPDEFS
typealias MyType = String
typealias MyOtherType = Array<String>       //typelias is the equivalent of using in C# or typedef in C++
let mot = MyOtherType()                     //use the type just like it were a real type
let mt: MyType? = nil                       //can also use modifiers like ? on it
typealias MyOtherType2 = MyOtherType?       //can refer to other typealiases and can also include the ? in the type
let mot2: MyOtherType2? = nil               //still somehow allows this (discards the extra ?)

//DEFAULT VALUES
Int.max
Int.min
Int.allZeros

//VARIANTS
var anyVar: Any = 20       //any is like a variant
anyVar = "hi"               //can be reassigned to a value of a different type
var casted = anyVar as! String      //variants can be CASTED to explicit types

//EXPRESSIONS
var x = 5 + 3               //can initialize variables with expressions
var y = x * 2
let z = x * y               //works for constants as well

//VALUE TYPES
var ageCopy = theage
var successCopy = success       //NUMBERS and BOOLEANS are value types
//NOTE: built-in stuff like tuples, arrays, dictionaries, etc. are actually value types in Swift

//CONVENTIONS
//Start with Capital: data types
//Start with lowercase: variables and constants
//Use Constants when possible
//Use Type Inference (instead of explicit types) when possible
//put : next to variable name (eg. var name: String)

//QUESTIONS
//Attributes?  Decorators?
//Weak references?
//Passing value typed by reference?
//When can conversions be done implicitly vs. explicitly?  What about for custom types?


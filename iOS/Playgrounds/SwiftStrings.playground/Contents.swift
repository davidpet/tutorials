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

//MANIPULATION
s.uppercased()
s.lowercased()

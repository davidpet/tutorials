//ARITHMETIC
var a = 5
a = a + 1
a = a - 1
a = a * 1
a = 5 / 2       //division and modulo same as C++
a = 5 % 2
//a = 5 \ 2     //not a thing in Swift
var a2 = Double(a) + 0.5            //oddly, Double and Int can't be mixed without conversion (no implicit casting)
1  | 2      //BITWISE operators work on integers

//TERNARY OPERATOR
a = true ? 0 : 1

//AUGMENTED ASSIGNMENT
a += 5
a *= 10

//INCREMENT AND DECREMENT
//NOT ALLOWED in Swift 3
//a++
//++a

//COMPARISON
a = 100
var b = 200
a < b
a > b
a >= b
a == b      //like C++, cannot use single = for comparison
a != b
//NOTE: for VALUE TYPE, == works (checks value, not address), for REFERNECE TYPE == is not allowed by default

//CONDITIONAL
a == b && 10 == a
a == b || 10 == a       //conditions can be combined same as C

//BOOLEAN
//var b: Bool = 6 % 2     //ILLEGAL unlike C - have to use an operator like == 0
//var b: Bool = Bool(6 % 2)   //also no good
//if (1) {}                 //NOPE

//GROUPING AND NEGATION
//just showing these things all work like other languages
var flag = a == b
!flag
!(a == b)

//STRINGS
var s = "hi"
var t = "bye"
var u = s + "_" + t     //natural concatenation like other languages

s = "Hi"
s == "hi"       //string comparison with == is CASE SENSITIVE!

//RANGES
let r = 1...5   //closed range (1-5 INCLUSIVE) (NOTE: 3 dots)
let r2 = 1..<5  //half-open range (1-5 EXCLUSIVE of 5)
//NOTE: the opposite open range or full open range do not exist
r2.contains(5)

//CASTING
//see SwiftVariables for VARIANTS
//see SwiftClasses for POLYMORPHISM
var str = String(5)   //casting string to int
var int = Int("5")      //casting int to string
var int2 = Int(3.14)    //casting float to int automatically rounds

//IMPLICIT CASTING
//DOES NOT EXIST IN SWIFT (even for function calls)

//TYPE CHECK
"hi" is String      //boolean type check

//OPTIONALS, OPTIONAL CHAINING, and COALESCING are covered in the SwiftVariables playground

//PATTERN MATCHING
//version1: EQUATABLE types
"cat" ~= "cat"      //NOT good for substrings
1 ~= 1
//version2: OPTIONALS
//version3: INTERVALS
1...10 ~= 4             //like calling contains() for the interval
//version4: RANGES
//[1, 2, 3] ~= 1        //surprisingly, DOES NOT WORK

//QUESTIONS
//Fill in OPTIONALS and RANGES versions of PATTERN MATCHING

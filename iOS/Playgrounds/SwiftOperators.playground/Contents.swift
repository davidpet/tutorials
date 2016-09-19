//ARITHMETIC
var a = 5
a = a + 1
a = a - 1
a = a * 1
a = 5 / 2       //division and modulo same as C++
a = 5 % 2
//a = 5 \ 2     //not a thing in Swift

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

//CASTING
//see SwiftVariables for VARIANTS
//see SwiftClasses for POLYMORPHISM
var str = String(5)   //casting string to int
var int = Int("5")      //casting int to string

//OPTIONALS, OPTIONAL CHAINING, and COALESCING are covered in the SwiftVariables playground


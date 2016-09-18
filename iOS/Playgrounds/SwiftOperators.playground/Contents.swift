//ARITHMETIC
var a = 5
a = a + 1
a = a - 1
a = a * 1
a = 5 / 2       //division and modulo same as C++
a = 5 % 2
//a = 5 \ 2     //not a thing in Swift

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

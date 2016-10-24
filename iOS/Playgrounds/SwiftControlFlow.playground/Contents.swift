//CONDITIONALS
let x = 5
var y : Int
if x == 4 {         //no () needed around condition
    y = 0
}                   //{} are required even for single liners
else if x == 5 {
    y = 1
}
else {              //otherwise acts basically like C
    y = 2
}

if x == 4 || x != 2 {   //combining multiple conditions
}

if x == 4 {}            //allowed to put {} on any lines you want like C (just not to OMMIT them)


//OPTIONAL UNWRAPPING CONDITIONALS
var opt : String?
if let unwrapped = opt {
    //this block only executes if opt is not nil
    //unwrapped is automatically a String (unwrapped)
}
var opt2 : Int?
if let unwrapped = opt, let unwrapped2 = opt2 {     //only executes if both unwrappings worked
}
//if let unwrapped = opt, unwrapped2 = opt {    //unlike with normal declarations, you HAVE to use a 2nd let here
//}

//if let x = 5 {    //NOTE: this syntax is specific to unwrapping optionals
//}

//RANGE LOOPS
for i in 1...10 {           //Python-like range loops (doesn't support C-style loops anymore)
    print("The value this time is \(i)")
}

for _ in 1...5 {            //variation when you don't need to know the index (has performance benefits)
    print("hi")
}

for _ in 1..<5 {            //half-closed ranges supported too
    print("bye")
}

let a = [1, 2, 3]
for i in 0..<a.count {      //going through array by index
    print(a[i])
}

//ARRAY LOOPS
for item in [1, 2, 3] {
    print(item * 2)
}
//see SwiftClasses playground POLYMORPHISM section for variations that do casting at the array level
let item1 = 1
let item2 = 2
let item3 = 3
for item in [item1, item2, item3] {         //useful if you want to loop through a bunch of local variables
}

//ENUMERATED ARRAY LOOPS
for (index, item) in [1, 2, 3, 4, 5].enumerated() {     //special enumerated() member of collection returns tuple(index, item)
    print(item)
}

//WHILE LOOPS
var z = 0
while true {            //basically like C but don't need ()
    if z == 10 {
        break           //break and continue work just like C
    }
    z += 2
}
repeat {                //equivalent of DO in C uses REPEAT instead
    print("hi")
    break
} while true

//EXTRA CONDITIONS
for item in [1, 2, 3, 4, 5, 6] where item % 2 == 0 {        //loop body only executed when condition is true
    print(item)                                             //NOTE: you can use && and || just like any other conditional
}

//LOOP LABELS
outerLoop: for x in [1, 2, 3, 4, 5] {       //can label any loop statement (for, while, etc.) with a name
    for y in [1, 2, 3, 4, 5] {
        if y == 3 && x == 2 {
            break outerLoop                 //can break or continue by loop name (otherwise this would only break the INNER loop)
        }
        else {
            print("\(x),\(y)")
        }
    }
}
//NOTE: there are no gotos (the old-fashioned reason labels are thought of badly)

//CONDITIONAL LABELS
let temp = 5
let temp2 = 10
outerConditional: if temp == 5 {        //can apply labels on conditionals too
    if temp2 != 10 {break outerConditional}             //can break out of the whole conditional instantly (helps to avoid deeply nested conditions)
    guard temp2 == 10 else {break outerConditional}         //also useful to combine with multiple guards
    
    print("success")
}

//SWITCH
let myvar = 100
switch myvar {          //NOTE: cases are guaranteed to run in order from top to bottom
case 0:                 //idiomatic alignment for cases
    print(0)
    print("zero")       //multiple lines in cases fine
case 10:
    print(10)           //NOTE: no fall-through or breaks
case 11...99:           //RANGES supported too
    print("woah")
case 1, 2:              //combining multiple possibilities on one line
    print("eh")
default:                //switches must be exhaustive or there will be an error
    print("whatever")
}

let mystr = "bye"
switch mystr {          //switches in Swift can be anything (not just numbers) and cases can be expressions
case "h":
    print("h")
case "hi":
    fallthrough         //special operator to make a case fall-through to the next one explicitly
case "bye":
    print("hi")
case "cat", "dog":      //multiple on one line works for strings too
    print("animal")
default:
    print("default")
}

//SWITCH - MULTIPLE VARIABLES
switch (temp, temp2) {  //can switch on a tuple and have the cases be tuples
case (5, 10):
    print("5,10")
default:
    print("nothing")
}
let tuple = (val1: temp, val2: temp2)
switch tuple {          //can switch on a tuple and use dynamic tuple cases (NOTE: positions can match against names)
case (5, 10):
    print("5 or 10")
default:
    print("whatever")
}

//SWITCH - PARTIAL MATCHES
switch (temp, temp2) {
case (4, _):            //cases can use _ to mean if the other values match, I don't care what this value is (multiple allowed)
    print("5!")             //NOTE: since cases happen in order, more specific cases should happen first
case (5, let second):   //can also capture the values you don't care about in the match using 'let'
    print(second)
default:
    print("else")
}

//SWITCH - CALCULATED TUPLES
func fizzbuzz(number: Int) -> String {
    switch (number % 3 == 0, number % 5 == 0) {     //mapping number space into truth table
    case (true, false):
        return "Fizz"
    case (false, true):
        return "Buzz"
    case (true, true):                              //individual truth table combinations
        return "FizzBuzz"
    case (false, false):
        return String(number)
    }
}

//SWITCH - OPTIONALS
let myopt: String? = "hi"
let myopt2: String? = nil
switch (myopt, myopt2) {
case let (.some(opt), .some(opt2Matched)):      //.some(localName) lets you match if the optional is not nil (and use localName to refer to it)
    print("hi")                                 //note that you can use the same name or another one
case let (.none, .some(opt2)):                  //use .none to match nil
    print(opt2)
default:
    print("else")
}

//SWITCH LOOPS
for case (2) in [1, 2, 3, 4, 5] {            //specifying switch case as loop variable
    print("2")
}
for case (let x) in [1, 2, 3, 4, 5] {        //can also define variables like this
    print(x)
}
for case (5, let x) in [(5, 10), (5, 12)] {  //matching tuples (with a don't-care value that you capture)
    print(x)
}
for case let (x, y) in [(5, 10), (5, 12)] {  //preferred syntax for doing multiple let (also shows using all lets to iterate tuples)
    print(x)
}
for case let (5, y) in [(5, 10), (5, 12)] { //can still use the let version when specific values are included
    print(y)
}
let anyArray: [Any?] = [1, "hi", nil, 10]
for case let .some(datum) in anyArray {     //syntax for iterating over non-nil optional values in array
    print(datum)
}
for case let datum? in anyArray {           //same meaning as above
    print(datum)
}
//for case .cloudy(40) in forecast {}       //example of matching enum with associated value in a loop

//TYPE CHECKING
let myobj = "hello"
if myobj is String {            //"is" operator works in conditionals
    print("it's a string")
}
switch myobj {
case is String:
    print("It's still a string")        //"is" operator syntax in switches
default:
    print("it's something else")
}
//for label in view.subviews where label is UILabel {       //useful way to iterate controls of a certain type
    //print("Found a label with frame \(label.frame)")
//}
//for case let label as UILabel in view.subviews {          //syntax for filtering and casting at the same time
    //print("Found a label with text \(label.text)")
//}

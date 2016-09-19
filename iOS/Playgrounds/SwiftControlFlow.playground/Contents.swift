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
if let unwrapped = opt, let unwrapped2 = opt2 {
    //only executes if both unwrappings worked
}
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

//WHILE LOOPS
var z = 0
while true {            //basically like C but don't need ()
    if z == 10 {
        break           //break and continue work just like C
    }
    z += 2
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


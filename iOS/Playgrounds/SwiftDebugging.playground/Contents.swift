//print(s): goes to output window in debug area
print("hi")     //prints value with newline at end
print(5)        //print() accepts various types by default

let x = 5
print(x)        //can print() an expression that returns a printable value

print("The value is \(x)")  //string interpolation is useful

print(1, 2, 3)      //print is VARIADIC (default separator is space and default terminator is newline)
print(1, 2, 3, separator: "_")      //can specify separator and/or terminator like this
print(1, 2, 3, terminator: ".")         //NOTE: no newline this time because specified another terminator
print(1, 2, 3, "cat", separator: ",", terminator: "\n")      //can specify both and multiple types
//print(1, 2, 3, terminator: "\n", separator: ",")      //order needs to be right

//ASSERTING
assert(1 == 1)  //failure message is optional
assert(1 == 1, "Numbers don't work")
//assert(1 == 2, "Oopsies")     //HALTS the program like other languages
//NOTE: only happens in debug mode like other languages
//NOTE: condition will not even be evaluated in release mode (due to low-level magic)

//CODE INSPECTION (compile-time values)
let file = #file        //name of the currently executed file
let line = #line        //line number of the code
func test(line: UInt = #line) {
    print(line)
}
test()              //default function args are executed at the caller (line 29) not the function (line 25)

//CONDITIONAL COMPILATION
if _isDebugAssertConfiguration() {
    print("debug mode")
}

//DEBUGGING CRASHES
//Next time you get a crash, follow these instructions to get right to the problem: click on the objc_exception_throw in your thread, then type "po $arg1" into the debug area to get the human-readable version of the error. If you use exception breakpoints, you can even add the "po $arg1" command there so it’s automatic.


//NOTE: see XCode Notes for information about things like breakpoints

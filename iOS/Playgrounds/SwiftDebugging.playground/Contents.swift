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

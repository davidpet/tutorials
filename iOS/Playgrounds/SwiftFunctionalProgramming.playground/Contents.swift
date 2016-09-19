//DEFINE FUNCTION THAT TAKES FUNCTION
func transform(array1: [Int], array2: [Int], with: (Int, Int) -> Int) -> [Int] {        //type of function/closure is (argtypes) -> returnType
    var out: [Int] = []
    for i in 0..<array1.count {
        out.append(with(array1[i], array2[i]))
    }
    return out
}

//PASSING FUNCTION TO FUNCTION
func multiply(value1: Int, value2: Int) -> Int {        //define a function that matches the signature expected by transform()
    return value1 * value2                      //NOTE: it doesn't matter what the param names are as long as the arg types are right
}
let multiplied = transform(array1: [1, 2, 3], array2: [4, 5, 6], with: multiply)    //can just pass function name as an argument

//PASSING CLOSURE (lambda) TO FUNCTION
let multiplied2 = transform(array1: [1, 2, 3], array2: [4, 5, 6], with: {(s1: Int, s2: Int) -> Int in       //closures have (args) -> ret in code
    return s1 * s2
})

//TYPE INFERENCE IN CLOSURES
let a1 = [1, 2, 3]
let a2 = [4, 5, 6]
let multiplied3 = transform(array1: a1, array2: a2, with: {s1, s2 in s1 * s2})  //able to remove the arg types, return type, and return statement due to inference
let multiplied4 = transform(array1: a1, array2: a2, with: {$0 * $1})        //using shorthand argument names to make it even shorter
let multiplied5 = transform(array1: a1, array2: a2, with: *)                //passing operator as if function (takes the right args and returns the right thing)

//TRAILING CLOSURES
let multiplied6 = transform(array1: a1, array2: a2) {       //if closure is the LAST arg you can put a {} outside of the parenthesis to specify the closure
    (s1: Int, s2: Int) -> Int in return s1 * s2
}
let multiplied7 = transform(array1: a1, array2: a2) {       //normal closure syntax rules still apply
    return $0 * $1
}
let sorted1 = a1.sorted(){$0 > $1}      //sorting array using built-in sorted() function that takes closure
let sorted2 = a1.sorted {$0 > $1}        //if the () after a call is empty, you can even ommit it entirely

//CLOSURES AS DATA
let closure1: (Int, Int) -> Int = {$0 * $1}     //NOTE: type inference worked here
let closure2: () -> Void = {print("hi")}        //NOTE: no params looks like () and void return is Void (with capital) [also expression can be void]
var closure3: (() -> Void)?             //OPTIONAL
closure2()              //callable like a function

//FUNCTIONAL SEQUENCE METHODS (available for array, for instance)
let a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let sortedA = a.sorted {$0 > $1}    //takes a trailing closure that says how each pair of adjacent elements should be related [(Int, Int) -> Bool]
let doubledA = a.map {$0 * 2}       //get new array of transformed items of original
let stringedA = a.map {String($0)}  //map() allows you to return a different type (like Select in C#)
let filteredA = a.filter {$0 > 5}   //getting array of items that match a condition
let sum = a.reduce(0, +)        //like in Clojure, takes seed value and function of that type and new item that returns the cumulative result
let squares = a.reduce([:]) {   //getting a map like in Clojure
    var ret = $0                //have to change it to mutable (without this it refuses to set the value)
    ret[$1] = $1*$1
    return ret
}
squares
type(of: doubledA)          //NOTE: these return real arrays, not lazy sequences

//CAPTURING
func getCounter() -> () -> Int {        //returning closure from function
    var count = 0
    let f: () -> Int = {
        count = count + 1               //count is captured and exists even after returning
        return count
    }
    count += 5                          //because closures capture by REFERENCE, changing the original affects the closure
    f()                                 //this will change the local variable as well
    return f
}
let counter = getCounter()              //NOTE: counter is a constant but the captured value can still be changed
counter()
let counter2 = counter
counter2()                              //closures are a REFERENCE type
//WARNING: if you capture a class property of a class that owns a closure, you might create a CYCLE

//CONVENTIONS
//Use trailing closures when possible (defining and calling)

//QUESTIONS
//@selector still a thing?
//Lazy sequences?
//methods on dictionary?
//Partial applications?  Unbound methods?
//Is there a typedef in Swift for things like closures?
//Look up escaping closures when it comes up (@escaping)
//Look up autoclosures when it comes up (@autoclosure)
//Is there a way to lock objects (not variables) as constant so that you can safely pass them into functions?


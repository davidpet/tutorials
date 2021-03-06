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
//NOTE: see SELECTORS section for how to disambiguate overloaded functions

//PASSING CLOSURE (lambda) TO FUNCTION
let multiplied2 = transform(array1: [1, 2, 3], array2: [4, 5, 6], with: {(s1: Int, s2: Int) -> Int in       //closures have (args) -> ret in code
    return s1 * s2
})
let multiplied2b = transform(array1: [1, 2, 3], array2: [4, 5, 6], with: {(s1: Int, s2: Int) -> Int in       //closures have (args) -> ret in code
    let multiplied = s1 * s2
    return multiplied               //everything after the "in" is part of closure, so can be multiline
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

//IGNORING ARGUMENTS
func takeALambda(closure: (Int, Int, Int) -> Int) {
}
takeALambda {_ in           //the _ says we don't care about any of the args (could also specify for individual args)
    return 10
}

//CLOSURES AS DATA
let closure1: (Int, Int) -> Int = {$0 * $1}     //NOTE: type inference worked here
let closure2: () -> Void = {print("hi")}        //NOTE: no params looks like () and void return is Void (with capital) [also expression can be void]
var closure3: (() -> Void)?             //OPTIONAL
closure2()              //callable like a function

//CALLING INLINE
let hi = { return "hi" }()      //creating temporary closure and calling it immediately (type inference used)

//FUNCTIONAL SEQUENCE METHODS (available for array, for instance)
let a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let sortedA = a.sorted {$0 > $1}    //takes a trailing closure that says how each pair of adjacent elements should be related [(Int, Int) -> Bool]
let doubledA = a.map {$0 * 2}       //get new array of transformed items of original (could be multithreaded, etc.)
let stringedA = a.map {String($0)}  //map() allows you to return a different type (like Select in C#)
a.forEach {print($0 * 12)}          //like map() but returns nothing and guaranteed to be called in sequence
let filteredA = a.filter {$0 > 5}   //getting array of items that match a condition
let sum = a.reduce(0, +)        //like in Clojure, takes seed value and function of that type and new item that returns the cumulative result
let squares = a.reduce([:]) {   //getting a map like in Clojure
    var ret = $0                //have to change it to mutable (without this it refuses to set the value)
    ret[$1] = $1*$1
    return ret
}
let groups = a.reduce([Int: [Int]]()) {     //GROUP BY even vs. odd
    var out = $0
    let key = $1 % 2
    out[key] = (out[key] ?? []) + [$1]
    return out
}
type(of: doubledA)          //NOTE: these return real arrays, not lazy sequences

//OPTIONALS and FLATMAP
//NOTE: optionals act like containers with regard to FP functions
let optInt: Int? = 5
let mapped = optInt.map {$0 * 10}       //can call map on optional (nil if the thing was nil, transformed value otherwise)
let mixedSeq: [Any?] = ["a", nil, 3, nil, "b"]
let flatMapped = mixedSeq.flatMap {$0}          //flatMap() is like map() but it throws away nil values (like filter) and then makes non-optional type
print(flatMapped)
let flatMapped2 = mixedSeq.flatMap {$0 ?? "cat"}
print(flatMapped2)                              //flatMap() filters out nil AFTER the mapping
//NOTE: name implies philosophically similar to joined() on a multidimensional array
//NOTE: to throw away nil but maintain optional type, use filter()
let multiArray = [[1, 2], [3, 4], []]
let flatMapped3 = multiArray.flatMap {$0}       //flatMap() also concats by 1 level like joined() if called on multidimensional
print(flatMapped3)

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
class MyClass {var x: String = "hi"}
let local = MyClass()
let local2 = MyClass()
let mylambda = { [unowned local, local2] (param: String) -> String in       //capture specification: local and local2 are both unowned
    return local.x + local2.x + param                           //NOTE: this is useful for things like adding a UIAlertController action that references the controller itself
}
//NOTE: if you already captured something (eg. unowned self) in a closure, then closures inside it don't need that explicitly (can just use self directly)

//NOTE: closures are REFERENCE TYPES and taking multiple references will refer to same capture variables
//NOTE: closures that capture class members must explicitly refer to them with 'self'

//ESCAPING
//NOTE: by default, closures passed into functions are non-escaping (which means they can't be used after function ends) [compile optimization]
func takeMyLambda(closure: @escaping () -> Void) -> (() -> Void) {      //need the @escaping attribute to allow this closure to be used after return
    return closure
}
let mystoredlambda = takeMyLambda {print("yay!")}
mystoredlambda()
//NOTE: could also use for storing an array, etc., not just returning

//AUTOCLOSURES
//code provided in the parameter is automatically turned into a closure
func shortCircuit(_ lhs: @autoclosure () -> Bool, _ rhs: @autoclosure () -> Bool) -> Bool {
    return lhs() && rhs()
}
print(shortCircuit(1 == 1, 2 == 1))     //the code is not evaluated until the closure is called
//NOTE: this kind of mechanism is how == can be properly implemented
func autoTest(_ closure: @autoclosure () -> String) {
    print(closure())
}
autoTest("hi")      //expressions automatically become return value of autoclosure
func autoTest2(_ closure: @autoclosure () -> String = String()) {       //default parameters can be arbitrary expressions
    print(closure())
}
autoTest2()

//INSTANCE METHODS
class MyClassClosureTestClass {
    var x = 5
    
    func myfunc() {print("mcct")}
    static func mystaticfunc() {print("static")}
    
    func getclosure() -> (Void) -> Void {
        return myfunc                       //can return instance methods from other instance methods (and will be implicitly bound)
    }
    static func getstaticclosure() -> (Void) -> Void {
        //return myfunc     not allowed because no instance
        return mystaticfunc             //can return static methods from other static methods
    }
    
    func getXAdder() -> (Void) -> Void { return {[unowned self] in      //closures sent outside of a class need to use self and probably want to take a weak reference to it
            self.x += 1
        }
    }
}
print("CLASS METHODS")
let mcct = MyClassClosureTestClass()
let classclosure = mcct.myfunc
let staticclosure = MyClassClosureTestClass.mystaticfunc
classclosure()          //static and instance closures (once bound) are just like functions
staticclosure()

//FUNCTORS and MONADS
//Functor = type that implements map (such as array)
//Monad = functor that also implements flatMap (such as array)
//full definition of monad is more extensive, but this is the Swifty one

//LAZY PROPERTIES
class MyNode {
    init() {
        print("MyNode initialized")
    }
}
class MyCollection {
    var array = [1, 2, 3, 4, 5]
    
    lazy var mynode = MyNode()        //stored property, initializer not used until first time property is retrieved
    lazy var reversed2: [Int] = {       //also a stored property but stores a closure that gets evaluated on first initialization
        print("getting closure stored property")
        return self.array.reversed()    //have to use 'self' explicitly inside (implicitly becomes unowned in a lazy property)(non-escaping)
    }()     //calling the closure
    static let mynode = MyNode()        //static constants like this on a class are automatically computed lazily
}
print("creating mc")
var mc = MyCollection()                 //even though it looks like it, MyNode initializer isn't called yet
print("getting stored property")
print(mc.mynode)                      //this is where the property actually gets initialized (and stays that way)
//NOTE: if multiple threads retrieve the stored proprety the first time, it may end up getting called multiple times
print(mc.reversed2)         //closure is not evaluated until now
print("getting static let")
print(MyCollection.mynode)
//NOTE: the property is only calculated the first time and is then cached like a normal property (MEMOIZATION)

//LAZY SEQUENCES
var lazySequence = Array(0...199).lazy     //the non-lazy collections contain a lazy property that gives you a lazy sequence on that collection
lazySequence[5]                           //you can still do the same kind of access (in this case random)
var lazySquares = lazySequence.map { (val: Int) -> Int  in         //lazy sequences have the same functional extension methods, but they return another lazy sequence
    print("squares computed for \(val)")
    return val * val
}
print(lazySquares[5])                    //the square is only computed for the value 5 here (not 0 to 4 or anything above 5)
print(lazySquares[5])                    //lazy sequences DO NOT use MEMOIZATION
//NOTE: lazy sequences are just special types that act like the non-lazy equivalents
//NOTE: fibonacci lazy sequence would recursively add two previous values (but without memoization will be rather inefficient for repeated calls)

//HEAD AND TAIL
let tail = lazySequence.dropFirst()
let head = lazySequence.first
let eleventandhigher = lazySequence.dropFirst(10)
//NOTE: these are on arrays and stuff too (not just lazy sequences)

//SELECTORS
//for compatibility with existing code (holdover from Objective-C)
//similar to closures but not as integrated into the syntax and only usable for class instance methods on classes that inherit from NSObject
import Foundation           //required to use selectors
func myselectortest() {
}
class myselectortestclass: NSObject {       //you must inherit from NSObject to use selectors for your class methods
    func myfunc() {
        print("no args")
    }
    func myfunc(_ x: Int) {
        print("_ arg")
    }
    func myfunc(_ x: Int, y: Int) {
        print("2 args")
    }
    func myfunc(a: Int, b: Int) {
        print("2 explicit args")
    }
    func myuniquefunc(x: Int) {
    }
    static func mystaticfunc() {
    }
    static func testSelectors() {
        //specifying for different arg scenarios
        _ = #selector(myuniquefunc)     //unambiguous to ARGS NOT NEEDED (even though has some)
        _ = #selector(myuniquefunc(x:)) //can specify the arg IF YOU WANT
        _ = #selector(mystaticfunc)         //allowed to declare for STATIC and CLASS methods too (but there doesn't seem to be a way to call it)
        //_ = #selector(myfunc)         //AMBIGUOUS
        _ = #selector(myfunc(_:))           //refers to the one that takes an int with _ (doesn't seem to be a way to refer to the one that takes no arguments)
        _ = #selector(myfunc(_:y:))       //specifying MULTIPLE parameters
        _ = #selector(myfunc(a:b:))     //specified by NAMES, not types
        _ = #selector(self.myuniquefunc)        //can use self (eg. if you were in a closure)
        
        //selector object
        var sel: Selector = #selector(myuniquefunc)     //selectors are of type Selector and are not strongly typed
        sel = #selector(myfunc(_:))                //selectors can be interchanged regardless of name and parameters in functions
        
        //calling selectors
        let mstc = myselectortestclass()
        mstc.perform(sel, with: 10)         //called through instance using NSObject perform (various overloads for different argument scenarios)
        mstc.perform(sel, with: 10, afterDelay: 1)          //make it ASYNCHRONOUS (although it will be called back on the current thread (in the run loop when available)
        mstc.performSelector(inBackground: sel, with: 10)       //ASYNCHRONOUSLY dispatch to BACKGROUND THREAD
        //mstc.perform(#selector(mystaticfunc))         //pretending a static is an instance method does not work
        //NSObject.perform(#selector(mystaticfunc))     //it looks like this should work, but it doesn't
        //there are tons of overloads of these methods
    }
}
//let sel1 = #selector(myselectortest)      //NOT ALLOWED for functions that are not methods
print("testing SELECTORS")
myselectortestclass.testSelectors()
_ = #selector(myselectortestclass.myuniquefunc(x:))     //can take selectors EXTERNALLY just by putting class name in front

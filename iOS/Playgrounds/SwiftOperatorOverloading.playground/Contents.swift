import Foundation //to get access to pow()

//defining a new precedence type (can also use existing ones)
precedencegroup ExponentiationPrecedence {
    higherThan: MultiplicationPrecedence            //exponentiation goes before multiplication in order of operations
    associativity: right        //if chained operator together, how would they auto-group (in this case (x ** (y ** z))
}

//defining an arbitrary new operator
infix operator **: ExponentiationPrecedence     //can make your own precedence group or use an existing one
//NOTE: use prefix or postfix if operator on single item

//defining behavior of the operator
func **(lhs: Double, rhs: Double) -> Double {       //syntax for defining operator behavior
    return pow(lhs, rhs)
}

//using the operator
2 ** 5
2**5
2**5**2 //same as 2**(5**2) due to associativity

//NOTE: can overload existing operators by redefining any of these pieces for it or adding new function, etc.
//NOTE: operators can be static methods on classes too (some protocols use that)

//EXAMPLE: tutorial shows redefining precedence group for ... and then making 1...2...3 work

//COMPARABLE
struct Dog: Comparable {      //comparable protocol lets you make an item support min(), max(), sorted() for arrays of them
    var breed: String
    var age: Int
    
    static func <(lhs: Dog, rhs: Dog) -> Bool {
        return lhs.breed < rhs.breed
    }
    static func ==(lhs: Dog, rhs: Dog) -> Bool {
        return lhs.age == rhs.age
    }
}

//OPERATOR METHODS
struct MyStruct {
    var value: Int
    
    static func +(lhs: MyStruct, rhs: MyStruct) -> MyStruct {       //binary operator between two of the type
        return MyStruct(value: lhs.value + rhs.value)
    }
    
    static func +(lhs: MyStruct, rhs: Int) -> MyStruct {            //binary operator between the type and something else
        return MyStruct(value: lhs.value + rhs)
    }
    
    static func +(lhs: Int, rhs: MyStruct) -> MyStruct {            //other polarity is required explicitly to support that direction
        return MyStruct(value: lhs + rhs.value)
    }
    
    //NOTE: for operators like += can use inout parameters
}
let mystruct = MyStruct(value: 10)
let mystruct2 = MyStruct(value: 20)
(mystruct + mystruct2).value
(10 + mystruct2).value

//SUBSCRIPT OPERATORS
struct Square {
    subscript(index: Int) -> Int {          //no func keyword, no static (because it operates on instance), acts like a property except for the parameter list
        return index * index
    }
    
    subscript(keyword: String) -> String {      //can have multiple subscripts and have any input and output types
        get {
            return keyword + keyword
        }
    }
    
    subscript(index1: Int, index2: Int) -> Int {        //can even have multiple input parameters
        get {
            return index1 * index2
        }
        set {
            print(index1 * index2 * newValue)               //can be read-only or have a setter too
        }
    }
}
var square = Square()
square[10]
square[10, 11]                  //calling with multiple indices does not use parameter names, and is comma separated
square["hi"]
square[10, 11] = 100

//CLASSES, STRUCTS, METHODS
//all support operator overloading

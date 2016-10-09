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
//EXAMPLE: tutorial shows redefining precedence group for ... and then making 1...2...3 work

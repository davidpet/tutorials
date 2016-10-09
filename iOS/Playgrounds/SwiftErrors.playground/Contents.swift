//to provide your own errors, implement Error protocol in enum like this
enum PasswordError: Error {
    case empty      //your own fields
    case short          //each value of the enum is a reason for the error to have been thrown
    case obvious(message: String)
}

//defining a function that throws errors
func encrypt(name: String, password: String) throws -> String {     //specify throws before return value (or lack thereof)
    if password.isEmpty {
        throw PasswordError.empty       //syntax for throwing a value of the enum
    }
    
    return name + "_" + password
}

//catching errors
do {        //try/catch must happen in a do block
    let encrypted  = try encrypt(name: "Bob", password: "") //try returns the actual type but it lets you catch
    print(encrypted)
}
catch PasswordError.empty {         //catching specific errors
    print("Empty password")
}
catch PasswordError.obvious(let message) {      //NOTE: could use 'where' and stuff like that just like with enums
    print(message)          //similar to switch statement syntax for handling enum values
}
catch {                         //catching other errors
    print("some other error")           //NOTE: this is not required as try/catch does not have to be exhaustive
}
//NOTE: you cannot throw if you don't specify throws

//error propagation
func functionC() throws {
    throw PasswordError.short
}
func functionB() throws {       //if want errors to leak out, have to specify throws
    try functionC()             //try allowed outside of do{} if not going to handle the error
}
func functionA() {
    do {
        try functionB()         //catching at 2nd level without throwing
    }
    catch {
        print("caught!")
    }
}
functionA()

//closure typing
let closure1: (String, String) throws -> String = encrypt       //throws statement goes where you'd expect
//let closure2: (String, String) -> String = encrypt        //cannot assign a throwing to a non-throwing reference (because it may throw)
let closure3: (String, String) throws -> String = {(a: String, b: String) -> String in return a + b }       //CAN assign non-throwing to throwing (because at least as safe)
//NOTE: all these rules apply to function parameters, etc. of course

//try vs. try? vs. try!
//NOTE: as shown above, try requires catch or throws and tends to go in do {}
let encryptedValue: String? = try? encrypt(name: "Bob", password: "blank")      //try? lets you return nil if an error is thrown
if let encryptedValue2 = try? encrypt(name: "Bob", password: "blank") {}        //conditional block depending on whether error thrown
let encryptedValue3 = try! encrypt(name: "Bob", password: "blank")              //try! will force unwrap and just crash if error is thrown (much like regular !)
try? encrypt(name: "Bob", password: "blank")                                    //like UDP (ignoring failures)

//ASSERT
//see SwiftDebugging playground

//NOTE: error handling is just as efficient as 'return' according to Apple

//CONVENTIONS
//Order of preference should be try, try?, try!

//QUESTIONS
//Can you rethrow (eg. with empty throw)?
//What does rethrows do?  (maybe the video for the course makes it clearer)
//Can you specify specific types that are thrown in throws like in C++?


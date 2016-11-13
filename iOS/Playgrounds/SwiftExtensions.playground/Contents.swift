//extensions can add members to STRUCTS, CLASSES, ENUMS, or PROTOCOLS

//can add even to types that you DO NOT HAVE CODE FOR (including BUILT-IN types)

//BASICS
//10.square()       //declaration order matters
extension Int { //everything in here is an extension to integers that is available automatically to anybody seeing this declaration
    func square() -> Int {
        return self * self      //use self because it's like any other method of the type
    }
}
5.square()          //automatically available for integers now (even literals)

extension Integer {         //extending whole class of numbers (by way of protocol they support)
    func square() -> Self {     //using Self to represent the type of the actual object
        return self * self          //otherwise works the same way
    }
}

//ADDING PROTOCOLS
protocol MyProtocol {
    func dostuff()
}
extension Int: MyProtocol {     //NOTE: can have multiple extensions for same type even in same file
    func dostuff() {}
}
5.dostuff()         //now you can use an int in place of a MyProtocol because you added it in this scope

//PROTOCOL EXTENSIONS
protocol MyProtocol2 {
    func dostuff()
    //fun dostuff2()        //ommiting method from protocol itself
    func dostuff3()
    //func dostuff4()
}
extension MyProtocol2 {
    func dostuff() {print("p1")}        //DEFAULT IMPLEMENTATION (can only be added by extension) for classes that don't provide their own
    func dostuff2() {print("p2")}          //providing method implementation that wasn't in the actual protocol
    func dostuff3() {print("p3")}
    func dostuff4() {print("p4")}
}
class MyProtocol2Impl: MyProtocol2 {
    func dostuff3() {print("c3")}        //providing implementation of method that is in protocol
    func dostuff4() {print("c4")}                  //provide implementation of method that is in protocol extension but not protocol
}
print("BEGIN EXTENSION")
let mpi = MyProtocol2Impl()
mpi.dostuff()
mpi.dostuff2()
mpi.dostuff3()
mpi.dostuff4()                  //specific class methods always used if available and called through CLASS type
print("MIDDLE EXTENSION")
let mp2 = mpi as MyProtocol2
mp2.dostuff()
mp2.dostuff2()
mp2.dostuff3()                  //for methods in the protocol itself, an instance of the protocol goes to the CLASS method (class overrides protocol extension)
mp2.dostuff4()                  //for methods not in the protocol but in the extension, an instance of the protocol goes to the EXTENSION (because class not known)
print("END EXTENSION")
//summary: when called through class, class implementations always win
//summary: when called through protocol, protocol extension implementations win unless method is declared in protocol itself (which makes it virtual)
//another way to look at it: the original protocol (not extension) defines a virtual table while extensions and class declarations just fill it in or replace each other

//EXTENDING GENERICS
extension Array {           //full type of an array is Array<Element> but you just say the name of the generic here
    func printMyType() {
        print(Element.self)     //use Element (the type argument in the generic) w/in the extension to refer to the type the item has been instantiated with
    }
}
[1, 2, 3].printMyType()
extension Array where Element: Integer {        //constraining the extension by type of element
    func getSum() -> Element {
        return self.reduce(Element.allZeros, +)     //won't let you use LITERAL so use these kinds of static members of the protocol instead
    }
}
[1, 2, 3, 4].getSum()
extension Collection where Iterator.Element: Integer {  //constraining by types that are within the type
}

//INITIALIZERS (eg. CONVERSION)
struct MyClass {
    var value: Int
}
extension Int {
    init(_ a: Int, _ b: Int, _ c: Int) {        //can add initializers via extensions
        self = a*b*c
    }
    
    init(_ mc: MyClass) {           //custom conversion from your class to existing type
        self = mc.value
    }
}
Int(10, 20, 30)
Int(MyClass(value: 10))

//MUTATING METHODS
//allowed
extension Int {
    mutating func plusOne() {
        self += 1               //NOTE: only allowed because MUTATING (required if you're going to change self)
    }
}
//5.plusOne()       //calling on constants or literals not allowed if MUTATING

//NESTED TYPES (adding)
//allowed

//SUBSCRIPTS
extension String {
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
"hi"[1]         //can use extensions to fix annoying limitation in built-in stuff

//POP (Protocol-Oriented Programming)
//builds on many of the OOP concepts (extension of OOP, not replacement)
//includes protocols, extensions, and protocol extensions (special version of polymorphism)
//horizontal rather than vertical programming (OOP = vertical)
//can be seen as similar to multiple inheritence, but since you can't add stored properties (state) via protocols, it keeps complexity low
//easier to add/modify/extend than classes
//Integer is protocol to extend to affect all integer types
//NOTE: through protocol extensions, you can add functionality, not just interfaces (including to built-in types via built-in protocols)
//NOTE: use Self to represent the type of the object (eg. in Integer to represent the real thing like Int)
//NOTE: a lot of things you can do by extending Collection with constraint of Iterator.Element (or something like Array with Element)

//POP EXAMPLES
//1. adding squared() method to all numbers: add protocol extensions for Integer
//2. clipping numbers: take two instances of Self in a protocol extension method
//3. adding functionality to all equatable types: extend Equatable protocol (w/ implementation)
//4.

//LIMITATIONS
//can add COMPUTED properties but not STORED ones
//cannot add property OBSERVERS to existing properties
//cannot add designated initializers or deinitializers
//Objective-C does not see protocol extensions (so extending a UIKIt protocol, for instance, won't work)(extending a protocl you marked @objc won't work either)

//CONVENTIONS
//Common naming scheme for extensions in source files: Type+Modifier.Swift (eg. String+RandomLetter.Swift)
//Also will commonly see something like String+Additions.Swift because it's timing consuming and ugly to make a file for each thing you add

//QUESTIONS
//make sense of this: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID215
//@objc keyword for extensions?
//Do you have to use mutating for all types when change self, or just built-in numerics?  Also what if changing member of self?
//Multiple constraints on extension?

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

//ADDING PROTOCOLS
protocol MyProtocol {
    func dostuff()
}
extension Int: MyProtocol {     //NOTE: can have multiple extensions for same type even in same file
    func dostuff() {}
}
5.dostuff()         //now you can use an int in place of a MyProtocol because you added it in this scope

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

//NESTED TYPES (adding)
//allowed

//SUBSCRIPTS
extension String {
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
"hi"[1]         //can use extensions to fix annoying limitation in built-in stuff

//LIMITATIONS
//can add COMPUTED properties but not STORED ones
//cannot add property OBSERVERS to existing properties
//cannot add designated initializers or deinitializers

//QUESTIONS
//make sense of this: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID215


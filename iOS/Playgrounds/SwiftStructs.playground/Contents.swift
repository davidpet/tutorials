//DECLARING
struct Person {
    var clothes: String         //properties
    var shoes: String
    //var myvalue: String?          //WARNING: even optional values are part of the memberwise initializer
}

//INITIALIZING
var joe = Person(clothes: "t-shirt", shoes: "sneakers")     //automatically gets member-wise initializer
//let bob = Person(shoes: "sneakers", clothes: "t-shirt")   //can't change the order of the members

//DEFAULT AND OPTIONAL VALUES
struct MyLooseStruct {
    var x: Int
    var y: Int = 10
    var z: Int?
}
let mls = MyLooseStruct(x: 10, y: 20, z: 30)        //the default memberwise initializer still requires everything (if you don't like it, provide your own)

//DELEGATING INITIALIZER (and OVERLOADING)
//simpler than classes because you can't inherit - initializers can call other initializers in same struct
struct MyDelegator {
    var x: Int
    var y: Int
    var z: Int?
    
    init(x: Int, y: Int, z: Int) {      //allowed to replace memberwise initializer
        self.init(x: x, y: y)               //allowed to call other initializers
        self.z = z                      //can initialize other members but only AFTER the other initializer is called
    }
    
    init(x: Int, y: Int) {
        self.x = x          //required to initialize x and y by end of initializer (but z is optional)
        self.y = y
    }
    
    init() {
        self.init(x: 10, y: 20, z: 30)      //all non-optional values must be set before initializer returns
    }
}

//FAILABLE INITIALIZERS (allowed on structs, classes, and enums)
//all the normal initializer rules still apply (eg. inheritence)
class MyFailableClass {
    var x: Int
    
    init?(x: Int) {             //initializer that can fail marked with ?
        guard x > 0 else { return nil }         //return nil to fail (but don't return anything to succeed)
        self.x = x
    }
    
    /*init!(x: Int) {       //could also make it implicitly unwrapped
                            //NOTE: you can even switch between ? and ! when overriding
    }*/
    /*init(x: Int) {                //cannot overload by same name and params if failability is only difference (but having non-failable ones in here is fine)
        self.x = x
    }*/
}
let mfc: MyFailableClass? = MyFailableClass(x: 10)      //constructing using a failable initializer will return an optional value

//ACCESSING MEMBERS
joe.clothes = "jacket"      //just like C++

//CONSTANTS
let bob = Person(clothes: "sweatshirt", shoes: "boots")
//bob.clothes = "t-shirt"     //can't change the members of a constant struct
var bob2 = bob
bob2.clothes = "t-shirt"      //since independent copy, does not matter if you change it
print(bob.clothes)

//VALUE TYPE
var person1 = Person(clothes: "t-shirt", shoes: "sneakers")
var person2 = Person(clothes: "sweathshirt", shoes: "boots")
var personCopy = person1        //because structs are value types, personCopy is an independent copy of person1
person1.clothes = "robe"
person1
personCopy                      //changing person1 did not affect personCopy

//BOXING
//to do boxing/unboxing (or nullable) make your own class which holds the value type as a member

//INHERITENCE
//struct Singer: Person {       //a struct CANNOT inhert
//}

//METHODS
struct Singer {
    var name: String
    var volume: Int
    
    func sing() {           //can have methods just like a class (with implicit vs. explicit self and everything)
        print("singing at \(volume) volume.")
    }
    
    mutating func changeName() {        //for value types like enums and structs, you need 'mutating' keyword on method if going to change a property
        name = "changed"        //NOTE: could also assign self to change the whole structure in a mutating method
    }
}

//PROPERTY OBSERVERS
struct Car {
    var color: String {     //use {} to make a property observable instead of just a field
        willSet {       //built-in observer for detecting a change that is about to happen
            print("About to repaint from \(color) to \(newValue).")         //newValue is special value for what is about to be the value
        }
        
        didSet {        //built-in observer for detecting a change that just happened
            print("Just repainted from \(oldValue) to \(color).")           //oldValue is a special value for what used to be the value
        }
    }
    /*
    var myval: Int = 0 {        //NOTE: can set a default value like this
        didSet {
            print(myval)
        }
    }*/
}
var car = Car(color: "blue")
car.color = "red"           //the observers are automatically triggered when changing the property like this

//COMPUTED PROPERTIES
struct Circle {
    var radius: Int
    
    var diameter: Int {         //similar to above syntax but uses get and set
        get {
            return radius * 2       //return for get
        }
        
        set {
            radius = newValue / 2   //newValue for set
        }
    }
    
    var area: Int {             //implicit readonly property (don't need to specify get)
        return Int(3.14 * (Double(diameter / 2)) * (Double(diameter / 2)))
    }
}
//NOTE: the other kind of properties (that act like variables) are called STORED PROPERTIES

//STATIC
struct MyStruct {
    var x: Int
    static var s: Int = 10      //static variable with initialization
    
    static func doStuff() {     //static method
    }
    
    func doOtherStuff() {
        MyStruct.doStuff()      //instance method can't refer to statics directly - must use CLASS NAME
    }
}
var ms = MyStruct(x: 5)         //static property not part of initializer
//ms.doStuff()                  //not allowed to access statics via instances
MyStruct.doStuff()              //use class name with . to access statics (like C#)

//ACCESS CONTROL
struct MyOtherStruct {
    var x: Int
    
    func dostuff() {
        doprivatestuff()        //calling private
    }
    
    private func doprivatestuff() {     //private method can only be called inside the class
    }
    
    private(set) var myproperty: Int        //can use private(set) [or another access modifier] to say that the setter is more restricted than the getter
                                                    //getter has same access level as the property itself
                                                //NOTE: this is equally true of stored and computed properties
    private(set) var myproperty2: Int {
        get {
            return 5            //accessible wherever the property is
        }
        set {
            //this is only accessible inside the class
        }
    }
}
//NOTE: there is no protected in Swift

//FACTORY INFERENCE
struct MySpecialStruct {
    var x: Int
    
    func dostuff() -> Int { return x }
    static func getvalue() -> MySpecialStruct { return MySpecialStruct(x: 10) }
}
let mss = MySpecialStruct(x: 10)
let mss2: MySpecialStruct = .getvalue()         //special case that's allowed to let you infer factory methods (used in libraries)

//CONVERSIONS
//see SwiftExtensions for how to add conversion operators to convert your type to another type (like Int)

//PROTOCOLS
//see SwiftClasses for explanation of protocols
//NOTE: structs automatically get initializer that sets all the fields by name, and this counts towards a protocol that needs it (eg. in bitfields - see SwiftEnums)

//PRINTING
//to support printing at the console or string interpolation, conform to the Printable protocol (or DebugPrintable)


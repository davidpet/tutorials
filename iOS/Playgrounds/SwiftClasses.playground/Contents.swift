//DECLARING
class Basic {
    var x: Int?
}
var basic = Basic()                             //if no non-default or non-optional properties, class has default initializer

class Person {
    var clothes: String                         //defining properties just like with struct
    var shoes: String
    
    var tie = false                             //DEFAULT value for new instances
    var watch: String?                         //OPTIONAL value (might be nil)
    
    var calculatedAtStart = 10 + 5              //initializers can do math and things like that
    var calculatedAtStart2 = { return 10 }()    //creating a closure and calling it at the same time in-place immediately
    
    let myConst: Int                            //constant values can be deferrred to the initializer for computation
    
    //initializers (constructors) don't use func and don't return anything
    init(clothes: String, shoes: String) {      //REQUIRED for any properties that are not optional or defaulted (can't create without params anymore)
        //printClothes()                        //ILLEGAL to call any methods before all values are initialized
        
        self.clothes = clothes                  //NOTE: self like Python but not passed in as a param
        self.shoes = shoes
        self.myConst = 5
        
        printClothes()                          //ok to call the method now
        
        tie = true                              //the SELF is only needed if there is ambiguity
    }
    
    func printClothes() {                       //METHOD looks and acts just like normal function definition
        print(clothes)                          //implicit SELF
    }
    
    func sing() {
        print("I don't know how")
    }
    
    func changeTie(tie: Bool) {                 //method that changes state
        self.tie = tie
    }
}

var person = Person(clothes: "tshirt", shoes: "sneakers")   //construct with name of class and parameters defined by initializer
person.sing()                                               //calling method like any other language
                                                            //NOTE: members can be accessed outside of the class by default (not locked to private like C++)

//PROPERTY OBSERVERS, COMPUTED PROPERTIES, STATIC, and ACCESS CONTROL
//see: SwiftStructs playground (syntax is the same)
//in addition, can define a variable with "private" in front

//INHERITENCE
class Singer: Person {                          //only ONE base class allowed just like in C#
    override func sing() {                      //OVERRIDE keyword required to change base method (automatically virtual)
        print("la la la")
    }
}

var singer = Singer(clothes: "tshirt", shoes: "sneakers")       //base INITIALIZER has been inherited
singer.sing()                                                   //overridden method is called here

class HeavyMetalSinger: Singer {
    var volume: Int             //adding a member that isn't on the base is fine
    
    init(clothes: String, shoes: String, volume: Int) {     //adding a new non-optional and non-defaulted property triggered need for a new initializer
        self.volume = volume
        super.init(clothes: clothes, shoes: shoes)      //calling base class initializer with SUPER
    }
    
    override func sing() {
        if volume < 100 {
            super.sing()                                //calling base class method from overridden method
        }
        else {                              //NOTE: you can override computed properties too
            print("ahhhh")
        }
    }
}

var heavyMetalSinger = HeavyMetalSinger(clothes: "leather", shoes: "boots", volume: 99)
heavyMetalSinger.sing()

//REFERENCE
var personRef = person                      //unlike struct, class is a reference type
personRef.clothes = "kimono"
print(person.clothes)                       //changing the other reference changed the original
weak var personRef2 = person                //weak reference (won't prevent garbage collection)
personRef2?.clothes                     //weak references act like optionals because they can be nil if the object has been DESTROYED
unowned var personRef3 = person         //unowned is like weak but doesn't make the thing optional (up to you to guarantee app doesn't blow up)
personRef3.clothes
personRef = Person(clothes: "", shoes: "")      //allowed to REBIND reference even if not optional

//POLYMORPHISM
var b: Person = Singer(clothes: "tshirt", shoes: "sneakers")    //base reference to a more derived class
b.sing()                                                        //derived version is called (like virtual in C++)
var a = [heavyMetalSinger, person]      //type inference chooses [Person] because it's common base (could specify it explicitly too)
var a2: [Person] = [heavyMetalSinger]
var a3 = a2 as! [HeavyMetalSinger]      //can cast whole array polymorphically
var castedSinger: Singer? = b as? Singer        //cast that will return nil if fails
var castedSinger2: Singer = b as! Singer        //cast that will CRASH if fails (only use if sure)
var castedPerson = castedSinger2 as Person      //casting to base is GUARANTEED and therefore you can use 'as'
if let singer = b as? Singer {            //idiomatic way of branching based on type
}
else if let heavyMetalSinger = b as? HeavyMetalSinger { //NOTE: ok to use these names to hide the outside scope versions
}
//not actually a special syntax, everything a and to the right is just an expression that returns a [HeavyMetalSinger]
for heavyMetalSinger in a as? [HeavyMetalSinger] ?? [HeavyMetalSinger]() {
}

//CONSTANTS (behave differently from STRUCT constants)
let p = Person(clothes: "shirt", shoes: "slippers")     //declaring constant class instance
p.sing()                    //ok to read and call methods on constants
p.shoes = "other"         //CAN change member of constant
p.changeTie(tie: true)         //CAN call method that changes member of a constant
//p = Person(clothes: "", shoes: "")    //the only thing that makes it constant is you can't assign to another instance

//PROTOCOLS
protocol MyProtocol {                       //protocol is like an interface in C#
    var description: String { get set } //just an interface, so you say get and/or set for property
    
    func adjust()                       //specify methods that must be implemented
    static func s()             //unlike with interfaces, statics are allowed in protocols (and force statics in the class)
}
class MyBaseClass {
}
class MyClass: MyBaseClass, MyProtocol {        //can only use 1 base class but UNLIMITED protocols
    func adjust() {
    }
    static func s() {
    }
    
    var description: String = "my description"  //must implement AT LEAST what is in the protocols
}
class MySubClass: MyClass {             //inherited classes automatically conform to the protocol as well
}
var mp: MyProtocol = MySubClass()     //can basically treat a protocol like a REAL CLASS in code (casting, etc.)
class MyFloatingClass {
    func adjust() {
    }
    static func s() {
    }
    
    var description: String = "my description"  //must implement AT LEAST what is in the protocols
}
extension MyFloatingClass: MyProtocol {}        //adding protocol to class after the fact (could add more members in the {}) (NOTE: works for built-in types too)
var mp2: MyProtocol = MyFloatingClass()         //within the scope of the extension, can treat the class as if the protocol were declared in the class statement
//NOTE: protocols can be used for structs and enums as well
//NOTE: built-in types already conform to protocols (eg. ints are equatable and Integer)
//NOTE: see Swift Generics playground for Self keyword in protocols

//FINAL
final class MyFinalClass {var x = 5}
//class MyFinalClass2: MyFinalClass {}      //can't inherit a final class
MyFinalClass().x = 10
class MyOpenClass {final func x() -> Int { return 10}}
//class MyOpenClass2 : MyOpenClass { override func x() -> Int { return 20 }}     //can't override a final method

//CONVENTIONS
//class names start with capital and methods/properties start with lowercase
//use structs unless you need to use classes (structs = safety, classes = flexibility)
//Mark things as final whenever you can - it provides a compiler optimization boost and reduces complexity

//QUESTIONS
//How do you clone/copy a class instance?
//Is there a way to prevent variable references being taken to a constant?  Or to make it a true runtime constant?
//Overloading operators, conversions, etc?
//How to do extension methods (or whatever joined() of Array<String> is)
//Are there still failable initializers with ? behind?  If so, need to relearn it in Swift 3.
//Are there still convenience and designated initializers?
//Can you delegate to other initializers in the same class?
//How to do optional items in protocols like the libraries have?
//How to check multiple protocols in class like <> in objective-c?
//How to make protocol conform dynamically instead of doing extension
//Making classes equatable and comparable (and enabling == on address)(how to check if same object the normal way)?



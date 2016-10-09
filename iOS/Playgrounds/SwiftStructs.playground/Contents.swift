//DECLARING
struct Person {
    var clothes: String         //properties
    var shoes: String
}

//INITIALIZING
var joe = Person(clothes: "t-shirt", shoes: "sneakers")     //automatically gets member-wise initializer
//let bob = Person(shoes: "sneakers", clothes: "t-shirt")   //can't change the order of the members

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
}

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
}

//CONVENTIONS
//computed properties tend to be more common in Apple code and less common in user code
//Use structs instead of classes to eliminate relationships that might cause things like race conditions
//Use classes when need inheritence or shared object
//Mark classes as constants and/or final when possible
//Also use structs if you want convenience of automatically generated init
//Prefer structs to classes when possible

//QUESTIONS
//Can a struct have custom initializers?
//Can you provide a default value in a struct, and how does that affect the initializer?
//Why does Swift leave out protected, and how do you do the normal scenarios like template method pattern?
//What are default access control levels and what are all the options?

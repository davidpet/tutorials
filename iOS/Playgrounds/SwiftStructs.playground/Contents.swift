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

//VALUE TYPE
var person1 = Person(clothes: "t-shirt", shoes: "sneakers")
var person2 = Person(clothes: "sweathshirt", shoes: "boots")
var personCopy = person1        //because structs are value types, personCopy is an independent copy of person1
person1.clothes = "robe"
person1
personCopy                      //changing person1 did not affect personCopy

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

//CONVENTIONS
//computed properties tend to be more common in Apple code and less common in user code

//QUESTIONS
//Can a struct have custom initializers?


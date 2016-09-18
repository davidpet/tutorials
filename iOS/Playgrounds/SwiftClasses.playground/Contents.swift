//DECLARING
class Person {
    var clothes: String                         //defining properties just like with struct
    var shoes: String
    
    var tie = false                             //DEFAULT value for new instances
    var watch : String?                         //OPTIONAL value (might be nil)
    
    //initializers (constructors) don't use func and don't return anything
    init(clothes: String, shoes: String) {      //REQUIRED for any properties that are not optional or defaulted
        //printClothes()                        //ILLEGAL to call any methods before all values are initialized
        
        self.clothes = clothes                  //NOTE: self like Python but not passed in as a param
        self.shoes = shoes
        
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

//PROPERTY OBSERVERS and COMPUTED PROPERTIES
//see: SwiftStructs playground (syntax is the same)

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
        else {
            print("ahhhh")
        }
    }
}

var heavyMetalSinger = HeavyMetalSinger(clothes: "leather", shoes: "boots", volume: 99)
heavyMetalSinger.sing()

//REFERENCE TYPE
var personRef = person                      //unlike struct, class is a reference type
personRef.clothes = "kimono"
print(person.clothes)                       //changing the other reference changed the original

//POLYMORPHISM
var b: Person = Singer(clothes: "tshirt", shoes: "sneakers")    //base reference to a more derived class
b.sing()                                                        //derived version is called (like virtual in C++)

//CONSTANTS
let p = Person(clothes: "shirt", shoes: "slippers")     //declaring constant class instance
p.sing()                    //ok to read and cal methods on constants
//p.shoes = "other"         //can't change member of constant
//p.changeTie(true)         //can't call method that changes member of a constant
var q = p
q.changeTie(tie: true)      //storing a variable reference to a constant allows us to change state
print(p.tie)                //the state change is seen back in the constant!!!

//CONVENTIONS
//class names start with capital and methods/properties start with lowercase
//use structs unless you need to use classes (structs = safety, classes = flexibility)

//QUESTIONS
//How do you clone/copy a class instance?
//Is there a way to prevent variable references being taken to a constant?  Or to make it a true runtime constant?

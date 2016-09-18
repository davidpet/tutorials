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

//QUESTIONS
//Can a struct have methods, initializers, etc like a class?

//for ARRAYS, DICTIONARIES, and STRINGS, see those playgrounds

//--------------
//SETS (unordered hash set)(value type)
//--------------
//creating
var s = Set([1, 2, 3, 3])       //can initialize from another sequence type
let s2 = Set<Int>()             //can initialize with or without type (depending on info available)
let uniqueArray = Array(s).sorted()     //de-duping items in an array by converting both ways
//let s3 = {1, 2, 3}    //NO set literal

//manipulating
s.insert(4)
s.contains(4)
s.remove(4)
s.removeFirst()         //these sort of methods are here but it's unpredictable what they will return

//array-like operations
for item in s {         //normal iteration and functional operators supported for sets
    print(item)
}
s.forEach {print($0)}
s.count
s.first                 //1st item in set (though you don't know what the order is) (use if you just want anything from the set)
s.first ?? 0                //optional

//set operations
let set1 = Set([1, 2, 3])
let set2 = Set([0, 3, 4, 5])
let union = set1.union(set2)
let intersection = set1.intersection(set2)
let diff = set1.symmetricDifference(set2)       //only items that are not in both sets
var set1Copy = set1
let set2Copy = set2
set1Copy.formUnion(set2Copy)        //in-place versions of set operations have form in front

//set comparisons
set1.isSubset(of: set2)         //strict versions available too
set1.isSuperset(of: set2)
set1.isDisjoint(with: set2)     //true if no overlap

//counted sets (keep track of number of times each element is there)
import Foundation
let cs = NSCountedSet(array: [1, 2, 2, 3, 3])       //NOTE: it is a class and therefore a REFERNECE TYPE
cs.count(for: 3)            //getting number of times item is in set (NOTE: this takes Any)
cs.allObjects as! [Int]

//--------------
//TUPLES (value type)
//--------------
//void returns
func dostuff() {}
type(of:dostuff())      //return of void function is actually EMPTY tuple

//single elements
let singleInt = (val: 5)    //single element tuples automatically stripped of label and made single element itself
let singleInt2 = (5)        //without the label, it is a tuple instead of a single value (strangely)
//let singleInt2: (val: Int) = 5        //not allowed to define a tuple with a single field
//NOTE: according to the tutorial, single values are basically tuples underneath somehow

//creation
var point = (1, 2, 3)           //unnamed elements (like Python tuple)
var person = (first: "Taylor", last: "Swift")       //named elements (like C# anonymous class)
var nested = (person: (first: "bob", last: "johnson"))      //tuples within tuples
var optional: (Int, Int)?       //tuples can be optional just like anything else (and so can their members)

//typing
print(type(of: point))
print(type(of: person))     //field names aren't part of the type
if type(of: (1, 2)) == type(of: (x: 1, y: 2)) {
    print("same")
}
typealias Person = (first: String, last: String)
var person2: Person? = nil      //can name the type of a tuple by structure

//reassigning
person = (first: "Bob", last: "Johnson")        //allowed to reassign as long as types and names match (tuples are STRONGLY TYPED)
//person = (x: "Bob", last: "Joe")          //names have to match
//person = (first: 5, last: 10)             //violating the type not allowed
//NOTE: when it comes to assignment, the field names act as part of the type even though type(of:) does not show this

//reading members
print(person.first)
print(person.0)
print(point.0)          //indexing allowed for NAMED or UNNAMED fields

//manipulation
person.first = "Jill"       //can reassign the members
print(person)

//comparison
if (x: 1, y: 2) == (a: 1, b: 2) {       //when it comes to comparison, only positions, types, and values matter (not field names)
    print("sameish")
}

//closures
var myperson = (first: "bob", sing: {(song: String) in print("la la la \(song)")})
myperson.sing("Norwegian Wood")     //NOTE: this is a way to fake methods on tuples
//NOTE: closures on tuples can't access tuple members by name like real methods would

//multiple return values
func getPoint() -> (x: Int, y: Int, z: Int) {       //specify tuple type here (could have a tuple without field names too)
    return (x: 10, y: 20, z: 30)
}
let newpoint = getPoint()               //getting tuple directly as an object
var (a, b, c) = getPoint()              //DESTRUCTURING tuple as indvidual items (NOTE: worked positionall instead of using field names here)
print(c)                                //c became the z member

//destructuring
let (d, e) = (10, 20)       //can do this like in Python as long as the counts perfectly match on both sides
//let (f, g) = (10)
//let (h, i) = (10, 20, 30)
let (j, _) = (10, 20)       //can use _ to make match on left side
//let (k, l) = (_, 20)      //other side doesn't work or make sense
(a, b) = (b, a)     //can do this arbitrarily (in this case performs a SWAP)

//NOTE: cannot do PROTOCOLS or METHODS in tuples

//--------------
//GENERAL
//--------------
//CONVENTIONS
//Use set instead of array when either uniqueness or lookup speed matters
//Use NSCountedSet instead of dictionary of item to count when speed matters

//QUESTIONS
//Set literals?
//Set operations?
//tuple counts, enumerating?

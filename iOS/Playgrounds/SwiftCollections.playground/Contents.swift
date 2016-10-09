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
let cs = NSCountedSet(array: [1, 2, 2, 3, 3])
cs.count(for: 3)            //getting number of times item is in set
cs.allObjects as! [Int]

//--------------
//TUPLES (value type)
//--------------
//creating

//--------------
//GENERAL
//--------------
//CONVENTIONS
//Use set instead of array when either uniqueness or lookup speed matters

//QUESTIONS
//Set literals?
//Set operations?

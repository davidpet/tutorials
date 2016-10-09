//DECLARATIONS
var a = [1, 2, 3]
var s = ["hi", "bye", "whatever"]   //single typed arrays with type inference

var t: [String] = ["abc", "def"]   //explicitly typed array declaration

//var u = [1, "hi"]     //can't use type inference with MIXED TYPES
var mixedArray : [Any] = [1, "abc"]     //by using Any you can do MIXED TYPES

//empty arrays
var emptyArray: [String] = []  //often preferred version
var emptyArray2 = [String]()    //alternate version

//TYPE
type(of: a)
let typedVal: Array<Int> = []    //the [Int] syntax is sugar for this

//INDEXING
s[0]
//s[3]          //out of range is illegal
s[0] = "cat"    //reassigning existing item
//s[3] = "dog"  //cannot assign non-existent index like this
//s[-1]         //no negative indexing
s[s.count - 1]  //getting last item
var index : Int? = s.index(of: "bye")   //finding an item in an array (nil if not there)
//s[100]        //runtime error going beyond last index

//SLICING
s[0...1]        //range operator can be passed to get an array from a portion of the array

//INSPECTION
s.count         //getting array length  (NOTE: property not method)
s.isEmpty       //gesting for emptiness (NOTE: property not method)
s.contains("cat")       //checking if element is in array

//ARRAY CONSTANTS
let cArray = [1, 2, 3]
//cArray[0] = 10        //cannot reassign an item in constant array

//MODIFYING
var m = [1, 2, 3]
m.append(4)     //adding an item dynamically (1st param is _)
m.insert(0, at: 0)      //inserting new element at index position (1st param is _)
m.remove(at: 0)     //removing item at index position
m.removeAll(keepingCapacity: true)      //empties the array with possibility of keeping storage as optimization (if going to refill)
m.removeAll()                       //can do without capacity too
m += [1, 2, 3, 4]

//TRANSFORMATIONS
//see SwiftFunctionalProgramming for closure syntax and ADDITIONAL METHODS
m.reverse()         //reverses the actual array in-place
let reversed = m.reversed()     //returns a reversed copy (as LAZY SEQUENCE)
m.sort()            //sort in-place using default sorting
m.sort(by: >)   //sort in-place using closure
let sorted = m.sorted(by: >)        //copy

//CONCATENATION
//a + 6         //cannot add an item like this
a + [6]         //can add an item by wrapping it as an array
a += [4, 5, 6]  //+ and += for concatenation
a = [1, 2, 3] + [4, 5, 6]   //works with literals
mixedArray += [10]          //array defined with Any can take more mixed type items

//MULTIDIMENSIONAL
let multi = [[1, 2], [3, 4], [5, 6]]    //arrays can be multidimensional (not flattened like Perl)
let flattened = Array(multi.joined())   //joined() flattens (1 level only) as a sequence and this line converts back to array

//CLASSES and POLYMORPHISM
//see SwiftClasses playground

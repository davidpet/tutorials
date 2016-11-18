//DECLARATIONS
var a = [1, 2, 3]
var s = ["hi", "bye", "whatever"]   //single typed arrays with type inference

var t: [String] = ["abc", "def"]   //explicitly typed array declaration

//var u = [1, "hi"]     //can't use type inference with MIXED TYPES
var mixedArray : [Any] = [1, "abc"]     //by using Any you can do MIXED TYPES
mixedArray = s          //arrays of more specific types can automatically be passed when [Any] is expected (same is true for other containers such as dictionaries)

//empty arrays
var emptyArray: [String] = []  //often preferred version
var emptyArray2 = [String]()    //alternate version
emptyArray.reserveCapacity(100)     //OPTIMIZATION like other languages

//SPECIAL INITIALIZERS
let zeroes = [Int](repeating: 0, count: 100)        //array of 100 0s
let matrix = [[Int]](repeating: [Int](repeating: 0, count: 100), count: 100)    //2D array of 0s
let myArray = Array(1...3)      //construcitng array from another sequence type (NOTE the lack of type needed in the Array initializer here)

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
s.first
s.last          //convenience methods for first and last items
emptyArray.first        //first and last are optionals (this is not a crash even though emptyArray[0] would be)

//SLICING
s[0...1]        //range operator can be passed to get an array from a portion of the array

//INSPECTION
s.count         //getting array length  (NOTE: property not method)
s.isEmpty       //gesting for emptiness (NOTE: property not method)
s.contains("cat")       //checking if element is in array
[1, 2, 3, 4].max() ?? Int.max  //max() and min() available (work on built-in types and Comparable protocol elements)

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
var first = m.removeFirst() //can shrink array from the ends and get the value
var last = m.removeLast()
last = m.popLast()!         //popLast() is like removeLast() but returns optional value
m = [1] + m + [3, 4]
//NOTE: use the versions of removeFirst and removeLast that take n parameter to remove MULTIPLE

//TRANSFORMATIONS
//see SwiftFunctionalProgramming for closure syntax and ADDITIONAL METHODS
m.reverse()         //reverses the actual array in-place
let reversed = m.reversed()     //returns a reversed copy (as LAZY SEQUENCE)
reversed.enumerated()       //many array-like things still work on the reversed sequence
        //NOTE: the indices in enumerating the reversed sequence will START HIGH and decrease
m.sort()            //sort in-place using default sorting
m.sort(by: >)   //sort in-place using closure
let sorted = m.sorted(by: >)        //copy
//NOTE: methods like min(), max(), sort() can be made to work for NON-DEFAULT types by conforming to Comparable protocol (see Operator Overloading playground)

//CONCATENATION
//a + 6         //cannot add an item like this
a + [6]         //can add an item by wrapping it as an array
a += [4, 5, 6]  //+ and += for concatenation
a = [1, 2, 3] + [4, 5, 6]   //works with literals
mixedArray += [10]          //array defined with Any can take more mixed type items

//MULTIDIMENSIONAL
let multi = [[1, 2], [3, 4], [5, 6]]    //arrays can be multidimensional (not flattened like Perl)
let flattened = Array(multi.joined())   //joined() flattens (1 level only) as a sequence and this line converts back to array
var multi2 = [[String]]()
multi2.append(["a", "b", "c"])      //basic nested array building

//VALUE TYPE
var b = a           //assigning an array makes a copy (NOTE: this greatly differs from other ref based languages)
b.remove(at: 0)
print(a)
print(b)

//CLASSES and POLYMORPHISM
//see SwiftClasses playground

//STRIDE
//see SwiftControlFlow for description of the built-in stride() function which can be used to get an array from bounds and step

//QUESTIONS
//ContinguousArray (haven't put above yet) (should act just like Array but be faster - is there a reason not to use it other than readability with the literals?)

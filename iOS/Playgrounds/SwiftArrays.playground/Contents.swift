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

//INSPECTION
s.count         //getting array length

//ARRAY CONSTANTS
let cArray = [1, 2, 3]
//cArray[0] = 10        //cannot reassign an item in constant array

//CONCATENATION
//a + 6         //cannot add an item like this
a + [6]         //can add an item by wrapping it as an array
a += [4, 5, 6]  //+ and += for concatenation
a = [1, 2, 3] + [4, 5, 6]   //works with literals
mixedArray += [10]          //array defined with Any can take more mixed type items

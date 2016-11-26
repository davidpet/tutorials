//PROCEDURE
func favoriteAlbum() {
    print("My favorite album is Rubber Soul")
}
favoriteAlbum()

//PARAMETER
func favoriteAlbum(name: String) {
    print("My favorite album is \(name)")
}
favoriteAlbum(name: "Revolver") //NOTE: the parameter must be named even if there's only one (new to Swift 3)
favoriteAlbum()             //NOTE: OVERLOADING is allowed

//MULTIPLE PARAMETERS
func favoriteAlbum(name: String, year: Int) {
    print("My favorite album is \(name) and it was released in \(year).")
}
favoriteAlbum(name: "Sgt. Pepper", year: 1967)

//OVERLOADING
func myfunc1() {
}
func myfunc1(name: String) {        //overloading is allowed as in other languages
    print(name + name)
}
func myfunc1(text: String) {        //in addition, you can overload by names of same-typed parameters
    print(text + text + text)
}
myfunc1(text: "goat")
myfunc1(name: "sheep")

//DEFAULT ARGUMENTS
func myfunc(a: Int) -> Int {
    return a
}
func myfunc(a: Int, b: Int, c: Int = 0, d: Int = 0) -> Int {
    return myfunc(a: a) + b + c + d
}
myfunc(a: 1, b: 2, d: 4)        //works here just like other languages
//NOTE: cannot change order of parameters but can leave optional ones out
func myfunc(a: Int = 0, b: Int) -> Int {
    return a + b
}
myfunc(a: 10, b: 20)  //NOTE: unlike other languages, the optional args can go in front of non-optional ones too

//IMPLICIT OPTIONAL PARAMETERS
func myimplicitparamfunc(x: Int! = nil) {
    if let y = x {
        print(y)
    }
}
myimplicitparamfunc(x: 5)

//EXTERNAL PARAMETER NAME (multiple allowed)
func countLettersInString(myString str: String) {       //str is the name inside the function while myString is the name when you call it
    print("There are \(str.characters.count) characters.")
}
countLettersInString(myString: "hello")
//countLettersInString(str: "hello")        //ILLEGAL to use the internal parameter name

//UNNAMED EXTERNAL PARAMETER NAMES (multiple allowed)
func countLettersInString(_ str: String) {  //using _ as the external name means no name needed
    countLettersInString(myString : str)    //NOTE: OVERLOADING one with and without external name works
}
countLettersInString("hello")       //calling without parameter name

func countLettersInString(_ str: String, _ str2: String) {
}
countLettersInString("a", "b")      //can have multiple

func countLettersInString(str: String, _ str2: String) {        //can freely INTERMIX named and unnamed
        countLettersInString(str, str)          //can also freely call other overloads
}

//PASSING BY REFERENCE
func refFunc(x: Int, y: inout Int) {        //mark a reference parameter with inout
    //x = 5     //parameters are constants (this is a compile error)
    y = 5       //this is fine because it's an inout parameter (not required to change it like out parameters in C#, more like ref in C#)
}
var myrefy = 2              //anything passed in as inout must be a variable, not a constant
refFunc(x: 1, y: &myrefy)       //must use & and pass in a variable, not a literal
print(myrefy)
//refFunc(x: 1, y: &(Int(5)))       //no temporary values either
//NOTE: inout parameters cannot be variadic and cannot have default args
//NOTE: if the value is a property with a setter and getter, the getter will be called to pass in, and the value on exiting will be passed into the setter
//In general, you should code as if the value will be copied and then copied back and don't rely on the pass by reference optimization (but be assured it will try to happen)

//SWIFTY NAMING (Swift naming to take advantage of external names gramatically)
func countLetters(in string: String) {
    print(string.characters.count)      //inside function we can use a sensible name
}
countLetters(in: "hello")               //outside function, we can make it act like part of the function name without making the name wordy

//RETURN VALUES
func getDoubled(string: String) -> String {     //return value specified after -> to make it not void anymore
    return string + string              //return just like any other language
}
let s = getDoubled(string: "hi")        //call it to get a value just like any other language

//OPTIONAL RETURN VALUES
func getHaterStatus(weather: String) -> String? {  //could return nil instead of a string
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

//IGNORING RETURN VALUES
_ = getDoubled(string: "hi")        //if the declaration isn't marked with @discardableResult, you need to do this to supress compiler warning

//VARIADIC
func addNumbers(nums: Int...) -> Int {      //put ... after the type to make an argument variadic (can supply as many as want)
    print(type(of: nums))           //the variadic parameter is actually an ARRAY
    return nums.reduce(0, +)                //treat the variadic arg like a container
}
addNumbers(nums: 1, 2, 3)               //pass in variadic parameter like this
//addNumbers(nums: [1, 2, 3])           //NOT ALLOWED to pass in array directly
func addNumbers(_ nums: Int...) -> Int {
    return nums.reduce(0, +)
}
addNumbers(1, 2, 3)                     //using _ to eliminate need for param label (like print())
func addNumbers(_ nums: Int..., seed: Int) -> Int {     //can have other parameters as usual
    return nums.reduce(0, +) + seed
}
addNumbers(1, 2, 3, seed: 10)
func addNumbers(seed: Int, _ nums: Int...) -> Int {         //can go ANYWHERE in the list but ONLY ALLOWED ONE
    return nums.reduce(0, +) + seed
}
addNumbers(seed: 10, 1, 2, 3)           //how you call it with external at end

//RECURSION
func factorial(of num: Int) -> Int {
    if num <= 1 {
        return 1
    }
    return num * factorial(of: num - 1)     //function can call itself recursively just like in any other language
}
//NOTE: Swift may do tail recursion optimization but you can't rely on it

//NESTING
func outerfunc() {
    func innerFunc() {      //nesting is allowed (could even return this as a CLOSURE)
    }
}

//IGNORING RETURN VALUES
func getstuff() -> Int {
    return 10
}
_ = getstuff()          //use _ to indicate you don't care about the return value (to suppress warning)

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

//NESTING
func outerfunc() {
    func innerFunc() {      //nesting is allowed (could even return this as a CLOSURE)
    }
}

//QUESTIONS
//What is the full official name of a function/method?
//In, Out, Ref parameters?  inout?
//Forwarding variadic args?
//Can you use the internal name externally, or when _ is used?
//Extension methods?
//Constant parameters and/or methods?

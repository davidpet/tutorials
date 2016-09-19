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
favoriteAlbum()             //NOTE: overloading is allowed

//MULTIPLE PARAMETERS
func favoriteAlbum(name: String, year: Int) {
    print("My favorite album is \(name) and it was released in \(year).")
}
favoriteAlbum(name: "Sgt. Pepper", year: 1967)

//EXTERNAL PARAMETER NAME (only one allowed, at front)
func countLettersInString(myString str: String) {       //str is the name inside the function while myString is the name when you call it
    print("There are \(str.characters.count) characters.")
}
countLettersInString(myString: "hello")
//countLettersInString(str: "hello")        //ILLEGAL to use the internal parameter name

//UNNAMED EXTERNAL PARAMETER NAME (only one allowed, at front)
func countLettersInString(_ str: String) {  //using _ as the external name means no name needed
    countLettersInString(myString : str)    //NOTE: overloading one with and without external name works
}
countLettersInString("hello")       //calling without parameter name

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

//OPTIONAL VALUES
func getHaterStatus(weather: String) -> String? {  //could return nil instead of a string
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

//QUESTIONS
//What is the full official name of a function/method?


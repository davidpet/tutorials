import UIKit

//DECLARATIONS
var s = "hi"        //string variable
let t = "hi"        //string constant (optimized and catches programmer error)

s = "bye"           //reassigning
//var s = "bye"     //cannot re-declare with var
//t = "bye"           //not allowed for constants

var name: String    //specifying type (note the spacing)
//print(name)       //can't use before initialized
name = "Bob"        //assigning the value (type must match)
var name2: String = "Joe"       //declare type and assign at same time

var name3: String = "hi", name4: String = "low" //multiple declarations together

//DATA TYPES
var thename: String = "Bob"
var theage: Int = 5
var latitude: Float = -18.633333333
var longitude: Double = -18.633333333       //recommended by Apple due to higher accuracy
var altitude = -18.63333                //becomes a Double even though Float would work
var success: Bool = true

//VARIANTS
var anyVar: Any = 20       //any is like a variant
anyVar = "hi"               //can be reassigned to a value of a different type

//EXPRESSIONS
var x = 5 + 3               //can initialize variables with expressions
var y = x * 2
let z = x * y               //works for constants as well

//CONVENTIONS
//Start with Capital: data types
//Start with lowercase: variables and constants
//Use Constants when possible
//Use Type Inference (instead of explicit types) when possible
//put : next to variable name (eg. var name: String)
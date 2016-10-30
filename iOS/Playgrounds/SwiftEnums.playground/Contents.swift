//BASIC SYNTAX
enum WeatherType {
    case sun, cloud, rain, wind, snow
}
enum WeatherType2 {     //can provide the cases on separate lines
    case sun
    case cloud
    case rain
    case wind
    case snow
}
var wt: WeatherType = WeatherType.cloud //declaring and instantiating full syntax
if wt == WeatherType.cloud {            //comparing with full syntax
}

//TYPE INFERENCE
var wt2: WeatherType = .cloud       //initializing without enum name
if wt2 == .cloud {                  //comparing without enum name
}
func getValue(weather: WeatherType) -> String {
    switch weather {
    case .cloud:                    //switch cases don't need enum name because type is known
        return "cloud"
    case .rain:
        return "rain"
    case .snow:
        return "snow"
    case .sun:
        return "sun"
    case .wind:
        return "wind"       //switch is considered EXHAUSTIVE here without default
    }
}
getValue(weather: .cloud)   //even passing into functions can use type inference for enums

//ASSOCIATED VALUES
enum WeatherType3 {
    case sun
    case cloud
    case rain
    case wind(speed: Int)   //wind has a parameter now (but rest don't)
    case snow
}
var wt3 = WeatherType3.cloud
var tw4 = WeatherType3.wind(speed: 5)
switch wt3 {
case .sun, .cloud, .rain:
    print("a")
case .wind(let speed) where speed < 10:     //special syntax for checking the extra value  //NOTE: can also use things like a range with contains
    print("b")
case .wind, .snow:                          //can still check without the extra value if that one didn't match (or if don't care)
    print("c")
}

//RAW VALUES
enum Color {
    case red
    case green
    case blue
}
//Color.red.rawValue    //by default, enums have no raw value - they are pure values
enum NumericColor: Int {       //defining raw type behind enum is like inheritence
    case red
    case green
    case blue
}
NumericColor.red.rawValue       //can access raw value on instance or value
let c = NumericColor.red
c.rawValue
enum Planet: Int {
    case mercury = 1        //default is 0 (works like other languages)
    case venus
    case earth
}
let p = Planet(rawValue: 1) ?? Planet.earth     //converting raw value to enum (coalesce since OPTIONAL)
enum PrintableColor: String {
    case red
    case green
    case blue
}
print(PrintableColor.red.rawValue)      //using String as rawValue automatically makes values string as defined in code

//STRING VALUES
//NOTE: see above for using string as the raw value
print("\(Color.red)")           //string interpolation automatically makes the name a string too (but can't treat as string INSIDE)

//PROPERTIES AND METHODS
enum MyEnum {
    case red, green, blue
    
    //var x = 5             //no non-computed properties allowed
    
    var description: String {       //computed property (NOTE: don't need to specify get because that's all you can do in enums)
        switch self {
        case .blue:
            return "blue"
        default:
            return "whatever"
        }
    }
    
    func otherdescription() -> String {     //method
        return description      //using the property
    }
}
let myenum = MyEnum.blue
print(myenum.description)       //use methods and properties like with classes and structs

//BITFIELDS
//NOTE: Cocoa Touch functions that take combinable options use this
struct MyBitField: OptionSet {          //NOTE that bitfields are STRUCTS intead of enums in Swift, but I included them here because it's more intuitive
    let rawValue: Int               //to make a struct a bitfield, conform to OptionSet protocol which requires a rawValue field of numeric type
    
    static let value1 = MyBitField(rawValue: 1)     //define static constants of the type of the struct itself with powers of 2 as raw values
    static let value2 = MyBitField(rawValue: 2)     //the apple documentation shows it doing 1 << 0 and so on instead but I like it this way
    static let value3 = MyBitField(rawValue: 4)
    
    static let values1And2: MyBitField = [.value1, .value2]     //this is how you would define special values that represent multiple values combined
}
let mbf: MyBitField = []                //automatically allowed to treat like an array because system knows it's a bit set (in this case no options)
let mbf2: MyBitField = [.value1, .value2]       //this is how you "OR" multiple values together
let mbf3: MyBitField = [.values1And2, .value3]  //can interop combined values and single values and the result will be what you expect
var mbf4: MyBitField = .value1              //can also treat it like a straight enum
//adding and testing values
mbf4.insert(.value2)                //inserting [ORing in] single values (must not be constant) [fine if already set]
mbf4.contains(.value2)              //testing for single values
mbf4.insert([.value2, .value3])     //inserting multiple values (OK if some of them already present)
mbf4.contains([.value1, .value2])   //testing for multiple values
mbf4.rawValue                       //getting the combined numeric value directly
//set operations
let unionbf = mbf4.union(mbf3)      //lets of set operations like this supported which return new instance

//VALUE TYPE
//NOTE: enums are value types

//CONVENTIONS
//enum types start with capitalize while enum values inside the type start with lowercase
//use 'unknown' as the unset type for an enum

//QUESTIONS
//Other variations of that syntax like multiple extra values, using other names, etc?
//How does OptionSet impart so much functionality when it's only a protocol?

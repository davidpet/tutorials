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

//ADDITIONAL VALUES
enum WeatherType3 {
    case sun
    case cloud
    case rain
    case wind(speed: Int)   //wind has a parameter now (but rest don't)
    case snow
}
var wt3 = WeatherType3.cloud
switch wt3 {
case .sun, .cloud, .rain:
    print("a")
case .wind(let speed) where speed < 10:     //special syntax for checking the extra value
    print("b")
case .wind, .snow:                          //can still check without the extra value if that one didn't match
    print("c")
}

//CONVENTIONS
//enum types start with capitalize while enum values inside the type start with lowercase

//QUESTIONS
//How would you set the extra value (eg. speed for wind)?
//Other variations of that syntax like multiple extra values, using other names, etc?
//Can you still change the raw type of an enum and do those other tricks from the Swift 2.2 tutorial?


//GENERIC FUNCTIONS
func transform<T>(_ value: T) -> T {        //just give type in <> and use it (like C#)
    return value
}
transform(5)            //type is implicitly found
//transform<Int>(5)       //not even allowed to explicitly do it

//CONSTRAINTS
func square<T: Integer>(_ value: T) -> T {  //constrain by PROTOCOL (NOTE: built-in types already conform to protocols)
    return value * value                        //since these are genericsi and not templates, you can only use functionality that the item is known to have from constraints
}
square(25)
protocol Numeric {
    static func *(lhs: Self, rhs: Self) -> Self //Self = keyword that means the class type (requires the class to implement for its own type)((in this case already done))
}                                                   //NOTE: once you use Self in a protocol, it can't be used as a variable but only as a generic constraint
extension Int: Numeric {}
extension Double: Numeric {}
extension Float: Numeric {}                 //way to add protocols to existing types
func square2<T: Numeric>(_ value: T) -> T {
    return value * value                //function needs to be in the protocol or the generic won't do it
}
square2(12.0)

//TYPES (can do for enums, classes, struct, etc.)
struct deque<T> {           //similar to C# (can also use CONSTRAINTS if want)
    var array = [T]()
    
    mutating func pushBack(_ obj: T) {
        array.append(obj)
    }
    
    init() {}
    init(initial: T) { array.append(initial) }
}
let d = deque<Int>()            //can explicitly instantiate by type
let d2 = deque(initial: 10)     //type can also be inferred from initializer args

//NOTE: built-in stuff like arrays, dictionaries, etc. are generics
//NOTE: of course you can use multiple generic parameters for generics

//EXTENSIONS
//see SwiftExtensions for how to extend generics

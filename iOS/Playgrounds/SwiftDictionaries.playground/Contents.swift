//preferred spacing, etc. for defining dictionary clearly
var d = [
    "FirstName": "Bob",            //type inference (keys usually strings, in this case values are too)
    "LastName": "Johnson"
]

//other value types
var e = [
    "Age": 30
]

//mixed value types and explicit dictionary type declarations
let m: [String: Any] = [     //have to declare the type as with arrays
    "Name": "Bob",
    "Age": 30
]

//initializing and empty dictionaries
var n: [String: Any] = [:]     //empty dictionary literals have a :
var o = Dictionary<String, Any>()       //full formal way
var p = Dictionary<String, String>(minimumCapacity: 100)        //pre-reserve space for performance reasons
var q = [String: String]()              //default initializer just like with arrays

//accessing items
d["FirstName"]
d["FirstName"] = "Joe"      //reassignment
d["NewString"] = "Whatever" //can add keys this way
d["NotHere"]            //not a crash, just returns an OPTIONAL (nil in thise case)

var f: [String: [Int]] = [
    "0": [1, 2]
]

//iterating
for key in d.keys {}
for val in d.values {}
for (key, val) in d {print(key + ":" + val)}

//dictionary constants
//m["Name"] = "Joe"     //can't reassign existing key
//m["NewKey"] = "Joe"     //can't add new key

//TYPING
type(of: d)
let typed: Dictionary<String, String> = [:] //explicit version of the sugar [String: String]

//VALUE TYPE
//dictionary is a value type (not a reference type like other languages)

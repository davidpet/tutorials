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

//empty dictionaries
var n: [String: Any] = [:]     //empty dictionary literals have a :

//accessing items
d["FirstName"]
d["FirstName"] = "Joe"      //reassignment
d["NewString"] = "Whatever" //can add keys this way

//dictionary constants
//m["Name"] = "Joe"     //can't reassign existing key
//m["NewKey"] = "Joe"     //can't add new key

//TYPING
type(of: d)
let typed: Dictionary<String, String> = [:] //explicit version of the sugar [String: String]

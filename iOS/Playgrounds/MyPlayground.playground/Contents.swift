//MILESTONE 1 Challenge: FizzBuzz Problem
func fizzbuzz(_ number: Int) -> String {
    let fizz: Bool = number % 3 == 0
    let buzz: Bool = number % 5 == 0
    var out: [String] = []
    
    if fizz {
        out.append("Fizz")
    }
    if buzz {
        out.append("Buzz")
    }
    if out.isEmpty {
        out.append(String(number))
    }
    
    return out.joined(separator: " ")
}

fizzbuzz(0)
fizzbuzz(1)
fizzbuzz(3)
fizzbuzz(5)
fizzbuzz(15)
fizzbuzz(17)

//NOTE: his solution just explicitly checks the modulos again and again returning the exact strings (I wanted to make mine more declarative although I'm not sure I did)

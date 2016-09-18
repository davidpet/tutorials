import UIKit

let vw = UIView()

//CLOSURES
UIView.animate(withDuration: 0.5, animations: { //animation parameter is a closure and {} allows you to pass it in
    vw.alpha = 0        //closures can refer to values OUTSIDE of themselves automatically (thus they are closures)
})

//TRAILING CLOSURES
UIView.animate(withDuration: 0.5) { //if closure is LAST parameter, can ommit it and put {} after the call for clarity
    vw.alpha = 0            //closure rules are still the same
}

//CONVENTIONS
//Use trailing closures when possible (defining and calling)

//QUESTIONS
//How do you define closures with arbitrary parameters and return types?  And what other syntactic sugars are there?
//Declaring and passing closures of various types as parameters?
//Using closures as events, delegates, etc?
//@selector still a thing?

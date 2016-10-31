//IMPORTING
import UIKit        //symbols in this module now available

//DECLARATION ORDER
//var x = MyClass()     //type (or variable) must be declared first
class MyClass {
    func method1() {
        method2()           //declaration order within class not as important (just like C# and C++)
    }
    func method2() {
    }
}

//OTHER STUFF
//see SwiftModules folder with projects in this same folder for stuff that could not be demonstrated with playgrounds
//some rules summarized below for convenience

//FILES IN SAME PROJECT
//from the perspective of a source file in a project, all other files in the same project can be assumed to have been executed (subject to access level)
//that means two files can access symbols in each other (which seems like a contradiction but works)
//global variables and types have this same behavior
//even works for classes referencing each other back and forth
//One thing to keep in mind is EXTENSIONS will be automatically available to every file if there is an extension with right access level somewhere in the project

//COCOA TOUCH FRAMEWORK (library)
//TBD

//WAYS TO SHARE CODE
//1. Include files directly via File menu, drag-and-drop etc. (can tell it to copy)
//2. Use a Cocoa Touch Framework (TBD)

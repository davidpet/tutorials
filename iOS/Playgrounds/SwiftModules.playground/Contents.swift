//IMPORTING
import UIKit        //symbols in this module now available (but not other imports)
//import MyLibrary  //if you had a library project with this name, this is how you'd import the types into a .swift file

//IMPORT OTHER MODULES
//by default, a module imported into your module does not get imported into other modules
//to make this happen, add this to the .h file for your module (for instance to import GameplayKit): #import <GameplayKit/GameplayKit.h>

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
//when you build a cocaa touch framework project, if the binaries are in the same folder as the application binaries, it will be able to access the public members
//if you put the library and the application in the same workspace and configure the library as a dependecy for the application, it will work seamlessly like they're in the same project
//to use types from the library in a given module of the application, use import with the name of the library
//NOTE: automatically generated members tend to be internal instead of public (eg. struct member-wise initializer), so currently you have to redefine/reimplement those to make them public

//WAYS TO SHARE CODE
//1. Include files directly via File menu, drag-and-drop etc. (can tell it to copy)
//2. Use a Cocoa Touch Framework
//    A. Directly
//    B. From within workspace


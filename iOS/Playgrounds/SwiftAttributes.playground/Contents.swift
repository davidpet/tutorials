//there are two types of attributes: DECLARATION and TYPE
//NOTE: there is no way to provide CUSTOM attributes in Swift or Objective-C

//FORMAT
//@attributename [rest of declaration]
//@attributename(arguments) [rest of declaration]
//argument format depends on the attribute

//DECLARATION attributes (when you declare classes, methods, etc.)
//@available() 
//  for specifying various things like when the declaration was made available, when it become obsolete, etc.
//@discardableResult
//  tells the compiler that calling the function/method and not doing anything with the result is fine
//@objc
//  marks a declaration as compatible with objective-c so that it's usable from there (class, function, etc.)
//  objective-c compatible methods are automatically @objc too
//  NOTE: subclassing an @objc class automatically makes your class @objc too (eg. view controllers, app delegates, etc.)
//  NOTE: this attribute also carries the extra requirement of inheriting from NSObject
//  NOTE: interestingly, since NSObject is @objc, you can just inherit from NSObject and NOT WORRY ABOUT THIS ATTRIBUTE
//  NOTE: marking a protocol objc does not require classes that conform to be objc
//@nonobjc
//  marks something that would otherwise be considered @objc by defualt as being not compatible with Objective-C
//  eg. mark a class as @objc and mark a member as @nonobjc
//@testable
//  marks an import declaration so that internal members become public (for test purposes)

//@NSCopying
//  marks a stored property (of type that conforms to NSCopying) in a class to get a setter that will use the NSCopying protocol to copy the value
//@NSManaged
//  marks a stored property or instance method as being part of a Core Data model within a class

//@NSApplicationMain
//  marks the main application delegate for an AppKit application (alternatively, could make a main.Swift and call appropriate function to use your application delegate
//@UIApplicationMain
//  marks the main application delegate for a UIKit application (could also use a main.Swift as in NSApplicationMain description)

//@GKInspectable
//  exposes a property in a GamePlay component to the Scene Editor
//@IBOutlet
//  marks a property as an outlet for an IB object
//@IBAction
//  marks a method as implementing an action for an IB object
//@IBDesignable
//  marks a class as designable by IB inspectors
//@IBInspectable
//  marks a property as excposed to the IB inspectors

//TYPE attributes (when you declare types within method declarations, closure types, etc.)
//@escaping and @autoclosure -> see Functional Programming playground
//@convention for specifying calling convention of a function or method (swift, block, or c)

//
//  AppDelegate.h
//  Hello World
//
//  Created by David Petrofsky on 12/12/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
- (IBAction)sayHello:(id)sender;
- (IBAction)sayGoodbye:(id)sender;
@property (weak) IBOutlet NSTextField *textField;
@end


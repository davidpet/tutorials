//
//  AppDelegate.m
//  Hello World
//
//  Created by David Petrofsky on 12/12/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSLog(@"This is a hello world application");
    [self sayHello:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)sayHello:(id)sender {
    self.textField.stringValue = @"hello";
}

- (IBAction)sayGoodbye:(id)sender {
    self.textField.stringValue = @"Goodbye";
}
@end

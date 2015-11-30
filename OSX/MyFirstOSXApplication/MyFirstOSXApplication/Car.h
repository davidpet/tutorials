//
//  Car.h
//  MyFirstOSXApplication
//
//  Created by David Petrofsky on 11/29/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
@property (copy) NSString *model;
- (void)drive;
@end

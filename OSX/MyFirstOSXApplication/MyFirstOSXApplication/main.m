//
//  main.m
//  MyFirstOSXApplication
//
//  Created by David Petrofsky on 11/29/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Car *car = [[Car alloc] init];
        car.model = @"Corolla";
        [car drive];
    }
    return 0;
}

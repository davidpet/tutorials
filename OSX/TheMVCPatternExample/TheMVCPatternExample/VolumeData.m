//
//  VolumeData.m
//  TheMVCPatternExample
//
//  Created by David Petrofsky on 12/13/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import "VolumeData.h"

@implementation VolumeData

- (id) init {
    self = [super init];
    if (self) {
        self.volumeWithoutMute = 100;
        self.isMuted = NO;
    }
    return self;
}

- (NSUInteger) volume {
    if (self.isMuted)
        return 0;
    else
        return self.volumeWithoutMute;
}

@end

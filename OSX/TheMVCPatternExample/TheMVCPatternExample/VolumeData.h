//
//  VolumeData.h
//  TheMVCPatternExample
//
//  Created by David Petrofsky on 12/13/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VolumeData : NSObject


@property (nonatomic) BOOL isMuted;

@property (nonatomic) NSUInteger volumeWithoutMute;

@property (nonatomic, readonly) NSUInteger volume;


@end

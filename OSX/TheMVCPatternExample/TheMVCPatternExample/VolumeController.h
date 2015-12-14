//
//  VolumeController.h
//  TheMVCPatternExample
//
//  Created by David Petrofsky on 12/13/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VolumeData.h"

@interface VolumeController : NSObject

@property (nonatomic) VolumeData *volumeData;

@property (weak) IBOutlet NSTextField *volumeTextField;
@property (weak) IBOutlet NSButton *muteButton;
@property (weak) IBOutlet NSSlider *volumeSlider;

- (IBAction)changeMute:(id)sender;
- (IBAction)changeVolume:(id)sender;

@end

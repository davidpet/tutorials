//
//  VolumeController.m
//  TheMVCPatternExample
//
//  Created by David Petrofsky on 12/13/15.
//  Copyright © 2015 David Petrofsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VolumeController.h"

@implementation VolumeController

- (id) init {
    self = [super init];
    if (self) {
        self.volumeData = [[VolumeData alloc] init];
    }
    return self;
}

- (void) awakeFromNib {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
    [self.volumeData addObserver:self forKeyPath:@"isMuted" options:options context:NULL];
    [self.volumeData addObserver:self forKeyPath:@"volumeWithoutMute" options:options context:NULL];
    
    [self synchronizeWithData];
}

- (void)dealloc {
    [self.volumeData removeObserver:self forKeyPath:@"isMuted"];
    [self.volumeData removeObserver:self forKeyPath:@"volumeWithoutMute"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (object == self.volumeData) {
        [self synchronizeWithData];
    }
}

- (void)synchronizeWithData {
    if (self.volumeData.isMuted) {
        self.muteButton.title = @"Unmute";
        self.volumeSlider.enabled = NO;
    }
    else {
        self.muteButton.title = @"Mute";
        self.volumeSlider.enabled = YES;
    }
    
    self.volumeTextField.stringValue = [NSString stringWithFormat:@"%ld", self.volumeData.volume];
    self.volumeSlider.integerValue = self.volumeData.volume;
}


- (IBAction)changeMute:(id)sender {
    self.volumeData.isMuted = !self.volumeData.isMuted;
}

- (IBAction)changeVolume:(id)sender {
    self.volumeData.volumeWithoutMute = self.volumeSlider.integerValue;
}

@end

//
//  JGDelayButton.m
//  AudioAndVideoDemo
//
//  Created by stkcctv on 16/9/19.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGDelayButton.h"

static NSTimeInterval defaultDuration = 2.0f;

static BOOL _isIgnoreEvent = NO;

static void resetState() {
    
    _isIgnoreEvent = NO;
}

@implementation JGDelayButton

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([self isKindOfClass:[UIButton class]]) {
        
        self.clickDurationTime = self.clickDurationTime == 0 ? defaultDuration : self.clickDurationTime;
        
        if (_isIgnoreEvent) {
            
            return;
        }
        else if (self.clickDurationTime > 0) {
            
            _isIgnoreEvent = YES;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.clickDurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                resetState();
            });
            
            [super sendAction:action to:target forEvent:event];
        }
    }
    else {
        
        [super sendAction:action to:target forEvent:event];
    }
}

@end

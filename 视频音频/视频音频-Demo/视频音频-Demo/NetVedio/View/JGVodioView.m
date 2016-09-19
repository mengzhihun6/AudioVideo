//
//  JGVodioView.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/26.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGVodioView.h"

@implementation JGVodioView

+ (instancetype)vodioView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

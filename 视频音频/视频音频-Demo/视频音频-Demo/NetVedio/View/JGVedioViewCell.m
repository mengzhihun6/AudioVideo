//
//  JGVedioViewCell.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/26.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGVedioViewCell.h"
#import "JGVedioModel.h"


@interface JGVedioViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;

@property (weak, nonatomic) IBOutlet UILabel *playCount;

@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UIImageView *simpleImg;

@end



@implementation JGVedioViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(JGVedioModel *)model {
    
    _model = model;
    
    [self.userImg sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"3"]];
    self.userName.text = model.name;
    self.createTime.text = model.create_time;
    self.descLbl.text = model.text;

//    JGLog(@" ===  %@",model.text);
    
    [self.simpleImg sd_setImageWithURL:[NSURL URLWithString:model.cdn_img] placeholderImage:[UIImage imageNamed:@"background"]];
    self.playCount.text = [NSString stringWithFormat:@"%d",model.playcount];
    
    NSInteger minute = model.videotime.integerValue / 60;
    NSInteger second = model.videotime.integerValue % 60;
    
    if (minute) {
        
        NSString *formatStr = minute < 10 ? @"%01zd分%02zd秒" : @"%02zd分%02zd秒";
        self.playTime.text = [NSString stringWithFormat:formatStr, minute, second];
    }else {
        
        self.playTime.text = [NSString stringWithFormat:@"%02zd秒",second];
    }
    

    
    
    
}

- (IBAction)playVedioBtnClick:(UIButton *)sender {

    UIViewController *VedioDetailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"VedioDetailVC"];
    
    [VedioDetailVC setValue:self.model.videouri forKey:@"urlStr"];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:VedioDetailVC animated:YES completion:nil];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  JGMusicListCell.m
//  视频音频-Demo
//
//  Created by stkcctv on 16/8/25.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGMusicListCell.h"
#import "JGMusicListModel.h"

@interface JGMusicListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JGMusicListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width * 0.5;
    self.imgView.clipsToBounds = YES;
}

- (void)setModel:(JGMusicListModel *)model {

    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] placeholderImage:[UIImage imageNamed:@"3.jpg"]];
    self.titleLabel.text = model.title;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

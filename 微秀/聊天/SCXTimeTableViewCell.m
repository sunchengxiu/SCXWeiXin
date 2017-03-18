//
//  SCXTimeTableViewCell.m
//  聊天
//
//  Created by 孙承秀 on 16/9/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXTimeTableViewCell.h"

@implementation SCXTimeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timeLabel=[[UILabel alloc]init];
        [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;

}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.timeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:100];
    [self.timeLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-100];
    [self.timeLabel autoSetDimension:ALDimensionHeight toSize:self.contentView.frame.size.height];
   // [self.timeLabel setBackgroundColor:[UIColor redColor]];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

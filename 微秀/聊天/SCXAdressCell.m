//
//  SCXAdressCell.m
//  聊天
//
//  Created by 孙承秀 on 16/10/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXAdressCell.h"

@implementation SCXAdressCell

-(void)setCount:(NSString *)count{
    [self.label removeFromSuperview];
    self.label=nil;
    _count=count;
    int hidden=[count intValue];
    self.label.hidden=!hidden;
    self.label.text=count;
}

-(UILabel *)label{
    if (!_label) {
        _label  = [[UILabel alloc]init];
        [_label setBackgroundColor:[UIColor redColor]];
        [_label setTextColor:[UIColor whiteColor]];
        [_label.layer setCornerRadius:10];
        [_label.layer setMasksToBounds:YES];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(22);
             make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-22);
             make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
            if ([_count intValue]<10) {
                make.width.mas_equalTo(20);
            }
            make.height.mas_equalTo(20);
            
        }];
    }
    return _label;
}

@end

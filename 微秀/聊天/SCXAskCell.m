//
//  SCXAskCell.m
//  聊天
//
//  Created by 孙承秀 on 16/10/21.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXAskCell.h"
extern int unAcceptCount;
@implementation SCXAskCell
-(void)setInfoDic:(NSDictionary *)infoDic{
    NSString *imageName=infoDic[kImgKey];
    NSDictionary *dic=infoDic[kTitleKey];
    NSString *userName=dic[kUser];
    NSString *liyou=dic[kLIYou];
    NSString *acceptTitle=dic[kAcceptButtonTitle];
    UIImage *image=[UIImage imageNamed:imageName];
    [self.iconImageView setImage:image];
    self.iconImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.label setText:userName];
    [self.label1 setText:liyou];
    [self setUpButton:acceptTitle];
}
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView=[[UIImageView alloc]init];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(5);
            make.top.mas_equalTo(self.contentView.mas_top).offset(5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
            make.width.mas_equalTo(_iconImageView.mas_height);
        }];
    }
    return _iconImageView;
}
-(UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc]init];
        [_label setFont:[UIFont boldSystemFontOfSize:16]];
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
            make.top.mas_equalTo(self.iconImageView.mas_top).offset(2);
            make.height.mas_equalTo(20);
        }];
    }
    return _label;
}
-(UILabel *)label1{
    if (!_label1) {
        _label1=[[UILabel alloc]init];
        [_label1 setFont:[UIFont systemFontOfSize:13]];
        [_label1 setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_label1];
        [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label.mas_left).offset(0);
            make.top.mas_equalTo(self.label.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
        }];
    }
    return _label1;
}
-(void)setUpButton:(NSString *)title{
    if (!_button) {
        _button=[[UIButton alloc]init];
        [self.contentView addSubview:_button];
        
        if ([title isEqualToString:@"接受"]) {
            unAcceptCount++;
            _button.userInteractionEnabled=YES;
            [_button setBackgroundColor:Global_tintColor];
        }
        else{
            
            _button.userInteractionEnabled=NO;
            [_button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_button setBackgroundColor:[UIColor whiteColor]];
        }
        [_button setTitle:title forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(accecptClick:) forControlEvents:UIControlEventTouchUpInside];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
            make.top.mas_equalTo(self.contentView.mas_top).offset(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20);
            make.width.mas_equalTo(64);
        }];
    }
}

-(void)accecptClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(clickAcceptButton:andHandleBlock:)]) {
        [self.delegate clickAcceptButton:self andHandleBlock:^(NSInteger integer) {
            [button setTitle:@"已接受" forState:UIControlStateNormal];
            [_button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
            button.userInteractionEnabled=NO;
            unAcceptCount--;
        }];
    }
}

@end

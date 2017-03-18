//
//  SCXPersonalCell.m
//  聊天
//
//  Created by 孙承秀 on 16/10/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXPersonalCell.h"

@implementation SCXPersonalCell
-(void)layoutCellIsHasIconImageView:(BOOL)isImageView andAlbum:(BOOL)isAlbum andSendButton:(BOOL)isSendButton{
    self.isIconImageView=isImageView;
    self.isHasAlbum=isAlbum;
    self.isSend=isSendButton;
}
-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic=infoDic;
    [self removeFromSuperview];
    if (self.isIconImageView) {
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
            make.left.mas_equalTo(self.contentView.mas_left).offset(20);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
            make.width.mas_equalTo(self.iconImageView.mas_height);
        }];
        [self.iconImageView setImage:[UIImage imageNamed:infoDic[kImgKey]]];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconImageView.mas_top).offset(10);
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(8);
            make.height.mas_equalTo(15);
        }];
        [self.weixinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
        }];
        [self.nameLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [self.weixinLabel setFont:[UIFont systemFontOfSize:15]];
        [self.weixinLabel setTextColor:[UIColor lightGrayColor]];
        [self.weixinLabel setText:@"15699998823"];
        [self.nameLabel setText:@"大牌丶"];
    }
    else{
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(20);
            make.top.mas_equalTo(self.contentView.mas_top).offset(5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        [self.titleLabel setText:infoDic[kTitleKey]];
    }
    if (self.isSend) {
        [self.sendMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(20);
            make.top.mas_equalTo(self.contentView.mas_top).offset(4);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-4);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
            
        }];
        self.sendMessageButton.layer.masksToBounds=YES;
        self.sendMessageButton.layer.cornerRadius=4;
        self.sendMessageButton.backgroundColor=Global_tintColor;
        [self.sendMessageButton setTitle:infoDic[kTitleKey] forState:UIControlStateNormal];
        if ([infoDic[kTitleKey] isEqualToString:@"视频聊天"]) {
            [self.sendMessageButton setBackgroundColor:[UIColor whiteColor]];
            self.sendMessageButton.layer.masksToBounds=YES;
            self.sendMessageButton.layer.borderWidth=1;
            self.sendMessageButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
            [self.sendMessageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}
-(void)removeViewFromSuperView{
    [self.iconImageView removeFromSuperview];
    self.iconImageView=nil;
    [self.titleLabel removeFromSuperview];
    self.titleLabel=nil;
    [self.nameLabel removeFromSuperview];
    self.nameLabel=nil;
    [self.sendMoiveButton removeFromSuperview];
    self.sendMoiveButton=nil;
    [self.sendMessageButton removeFromSuperview];
    self.sendMessageButton=nil;
    [self.weixinLabel removeFromSuperview];
    self.weixinLabel=nil;
}
#pragma mark--懒加载
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView=[[UIImageView alloc]init];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UILabel *)weixinLabel{
    if (_weixinLabel==nil) {
        _weixinLabel=[[UILabel alloc]init];
        [self.contentView addSubview:_weixinLabel];
    }
    return _weixinLabel;
}
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
    
}
-(UIButton *)sendMessageButton{
    if (_sendMessageButton==nil) {
        _sendMessageButton=[[UIButton alloc]init];
        [_sendMessageButton addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_sendMessageButton];
    }
    return _sendMessageButton;
}
-(UIButton *)sendMoiveButton{
    if (_sendMoiveButton==nil) {
        _sendMoiveButton=[[UIButton alloc]init];
        [self.contentView addSubview:_sendMoiveButton];
    }
    return _sendMoiveButton;
}
#pragma mark--按钮点击触发事件
-(void)sendClick:(UIButton *)but{
    if (self.block) {
        self.block([but currentTitle]);
    }
}

@end

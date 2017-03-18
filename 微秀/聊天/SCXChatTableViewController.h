//
//  SCXChatTableViewController.h
//  聊天
//
//  Created by 孙承秀 on 16/9/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMSDK.h"
#import "SCXSendTableViewCell.h"
#import "SCXBaseTableViewController.h"
#import <MBProgressHUD.h>
#import "SCXCallManager.h"
@interface SCXChatTableViewController : SCXBaseTableViewController<UITextViewDelegate,UIImagePickerControllerDelegate,EMChatManagerDelegate,EMContactManagerDelegate>

@property (nonatomic, strong) EMGroup *group;

@property (nonatomic, copy) NSString *Username;

@property (nonatomic, assign) BOOL isGroup;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)EMConversation *conversation;
@property(nonatomic,strong)UITableView *tableView1;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIView *keyBoardView;
@property(nonatomic,strong)UIButton *keyboardButton;
@property(nonatomic,strong)UIButton *recordButton;
@property(nonatomic,strong)UIButton *moreButton;
@property(nonatomic,strong)UIButton *emojiButton;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)SCXSendTableViewCell *chatCell;
@property(nonatomic,strong)UIView *emojiView;
@property(nonatomic,strong)UIView *intrusView;
@property(nonatomic,assign)BOOL isEmoji;
@property(nonatomic,assign)BOOL isIntrus;
@property(nonatomic,strong)UIButton *imageBUtton;
@property(nonatomic,strong)UIButton *voiceButton;
@property(nonatomic,strong)UIButton *videoButton;
/******  hud *****/
@property(nonatomic,strong)MBProgressHUD *hud;
/******  聊天celFrameArray *****/
@property(nonatomic,strong)NSMutableArray *cellFrameArray;

@end

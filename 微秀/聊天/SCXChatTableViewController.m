//
//  SCXChatTableViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/9/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXChatTableViewController.h"
#import "NSDate+Extension.h"
#import "SCXSendTableViewCell.h"

#import "SCXTimeTableViewCell.h"
#import "MD5Class.h"
#import "EMCDDeviceManagerDelegate.h"
#import "EMCDDeviceManager.h"
#import "SCXChatFrame.h"
#import "SCXChatModel.h"
static NSString * const sendCell=@"sendCell";
static NSString * const receiveCell=@"receiveCell";
@interface SCXChatTableViewController ()

@end

@implementation SCXChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kBackgroundColor];
    self.navigationController.navigationBar .tintColor=[UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    [self loadAllMessage];
    self.SCX_tableView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboardFirstResponder:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.SCX_tableView.backgroundColor=kBackgroundColor;
    self.SCX_tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}
-(void)loadBottomView{
    UIView *view=[[UIView alloc]init];
    UIButton *recordButton=[[UIButton alloc]init];
    //[recordButton setBackgroundImage:[UIImage imageNamed:@"chatBar_record"] forState:UIControlStateNormal];
    [recordButton setTitle:@"按住讲话" forState:UIControlStateNormal];
    [recordButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [recordButton addTarget:self action:@selector(recordBegin:) forControlEvents:UIControlEventTouchDown];
    [recordButton addTarget:self action:@selector(recordEnd:) forControlEvents:UIControlEventTouchUpInside];
    [recordButton addTarget:self action:@selector(recordCancel:) forControlEvents:UIControlEventTouchUpOutside];
    UIButton *keyboardButton=[[UIButton alloc]init];
    [keyboardButton setBackgroundImage:[UIImage imageNamed:@"chatBar_keyboard"] forState:UIControlStateSelected];
    [keyboardButton setBackgroundImage:[UIImage imageNamed:@"chatBar_recordSelected"] forState:UIControlStateNormal];
   
    [keyboardButton addTarget:self action:@selector(keyBoardButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:keyboardButton];
    UIButton *moreButton=[[UIButton alloc]init];
    [moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [moreButton setBackgroundImage:[UIImage imageNamed:@"chatBar_more"] forState:UIControlStateNormal];
    [moreButton setBackgroundImage:[UIImage imageNamed:@"chatBar_moreSelected"] forState:UIControlStateSelected];
    [view addSubview:moreButton];
    UIButton *emojiButton=[[UIButton alloc]init];
    [emojiButton setBackgroundImage:[UIImage imageNamed:@"chatBar_face"] forState:UIControlStateNormal];
    [emojiButton setBackgroundImage:[UIImage imageNamed:@"chatBar_faceSelected"] forState:UIControlStateSelected];
    
    [view addSubview:emojiButton];
    UITextView *textView=[[UITextView alloc]init];
    [view addSubview:textView];
    [view addSubview:recordButton];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:view];
    
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:[[[UIApplication sharedApplication] delegate] window] withOffset:0];
    [view autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:[[[UIApplication sharedApplication] delegate] window] withOffset:0];
    [view autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:[[[UIApplication sharedApplication] delegate] window] withOffset:0];
    [view autoSetDimension:ALDimensionHeight toSize:50];
    [view setBackgroundColor:[UIColor whiteColor]];
    _bottomView=view;
    _recordButton=recordButton;
    _keyboardButton=keyboardButton;
    _moreButton=moreButton;
    _emojiButton=emojiButton;
    _textView=textView;
    [_keyboardButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view withOffset:5];
    [_keyboardButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:view withOffset:8];
    [_keyboardButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:view withOffset:-8];
    [_keyboardButton autoSetDimension:ALDimensionWidth toSize:34];

    [_moreButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view withOffset:-5];
    [_moreButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:view withOffset:8];
    [_moreButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:view withOffset:-8];
    [_moreButton autoSetDimension:ALDimensionWidth toSize:34];
    [_emojiButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_moreButton withOffset:-5];
    [_emojiButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_moreButton];
    [_emojiButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_moreButton];
    [_emojiButton autoSetDimension:ALDimensionWidth toSize:34];
    [_textView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_keyboardButton withOffset:5];
    [_textView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_emojiButton withOffset:-5];
    [_textView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_emojiButton];
    [_textView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_emojiButton];
    [_recordButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_keyboardButton withOffset:5];
    [_recordButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_emojiButton withOffset:-5];
    [_recordButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_emojiButton];
    [_recordButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_emojiButton];
    [_recordButton setBackgroundColor:[UIColor lightGrayColor]];
       // _recordButton.hidden=YES;
    [_textView setBackgroundColor:[UIColor lightGrayColor]];
    _textView.enablesReturnKeyAutomatically=YES;
    _textView.font=[UIFont systemFontOfSize:16];
    _textView.delegate=self;
    self.chatCell=[self.SCX_tableView dequeueReusableCellWithIdentifier:@"sendCell"];
    //键盘
    UIView *keyboardView=[[UIView alloc]init];
    [keyboardView setBackgroundColor:[UIColor redColor]];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:keyboardView];
    [keyboardView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:view];
    [keyboardView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view];
    [keyboardView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view];
    [keyboardView autoSetDimension:ALDimensionHeight toSize:225];
    CGFloat weight=([UIScreen mainScreen].bounds.size.width-20*4)/3;
    NSArray *arr=[NSArray arrayWithObjects:@"图片",@"语音",@"视频", nil];
    for (NSInteger i=0; i<3; i++) {
        UIButton *button=[[UIButton alloc]init];
        [keyboardView addSubview:button];
        [button setBackgroundColor:[UIColor greenColor]];
        [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:keyboardView    withOffset:20*(i+1)+weight*i];
        [button autoSetDimension:ALDimensionWidth toSize:weight];
        [button autoSetDimension:ALDimensionHeight toSize:weight];
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:keyboardView withOffset:50];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag=i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            _imageBUtton=button;
        }
        if (i==1) {
            _voiceButton=button;
        }
        if (i==2) {
            _videoButton=button;
        }
    }
    _keyBoardView=keyboardView;
    _bottomView=view;
    
   
}
-(void)beginRecord:(UIButton *)button{


}
-(void)endRecore:(UIButton *)button{


}
-(void)cancelRecord:(UIButton *)button{


}
-(void)buttonClick:(UIButton *)button{
    if (button.tag==0) {
        [self openImagePickerDataBase:UIImagePickerControllerSourceTypePhotoLibrary];
        NSLog(@"点击图片了 ");
    
    }
    if (button.tag==1) {
        NSLog(@"点击语音了");
        NSLog(@"%@",self.Username);
        [SCXCallManager sharedCallManager];
        [[NSNotificationCenter defaultCenter] postNotificationName:CALL_NOTIFIGATION object:@{@"userName":self.Username,@"type":[NSNumber numberWithInt:0],@"controller":self}];
       
    }
    if (button.tag==2) {
         NSLog(@"点击视频了");
         [[NSNotificationCenter defaultCenter] postNotificationName:CALL_NOTIFIGATION object:@{@"userName":self.Username,@"type":[NSNumber numberWithInt:1],@"controller":self}];
    }

}
-(void)keyBoardButtonclick:(UIButton *)keyBoardButton{
    _keyboardButton.selected=!keyBoardButton.selected;
    if (_keyboardButton.selected) {
        _recordButton.hidden=YES;
        [_textView resignFirstResponder];
        
    }
    else{
        _recordButton.hidden=NO;
        [_textView becomeFirstResponder];
    
        
    }

}
-(void)recordButtonClick:(UIButton *)recordButton{

}
-(void)moreButtonClick:(UIButton *)moreButton{
    moreButton.selected=!moreButton.selected;
    if (moreButton.selected) {
        [_textView resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            
            _bottomView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-260-50, [UIScreen mainScreen].bounds.size.width, 50);
            [self scrollToBottom:NO];
            _keyBoardView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-260, _bottomView.frame.size.width, 260);
            
        }];
    }
    else{
    [_textView becomeFirstResponder];
        
    }
    
}
-(void)emojiButtonClick:(UIButton *)emojiButton{


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadBottomView];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
}

-(void)loadAllMessage{
    [self.dataArray removeAllObjects];
    [self.cellFrameArray removeAllObjects];
    NSString *typeStr=self.isGroup?self.group.groupId:self.Username;
    EMConversationType type=self.isGroup?EMConversationTypeGroupChat:EMConversationTypeChat;
    EMConversation *conversation=[[EMClient sharedClient].chatManager getConversation:typeStr type:type createIfNotExist:YES];
    self.conversation=conversation;
   [conversation loadMessagesStartFromId:nil count:1000 searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
       if (aError==nil) {
           for (EMMessage *message in aMessages) {
               SCXChatModel *model=[[SCXChatModel alloc]init];
               model.message=message;
               SCXChatFrame *chatFrame=[[SCXChatFrame alloc]init];
               chatFrame.chatModel=model;
               
               [self addMessageToDataSource:message andCellFrame:chatFrame];
           }
       }
    }];

}
-(void)addMessageToDataSource:(EMMessage *)message andCellFrame:(SCXChatFrame *)cellFrame{
    NSDate *lastCurrentDate=0;
    if (self.dataArray.count>0) {
        SCXChatFrame *chatFrame=[self.dataArray lastObject];
        EMMessage *message=chatFrame.chatModel.message;
        NSDate *lastDate=[NSDate dateWithTimeIntervalSince1970:message.timestamp/1000.0];
        lastCurrentDate=lastDate;
    }
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:message.timestamp/1000.0];
    NSString *currentTime=[date ff_dateDescription2];
    NSInteger invocation=ABS((NSInteger)[date timeIntervalSinceDate:lastCurrentDate]);
    if (invocation>60) {
        [self.dataArray addObject:currentTime];
    }
    SCXChatModel *model=[[SCXChatModel alloc]init];
    model.message=message;
    [self.cellFrameArray addObject:cellFrame];
    [self.dataArray addObject:cellFrame];
    [self.SCX_tableView reloadData];
    [self.SCX_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [self.conversation markMessageAsReadWithId:message.messageId error:nil];

}
-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text hasSuffix:@"\n"]) {
        [self setText:textView.text];
        textView.text=nil;
        [textView scrollRangeToVisible:textView.selectedRange];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}


-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.SCX_tableView.separatorStyle=UITableViewCellSelectionStyleNone;
   
    if ([self.dataArray[indexPath.row] isKindOfClass:[NSString class]]) {
       
        SCXTimeTableViewCell *timeCell= [SCXTimeTableViewCell cellWithTableView:self.SCX_tableView];
        timeCell.timeLabel.text=self.dataArray[indexPath.row];
        timeCell.selectionStyle=UITableViewCellSelectionStyleNone;
        timeCell.backgroundColor=kBackgroundColor;
        return timeCell;
    }
    else{
        SCXSendTableViewCell *cell=[SCXSendTableViewCell cellWithTableView:self.SCX_tableView];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        SCXChatFrame *chatFrmae=self.dataArray[indexPath.row];
        cell.chatFrmae=chatFrmae;
        cell.backgroundColor=kBackgroundColor;
        return cell;
      
    }
 
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataArray[indexPath.row] isKindOfClass:[NSString class]]) {
        return 30;
    }
    SCXChatFrame *chatFrame=self.dataArray[indexPath.row];
    return chatFrame.cellHeight;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    for (NSInteger i=0;i<_bottomView.subviews.count;i++) {
        UIButton *bt=(UIButton *)_bottomView.subviews[i];
        [bt removeFromSuperview];
        bt=nil;
    }
    [_imageBUtton removeFromSuperview];
    _imageBUtton=nil;
    [_voiceButton removeFromSuperview];
    _voiceButton=nil;
    [_videoButton removeFromSuperview];
    _videoButton=nil;
    [_bottomView removeFromSuperview];
    _bottomView=nil;
}
-(void)keyBoardShow:(NSNotification *)noti{
    
    CGRect rect=[[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat durtion=[[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat kbHeight = rect.size.height;
    
    CGRect beginRect = [[noti.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGRect endRect = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSLog(@"%f", kbHeight);
    NSLog(@"%@    ----   %@,    %f  xxx %f ",NSStringFromCGRect(beginRect), NSStringFromCGRect(endRect), beginRect.size.height, beginRect.origin.y - endRect.origin.y);
    // 第三方键盘回调三次问题，监听仅执行最后一次
    
    if(!(beginRect.size.height > 0 && ( fabs(beginRect.origin.y - endRect.origin.y) > 0))) return;
    [UIView animateWithDuration:durtion animations:^{
        if(self.SCX_tableView.contentSize.height>SCX_ScreenHeight-rect.size.height){
        self.SCX_tableView.frame=CGRectMake(0, -rect.size.height, [UIScreen mainScreen].bounds.size.width, self.SCX_tableView.frame.size.height);
        }
        _bottomView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-rect.size.height-50, [UIScreen mainScreen].bounds.size.width, 50);
        [self scrollToBottom:NO];
        
    }];
    
    
}
-(void)keyBoardHide:(NSNotification *)no{
    
    [UIView animateWithDuration:0.3 animations:^{
       self.SCX_tableView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.SCX_tableView.frame.size.height);
       _bottomView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width, 50);
      
        [_textView resignFirstResponder];
        [self scrollToBottom: NO];
        
    }];

}
-(void)resignKeyboardFirstResponder:(UITapGestureRecognizer *)tap{

    [UIView animateWithDuration:0.3 animations:^{
        
        _bottomView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width, 50);
       _keyBoardView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height, _bottomView.frame.size.width, 260);
        [_textView resignFirstResponder];
       // [self scrollToBottom:NO];
       
    }];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}
- (void)scrollToBottom:(BOOL)animated {
    // 1.获取最后一行
    if (self.dataArray.count == 0) {
        return;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
    [self.SCX_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}
-(void)openImagePickerDataBase:(UIImagePickerControllerSourceType)type{

    UIImagePickerController *pickerController=[[UIImagePickerController alloc]init];
    pickerController.sourceType=type;
    pickerController.delegate=self;
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    [self sendImage:image];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}
-(void)recordBegin:(UIButton *)recordButton{
    int random=arc4random()%1000;
    NSString *md5=[MD5Class md5:[NSString stringWithFormat:@"%d",random] ];
    [[EMCDDeviceManager sharedInstance] asyncStartRecordingWithFileName:md5 completion:^(NSError *error) {
        if (!error) {
            //[MBProgressHUD showLoadingWithView:[[[UIApplication sharedApplication] delegate] window] andText:@"录制中..."];
            [MBProgressHUD showAnimationImageView:[[[UIApplication sharedApplication] delegate] window]];
            NSLog(@"开始语音录制");
        }
    }];

}
-(void)recordEnd:(UIButton *)recordButton{
    [[EMCDDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
        NSLog(@"语音录制成功");
        [MBProgressHUD hideAllHUDsInView:[[[UIApplication sharedApplication] delegate] window]];
        if (aDuration<1) {
           
            MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:[[[UIApplication sharedApplication] delegate] window]];
            [[[[UIApplication sharedApplication] delegate] window] addSubview:hud];
            hud.mode=MBProgressHUDModeText;
            hud.labelText=@"对不起，说话时间过短";
            hud.yOffset=200;
            __block typeof(hud)HUD=hud;
            [hud showAnimated:YES whileExecutingBlock:^{
                sleep(2);
            } completionBlock:^{
                [HUD removeFromSuperview];
                HUD=nil;
            }];
        }
        else{
            [self sendVoiceWithVoicePath:recordPath andVoiceDurtion:aDuration];
        }
    }];
}
-(void)recordCancel:(UIButton *)recordButton{
    [MBProgressHUD hideAllHUDsInView:[[[UIApplication sharedApplication] delegate] window]];
    [MBProgressHUD hideAllHUDsInView:[[[UIApplication sharedApplication] delegate] window]];
    NSLog(@"取消此次录音了");
    [[EMCDDeviceManager sharedInstance] cancelCurrentRecording];
    
}
-(void)setText:(NSString *)text{
    EMTextMessageBody *body=[[EMTextMessageBody alloc]initWithText:text];
    NSString *from=[[EMClient sharedClient] currentUsername];
    NSString *to=self.isGroup?self.group.groupId:self.Username;
    
    EMMessage *message=[[EMMessage alloc]initWithConversationID:to from:from to:to body:body ext:nil];
    SCXChatModel *model=[[SCXChatModel alloc]init];
    model.message=message;
    SCXChatFrame *cellFrame=[[SCXChatFrame alloc]init];
    cellFrame.chatModel=model;
    [self addMessageToDataSource:message andCellFrame:cellFrame];
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        
    } completion:^(EMMessage *message, EMError *error) {
        if (error==nil) {
            NSLog(@"消息发送成功");
            [self.SCX_tableView reloadData];
            
        }
        else {
            NSLog(@"消息发送失败");
        }
        
    }];
}
-(void)sendImage:(UIImage *)imge{
    NSData *data=UIImageJPEGRepresentation(imge, 1);
    EMImageMessageBody *body=[[EMImageMessageBody alloc]initWithData:data displayName:@"[图片]"];
    NSString *to=self.isGroup?self.group.groupId:self.Username;
    NSString *from=[[EMClient sharedClient] currentUsername];
    EMMessage *message=[[EMMessage alloc]initWithConversationID:to from:from to:to body:body ext:nil];
    message.chatType=EMChatTypeChat;
    SCXChatModel *model=[[SCXChatModel alloc]init];
    model.message=message;
    SCXChatFrame *chatFrame=[[SCXChatFrame alloc]init];
    chatFrame.chatModel=model;
    [self addMessageToDataSource:message andCellFrame:chatFrame];
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        NSLog(@"图片进度:%d",progress);
    } completion:^(EMMessage *message, EMError *error) {
        if (error==nil) {
            NSLog(@"图片发送成功");
            [self loadAllMessage];
        }
        else{
            NSLog(@"图片发送失败");
        }
    }];
    
    
}

-(void)sendVoiceWithVoicePath:(NSString *)voicePath andVoiceDurtion:(NSInteger )durtion{
    EMVoiceMessageBody *voiceBody=[[EMVoiceMessageBody alloc]initWithLocalPath:voicePath displayName:@"[语音]"];
    voiceBody.duration=(int)durtion;
    NSString *to=self.isGroup?self.group.groupId:self.Username;
    NSString *from=[[EMClient sharedClient] currentUsername];
    EMMessage *message=[[EMMessage alloc]initWithConversationID:to from:from to:to body:voiceBody ext:nil];
    SCXChatModel *model=[[SCXChatModel alloc]init];
    model.message=message;
    SCXChatFrame *chatFrame=[[SCXChatFrame alloc]init];
    chatFrame.chatModel=model;
    [self addMessageToDataSource:message andCellFrame:chatFrame];
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        
    } completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            NSLog(@"语音发送成功");
        }
        else{
            NSLog(@" 育婴发送失败");
        }
    }];
}
-(NSMutableArray *)cellFrameArray{
    if (!_cellFrameArray) {
        _cellFrameArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _cellFrameArray;
}
-(void)messagesDidReceive:(NSArray *)aMessages{
    [self loadAllMessage];

}

@end

//
//  SCXGroupViewController.swift
//  聊天
//
//  Created by 孙承秀 on 16/10/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXGroupViewController: UITableViewController ,EMGroupManagerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden=true
        self.view.backgroundColor=UIColor.white
        /**********创建按钮***********/
        let rightButton:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        /**********swift有类型推倒，会自动识别为int类型***********/
       // let a  = 3
        
        rightButton.backgroundColor=UIColor.red
        /**********"!"表示这个可选变量存在，可以使用，如果用"!"访问不存在的可选变量会导致一些错误
         
         "?"表示这个变量可能不存在，如果不存在，"?"所在语句后面的内容都不会执行
         
         
         
         !是一个强制拆包,告诉编译器我绝对肯定代码能够执行, 如: strValue!.hashValue ,如果不能执行则报错。
         ?是表示一个不确定,strValue?.hashValue 就等于OC的if(strValue){  [strValue hashValue]; } 有就执行,有没后面代码就不执行。 不会报错。***********/
        rightButton.addTarget(self, action: #selector(buttonClick(btn:)), for: UIControlEvents.touchUpInside)
        let image:UIImage? = UIImage(named: "add_friend_icon_addgroup")
        rightButton.setBackgroundImage(image, for: UIControlState.normal)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(customView: rightButton)
        self.getGroupList()
        let error:EMError = EMError()
        
        let group:EMGroup = EMClient.shared().groupManager.fetchGroupInfo("123", includeMembersList: true, error: nil)
        
        //EMClient.shared().groupManager.add(<#T##aDelegate: EMGroupManagerDelegate!##EMGroupManagerDelegate!#>, delegateQueue: <#T##DispatchQueue!#>)
    }
    func getGroupList() -> () {
        
    }
   
    /// 添加群组
    ///
    /// - parameter btn: 添加群组按钮
    func buttonClick(btn:UIButton!) -> () {
       print("点击添加群组了")
        /**********EMError *error = nil***********/
        let error:EMError = EMError()
        // EMGroupOptions *setting = [[EMGroupOptions alloc] init];
        let setting:EMGroupOptions = EMGroupOptions.init()
        setting.maxUsersCount = 500;
        setting.style = EMGroupStylePublicOpenJoin;// 创建不同类型的群组，这里需要才传入不同的类型
        //EMGroup *group = [[EMClient sharedClient].groupManager createGroupWithSubject:@"群组名称" description:@"群组描述" invitees:@[@"6001",@"6002"] message:@"邀请您加入群组" setting:setting error:&error];
        let group:EMGroup = EMClient.shared().groupManager.createGroup(withSubject: "大牌的群组", description: "大牌swift群组", invitees: ["456","rng"], message: "邀请您加入群组", setting: setting, error: nil)
       // EMClient.shared().groupManager.addOccupants(["123"], toGroup: "123", welcomeMessage: "欢迎加群", error: nil)
        if (error.errorDescription != nil) {
            print("群组创建失败")
        }
        else{
        print(group)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

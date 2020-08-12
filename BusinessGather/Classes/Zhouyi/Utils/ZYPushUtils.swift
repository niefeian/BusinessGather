//
//  ZYPushUtils.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/7/23.
//

import UIKit
import NFAToolkit
import SwiftProjects
import NFATipsUI

public class ZYPushUtils {
    
    
    //先只支持新模式，旧模式后面再说吧
    public class func csInfoRule(_ obj : CalculationVO) -> Bool
    {
        if obj.csType == "bbquming"
        {
            if obj.userVo.xing.count == 0
            {
                showTipsWindow("宝宝姓氏不能为空")
            }else if obj.userTime == nil
            {
                showTipsWindow("宝宝生日不能为空")
            }
            else if obj.userVo.nameNum == "0" && obj.userVo.dingzi.count > 0
            {
                showTipsWindow("单字名不可输入定字")
            }
            else if obj.userVo.isBirth.count > 0
            {
                let isBirth = Date(timeIntervalSince1970: TimeInterval(obj.userTime.birthday_time.floatValue())).timeIntervalSinceNow > 0
               if obj.userVo.isBirth == "1" && isBirth
                {
                   showTipsWindow("出生日期不能晚于当前时间")
               }
               else if  obj.userVo.isBirth == "0" && !isBirth
                {
                    showTipsWindow("出生日期不能早于当前时间")
               }
                else
                {
                return true
                }
            }
            else
            {
                return true
            }
        }
        else if obj.csType == "bazijingpi" || obj.csType == "chenggu" || obj.csType == "bazicaiyun" || obj.csType == "bazizonghe"
        {
            if obj.userVo.getUserName().count == 0
               {
                   showTipsWindow("您的姓名不能为空")
               }else if obj.userTime == nil
               {
                   showTipsWindow("您的生日不能为空")
               }
               else if obj.userVo.isBirth.count > 0
               {
                   let isBirth = Date(timeIntervalSince1970: TimeInterval(obj.userTime.birthday_time.floatValue())).timeIntervalSinceNow > 0
                  if obj.userVo.isBirth == "1" && isBirth
                   {
                      showTipsWindow("出生日期不能晚于当前时间")
                  }
                  else if  obj.userVo.isBirth == "0" && !isBirth
                   {
                       showTipsWindow("出生日期不能早于当前时间")
                  }
                   else
                   {
                   return true
                   }
               }
               else
               {
                   return true
               }
        }
        else if obj.csType == "bazihehun"
        {
            if obj.userVo.getUserName().count == 0 {
                showTipsWindow("男方姓名不能为空")
            }else if obj.userTime == nil {
                showTipsWindow("男方生日不能为空")
            }else if obj.womanUserVo.getUserName().count == 0 {
                showTipsWindow("女方姓名不能为空")
            }else if obj.womanUserTime == nil {
                showTipsWindow("女方生日不能为空")
            }else{
                return true
            }
        }
        else if obj.csType == "xingmingpd"
        {
            if  obj.userVo.xing.count == 0 {
                showTipsWindow("男方姓氏不能为空")
            }else if obj.userVo.name.count == 0 {
                 showTipsWindow("男方名字不能为空")
            }else if obj.womanUserVo.xing.count == 0 {
                showTipsWindow("女方姓氏不能为空")
            }else if obj.womanUserVo.name.count == 0 {
                 showTipsWindow("女方名字不能为空")
            }else {
                return true
            }
        }
        else if obj.csType == "xingmingxp"
        {
            if obj.userVo.xing.count == 0 {
                 showTipsWindow("您的姓氏不能为空")
            }else if obj.userVo.name.count == 0 {
                 showTipsWindow("您的名字不能为空")
            }else if obj.userTime == nil  {
                 showTipsWindow("您的生日不能为空")
            }else{
                 return true
            }
        }
        else if obj.csType == "fs_zaiming"
        {
            if obj.chaoxiang.count == 0 {
                 showTipsWindow("您必须选择大门朝向")
            }else if obj.userTime == nil  {
                 showTipsWindow("您的生日不能为空")
            }else{
                 return true
            }
        }
        
        return false
    }

    public class func showCSTips(_ obj : AnyObject , _ succes : @escaping CB)
    {
        let pop = PopupController.create(ResidentManager.curViewController)?.customize([ .animation(.none), .scrollable(false), .backgroundStyle(.blackFilter(alpha: 0.3)) ])
        let vw = CSTipsPopView()
        vw.csInfo = getObject(obj)
        vw.model = getObject(obj)
        vw.regCallBack { (data) in
            if let str = data as? Int , str == 1{
                succes()
            }
            pop?.dismiss()
        }
        pop?.show(vw)
    }
    
    
}

//
//  CalculationVO.swift
//  AutoModel
//
//  Created by 聂飞安 on 2020/7/3.
//

import UIKit
import AutoModel
import NFAFile

public enum AppSex : String {
      case 男 = "1" , 女 = "2"
}

public class CalculationVO: NSObject {
   
    @objc public var userTime : TimeVO!
    @objc public var userVo : UserVO!
    @objc public var womanUserTime : TimeVO!
    @objc public var womanUserVo : UserVO!
    @objc public var csType : String! = ""
    @objc public var chaoxiang  = ""//大门朝向
    
    public required init(_ dic: Any? = nil) {
        super.init()
        if let map = dic as? [String:AnyObject]
        {
            if let dic = map["userTime"]
            {
                userTime = TimeVO(dic)
            }
            if let dic = map["userVo"]
            {
                userVo = UserVO(dic)
            }
            if let dic = map["womanUserTime"]
            {
                womanUserTime = TimeVO(dic)
            }
            if let dic = map["womanUserVo"]
            {
                womanUserVo = UserVO(dic)
            }
        }
    }
    
    public class func get(_ key : String) -> CalculationVO?
    {
        if let map = UserDefaultsUtils.getInGroup("CalculationVO", key: key) as? [String: AnyObject]
        {
            return CalculationVO(map)
        }
        return nil
    }
    
    public func save(_ key : String){
        UserDefaultsUtils.setInGroup("CalculationVO", key: key, value: self.toJosn())
    }
    
    public func toJosn() -> [String:Any]{
        return MirrorUtils.jsonMirrorsMain(self)
    }
    
    
    public func calculationEngine(_ type : String , callBack : @escaping ([String:String]) -> Void)
        {

            switch type {
            case "bbquming":
                let para = ["sex": userVo.sex ,"timestamp":userTime.birthday_time,"birthday_gongli":userTime.birthday_gongli,"birthday_nongli":userTime.birthday_nongli,"xingshi":userVo.nameNum ,"ding":userVo.ding,"dingzi":userVo.dingzi,"xing":userVo.xing,"type":type]
                callBack(para)
            case "cemming":
                let para = ["sex": userVo.sex == "1" ? "1" : "0" ,"timestamp":userTime.birthday_time,"name": userVo.xing + userVo.name ,"type":userVo.xingNum == "1" ? "2":"1"]
                callBack(para)
            case "fs_zaiming":
                let para = ["sex":userVo.sex,"timestamp":userTime.birthday_time,"xiang":chaoxiang,"type":type,"infrom":"infrom"]
                callBack(para)
            case "chenggu":
                let para = ["name":userVo.getUserName(),"sex": userVo.sex,"nongli":userTime.birthday_nongli,"gongli":userTime.birthday_gongli,"timestamp":userTime.birthday_time,"type":type,"infrom":"infrom"]
                callBack(para)
            case "bazicaiyun":
                let para = ["name":userVo.getUserName(),"xingbie": userVo.sex,"xing":"","nongli":userTime.birthday_nongli,"gongli":userTime.birthday_gongli,"timestamp":userTime.birthday_time,"type":type,"infrom":"infrom"]
                callBack(para)
            case "bazijingpi":
                let para = ["name":userVo.getUserName(),"xingbie": userVo.sex,"xing":"","nongli":userTime.birthday_nongli,"gongli":userTime.birthday_gongli,"timestamp":userTime.birthday_time,"type":type,"infrom":"infrom"]
                callBack(para)
        case "bazizonghe":
             let para = ["name":userVo.getUserName(),"xingbie": userVo.sex,"xing":"","nongli":userTime.birthday_nongli,"gongli":userTime.birthday_gongli,"timestamp":userTime.birthday_time,"type":type,"infrom":"infrom"]
             callBack(para)
            case "bazihehun":
                let para = ["name1":userVo.getUserName(),"nongli1":userTime.birthday_nongli,"gongli1":userTime.birthday_gongli,"timestamp1":userTime.birthday_time,"name2":womanUserVo.getUserName(),"nongli2":womanUserTime.birthday_nongli,"gongli2":womanUserTime.birthday_gongli,"timestamp2":womanUserTime.birthday_time,"type":type,"infrom":"infrom"]
                callBack(para)
            case "xingmingpd":
                let para = ["malexing":userVo.xing,"malename":userVo.name,"femalexing":womanUserVo.xing,"femalename":womanUserVo.name,"type":type,"infrom":"infrom"]
                callBack(para)
            case "xingmingxp":
                let para = ["name":userVo.name,"xing":userVo.xing,"xingbie": userVo.sex,"nongli":userTime.birthday_nongli,"gongli":userTime.birthday_gongli,"timestamp":userTime.birthday_time,"type":type,"infrom":"infrom"]
                callBack(para)
            default:
                break
            }
        }
   
 
}


public class TimeVO: BaseModel {
    @objc public var birthday_time = ""
    @objc public var birthday_nongli = ""
    @objc public var birthday_gongli = ""
    @objc public var birthday_show = ""
}

public class UserVO : BaseModel {
    
    @objc public var name : String = ""
    @objc public var xing : String = ""
    @objc public var sex = "1" // 1 男  2女
    
    //单姓  0 代表单 1 代表双
    @objc public var xingNum : String = "1"
    // 名字单双 0 代表单 1 代表双
    @objc public var nameNum : String = "1"
    //定字
    @objc public var dingzi : String = ""
    
    // 0 代表首 1 代表尾
    @objc public var ding : String = "0"
    
    //是否出生 0 未出生  1 已经出生 空不管
     @objc public var isBirth : String = ""
    
    public func getUserName() -> String
    {
        return xing + name
    }
}

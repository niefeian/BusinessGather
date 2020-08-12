//
//  CalculationEngine.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/7/14.
//

import UIKit

public class CalculationEngine: NSObject {
    
    @objc public class func calculationEngine(_ type : String , model : CSBaseVO , infrom : String , callBack : @escaping ([String:String]) -> Void ){
       
           if  type == "fs_zaiming"
           {
               let para = ["sex":model.noUserSex,"timestamp":model.getBirthday_time(),"xiang":model.chaoxiang,"type":type,"infrom":infrom]
               callBack(para)
           }
           else if type == "chenggu"
           {
               let para = ["name":model.getXM(),"sex": model.noUserSex,"nongli":model.getBirthday_nongli(),"gongli":model.getBirthday_gongli(),"timestamp":model.getBirthday_time(),"type":type,"infrom":infrom]
               callBack(para)
           }
           else if  type == "bazicaiyun" ||  type == "bazijingpi"
           {
               let para = ["name":model.getXM(),"xingbie": model.noUserSex,"xing":"","nongli":model.getBirthday_nongli(),"gongli":model.getBirthday_gongli(),"timestamp":model.getBirthday_time(),"type":type,"infrom":infrom]
               callBack(para)
           }
           else if type == "bazihehun"
           {
                let para = ["name1":model.manXing + model.manName,"nongli1":model.manBirthday_nongli,"gongli1":model.manBirthday_gongli,"timestamp1":model.manBirthday_time,"name2":model.womanXing + model.womanName,"nongli2":model.womanBirthday_nongli,"gongli2":model.womanBirthday_gongli,"timestamp2":model.womanBirthday_time,"type":type,"infrom":infrom]
               callBack(para)
           }
           else if type == "xingmingpd"
           {
                let para = ["malexing":model.manXing,"malename":model.manName,"femalexing":model.womanXing,"femalename":model.womanName,"type":type,"infrom":infrom]
               callBack(para)
           }
           else if type == "bbquming"
           {
             let para = ["sex": model.noUserSex,"timestamp":model.getBirthday_time(),"xingshi":model.danshaun,"ding":model.shouwei,"dingzi":model.ding,"xing":model.getXing(),"type":type,"infrom":infrom]
               callBack(para)
           }
           else
           {
      
             let para = ["name":model.getXM(),"xingbie":model.noUserSex,"username":model.getXM(),"nongli":model.getBirthday_nongli(),"gongli":model.getBirthday_gongli(),"timestamp":model.getBirthday_time(),"type":type,"infrom":infrom]
                callBack(para)
           }
       }
       
       
     public class func getCalculationVo(_ model : CSBaseVO) -> CalculationVO{
            
        let vo = CalculationVO()
            let userVo = UserVO()
            userVo.name = model.getName()
            userVo.xing = model.getXing()
            userVo.sex = model.noUserSex
            vo.userVo = userVo
           
           if model.noUserSex == "1" && model.womanName.count + model.womanXing.count > 0
           {
               let womanUserVo = UserVO()
               womanUserVo.name = model.womanName
               womanUserVo.xing = model.womanXing
               womanUserVo.sex = "2"
               vo.womanUserVo = womanUserVo
           }
           
           if model.getBirthday_time().count > 0
           {
               let userTimeVo = TimeVO()
               userTimeVo.birthday_gongli = model.getBirthday_gongli()
               userTimeVo.birthday_nongli = model.getBirthday_nongli()
               userTimeVo.birthday_time = model.getBirthday_time()
               vo.userTime = userTimeVo
           }
           
           
           if model.noUserSex == "1" && model.womanBirthday_time.count > 0
           {
               let userTimeVo = TimeVO()
               userTimeVo.birthday_gongli = model.womanBirthday_gongli
               userTimeVo.birthday_nongli = model.womanBirthday_nongli
               userTimeVo.birthday_time = model.womanBirthday_time
               vo.womanUserTime = userTimeVo
           }
           return vo
       }
    
    
       
     public class func saveInfo(_ model : CSBaseVO  , type : String)
       {
           let vo = getCalculationVo(model)
           vo.save(getType(type))
       }
       
    public class func getCalculationVo(key : String) -> CalculationVO?
    {
       return  CalculationVO.get(getType(key))
    }
       
   public class func loadOldInfo(_ model : CSBaseVO , type : String)
       {
           
          if let vo = CalculationVO.get(getType(type))
          {
               if let userTime = vo.userTime
               {
                   model.manBirthday_gongli = userTime.birthday_gongli
                   model.manBirthday_nongli = userTime.birthday_nongli
                   model.manBirthday_time = userTime.birthday_time
               }
           
               if let userTime = vo.womanUserTime
               {
                   model.womanBirthday_gongli = userTime.birthday_gongli
                   model.womanBirthday_nongli = userTime.birthday_nongli
                   model.womanBirthday_time = userTime.birthday_time
               }
           
               if let userVo = vo.womanUserVo
               {
                   model.womanXing = userVo.xing
                   model.womanName = userVo.name
               }
               
               
               if let userVo = vo.userVo
               {
                  model.manXing = userVo.xing
                  model.manName = userVo.name
                   //如果 userVo sex 是 2 信息反转
                  if userVo.sex == "2"
                   {
                       model.noUserSex = "2"
                   }
               }
           }
       }
       
       class func getType(_ key : String) -> String
       {
           switch key {
           case "bazihehun":
              return "双人"
           case "xingmingpd":
              return "配对"
           case "bbquming":
               return "宝宝"
           case "xingmingxp":
             return "详批"
           case "fs_zaiming":
               return "风水大师"
           default:
               break
           }
           return "单身狗"
       }
}

//
//  CSBaseVO.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/7/14.
//

import UIKit

open class CSBaseVO : NSObject {
    
    @objc open var manName : String = ""
    @objc open var manXing : String = ""
    @objc open var manBirthday_time = ""
    @objc open var manBirthday_nongli = ""
    @objc open var manBirthday_gongli = ""
    @objc open var manSex = "1"
    @objc open var womanName : String = ""
    @objc open var womanXing : String = ""
    @objc open var womanBirthday_time = ""
    @objc open var womanBirthday_nongli = ""
    @objc open var womanBirthday_gongli = ""
    @objc open var womanSex = "2"
    
    @objc open var mobile = ""
    @objc open var chaoxiang = ""
    @objc open var manXingNum : String = ""
    @objc open var womanXingNum : String = ""
    
    @objc open var title = ""
    
    @objc open var type = ""//内购类型
    
    @objc open var userTimeVo : TimeVO!
        {
        didSet
        {
            if noUserSex == "1"
            {
                manBirthday_time = userTimeVo.birthday_time
                manBirthday_gongli = userTimeVo.birthday_gongli
                manBirthday_nongli = userTimeVo.birthday_nongli
            }
            else
            {
                womanBirthday_time = userTimeVo.birthday_time
                womanBirthday_gongli = userTimeVo.birthday_gongli
                womanBirthday_nongli = userTimeVo.birthday_nongli
            }
        }
    }
    
    //宝宝取名的定字跟单双首尾巴
    //    0 单  1 双
    @objc open var danshaun = "双"
    @objc open var ding : String = ""
    //    "0":"1" 0 首
    @objc open var shouwei : String = "首"
    
    // 男 1 女 2 
    @objc open var noUserSex = "1"{
      didSet{
          if oldValue != noUserSex {
              chengeSex()
          }
      }
    }

    public func setName(_ text : String)
    {
        if noUserSex == "1"
        {
           manName = text
        }
        else
        {
           womanName = text
        }
    }
    
    public func setXing(_ text : String)
    {
        if noUserSex == "1"
        {
           manXing = text
        }
        else
        {
           womanXing = text
        }
    }
    
    public func getName() -> String {
        return noUserSex == "1" ? manName : womanName
    }
    
    public func getXM() -> String {
        return noUserSex == "1" ? (manXing + manName) : (womanXing + womanName)
    }
    
    public func getXing() -> String {
        return noUserSex == "1" ? manXing:womanXing
    }
    
    public func getBirthday_time() -> String {
        return noUserSex == "1" ? manBirthday_time:womanBirthday_time
    }
    
    public func getBirthday_nongli() -> String {
        return noUserSex == "1" ? manBirthday_nongli : womanBirthday_nongli
    }
    
    public func getBirthday_gongli() -> String {
        return noUserSex == "1" ? manBirthday_gongli : womanBirthday_gongli
    }
    

    
    private func chengeSex(){
        let manX = manXing
        let manN = manName
        let manT = manBirthday_time
        let manNo = manBirthday_nongli
        let manG = manBirthday_gongli
        manXing = womanXing
        manName = womanName
        manBirthday_time = womanBirthday_time
        manBirthday_nongli = womanBirthday_nongli
        manBirthday_gongli = womanBirthday_gongli
        womanXing = manX
        womanName = manN
        womanBirthday_time = manT
        womanBirthday_nongli = manNo
        womanBirthday_gongli = manG
    }
}


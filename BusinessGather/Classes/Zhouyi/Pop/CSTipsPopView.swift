//
//  CSTipsPopView.swift
//  AutoModel
//
//  Created by 聂飞安 on 2020/7/21.
//

import UIKit
import SwiftProjects
import SnapKit
import NFAToolkit


public class CSTipsPopView: BasePopVC {

    public var model : CSBaseVO!
//        = CSBaseVO()//旧的模式
    public var csInfo : CalculationVO!
//        = CalculationVO()//新的模式
    
    override public func initializePage() {
        addAutoView([(.view, 4),(.label, 2),(.button, 2)])
        super.initializePage()
    }
    
    override public func initLayoutSubviews() {
        
        getSubview(autoViewClass: .view, index: 1)?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview()
        })
        
        getSubview(autoViewClass: .label, index: 1)?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(19.pd6sW)
        })
        
        getSubview(autoViewClass: .view, index: 2)?.snp.makeConstraints({ (make) in
            make.top.equalTo(getSubview(autoViewClass: .label, index: 1)!.snp_bottom).offset(14.pd6sW)
            make.centerX.equalToSuperview()
            make.left.equalTo(17.pd6sW)
            make.height.equalTo(1)
        })
        
        getSubview(autoViewClass: .label, index: 2)?.snp.makeConstraints({ (make) in
            make.top.equalTo(getSubview(autoViewClass: .view, index: 2)!.snp_bottom).offset(24.pd6sW)
            make.centerX.equalToSuperview()
            make.left.equalTo(25.pd6sW)
//            make.height.greaterThanOrEqualTo(150.pd6sW)
        })
        
        getSubview(autoViewClass: .view, index: 3)?.snp.makeConstraints({ (make) in
            make.top.equalTo(getSubview(autoViewClass: .label, index: 2)!.snp_bottom).offset(20.pd6sW)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(1)
        })
        
        getSubview(autoViewClass: .view, index: 4)?.snp.makeConstraints({ (make) in
            make.top.equalTo(getSubview(autoViewClass: .view, index: 2)!.snp_bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.bottom.equalTo(getSubview(autoViewClass: .view, index: 1)!)
        })
        
        getSubview(autoViewClass: .button, index: 1)?.snp.makeConstraints({ (make) in
            make.left.equalTo(10.pd6sW)
            make.top.equalTo(getSubview(autoViewClass: .view, index: 3)!.snp_bottom)
            make.bottom.equalTo(getSubview(autoViewClass: .view, index: 1)!)
            make.right.equalTo(getSubview(autoViewClass: .view, index: 4)!.snp_left)
            make.height.equalTo(40.pd6sW)
        })
        
        getSubview(autoViewClass: .button, index: 2)?.snp.makeConstraints({ (make) in
            make.right.equalTo(-10.pd6sW)
            make.top.equalTo(getSubview(autoViewClass: .view, index: 3)!.snp_bottom)
            make.bottom.equalTo(getSubview(autoViewClass: .view, index: 1)!)
            make.left.equalTo(getSubview(autoViewClass: .view, index: 4)!.snp_right)
        })
    }
    
    override public func initializeDraw() {
        
        for index in 2...3
        {
            getSubview(autoViewClass: .view, index: index)?.backgroundColor = .initString("#EEEEEE")
        }
        
        getSubview(autoViewClass: .view, index: 1)?.backgroundColor = .white
        getSubview(autoViewClass: .view, index: 1)?.setCornerRadius(5)
                
        if let label = getSubview(autoViewClass: .label, index: 1) as? UILabel
        {
            label.font = UIFont.boldSystemFont(ofSize: 17.pd6sW)
            label.text = "请人以下信息是否正确"
            label.textColor = UIColor.initString("#333333")
        }
        
        if let label = getSubview(autoViewClass: .label, index: 2) as? UILabel
        {
            label.numberOfLines = 0
        }
        
        for index in 1...2
        {
            if let button = getSubview(autoViewClass: .button, index: index) as? UIButton
            {
                button.addTarget(self, action: #selector(touchUp(_:)), for: .touchUpInside)
                button.setTitle(index == 1 ? "返回修改" : "确认无误", for: .normal)
                button.setTitleColor(index == 2 ? UIColor.initString("#AF2F2C") : UIColor.initString("#999999"), for: .normal)
                button.titleLabel?.setFont(17)
            }
        }
    }
    
    @objc func touchUp(_ btn : UIButton)
    {
        callBack?((btn.tag - 201) as AnyObject)
    }
    
    
    public override func viewDidLoad() {
        regisPopSize(CGSize(width: 315.pd6sW, height: 315.pd6sW))
        super.viewDidLoad()
        loadUI()
       
        // Do any additional setup after loading the view.
    }
    
    
    func loadUI(){
        if let l1 = getSubview(autoViewClass: .label, index: 2 ,autoInit: true) as? UILabel
        {
            
            
            l1.setFont(12)
            l1.textColor = UIColor.initString("999999")
            let lineSpacing = 15.pd6sW
            if model != nil
            {
                switch model.type {
                case "bazihehun":
                   let str = """
                   男方姓名：\(model.manName)
                   男方生日：\(model.manBirthday_gongli)
                   女方姓名：\(model.womanName)
                   女方生日：\(model.womanBirthday_gongli)
                   """
                   l1.setAttrString2(string: str , lineSpacing: lineSpacing, array: [(["男方姓名：","男方生日：","女方姓名：","女方生日："],UIColor.black,pd6sW(13))])
                case "bbquming":
                    
                  let str = """
                  宝宝姓氏：\(model.getXing())
                  宝宝性别：\(model.noUserSex == "1" ? "男" : "女")
                  出生日期：\(model.getBirthday_gongli())
                  名字形式：\(model.danshaun)字
                  定   字：\(model.ding == "" ? "无": ("\(model.shouwei)字 － " + model.ding))
                  """
                  l1.setFont(11)
                  l1.setAttrString2(string: str, lineSpacing: lineSpacing, array: [(["宝宝姓氏：","宝宝性别：","出生日期：","名字形式：","定   字："],UIColor.black,pd6sW(14))])
                case "xingmingpd":
                    let str = """
                    男方姓名：\(model.manXing + model.manName)
                    女方姓名：\(model.womanXing + model.womanName)
                    """
                    l1.setAttrString2(string: str, lineSpacing: lineSpacing, array: [(["男方姓名：","女方姓名："],UIColor.black,pd6sW(14))])

                case "fs_zaiming":
                    let t1 = """
                    性别:     \(model.noUserSex == "1" ? "男" : "女")
                    出生时间:  \(model.getBirthday_gongli())
                    大门朝向:  \(model.chaoxiang)
                    """
                    l1.setAttrString2(string: t1, lineSpacing: lineSpacing, array: [(["性别:","出生时间:","大门朝向:"],UIColor.black,pd6sW(14))])
                default:
                   
                   let str = """
                   姓名：\(model.getXM())
                   性别：\(model.noUserSex == "1" ? "男" : "女")
                   公历：\(model.getBirthday_gongli())
                   农历：\(model.getBirthday_nongli())
                   """
                   l1.setAttrString2(string: str, lineSpacing: lineSpacing, array: [(["姓名：","性别：","公历：","农历："],UIColor.black,pd6sW(14))])
                   break;
                }
            }
            else if csInfo != nil
            {
                l1.setFont(11)
                switch csInfo.csType {
                case "bazihehun":
                   let str = """
                   男方姓名：\(csInfo.userVo.getUserName())
                   男方生日：\(csInfo.userTime.birthday_show)
                   女方姓名：\(csInfo.womanUserVo.getUserName())
                   女方生日：\(csInfo.womanUserTime.birthday_show)
                   """
                   l1.setAttrString2(string: str , lineSpacing: lineSpacing, array: [(["男方姓名：","男方生日：","女方姓名：","女方生日："],UIColor.black,pd6sW(13))])
                case "bbquming":
                    
                  let str = """
                  宝宝姓氏：\(csInfo.userVo.xing)
                  宝宝性别：\(csInfo.userVo.sex == "1" ? "男" : "女")
                  出生日期：\(csInfo.userTime.birthday_show)
                  名字形式：\(csInfo.userVo.nameNum == "0" ? "单" : "双")字
                  定   字：\(csInfo.userVo.dingzi == "" ? "无" : ("\(csInfo.userVo.ding == "0" ? "首":"尾")字 － " + csInfo.userVo.dingzi))
                  """
                  l1.setAttrString2(string: str, lineSpacing: lineSpacing, array: [(["宝宝姓氏：","宝宝性别：","出生日期：","名字形式：","定   字："],UIColor.black,pd6sW(13))])
                case "xingmingpd":
                    let str = """
                    男方姓名：\(csInfo.userVo.getUserName())
                    女方姓名：\(csInfo.womanUserVo.getUserName())
                    """
                    l1.setAttrString2(string: str, lineSpacing: lineSpacing, array: [(["男方姓名：","女方姓名："],UIColor.black,pd6sW(14))])

                case "fs_zaiming":
                    let t1 = """
                    性别:     \(csInfo.userVo.sex == "1" ? "男" : "女")
                    出生时间:  \(csInfo.userTime.birthday_show)
                    大门朝向:  \(csInfo.chaoxiang)
                    """
                    l1.setAttrString2(string: t1, lineSpacing: lineSpacing, array: [(["性别:","出生时间:","大门朝向:"],UIColor.black,pd6sW(14))])
                default:
                   
                   let str = """
                   姓名：\(csInfo.userVo.getUserName())
                   性别：\(csInfo.userVo.sex == "1" ? "男" : "女")
                   公历：\(csInfo.userTime.birthday_gongli)
                   农历：\(csInfo.userTime.birthday_nongli)
                   """
                   l1.setAttrString2(string: str, lineSpacing: lineSpacing, array: [(["姓名：","性别：","公历：","农历："],UIColor.black,pd6sW(12))])
                   break;
                }
            }
            
        }
               
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

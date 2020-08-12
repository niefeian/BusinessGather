//
//  ViewController.swift
//  BusinessGather
//
//  Created by 335074307@qq.com on 07/03/2020.
//  Copyright (c) 2020 335074307@qq.com. All rights reserved.
//

import UIKit
import BusinessGather
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vo = CalculationVO()
        vo.userVo = UserVO()
        print(vo.toJosn())
        vo.save("1")
        if let vo2 = CalculationVO.get("1")
        {
           print(vo2.toJosn())
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


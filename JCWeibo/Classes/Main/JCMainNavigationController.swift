//
//  JCMainNavigationController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCMainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = children.count != 0
        
        super.pushViewController(viewController, animated: animated)
    }
}


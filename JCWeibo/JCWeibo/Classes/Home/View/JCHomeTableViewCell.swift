//
//  JCHomeTableViewCell.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

let kHomeCellId = "__homeCellId__"

class JCHomeTableViewCell: UITableViewCell {
    
    var statusViewModels: JCStatusViewModel? {
        didSet {
            self.textLabel?.text = statusViewModels?.statusModel.text
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 

}

//
//  NSDate+Extension.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

extension NSDate {
    
    /**
     根据字符串创建时间
     
     - parameter str: 时间字符串
     */
    class func createDateWithString(str: String) -> NSDate? {
        // 1.创建时间格式化
        let formatter = DateFormatter()
        // 2.设置时间格式
        formatter.dateFormat = "EE MM dd HH:mm:ss Z yyyy"
        // 3.设置区域
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale!
        
        return formatter.date(from: str) as NSDate?
    }
    
    /**
     返回当前时间对象对应的字符串
     */
    func descString() -> String {
        /**
         刚刚(一分钟内)
         X分钟前(一小时内)
         X小时前(当天)
         
         昨天 HH:mm(昨天)
         
         MM-dd HH:mm(一年内)
         yyyy-MM-dd HH:mm(更早期)
         */
        // 1.创建时间格式化
        let formatter = DateFormatter()
        // 2.设置区域
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale!
        
        // 3.创建日历类
        let calendar = NSCalendar.current
        
        // 4.处理时间
        if calendar.isDateInToday(self as Date) {
            // 6.1判断是否是当天
            // 5.获取发布微博的时间和当前时间的时间差, 单位秒
            let interval = Int(NSDate().timeIntervalSince(self as Date))
            
            if interval < 60 {
                return "刚刚"
            }else if interval < 60 * 60 {
                return "\(interval / 60)分钟以前"
            }else {
                return "\(interval / (60 * 60))小时前"
            }
            
        }else if calendar.isDateInYesterday(self as Date) {
            // 6.2判断是否是昨天
            formatter.dateFormat = "昨天 HH:mm"
        }else {
            formatter.dateFormat = "MM-dd HH:mm"
        }
        
        // 按照指定的格式将时间格式化为字符串
        return formatter.string(from: self as Date)
    }
}

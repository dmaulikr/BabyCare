//
//  BBreastMilkTableViewCell.swift
//  BabyCare
//
//  Created by Neo on 2017/3/8.
//  Copyright © 2017年 JL. All rights reserved.
//

import UIKit

class BBreastMilkTableViewCell: JBaseTableViewCell {
        
    var dayLabel: UILabel?
    var hourLabel: UILabel?
    
    var leftTimeLabel: UILabel?
    var rightTimeLabel: UILabel?
    
    var breastMilk:BBreastMilkEntity? {
        didSet {
            self.dayLabel?.attributedText = self.translateToDayString(date: (breastMilk?.createTime)!)
            self.hourLabel?.text = self.translateTimeToShortFormatter(time: (breastMilk?.createTime)!)
            self.leftTimeLabel?.text =  self.translateSecondToMinute(second: (breastMilk?.left)!)
            self.rightTimeLabel?.text = self.translateSecondToMinute(second: (breastMilk?.right)!)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     

        dayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        dayLabel?.textAlignment = .center
        dayLabel?.baselineAdjustment = .alignBaselines
        self.contentView.addSubview(dayLabel!)
        
        hourLabel = UILabel(frame: CGRect(x: 10, y: (dayLabel?.bottom)! + 10, width: 60, height: 12))
        hourLabel?.textAlignment = .right
        hourLabel?.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(hourLabel!)
        
        let width = (Util.screenWidth() - (dayLabel?.right)! - 20 - 20)/2
        
        let leftDesLabel = UILabel(frame: CGRect(x: (dayLabel?.right)!+20, y: 5, width: width, height: 30))
        leftDesLabel.textAlignment = .center
        leftDesLabel.font = UIFont.systemFont(ofSize: 15)
        leftDesLabel.text = "左侧"
        self.contentView.addSubview(leftDesLabel)
        
        leftTimeLabel = UILabel(frame: CGRect(x: leftDesLabel.left, y: leftDesLabel.bottom + 6, width: width, height: 24))
        leftTimeLabel?.font = UIFont.systemFont(ofSize: 14)
        leftTimeLabel?.textAlignment = .center
        self.contentView.addSubview(leftTimeLabel!)
        
        let rightDesLabel = UILabel(frame: CGRect(x: leftDesLabel.right, y: 5, width: width, height: 30))
        rightDesLabel.textAlignment = .center
        rightDesLabel.font = UIFont.systemFont(ofSize: 15)
        rightDesLabel.text = "右侧"
        self.contentView.addSubview(rightDesLabel)
        
        rightTimeLabel = UILabel(frame: CGRect(x: leftDesLabel.right, y: leftDesLabel.bottom + 6, width: width, height: 24))
        rightTimeLabel?.font = UIFont.systemFont(ofSize: 14)
        rightTimeLabel?.textAlignment = .center
        self.contentView.addSubview(rightTimeLabel!)
    }
    
    func translateSecondToMinute(second: String) -> String {
        let second = Double(second)
        
        let minute = Int(second!/60)
        let mod = Int(second! - Double(minute * 60))
        return String(minute) + "分钟" + String(mod) + "秒"
    }
    
    func translateTimeToShortFormatter(time: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date(timeIntervalSince1970: Double(time)!))
    }
    
    func translateToDayString(date: String) -> NSMutableAttributedString {
        var attributeString: NSMutableAttributedString
        let createDate = Date(timeIntervalSince1970: Double(date)!)
        let calendar = Calendar.current
        if calendar.isDateInToday(createDate) {
            attributeString = NSMutableAttributedString(string: "今天")
            attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, 2))
            return attributeString
        } else if calendar.isDateInYesterday(createDate){
            attributeString = NSMutableAttributedString(string: "昨天")
            attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, 2))
            return attributeString  
        } else {
            let com = calendar.dateComponents([.month,.day], from: createDate)
            let day = com.day?.description
            let month = com.month?.description
            
            attributeString = NSMutableAttributedString(string: day! + month! + "月")
            attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSMakeRange(0, (day?.characters.count)!))
            attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 9), range: NSMakeRange((day?.characters.count)!, (month?.characters.count)! + 1))
            return attributeString
        }
    }

    func hideDate(hidden: Bool) {
        dayLabel?.isHidden = hidden
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func cellHeightWith(data: AnyObject?) -> CGFloat {
        return 65
    }
}

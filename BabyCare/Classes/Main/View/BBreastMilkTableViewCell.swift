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
    
    var leftTimeLabel: UILabel?
    var rightTimeLabel: UILabel?
    
    var breastMilk:JBreastMilkEntity?{
        didSet{
            self.dayLabel?.attributedText = self.translateToDayString(date: (breastMilk?.createTime)!)
            self.leftTimeLabel?.text = "14分钟"
            self.rightTimeLabel?.text = "12分钟"
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     

        dayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        dayLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        dayLabel?.textAlignment = .center
        dayLabel?.baselineAdjustment = .alignBaselines
        self.contentView.addSubview(dayLabel!)
        
        let width = (Util.screenWidth() - (dayLabel?.right)! - 20 - 20)/2
        
        let leftDesLabel = UILabel(frame: CGRect(x: (dayLabel?.right)!+20, y: 5, width: width, height: 30))
        leftDesLabel.numberOfLines = 2
        leftDesLabel.textAlignment = .center
        leftDesLabel.font = UIFont.systemFont(ofSize: 16)
        leftDesLabel.text = "左\nleft"
        self.contentView.addSubview(leftDesLabel)
        
        leftTimeLabel = UILabel(frame: CGRect(x: leftDesLabel.left, y: leftDesLabel.bottom + 6, width: width, height: 24))
        leftTimeLabel?.font = UIFont.systemFont(ofSize: 14)
        leftTimeLabel?.textAlignment = .center
        self.contentView.addSubview(leftTimeLabel!)
        
        let rightDesLabel = UILabel(frame: CGRect(x: leftDesLabel.right, y: 5, width: width, height: 30))
        rightDesLabel.numberOfLines = 2
        rightDesLabel.textAlignment = .center
        rightDesLabel.text = "右\nright"
        self.contentView.addSubview(rightDesLabel)
        
        rightTimeLabel = UILabel(frame: CGRect(x: leftDesLabel.right, y: leftDesLabel.bottom + 6, width: width, height: 24))
        rightTimeLabel?.font = UIFont.systemFont(ofSize: 14)
        rightTimeLabel?.textAlignment = .center
        self.contentView.addSubview(rightTimeLabel!)
    }
    
    func translateToDayString(date: String) -> NSMutableAttributedString {
        var attributeString: NSMutableAttributedString
        let createDate = Date(timeIntervalSince1970: Double(date)!)
        let calendar = Calendar.current
        if calendar.isDateInToday(createDate) {
            attributeString = NSMutableAttributedString(string: "今天")
            attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, 2))
            return attributeString
        }else if calendar.isDateInYesterday(createDate){
            attributeString = NSMutableAttributedString(string: "昨天")
            attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, 2))
            return attributeString  
        }else{
           let com = calendar.dateComponents([.month,.day], from: createDate)
            let day = com.day?.description
            let month = com.month?.description
            
            
            attributeString = NSMutableAttributedString(string: day! + month! + "月")
            attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSMakeRange(0, (day?.characters.count)!))
            attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 10), range: NSMakeRange((day?.characters.count)!, (month?.characters.count)! + 1))
            return attributeString
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func cellHeightWith(data: AnyObject?) -> CGFloat {
        return 65
    }
}

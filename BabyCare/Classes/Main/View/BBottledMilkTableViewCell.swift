//
//  BBottledMilkTableViewCell.swift
//  BabyCare
//
//  Created by Neo on 2017/3/21.
//  Copyright © 2017年 JL. All rights reserved.
//

import UIKit

class BBottledMilkTableViewCell: JBaseTableViewCell {
    
    
    var dayLabel: UILabel?
    var hourLabel: UILabel?
    
    var typeLabel: UILabel?
    var amountLabel: UILabel?
    
    var bottledMilk: BBottledMilkEntity? {
        didSet{
            dayLabel?.attributedText = self.translateToDayString(date: (bottledMilk?.createTime)!)
            hourLabel?.text = self.translateTimeToShortFormatter(time: (bottledMilk?.createTime)!)
            typeLabel?.text = Int((bottledMilk?.type)!) == 0 ? "母乳" : "配方奶"
            amountLabel?.text = (bottledMilk?.amount)! + "ml"
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
                
        typeLabel = UILabel(frame: CGRect(x: (dayLabel?.right)! + 20, y: 15, width: 100, height: 30))
        typeLabel?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(typeLabel!)
        
        amountLabel =  UILabel(frame: CGRect(x: (typeLabel?.right)!, y: 15, width: 100, height: 30))
        amountLabel?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(amountLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
            attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 9), range: NSMakeRange((day?.characters.count)!, (month?.characters.count)! + 1))
            return attributeString
        }
    }

    func hideDate(hidden: Bool) {
        dayLabel?.isHidden = hidden
    }
    
    override class func cellHeightWith(data: AnyObject?) -> CGFloat {
        return 60
    }
}

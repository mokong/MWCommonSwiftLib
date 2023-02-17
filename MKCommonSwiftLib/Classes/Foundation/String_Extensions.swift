//
//  String_Extensions.swift
//  meijuplay
//
//  Created by MorganWang on 24/12/2021.
//

import Foundation
import UIKit

public extension String {
    // 根据宽度和字体，计算高度
    func getStrHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [NSAttributedString.Key.font : font],
                                                       context: nil)
        let resultH = ceil(rect.height) + 0.1
        return resultH
    }
    
    // 根据高度和字体，计算宽度
    func getStrWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [NSAttributedString.Key.font : font],
                                                       context: nil)
        let resultW = ceil(rect.width) + 0.1
        return resultW
    }
    
    func queryParams() -> [String: String] {
        var params: [String: String] = [:]
        let urlComp = URLComponents(string: self)
        urlComp?.queryItems?.enumerated().forEach({ item in
            if let value = item.element.value {
                params[item.element.name] = value
            }
        })
        return params
    }
}

public
extension String {
    //手机号中间四位加星处理
    static func dealPhoneNum(_ phone : String) -> String {
        if phone.count == 11 {
            if let range = Range(NSRange(location: 3, length: 4), in:phone) {
                let result = phone.replacingCharacters(in: range, with: "****")
                return result
            } else {
                return phone
            }
        } else {
            return phone
        }
    }
}

public enum ValidateType {
    case mobile
    case IDNumber
    case Number
    case ChatNumber(length: Int)
    case email
    case carNo
    case chinese
    case password
    case custom(format: String)
}

public extension String {
    /** 正则判断
     * @param type 正则验证类型
     */
    func validate(_ type:ValidateType) -> Bool {
        var mobileReg = ""
        switch type {
        case .mobile:
            mobileReg = "^1[3456789]\\d{9}$"
        case .IDNumber:
            //"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)"
            mobileReg = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        case .Number:
            mobileReg = "^[0-9]*$"
        case .ChatNumber(let length):
            mobileReg = "^\\d{\(length)}$"
        case .email:
            mobileReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        case .carNo:
            /*1、传统车牌
            第1位为省份简称（汉字），第二位为发牌机关代号（A-Z的字母）第3到第7位为序号（由字母或数字组成，但不存在字母I和O，防止和数字1、0混淆，另外最后一位可能是“挂学警港澳使领”中的一个汉字）。
            2、新能源车牌
            第1位和第2位与传统车牌一致，第3到第8位为序号（比传统车牌多一位）。新能源车牌的序号规则如下：
            小型车：第1位只能是字母D或F，第2为可以是数字或字母，第3到6位必须是数字。
            大型车：第1位到第5位必须是数字，第6位只能是字母D或F
             */
            mobileReg = "^(([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z](([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z][A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳使领]))$"
        case .chinese:
            mobileReg = "^([\\u4E00-\\u9FA5]{2,30}$)"
        case .password:
            mobileReg = "(^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[0-9a-zA-Z])(.{8,10})$)"   //"(^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z](.{8,10})$)"
        case .custom(let format):
            mobileReg = format
        }
        let predicate = NSPredicate(format:"SELF MATCHES %@", mobileReg)
        if predicate.evaluate(with: self) {
            return true
        } else {
            return false
        }
        /*
         验证密码是否符合规则 8-20位字符，必须包含字母和数字，字母区分大小写
         "(^(?=.*[0-9])(?=.*[a-zA-Z])(.{8,20})$)"
         是否是汉字
         "^([\\u4e00-\\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5})$"
         中文判断
         "^([\\u4E00-\\u9FA5]{2,30}$)"
         */
    }
    //
    func toDictionary() -> [String : Any] {
        var result = [String : Any]()
        guard !self.isEmpty else { return result }
        guard let dataSelf = self.data(using: .utf8) else {
            return result
        }
        if let dic = try? JSONSerialization.jsonObject(with: dataSelf,
                                                       options: .mutableContainers) as? [String : Any] {
            result = dic
        }
        return result
    }
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
}

public extension String {
    //日期 -> 字符串 默认：yyyy-MM-dd HH:mm:ss
    static func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let dateString = formatter.string(from: date)
        return dateString
    }
    //字符串 -> 日期 默认：yyyy-MM-dd HH:mm:ss
    static func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date ?? Date()
    }
    static func compareTimeOfSize(endTime:String, nowTIme:String) -> TimeInterval {
        if endTime.isEmpty == true || nowTIme.isEmpty == true {
            return 0
        }
        return String.string2Date(endTime).timeIntervalSince(String.string2Date(nowTIme))
    }
    //日期字符串转格式 -> 日期字符串 默认：MM-dd HH:mm:ss
    static func dateStringFormatTo(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        
        if string.isEmpty == true {
            return ""
        }
        let date = String.string2Date(string)
        let stamp = date.timeIntervalSince1970
        let date1 = Date(timeIntervalSince1970: stamp)
        let dateString = String.date2String(date1, dateFormat: dateFormat)
        return dateString
    }
}


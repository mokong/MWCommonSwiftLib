//
//  Data_Extension.swift
//  ToDoForOthers
//
//  Created by MorganWang on 15/1/2022.
//

import Foundation
import CommonCrypto

extension Data {
    public init(hex: String) {
        self.init(Array<UInt8>(hex: hex))
    }
    public var bytes: Array<UInt8> {
        return Array(self)
    }
    public func toHexString() -> String {
        return bytes.toHexString()
    }
    
    /// AES 解密  字符串本身是加密后的字符
    ///
    /// - Parameters:
    ///   - key: key
    ///   - iv: 密钥
    /// - Returns: 解密后的字符
    func aesDecrypt(key:String,iv:String?,algorithm:CCAlgorithm = CCAlgorithm(kCCAlgorithmAES)) -> String? {
        guard let decryptedData = aescrypt(key: key, iv: iv, operation: CCOperation(kCCDecrypt),algorithm: algorithm) else { return nil }
        return String.init(data: decryptedData, encoding: .utf8)
    }
    
    ///  AES 加密
    ///
    /// - Parameters:
    ///   - key: 加密密钥
    ///   - iv:  加密算法、默认的 AES/DES
    ///   - operation: CCOperation(kCCEncrypt) CCOperation(kCCDecrypt)
    ///   - algorithm: CCAlgorithm
    /// - Returns: 计算的结果
    func aescrypt(key:String,iv:String?,operation: CCOperation,algorithm:CCAlgorithm = CCAlgorithm(kCCAlgorithmAES)) -> Data? {
        
        guard key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES256,let keyData = key.data(using: .utf8) else {
            debugPrint("Error: Failed to set a key.")
            return nil
        }
        
        var options = CCOptions(kCCOptionPKCS7Padding)
        if iv != nil{
            options = CCOptions(kCCOptionPKCS7Padding)//CBC 加密！
        }else{
            options = CCOptions(kCCOptionPKCS7Padding|kCCOptionECBMode)//ECB加密！
        }
        
        let ivData = iv?.data(using: .utf8)
        
        //key
        let keyBytes = keyData.bytes
        let keyLength = [UInt8](repeating: 0, count: key.count).count
        
        //data(input) 要加密的数据（指针）
        let dateBytes = self.bytes
        let dataLength = self.count
        
        //data(output) 加密后的数据（指针）
        var cryptData = Data(count: dataLength + Int(kCCBlockSizeAES128))
        let cryptLength = cryptData.count
        
        //iv
        let ivBytes = ivData?.bytes
        var bytesDecrypted: size_t = 0
        
        let status = cryptData.withUnsafeMutableBytes { (cryptBytes) -> Int32 in
            let cryptBytesBuffterPointer = cryptBytes.bindMemory(to: UInt8.self)
            guard let cryptBytesAddress = cryptBytesBuffterPointer.baseAddress else {
                return Int32(kCCParamError)
            }
            return CCCrypt(operation, algorithm, options, keyBytes, keyLength, ivBytes, dateBytes, dataLength, cryptBytesAddress, cryptLength, &bytesDecrypted)
        }
        
        
        guard Int32(status) == Int32(kCCSuccess) else {
            debugPrint("Error: Failed to crypt data. Status \(status)")
            return nil
        }
        cryptData.removeSubrange(bytesDecrypted..<cryptData.count)
        return cryptData
    }
}

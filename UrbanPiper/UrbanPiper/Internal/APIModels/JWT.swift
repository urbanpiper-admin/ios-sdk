//
//  JWT.swift
//  UrbanPiper
//
//  Created by Vid on 09/11/18.
//

import UIKit

public class JWT: NSObject, NSCoding {
    
    var exp: Int!
    var iat: Int!
    var jit: String!
    var token: String!
    
    var shouldRefreshToken: Bool {
        guard exp != nil, iat != nil else { return false }
        let utcTime: Int = Int(Date().timeIntervalSince1970)
        return Int(0.8 * Double(exp - iat)) < (utcTime - iat)
    }
    
    var tokenExpired: Bool {
        guard exp != nil, iat != nil else { return false }
        let utcTime: Int = Int(Date().timeIntervalSince1970)
        return exp < utcTime
    }

    static func decode(jwtToken jwt: String) -> [String: Any] {
        let segments: [String?] = jwt.components(separatedBy: ".")
        guard let segment = segments[1] else { return [:] }
        return decodeJWTPart(segment) ?? [:]
    }
    
    static func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    static func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
            let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
                return nil
        }
        
        return payload
    }
    
    public init(jwtToken: String) {
        let dictionary = JWT.decode(jwtToken: jwtToken)
        
        exp = dictionary["exp"] as? Int
        iat = dictionary["iat"] as? Int
        jit = dictionary["jit"] as? String
        token = jwtToken        
    }
    
//    public func toDictionary() -> [String:Any] {
//        var dictionary: [String: Any] = [String:Any]()
//        if exp != nil{
//            dictionary["exp"] = exp
//        }
//        if iat != nil{
//            dictionary["iat"] = iat
//        }
//        if jit != nil{
//            dictionary["jit"] = jit
//        }
//        if token != nil{
//            dictionary["token"] = token
//        }
//        return dictionary
//    }

    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        exp = aDecoder.decodeObject(forKey: "exp") as? Int
        iat = aDecoder.decodeObject(forKey: "iat") as? Int
        jit = aDecoder.decodeObject(forKey: "jit") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if exp != nil{
            aCoder.encode(exp, forKey: "exp")
        }
        if iat != nil{
            aCoder.encode(iat, forKey: "iat")
        }
        if jit != nil{
            aCoder.encode(jit, forKey: "jit")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
    }
    
}

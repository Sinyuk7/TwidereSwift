//
//  XAOuth.swift
//  Authorize
//
//  Created by 沈烨坷 on 2018/9/28.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import Foundation

public class XAuth{
    public init() {
        
    }
    public enum Parameters: String{
        case ConsumerKey = "oauth_consumer_key"
        case Nonce = "nonce"
        case Username = "x_auth_username"
        case Password = "x_auth_password"
        case Mode = "x_auth_mode"
        case Timestamp = "timestamp"
        case SignatureMethod = "signature_method"
        case Version = "version"
    }
    
    public func getAccessToken(baseUrl url:String,parameters args:[XAuth.Parameters:String]) -> String{
        var params:[String:String] = [:]
        for (k,v) in args{
            params[k.rawValue] = v
        }
        var callback = url
        var first = true
        for (k,v) in params{
            if first{
                callback.append("?")
                first = false
            }else{
                callback.append("&")
            }
            callback.append(k)
            callback.append("=")
            callback.append(v)
        }
        return callback
    }
}


/// Random String Generator
///
/// - Parameter aLength: length
/// - Returns: random string
public func randomString(length aLength:Int) -> String {
    let str = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    var buffer = ""
    for _ in 0..<aLength{
        let index = Int.random(in: 0..<str.count)
        buffer.append(str[index])
    }
    return buffer
}



/// Simple clock like class, to allow time mocking.
public class Clock{
    public func mills() -> String{
        return String.init(Date().timeIntervalSince1970 /* * 1000 */)
    }
    
    public init() {
        
    }
}



private let ALLOWED_BYTES: [UInt8] = [
    //  0           1           2           3           4           5
    0b00110000, 0b00110001, 0b00110010, 0b00110011, 0b00110100, 0b00110101,
    //  6           7           8           9           A           B
    0b00110110, 0b00110111, 0b00111000, 0b00111001, 0b01000001, 0b01000010,
    //  C           D           E           D           G           H
    0b01000011, 0b01000100, 0b01000101, 0b01000110, 0b01000111, 0b01001000,
    //  I           J           K           L           M           N
    0b01001001, 0b01001010, 0b01001011, 0b01001100, 0b01001101, 0b01001110,
    //  O           P           Q           R           S           T
    0b01001111, 0b01010000, 0b01010001, 0b01010010, 0b01010011, 0b01010100,
    //  U           V           W           X           Y           Z
    0b01010101, 0b01010110, 0b01010111, 0b01011000, 0b01011001, 0b01011010,
    //  a           b           c           d           e           f
    0b01100001, 0b01100010, 0b01100011, 0b01100100, 0b01100101, 0b01100110,
    //  g           h           i           j           k           l
    0b01100111, 0b01101000, 0b01101001, 0b01101010, 0b01101011, 0b01101100,
    //  m           n           o           p           q           r
    0b01101101, 0b01101110, 0b01101111, 0b01110000, 0b01110001, 0b01110010,
    //  s           t           u           v           w           x
    0b01110011, 0b01110100, 0b01110101, 0b01110110, 0b01110111, 0b01111000,
    //  y           z
    0b01111001, 0b01111010
    
]

/// A random value of a specified length that is representable as an ASCII alpha-numeric string.
public struct Nonce: CustomStringConvertible {
    private let bytes: [UInt8]
    
    /// Creates a new random `Nonce` of the specified length in bytes.
    ///
    /// - parameter length: The number of random bytes.
    public init(length: Int = 32) {
        var result: [UInt8] = Array(repeating: 0, count: length)
        for i in 0..<length {
            let offset = arc4random_uniform(UInt32(ALLOWED_BYTES.count))
            result[i] = ALLOWED_BYTES[Int(offset)]
        }
        bytes = result
    }
    
    /// A human-readable representation of the underlying bytes as ASCII.
    public var description: String {
        return String(bytes: bytes, encoding: .ascii)!
    }
    
    /// The number of random bytes.
    public var length: Int {
        return bytes.count
    }
    
    /// The raw value of random bytes.
    public var data: Data {
        return Data(bytes: bytes)
    }
    
    /// The random bytes represented in hexadecimal notation.
    public var hexString: String {
        return bytes.hexString
    }
}

extension Sequence where Element == UInt8 {
    public var hexString: String {
        var hexadecimalString = ""
        var iterator = makeIterator()
        while let value = iterator.next() {
            hexadecimalString += String(format: "%02x", value)
        }
        return hexadecimalString
    }
}

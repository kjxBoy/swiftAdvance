//
//  自定义运算符.swift
//  swift进阶
//
//  Created by 康佳兴 on 2018/3/2.
//  Copyright © 2018年 Kang. All rights reserved.
//

import Foundation

/* Use
 
     let bodyTemperature: Double? = 37.0
     let bloodGlucose: Double? = nil
     print("Body temperature: \(bodyTemperature ??? "n/a")")
     // Body temperature: 37.0
     print("Blood glucose level: \(bloodGlucose ??? "n/a")")
     // Blood glucose level: n/a

 */

infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String
{
    switch optional {
    case let value?: return String(describing: value)
    case nil: return defaultValue()
    }
}

/**
 var s: String! = "Hello"
 print(s?.isEmpty ?? true) // Optional(false)
 print(s.isEmpty)
 if let s = s { print(s) }
 s = nil
 print(s ?? "Goodbye") // Goodbye
 */

infix operator !?

func !?<T: ExpressibleByIntegerLiteral>(wrapped: T?, failureText: @autoclosure () -> String) -> T
{
    assert(wrapped != nil, failureText())
    return wrapped ?? 0
}

func !?<T: ExpressibleByArrayLiteral>(wrapped: T?, failureText: @autoclosure () -> String) -> T
{
    assert(wrapped != nil, failureText())
    return wrapped ?? []
}

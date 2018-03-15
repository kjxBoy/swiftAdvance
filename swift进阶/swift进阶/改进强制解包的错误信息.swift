//
//  改进强制解包的错误信息.swift
//  swift进阶
//
//  Created by 康佳兴 on 2018/3/5.
//  Copyright © 2018年 Kang. All rights reserved.
//

import Foundation

infix operator !!
/*
     let s = "foo"
     let i = Int(s) !! "Expecting integer, got \"\(s)\""
     print(i)
 */

// autoclosure 参考 ：http://swifter.tips/autoclosure/
func !! <T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    if let x = wrapped { return x }
    fatalError(failureText())
}

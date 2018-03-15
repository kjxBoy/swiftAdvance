//
//  add.swift
//  swift进阶
//
//  Created by 康佳兴 on 2018/2/24.
//  Copyright © 2018年 Kang. All rights reserved.
//

import Foundation



extension Array {
    func accumulate<Result>(_ initialResult: Result,
                            _ nextPartialResult: (Result, Element) -> Result) -> [Result]
    {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
    
    // 理由reduce(into:_:)自定义filter的实现，时间复杂度是O(n)
    func filter3(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce(into: []) { result, element in
            if isIncluded(element) {
                result.append(element)
            }
        }
    }
}

extension Sequence where Element: Hashable {
    var frequencies: [Element:Int] {
        let frequencyPairs = self.map { ($0, 1) }
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }
}


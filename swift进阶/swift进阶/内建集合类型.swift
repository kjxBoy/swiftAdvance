//
//  内建集合类型.swift
//  swift进阶
//
//  Created by 康佳兴 on 2018/2/24.
//  Copyright © 2018年 Kang. All rights reserved.
//

import UIKit

enum Setting {
    case text(String)
    case int(Int)
    case bool(Bool)
}

class Dog: NSObject {
    var age = 0
}

struct Person {
    var age = 0
}



// MARK: - 利用set将数组去重
extension Sequence where Element: Hashable {
    //let unique = [1,2,3,12,1,3,4,5,6,4,6].unique()
    //print(unique) // [1, 2, 3, 12, 4, 5, 6]
    func unique() -> [Element] {
        var seen: Set<Element> = []
        
        return filter { element in
            if seen.contains(element) {
                return false
            } else {
                seen.insert(element)
                return true
            }
        }
    }
}



// MARK: - 字典
extension ViewController {
    func testDictionaryOne() {
        let defaultSettings: [String:Setting] = [
            "Airplane Mode": .bool(false),
            "Name": .text("My iPhone"),
            ]
        print(defaultSettings)
        
        var settings = defaultSettings
        let overriddenSettings: [String:Setting] = ["Name": .text("Jane's iPhone")]
        settings.merge(overriddenSettings, uniquingKeysWith: { $1 })
        print(settings)
    }
    
    func testDictionaryTwo() {
        let frequencies = "hello".frequencies // ["e": 1, "o": 1, "l": 2, "h": 1]
        print(frequencies.filter { $0.value > 1 }) // ["l": 2]
        
        let pairsWithDuplicateKeys = [("a", 1), ("b", 2), ("a", 3), ("b", 4)]
        
        let firstValues = Dictionary(pairsWithDuplicateKeys,uniquingKeysWith: { (first, _) in first })
        print(firstValues)
        // ["b": 2, "a": 1]
        
        let lastValues = Dictionary(pairsWithDuplicateKeys,uniquingKeysWith: { (_, last) in last })
        print(lastValues)
        // ["b": 4, "a": 3]
        
        let values = Dictionary(pairsWithDuplicateKeys) {
            $0 + $1
        }
        print(values)
        //["b": 6, "a": 4]
    }
    
    func testDictionaryThree() {
        
        let defaultSettings: [String:Setting] = [
            "Airplane Mode": .bool(false),
            "Name": .text("My iPhone"),
            ]
        
        print(defaultSettings)
        
        // 返回一个新的字典，包含原来字典的Key值，和通过闭包变换后的value
        let settingsAsStrings = defaultSettings.mapValues { setting -> String in
            switch setting {
            case .text(let text): return text
            case .int(let number): return String(number)
            case .bool(let value): return String(value)
            }
        }
        
        print(settingsAsStrings) // ["Name": "My iPhone", "Airplane Mode": "false"]
    }
}



// MARK: - reduce
extension ViewController {
    func testReduce() {
        
        let money = [5,6,7,8,9]
        let result = money.reduce(0, +)
        print(result)
        
        /// counts 与 into 后面的类型相同，letter是对应的元素类型
        let letters = "abracadabra"
        let letterCount = letters.reduce(into: [:]) { counts, letter in
            counts[letter, default: 0] += 1
        }
        print(letterCount)
        // letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]
        
        // reduce(into:_:) 中的第一个参数，是inout类型，可以被外界修改 ，因此result就是最后的返回结果
        let letterShow = letters.reduce(into: "") { (result, character) in
            result.append("+\(character)")
            
        }
        print(letterShow)
        
        
    }
}

// MARK: - 闭包
extension ViewController {
    func test() {
        
        let testArray = [1,2,3,4]
        
        // 可以把定义函数的部分调整为闭包
        let oneShowResult = testArray.accumulate(0, {(result, sInt) -> Int in return result + sInt})
        print(oneShowResult)
        
        // 单表达式可以隐藏return
        let twoShowResult = testArray.accumulate(0, {(result, sInt) in result + sInt})
        print(twoShowResult)
        
        // 参数名称缩写
        let threeShowResult = testArray.accumulate(0, {$0 + $1})
        print(threeShowResult)
        
        // 因为在Int的拓展中，定义了类似“{$0 + $1}” 的函数 “+”，因此可以直接替代
        // 运算符也是函数
        let finalShowResult = testArray.accumulate(0, +)
        print(finalShowResult)
        
        // 这种是使用尾随闭包的方式,将小括号“（）”提前，将闭包放到外面来实现
        let showResult = testArray.accumulate(0) { (result, sInt) -> Int in
            return result + sInt
        }
        print(showResult)
    }
}

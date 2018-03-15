//
//  自定义的集合索引.swift
//  swift进阶
//
//  Created by 康佳兴 on 2018/3/1.
//  Copyright © 2018年 Kang. All rights reserved.
//

import Foundation

//print(Array(Words("hello world test").prefix(2))) // ["hello", "world"]

/* *
   * 作用： 将传入的字符串 “one two three” 按照空格分割成集合["one","two","three"]的类型 ，并且按需求进行切割，不会像split函数一样，将字符串全部分割，在字符串很长的情况下提高了操作效率
 
     let words = Words(" hello world test ")
     let onePastStart = words.index(after: words.startIndex)
     let firstDropped2 = words.suffix(from: onePastStart)
     let firstDropped3 = words[onePastStart...]
     print(Array(firstDropped2))
     print(Array(firstDropped3))
 
 
   * 不使用int作为索引类型, 使用自定义的WordsIndex作为索引类型
 */
struct Words: Collection {
    let string: Substring
    let startIndex: WordsIndex
    init(_ s: String) {
        self.init(s[...])
    }
    
    private init(_ s: Substring) {
        self.string = s
        self.startIndex = WordsIndex(string.nextWordRange)
    }
    var endIndex: WordsIndex {
        let e = string.endIndex
        return WordsIndex(e..<e)
    }
}

extension Substring {
    var nextWordRange: Range<Index> {
        // 一个子字符串可能由若干个空格作为开始，我们将它们跳过
        let start = drop(while: { $0 == " "})
        // 遇到空格结束遍历
        let end = start.index(where: { $0 == " "}) ?? endIndex
        return start.startIndex..<end
    }
}

extension Words {
    // 集合类型需要我们提供 subscript 下标方法来获取元素
    subscript(index: WordsIndex) -> Substring {
        return string[index.range]
    }
}

extension Words {
    // 给定某个索引，计算下一个索引的值
    func index(after i: WordsIndex) -> WordsIndex {
        guard i.range.upperBound < string.endIndex else { return endIndex }
        let remainder = string[i.range.upperBound...]
        return WordsIndex(remainder.nextWordRange)
    }
}

extension Words {
    subscript(range: Range<WordsIndex>) -> Words {
        let start = range.lowerBound.range.lowerBound
        let end = range.upperBound.range.upperBound
        return Words(string[start..<end])
    }
}

struct WordsIndex: Comparable {
    fileprivate let range: Range<Substring.Index>
    fileprivate init(_ value: Range<Substring.Index>) {
        self.range = value
    }
    static func < (lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range.lowerBound < rhs.range.lowerBound
    }
    static func ==(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range == rhs.range
    }
}

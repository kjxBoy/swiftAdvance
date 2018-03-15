//
//  自定义一个队列(FIFO).swift
//  swift进阶
//
//  Created by 康佳兴 on 2018/2/27.
//  Copyright © 2018年 Kang. All rights reserved.
//

import UIKit
/// 一个能够将元素入队和出队的类型
protocol Queue {
    /// 在 `self` 中所持有的元素的类型
    associatedtype Element
    /// 将 `newElement` 入队到 `self`
    mutating func enqueue(_ newElement: Element)
    /// 从 `self` 出队一个元素
    mutating func dequeue() -> Element?
}

/**
     var playlist: FIFOQueue = ["Shake It Off", "Blank Space", "Style"]
     print(playlist.first ?? "") // Optional("Shake It Off")
     playlist[0] = "You Belong With Me"
     print(playlist.first ?? "") // Optional("You Belong With Me")
 */

/// 一个高效的 FIFO 队 ，其中元素类型为 `Element`
struct FIFOQueue<Element>: Queue {
    private var left: [Element] = []
    private var right: [Element] = []
    /// 将元素添加到队列最后
    /// - 复杂度: O(1)
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    /// 从队列前端移除一个元素
    /// 当队列为空时，返回 nil
    /// - 复杂度: 平摊 O(1)
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

extension FIFOQueue:Collection {
    
    // 我们使用 Int 来作为 Index 类型
    // 这句可以省略，swift可以根据上下文进行推断
    typealias Index = Int
    
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count }
    
    /// 返回在给定索引之后的那个索引值
    public func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }
    
    /// 访问特定位置的元素
    /*
        let quene:FIFOQueue = [1,2,3]
        print(quene[0])
     */
    public subscript(position: Int) -> Element {
        get {
            precondition((0..<endIndex).contains(position), "Index out of bounds")
            if position < left.endIndex {
                return left[left.count - position - 1]
            } else {
                return right[position - left.count]
            }
        }
        set {
            precondition((0..<endIndex).contains(position),"Index out of bounds")
            if position < left.endIndex {
                left[left.count - position - 1] = newValue
            } else {
                right[position - left.count] = newValue
            }
        }
    }
}


// MARK: - ExpressibleByArrayLiteral(使得队列满足使用[1,2,3]方式进行快速定义)
// 这里的 [1, 2, 3] 并不是一个数组，它只是 一个 “数组字面量”，是一种写法，我们可以用它来创建任意的遵守 ExpressibleByArrayLiteral 的类型。
extension FIFOQueue: ExpressibleByArrayLiteral {
    // 这行可以省略，swift会自动推断
    typealias ArrayLiteralElement = Element
    init(arrayLiteral elements: Element...) {
        left = elements.reversed()
        right = []
    }
}

extension FIFOQueue: RangeReplaceableCollection {
    mutating func replaceSubrange<C: Collection>(_ subrange: Range<Int>,
                                                 with newElements: C) where C.Element == Element {
        right = left.reversed() + right
        left.removeAll()
        right.replaceSubrange(subrange, with: newElements)
    } }


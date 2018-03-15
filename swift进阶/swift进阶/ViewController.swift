//
//  ViewController.swift
//  swift进阶
//
//  Created by 康佳兴 on 2018/2/23.
//  Copyright © 2018年 Kang. All rights reserved.
//

import UIKit
/*
var screen = Rectangle(width: 320, height: 480) {
    didSet {
        print("Screen changed: \(screen)")
    }
}

screen.translate(by: Point(x: 10, y: 10))
*/

struct Point {
    var x: Int
    var y: Int
    static let zero = Point(x: 0, y: 0)
}


struct Size {
    var width: Int
    var height: Int
}

struct Rectangle {
    var origin: Point
    var size: Size
}

private func +(lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

extension Rectangle {
    
    init(x: Int = 0, y: Int = 0, width: Int, height: Int) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
    
    // 只有使用了这个关键字，我们才能在方法内部对 self 的各部分进行改变
    mutating func translate(by offset: Point) {
        origin = origin + offset
    }
    
    func translated(by offset: Point) -> Rectangle {
        var copy = self
        copy.translate(by: offset)
        return copy
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bytes = MyData()
        var copy = bytes
         print(bytes._dataForWriting === copy._dataForWriting)
        for byte in 0..<5 as CountableRange<UInt8> {
            print("Appending 0x\(String(byte, radix: 16))")
            bytes.append(byte)
        }
        
    }
}

final class Box<A> {
    var unbox: A
    init(_ value: A) {
        self.unbox = value
    }
}

struct MyData {
    
    private var _data: Box<NSMutableData>
    
    var _dataForWriting: NSMutableData {
        mutating get {
            if !isKnownUniquelyReferenced(&_data) {
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                print("Making a copy")
            }
            return _data.unbox
        }
    }
    init() {
        _data = Box(NSMutableData())
    }
    init(_ data: NSData) {
        _data = Box(data.mutableCopy() as! NSMutableData)
    }
}


extension MyData {
   mutating func append(_ byte: UInt8) {
        var mutableByte = byte
        _dataForWriting.append(&mutableByte, length: 1)
    }
}


class BinaryScanner {
    var position: Int
    let data: Data
    init(data: Data) {
        self.position = 0
        self.data = data
    }
}

extension BinaryScanner {
    func scanByte() -> UInt8? {
        guard position < data.endIndex else { return nil }
        position += 1
        return data[position-1]
    }
    
    func scanRemainingBytes() {
        while let byte = self.scanByte() {
            print(byte)
        }
    }
}






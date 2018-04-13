//
//  ViewController.swift
//  swift进阶
//
//  Created by 康佳兴 on 2018/2/23.
//  Copyright © 2018年 Kang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let people = [
            Person(first: "Emily", last: "Young", yearOfBirth: 2002),
            Person(first: "David", last: "Gray", yearOfBirth: 1991),
            Person(first: "Robert", last: "Barnes", yearOfBirth: 1985),
            Person(first: "Ava", last: "Barnes", yearOfBirth: 2000),
            Person(first: "Joanne", last: "Miller", yearOfBirth: 1994),
            Person(first: "Ava", last: "Barnes", yearOfBirth: 1998),
            ]
        
//        let lastDescriptor = NSSortDescriptor(key: #keyPath(Person.last),
//                                              ascending: true,
//                                              selector: #selector(NSString.localizedStandardCompare(_:))
//        )
//
//        let firstDescriptor = NSSortDescriptor(key: #keyPath(Person.first),
//                                               ascending: true,
//                                               selector: #selector(NSString.localizedStandardCompare(_:))
//        )
//        let yearDescriptor = NSSortDescriptor(key: #keyPath(Person.yearOfBirth),
//                                              ascending: true)
//        let descriptors = [lastDescriptor, firstDescriptor, yearDescriptor]
//        let m = (people as NSArray).sortedArray(using: descriptors)
//        print(m)
        
//       let sortFirst = people.sorted { $0.yearOfBirth < $1.yearOfBirth }
//       let sortSecond = sortFirst.sorted { p0, p1 in
//            let left = [p0.last, p0.first]
//            let right = [p1.last, p1.first]
//            return left.lexicographicallyPrecedes(right) {
//                $0.localizedStandardCompare($1) == .orderedAscending }
//        }
//       let sortThird = sortSecond.map{ $0.first }
//        print(sortThird)
        
        /// ⼀个排序断言，当且仅当第一个值应当排序在第二个值之前时，返回 `true`
        typealias SortDescriptor<Value> = (Value, Value) -> Bool
        
        /// 通过一个排序断言，以及⼀个能给定某个值，就能对应产⽣应该用于排序断言的值的`key` 函数，来构建⼀个`SortDescriptor`函数。
        func sortDescriptor<Value, Key>(key: @escaping (Value) -> Key,by areInIncreasingOrder: @escaping (Key, Key) -> Bool) -> SortDescriptor<Value> {
            return { areInIncreasingOrder(key($0), key($1)) }
        }
    }
    
    @objcMembers
    final class Person: NSObject {
        let first: String
        let last: String
        let yearOfBirth: Int
        init(first: String, last: String, yearOfBirth: Int) {
            self.first = first
            self.last = last
            self.yearOfBirth = yearOfBirth
        }
    }

    
}








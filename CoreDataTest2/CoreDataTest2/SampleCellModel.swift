//
//  cellModel.swift
//  tableViewDemo
//
//  Copyright © 2015 jatin. All rights reserved.
//

import Foundation
import UIKit

open class SampleCellModel: NSObject {
    var downcateg1: String!
    var money1: String!
    var faceimage1: UIImage!
    var upimage1: UIImage!
    var note1: String!
    var userimage1: UIImage!
    
    init(downcateg1: String, money1: String,note1: String,faceimage1: UIImage!,userimage1: UIImage!,upimage1: UIImage!) {
        self.downcateg1 = downcateg1
        self.money1 = money1
        self.note1 = note1
        self.faceimage1 = faceimage1 ?? nil
        self.userimage1 = userimage1 ?? nil
        self.upimage1 = upimage1 ?? nil
    }
}

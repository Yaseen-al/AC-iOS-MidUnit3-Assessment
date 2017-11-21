//
//  JeopardyData.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct JeopardyQuestion: Codable {
    var answer: String
    var question: String
    var value: Int?
    var category: CategoryWraper
}
struct CategoryWraper: Codable {
    var title: String
}

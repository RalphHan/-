//
//  Cell.swift
//  TouTiao
//
//  Created by RalphHan on 2021/4/22.
//

import Foundation
import SwiftUI


struct Cell: Hashable, Identifiable {
    var id=UUID()
    var publish_time: String=""
    var author_name: String=""
    var avatar: String=""
    var cell_type: Int=0
    var title: String=""
    var article_url: String=""
    var covers:[String]=[]
}

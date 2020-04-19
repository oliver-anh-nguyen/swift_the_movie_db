//
//  Strings.swift
//  TheMoviesDb
//
//  Created by Anh Nguyen on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

let str_home_section_recommend      = "RECOMMENDATIONS"
let str_home_section_category       = "CATEGORY"
let str_home_section_popular        = "POPULAR"
let str_home_section_toprated       = "TOP RATED"
let str_home_section_upcoming       = "UPCOMING"


let str_detail_section_rating      = "Your Rate"
let str_detail_section_series      = "Series Cast"
let str_detail_section_video       = "Videos"
let str_detail_section_comment     = "Comments"
let str_detail_section_recomend    = "Recommendations"
let str_detail_button_comment      = "WRITE A COMMENT"

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

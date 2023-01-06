//
//  HeroStats.swift
//  week-4-homework-2-mehmetalidemir
//
//  Created by Mehmet Ali Demir on 6.01.2023.
//

import Foundation

struct HeroStats: Decodable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
}

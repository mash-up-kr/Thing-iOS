//
//  Rankings.swift
//  thing
//
//  Created by Jinha Park on 2019/07/11.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

struct Rankings: Decodable {
    let nextPage: Int?
    let totalPage: Int
    let currentPage: Int
    let createAt: String
    let filterType: String
    let rankings: [RankingList]
}

struct RankingList: Decodable {
    let id: Int
    let ranking: Int
    let name: String
    let thumbnail: String?
    let viewCount: String
    let bannerImgUrl: String?
    let subscriberCount: String
}

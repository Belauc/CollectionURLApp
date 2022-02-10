//
//  Models.swift
//  CollectionURLApp
//
//  Created by Sergey on 19.01.2022.
//

import UIKit

class collectionCell: UICollectionViewCell {

    
}

struct Anime: Decodable {
    var anime_id: Int = 0
    var anime_name: String = ""
    var anime_img: String = ""
    
}

struct AnimeFact: Decodable {
    let fact_id: Int
    let fact: String
}

struct AnimeList: Decodable {
    let data: [Anime]
}

struct ChooseAnimeFacts: Decodable {
    let total_facts: Int
    let img: String
    let data: [AnimeFact]
}


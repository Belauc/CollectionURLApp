//
//  CustomCollectionViewCell.swift
//  CollectionURLApp
//
//  Created by Sergey on 19.01.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

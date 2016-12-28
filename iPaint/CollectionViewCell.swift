//
//  CollectionViewCell.swift
//  iPaint
//
//  Created by Pham Ngoc Hai on 12/28/16.
//  Copyright © 2016 pnh. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let kCellWidth : CGFloat = 44
    var filteredImage: UIImageView!
    override init(frame: CGRect){
    super.init(frame: frame)
        addSubview()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview()
        
    }
    func addSubview() {
        if filteredImage == nil{
        filteredImage = UIImageView(frame: CGRect(x: 0, y: 0, width: kCellWidth, height: kCellWidth))
            filteredImage.layer.borderColor = tintColor.cgColor
            contentView.addSubview(filteredImage)
        
        }
    }
    override var isSelected: Bool
        {
        didSet
        {
            filteredImage.layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    }


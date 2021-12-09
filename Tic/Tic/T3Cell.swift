//
//  T3Cell.swift
//  Tic
//
//  Created by DCS on 26/11/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class T3Cell: UICollectionViewCell {
   private let myimgView : UIImageView =
    {
        let imgview = UIImageView()
        imgview.contentMode = .scaleAspectFit
        imgview.clipsToBounds = true
        return imgview
    }()
    
    func setupCell(with status:Int)
    {
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(myimgView)
        myimgView.frame = CGRect(x: 10, y: 10, width: 65, height: 65)
        let name = status == 0 ? "Zero" : status == 1 ? "Cross" : ""
        myimgView.image = UIImage(named : name)
        
        
    }
}

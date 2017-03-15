//
//  CharCell.swift
//  Worldie
//
//  Created by Code For Change on 3/1/17.
//  Copyright © 2017 Code For Change. All rights reserved.
//

import Foundation


import UIKit

class CharCell: UICollectionViewCell {
    var charName : UILabel
    var imageView : UIImageView
    
    override init(frame: CGRect) {
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        charName = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        super.init(frame: frame)
        
        charName.textAlignment = NSTextAlignment.center
        charName.textColor = UIColor.white
        
        contentView.addSubview(imageView)
        contentView.addSubview(charName)
       
    }
    
    func getFrame(x: CGFloat, y:CGFloat, width:CGFloat, height:CGFloat) -> CGRect {
        return CGRect(x: x-(width/2), y: y-(height/2), width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //contentView.addSubview(charname)
    
}

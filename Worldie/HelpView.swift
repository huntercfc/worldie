//
//  HelpView.swift
//  Worldie
//
//  Created by Code For Change on 3/1/17.
//  Copyright © 2017 Code For Change. All rights reserved.
//

import Foundation

import UIKit

class HelpView: UIView, UIScrollViewDelegate {
    
    
    var title : UILabel!
    var headerView : UIImageView!
    var donateButton : UIButton!
    var helpButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
    }
    
    convenience init(charID: Int, frame: CGRect) {
        self.init(frame: frame)
        self.switchChar(charID: charID)
    }
    
    func switchChar(charID: Int) {
        title.text = "Charity: " + String(charID)
    }
    
    func addViews() {
        let width = self.bounds.width
        let height = self.bounds.height
        title = UILabel()
        headerView = UIImageView()
        donateButton = UIButton()
        helpButton = UIButton()
        let titleHeight : CGFloat = 70
        let titleWidth = width-16
        title.frame = getFrame(x: width/2, y: 100, width: titleWidth, height: titleHeight)
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.textColor = UIColor.black
        title.textAlignment = NSTextAlignment.center
        
        headerView.frame = CGRect(x: 0, y: 0, width: width, height: 200)
        
        let buttonWidth : CGFloat = 70
        donateButton.frame = getFrame(x: width/4, y: 0.75*height, width: buttonWidth, height: buttonWidth)
        helpButton.frame = getFrame(x: 3*width/4, y: 0.75*height, width: buttonWidth, height: buttonWidth)
        donateButton.layer.cornerRadius = buttonWidth/2
        helpButton.layer.cornerRadius = buttonWidth/2
        donateButton.setTitle("Donate", for: UIControlState.normal)
        helpButton.setTitle("Help", for: UIControlState.normal)
        donateButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        helpButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        donateButton.backgroundColor = hexColor(hex: "2e5ce6")
        helpButton.backgroundColor = hexColor(hex: "02c38e")
        
        self.addSubview(title)
        self.addSubview(headerView)
        self.addSubview(donateButton)
        self.addSubview(helpButton)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.frame.width/8
    }
    
    func getFrame(x: CGFloat, y:CGFloat, width:CGFloat, height:CGFloat) -> CGRect {
        return CGRect(x: x-(width/2), y: y-(height/2), width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Helper Functions
    
    func hexColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

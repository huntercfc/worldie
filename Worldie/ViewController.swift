//
//  ViewController.swift
//  Worldie
//
//  Created by Code For Change on 3/1/17.
//  Copyright © 2017 Code For Change. All rights reserved.
//

import UIKit
import Foundation

//Queue the Charity Navigator API using JSON using the Spine Framework

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var chars: UICollectionView!//The main view for broswing charities, interaction, etc
    var top: UIView!//The navigation bar at the top
    let width = UIScreen.main.bounds.width //Useful dims for making views
    let height = UIScreen.main.bounds.height
    var helper : HelpView! = nil //The popup charity info view
    
    
    //Called as soon as our app starts
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Initializing views
        startChars()
        startTop()
        startHelper()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Sets up the Charity View/chars, a collection view containing cells that each contain a charity/non-profit
    func startChars() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let cellWidth = (width-(2*2))/3
        layout.sectionInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width:cellWidth, height: cellWidth)
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        chars = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        chars.dataSource = self
        
        chars.delegate = self
        chars.register(CharCell.self, forCellWithReuseIdentifier: "Cell")
        chars.backgroundColor = UIColor.black
        self.view.addSubview(chars)
    }
    
    //Sets up the navigation bar at the top of the screen
    func startTop() {
        top = UIView()
        let topHeight : CGFloat = 64
        top.frame = CGRect(x: 0, y: 0, width: width, height: topHeight)
        top.backgroundColor = hexColor(hex: "02c38e",alpha:0.2)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = top.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.top.addSubview(blurEffectView)
        
        let title = UILabel()
        let titleWidth : CGFloat = 200
        let titleHeight : CGFloat = 40
        title.frame = CGRect(x: (width-titleWidth)/2, y: (topHeight+20-titleHeight)/2, width: titleWidth, height: titleHeight)
        title.text = "Code 4 Change"
        title.textColor = UIColor.white
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textAlignment = NSTextAlignment.center
        self.top.addSubview(title)
        
        self.view.addSubview(top)
    }
    
    //Sets up the interaction interface that pops up when a charity is tapped on in chars
    func startHelper(){
        helper = HelpView(frame: getFrame(x: width/2, y: 1.5*height, width: 0.75*width, height:0.75*height))
        let hWidth = helper.frame.width
        let exit = UIButton()
        let exitWidth : CGFloat = 40.0
        exit.backgroundColor = UIColor.lightGray
        exit.layer.cornerRadius = exitWidth/2
        exit.frame = getFrame(x: hWidth/2, y: exitWidth, width: exitWidth, height: exitWidth)
        exit.addTarget(self, action: #selector(closeHelper), for: .touchUpInside)
        exit.setTitle("X", for: UIControlState.normal)
        helper.addSubview(exit)
        
       
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.closeHelper))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        helper.addGestureRecognizer(swipeDown)
        
        self.view.addSubview(helper)
    }
    
    //Pops up the helper when called
    func openHelper(){
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 15.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.helper.transform = CGAffineTransform.init(translationX: 0, y: -self.height)
        })
    }
    
    //Closes helper when called
    func closeHelper(){
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 15.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.helper.transform = CGAffineTransform.identity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1002//Arbitrary ammount -> will be the number of charities in our database
    }
    
    //This function is called for when each cell is loaded into chars, the only information we get is the indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CharCell
        
        //Randomized Color Gen (Just for prototype)
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        cell.charName.text = String(indexPath.row)
        cell.backgroundColor = UIColor.init(displayP3Red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        return cell
    }
    
    //Called when a cell is tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        helper.switchChar(charID: indexPath.row)
        openHelper()
    }
    
    //Called when a cell goes out of view
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
    }
    
    //Helper Functions >>>
    
    //Hex String to UIColor
    func hexColor (hex:String, alpha: CGFloat) -> UIColor {
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
            alpha: alpha
        )
    }
    
    //Gets a frame that has a certain width and height, centered on point (x,y)
    func getFrame(x: CGFloat, y:CGFloat, width:CGFloat, height:CGFloat) -> CGRect {
        return CGRect(x: x-(width/2), y: y-(height/2), width: width, height: height)
    }

}


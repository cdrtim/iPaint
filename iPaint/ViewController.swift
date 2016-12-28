//
//  ViewController.swift
//  iPaint
//
//  Created by Pham Ngoc Hai on 12/28/16.
//  Copyright © 2016 pnh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var mainView: UIImageView!
    var lastPoint = CGPoint.zero
    var red : CGFloat = 0.0
    var blue : CGFloat = 0.0
    var green: CGFloat = 0.0
    var brush : CGFloat = 10.0
    var opacity : CGFloat =  1.0
    var swiped = false
    var baseImage = UIImage()
    let arrayColor = ["Black", "Grey", "Red", "Blue", "LightBlue", "DarkGreen", "LightGreen", "Brown", "DarkOrange", "Yellow"]
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         }

    @IBAction func Reset(_ sender: Any) {
         mainView.image = baseImage
    }
   
    @IBAction func SAve(_ sender: AnyObject) {
       UIImageWriteToSavedPhotosAlbum(mainView.image!, self, nil, nil)
    }

    @IBAction func Album(_ sender: Any) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imgPicker, animated: true, completion: nil)
    }
  //  image picker controller delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage
        {
            baseImage = pickedImage
            mainView.image = baseImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func btn_eraser(_ sender: Any) {
        let index = (sender as AnyObject).tag
        switch (index!)
        {
        case 101: brush = 5
        case 102: brush = 10
        case 103: brush = 30
        case 104:(red, green, blue) = colors[10]
        default: break
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touches = touches.first
        {
            
            lastPoint = touches.location(in: view)
            
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touches = touches.first
        {
        
        let currentPoint = touches.location(in: mainView)
            drawLineFome(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
            
        
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!swiped)
        {
        drawLineFome(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    func drawLineFome(fromPoint: CGPoint, toPoint: CGPoint)
    {
    UIGraphicsBeginImageContext(mainView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        mainView.image?.draw(in: CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height))
       
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        // 3
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(CGFloat(brush))
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        mainView.image = UIGraphicsGetImageFromCurrentImageContext()
        mainView.alpha = opacity
        UIGraphicsEndImageContext()
        
    
    
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  colors.count - 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.filteredImage.image = UIImage(named: arrayColor[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         (red, green, blue) = colors[(indexPath as NSIndexPath).item]
    }
    }





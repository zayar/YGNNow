//
//  LoadImages.swift
//  YGNNow
//
//  Created by zayar min on 12/11/16.
//  Copyright © 2016 zayarmin. All rights reserved.
//



import UIKit
import Firebase
import FirebaseStorage

/*
 Download images with cache extension
 */

let imageCache = NSCache <AnyObject,AnyObject>()

extension UIImageView{
    
    func loadUsingCache(_ theUrl: String) {
        
        self.image = nil
        
        //check cache for image
        if let cachedImage = imageCache.object(forKey: theUrl as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        
        //otherwise download it
        let url = URL(string: theUrl)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            //print error
            if (error != nil){
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: theUrl as AnyObject)
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}
















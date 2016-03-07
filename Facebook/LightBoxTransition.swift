//
//  LightBoxTransition.swift
//  Facebook
//
//  Created by Brenda Chung on 3/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LightBoxTransition: BaseTransition {
    
    var movingImageView: UIImageView!
    var selectedImageTag: Int!

    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let photoViewController = fromViewController as! PhotoViewController
        let lightBoxViewController = toViewController as! LightBoxViewController
        
        selectedImageTag = photoViewController.selectedImageView.tag
        
//        if (photoViewController.scrollView.contentOffset.y != photoViewController.weddingImages[selectedImageTag].frame.origin.y) {
//            photoViewController.scrollView.contentOffset.y = photoViewController.weddingImages[selectedImageTag].frame.origin.y
//        }
        
        let photoViewFrame = containerView.convertRect(photoViewController.selectedImageView.frame, fromView: photoViewController.scrollView)
        let lightBoxViewFrame = containerView.convertRect(lightBoxViewController.imageView.frame, fromView: lightBoxViewController.scrollView)
        
        movingImageView = UIImageView()
//                movingImageView.frame.size.height = photoViewController.selectedImageView.frame.size.height
//                movingImageView.frame.size.width = photoViewController.selectedImageView.frame.size.width
//                movingImageView.frame.origin.y = photoViewController.selectedImageView.frame.origin.y
        
        movingImageView.image = photoViewController.selectedImageView.image
        movingImageView.frame = photoViewFrame
        //movingImageView.clipsToBounds = photoViewController.selectedImageView.clipsToBounds
        movingImageView.contentMode = .ScaleAspectFit
        
//        lightBoxViewController.imageView.frame.size.width = photoViewController.selectedImageView.frame.size.width
        
        
        containerView.addSubview(movingImageView)
        
        photoViewController.selectedImageView.alpha = 0
        photoViewController.imageView.alpha = 0
        toViewController.view.alpha = 0
        
        UIView.animateWithDuration(duration, animations: {
            toViewController.view.alpha = 1
            self.movingImageView.frame = lightBoxViewFrame
            
            }) { (finished: Bool) -> Void in
                toViewController.view.alpha = 1
                photoViewController.selectedImageView.alpha = 1
                self.movingImageView.alpha = 0
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let photoViewController = toViewController as! PhotoViewController
        let lightBoxViewController = fromViewController as! LightBoxViewController
        let contentOffset = photoViewController.scrollView.frame.origin.y - photoViewController.scrollView.contentOffset.y
        
        var tempFrame = photoViewController.selectedImageView.frame
        tempFrame.origin.y = photoViewController.selectedImageView.frame.origin.y + contentOffset
        
        lightBoxViewController.imageView.alpha = 0
        lightBoxViewController.view.alpha = 0
        movingImageView.alpha = 1
        
       // movingImageView.bounds = photoViewController.selectedImageView.bounds

        UIView.animateWithDuration(duration, animations: {
            self.movingImageView.frame = tempFrame
            //photoViewController.view.backgroundColor = UIColor.clearColor()
            
            }) { (finished: Bool) -> Void in
                self.movingImageView.removeFromSuperview()
                self.finish()
        }
        
    }


}

//
//  ImageTransition.swift
//  Facebook
//
//  Created by Brenda Chung on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    
    var movingImageView: UIImageView!
    var selectedImageTag: Int!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let newsFeedViewController = fromViewController as! NewsFeedViewController
        let photoViewController = toViewController as! PhotoViewController
//        let contentOffset = newsFeedViewController.scrollView.frame.origin.y - newsFeedViewController.scrollView.contentOffset.y
        
        selectedImageTag = newsFeedViewController.selectedImageView.tag
        
        // TODO: Instead of checking for the first image, check if its landscape or not.
        if (selectedImageTag > 0) {
            photoViewController.scrollView.contentOffset.y = photoViewController.weddingImages[selectedImageTag].frame.origin.y - 139
        } else {
            photoViewController.scrollView.contentOffset.y = photoViewController.weddingImages[selectedImageTag].frame.origin.y
        }
//        print(photoViewController.weddingImages[selectedImageTag].frame.origin.y)
            //CGFloat(selectedImageTag) * 523
        
        let newsViewFrame = containerView.convertRect(newsFeedViewController.selectedImageView.frame, fromView: newsFeedViewController.scrollView)
        let photoViewFrame = containerView.convertRect(photoViewController.weddingImages[selectedImageTag].frame, fromView: photoViewController.scrollView)
        
        movingImageView = UIImageView()
        movingImageView.image = newsFeedViewController.selectedImageView.image
        movingImageView.frame = newsViewFrame
//        movingImageView.frame.size.height = newsFeedViewController.selectedImageView.frame.size.height
//        movingImageView.frame.size.width = newsFeedViewController.selectedImageView.frame.size.width
//        movingImageView.frame.origin.y = newsFeedViewController.selectedImageView.frame.origin.y
        movingImageView.contentMode = .ScaleAspectFit
        containerView.addSubview(movingImageView)
        
        newsFeedViewController.selectedImageView.alpha = 0
        photoViewController.imageView.alpha = 0
        toViewController.view.alpha = 0

        UIView.animateWithDuration(duration, animations: {
            self.movingImageView.frame = photoViewFrame
            //photoViewController.view.backgroundColor = UIColor.blackColor()
            
            }) { (finished: Bool) -> Void in
                toViewController.view.alpha = 1
                newsFeedViewController.selectedImageView.alpha = 1
                self.movingImageView.alpha = 0
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let newsFeedViewController = toViewController as! NewsFeedViewController
        let photoViewController = fromViewController as! PhotoViewController
        let contentOffset = newsFeedViewController.scrollView.frame.origin.y - newsFeedViewController.scrollView.contentOffset.y
        
        photoViewController.imageView.alpha = 0
        photoViewController.view.alpha = 0
        movingImageView.alpha = 1
//        UIView.animateWithDuration(0.2, delay: 0.8, options: [], animations: { () -> Void in
//            self.movingImageView.alpha = 1
//            }, completion: nil)
        
        var tempFrame = newsFeedViewController.selectedImageView.frame
        tempFrame.origin.y = newsFeedViewController.selectedImageView.frame.origin.y + contentOffset
        
        UIView.animateWithDuration(duration, animations: {
            self.movingImageView.frame = tempFrame
            //photoViewController.view.backgroundColor = UIColor.clearColor()
        
            }) { (finished: Bool) -> Void in
                self.movingImageView.removeFromSuperview()
                self.finish()
        }
        
    }

}

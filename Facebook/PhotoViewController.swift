//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Brenda Chung on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var wedding1: UIImageView!
    @IBOutlet weak var wedding2: UIImageView!
    @IBOutlet weak var wedding3: UIImageView!
    @IBOutlet weak var wedding4: UIImageView!
    @IBOutlet weak var wedding5: UIImageView!
    var weddingImages = [UIImageView]()
    var selectedImageView: UIImageView!
    var lightBoxTransition: LightBoxTransition!
    var offset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: 1622)
        
        weddingImages = [wedding1, wedding2, wedding3, wedding4, wedding5]
//        for weddingImage in weddingImages {
//            weddingImage.alpha = 1
//        }
        lightBoxTransition = LightBoxTransition()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onTapGesture(sender: UITapGestureRecognizer) {
        selectedImageView = sender.view as! UIImageView
        offset = scrollView.contentOffset.y
        performSegueWithIdentifier("lightboxSegue", sender: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
        UIView.animateWithDuration(0.4, animations: {
            self.imageView.alpha = 0
            }) { (finished: Bool) -> Void in
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let lightBoxViewController = segue.destinationViewController as! LightBoxViewController
        
        lightBoxViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        lightBoxViewController.transitioningDelegate = lightBoxTransition
        
        lightBoxViewController.view.layoutIfNeeded()
        
        lightBoxViewController.imageView.image = selectedImageView.image
    }
    

}

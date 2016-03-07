//
//  LightBoxViewController.swift
//  Facebook
//
//  Created by Brenda Chung on 3/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LightBoxViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButton: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: 674)
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
        UIView.animateWithDuration(0.4, animations: {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.8)
            }) { (finished: Bool) -> Void in
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.2, animations: {
            self.doneButton.alpha = 0
            }) { (finished: Bool) -> Void in
        }
    }
    
    @IBAction func didPressDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            if scrollView.contentOffset.y > 100 {
                dismissViewControllerAnimated(true, completion: nil)
            } else {
                UIView.animateWithDuration(0.2, animations: {
                    scrollView.setContentOffset(CGPoint.zero, animated:true)
                    self.doneButton.alpha = 1
                    self.actionButton.alpha = 1
                    }) { (finished: Bool) -> Void in
                }
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

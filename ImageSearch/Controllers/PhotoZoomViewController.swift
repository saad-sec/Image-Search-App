//
//  PhotoZoomViewController.swift
//  ImageSearch
//
//  Created by Saad on 22/1/22.
//

import UIKit

protocol PhotoZoomViewControllerDelegate: AnyObject {
    func photoZoomViewController(_ photoZoomViewController: PhotoZoomViewController, scrollViewDidScroll scrollView: UIScrollView)
}

class PhotoZoomViewController: UIViewController {
    
    weak var delegate: PhotoZoomViewControllerDelegate?

    var model: MainImageModel!
    var index: Int = 0
    
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newImageView: UIImageView!
    //@IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.scrollView.delegate = self
//        if #available(iOS 11, *) {
//            self.scrollView.contentInsetAdjustmentBehavior = .never
//        }
        
        self.newImageView.downloadImage(self.model.thumbImageURL, withAnimation: false)
        print(self.model.mainImageURL)
        self.newImageView.downloadImage(self.model.mainImageURL, withAnimation: false)
        
        //self.imageView.image = self.image
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateZoomScaleForSize(view.bounds.size)
        updateConstraintsForSize(view.bounds.size)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateZoomScaleForSize(view.bounds.size)
        updateConstraintsForSize(view.bounds.size)
    }
    
    fileprivate func updateZoomScaleForSize(_ size: CGSize) {
        
//        let widthScale = size.width / imageView.bounds.width
//        let heightScale = size.height / imageView.bounds.height
//        let minScale = min(widthScale, heightScale)
//        scrollView.minimumZoomScale = minScale
//
//        scrollView.zoomScale = minScale
//        scrollView.maximumZoomScale = minScale * 4
    }
    
    fileprivate func updateConstraintsForSize(_ size: CGSize) {
//        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
//        imageViewTopConstraint.constant = yOffset
//        imageViewBottomConstraint.constant = yOffset
//
//        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
//        imageViewLeadingConstraint.constant = xOffset
//        imageViewTrailingConstraint.constant = xOffset
//
//        let contentHeight = yOffset * 2 + self.imageView.frame.height
//        view.layoutIfNeeded()
//        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: contentHeight)
    }
}

//extension PhotoZoomViewController: UIScrollViewDelegate {
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return imageView
//    }
//    
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        updateConstraintsForSize(self.view.bounds.size)
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.delegate?.photoZoomViewController(self, scrollViewDidScroll: scrollView)
//    }
//}

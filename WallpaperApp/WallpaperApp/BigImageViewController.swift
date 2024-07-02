//
//  BigImageViewController.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/06/28.
//

import UIKit

class BigImageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = image {
            imageView.image = image
            
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 4.0
            scrollView.bouncesZoom = true
            
            // ContentViewの設定
            contentView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            scrollView.addSubview(contentView)
            
            // ImageViewの設定
            imageView.frame = contentView.bounds
            contentView.addSubview(imageView)
            
            // ScrollViewのコンテンツサイズを設定
            scrollView.contentSize = contentView.frame.size
            
            // 画像の中心を常に画面の中心にする
            centerImage()
        }
    }
    
    func centerImage() {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2.0 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}

extension BigImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        centerImage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        centerImage()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = true
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.isScrollEnabled = true
    }
}

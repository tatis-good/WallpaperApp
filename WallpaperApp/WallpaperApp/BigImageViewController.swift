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
    private var isDragging = false
    private var lastLocation: CGPoint = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = image {
            imageView.image = image
            
            // ピンチジェスチャーを追加
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            scrollView.addGestureRecognizer(pinchGesture)
            // ダブルタップジェスチャーを追加
            let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
            doubleTapGesture.numberOfTapsRequired = 2
            scrollView.addGestureRecognizer(doubleTapGesture)
            
            // マウスドラッグ操作ジェスチャー認識を追加
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            imageView.addGestureRecognizer(panGesture)
        }
    }
    // ピンチジェスチャーのハンドラ
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let imageView = imageView else { return }
        imageView.transform = imageView.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1.0
    }
    // ダブルタップジェスチャーのハンドラ
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        guard let imageView = imageView else { return }
        
        // 現在の倍率を取得
        let currentScale = imageView.transform.a
        
        // 倍率が1.0より大きい場合は縮小
        if currentScale > 1.0 {
            let scaleAmount: CGFloat = 0.5
            let newTransform = imageView.transform.scaledBy(x: scaleAmount, y: scaleAmount)
            imageView.transform = newTransform
        }
        // 倍率が1.0以下の場合は拡大
        else {
            let scaleAmount: CGFloat = 2.0
            let newTransform = imageView.transform.scaledBy(x: scaleAmount, y: scaleAmount)
            imageView.transform = newTransform
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let imageView = imageView else { return }
        
        switch gesture.state {
        case .began:
            isDragging = true
            lastLocation = imageView.center
        case .changed:
            if isDragging {
                let translation = gesture.translation(in: view)
                imageView.center = CGPoint(x: lastLocation.x + translation.x,
                                           y: lastLocation.y + translation.y)
            }
        case .ended, .cancelled, .failed:
            isDragging = false
        default:
            break
        }
    }
    
}



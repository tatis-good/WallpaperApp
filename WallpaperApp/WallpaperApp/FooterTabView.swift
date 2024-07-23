//
//  FooterTabView.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/07/01.
//

import UIKit

enum FooterTab {
    case home
    case colorsearch
    case appinfo
}

protocol FooterTabViewDelegate: AnyObject {
    func footerTabView(_ footerTabView: FooterTabView, didselectedTab: FooterTab)
    func switchViewController(selectedTab: FooterTab)
}

class FooterTabView: UIView {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    weak var delegate: FooterTabViewDelegate?
    
    //新着写真の画面
    @IBAction func didTapHome(_ sender: Any) {
        delegate?.footerTabView(self, didselectedTab: .home)
        delegate?.switchViewController(selectedTab: .home)
    }
    //カラー別写真の画面
    @IBAction func didTapColorSearch(_ sender: Any) {
        delegate?.footerTabView(self, didselectedTab: .colorsearch)
        delegate?.switchViewController(selectedTab: .colorsearch)
    }
    //アプリ概要に画面
    @IBAction func didTapAppInfo(_ sender: Any) {
        delegate?.footerTabView(self, didselectedTab: .appinfo)
        delegate?.switchViewController(selectedTab: .appinfo)
    }
    
    //カスタムビューの初期化メソッド
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
        setup()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        load()
        setup()
    }
    
    //Viewのレイアウト設定
    func setup() {
        contentView.layer.cornerRadius = contentView.frame.height / 2
        contentView.clipsToBounds = true
        shadowView.layer.cornerRadius = shadowView.frame.height / 2
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowRadius = 8.0
        shadowView.layer.shadowOpacity = 0.2
    }
    
    func load() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    
    
}

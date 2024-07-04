//
//  ViewController.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/06/25.
//

import UIKit

class ViewController: UIViewController, FooterTabViewDelegate {
    
    
    
    @IBOutlet weak var footerTabView: FooterTabView! {
        didSet {
            footerTabView.delegate = self
        }
    }
    
    var selectedTab: FooterTab = .home
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchViewController(selectedTab: .home)
    }
    private lazy var homeViewController: HomeViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        add(childViewController: viewController)
        return viewController
    }()
    
    private lazy var colorSearchViewController: ColorSearchViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ColorSearchViewController") as! ColorSearchViewController
        add(childViewController: viewController)
        return viewController
    }()
    
    private lazy var appInfoViewController: AppInfoViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AppInfoViewController") as! AppInfoViewController
        add(childViewController: viewController)
        return viewController
    }()
    
     func switchViewController(selectedTab: FooterTab) {
        switch selectedTab {
        case .home: add(childViewController: homeViewController)
            remove(childViewController: colorSearchViewController)
            remove(childViewController: appInfoViewController)
        case .colorsearch: add(childViewController: colorSearchViewController)
            remove(childViewController: homeViewController)
            remove(childViewController: appInfoViewController)
        case .appinfo: add(childViewController: appInfoViewController)
            remove(childViewController: homeViewController)
            remove(childViewController: colorSearchViewController)
        }
        self.selectedTab = selectedTab
        view.bringSubviewToFront(footerTabView)
    }
    
    private func add(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    private  func remove(childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
    
    func footerTabView(_ footerTabView: FooterTabView, didselectedTab: FooterTab) {
        switchViewController(selectedTab: selectedTab)
    }
   
    }


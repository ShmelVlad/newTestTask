//
//  BaseViewController.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import UIKit
import Dip

class BaseViewController<PresenterType: BasePresenter>: UIViewController, StoryboardInstantiatable {
    
    private var progressViewBackground: UIView?
    private var indicatorActivity: UIActivityIndicatorView?
    private var keyBoardUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlert(with message: String, title: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func progressBarWillShow() {
        
        progressViewBackground = UIView()
        progressViewBackground?.layer.zPosition = 5
        progressViewBackground?.frame = CGRect(x: 0,
                                               y: 0,
                                               width: self.view.frame.width,
                                               height: self.view.frame.height)
        progressViewBackground?.backgroundColor = .black
        progressViewBackground?.alpha = 0 //0.5
        
        indicatorActivity = UIActivityIndicatorView()
        indicatorActivity?.frame = (progressViewBackground?.frame)!
        progressViewBackground?.addSubview(indicatorActivity!)
        indicatorActivity?.startAnimating()
        self.view.addSubview(progressViewBackground!)
        
        UIView.animate(withDuration: 0.4) {
            self.progressViewBackground?.alpha = 0.5
        }
        
    }
    
    func progressBarWillHide() {
        
        indicatorActivity?.stopAnimating()
        
        UIView.animate(withDuration: 0.2) {
            self.progressViewBackground?.alpha = 0
        }
        
        self.progressViewBackground?.removeFromSuperview()
    }

    
    func bind(presenter: PresenterType) {
        assertionFailure("Переопредели данный метод для потомка")
    }
    
    // MARK: DIP
    func didInstantiateFromStoryboard(_ container: DependencyContainer, tag: DependencyContainer.Tag?) throws {
        assertionFailure("Переопредели данный метод для потомка")
    }
}


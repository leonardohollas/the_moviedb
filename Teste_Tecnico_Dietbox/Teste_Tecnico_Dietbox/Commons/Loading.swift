//
//  Loading.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 20/09/21.
//

import UIKit

class Loading {
    static let shared = Loading()
    private var activityIndicatorView = UIActivityIndicatorView()
    private var loadingView = UIView()
    private var viewTag = 9874625363653773
        
    private var loadingVC = UIViewController()
    
    init(){}
    
    func showLoading(view: UIView) {
        var screenSize: CGRect = view.bounds
        if screenSize.width == 0 {
            screenSize = UIScreen.main.bounds
        }
        loadingView = UIView(frame: screenSize)
        
        activityIndicatorView = UIActivityIndicatorView()
        
        activityIndicatorView.center = loadingView.center
        activityIndicatorView.color = .white
        
        loadingView.tag = viewTag
        loadingView.addSubview(activityIndicatorView)
        loadingView.bringSubviewToFront(activityIndicatorView)
        loadingView.backgroundColor = .gray
        
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading(view: UIView) {
        if let loadingView = view.viewWithTag(viewTag) {
            loadingView.removeFromSuperview()
        }
        
        guard view is UICollectionView else { return }
        
        if let loadingView = view.viewWithTag(viewTag) {
            loadingView.removeFromSuperview()
        }
        else {
            guard let loadingView = view.superview?.superview?.viewWithTag(viewTag) else { return }
            
            loadingView.removeFromSuperview()
        }
    }
}

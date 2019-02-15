//
//  VCModulo.swift
//  findBike
//
//  Created by Israel on 2/14/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class VCModulo: UIViewController {
    
    var loading:NVActivityIndicatorView!
    var lblLoadingStatus:UILabel!
    var viewLoadingBackground:UIView!
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoading()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initLoading()
    {
        loading = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 70, height: 70), type: .circleStrokeSpin, color: UIColor.white, padding: 0)
        loading.center = CGPoint(x:UIScreen.main.bounds.width/2, y:UIScreen.main.bounds.height/2)
        lblLoadingStatus = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        lblLoadingStatus.textAlignment = .center
        lblLoadingStatus.font = UIFont.systemFont(ofSize: 17)
        lblLoadingStatus.textColor = .white
        lblLoadingStatus.center = CGPoint(x:UIScreen.main.bounds.width/2, y:(UIScreen.main.bounds.height/2)+80)
        viewLoadingBackground = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        viewLoadingBackground.backgroundColor = UIColor.black
        viewLoadingBackground.alpha = 0
    }
    
   
    func showShadown(mostrar: Bool){
        if mostrar{
            self.navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
            self.navigationController?.navigationBar.layer.masksToBounds = false
            self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0 , height: 2.0)
            self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
            self.navigationController?.navigationBar.layer.shadowRadius = 2.0
        }else{
            self.navigationController?.navigationBar.layer.shadowColor = nil
            self.navigationController?.navigationBar.layer.masksToBounds = false
            self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
            self.navigationController?.navigationBar.layer.shadowOpacity = 0.0
            self.navigationController?.navigationBar.layer.shadowRadius = 0.0
        }
    }
    
    func showLoading(status:String)
    {
        if !isLoading
        {
            isLoading = true
            DispatchQueue.main.async(execute:
                {
                    
                    UIApplication.shared.keyWindow?.addSubview(self.viewLoadingBackground)
                    UIApplication.shared.keyWindow?.addSubview(self.loading)
                    UIApplication.shared.keyWindow?.addSubview(self.lblLoadingStatus)
                    
                    self.viewLoadingBackground.alpha(alpha: 0.6, duration: 0.6, delay: 0)
                    
                    self.loading.alpha = 0
                    self.lblLoadingStatus.alpha = 0
                    self.lblLoadingStatus.text = status
                    
                    self.loading.startAnimating()
                    
                    self.loading.alpha(alpha: 1, duration: 0.6, delay: 0)
                    self.lblLoadingStatus.alpha(alpha: 1, duration: 0.6, delay: 0.3)
                    
                    self.view.isUserInteractionEnabled = false
            })
        }
    }
    
    func hideLoading()
    {
        DispatchQueue.main.async(execute: {
            self.loading.alpha(alpha:0, duration: 0.6, delay: 0, completion: { (finished) in
                self.loading.stopAnimating()
                self.loading.alpha = 1
            })
            
            self.lblLoadingStatus.alpha(alpha:0, duration: 0.4, delay: 0, completion:nil)
            
            self.viewLoadingBackground.alpha(alpha:0, duration: 0.6, delay: 0.2, completion:
                {
                    finished in
                    
                    self.viewLoadingBackground.removeFromSuperview()
                    self.loading.removeFromSuperview()
                    self.lblLoadingStatus.removeFromSuperview()
                    
                    self.isLoading = false
            })
            self.view.isUserInteractionEnabled = true
        })
    }
}
extension UIView{
    
    //MARK:- Alpha
    func alpha(alpha:CGFloat)
    {
        self.alpha = alpha
    }
    
    func alpha(alpha:CGFloat, duration:TimeInterval)
    {
        self.alpha(alpha:alpha, duration:duration, delay:0)
    }
    
    func alpha(alpha:CGFloat, duration:TimeInterval, delay:TimeInterval)
    {
        Animation.sharedInstance.alphaWithAnimation(view: self, alpha: alpha, duration: duration, delay: delay, options: .curveEaseInOut, completion: nil)
    }
    
    
    func alpha(alpha:CGFloat, duration:TimeInterval, delay:TimeInterval, completion:((Bool) -> Swift.Void)? = nil)
    {
        Animation.sharedInstance.alphaWithAnimation(view: self, alpha: alpha, duration: duration, delay: delay, options: .curveEaseInOut, completion: completion)
    }
    
}

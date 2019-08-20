//
//  DashboardViewController.swift
//  SliderViewPager
//
//  Created by Neeraj kumar on 23/07/19.
//  Copyright © 2019 prolifics. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    var controller: PageViewController!
    var xValue1: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        self.controller = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        addChild(self.controller)
        self.containerView.addSubview(self.controller.view)
        self.controller.view.isUserInteractionEnabled = true
        self.controller.scrollView?.panGestureRecognizer.addTarget(self, action:#selector(self.handlePan(sender:)))
        
    }
    
    @objc func handlePan(sender:UIPanGestureRecognizer) {
        
        switch sender.state {
        case .ended:
            let translation = sender.translation(in: self.view)
            if translation.x > 0{
                self.xValue1 = self.xValue1 - 1
                if self.xValue1 < 0{
                    self.xValue1 = 0
                }else{
                    swipeButton(xValue1: self.xValue1)
                }
                print(self.xValue1)
            }else{
                self.xValue1 = self.xValue1 + 1
                if self.xValue1 > 2{
                    self.xValue1 = 2
                }else{
                    swipeButton(xValue1: self.xValue1)
                }
                
            }
            print("User Swaped  ",self.xValue1)
        default:
            break
        }
    }
    
    func swipeButton(xValue1: CGFloat) {
        var xValue = xValue1
        switch xValue {
        case 0:
            xValue = self.firstBtn.frame.origin.x
            self.firstBtn.setTitleColor(UIColor.white, for: .normal)
            self.secondBtn.setTitleColor(UIColor.black, for: .normal)
            self.thirdBtn.setTitleColor(UIColor.black, for: .normal)
        case 1:
            xValue = self.secondBtn.frame.origin.x
            self.firstBtn.setTitleColor(UIColor.black, for: .normal)
            self.secondBtn.setTitleColor(UIColor.white, for: .normal)
            self.thirdBtn.setTitleColor(UIColor.black, for: .normal)
        case 2:
            xValue = self.thirdBtn.frame.origin.x
            self.firstBtn.setTitleColor(UIColor.black, for: .normal)
            self.secondBtn.setTitleColor(UIColor.black, for: .normal)
            self.thirdBtn.setTitleColor(UIColor.white, for: .normal)
        default:
            print("")
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.selectionView.frame.origin.x = xValue+5
        })
    }
    
    func setControllerFrame(controller: UIViewController){
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
        
        controller.view.translatesAutoresizingMaskIntoConstraints = true
        NSLayoutConstraint.activate([
            self.controller.view.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 0),
            self.controller.view.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 0),
            self.controller.view.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 0),
            self.controller.view.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: 0)
            ])
    }

    @IBAction func firstSecondThirdBtnACtion(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("scrollToIndex"), object: nil, userInfo: ["atIndex":sender.tag])
        self.performActionForTodayWeekMonth(sender: sender)
        self.xValue1 = CGFloat(self.controller.currentIndex)
        print(self.xValue1)
    }
    
    func performActionForTodayWeekMonth(sender: UIButton){
        var xValue : CGFloat = 0
        
        switch sender.tag {
        case 0:
            xValue = self.firstBtn.frame.origin.x
            self.firstBtn.setTitleColor(UIColor.white, for: .normal)
            self.secondBtn.setTitleColor(UIColor.black, for: .normal)
            self.thirdBtn.setTitleColor(UIColor.black, for: .normal)
        case 1:
            xValue = self.secondBtn.frame.origin.x
            self.firstBtn.setTitleColor(UIColor.black, for: .normal)
            self.secondBtn.setTitleColor(UIColor.white, for: .normal)
            self.thirdBtn.setTitleColor(UIColor.black, for: .normal)
        case 2:
            xValue = self.thirdBtn.frame.origin.x
            self.firstBtn.setTitleColor(UIColor.black, for: .normal)
            self.secondBtn.setTitleColor(UIColor.black, for: .normal)
            self.thirdBtn.setTitleColor(UIColor.white, for: .normal)
        default:
            print("")
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.selectionView.frame.origin.x = xValue+5
        })
    }
    
}

extension UIPageViewController {
    
    public var scrollView: UIScrollView? {
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                return scrollView
            }
        }
        return nil
    }
    
}

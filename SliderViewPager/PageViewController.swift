//
//  PageViewController.swift
//  SliderViewPager
//
//  Created by Neeraj kumar on 23/07/19.
//  Copyright © 2019 prolifics. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController {
    var pages = [UIViewController]()
    var previousIndex : Int = 0
    var currentIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToThePageAtIndex(_:)), name: NSNotification.Name("scrollToIndex"), object: nil)
        
        let firstVC: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        let secondVC: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        let thirdVC: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        
        self.pages.append(firstVC)
        self.pages.append(secondVC)
        self.pages.append(thirdVC)
        
        setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        
    }
    
    @objc func scrollToThePageAtIndex(_ notification: Notification){
        self.currentIndex = notification.userInfo?["atIndex"] as! Int
        
        if self.currentIndex > self.previousIndex{
            setViewControllers([self.pages[self.currentIndex]], direction: .forward, animated: true, completion: nil)
        }else if self.currentIndex < self.previousIndex{
            setViewControllers([self.pages[self.currentIndex]], direction: .reverse, animated: true, completion: nil)
        }else{
            
        }
        self.previousIndex = self.currentIndex
    }
    
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pages.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard self.pages.count > previousIndex else{
            return nil
        }
        
//        if currentIndex > 0{
//            self.currentIndex = abs((currentIndex + 1) % pages.count)
//            return pages[currentIndex]
//        }else{
//            return nil
//        }
        
        return self.pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pages.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard self.pages.count != nextIndex else {
            return nil
        }
        guard self.pages.count > nextIndex else{
            return nil
        }
        
//        if currentIndex < 2{
//            self.currentIndex = abs((currentIndex + 1) % pages.count)
//            return pages[currentIndex]
//        }else{
//            return nil
//        }
        return self.pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

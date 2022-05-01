//
//  GuideMainViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/05/01.
//

import UIKit

final class GuideMainViewController: BaseViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    lazy var vc1: UIViewController = {
        let vc = GuideWithImageViewController(image: Image.guide1)
        return vc
    }()
    
    lazy var vc2: UIViewController = {
        let vc = GuideWithImageViewController(image: Image.guide2)
        return vc
    }()
    
    lazy var vc3: UIViewController = {
        let vc = GuideWithImageViewController(image: Image.guide3)
        return vc
    }()
    
    lazy var vc4: UIViewController = {
        let vc = GuideWithButtonViewController(image: Image.guide4)
        return vc
    }()
    
    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2, vc3, vc4]
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        return vc
    }()
    
    private func configure() {
        view.addSubview(pageViewController.view)
        
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)
        
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
}

extension GuideMainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}

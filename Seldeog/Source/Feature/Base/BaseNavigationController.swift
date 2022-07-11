//
//  BaseNavigationController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/08.
//

import UIKit


public class BaseNavigationController: UINavigationController {
    
    public override var title: String? {
        didSet { self.titleLabel.text = title }
    }
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .nanumPen(size: 35, family: .bold)
        return label
    }()
    
    public init(title: String? = nil, rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.title = title
    }
    
    public init(title: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        setProperties()
    }
    
    private func setProperties() {
        setNavigationBarAppearance()
    }
    
    private var backButtonAppearance: UIBarButtonItemAppearance = {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0.0)]

        return backButtonAppearance
    }()
    
    private var backButtonImage: UIImage? {
        return Image.arrowLeftIcon.withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -12.0, bottom: 5.0, right: 0.0))
    }
    
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.setBackIndicatorImage(backButtonImage,
                                         transitionMaskImage: backButtonImage)
        appearance.shadowColor = nil
        appearance.backButtonAppearance = backButtonAppearance
        
        navigationBar.tintColor = UIColor.black
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }

    private lazy var fullWidthBackGestureRecognizer = UIPanGestureRecognizer()
}


extension BaseNavigationController {
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        setNavigationBarItem()
    }
    
    public override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        setNavigationBarItem()
    }

    private func setNavigationBarItem() {
        titleLabel.text = title
        navigationBar.topItem?.titleView = titleLabel
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

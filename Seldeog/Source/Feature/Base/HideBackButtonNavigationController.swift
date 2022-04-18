//
//  HideBackButtonNavigationController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/16.
//

import UIKit


public class HideBackButtonNavigationController: UINavigationController {
    
    //  MARK: - 외부에서 지정할 수 있는 속성
    
    /**
     RootViewController의 NavigationBar 상단에 들어가는
     굵은 Title의 String입니다.
     */
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
    
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        
        navigationBar.tintColor = UIColor.black
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }

    private lazy var fullWidthBackGestureRecognizer = UIPanGestureRecognizer()
}


extension HideBackButtonNavigationController {
    
    /**
     ViewController가 Push될 때
     count가 1이라면(=root밖에 없다면) 굵은 titleLabel을 세팅합니다.
     count가 1이 아니라면(=root 이외에 다른게 있다면) backBarButtonItem을 초기화하여
     backButton 옆에 상위 viewController의 title이 나타나지 않도록 합니다.
     */
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

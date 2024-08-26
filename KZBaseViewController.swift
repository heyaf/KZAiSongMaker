//
//  KZBaseViewController.swift
//  KZAiSongMaker
//
//  Created by hebert on 2024/8/26.
//

import UIKit

class KZBaseViewController: UIViewController {
    
    private let baseMainColor: UIColor = .black
    
    lazy var backBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 6, width: 55, height: 30)
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        button.isHighlighted = false
        button.backgroundColor = baseMainColor
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 15, bottom: 2, right: 15)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = baseMainColor
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        guard let navigationController = navigationController else { return }
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = baseMainColor
        appearance.shadowColor = baseMainColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.leftBarButtonItem = nil
        navigationController.navigationBar.addSubview(backBtn)
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backBtn.isHidden = navigationController?.countOfViewControllersOnStack() ?? 1 <= 1
    }
}

extension UINavigationController {
    func countOfViewControllersOnStack() -> Int {
        var count = viewControllers.count
        var currentNavController = presentedViewController as? UINavigationController
        while let navController = currentNavController {
            count += navController.viewControllers.count
            currentNavController = navController.presentedViewController as? UINavigationController
        }
        return count
    }
}

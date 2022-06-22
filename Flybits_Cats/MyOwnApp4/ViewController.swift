//
// ViewController.swift
// MyOwnApp
//
// Created by Gray Yang on 2022-06-014.
//
import UIKit


class ViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x:0,y:0,width: 300,height: 52))
        button.setTitle("Welcome to Flybits Onboarding App", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    @objc override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
 
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton),for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
    }
    
    
    @objc func didTapButton() {
        //Create and present tab bar controller
        let tabBarVC = UITabBarController()
        let vc1 = UINavigationController(rootViewController: TableViewController())
        let vc2 = UINavigationController(rootViewController: CollectionViewController())
        let vc3 = UINavigationController(rootViewController: EmptyViewController())
        vc1.title = "TableViewController"
        vc2.title = "CollectionViewController"
        vc3.title = "EmptyViewController"
        tabBarVC.setViewControllers([vc1,vc2,vc3], animated: false)
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let images = ["star", "bell", "person.circle"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
     
}
/*
class TableViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "TableViewController"
    }
}
*/
/*
class CollectionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "CollectionViewController"
    }
}
 */

class EmptyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "EmptyViewController"
    }
}



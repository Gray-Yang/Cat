//
//  DetailViewController.swift
//  MyOwnApp
//
//  Created by Gray Yang on 2022-06-13.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let items: [String]
    
    //INIT
    
    init(items: [String]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var mainStackView: UIStackView = UIStackView()
    var stackView1: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.autolayoutMainStackView()
        self.autolayoutStackView1()
    }
    
    func didReceieveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    private func autolayoutMainStackView(){
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:10).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-10).isActive = true
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor,constant:70).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:-70).isActive = true
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 10
    }
    
    
    
    private func autolayoutStackView1(){
        //stackView1 setting
        mainStackView.addArrangedSubview(stackView1)
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.axis = .vertical
        stackView1.alignment = .center
        stackView1.distribution = .fillEqually
        stackView1.spacing = 10
        
        for element in items{
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = element
            //print(element)
            stackView1.addArrangedSubview(label)
        }
        
    }
}

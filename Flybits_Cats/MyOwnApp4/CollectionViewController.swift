//
//  ViewController.swift
//  MyOwnApp
//
//  Created by Gray Yang on 2022-06-14.
//

import UIKit

class CollectionViewController: UIViewController {
    private var data: [UIColor] = []
    private var tableData: [Cat] = []
    
    // a property to hold the collectionView
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
        
        
        checkNum { [self] catlist in
            for element in catlist {
                var list: [String] = []
                list.append("verified: "+String(element.status.verified))
                list.append("sentCount: "+String(element.status.sentCount))
                list.append("_id: "+String(element._id))
                list.append("user: "+String(element.user))
                list.append("text: "+String(element.text))
                list.append("__v: "+String(element.__v))
                list.append("source: "+String(element.source))
                list.append("updatedAt: "+String(element.updatedAt))
                list.append("type: "+String(element.type))
                list.append("createdAt: "+String(element.createdAt))
                list.append("deleted: "+String(element.deleted))
                list.append("used: "+String(element.used))
                
                let temp = Cat(title:"cat_id: \(element._id)", items:list)
                self.tableData.append(temp)
                self.data.append(UIColor.systemGray)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func loadView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 180, height: 180)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view = collectionView
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let cat = tableData[indexPath.row]
        
        let vc = DetailViewController(items: cat.items)
        vc.title = cat.title
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let label = UILabel(frame: CGRect(x: 10, y:35, width: 150, height: 100))
        
        label.text = self.tableData[indexPath.item].title
        cell.contentView.addSubview(label)
        
        let data = self.data[indexPath.item]
        cell.backgroundColor = data
        return cell
    }
}

private func checkNum(completionHandler: @escaping ([CatFact]) -> Void ){
    let url = "https://cat-fact.herokuapp.com/facts/"
    let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
        guard let data = data, error == nil else {
            print("something went wrong")
            return
        }

        var result: [CatFact]?
        do {
          result = try JSONDecoder().decode([CatFact].self, from: data)
        }
        catch {
          print("failed to convert \(error)")
        }
        
        guard let json = result else {
          return
        }
        //num = json.count
        completionHandler(json)
    //print(num)
  })
   
  //print(num)
  task.resume()
  //print(num)
}





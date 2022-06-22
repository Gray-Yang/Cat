//
// ViewController.swift
// MyOwnApp
//
// Created by Gray Yang on 2022-06-01.
//
import UIKit

struct Cat {
    let title: String
    let items: [String]
}

class TableViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var tableData: [Cat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
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
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cat = tableData[indexPath.row]
        
        let vc = DetailViewController(items: cat.items)
        vc.title = cat.title
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row].title
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
        //print("why5")
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

struct CatFact: Codable {
    let status: MyStatus
    let _id: String
    let user: String
    let text: String
    let __v: Int
    let source: String
    let updatedAt: String
    let type: String
    let createdAt: String
    let deleted: Bool
    let used: Bool
}

struct MyStatus: Codable {
    let verified: Bool
    let sentCount: Int
}

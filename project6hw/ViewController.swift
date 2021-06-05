//
//  ViewController.swift
//  project6hw
//
//  Created by Ярослав on 3/29/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showTextFieldAlert))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCort))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(shareButton))
        
        toolbarItems = [space,share]
        navigationController?.isToolbarHidden = false
       
        
        
        refreshCort()
    }
    
    @objc func refreshCort(){
        title = "Cort"
        itemList.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareButton(){
        let shareButton = UIActivityViewController(activityItems: [itemList.joined(separator: "\n")], applicationActivities: [])
        present(shareButton, animated: true)
    }
    
    @objc func showTextFieldAlert(){
        let ac = UIAlertController(title: "Write item you need", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let newItem = ac?.textFields?[0].text else { return }
            self?.addItem(newItem)
        }
        ac.addAction(submitAction)
        
        
        present(ac , animated: true)
    }
        
        func addItem(_ item: String){
            itemList.insert(item, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        
        cell.textLabel?.text = itemList[indexPath.row]
        
        return cell
    }
    
    

}


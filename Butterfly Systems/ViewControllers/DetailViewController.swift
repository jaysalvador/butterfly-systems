//
//  DetailViewController.swift
//  Butterfly Systems
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

enum DetailSegment: Int {
    
    case item = 0
    case invoice
}

class DetailViewController: UITableViewController {
    
    private var viewModel: DetailViewModelProtocol?
    
    // MARK: - Setup
    
    private func setupViewModel() {
        
        self.viewModel?.onUpdated = { [weak self] in
            
            self?.tableView.reloadData()
        }
        
        self.viewModel?.onError = { [weak self] in
                       
           DispatchQueue.main.async {
               
               let error = self?.viewModel?.error
               
               let alert = UIAlertController(title: error?.title, message: error?.errorDescription, preferredStyle: .alert)
               
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               
               self?.present(alert, animated: true, completion: nil)
           }
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupViewModel()
        
        self.viewModel?.getItems()
        
        self.title = "Order \(self.viewModel?.order.id?.intValue ?? 0)"

        let button1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTouchUpInside(_:)))
        
        self.navigationItem.rightBarButtonItem = button1
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let item = viewModel?.items?[indexPath.row],
            let cell = tableView.dequeueReusable(cell: DetailCell.self, for: indexPath) {
            
            return cell.prepare(item: item)
        }
        
        return OrderCell()
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTouchUpInside(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
                
        alertController.addTextField { (textField) in
            
            textField.placeholder = "Quantity"
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(
            UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
                
                if let text = alertController.textFields?.first?.text,
                    let number = Int(text) {

                    self?.viewModel?.newItem(number)
                }
            })
        )
        
        alertController.addAction(
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        )
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        self.viewModel?.segment = DetailSegment(rawValue: sender.selectedSegmentIndex) ?? .item
        
        self.navigationItem.rightBarButtonItem?.isEnabled = self.viewModel?.segment == .item
        
        self.viewModel?.getItems()
    }
}

extension DetailViewController {
    
    /// Creates a new `DetailViewController` with injectable `DetailViewModel`
    /// - Parameter viewModel: `DetailViewModel` object adhering to `DetailViewModelProtocol`
    class func make(withViewModel viewModel: DetailViewModelProtocol) -> DetailViewController? {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {

            vc.viewModel = viewModel
            
            return vc
        }
        
        return nil
    }
}

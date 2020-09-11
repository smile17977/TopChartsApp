//
//  TopChartsTableViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 16.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol TopChartsTableViewControllerProtocol: class {
    
    func reloadTableView()
}

class TopChartsTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var userName: String!
    var urlString: String!
    
    private var mediaProduct: MediaProduct!
    
    private var presenter: TopChartsPresenterProtocol!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = TopChartsPresenter.init(view: self)
        presenter.getData(from: urlString)
        setupNavigationBar()
        view.backgroundColor = Colors.lightGreen
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getMediaCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MediaProductTableViewCell
        let cellPresenter = presenter.cellPresenter(for: indexPath, for: cell)
        
        cell.presenter = cellPresenter
   
        return cell
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
        let mediaProductVC = segue.destination as! MediaProductViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            mediaProductVC.result = presenter.results[indexPath.row]
        }
    }
    
    // MARK: Setup Navigation Bar
    
    private func setupNavigationBar() {
        title = userName
        
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        navBar?.backgroundColor = Colors.lightGreen
    }
}

extension TopChartsTableViewController: TopChartsTableViewControllerProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}


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
    func startActivityIndicator()
    func stopActivityIndicator()
}

class TopChartsTableViewController: UITableViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var userName: String!
    
    private var mediaProduct: MediaProduct!
    
    private var presenter: TopChartsPresenterProtocol!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TopChartsPresenter.init(view: self)
        presenter.getData()
        setupNavigationBar()
        
        view.backgroundColor = .opaqueSeparator
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getMediaCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MediaProductTableViewCell
        presenter.configurateCell(cell, index: indexPath.row)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
        let mediaProductVC = segue.destination as! MediaProductViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
//            mediaProductVC.result = mediaProduct?.feed.results[indexPath.row]
            mediaProductVC.result = presenter.results[indexPath.row]
        }
    }
    
    // MARK: Setup Navigation Bar
    
    private func setupNavigationBar() {
        title = userName
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .opaqueSeparator
    }
    
}

extension TopChartsTableViewController: TopChartsTableViewControllerProtocol {
    
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

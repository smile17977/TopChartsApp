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
    func showMediaProductVC(with result: Result)
}

class TopChartsTableViewController: UITableViewController {
    
    // MARK: Properties
    var userName: String!
    var urlString: String!
    
    var presenter: TopChartsPresenterProtocol!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        view.backgroundColor = Colors.lightGreen
    }
    
    // MARK: Setup Navigation Bar
    private func setupNavigationBar() {
        title = userName

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = Colors.lightGreen
        navBarAppearance.titleTextAttributes = [.foregroundColor: Colors.orange]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Colors.orange]
        
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        navBar?.standardAppearance = navBarAppearance
        navBar?.scrollEdgeAppearance = navBarAppearance
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return presenter.getMediaCount()
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! MediaProductTableViewCell
        presenter.configureCell(for: indexPath, for: cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.moveToMediaProductVC(indexPath: indexPath)
    }
}

// MARK: TopChartsTableViewControllerProtocol
extension TopChartsTableViewController: TopChartsTableViewControllerProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showMediaProductVC(with result: Result) {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let mediaProductVC = storyboard
            .instantiateViewController(identifier: "MediaProductVC") as! MediaProductViewController
        mediaProductVC.presenter = MediaProductPresenter.init(view: mediaProductVC,
                                                              result: result)
        self.navigationController?.pushViewController(mediaProductVC,
                                                      animated: true)
    }
}


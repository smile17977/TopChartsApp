//
//  TopChartsPresenter.swift
//  TopChartsApp
//
//  Created by Kir Pir on 25.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation


protocol TopChartsPresenterProtocol {
    
    init(view: TopChartsTableViewControllerProtocol)
    
    var results: [Result] { get }
    
    func getData(from url: String)
    func getMediaCount() -> Int
    
    func cellPresenter(for indexPath: IndexPath, for view: MediaProductTableViewCellProtocol ) -> MediaProductTableViewCellPresenterPorotocol?
}

class TopChartsPresenter: TopChartsPresenterProtocol {
        
    private unowned let view: TopChartsTableViewControllerProtocol
    
    var mediaProduct: MediaProduct?
    
    var results: [Result] {
        mediaProduct?.feed.results ?? []
    }
    
    required init(view: TopChartsTableViewControllerProtocol) {
        self.view = view
    }
    
    func getData(from url: String) {
        NetworkManager.shared.fetchData(from: url) { (mediaProduct) in
            DispatchQueue.main.async {
                self.mediaProduct = mediaProduct
                self.view.reloadTableView()
            }
        }
    }
    
    func getMediaCount() -> Int {
        return mediaProduct?.feed.results.count ?? 0
    }
    
    func cellPresenter(for indexPath: IndexPath,
                       for viewCell: MediaProductTableViewCellProtocol ) -> MediaProductTableViewCellPresenterPorotocol? {
        viewCell.cellColor(color: Colors.darkGreenCell)
        let result = results[indexPath.row]
        return MediaProductTableViewCellPresenter(result: result,
                                                  viewCell: viewCell)
    }
    
}

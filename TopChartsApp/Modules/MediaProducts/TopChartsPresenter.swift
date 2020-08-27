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
    
    func getData()
    func getMediaCount() -> Int
    func configurateCell(_ cell: MediaProductTableViewCellProtocol, index: Int)

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
    
    func getData() {
        NetworkManager.shared.fetchData(from: Requests.mediaProjectURL) { (mediaProduct) in
            DispatchQueue.main.async {
                self.mediaProduct = mediaProduct
                self.view.reloadTableView()
            }
        }
    }
    
    
    
    func getMediaCount() -> Int {
        return mediaProduct?.feed.results.count ?? 0
    }
    
    func configurateCell(_ cell: MediaProductTableViewCellProtocol, index: Int) {
        self.view.startActivityIndicator()
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                cell.display(name: self.mediaProduct?.feed.results[index].name ?? "")
                cell.cellColor(color: .opaqueSeparator)
                self.view.stopActivityIndicator()
            }
            cell.display(stringURL: self.mediaProduct?.feed.results[index].artworkUrl100 ?? "")
        }
    }
}

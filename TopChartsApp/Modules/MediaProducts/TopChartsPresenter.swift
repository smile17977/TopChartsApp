//
//  TopChartsPresenter.swift
//  TopChartsApp
//
//  Created by Kir Pir on 25.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation


protocol TopChartsPresenterProtocol {
    
    init(view: TopChartsTableViewControllerProtocol, stringURL: String)

    func getMediaCount() -> Int
    func moveToMediaProductVC(indexPath: IndexPath)
    func configureCell(for indexPath: IndexPath, for cell: MediaProductTableViewCell)
}

class TopChartsPresenter: TopChartsPresenterProtocol {
        
    private unowned let view: TopChartsTableViewControllerProtocol
    
    private var stringURL : String
    private var mediaProduct: MediaProduct?
    
    private var results: [Result] {
        mediaProduct?.feed.results ?? []
    }
    
    required init(view: TopChartsTableViewControllerProtocol, stringURL: String) {
        self.view = view
        self.stringURL = stringURL
        getData()
    }
    
    func getMediaCount() -> Int {
        return mediaProduct?.feed.results.count ?? 0
    }
    
    func configureCell(for indexPath: IndexPath, for cell: MediaProductTableViewCell) {
        let result = results[indexPath.row]
        guard let imageURL = result.artworkUrl100 else { return }
        guard let name = result.name else { return }
        
        ImageManager.shared.fetchImage(stringURL: imageURL) { (image) in
            cell.setDefaultImage()
            cell.setImage(for: image)
        }
        cell.cellColor(color: Colors.darkGreenCell)
        cell.setLabel(name: name)
    }
    
    func getData() {
        NetworkManager.shared.fetchData(from: stringURL) { (mediaProduct) in
            DispatchQueue.main.async {
                self.mediaProduct = mediaProduct
                self.view.reloadTableView()
                print(mediaProduct)
            }
        }
    }
    
    func moveToMediaProductVC(indexPath: IndexPath) {
        view.showMediaProductVC(with: results[indexPath.row])
    }
}

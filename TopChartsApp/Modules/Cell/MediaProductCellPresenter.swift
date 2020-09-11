//
//  MediaProductCellPresenter.swift
//  TopChartsApp
//
//  Created by Kir Pir on 27.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol MediaProductTableViewCellPresenterPorotocol {
    var imageData: String { get }
    var resultName: String { get }
    init(result: Result, viewCell: MediaProductTableViewCellProtocol)
    func getImage()
}

class MediaProductTableViewCellPresenter: MediaProductTableViewCellPresenterPorotocol {
    
    let result: Result
    
    var view: MediaProductTableViewCellProtocol!
    
    required init(result: Result,
                  viewCell: MediaProductTableViewCellProtocol) {
        self.result = result
        self.view = viewCell
    }
    
    func getImage() {
        view.setDefaultImage()
        ImageManager.shared.fetchImage(stringURL: imageData) { (image) in
            self.view.setImage(for: image)
        }
    }
    
    var imageData: String {
        result.artworkUrl100 ?? ""
    }
    
    var resultName: String {
        result.name ?? ""
    }
}

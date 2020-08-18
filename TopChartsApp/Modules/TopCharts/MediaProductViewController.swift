//
//  MediaProductViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 18.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

class MediaProductViewController: UIViewController {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    
    var logoImage: UIImage!
    var name: String!
    var artistName: String!
    var genres: String!
    
    var result: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = result.name
        
        guard let stringURL = result.artworkUrl100 else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        
        DispatchQueue.main.async {
            self.logoImageView.image = UIImage(data: imageData)
            
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

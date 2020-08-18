//
//  TopChartsTableViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 16.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

class TopChartsTableViewController: UITableViewController {
    
//    var results: [Result] = []
    var mediaProduct: MediaProduct?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchData(from: Requests.mediaProjectURL) { (mediaProduct) in
            DispatchQueue.main.async {
//                self.results = mediaProduct.feed.results
                self.mediaProduct = mediaProduct
                self.tableView.reloadData()
                print(self.mediaProduct?.feed.results ?? 0)
            }
        }
        
        
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mediaProduct?.feed.results.count ?? 0
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        configure(with: mediaProduct?.feed.results, for: indexPath.row, cell: cell)
        
        return cell
    }
    
    func configure(with results: [Result]?, for index: Int, cell: UITableViewCell?) {
        
        cell?.textLabel?.text = results?[index].name
        
        guard let stringURL = results?[index].artworkUrl100 else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        
        DispatchQueue.main.async {
            cell?.imageView?.image = UIImage(data: imageData)
            
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
        let mediaProductVC = segue.destination as! MediaProductViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            mediaProductVC.result = mediaProduct?.feed.results[indexPath.row]
            
            
        }
        
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//
//  ViewController.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class ViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var mobilesToDisplay = [MobileViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var allMobiles = [MobileViewModel]()
    
    @IBAction func didTapSortButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapListToggleControl(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
            
        case 0:
            // Tapped on all segment
            showFavourites = false
        case 1:
            // Tapped on favourites segment
            showFavourites = true
        default:
            print("Unknown segment index")
        }
    }
    
    var showFavourites : Bool = false {
        didSet{
            if (showFavourites) {
                mobilesToDisplay = allMobiles.filter() {$0.isFavourite}
            } else {
                mobilesToDisplay = allMobiles
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMobileList()
        tableView.dataSource = self
        tableView.delegate = self
    
    }
    
    private func fetchMobileList() {
        let api = MobilePhoneAPI()
        
        api.getAllMobilePhoneData() { (result) in
            switch (result) {
                case .success(let values):
                    self.allMobiles = values.compactMap(MobileViewModel.init)
                    
                    DispatchQueue.main.async {
                        self.mobilesToDisplay = self.allMobiles
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobilesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell", for: indexPath) as! MobileCell
        
        cell.configure(mobileViewModel: mobilesToDisplay[indexPath.row])
        cell.accessoryType = .detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = mobilesToDisplay[indexPath.row]
        print("tapped on \(vm.modelName)")
        vm.isFavourite = !vm.isFavourite
    }
}

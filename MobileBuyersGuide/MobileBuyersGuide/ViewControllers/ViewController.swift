//
//  ViewController.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol MobileListDelegate : class {
    func didTapFavourite(with index : Int)
}

class ViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, MobileListDelegate {
    
    var mobilesToDisplay = [MobileViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private(set) var allMobiles = [MobileViewModel]()
    
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
                DispatchQueue.main.async {
                    self.allMobiles = values.compactMap(MobileViewModel.init)
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
        
        let viewModel = mobilesToDisplay[indexPath.row]
        cell.configure(mobileViewModel: viewModel, index: indexPath.row)
        cell.delegate = self
        
        cell.setFavouriteButtonState(hidden: showFavourites)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = mobilesToDisplay[indexPath.row]
        print("tapped on: \(vm.modelName).  should enter detail view")
    }
    
    func didTapFavourite(with index: Int) {
        mobilesToDisplay[index].isFavourite.toggle()
        let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! MobileCell
        cell.setFavouriteButtonImage(favourite: mobilesToDisplay[index].isFavourite)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return showFavourites
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            mobilesToDisplay[indexPath.row].isFavourite.toggle()
            mobilesToDisplay.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}

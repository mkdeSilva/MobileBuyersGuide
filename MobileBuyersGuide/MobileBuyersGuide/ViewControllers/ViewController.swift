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
    
    private var mobileList : MobilePhonesList = MobilePhonesList(mobiles: [], showFavourites: false)
    
    @IBAction func didTapSortButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapListToggleControl(_ sender: UISegmentedControl) {
        
        switch(sender.selectedSegmentIndex) {
        case 0:
            // Tapped on all segment
            mobileList.showFavourites = false
            tableView.reloadData()
        case 1:
            // Tapped on favourites segment
            mobileList.showFavourites = true
            tableView.reloadData()
        default:
            print("Unknown segment index")
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMobileList()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    let api = MobilePhoneAPI()
    
    private func fetchMobileList() {
        api.getAllMobilePhoneData() { [unowned self] (result) in
            switch (result) {
            case .success(let values):
                self.mobileList = MobilePhonesList(mobiles: values.compactMap(MobileViewModel.init), showFavourites: false)
                self.getMobileImages()
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getMobileImages() {
        for mobile in mobileList.allMobiles {
            api.getImage(urlString: mobile.imageUrl) { [unowned self] (result) in
                switch(result) {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        print("Bad data for thumbnail image for \(mobile.modelName)")
                        return
                    }
                    DispatchQueue.main.async {
                        mobile.setImage(image)
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobileList.mobilesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell", for: indexPath) as! MobileCell
        
        let viewModel = mobileList.mobilesToDisplay[indexPath.row]
        cell.configure(mobileViewModel: viewModel, index: indexPath.row)
        cell.delegate = self
        
        cell.setFavouriteButtonState(hidden: mobileList.showFavourites)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = mobileList.mobilesToDisplay[indexPath.row]
        print("tapped on: \(vm.modelName).  should enter detail view")
    }
    
    func didTapFavourite(with index: Int) {
        mobileList.mobilesToDisplay[index].isFavourite.toggle()
        let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! MobileCell
        cell.setFavouriteButtonImage(favourite: mobileList.mobilesToDisplay[index].isFavourite)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return mobileList.showFavourites
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            mobileList.mobilesToDisplay[indexPath.row].isFavourite.toggle()
            mobileList.mobilesToDisplay.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

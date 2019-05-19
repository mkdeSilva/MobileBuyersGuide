//
//  DetailViewController.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailView: DetailView!
    
    private var currentViewModel :  MobileViewModel?
    
    let api = MobilePhoneAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let viewModel = currentViewModel else {
            return
        }
        
        configure(with: viewModel)
    }
   
    func configure(with viewModel : MobileViewModel) {
        if (viewModel.detailViewModel != nil) {
            print("Already have detail view model")
            if (detailView != nil) {
                detailView.configure(with: viewModel)
            } else {
                currentViewModel = viewModel
            }
            return
        }
        
        api.getMobileDetail(mobileID: viewModel.mobileId) { [unowned self] (result) in
            switch (result) {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let details):
                self.getDetailImages( for: viewModel,  urlStrings: details.map() { $0.url } )
            }
        }
    }
    
    private func getDetailImages(for viewModel: MobileViewModel, urlStrings : [String]) {
        let detailViewModel = DetailViewModel()
        
        viewModel.detailViewModel = detailViewModel
        
        for urlString in urlStrings {
            api.getImage(urlString: urlString) { [unowned self] (result) in
                switch(result) {
                case .failure(let error):
                    print("Failed to get image: \(error.localizedDescription)")
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        print("Cannot get image from data")
                        return
                    }
                    DispatchQueue.main.async {
                        detailViewModel.images.append(image)
                        self.detailView.configure(with: viewModel)
                    }
                }
            }
        }
    }
}

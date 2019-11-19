//
//  SpecificBeerViewController.swift
//  BeerAPI
//
//  Created by Euijoon Jung on 16/11/2019.
//  Copyright © 2019 Euijoon Jung. All rights reserved.
//

import UIKit
import Kingfisher


class SpecificBeerViewController: UIViewController {

    static let storyBoardID = "specificBeerVC"
    
    @IBOutlet weak var beerImage: UIImageView!
    var viewModel: SpecificBeerViewModel?
    
    
    @IBOutlet weak var paringFood: UILabel!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()        
        initLayout()
    }
  
    func initLayout() {
        guard let beer = viewModel?.selectedBeer else {
            self.dismiss(animated: false, completion: nil)
            return
        }
        
        print(beer.name)
        guard let imageUrlStr = beer.imageURL, let imageUrl = try URL(string: imageUrlStr) else {
            self.dismiss(animated: false, completion: nil)
            return
        }
        
        beerImage.kf.setImage(with: imageUrl)
        beerName.text = beer.name
        
        
        beerDescription.isUserInteractionEnabled = false
        beerDescription.translatesAutoresizingMaskIntoConstraints = false
        beerDescription.text = beer.beerDataDescription

        paringFood.text = beer.foodPairing.joined(separator: "  ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.title = "Main"
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}

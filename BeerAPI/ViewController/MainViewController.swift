//
//  ViewController.swift
//  BeerAPI
//
//  Created by Euijoon Jung on 16/11/2019.
//  Copyright © 2019 Euijoon Jung. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var randomButton: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var viewModel: MainViewModel?
    
    var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        
        viewModel = MainViewModel()
        viewModel?.delegate = self
        viewModel?.getBeers()
    }
    
    func initLayout() {
        self.navigationController?.navigationBar.topItem?.title  = "Find My Own Beer"
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "MainBeerTableViewCell", bundle: nil), forCellReuseIdentifier: MainBeerTableViewCell.cellId)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapRandomButton))
        randomButton.isUserInteractionEnabled = true
        randomButton.addGestureRecognizer(tapGestureRecognizer)
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        self.view.addSubview(indicator)
        indicator.center = self.view.center
        indicator.style = .large
        indicator.layer.cornerRadius = 15.0
        indicator.showsLargeContentViewer = true
        indicator.backgroundColor = UIColor.lightGray
        indicator.alpha = 0.9
        
            
        
    }

    @objc func didTapRandomButton() {
//        randomButton.backgroundColor = UIColor.gray
        indicator.startAnimating()
        viewModel?.getRandomBeer()
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.beers.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainBeerTableViewCell.cellId) as? MainBeerTableViewCell, let beers = viewModel?.beers else {
            return UITableViewCell()
        }
        let beer = beers[indexPath.row]
        
        guard let imageURLStr = beer.imageURL, let imageUrl = try URL(string: imageURLStr) else {
            return UITableViewCell()
        }
        cell.beerImage?.kf.setImage(with: imageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            if error != nil {
                cell.imageView?.backgroundColor = UIColor.gray // blank image
            }
        })
        
        cell.beerImage.contentMode = .scaleAspectFit
        cell.beerName.text = beer.name
        cell.beerDescription.text = beer.beerDataDescription
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        guard let vc = storyBoard.instantiateViewController(identifier: SpecificBeerViewController.storyBoardID) as? SpecificBeerViewController else {
             return
        }

        
        guard let selectedBeer = viewModel?.beers[indexPath.row] else { return }
        
        vc.viewModel = SpecificBeerViewModel(beer: selectedBeer)
        
//        self.show(vc, sender: self)
        self.present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let endOfPage = viewModel?.beers.count else { return }

        if section + 5 == endOfPage {
            print(#function)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let beerCount = viewModel?.beers.count else { return }
        if indexPath.row + 5 == beerCount {            
            let nextPage = (beerCount / 25) + 1
            viewModel?.getBeers(nextPage)
        }
        
    }
}

extension MainViewController: MainBeerViewDelegate {
    func didGetRandomBeer(_ beer: BeerData) {
//        randomButton.backgroundColor = UIColor.white
        indicator.stopAnimating()
        guard beer.validationCheck() else {
            self.didTapRandomButton()
            return
        }
        
        guard let vc = storyBoard.instantiateViewController(identifier: SpecificBeerViewController.storyBoardID) as? SpecificBeerViewController else { return }
        vc.viewModel = SpecificBeerViewModel(beer: beer)
        
//        self.show(vc, sender: self)
        self.present(vc, animated: true, completion: nil)
    }
    
    func didGetBeers() {
        tableView.reloadData()
    }
}

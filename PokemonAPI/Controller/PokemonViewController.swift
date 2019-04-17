//
//  PokemonViewController.swift
//  pokemon
//
//  Created by Jann Aleli Zaplan on 12/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import UIKit

public class PokemonViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var dataSource: [UIImage] = []
     var initial: [String] = []
    @IBOutlet weak var collectioView: UICollectionView?
    

    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let reuseIdentifier = "PokemonCell"
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCell
        cell.backgroundColor = .black
     
        let image = self.dataSource[indexPath.row]
           cell.imageCell?.image = image
  
        
        // Configure the cell
        return cell
        
    }
    
    public func setDataSource() {
        PokemonRoute().getPokemonImages(completionBlock: {
            data, error in

            if error == nil {
                self.initial = data as! [String]
                
            self.loadinBackground()
            }
            
        })
    }
    
    public func loadinBackground() {
        for each in self.initial {
            
            
            PokemonRoute().sendRequestForImage(url: each, completionBlock: {
                data, error in
                self.dataSource.append(data as! UIImage)
                self.collectioView?.reloadData()
            })
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setDataSource()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

//
//  MostPopularCollectionViewCell.swift
//  MovieApplication
//
//  Created by Hilal Karadas on 9.08.2023.
//

import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "MostPopularCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MostPopularCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=f6623503dead1c4fbf323c1814eff5b0")
    
    }
        
        
        
        
    
    func setValueTR(data:TRResult){

        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "http://image.tmdb.org/t/p/w500\(data.posterPath)")!)){(data,request,error) in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
            self.imageView.image = UIImage(data: data)
            }
            
            
        }
        .resume()
    }
}


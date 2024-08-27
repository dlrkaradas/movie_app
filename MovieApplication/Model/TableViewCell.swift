//
//  TableViewCell.swift
//  MovieApplication
//
//  Created by Hilal Karadas on 8.08.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    // VARİABLES
    @IBOutlet var puan: UILabel!
    @IBOutlet var movieText: UILabel!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var langs: UILabel!
    static let identifier = "cell"
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
    
    // FUNC
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setValue(data:TRResult){
        movieName.text=data.title
        movieText.text=data.overview
        date.text=data.releaseDate
        langs.text=data.originalLanguage
        puan.text=String(data.voteAverage)
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "http://image.tmdb.org/t/p/w500\(data.posterPath)")!)){(data,request,error) in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.movieImage.image = UIImage(data: data)
            }
            
            
        }
        .resume()
    }
}

//  SearchTableViewCell.swift
//  MovieApplication
//
//  Created by Hilal Karadas on 11.08.2023.

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var searchMovieName: UILabel!
    @IBOutlet var searchImage: UIImageView!
    static let identifier = "SearchTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    func setSearchValue(data : SearchResult ){
        self.searchMovieName.text = data.title
//        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "http://image.tmdb.org/t/p/w500\(data.posterPath)")!)){(data,request,error) in
//            guard let data = data else { return }
//            DispatchQueue.main.async {
//            self.searchImage.image = UIImage(data: data)
//           }


       }
//       .resume()
   }
//}


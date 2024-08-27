//
//  DetailsViewController.swift
//  MovieApplication
//
//  Created by Hilal Karadas on 13.08.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    var id : Int = 0
    
    //     MARK VARİABLES
    var similar = [TRResult]()
    @IBOutlet var similarMovies: UICollectionView!
    @IBOutlet var movieLabel: UILabel!
    @IBOutlet var movieDate: UILabel!
    @IBOutlet var MovieImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    var movie: Details?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.similarMovies.delegate=self
        self.similarMovies.dataSource=self
        similarMovies.register(MostPopularCollectionViewCell.nib(), forCellWithReuseIdentifier: MostPopularCollectionViewCell.identifier)
            fetchSimilarMovies()
        fetchMovieDetails()
    }
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func playButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toMoviePlayerVC", sender: nil)
    }
    
    func fetchMovieDetails(){
        
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=f6623503dead1c4fbf323c1814eff5b0")!)){(data,request,error) in
            
            do{
                let sonuc = try JSONDecoder().decode(Details.self, from: data!)
                DispatchQueue.main.async {
                    self.movie = sonuc
                    self.similarMovies.reloadData()
                    self.movieLabel.text = sonuc.overview
//                    self.movieImage.image = sonuc.backdropPath
                    self.movieName.text=sonuc.title
                    
                }
            }
            catch{
                print("hata")
            }
        }.resume()
        
    }
        
        
    
    
    func fetchSimilarMovies() {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=f6623503dead1c4fbf323c1814eff5b0")!)){(data,request,error) in
            
            do{
                let sonuc = try JSONDecoder().decode(TRMovieResult.self, from: data!)
                DispatchQueue.main.async {
                    self.similar = sonuc.results
                    self.similarMovies.reloadData()
                }
            }catch{
                print("hata")
            }
            
        }.resume()
    }
}


// MARK EXTENSİON

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MostPopularCollectionViewCell.identifier, for: indexPath) as? MostPopularCollectionViewCell {
            cell.setValueTR(data: similar[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}

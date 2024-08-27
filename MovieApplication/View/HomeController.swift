//
//  HomeController.swift
//  MovieApplication
//
//  Created by Hilal Karadas on 3.08.2023.
//
import Foundation
import UIKit


class HomeController: UIViewController {
    
    //  MARK -- VARİABLES
    var movieIDTable: Int = 0
    var movieIDCollection: Int = 0
    var movieList = [TRResult]()
    var topRated = [TRResult]()
    @IBOutlet var mostPopularCollectionView: UICollectionView!
    @IBOutlet var table: UITableView!
    
    
    
    //    MARK -- LİFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        //        alt kısımdaki Popular filmler için
        table.delegate = self
        table.dataSource = self
        table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        //    üst kısımdaki most popular filmler için
        mostPopularCollectionView.dataSource = self
        mostPopularCollectionView.delegate = self
        mostPopularCollectionView.register(MostPopularCollectionViewCell.nib(), forCellWithReuseIdentifier: MostPopularCollectionViewCell.identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMoviesForPopular()
        fetchMoviesForMostPopular()
    }
    
    
    //  MARK --  FUNCTİONS
    
    func fetchMoviesForPopular() {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=f6623503dead1c4fbf323c1814eff5b0")!)){(data,request,error) in
            do{
                let sonuc = try JSONDecoder().decode(TRMovieResult.self, from: data!)
                DispatchQueue.main.async {
                    self.movieList = sonuc.results
                    self.table.reloadData()
                    
                }
            }catch{
                print("hata popular movies")
            }
            
        }.resume()
    }
    
    func fetchMoviesForMostPopular() {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=f6623503dead1c4fbf323c1814eff5b0")!)){(data,request,error) in
            
            do{
                let sonuc = try JSONDecoder().decode(TRMovieResult.self, from: data!)
                DispatchQueue.main.async {
                    self.topRated = sonuc.results
                    self.mostPopularCollectionView.reloadData()
                }
            }catch{
                print("hata top rated")
            }
            
        }.resume()
    }
    
    //    DetailsVC'de tıklanılan filmin verilerini görmek için filmin idsini alıyoruz
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if movieIDTable != 0{
            if segue.identifier == "TVtoDetails"   {
                let destination = segue.destination as! DetailsViewController
                destination.id = movieIDTable
            } else if movieIDCollection != 0{
                if segue.identifier == "CVtoDetails" {
                    let destination = segue.destination as! DetailsViewController
                    destination.id = movieIDCollection }
                
            } else{ print("hata segue")}
        }
        
    }
}


// MARK-- Extension

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell{
            cell.setValue(data: movieList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsMovieId = movieList[indexPath.row].id
        self.movieIDTable = detailsMovieId
        performSegue(withIdentifier: "TVtoDetails", sender: nil)
    }
}



extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topRated.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MostPopularCollectionViewCell.identifier, for: indexPath) as? MostPopularCollectionViewCell {
            cell.setValueTR(data: topRated[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsMovieId = topRated[indexPath.row].id
        self.movieIDCollection = detailsMovieId
        performSegue(withIdentifier: "CVtoDetails", sender: nil)
    }
    
}






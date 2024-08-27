//
//  SearchController.swift
//  MovieApplication
//
//  Created by Hilal Karadas on 3.08.2023.
//

import UIKit
import Parse

class SearchController: UIViewController , UISearchBarDelegate {
    
    //     VARİABLES
    var SearchList = [TRResult]()
    var filteredList:[String]=[]
    var date : String = ""
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var searchtext : String = ""



    //    LİFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate=self
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        ifSearchBarEmtpyRequest()
    }


    //    FUNC

    func ifSearchBarIsntEmpty(searchText: String){
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=f6623503dead1c4fbf323c1814eff5b0&query=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)) {(data,request,error) in
            do{
                let sonuc = try JSONDecoder().decode(TRMovieResult.self, from: data!)
                DispatchQueue.main.async {
                    self.SearchList = sonuc.results
                    self.tableView.reloadData()
                }
            }catch{
                print("hata")
            }
            
        }.resume()
    }


    func ifSearchBarEmtpyRequest (){
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=f6623503dead1c4fbf323c1814eff5b0")!)){(data,request,error) in

            do{
                let sonuc = try JSONDecoder().decode(TRMovieResult.self, from: data!)
                DispatchQueue.main.async {
                    self.SearchList = sonuc.results
                    self.tableView.reloadData()
                   
                }
            }catch{
                print("hata")
            }

        }.resume()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            ifSearchBarEmtpyRequest()
            self.tableView.reloadData()
        }else {
            ifSearchBarIsntEmpty(searchText: searchText)
            self.tableView.reloadData()
            }
    }
}

    // EXTENSİON

    extension SearchController : UITableViewDelegate , UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            SearchList.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for:   indexPath) as! TableViewCell
            cell.setValue(data: SearchList[indexPath.row])
            return cell

        }


    }


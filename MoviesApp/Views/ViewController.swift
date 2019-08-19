//
//  ViewController.swift
//  MoviesApp
//
//  Created by ASamir on 6/28/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var moviesList : UITableView!
    //MARK:- Properties
    var viewModelObject : MoviesViewModel = MoviesViewModel()
    var currentPage : Int = 1
    var newAddedMovieArray : [MoviesResultsBasicModel] = [MoviesResultsBasicModel]()
    var newMovieImage : UIImage?
    var imageArray : [UIImage] = []
    var indicator = UIActivityIndicatorView()
    
    override func loadView() {
        super.loadView()
        //to notify data was fetched
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.onFetchingMovies(notification:)), name: .fetchingMoviesCompleted, object: nil)
        // add activity indicator
        activityIndicator()
        self.indicator.startAnimating()
        self.indicator.backgroundColor = UIColor.clear
    }
    
    //set activity indicator function
    func activityIndicator() {
        indicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        moviesList.delegate   = self
        moviesList.dataSource = self
        registerNib()
        viewModelObject.getData(page: currentPage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.moviesList.reloadData()
    }
    //register XIBs
    func registerNib(){
        moviesList.register(UINib(nibName: "AllMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllMoviesTableViewCell")
        moviesList.register(UINib(nibName: "NoMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "NoMoviesTableViewCell")
        moviesList.register(UINib(nibName: "SectionHeaderTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderTableViewCell")
        
    }
    // function to reload data after fetching data
    @objc func onFetchingMovies(notification: NSNotification){
        DispatchQueue.main.async {
            self.moviesList.reloadData()
            self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true
        }
    }
    
}
//TableView delegate and Data Source Functions
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let firstHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderTableViewCell" ) as! SectionHeaderTableViewCell
            firstHeaderView.sectionHeaderLabel.text = "My Movies"
            firstHeaderView.sectionMoreBtn.isHidden = false
            firstHeaderView.delegate = self
            return firstHeaderView
        case 1:
            let secondHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderTableViewCell" ) as! SectionHeaderTableViewCell
            secondHeaderView.sectionHeaderLabel.text = "All Movies"
            secondHeaderView.sectionMoreBtn.isHidden = true
            return secondHeaderView
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if self.newAddedMovieArray.count == 0 {
                return 1
            }else{
                return self.newAddedMovieArray.count
            }
        case 1 :
            return self.viewModelObject.movieArray.count
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if self.newAddedMovieArray.count == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoMoviesTableViewCell", for: indexPath) as! NoMoviesTableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AllMoviesTableViewCell", for: indexPath) as! AllMoviesTableViewCell
                cell.movieDate.text = self.newAddedMovieArray[indexPath.row].release_date
                cell.movieTitle.text = self.newAddedMovieArray[indexPath.row].title
                cell.movieImage.image = self.imageArray[indexPath.row]
                cell.movieOverView.text = self.newAddedMovieArray[indexPath.row].overview
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllMoviesTableViewCell", for: indexPath) as! AllMoviesTableViewCell
            
            if let data = NSData(contentsOf: URL(string: MoviesConstants.IMG_BASE_URL + viewModelObject.movieArray[indexPath.row].poster_path)!) {
                let movieImage = UIImage(data:data as Data)
                if movieImage == nil {
                    cell.movieImage.image = UIImage(named: "Image")
                }else{
                    cell.movieImage.image = UIImage(data:data as Data)
                }
                
            }
            cell.movieTitle.text = self.viewModelObject.movieArray[indexPath.row].title
            cell.movieDate.text = self.viewModelObject.movieArray[indexPath.row].release_date
            cell.movieOverView.text = self.viewModelObject.movieArray[indexPath.row].overview
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                
            }else{
                
            }
        }
        
    }
    //refresh tableView
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.moviesList {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
                
                if(self.viewModelObject.movieArray.count <= 20 * self.currentPage) {
                    
                    self.currentPage += 1
                    self.viewModelObject.getData(page: self.currentPage)
                }
            }
        }
    }
}
//navigate to Add Movies View Controller
extension ViewController : AddMoviesNavigation {
    func navigateToAddMoviesVC() {
        let addedMovieVC = UIStoryboard(name: "AddMoviesViewController", bundle: nil).instantiateViewController(withIdentifier: "AddMoviesViewController") as! AddMoviesViewController
        addedMovieVC.MovieArray =  self.newAddedMovieArray
        addedMovieVC.addedImageArray = self.imageArray
        self.navigationController?.pushViewController(addedMovieVC, animated: true)
    }
    
    
}

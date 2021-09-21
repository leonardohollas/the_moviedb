//
//  HomeViewController.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 16/09/21.
//

import UIKit
import RealmSwift

enum AlertMessage {
    case error
    case empty
}

class HomeViewController: UIViewController {

    @IBOutlet var searchMoviesTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var trendingsTableView: UITableView!
    
    private let homeManager = TMDBHomeManager()
    private var datasource: TMDBTrendingsViewModel? {
        didSet {
            trendingsTableView.reloadData()
        }
    }
    private var storedData: [MovieResponseModel]? {
        didSet {
            trendingsTableView.reloadData()
        }
    }
    
    // MARK: - > Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupComponents()
        setupDelegates()
        //Para testar cenário com internet
//        getTrendings()
        //Para testar cenário sem internet
        readStoredData()
    }
    
    func setupComponents() {
        navigationItem.title = LocaleKeys.theMovieDB
        searchMoviesTextField.placeholder = LocaleKeys.searchMovies
        titleLabel.text = LocaleKeys.popularMovies
        titleLabel.adjustsFontSizeToFitWidth = true
        trendingsTableView.tableFooterView = UIView()
    }
    
    func setupDelegates() {
        trendingsTableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: Cells.movieCell)
        trendingsTableView.delegate = self
        trendingsTableView.dataSource = self
    }
    
    func getTrendings() {
        view.showLoading()
        homeManager.getTrendings { [weak self] result, error in
            self?.view.hideLoading()
            if error != nil {
                self?.presentAlert(message: .error)
                return
            } else {
                self?.datasource = result
                self?.updateTitleLabel("")
                if result.results.count == 0 {
                    self?.presentAlert(message: .empty)
                } else {
                    self?.writeData()
                }
                return
            }
        }
    }
    
    @IBAction func searchMovieTapped(_ sender: Any) {
        guard let key = searchMoviesTextField.text else { return }
        if key == "" {
            getTrendings()
        } else {
            searchMovie(key)
        }
    }
    
    func searchMovie(_ key: String) {
        view.showLoading()
        homeManager.searchMovie(key) { [weak self] result, error in
            self?.view.hideLoading()
            if error != nil {
                self?.presentAlert(message: .error)
                return
            } else {
                self?.datasource = result
                self?.updateTitleLabel(key)
                if result.results.count == 0 {
                    self?.presentAlert(message: .empty)
                } else {
                    self?.writeData()
                }
                return
            }
        }
    }
    
    func writeData() {
        let realm = try! Realm()
        try! realm.write {
            let movies = (datasource?.results.map({
                let movie = Movie()
                movie.setValues(model: $0)
                return movie
            }) ?? []) as [Object]
            realm.add(movies, update: .modified)
        }
    }
    
    func readStoredData() {
        let realm = try! Realm()
        let movies = realm.objects(Movie.self)
        let model = movies.map({
            var movie = MovieResponseModel()
            movie.setStoredData(movie: $0)
            return movie
        }) as [MovieResponseModel]
        storedData = model
    }
    
    func updateTitleLabel(_ key: String){
        if key == "" {
            titleLabel.text = LocaleKeys.popularMovies
        } else {
            titleLabel.text = LocaleKeys.searchResultsFor + "'" + key + "'"
        }
    }
    
    func convertModel(index: Int, isStoredData: Bool) -> TMDBMovieViewModel? {
        if isStoredData {
            if let model = storedData?[index] {
                return TMDBMovieViewModel(model: model)
            }
        } else {
            if let model = datasource?.results[index] {
                return TMDBMovieViewModel(model: model)
            }
        }
        return nil
    }
    
    func presentAlert(message: AlertMessage) {
        var alert = UIAlertController()
        switch message {
        case .error:
            alert = UIAlertController(title: LocaleKeys.ops, message: LocaleKeys.tryAgain, preferredStyle: .alert)
        case .empty:
            alert = UIAlertController(title: LocaleKeys.ops, message: LocaleKeys.notFound, preferredStyle: .alert)
        
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString(LocaleKeys.ok, comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datasource == nil {
            return storedData?.count ?? 0
        } else {
            return datasource?.results.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model: TMDBMovieViewModel?
        if datasource == nil {
            model = convertModel(index: indexPath.row, isStoredData: true)
        } else {
            model = convertModel(index: indexPath.row, isStoredData: false)
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model: TMDBMovieViewModel?
        if datasource == nil {
            model = convertModel(index: indexPath.row, isStoredData: true)
        } else {
            model = convertModel(index: indexPath.row, isStoredData: false)
        }
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailsVC = mainStoryboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        detailsVC.datasource = model
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}


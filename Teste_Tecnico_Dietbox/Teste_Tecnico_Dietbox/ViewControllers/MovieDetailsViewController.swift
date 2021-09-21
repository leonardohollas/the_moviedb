//
//  MovieDetailsViewController.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 20/09/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var overviewTextView: UITextView!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var languageValueLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dateValueLabel: UILabel!
    
    var datasource: TMDBMovieViewModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureFields()
        configureInfos()
    }
    
    private func configureFields(){
        titleLabel.adjustsFontSizeToFitWidth = true
        overviewTextView.adjustsFontForContentSizeCategory = true
    }
    
    private func configureInfos() {
        guard let datasource = datasource else { return }
        movieImageView.downloadImage(NetworkConstants.URLs.imageURL + datasource.poster_path)
        titleLabel.text = datasource.title
        overviewLabel.text = LocaleKeys.overview
        overviewTextView.text = datasource.overview
        languageLabel.text = LocaleKeys.originalLanguage
        languageValueLabel.text = datasource.original_language.uppercased()
        dateLabel.text = LocaleKeys.releaseDate
        dateValueLabel.text = datasource.release_date.formatDate()
    }
    
}

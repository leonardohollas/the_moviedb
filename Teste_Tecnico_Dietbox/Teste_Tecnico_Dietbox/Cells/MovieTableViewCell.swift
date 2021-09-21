//
//  MovieTableViewCell.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 20/09/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var scoreValueLabel: UILabel!
    @IBOutlet var seeMoreLabel: UILabel!
    
    var model: TMDBMovieViewModel? {
        didSet {
            guard let model = model else { return }
            movieImageView?.downloadImage(NetworkConstants.URLs.smallImageURL + model.poster_path)
            titleLabel?.text = model.title
            scoreLabel?.text = LocaleKeys.score
            scoreValueLabel.text = "\(model.vote_average)"
            seeMoreLabel?.text = LocaleKeys.seeMore
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureFields()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: Cells.movieCell, bundle: nil)
    }
    
    func configureFields(){
        titleLabel.adjustsFontSizeToFitWidth = true
    }
}

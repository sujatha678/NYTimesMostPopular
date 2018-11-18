//
//  ArticleTableViewCell.swift
//  NYTimesMostPopular
//
//  Created by SriSarayu on 18/11/18.
//  Copyright © 2018 Sujatha. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
  
    @IBOutlet weak var thumbImage: UIImageView?
    @IBOutlet weak var articleTitleLabel: UILabel?
    @IBOutlet weak var technologyLabel: UILabel?
    @IBOutlet weak var abstractLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    
    //When the Article is assigned then the Cell UI will be configured
    var article: ArticleData? {
        didSet {
            configureCell()
        }
    }
    
    func configureCell() {
        //Check if article has value
        guard let article = article else { return }
        
        self.articleTitleLabel?.text = article.title
        self.abstractLabel?.text = article.abstract
        self.technologyLabel?.text = article.section
        guard let datestr : String = article.publishedDate else{
            return (self.dateLabel?.text = "")!
        }
        self.dateLabel?.text =  Utils.convertDateFormater(date: datestr)
       
        let meta = article.mediaImages?.first?.imagesDetails?.first(where: {$0.format == "Standard Thumbnail"})
        if let url =  URL.init(string: meta?.url ?? ""){
            self.thumbImage?.sd_setImage(with: url, placeholderImage: UIImage.init(named: "image-thumb"), options: SDWebImageOptions.highPriority) { (image, error, type, url) in
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

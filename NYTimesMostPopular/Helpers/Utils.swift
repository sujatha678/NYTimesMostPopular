//
//  Utils.swift
//  NYTimesMostPopular
//
//  Created by SriSarayu on 18/11/18.
//  Copyright © 2018 Sujatha. All rights reserved.
//

import UIKit

let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

class Utils: NSObject {
    /// Shows alert view
   
    static func showAlert(title: String, message: String, viewController : UIViewController) {
   
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        viewController .present(alert, animated: true, completion: nil)
        
    }
    /// Shows ActivityIndicator
    
    class func showActivityIndicator(viewController : UIViewController) {
        
        activityIndictor.center = viewController.view.center
        activityIndictor.activityIndicatorViewStyle = .gray
        viewController.view.addSubview(activityIndictor)

        activityIndictor.startAnimating()
    }
    
    /// Stop ActivityIndicator

    class func stopActivityIndicator() {
        activityIndictor.stopAnimating()
    }
    
    // Get height for article cell
    class func getHeight(article : ArticleData)-> CGFloat{
        var height : CGFloat = 0.0
        if let ns_str:String = article.title as String? {
            let font: [NSAttributedStringKey : UIFont] = [ NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 17.0)!]
            let sizeOfString: CGSize = ns_str.boundingRect(
                with: CGSize(width: UIScreen.main.bounds.size.width - 40, height: .greatestFiniteMagnitude),options: .usesLineFragmentOrigin,attributes:font,context: nil).size
            height = height + sizeOfString.height
            
        }
        if let ns_str:String = article.abstract as String? {
            let font: [NSAttributedStringKey : UIFont] = [ NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: 15.0)! ]
            let sizeOfString: CGSize = ns_str.boundingRect(
                with: CGSize(width: UIScreen.main.bounds.size.width - 40, height: .greatestFiniteMagnitude),options: .usesLineFragmentOrigin,attributes:font,context: nil).size
            height = height + sizeOfString.height
            
        }
        return height + 50.0
    }
    
    // Changing dateformat

    class func convertDateFormater(date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM dd"
        return  dateFormatter.string(from: date!)
        
    }
}


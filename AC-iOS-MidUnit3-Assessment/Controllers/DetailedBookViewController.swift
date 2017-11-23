//
//  DetailedBookViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedBookViewController: UIViewController {
    var book: Book? = nil
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookPrice: UILabel!
    @IBOutlet weak var bookSummary: UITextView!
    @IBOutlet weak var bookSubtitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBook()

    }
    func loadBook() {
        if let book = book{
            bookPrice.text = "Price: " + book.saleInfo.listPrice.currencyCode + " " + book.saleInfo.listPrice.amount.description
            bookSummary.text = book.volumeInfo.description
            bookAuthor.text = "Author: " + book.volumeInfo.authors[0]
            bookLabel.text = "Title: " + book.volumeInfo.title
            let imageLink = book.volumeInfo.imageLinks.thumbnail
            print(imageLink)
            if let safeBookSubtitle = book.volumeInfo.subtitle{
                bookSubtitle.text = "Subtitle: " + safeBookSubtitle + ", ISBN_13 Code : \(book.volumeInfo.industryIdentifiers[0].identifier)"
            }
            else{
                bookSubtitle.text = "Book Subtitle Unavailable" + ", ISBN_13 Code : \(book.volumeInfo.industryIdentifiers[0].identifier)"
            }
            let myURL = URL(string: imageLink)
            if let data = try? Data(contentsOf: myURL!){
                bookImage.image = UIImage(data: data)
            }
            else{
                bookImage.image = #imageLiteral(resourceName: "defaultBook")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    var myBooks = [Book]()
    @IBOutlet weak var booksTableView: UITableView!
    @IBOutlet weak var BooksSearchBar: UISearchBar!
    // Mark SearchBar: Required properties and delegate assigned
    var filteredBooks:[Book]{
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return myBooks
        }
        return myBooks.filter{$0.volumeInfo.title.lowercased().contains(searchTerm.lowercased())}
    }
    var searchTerm: String?{
        didSet{
            booksTableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
    // Mark TableView: Required Methods, delegat and data source assigned
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookSetup = filteredBooks[indexPath.row]
        guard let cell: UITableViewCell = booksTableView.dequeueReusableCell(withIdentifier: "myCell") else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = bookSetup.volumeInfo.title
            return defaultCell
        }
        cell.textLabel?.text = bookSetup.volumeInfo.title
        cell.detailTextLabel?.text = bookSetup.saleInfo.listPrice.currencyCode + " " + bookSetup.saleInfo.listPrice.amount.description
        return cell
    }
    func loadBookData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json"){
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL){
                let myDecoder = JSONDecoder()
                do{
                    let books = try myDecoder.decode(AllBooks.self, from: data)
                    print("it has passed")
                    self.myBooks = books.items
                }
                catch let error{
                    print("\n", error, error.localizedDescription)
                }
            }
        }
        //        for book in myBooks{
        //            print(book.volumeInfo.imageLinks.smallThumbnail)
        //        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.booksTableView.delegate = self
        self.booksTableView.dataSource = self
        self.BooksSearchBar.delegate = self
        loadBookData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedBookViewController{
            let indexPath = booksTableView.indexPathForSelectedRow!
            destination.book = filteredBooks[indexPath.row]
        }
    }
    
    
}

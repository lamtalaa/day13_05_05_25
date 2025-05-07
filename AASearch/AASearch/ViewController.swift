//
//  ViewController.swift
//  AASearch
//
//  Created by Yassine Lamtalaa on 5/5/25.
//
// Implemeting AA Coding challenge with Api Call seperate from View Controller using Closures and Generics.

import UIKit

protocol ViewControllerProtocol {
    func refreshUI(with response: SearchResponse)
}

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var results: [ResultItem] = []
    var relatedTopics: [RelatedTopicItem] = []
    
    let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self

        tableView.backgroundColor = UIColor.systemGray5
        tableView.sectionHeaderTopPadding = 0
        
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.backgroundColor = .white
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.leftView = nil  // removes the search icon
        }

        performSearch(with: searchBar.text)
    }
    
    func performSearch(with text: String?) {
        guard let searchedText = text, !searchedText.isEmpty else { return }

        let encoded = searchedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://api.duckduckgo.com/?q=\(encoded)&format=json&pretty=1"

        networkManager.doApi(endPoint: url, modelName: SearchResponse.self) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.refreshUI(with: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: ViewControllerProtocol {
    func refreshUI(with response: SearchResponse) {
        DispatchQueue.main.async {
            self.results = response.Results
            self.relatedTopics = response.RelatedTopics
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "RESULTS" : "RELATED TOPICS"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = UIColor.systemGray5
            header.textLabel?.textColor = .systemGray2
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? results.count : relatedTopics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultsTableViewCell

        if indexPath.section == 0 {
            let item = results[indexPath.row]
            cell?.textFieldLabel.text = item.Text
            cell?.firstURLLabel.text = item.FirstURL
        } else {
            let topic = relatedTopics[indexPath.row]
            cell?.textFieldLabel.text = topic.Text
            cell?.firstURLLabel.text = topic.FirstURL
        }

        cell?.firstURLLabel.textColor = .gray
        cell?.firstURLLabel.font = UIFont.systemFont(ofSize: 13)

        return cell ?? UITableViewCell()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch(with: searchBar.text)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        performSearch(with: searchBar.text)
    }
}


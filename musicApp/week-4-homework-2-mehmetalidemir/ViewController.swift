//
//  ViewController.swift
//  week-4-homework-2-mehmetalidemir
//
//  Created by Mehmet Ali Demir on 3.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var heroes = [HeroStats]()


    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            print("success")
        }

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        activityIndicator.startAnimating()
    }

}

// MARK -
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        let hero = heroes[indexPath.row]
        cell?.lbl.text = hero.localized_name.capitalized

        return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController
        let hero = heroes[indexPath.row]
        vc?.hero = hero
        vc?.modalPresentationStyle = .formSheet
        present(vc!, animated: true, completion: nil)
    }



    func fetchData(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")

        URLSession.shared.dataTask(with: url!) { data, response, err in

            if err == nil {
                do {
                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("error fetching data from api")
                }
            }
        }.resume()
    }

}





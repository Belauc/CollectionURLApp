//
//  ViewController.swift
//  CollectionURLApp
//
//  Created by Sergey on 19.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var factsLabel: UILabel!
    
    var animeFacts: [AnimeFact] = []
    var anime: Anime = Anime()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = anime.anime_name
        updateImage()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchAnimeInfo()
        
//        updateViewConstraints()
    }
    
    private func updateFatc() {
        animeFacts.forEach { (fact) in
            factsLabel.text! += fact.fact
        }
    }
    private func updateImage() {
        let url = URL(string: anime.anime_img)
        if let data = try? Data(contentsOf: url!) {
            let image = UIImage(data: data)
            imageView.image = image
        }
    }

}

extension ViewController {
    func fetchAnimeInfo(){
        guard let url = URL(string: "\(URLAnime.chooseAnimeFacts.rawValue)\(anime.anime_name)") else { return }
        print(url.absoluteURL)
        URLSession.shared.dataTask(with: url.absoluteURL) { [weak self] (data, _, _) in
            guard let data = data else { return }
            do{
                let facts = try JSONDecoder().decode(ChooseAnimeFacts.self, from: data)
                self?.animeFacts = facts.data
                DispatchQueue.main.async { [weak self] in
                    self?.updateFatc()
                }
            }catch let error {
                print(error)
            }
        }.resume()
        
    }
}


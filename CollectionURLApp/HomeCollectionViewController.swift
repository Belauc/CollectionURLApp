//
//  HomeCollectionViewController.swift
//  CollectionURLApp
//
//  Created by Sergey on 19.01.2022.
//

import UIKit

private let reuseIdentifier = "cell"

class HomeCollectionViewController: UICollectionViewController {
    
    private var listAnime: [Anime] = []
    private var anime: Anime?


    override func viewDidLoad() {
        super.viewDidLoad()
    }



    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let destination = segue.destination as? ViewController else {
             return
         }
        destination.anime = self.anime ?? .init()
        
     }
     

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAnime.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        // Configure the cell
        cell.clipsToBounds = true
        let anime = listAnime[indexPath.item]
        let stringUrl = anime.anime_img
        let imageUrl = URL(string: stringUrl)
        if let dataImage = try? Data(contentsOf: imageUrl!) {
            let image = UIImage(data: dataImage)
            cell.imageView.image = image
            cell.imageView.frame.size.height = CGFloat(150.0)
            cell.imageView.frame.size.width = CGFloat(150.0)
        }

        cell.label.text = anime.anime_name
        return cell
        
    }
    

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.anime = listAnime[indexPath.item]
        return true
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetail", sender: nil)
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let url = URL(string: URLAnime.animeList.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let data = data {
                do {
                    let list = try JSONDecoder().decode(AnimeList.self, from: data)
                    self?.listAnime = list.data
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        print(view.frame.size == view.bounds.size)
    }
    
  
}

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48 , height: UIScreen.main.bounds.width / 1.5)
    }
}




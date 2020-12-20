//
//  DetailVC.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import UIKit
import Kingfisher
import WebKit

class DetailVC: UIViewController {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var imageViewBackdrop: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelSynop: UILabel!
    @IBOutlet weak var labelMovieYear: UILabel!
    @IBOutlet weak var collectionViewCasters: UICollectionView!
    @IBOutlet weak var collectionViewReviews: UICollectionView!
    @IBOutlet weak var buttonViewAllReviews: UIButton!
    @IBOutlet weak var wkTrailer: WKWebView!
    @IBOutlet weak var viewRevies: UIView!
    
    weak var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewReviews.register(cellType: ReviewHorizontalCell.self)
        collectionViewCasters.register(cellType: CasterCell.self)
        collectionViewReviews.dataSource = self
        collectionViewReviews.delegate = self
        collectionViewCasters.dataSource = self
        collectionViewCasters.delegate = self
        
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel?.changeHandler = { changes in
            switch changes {
            case .updateDataModel:
                self.setupUI()
            case .error(let message):
                print(message)
            case .loaderStart:
                break
            case .loaderEnd:
                break
            }
        }
        viewModel?.changeHandlerReviews = { changes in
            self.viewModel?.processGetCasters()
            switch changes {
            case .updateDataModel:
                if (self.viewModel?.reviews!.isEmpty ?? false) {
                    self.viewRevies.isHidden = true
                    return
                }
                self.viewRevies.isHidden = false
                self.collectionViewReviews.reloadData()
            case .error(let message):
                print(message)
                self.viewRevies.isHidden = true
            case .loaderStart:
                break
            case .loaderEnd:
                break
            }
        }
        viewModel?.changeHandlerVideos = { changes in
            self.viewModel?.processGetReviews()
            switch changes {
            case .updateDataModel:
                if let trailers = self.viewModel?.videos?.filter({ $0.type == "Trailer" && $0.site == "YouTube"}) {
                    if !trailers.isEmpty {
                        if let key = trailers.first?.key {
                            self.wkTrailer.isHidden = false
                            self.loadYoutube(videoID: key)
                        }
                    }
                }
            case .error(let message):
                print(message)
            case .loaderStart:
                break
            case .loaderEnd:
                break
            }
        }
        viewModel?.changeHandlerCasters = { changes in
            switch changes {
            case .updateDataModel:
                self.collectionViewCasters.reloadData()
            case .error(let message):
                print(message)
            case .loaderStart:
                break
            case .loaderEnd:
                break
            }
        }
        viewModel?.isShowingViewAllReviews = { show in
            self.buttonViewAllReviews.isHidden = show ? false : true
        }
    }
    private func loadYoutube(videoID:String) {
            guard
                let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")
                else { return }
        wkTrailer.load( URLRequest(url: youtubeURL) )
        }
    private func setupUI() {
        if let posterPath = viewModel?.movie?.posterPath {
            guard let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185/\(posterPath)") else { return }
            imageViewPoster.kf.setImage(with: posterUrl)
        }
        if let backdropPath = viewModel?.movie?.backdropPath {
            guard let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)") else { return }
            imageViewBackdrop.kf.setImage(with: backdropUrl)
        }
        labelMovieYear.text = viewModel?.movie?.releaseDate.getYear()
        labelSynop.text = viewModel?.movie?.overview
        labelMovieName.text = viewModel?.movie?.title
        viewModel?.processGetVideos()
    }
    
    @IBAction func didTappedWatch(){
        if let trailers = self.viewModel?.videos?.filter({ $0.type == "Trailer" && $0.site == "YouTube"}) {
            guard let id = trailers.first?.key else {return}
            let url = URL(string: "https://www.youtube.com/embed/\(id)")
            print(url)
        }
    }
}

extension DetailVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return viewModel?.reviews?.count ?? 0
        } else {
            return viewModel?.casters?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(with: ReviewHorizontalCell.self, for: indexPath)
            if let review = viewModel?.reviews?[indexPath.row] {
                cell.bind(with: review)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: CasterCell.self, for: indexPath)
            if let cast = self.viewModel?.casters?[indexPath.row] {
                cell.bind(with: cast)
            }
            return cell
        }
    }
}

extension DetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 16, bottom: 8, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
            return .init(width: itemSize, height: itemSize)
        } else {
            let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 4
            return .init(width: itemSize, height: itemSize)
        }
    }
}

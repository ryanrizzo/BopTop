//
//  TopBopsController.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit
import AVFoundation
import LKAlertController

class TopBopsCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    var currentlyPlayingIndexPath : IndexPath?
    let store = SongStore()
    var topBops = TopBops.init(weeks: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchTopBops { [unowned self] (result) in
            switch result {
            case let .success(topBops):
                self.topBops = topBops
                self.collectionView?.reloadData()
            case let .failure(error):
                print("Error fetching top bops: \(error)")
            }
        }
        
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gestureRecognizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){
        
        if (gestureRecognizer.state != UIGestureRecognizerState.began){
            return
        }
        let p = gestureRecognizer.location(in: self.collectionView)
        if let indexPath : IndexPath = (self.collectionView?.indexPathForItem(at: p)){
            let song = self.topBops.weeks[indexPath.section].songs[indexPath.row]
            DispatchQueue.main.async {
                ActionSheet(title: song.title, message: song.artist)
                    .addAction("Add to Queue", style: .default, handler: { [unowned self] _ in
                        let item = AVPlayerItem.init(url: song.url )
                        Player.sharedInstance.insert(item, after: nil)
                    })
                    .addAction("Cancel")
                    .show(animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.register(TopBopCell.self, forCellWithReuseIdentifier: "TopBopCell")
        collectionView?.register(TopBopsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TopBopsHeader")
        collectionView?.backgroundColor = .white
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topBops.weeks[section].songs.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return topBops.weeks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopBopCell", for: indexPath) as? TopBopCell {
            let song = topBops.weeks[indexPath.section].songs[indexPath.row]
            cell.dateLabel.text = DateHelper.dateToWeekday(date: song.date)
            cell.artistLabel.text = song.artist
            cell.titleLabel.text = song.title
            cell.likesLabel.text = String(song.likes)
            cell.playsLabel.text = String(song.plays)
            cell.imageView.image = song.image
            cell.playTapped = { [unowned self] () in
                if let path = self.currentlyPlayingIndexPath {
                    let playingCell = collectionView.cellForItem(at: path) as? TopBopCell
                    playingCell?.playButton.imageView?.image = #imageLiteral(resourceName: "play")
                }
                if(cell.isPlaying){
                    Player.sharedInstance.pause()
                    cell.isPlaying = false
                    DispatchQueue.main.async {
                        cell.playButton.imageView?.image = #imageLiteral(resourceName: "play")
                    }
                } else{
                    let item = AVPlayerItem.init(url: song.url)
                    Player.sharedInstance.removeAllItems()
                    Player.sharedInstance.insert(item, after: nil)
                    Player.sharedInstance.play()
                    cell.isPlaying = true
                    self.currentlyPlayingIndexPath = indexPath
                    DispatchQueue.main.async {
                        cell.playButton.imageView?.image = #imageLiteral(resourceName: "pause")
                    }
                }
            }
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopBopCell", for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TopBopsHeader", for: indexPath) as? TopBopsHeader
            headerView?.weekLabel.text = "Week of \(topBops.weeks[indexPath.section].date)"
            reusableView = headerView
        }
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 0 || indexPath.row == 4) {
            return CGSize.init(width: (view.frame.width - 20), height: (view.frame.width - 20) / 4)
        }
        else if( indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            return CGSize.init(width: (view.frame.width - 41) / 3, height: (view.frame.width - 41) / 2)
        }
        else {
            return CGSize.init(width: (view.frame.width - 30) / 2, height: (view.frame.width - 41) / 3)
        }
    }
    

}

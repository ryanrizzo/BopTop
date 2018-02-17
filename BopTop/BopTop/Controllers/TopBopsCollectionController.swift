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
import AudioToolbox



class TopBopsCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{
    var activeCell : (indexPath: IndexPath, isPlaying: Bool)?
    let store = SongStore()
    var topBops = TopBops.init(weeks: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(isPlaying), name: Notification.Name("isPlaying"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(isPaused), name: Notification.Name("isPaused"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeSongs), name: Notification.Name("didChangeSongs"), object: nil)
        
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
    
    @objc func isPlaying(notification: NSNotification) {
        if let indexPath = notification.userInfo?["indexPath"] as? IndexPath {
            guard notification.userInfo?["sender"] as? String == "TopBops" else {
                if let pathToReload = activeCell?.indexPath {
                    activeCell = nil
                    DispatchQueue.main.async{
                        self.collectionView?.reloadItems(at: [pathToReload])
                    }
                }
                return
            }
        
            activeCell?.isPlaying = true
            DispatchQueue.main.async{
                self.collectionView?.reloadItems(at: [indexPath])
            }
            
        }
    }
    
    @objc func isPaused(notification: NSNotification) {
        if let indexPath = notification.userInfo?["indexPath"] as? IndexPath {
            guard notification.userInfo?["sender"] as? String == "TopBops" else {
                if let pathToReload = activeCell?.indexPath {
                    activeCell = nil
                    DispatchQueue.main.async{
                        self.collectionView?.reloadItems(at: [pathToReload])
                    }
                }
                return
            }
            
            activeCell?.isPlaying = false
            DispatchQueue.main.async{
                self.collectionView?.reloadItems(at: [indexPath])
            }
        }
    }
    
    @objc func didChangeSongs(notification: NSNotification) {
        if let indexPath = notification.userInfo?["indexPath"] as? IndexPath {
            guard notification.userInfo?["sender"] as? String == "TopBops" else {
                if let pathToReload = activeCell?.indexPath {
                    activeCell = nil
                    DispatchQueue.main.async{
                        self.collectionView?.reloadItems(at: [pathToReload])
                    }
                }
                return
            }
            
            var pathsToReload : [IndexPath] = [indexPath]
            if let activeCell = activeCell {
                //there is a previously active cell
                if(activeCell.indexPath != indexPath){
                    //this was a different cell, so 2 paths need to be reloaded
                    pathsToReload.append(activeCell.indexPath)
                }
                switch activeCell.isPlaying {
                case true:
                    self.activeCell = (indexPath: indexPath, isPlaying: true)
                case false:
                    self.activeCell = (indexPath: indexPath, isPlaying: false)
                }
            } else {
                self.activeCell = (indexPath: indexPath, isPlaying: false)
            }
            DispatchQueue.main.async{
                self.collectionView?.reloadItems(at: pathsToReload)
            }
        }
    }
    
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){
        
        if (gestureRecognizer.state != UIGestureRecognizerState.began){
            return
        }
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        let p = gestureRecognizer.location(in: self.collectionView)
        if let indexPath : IndexPath = (self.collectionView?.indexPathForItem(at: p)){
            let song = self.topBops.weeks[indexPath.section].songs[indexPath.row]
            DispatchQueue.main.async {
                ActionSheet(title: song.title, message: song.artist)
                    .addAction("Add to Queue", style: .default, handler: { _ in
                        playerController.addToQueue(song: song, indexPath: indexPath, sender: "TopBops")
                        print("my queue: \(playerController.queue.count)")
                    })
                    .addAction("View Artist", style: .default, handler: { _ in
                        //View Artist Page
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
        collectionView?.backgroundColor = UIColor(red:0.88, green:0.91, blue:0.96, alpha:1.0)
        if let cell = activeCell{
            var pathsToReload = [cell.indexPath]
            if playerController.currentSong?.sender == "TopBops" {
                switch playerController.state {
                case .isNil:
                    activeCell = nil
                case .isPaused:
                    activeCell = (indexPath: playerController.currentSong?.indexPath, isPlaying: false) as? (indexPath: IndexPath, isPlaying: Bool)
                    if !pathsToReload.contains((activeCell?.indexPath)!){
                        pathsToReload.append((activeCell?.indexPath)!)
                    }
                case .isPlaying:
                    activeCell = (indexPath: playerController.currentSong?.indexPath, isPlaying: true) as? (indexPath: IndexPath, isPlaying: Bool)
                    if !pathsToReload.contains((activeCell?.indexPath)!){
                        pathsToReload.append((activeCell?.indexPath)!)
                    }
                }
            } else {
                activeCell = nil
            }
            collectionView?.reloadItems(at: pathsToReload)
        }
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
            
            if let activeCell = activeCell {
                if(activeCell.indexPath == indexPath) {
                    switch activeCell.isPlaying {
                    case true:
//                        cell.centerView.isHidden = false
//                        cell.animatePulsatingLayer()
                        cell.speakerView.isHidden = false
                        cell.speakerView.animatePulsatingLayer()
                    case false:
//                        cell.centerView.isHidden = false
//                        cell.stopAnimatingPulsatingLayer()
                        cell.speakerView.isHidden = false
                        cell.speakerView.stopAnimatingPulsatingLayer()
                    }
                    return cell
                }
            }
            
//            cell.centerView.isHidden = true
            cell.speakerView.isHidden = true
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let song = topBops.weeks[indexPath.section].songs[indexPath.row]
        playerController.play(song: song, indexPath: indexPath, sender: "TopBops")
    }
}

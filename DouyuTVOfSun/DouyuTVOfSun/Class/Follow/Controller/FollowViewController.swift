//
//  FollowViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/13.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit
import AVFoundation

private let kCellIdentifier = "kCellIdentifier"

class FollowViewController: UIViewController {
    
    private lazy var tableView: UITableView = {[weak self] in
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.register(FollowPlayerCell.self, forCellReuseIdentifier: kCellIdentifier)
        return tableView
    }()
    
    private lazy var videoList: Array = [FollowVideoModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关注"
        let image: UIImage = UIImage(named: "Image_scan")!.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(scanAction))
        
        setupUI()
        loadData()
    }
    
    @objc private func scanAction() {
        let scanCodeViewController: ScanCodeViewController = ScanCodeViewController()
        scanCodeViewController.delegate = self
        present(scanCodeViewController, animated: true, completion: nil)
    }
}

extension FollowViewController {
    private func setupUI() {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        view.addSubview(tableView)
    }
}

extension FollowViewController {
    private func loadData() {
        guard let filePath = Bundle.main.path(forResource: "VideoList", ofType: "plist") else {return}
        guard let tempdict = NSDictionary(contentsOfFile: filePath) else {return}
        guard let tempList = tempdict["VideoList"] as? NSArray else {return}
        for dict in tempList {
            let videoModel = FollowVideoModel(dict: dict as! [String : Any])
            videoList.append(videoModel)
        }
        tableView.reloadData()
    }
}

extension FollowViewController {
    private func pushPlayerVC(urlString: String) {
        let playVC = RoomPlayerViewController()
        playVC.urlString = urlString
        navigationController?.pushViewController(playVC, animated: true)
    }
}

extension FollowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FollowPlayerCell.height()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! FollowPlayerCell
        cell.videoModel = videoList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = videoList[indexPath.row]
        pushPlayerVC(urlString: viewModel.url)
    }
}

extension FollowViewController: ScanCodeViewControllerDelegate {
    func scanCodeViewController(_ viewController: ScanCodeViewController, didCompleteScanning codeString: String?) {
        guard let codeString = codeString else {
            let alert = UIAlertView(title: "Warning", message: "scan code is nil", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        pushPlayerVC(urlString: codeString)
    }
}


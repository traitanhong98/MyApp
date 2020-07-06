//
//  TardisChannelViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/4/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisChannelViewController: BaseTabViewController {

    
    @IBOutlet weak var addChannelButton: UIButton!
    @IBOutlet weak var channelsTableView: UITableView!
    let dataModel = TardisChannelDataModel()
    var firstLoad = true
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if firstLoad {
            loadChannel()
            firstLoad = false
        }
    }
    deinit {
        dataModel.reset()
    }
    func loadChannel() {
        dataModel.loadChannels { status in
            if status {
                CommonFunction.annoucement(title: "", message: "Load dữ liệu thành công")
            } else {
                CommonFunction.annoucement(title: "", message: "Load dữ liệu thất bại")
            }
            self.channelsTableView.reloadData()
        }
    }
    func registerTableView() {
        channelsTableView.register(UINib(nibName: "TardisChannelTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisChannelTableViewCell")
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
        channelsTableView.contentInset = .init(top: 60, left: 0, bottom: 0, right: 0)
    }
    @IBAction func leftMenuAction(_ sender: Any) {
        CommonFunction.rootVC.showLeftViewAnimated()
    }
    @IBAction func addChannelAction(_ sender: Any) {
        let addPopup = TardisCreateChannelPopup()
        addPopup.delegate = self
        addPopup.show()
    }
}
extension TardisChannelViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.listChannel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = channelsTableView.dequeueReusableCell(withIdentifier: "TardisChannelTableViewCell", for: indexPath) as? TardisChannelTableViewCell else { return UITableViewCell()}
        cell.bindData(channel: dataModel.listChannel[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = TardisChannelContentViewController()
        channel.hidesBottomBarWhenPushed = true
        channel.currentChannel = dataModel.listChannel[indexPath.row]
        self.navigationController?.pushViewController(channel, animated: true)
    }
}
extension TardisChannelViewController: TardisCreateChannelPopupDelegate {
    func createChannel(_ name: String) {
        dataModel.createChannel(name) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Tạo nhóm thành công")
            } else {
                CommonFunction.annoucement(title: "", message: "Tạo nhóm thất bại")
            }
            self.channelsTableView.reloadData()
        }
    }
}

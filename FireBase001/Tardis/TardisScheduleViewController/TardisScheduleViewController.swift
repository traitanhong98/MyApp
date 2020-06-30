//
//  TardisScheduleViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisScheduleViewController: BaseTabViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var scheduleTableView: UITableView!
    // MARK: - Var
    var dataModel = TardisScheduleDataModel.shared
    var firstLoad = true
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        observeSchedule()
    }
    override func viewWillAppear(_ animated: Bool) {
        if firstLoad {
            dataModel.loadSchedule { (status) in
                if status {
                    CommonFunction.annoucement(title: "", message: "Load dữ liệu thành công")
                } else {
                    CommonFunction.annoucement(title: "", message: "Load dữ liệu thất bại")
                }
                self.scheduleTableView.reloadData()
            }
        }
        firstLoad = false
    }
    deinit {
        dataModel.reset()
    }
    // MARK: - Func
    func observeSchedule() {
        dataModel.firObserveSchedule { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Load dữ liệu thành công")
            } else {
                CommonFunction.annoucement(title: "", message: "Load dữ liệu thất bại")
            }
            self.scheduleTableView.reloadData()
        }
    }
    func registerTableView() {
        scheduleTableView.register(UINib(nibName: "TardisScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisScheduleTableViewCell")
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.contentInset = .init(top: 90, left: 0, bottom: 0, right: 0)
    }

    // MARK: - IBAction
    @IBAction func leftMenuAction(_ sender: Any) {
        CommonFunction.rootVC.showLeftViewAnimated()
    }
    @IBAction func addAction(_ sender: Any) {
        let infoPopup = TardisScheduleInfoPopup()
        infoPopup.delegate = self
        infoPopup.show()
    }
    
}
// MARK: - Extension
extension TardisScheduleViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.listSchedules.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = scheduleTableView.dequeueReusableCell(withIdentifier: "TardisScheduleTableViewCell", for: indexPath) as? TardisScheduleTableViewCell else {
            return UITableViewCell()
        }
        cell.bindData(schedule: dataModel.listSchedules[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TardisScheduleHeaderView()
        headerView.headerTitle = "Đây là section \(section)"
        return headerView.view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoPopup = TardisScheduleInfoPopup()
        infoPopup.bindData(schedule: dataModel.listSchedules[indexPath.row])
        infoPopup.delegate = self
        infoPopup.show()
    }
}
extension TardisScheduleViewController: TardisScheduleInfoPopupDelegate {
    func closeAction() {
        // Do SomeThing
    }
    
    func deleteAction(withObject object: TardisScheduleObject) {
        dataModel.deleteSchedule(schedule: object) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Xoá thành công")
            } else {
                CommonFunction.annoucement(title: "", message: "Xoá thất bại")
            }
        }
    }
    
    func acceptAction(withObject object: TardisScheduleObject) {
        dataModel.addSchedule(schedule: object) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Thêm thành công")
            } else {
                CommonFunction.annoucement(title: "", message: "Thêm thất bại")
            }
        }
    }
}

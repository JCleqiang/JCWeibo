//
//  JCHomeViewController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCHomeViewController: JCVisitorTableViewController {
    
    /// 保存所有微博数据
    var statusViewModels: [JCStatusViewModel]? {
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupNav()
        
        // 0.注册cell
        tableView.register(JCHomeTableViewCell.self, forCellReuseIdentifier: kHomeCellId)
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
//        tableView.estimatedRowHeight = 400
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        JCStatusViewModel.loadStatuesData { (array, error) in
            var models = [JCStatusViewModel]()
            for dict in array! {
                let statusModel = JCStatusModel(dict: dict)
                let viewModel = JCStatusViewModel(statusModel: statusModel)
                models.append(viewModel)
            }

            // 保存数据
            self.statusViewModels = models;
        }
    }
    
    func setupNav() {
        navigationItem.titleView = filterNavBarButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"navigationbar_friendattention", target: self, action: #selector(leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName:"navigationbar_pop", target: self, action: #selector(rightBtnClick))
    }
    
    func filterNavBarButtonDidClick() {
        let popMenuTool = JLPopMenuTool()
        popMenuTool.menuArray = ["首页", "首页", "首页", "首页", "首页", "首页"]
        popMenuTool.delegate = self
        popMenuTool.show(from: filterNavBarButton)
    }
    
    @objc private func leftBtnClick() {
        JCLog(message: "-----")
    }
    @objc private func rightBtnClick() {
        let qrCode = JCMainNavigationController(rootViewController: JCQRCodeViewController())
        present(qrCode, animated: true, completion: nil)
    }

    
    lazy var filterNavBarButton: NSFilterNavBarButton = {
        let filterNavBarButton = NSFilterNavBarButton()
        filterNavBarButton.addTarget(self, action: #selector(filterNavBarButtonDidClick), for:.touchUpInside)
        filterNavBarButton.navTitle = "静持大师"
        
        return filterNavBarButton
    }()
}

extension JCHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("xixi")
        print(statusViewModels?.count)
        return statusViewModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.取出cell
        let cell = tableView.dequeueReusableCell(withIdentifier: kHomeCellId, for: indexPath) as! JCHomeTableViewCell
        
        // 2.设置数据
        let viewModel = statusViewModels![indexPath.row]
        cell.statusViewModels = viewModel
        
        // 3.返回cell
        return cell
    }
}

extension JCHomeViewController: JLPopMenuToolDelegate {
    func popMenuTool(_ popMenuTool: JLPopMenuTool!, didSelectRowAt indexPath: IndexPath!) {
        JCLog(message: "点击菜单")
    }
}

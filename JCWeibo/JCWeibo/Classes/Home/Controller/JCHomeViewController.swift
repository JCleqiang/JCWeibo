//
//  JCHomeViewController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCHomeViewController: JCVisitorTableViewController {
    /// 缓存行高字典(key就是微博ID, value就是当前微博的行高)
    lazy var rowHeightCache: NSMutableDictionary = {
        /*
         NSCache和字典差不错, 也是通过key/value的形式保存数据
         
         和字典不同的地方在于, 字典不会自动释放存储内容
         NSCache当接收到系统内存警告时会自动释放存储的内容
         
         NSCache还可以设置最大能够存储的容量, 以及最大能够存储的个数
         */
        var cache = NSMutableDictionary()
//        cache.countLimit = 30
        
        return cache
    }()
    
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
        tableView.register(JCHomeTableViewCell.self, forCellReuseIdentifier: JCHomeTableViewCell.identifier())
        tableView.separatorStyle = .none
//        tableView.rowHeight = 00
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
        let cell = tableView.dequeueReusableCell(withIdentifier: JCHomeTableViewCell.identifier(), for: indexPath) as! JCHomeTableViewCell
        
        // 2.设置数据
        let viewModel = statusViewModels![indexPath.row]
        cell.statusViewModel = viewModel
        
        // 3.返回cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 0. 获取当前行对用的模型
        let viewModel = statusViewModels![indexPath.row]
         
        // 1.先从缓存中获取行高
        if let height = rowHeightCache.object(forKey: viewModel.statusModel.id.description) as? CGFloat {
            print("缓存高度")
            print(height)
            return height
        }
        
        // 2.拿到当前行对应的cell
        let cell = tableView.dequeueReusableCell(withIdentifier: JCHomeTableViewCell.identifier()) as! JCHomeTableViewCell
        
        // 3.获取当前行行高
        let height = cell.rowHeight(viewModel: viewModel)
        
        // 4.缓存行高
//        rowHeightCache.setObject(height, forKey: viewModel.status.id)
        rowHeightCache.setValue(height, forKey: viewModel.statusModel.id.description)
        
        print("计算")
        print(height)
        
        // 5.返回行高
        return height
    }
}

extension JCHomeViewController: JLPopMenuToolDelegate {
    func popMenuTool(_ popMenuTool: JLPopMenuTool!, didSelectRowAt indexPath: IndexPath!) {
        JCLog(message: "点击菜单")
    }
}

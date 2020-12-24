//
//  JCHomeViewController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import SVProgressHUD

class JCHomeViewController: JCVisitorTableViewController {
    /// 缓存行高字典(key就是微博ID, value就是当前微博的行高)
    lazy var rowHeightCache: NSMutableDictionary = {
        /*
         NSCache和字典差不错, 也是通过key/value的形式保存数据
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupNav()
        
        if tableView != nil {
            setupTableView()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(scanBigPicNoti), name: NSNotification.Name(rawValue: JCScanBigPicNotification), object: nil)
    }
    
    override func loginSuccessNoti()  {
        super.loginSuccessNoti()
        
        setupTableView()
    }
    
    func setupNav() {
        navigationItem.titleView = filterNavBarButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"navigationbar_friendattention", target: self, action: #selector(leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName:"navigationbar_pop", target: self, action: #selector(rightBtnClick))
    }
    
    func setupTableView()  {
        // 0.注册cell
        tableView.register(JCHomeTableViewRepostCell.self, forCellReuseIdentifier: JCHomeTableViewRepostCell.identifier())
        tableView.register(JCHomeTableViewNormalCell.self, forCellReuseIdentifier: JCHomeTableViewNormalCell.identifier())
        tableView.separatorStyle = .none
        
        tableView.mj_header = JCRefreshHeader(refreshingBlock: {
            let since_id = self.statusViewModels?.first?.statusModel.id ?? 0
            let max_id = 0
            JCStatusViewModel.loadStatuesData(since_id: since_id, max_id: max_id, finished: { (array, error) in
                self.tableView.mj_header.endRefreshing()
                
                guard let array = array else {
                    SVProgressHUD.showInfo(withStatus: "没有微博更新")
                    return
                }
                
                var models = [JCStatusViewModel]()
                for dict in array {
                    let statusModel = JCStatusModel(dict: dict as [String : AnyObject])
                    let viewModel = JCStatusViewModel(statusModel: statusModel)
                    models.append(viewModel)
                }
                
                SVProgressHUD.showInfo(withStatus: "更新\(models.count)条微博")

                guard let hadModels = self.statusViewModels else {
                    self.statusViewModels = models
                    return
                }
                
                self.statusViewModels = models + hadModels
            })
        })
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = JCRefreshFooter(refreshingBlock: { 
            let since_id = 0
            let max_id = self.statusViewModels!.last!.statusModel.id - 1
            JCStatusViewModel.loadStatuesData(since_id: since_id, max_id: max_id, finished: { (array, error) in
                self.tableView.mj_footer.endRefreshing()
                
                var models = [JCStatusViewModel]()
                for dict in array! {
                    let statusModel = JCStatusModel(dict: dict as [String : AnyObject])
                    let viewModel = JCStatusViewModel(statusModel: statusModel)
                    models.append(viewModel)
                }
                
                self.statusViewModels = self.statusViewModels! + models
            })
        })
    }
    
    @objc func scanBigPicNoti(noti: Notification)  {
        let info: [String: Any] = noti.userInfo as! [String : Any]
        
        let photo = KLPhotoBrowserController(imageMessageArray: info["urls"] as! [String]?, seletedIndex: (info["indexPath"] as! NSIndexPath).row)
        present(photo!, animated: false, completion: nil)
    }
    
    @objc func filterNavBarButtonDidClick() {
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
        print(statusViewModels?.count)
        return statusViewModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = statusViewModels![indexPath.row]
        
        let Identifier = JCHomeTableViewCell.identiferWithViewModel(viewModel: viewModel)
        
        // 1.取出cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! JCHomeTableViewCell
        
        // 2.设置数据
        
        cell.statusViewModel = viewModel
        
        cell.myDelegate = self
        
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
            return height
        }
        
        // 2.拿到当前行对应的cell. 获取当前行行高
        let Identifier = JCHomeTableViewCell.identiferWithViewModel(viewModel: viewModel)
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier) as! JCHomeTableViewCell
        let height = cell.rowHeight(viewModel: viewModel)
        
        // 4.缓存行高
        rowHeightCache.setValue(height, forKey: viewModel.statusModel.id.description)
        
        return height
    }
}

extension JCHomeViewController: JLPopMenuToolDelegate {
    func popMenuTool(_ popMenuTool: JLPopMenuTool!, didSelectRowAt indexPath: IndexPath!) {
        JCLog(message: "点击菜单")
    }
}

extension JCHomeViewController: JCHomeTableViewCellDelegate {
    func highlightDidClik(content: String) {
        if content.hasPrefix("http://") || content.hasPrefix("https://"){
            let webView = JCCommonWebViewController()
            webView.path = content
            navigationController?.pushViewController(webView, animated: true)
        }
    }
}

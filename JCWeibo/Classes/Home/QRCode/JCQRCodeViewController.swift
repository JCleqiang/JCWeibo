//
//  JCQRCodeViewController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import AVFoundation

class JCQRCodeViewController: UIViewController { 
    /// 容器视图
    @IBOutlet weak var containerView: UIView!
    /// 冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    /// 冲击波顶部约束
    @IBOutlet weak var scanLineTopCons: NSLayoutConstraint!
    
    let kContainerViewH: CGFloat = 300;


    override func viewDidLoad() {
        super.viewDidLoad()
        
        JCLog(message: scanLineTopCons.constant)
        
        title = "扫一扫"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "关闭", target: self, action: #selector(JCQRCodeViewController.leftItemDidClick))

        setupScanQRCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }
    
    @objc private func leftItemDidClick() {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     初始化二维码扫描
     */
    private func setupScanQRCode() {
        // 1.判断输入是否能够添加到会话中
        if !session.canAddInput(inputDevice!) {
            JCLog(message: "输入不能够添加到会话中")
            return
        }
        // 2.判断输出是否能够添加到会话中
        if !session.canAddOutput(output) {
            JCLog(message: "输出不能够添加到会话中")
            return
        }
        // 3.将输入和输出添加到会话中
        session.addInput(inputDevice!)
        session.addOutput(output)
        
        // 4.设置输出对象能够解析的数据类型
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        // 5.设置代理监听解析之后数据
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 6.设置预览界面
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        
        
        // 7.添加专门用于保存描边图层
        containerLayer.frame = view.bounds
        containerLayer.backgroundColor = UIColor.clear.cgColor
        view.layer.addSublayer(containerLayer)
        
        
        // 7.开始扫描二维码
        session.startRunning()
    }
    
    // MAKR: - 内部控制方法
    private func startAnimation() {
        
        // 0.停止动画
        scanLineView.layer.removeAllAnimations()
        
        // 1.设置冲击波看不到
        scanLineTopCons.constant = -kContainerViewH
        view.layoutIfNeeded()
        
        // 2.执行动画
        UIView.animate(withDuration: 2.0) { 
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineTopCons.constant = self.kContainerViewH
            self.view.layoutIfNeeded()
        }
    }

    // MAKR: - 懒加载
    /// 输入设备
    private lazy var inputDevice: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        return try? AVCaptureDeviceInput(device: device!)
    }()

    /// 输出对象
    private lazy var output: AVCaptureMetadataOutput = {
        // 1.创建输出对象
        let metadataOutput = AVCaptureMetadataOutput()
        
        // 2.获取容器视图的frame
        let containerFrame = self.containerView.frame
        let screenFrame = UIScreen.main.bounds
        
        // 3.计算x/y/width/height比例
        let x = containerFrame.origin.y / screenFrame.size.height
        let y = containerFrame.origin.x / screenFrame.size.width
        let width = containerFrame.size.height / screenFrame.size.height
        let height = containerFrame.size.width / screenFrame.size.width
        
        // 4.设置 解析数据感兴趣区域
        metadataOutput.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
        
        // 5.返回输出对象
        return metadataOutput
    }()

    /// 会话
    private lazy var session = AVCaptureSession()
    
    /// 预览图层
    // 如果是在懒加载中用到self一般情况下是没有循环引用的
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        return layer
    }()
    
    /// 专门用于保存描边的图层
    private lazy var containerLayer = CALayer()
}

// MAKR: - 扫描二维码相关
extension JCQRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    // MAKR: - AVCaptureMetadataOutputObjectsDelegate
    /**
     当解析到扫描到的数据时就会调用
     所有扫描到的数据都存在在metadataObjects
     */
    private func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        
        for objc in metadataObjects {
            let temp = objc as! AVMetadataMachineReadableCodeObject
//            resultLabel.text = temp.stringValue
            JCLog(message: temp.stringValue)
        }
    }
}

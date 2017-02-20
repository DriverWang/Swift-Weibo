//
//  QRCodeViewController.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/29.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit
import AVFoundation
class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var customContainerView: UIView!
    @IBOutlet weak var scanLineVIew: UIImageView!

    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var customTabBar: UITabBar!

    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        customTabBar.selectedItem = customTabBar.items?.first
        customTabBar.delegate = self
        
        scanQRCode()
        
    }

    private func scanQRCode(){
    
        if !session.canAddInput(input){
            return
        }
        
        if !session.canAddOutput(output){
        
            return
        }
    
        session.addInput(input)
        session.addOutput(output)
        
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue .main)
    
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds
        
        view.layer.addSublayer(containerLayer)
        containerLayer.frame = view.bounds
        
        session.startRunning()
    }
    
   
    @IBAction func closeBtnOnClick(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func photoBtnOnClick(_ sender: AnyObject) {
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            return
        }
        
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true, completion: nil)
        
    }
    
      func startAnimtaion(){
        
        scanLineCons.constant = -containerHeightCons.constant
        view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0) {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineCons.constant = self.containerHeightCons.constant
            
            self.view.layoutIfNeeded()
            
        }
    }

    override func viewDidAppear(_ animated: Bool) {
     
        super.viewDidAppear(animated)
             startAnimtaion()
    }
    
    
    private lazy var input:AVCaptureInput = {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        return try! AVCaptureDeviceInput(device:device)
    }()
    
    private lazy var session:AVCaptureSession = AVCaptureSession()
    
    private lazy var output :AVCaptureMetadataOutput = {
        
       let out = AVCaptureMetadataOutput()
        
        let viewRect = self.view.frame
        let containerRect = self.customContainerView.frame
        let x = containerRect.origin.y / viewRect.origin.y
        let y = containerRect.origin.x / viewRect.origin.x
        let width = containerRect.height / viewRect.height
        let height = containerRect.width / viewRect.width

        out.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)

        return out
    }()
    lazy var previewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    lazy var containerLayer:CALayer = CALayer()
    
}

extension QRCodeViewController:AVCaptureMetadataOutputObjectsDelegate{
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        clearLayers()

        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;

            customLabel.text = readableObject.stringValue

            guard let metdata = metadataObject as?AVMetadataMachineReadableCodeObject else {
                return
            }
            
            let objc = previewLayer.transformedMetadataObject(for: metdata)
            drawLines(objc: objc as! AVMetadataMachineReadableCodeObject)
    }
    }
    
    private func drawLines(objc:AVMetadataMachineReadableCodeObject){
        
        guard let array = objc.corners else {
            return
        }
        
        
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        var index = 0
        let path = UIBezierPath()
        let point = CGPoint.init(dictionaryRepresentation: (array[index] as! CFDictionary))
        
        index += 1
        
        path.move(to: point!)
        
        while index<array.count {
            let point = CGPoint.init(dictionaryRepresentation: (array[index] as! CFDictionary))
            path.addLine(to: point!)
            index += 1

        }
        
        path.close()
        
        layer.path = path.cgPath
        
         containerLayer.addSublayer(layer)
    }

    private func clearLayers(){
    
        guard let subLayers = containerLayer.sublayers else {
            
            return
        }
    
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
    }
    
    
}
extension QRCodeViewController:UITabBarDelegate  {

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
     
        containerHeightCons.constant = (item.tag == 1) ? 150 : 300
        view.layoutIfNeeded()
        
        scanLineVIew.layer.removeAllAnimations()
        
        startAnimtaion()
        
    }
}
extension QRCodeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
}


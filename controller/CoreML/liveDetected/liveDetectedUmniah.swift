//
//  liveDetectedUmniah.swift
//  AirFix
//
//  Created by Ahmad Mustafa on 6/2/19.
//  Copyright © 2019 Pixel. All rights reserved.
//

import UIKit
import CoreML
import Vision
import AVKit

class liveDetectedUmniah: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate  {
    
    @IBOutlet weak var imageLiveView: UIImageView!
    
    @IBOutlet weak var finalResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "UMNIAH"
        setBookMLVision()
        
    }
    
    func setBookMLVision(){
        // set the device type and input
        guard let device = AVCaptureDevice.default(for: .video) else {return}
        guard let deviceInput = try? AVCaptureDeviceInput(device: device) else {return}
        
        // Mange for capture video
        let session = AVCaptureSession()
        session.sessionPreset = .hd1920x1080
        
        // Core Animated for the layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.frame
        imageLiveView.layer.addSublayer(previewLayer)
        
        // set the deive type and output
        let outputDevice = AVCaptureVideoDataOutput()
        outputDevice.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera"))
        
        session.addInput(deviceInput)
        session.addOutput(outputDevice)
        session.startRunning()
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let sample = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        scanRouter(currentBuffer: sample)
    }
    
    func scanRouter(currentBuffer: CVPixelBuffer){
        guard let model = try? VNCoreMLModel(for: umniahRouterML().model) else {return}
        
        // scan the request inside the closure
        let request = VNCoreMLRequest(model: model){ request, error in
            
            // set the reuslt and most result
            guard let result = request.results as? [VNClassificationObservation] else {return}
            guard let mostResult = result.first else {return}
            
            DispatchQueue.main.async {
                if mostResult.confidence >= 0.9{
                    switch mostResult.identifier{
                    case "NoElectric":
                        self.finalResult.text = "there is no power .. conect it to the power"
                    case "NoInternet":
                        self.finalResult.text = " there is no internet connection"
                    case "work":
                        self.finalResult.text = " everything is fine"
                        
                    default:
                        return
                    }
                }else{
                    self.finalResult.text = "there is no router"
                }
            }
        }
        let requestHander = VNImageRequestHandler(cvPixelBuffer: currentBuffer, options: [:])
        do{
            try requestHander.perform([request])
        }catch{
            print(error)
        }
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype,
                              with event: UIEvent?){
        let alert = UIAlertController(title: "How to use", message: "put the camera on the Router and check the result down on the Box", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert,animated: true,completion: nil)
    }
    
    
}



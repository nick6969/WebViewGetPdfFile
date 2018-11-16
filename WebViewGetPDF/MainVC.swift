//
//  MainVC.swift
//  WebViewGetPDF
//
//  Created by Nick on 2018/11/16.
//  Copyright © 2018 kcin.nil.app. All rights reserved.
//

import UIKit

final class MainVC: UIViewController {
    
    private let button: UIButton = UIButton()
    private let webView: UIWebView = UIWebView()
    private let pdfURLstring: String = <#Type Your PDF Path#>
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(webView)
        webView.mLaySafe(pin: .init(top: 0, left: 0, bottom: 50, right: 0))
        
        view.addSubview(button)
        button.mLaySafe(pin: .init(left: 0, bottom: 0, right: 0))
        button.mLay(.height, 50)
        button.backgroundColor = .red
        button.setTitle("測試", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        webView.loadRequest(URLRequest(url: URL(string: pdfURLstring)!))
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        guard let classString = NSClassFromString("UIWebPDFView") else {
            print("can't find UIWebPDFView class")
            return
        }
        for view in webView.scrollView.subviews where view.isKind(of: classString) {
            if view.responds(to: Selector(("documentData"))) {
                if let data = view.perform(Selector(("documentData"))).takeUnretainedValue() as? Data {
                    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
                    let pdfFileURL = directoryURL.appendingPathComponent("test.pdf")
                    do {
                        try data.write(to: pdfFileURL)
                        print("filePath: \(pdfFileURL.absoluteString)")
                        print("write file success")
                        return
                    } catch {
                        print("write file error: \(error.localizedDescription)")
                    }
                }
            }
            
        }
        print("not get pdf")
    }
    
}

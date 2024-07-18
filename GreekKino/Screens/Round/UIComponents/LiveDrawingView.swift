//
//  LiveDrawingView.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 17.7.24..
//

import SwiftUI
import WebKit

struct LiveDrawingView: UIViewRepresentable {
    private let urlString = "https://www.mozzartbet.com/sr/lotto-animation/26#/" 
    
    let webView: WKWebView
        
    init() {
        webView = WKWebView(frame: .zero)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: urlString)!))
    }
}

#Preview {
    LiveDrawingView()
}

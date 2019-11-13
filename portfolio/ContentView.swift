//
//  ContentView.swift
//  workoutsettracker
//
//  Created by Raja, Tarun on 11/13/19.
//  Copyright © 2019 Raja, Tarun. All rights reserved.
//

import SwiftUI

func GetConfigFile() -> Any  {
    let url = Bundle.main.url(forResource: "File", withExtension: "txt")!
    var json: Any = {}
    do {
        let jsonData = try Data(contentsOf: url)
        json = try JSONSerialization.jsonObject(with: jsonData) as! [[[String: Any]]]
    }
    catch {
        print(error)
    }
    return json
}

func getQRCode() -> UIImage {
    let image: UIImage = #imageLiteral(resourceName: "IMG_1797.jpg");
    let myString = "https://www.linkedin.com/in/tarun-raja"
    // Get data from the string
    let data = myString.data(using: String.Encoding.ascii)
    // Get a QR CIFilter
    guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return image }
    // Input the data
    qrFilter.setValue(data, forKey: "inputMessage")
    // Get the output image
    guard let qrImage = qrFilter.outputImage else { return image}
    // Scale the image
    let transform = CGAffineTransform(scaleX: 8, y: 8)
    let scaledQrImage = qrImage.transformed(by: transform)
    let context = CIContext()
    guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return image}
    let processedImage = UIImage(cgImage: cgImage)
    return processedImage;
}

struct MainView: View {
    var bounds = UIScreen.main.bounds
    var body: some View {
        VStack {
            Text(NSLocalizedString("HomePageTitle", comment: ""))
                .font(.system(.title)).frame(width: bounds.size.width).foregroundColor(.black)
            
        }
    }
}

struct ContentView: View {
    var bounds = UIScreen.main.bounds
    
    private var image: UIImage = #imageLiteral(resourceName: "IMG_1797.jpg");
    var body: some View {
        VStack {
            ScrollView(.vertical){
                Image(uiImage: image).resizable().aspectRatio(contentMode: .fill)
                MainView()
                Image(uiImage: getQRCode())
            }
        }.frame(height: bounds.size.height)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

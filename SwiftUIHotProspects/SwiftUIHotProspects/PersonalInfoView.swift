//
//  PersonalInfoView.swift
//  SwiftUIHotProspects
//
//  Created by Kunal Kumar R on 27/08/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct PersonalInfoView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("name", text: $name)
                    .textContentType(.name)
                    .font(.headline)
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.headline)
                
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateQRCode)
            .onChange(of: name, updateQRCode)
            .onChange(of: emailAddress, updateQRCode)
        }
    }
}

#Preview {
    PersonalInfoView()
}


extension PersonalInfoView {
    //MARK: - Genereate QRCode method
    func generateQRcode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    //MARK: - Update QR code method
    func updateQRCode() {
        qrCode = generateQRcode(from: "\(name)\n\(emailAddress)")
    }

}

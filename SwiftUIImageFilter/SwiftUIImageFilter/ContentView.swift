//
//  ContentView.swift
//  SwiftUIImageFilter
//
//  Created by Kunal Kumar R on 26/08/24.
//

import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedImage: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                //Image area
                PhotosPicker(selection: $selectedImage) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    }else {
                        ContentUnavailableView("No preview", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                    
                }
                .onChange(of: selectedImage, loadImage)
                
                Slider(value: $filterIntensity)
                    .onChange(of: selectedImage, applyFilter)
                
                Spacer()
                
                HStack {
                    Button("Change filter", action: changeFilter)
                        .disabled(selectedImage == nil)
                    Spacer()
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Filter Image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Image Filter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    //MARK: - Change Filter method
    func changeFilter() {
        showingFilters = true
    }
    
    //MARK: - Load Image method
    func loadImage() {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let initialImage = CIImage(image: inputImage)
            currentFilter.setValue(initialImage, forKey: kCIInputImageKey)
            applyFilter()
        }
    }
    
    //MARK: - Apply filter method
    func applyFilter() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)}
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    //MARK: - Set filter method
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        if filterCount >= 20 {
            requestReview()
        }
    }
}

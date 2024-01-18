//
//  LocalFIleManager.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 08/08/2023.
//

import Foundation
import SwiftUI

class LocalFileManager{
    
    static let instance = LocalFileManager()
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String){
        
        //create folder
        createFolderIfNeeded(folderName: folderName)
        
        //get image path
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        //save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error Image saving. ImageName: \(imageName) \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String){
        
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("ERROR create folder. FolderName \(folderName) \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL?{
        
        guard let folderURL = getURLForFolder(folderName: folderName ) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
}

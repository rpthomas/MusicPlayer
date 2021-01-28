//
//  ReadWrite.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/14/21.
//

import UIKit

class ReadWrite: NSObject {
    func readFromDocumentsDirectory(imgtype: NSString) -> NSMutableDictionary
    {
        let namesDict: NSMutableDictionary = [:]
        
        // Get the document directory url
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let _ = paths[0] //documentsDirectory
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            print(directoryContents)

            if (imgtype.isEqual(to: "Images"))
            {
                let imageFiles = directoryContents.filter{ $0.pathExtension == "bmp" || $0.pathExtension == "bmpf" || $0.pathExtension == "jpg" || $0.pathExtension == "jpeg" || $0.pathExtension == "gif" || $0.pathExtension == "png" || $0.pathExtension == "tif" || $0.pathExtension == "tiff"}
                
                for item in imageFiles {
                    namesDict.setValue(item.lastPathComponent, forKey: item.absoluteString)
                }
                print(type(of: imageFiles))
                print(namesDict)
                
                print("image urls:",imageFiles)
                let imageFileNames = imageFiles.map{ $0.deletingPathExtension().lastPathComponent }
                print("images list:", imageFileNames)
            }
            else
            {
                let videoFiles = directoryContents.filter{ $0.pathExtension == "mp4" || $0.pathExtension == "mv4" || $0.pathExtension == "mov"}
                
                for item in videoFiles {
                    namesDict.setValue(item.lastPathComponent, forKey: item.absoluteString)
                }
                
                print("video urls:",videoFiles)
                let videoFileNames = videoFiles.map{ $0.deletingPathExtension().lastPathComponent }
                print("video list:", videoFileNames)
                
            }
            

        } catch {
            print(error)
        }
        
        return namesDict
    }
    
    func saveImageToDocumentDirectory(imgView : UIImageView) -> Bool {
            let fileManager = FileManager.default
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
        let image = imgView.image//UIImage(named: "apple.jpg")
        let imageData = image!.jpegData(compressionQuality: 0.5)
        return fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        
        }
    
    func writeToPhotoAlbum(image: UIImage) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
        }

        @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            print("Save finished!")
        }
    
    //How to Get Document Directory Path

    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
   // How to Create Directory

    func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("images")
        if !fileManager.fileExists(atPath: paths){
            do {
                try fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Couldn't create document directory")
            }
        }else{
            print("Already directory created.")
        }
    }
    
    
    //How to Write / Save Image at Document Directory


    
    
    //Read / Get Image from Document Directory

    func getImage(imageName : String)-> UIImage{
            let fileManager = FileManager.default
    // Here using getDirectoryPath method to get the Directory path
            let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(imageName)
            if fileManager.fileExists(atPath: imagePath){
                return UIImage(contentsOfFile: imagePath)!
            }else{
                print("No Image available")
                return UIImage.init(named: "placeholder.png")! // Return placeholder image here
            }
        }
    
    //Delete Directory by Name

     func deleteDirectory(directoryName : String){
            let fileManager = FileManager.default
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(directoryName)
            if fileManager.fileExists(atPath: paths){
                try! fileManager.removeItem(atPath: paths)
            }else{
                print("Directory not found")
            }
        }
    
    func clearCache(){
        let fileManager = FileManager.default
        do {
            let documentDirectoryURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURLs = try fileManager.contentsOfDirectory(at: documentDirectoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for url in fileURLs {
               try fileManager.removeItem(at: url)
            }
        } catch {
            print(error)
        }
    }
    
   

    
}

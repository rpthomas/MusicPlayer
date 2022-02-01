//
//  YouTubeMusicViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/9/21.
//

import UIKit

class YouTubeMusicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didChangeValue(forKey key: String, withSetMutation mutationKind: NSKeyValueSetMutationKind, using objects: Set<AnyHashable>) {
        {
            let videoURL = "http://www.youtube.com/watch?v=KMU0tzLwhbE"
                let url = NSURL(string: "http://www.youtubeinmp3.com/fetch/?format=JSON&video=\(videoURL)")
                let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
                let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
                let request = NSMutableURLRequest(URL: url!)
                request.HTTPMethod = "GET"

                let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                    if (error == nil) {
                        if let response = response as? NSHTTPURLResponse {
                            print("response=\(response)")
                            if response.statusCode == 200 {
                                if data != nil {
                                    do {
                                        let responseJSON =  try  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary;
                                        let urlString = responseJSON["link"] as! String
                                        let directDownloadURL = NSURL(string: urlString)

                                        // Call your method loadFileAsync
                                        YourClass.loadFileAsync(directDownloadURL!, completion: { (path, error) -> Void in
                                            print(path)
                                        })

                                    }
                                    catch let JSONError as NSError {
                                        print("\(JSONError)")
                                    }
                                    catch {
                                        print("unknown error in JSON Parsing");
                                    }

                                }
                            }
                        }
                    }
                    else {
                        print("Failure: \(error!.localizedDescription)");
                    }
                })
                task.resume()

            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

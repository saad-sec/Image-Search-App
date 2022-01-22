

import UIKit

//MARK:- UICollectionView
extension UICollectionView {
    func register(nib nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}

//MARK:- UIImageView
extension UIImageView {
    
    func downloadImage(_ url: String, withAnimation: Bool = true) {
        
        DownloadManager.shared.addOperation(url: url,imageView: self) {  [weak self](result,downloadedImageURL)  in
            DispatchQueue.main.async {
                switch result {
                case .Success(let image):
                    
                    if(withAnimation){
                        self?.alpha = 0.0
                        self?.image = image
                        UIView.animate(withDuration: 0.15, animations: {
                            self?.alpha = 1.0
                        }, completion: nil)
                    }else{
                        self?.alpha = 1.0
                        self?.image = image
                    }
                    
                    
                case .Failure(_):
                    break
                case .Error(_):
                    break
                }
            }
        }
    }
    //completion: @escaping (Result<Data>) -> Void
}

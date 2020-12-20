//
//  UITableView+extensions.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    func indicatorView() -> UIActivityIndicatorView{
            var activityIndicatorView = UIActivityIndicatorView()
            if self.tableFooterView == nil{
                let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 40)
                activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
                activityIndicatorView.isHidden = false
                activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
                activityIndicatorView.isHidden = true
                self.tableFooterView = activityIndicatorView
                return activityIndicatorView
            }else{
                return activityIndicatorView
            }
        }

        func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
            indicatorView().startAnimating()
            if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
                if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        closure()
                    }
                }
            }
            indicatorView().isHidden = false
        }

        func stopLoading(){
            indicatorView().stopAnimating()
            indicatorView().isHidden = true
        }
}

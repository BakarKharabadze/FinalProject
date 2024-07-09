//
//  NewsDetailViewController.swift
//  
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import UIKit

public class NewsDetailViewController: UIViewController {

    private var viewModel: NewsDetailViewModel!
    
    public class func create(with viewModel: NewsDetailViewModel) -> NewsDetailViewController {
        let vc = NewsDetailViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()


    }

}

//
//  ProductListViewController.swift
//  MVVMRestAPI
//
//  Created by MD Faizan on 30/04/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    
    @IBOutlet weak var productTableView: UITableView!
    
    
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        
        
    }
    
}

extension ProductListViewController {
    
    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        initViewModel()
        observeEvent()
        
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    //Data binding event observe karenga - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            
            switch event {
                
            case .loading:
                //indicator show
                print("product loading")
            case .stopLoading:
                //indicator hide
                print("stop loading")
            case .dataLoaded:
                print("data loaded")
                DispatchQueue.main.async {
                    //UI Main Works Well
                    self.productTableView.reloadData()
                }
                print(self.viewModel.products)
            case .error(let error):
                print(error)
                
            }
            
        }
    }
}


extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
}

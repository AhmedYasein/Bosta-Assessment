//  Bosta Assessment
//  UISearchBar
//  Created by Ahmed Yasein on 03/12/2024.
//



import UIKit
import Combine

extension UISearchBar {
    var textDidChangePublisher: AnyPublisher<String?, Never> {
        let controlPublisher = publisher(for: \.text, options: .new).eraseToAnyPublisher()
        return controlPublisher
    }
}

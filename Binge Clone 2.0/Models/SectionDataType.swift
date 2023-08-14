//
//  SectionDataType.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit


struct SectionDataType {
    let headerFooter: SupplementaryDataType
    var cells: [CellDataType]
    
    init(headerFooter: SupplementaryDataType, cells: [CellDataType]) {
        self.headerFooter = headerFooter
        self.cells = cells
    }
}

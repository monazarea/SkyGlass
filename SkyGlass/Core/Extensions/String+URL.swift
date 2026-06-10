//
//  String+URL.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation

extension String{
    func withHttpPrefix()->String{
        if self.hasPrefix("//"){
            return "https:" + self
        }
        return self
    }
}

//
//  String+DateFormat.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//



import Foundation

extension String {
    func toAmPmFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "h a"
            return formatter.string(from: date)
        }
        
        return self 
    }
    
        func toDayName() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            guard let date = formatter.date(from: self) else { return self }
            
            if Calendar.current.isDateInToday(date) {
                return "Today"
            }
            
            formatter.dateFormat = "EEE" // بتجيب أول 3 حروف من اسم اليوم
            return formatter.string(from: date)
        }
}

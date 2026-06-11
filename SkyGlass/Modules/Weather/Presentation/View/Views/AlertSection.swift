//
//  AlertSection.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import SwiftUI

struct AlertSection: View {
    let alertText: String
    let theme: AppTheme
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            // 1. أيقونة التنبيه
            Image(systemName: "exclamationmark.triangle")
                .font(.title3)
                .foregroundColor(.teal) // اللون السماوي/الأخضر اللي في الديزاين
            
            // 2. النصوص
            VStack(alignment: .leading, spacing: 6) {
                Text("WEATHER ALERT")
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(1.5) // المسافة بين الحروف عشان تدي شكل عصري
                    .foregroundColor(theme.primaryTextColor.opacity(0.6))
                
                Text(alertText)
                    .font(.subheadline)
                    .lineSpacing(4) // مسافة بين السطور للقراءة المريحة
                    .foregroundColor(theme.primaryTextColor)
                    .fixedSize(horizontal: false, vertical: true) // عشان النص ينزل على سطرين لو طويل براحته
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        // 3. تأثير الـ Glassmorphism هنا 🪞
        .background(.ultraThinMaterial)
        // 💡 السطر ده سحر: بيخلي الزجاج يقلب غامق لو احنا بالليل وفاتح لو بالنهار!
        .environment(\.colorScheme, theme.primaryTextColor == .white ? .dark : .light)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(theme.primaryTextColor.opacity(0.15), lineWidth: 1) // إطار خفيف جداً
        )
    }
}

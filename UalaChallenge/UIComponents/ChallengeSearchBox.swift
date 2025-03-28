//
//  ChallengeSearchBox.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import SwiftUI

struct ChallengeSearchBox: View {
    
    var enabled: Bool = true
    private var onFocus: Bool? { search != "" || focus }
    @State private var focus: Bool = false
    @Binding var search: String
    var placeholder: String
    
    public init(search: Binding<String>, enabled: Bool, placeholder: String = "Search") {
        self._search = search
        self.enabled = enabled
        self.placeholder = placeholder
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundColor(Color(hex: "#333333"))
            
            TextField(placeholder, text: $search)
                .disabled(!enabled)
            
            Button(
                action: {
                    search = ""
                    focus.toggle()
                },
                label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(hex: "#50007F"))
                })
                .opacity(search.isEmpty ? 0 : 1)
        }
        .frame(height: 48)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke( onFocus ?? false ? Color(hex: "#50007F") : Color(hex: "#D1D1D1"), lineWidth: 1)
        )
        .background(Color(hex: "#FFFFFF"))
        .cornerRadius(16)
        .shadow(color: Color(hex: "#333333").opacity( onFocus ?? false ? 0.2 : 0), radius: 4, x: 0, y: 2)
        .foregroundColor(!enabled ? Color(hex: "#D1D1D1") : Color(hex: "#5B5B5B"))
        .onTapGesture {
            focus.toggle()
        }
    }
}

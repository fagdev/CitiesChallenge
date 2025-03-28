//
//  ChallengeCityCell.swift
//  UalaChallenge
//
//  Created by NaranjaX on 28/03/2025.
//

import SwiftUI

struct ChallengeCityCell: View {
    var title: String
    var subtitle: String
    @State var favState: Bool
    var onTapCell: (() -> ())?
    var onTapPrimaryButton: (() -> ())?
    var onTapSecondaryButton: ((_ state: Bool) -> ())?
    
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .bold()
                        .padding(.bottom, 4)
                    
                    Text(subtitle)
                        .padding(.bottom, 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .onTapGesture {
                if let onTapCell {
                    onTapCell()
                }
            }
            
            HStack(spacing: 16) {
                Button(action: { onTapPrimaryButton?() }) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 20))
                }
                
                Button(action: {
                    onTapSecondaryButton?(favState)
                    self.favState.toggle()
                }) {
                    Image(systemName: favState ? "heart.fill" : "heart")
                        .font(.system(size: 20))
                }
            }
        }
        .padding(.horizontal)
    }
}

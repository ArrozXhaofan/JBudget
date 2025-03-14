//
//  UIMyList.swift
//  JBudget
//
//  Created by Jean Laura on 28/02/25.
//

import SwiftUI
import MapKit

struct UIMyList: View {
    
    @Binding var manager: ExploreViewModel
    
    var body: some View {
        
        VStack {
            ScrollView {
                ForEach(manager.searchResults, id: \.self) { value in
                    let place = value.placemark
                    
                    Button {
                        hideKeyboard()
                        manager.searchResults.removeAll()
                        
                        withAnimation(.easeInOut(duration: 1)) {
                            manager.cameraPosition = .item(value, allowsAutomaticPitch: true)
                            manager.currentMKItemSelected = value
                        }
    
                    } label: {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(place.name ?? "")
                            Text(place.title ?? "")
                            Spacer()
                        }
                        .font(.footnote)
                        .padding(.horizontal, 15)
                        .frame(width: 350, height: 50, alignment: .leading)
                    }
                    Divider()
                }
            }
            
        }
        .frame(maxWidth: 350, minHeight: 250, maxHeight: 250)
        .padding(0)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.blackGrayVercel)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.borderGray , lineWidth: 2)
                }
        }
        .padding(0)
    }
}

#Preview {
    ExploreView()
    //UIMyList(value: [.sampleMapItem(), .sampleMapItem(), .sampleMapItem()])
}



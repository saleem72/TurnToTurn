//
//  NavHeaderView.swift
//  TurnToTurn
//
//  Created by Yousef on 5/24/22.
//

import SwiftUI

struct NavHeaderView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    private var label: String
    private var handler: () -> ()
    
    init(label: String, handler: @escaping () -> ()) {
        self.handler = handler
        self.label = label
    }
    
    var body: some View {
        HStack {
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .frame(width: 44, height: 44)
                    .navigationButton(direction: .leading)
            })
            
            Spacer(minLength: 0)
            
            Button(action: {
                handler()
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 44, height: 44)
                    .navigationButton(direction: .trailing)
            })
        }
        .frame(height: 146)
        .overlay(
            Text(label)
                .font(Font.gallery.semiBold(17))
        )
    }
}

struct NavHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavHeaderView(label: "Testing") { }
    }
}

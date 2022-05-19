//
//  DropdownList.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/16/22.
//

import SwiftUI

struct DropdownList: View {
    
    @Binding var selection: String
    let options: [String]
    
    @State private var showList: Bool = false
    private var visibleCount: CGFloat = 3
    private var width: CGFloat = 100
    private var itemHeight: CGFloat = 44
    private var bkColor: Color = .clear
    private var foreColor: Color = Color.white
    init(selection: Binding<String>, options: [String]) {
        self._selection = selection
        self.options = options
    }
    
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    Button(action: {
                        toggleList()
                    }, label: {
                        HStack(spacing: 8) {
                            Text(selection)
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.subheadline)
                                .rotationEffect(Angle(degrees: showList ? 180 : 0))
                        }
                        .font(Font.gallery.subheadline())
                        .foregroundColor(foreColor)
                        .frame(width: width, height: itemHeight)
                        .background(
                            RoundedRectangle(cornerRadius: 23)
                                .fill(bkColor)
                        )
                    })
                    if showList {
                        optionsList
                            .frame(height: visibleCount * (itemHeight + 10))
                            .offset(y: (((visibleCount + 1) * itemHeight) / 2) + 24)
                            .zIndex(1.0)
                    }
                    
                }
                .frame(width: width)
            }
            .frame(width: width)
        }
        
        .frame(height: 45)
        .zIndex(2)
    }
    
    func toggleList() {
        withAnimation(.easeInOut) {
            showList.toggle()
        }
    }
}

struct DropdownList_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DropdownList(selection: .constant("Dog"), options: ["Dog", "Cat", "Horse"])
                .listWidth(200)
                .backgroundColor(Color.green)
            
            Text("Hello world!")
        }
    }
}

extension DropdownList {
    private var optionsList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { value in
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id:\.self) { item in
                        Button(action: {
                            selection = item
                            toggleList()
                        }, label: {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(item)
                                    .padding(item == selection ? 4: 0)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(item == selection ? Color.yellow : bkColor)
                                    )
                                    .frame(height: itemHeight)
                                    .frame(maxWidth: .infinity)
                                    .font(Font.gallery.subheadline())
                                    .foregroundColor(foreColor)
                                    
                            }
                        })
                        .id(item)     
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(bkColor)
                        .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0.0, y: 5)
                )
                .onAppear(perform: {
                    value.scrollTo(selection, anchor: .center)
                })
            }
            
        }
    }
}


extension DropdownList {
    func listWidth(_ width: CGFloat) -> DropdownList {
        var view = self
        view.width = width
        return view
    }
    
    func backgroundColor(_ color: Color) -> DropdownList {
        var view = self
        view.bkColor = color
        return view
    }
}

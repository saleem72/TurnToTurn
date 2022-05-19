//
//  DropDownDateView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/16/22.
//

import SwiftUI

class DropDownDateViewModel: ObservableObject {
    @Published var selectedDay: String = "1"
    @Published var selectedMonth: String = "May"
    @Published var selectedYear: String = "2022"
    
    @Published var dayOptions: [String] = []
    @Published var monthOptions: [String] = []
    @Published var yearOptions: [String] = []
    
    
    init(date: Date) {
        selectedDay = "\(date.day)"
        selectedMonth = date.month
        selectedYear = "\(date.year)"
        
        dayOptions = getDayOptions(monthDays: date.monthDays)
        monthOptions = Date.monthsList
        yearOptions = getYearOptions(current: date.year)
    }
    
    func getDayOptions(monthDays: Int) -> [String] {
        var result = [String]()
        for i in (1...monthDays) {
            result.append("\(i)")
        }
        return result
    }
    
    func getYearOptions(current: Int) -> [String] {
        var result = [String]()
        for i in current - 10...current {
            result.append("\(i)")
        }
        
        return result.reversed()
    }
    
    var date: Date {
        let monthIndex  = (monthOptions.firstIndex(of: selectedMonth)  ?? 1) + 1
        let month = max(1, min(12, monthIndex))
        return Date.dateComponents(
            day: Int(selectedDay) ?? 1,
            month: month,
            year: Int(selectedYear) ?? 2020
        )
    }
    
    func refreshDayOptions() {
        let monthIndex  = (monthOptions.firstIndex(of: selectedMonth)  ?? 1) + 1
        let month = max(1, min(12, monthIndex))
        let date = Date.dateComponents(
            day: 1,
            month: month,
            year: Int(selectedYear) ?? 2020
        )
        let count = date.monthDays
        dayOptions = getDayOptions(monthDays: count)
        if (Int(selectedDay) ?? 1) > count {
            selectedDay = "\(count)"
        }
    }
}

struct DropDownDateView: View {
    
    @StateObject private var viewModel: DropDownDateViewModel
    @Binding var date: Date
    
    init(date: Binding<Date>) {
        self._date = date
        self._viewModel = StateObject(wrappedValue: .init(date: date.wrappedValue))
    }
    
    var body: some View {
        HStack {
            DropdownList(selection: $viewModel.selectedYear, options: viewModel.yearOptions)
                .listWidth(90)
            DropdownList(selection: $viewModel.selectedMonth, options: viewModel.monthOptions)
                .listWidth(130)
            DropdownList(selection: $viewModel.selectedDay, options: viewModel.dayOptions)
                .listWidth(75)
                .backgroundColor(Color.white.opacity(0.04))
        }
        .onChange(of: viewModel.date, perform: { value in
            date = value
        })
        .onChange(of: viewModel.selectedMonth, perform: { _ in
            viewModel.refreshDayOptions()
        })
    }
}

struct TestDropDownDate: View {
    
    @State private var date = Date()
    @State private var week: [Date] = Date().week
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var fontSize: CGFloat {
        switch screenWidth {
        case 0...380: return 12
        case 381...700: return 24
        case 701...1000: return 36
        default: return 10
        }
    }
    
    var body: some View {
        ZStack {
            Color("screenFrom")
                .edgesIgnoringSafeArea(.all)
            VStack {
                DropDownDateView(date: $date)
                    .zIndex(1.0)
                
                Text(date.longDate)
                    .font(.system(size: fontSize, weight: .regular))
                
                Text("\(screenWidth)")
                
                HStack {
                    ForEach(week, id:\.self) { item in
                        VStack {
                            Text(item.weekday)
                            Text(item.shortDate)
                        }
                    }
                }
            }
        }
    }
}

struct DropDownDateView_Previews: PreviewProvider {
    static var previews: some View {
        TestDropDownDate()
            .preferredColorScheme(.dark)
    }
}

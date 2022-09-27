//
//  LibrarySettings_macOS.swift
//  Kiwix for macOS
//
//  Created by Chris Li on 6/11/22.
//  Copyright © 2022 Chris Li. All rights reserved.
//

import SwiftUI

import Defaults

struct LibrarySettings_macOS: View {
    @Default(.libraryAutoRefresh) private var autoRefresh
    @StateObject private var viewModel = LibraryViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            SettingSection_macOS(name: "Catalog") {
                HStack(spacing: 6) {
                    Button("Refresh Now") {
                        viewModel.startRefresh(isUserInitiated: true)
                    }.disabled(viewModel.isRefreshing)
                    if viewModel.isRefreshing {
                        ProgressView().progressViewStyle(.circular).scaleEffect(0.5).frame(height: 1)
                    }
                    Spacer()
                    Text("Last refresh:").foregroundColor(.secondary)
                    LibraryLastRefreshTime().foregroundColor(.secondary)
                }
                VStack(alignment: .leading) {
                    Toggle("Auto refresh", isOn: $autoRefresh)
                    Text("When enabled, the library catalog will be refreshed automatically when outdated.")
                        .foregroundColor(.secondary)
                }
            }
            SettingSection_macOS(name: "Languages") {
                LanguageSelector()
            }
        }
        .padding()
        .tabItem { Label("Library", systemImage: "folder.badge.gearshape") }
    }
}

struct LibrarySettings_macOS_Previews: PreviewProvider {
    static var previews: some View {
        TabView { LibrarySettings_macOS() }.frame(width: 480).preferredColorScheme(.light)
        TabView { LibrarySettings_macOS() }.frame(width: 480).preferredColorScheme(.dark)
    }
}
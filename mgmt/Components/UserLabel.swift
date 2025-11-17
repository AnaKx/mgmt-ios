//
//  UserDetaislLabel.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 12/11/25.
//

import SwiftUI

struct UserLabel: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.icon)
            Text(text)
                .foregroundColor(.secondary)
        }
    }
}

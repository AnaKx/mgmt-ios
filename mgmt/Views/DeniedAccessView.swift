//
//  DeniedAccessView.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 08/11/25.
//

import SwiftUI

struct DeniedAccessView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack(spacing: 20){
            Spacer()
            
            Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(Color(.icon))
                .padding(.vertical, 10)
                
            
            Text("\(Text("Your")) \(Text("user").foregroundStyle(.accent).fontWeight(.light)) \(Text("access has been")) \(Text("revoked").foregroundStyle(.accent).fontWeight(.light)) ")
                .font(Font.largeTitle.weight(.thin))
                .multilineTextAlignment(.center)
            
            Text("Get in touch with an admin to restore access")
                .multilineTextAlignment(.center)
                .fontWeight(.light)
                .foregroundColor(.secondary)
            
            Spacer()
            Button("Log out"){
                KeychainService.shared.deleteToken()
                UserDefaultsService.shared.clearUser()
                
                isLoggedIn = false
            }
            .buttonStyle(CustomButton())
            
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background() {
            Color(.background)
                .ignoresSafeArea()
        }
        
    }
}

#Preview {
    @Previewable @State var isLoggedIn = true
    
    DeniedAccessView(isLoggedIn: $isLoggedIn)
}

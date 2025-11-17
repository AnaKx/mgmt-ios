//
//  CustomInputField.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 08/11/25.
//

import SwiftUI

struct CustomInputField: View {
    let label: String
    @Binding var text: String
    var isSecure: Bool = false // for passwords
    
    
    @FocusState private var isFocused: Bool
    
    @State private var isPasswordVisible = false
    
    var shouldFloat: Bool {
        isFocused || !text.isEmpty
    }
    
    var body: some View {
        VStack{
            ZStack(alignment: .leading) {
                Text(label)
                    .foregroundColor(.gray)
                    .offset(y: shouldFloat ? -30 : 0)
                    .scaleEffect(shouldFloat ? 0.8 : 1.0, anchor: .leading)
                    .animation(.spring(response: 0.3), value: shouldFloat)
                
                HStack {
                    if isSecure && !isPasswordVisible {
                        SecureField("", text: $text)
                            .focused($isFocused)
                    } else {
                        TextField("", text: $text)
                            .focused($isFocused)
                    }
                    
                    if isSecure {
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding(.bottom, 5)
            
            Divider()
                .background(Color.gray)
        }
        .padding(.bottom, 50)
    }
}

#Preview {
    @Previewable @State var text = ""
    CustomInputField(label: "Email", text: $text)
}

//
//  URLImage.swift
//  GainCodeCase
//
//  Created by Ege Seçkin on 12.11.2021.
//

import SwiftUI


struct URLImage: View {
    let imageData: Data
       
       var body: some View {

           ZStack {
               
                   Image(uiImage: UIImage(data: imageData)!)
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .cornerRadius(18)
           }
           .frame(width: 140, height: 230)
       }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(imageData: Data())
    }
}

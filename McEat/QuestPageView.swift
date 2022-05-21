//
//  QuestPageView.swift
//  McEat
//
//  Created by Rivaldo Fernandes on 21/05/22.
//

import SwiftUI


struct QuestPageView: View {
    var body: some View {
        GeometryReader { geo in
            NavigationView{
                ZStack{
                    VStack {
                        ZStack{
                            HStack {
                                Image(systemName: "xmark")
                                VStack {
                                    Text("Lokasi Kamu")
                                    Text("Jakarta")
                                }
                                Image(systemName: "chevron.down")
                            }.onTapGesture {
                                print("hello")
                            }
                        }
                        .frame(width: geo.size.width, height: 200)
                        .background(Corners(color: .red, tl: 0, tt: 0, bl: 30, bt: 30))
                        
                        Spacer()
                    }
                }
                .navigationBarHidden(true)
                .ignoresSafeArea()
            }
        }
    }
}

struct QuestPageView_Previews: PreviewProvider {
    static var previews: some View {
        QuestPageView()
    }
}


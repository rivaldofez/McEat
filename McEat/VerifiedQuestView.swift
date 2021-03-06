//
//  VerifiedQuestView.swift
//  McEat
//
//  Created by Rivaldo Fernandes on 21/05/22.
//

import SwiftUI

struct VerifiedQuestView: View {
    @State var questItem: QuestItem
    //Gesture Properties
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @State var isMidDrag: Bool = false
    @State var showRoot: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                showRoot = true
            }){
                HStack {
                    Image(systemName: "chevron.backward")
                    Text("Back")
                }.padding(.leading, 10)
            }.padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
            NavigationLink(destination: MainView(), isActive: self.$showRoot){
            }
            ZStack(alignment: isMidDrag ? .top : .center) {
                CustomColor.white
                VStack {
                    Text("CONGRATULATIONS")
                        .font(.system(.title2).bold())
                        .foregroundColor(.black)
                    Text("Kamu telah berhasil menjawab Questnya")
                        .font(.system(.body))
                        .foregroundColor(.black)
                    Image(questItem.unlockQuest.image)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text(questItem.unlockQuest.title)
                        .font(.system(.title2).bold())
                        .foregroundColor(.black)
                }.padding(.top, isMidDrag ? 20 : 0)
                
                GeometryReader { geo -> AnyView in
                    //getting height for drag gesture
                    
                    let height = geo.frame(in: .global).height
                    
                    return AnyView(
                        ZStack {
                            CustomColor.primary
                                .clipShape(CustomShapeRounded(corners: [.topLeft,.topRight], radius: 30))
                            
                            VStack {
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: 80, height: 4)
                                    .padding(.top)
                                
                                Text("Story Food")
                                    .font(.system(.title2).bold())
                                    .foregroundColor(.white)
                                    .padding(.top, 15)
                                
                                HStack {
                                    VStack(alignment:.leading) {
                                        Text(questItem.unlockQuest.title)
                                            .font(.system(.title).bold())
                                            .foregroundColor(CustomColor.white)
                                        
                                        Text(questItem.unlockQuest.story)
                                            .font(.system(.body))
                                            .foregroundColor(CustomColor.white)
                                    }
                                    
                                    Spacer()
                                }.padding(.top, 20)
                                
                            }
                            .padding(.horizontal)
                            .frame(maxHeight: .infinity, alignment: .top)
                            
                        }
                            .offset(y: height - 100)
                            .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                            .gesture(DragGesture().updating(self.$gestureOffset, body: { value, out, _ in
                                out = value.translation.height
                                onChange()
                            }).onEnded({value in
                                let maxHeight = height - 100
                                withAnimation{
                                    //Logic condition for moving states
                                    //up down or min
                                    
                                    if -offset > 100 && -offset < maxHeight / 2{
                                        offset = -(maxHeight / 3)
                                        isMidDrag = true
                                        
                                    }else if -offset > maxHeight / 2 {
                                        offset = -maxHeight
                                        isMidDrag = true
                                    }else{
                                        offset = 0
                                        isMidDrag = false
                                    }
                                }
                                lastOffset = offset
                            })
                                    )
                     )
                }.ignoresSafeArea(.all, edges: .bottom)
            }
        }
        .navigationBarHidden(true)

    }
    
    func onChange(){
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        
        return progress * 30
    }
}

struct VerifiedQuestView_Previews: PreviewProvider {
    static var previews: some View {
        VerifiedQuestView(questItem: QuestData().questData[0].questItem[0])
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    
    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

//
//  DialogOutdoor.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct DialogOutdoor: View {
    @Binding var isShowOutdoor: Bool
    @State private var offSet: CGFloat = 1000
    @Binding var textOutdoor: String
    @Binding var metValue: Double
    let textList = [
        "Badminton: general", 
        "Basketaba",
        "Bowling",
        "Dancing: disco, ballroom,square",
        "Dancing: slow, waltz, foxtrot",
        "Football: competitive",
        "Frisbee", "Golf: using cart",
        "Handball: general",
        "Horseback Riding: general" ,
        "Kayaking",
        "Racquetball: casual, general",
        "Rock Climbing: ascending",
        "Rollerblading/skating (Casual)",
        "Rope Jumping(Fast)",
        "Rugby: competitive",
        "Skateboarding",
        "Skiing: downhill",
        "Snow Shoeing" ,
        "Softball: general play",
        "Tennis: general",
        "Volleyball: competitive, gymnasium play" ,
        "Walk/Jog: jog <10 min.",
        "Water Skiing",
        "Whitewater: rafting, kayaking",
        "Basketball: playing a game",
        "Billiards" ,"Boxing:  sparring" ,
        "Dancing:  Fast, ballet, twist",
        "Fencing: general",
        "Football: touch, flag,general",
        "Golf: carrying clubs",
        "Gymnastics: general",
        "Hockey: field & ice",
        "Ice Skating: general" ,
        "Martial Arts: judo, karate, kickbox",
        "Racquetball: competitive",
        "Rock Climbing: rappelling",
        "Rollerblading/skating(Fast)",
        "Rope Jumping (Slow)",
        "Scuba or skin diving",
        "Skiing: cross-country",
        "Sledding, luge, toboggan" ,
        "Soccer: general",
        "Tai Chi",
        "Volleyball: beach",
        "Volleyball: non-competitive, general play",
        "Water Polo",
        "Water Volleyball",
        "Wrestling"
    ]
    
    let activityMETs: [String: Double] = [
            "Badminton: general": 4.5,
            "Basketball: playing a game": 8.0,
            "Bowling": 3.0,
            "Dancing: disco, ballroom,square": 5.0,
            "Dancing: slow, waltz, foxtrot": 3.0,
            "Football: competitive": 8.0,
            "Frisbee": 3.0,
            "Golf: using cart": 3.5,
            "Handball: general": 8.0, 
            "Horseback Riding: general": 3.5,
            "Kayaking": 3.5, 
            "Racquetball: casual, general": 8.0,
            "Rock Climbing: ascending": 8.0,
            "Rollerblading/skating (Casual)": 4.0,
            "Rope Jumping(Fast)": 9.8,
            "Rugby: competitive": 8.0,
            "Skateboarding": 5.0, 
            "Skiing: downhill": 6.0,
            "Snow Shoeing": 5.3,
            "Softball: general play": 5.0,
            "Tennis: general": 6.0,
            "Volleyball: competitive, gymnasium play": 4.0,
            "Walk/Jog: jog <10 min.": 8.0, 
            "Water Skiing": 6.0,
            "Whitewater: rafting, kayaking": 6.0,
            "Billiards": 2.5,
            "Boxing: sparring": 7.8, 
            "Dancing: Fast, ballet, twist": 6.0,
            "Fencing: general": 6.0,
            "Football: touch, flag,general": 8.0,
            "Golf: carrying clubs": 5.5, 
            "Gymnastics: general": 5.5,
            "Hockey: field & ice": 8.0,
            "Ice Skating: general": 7.0,
            "Martial Arts: judo, karate, kickbox": 8.0,
            "Racquetball: competitive": 8.0, 
            "Rock Climbing: rappelling": 8.0,
            "Rollerblading/skating(Fast)": 12.0, 
            "Rope Jumping (Slow)": 8.0,
            "Scuba or skin diving": 6.0,
            "Skiing: cross-country": 8.0,
            "Sledding, luge, toboggan": 7.0,
            "Soccer: general": 8.0,
            "Tai Chi": 3.5,
            "Volleyball: beach": 4.0,
            "Volleyball: non-competitive, general play": 4.0,
            "Water Polo": 8.0,
            "Water Volleyball": 5.0,
            "Wrestling": 8.0
    ]
    let colums = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    close()
                }
            
            ScrollView {
                VStack {
                    LazyVGrid(columns: colums) {
                        ForEach(textList, id: \.self) { list in
                            Button {
                                textOutdoor = list
                                metValue = activityMETs[list] ?? 1.0
                            } label: {
                                Image(systemName: textOutdoor == list ? "circle.circle.fill" : "circle.circle")
                                    .foregroundColor(.black)
                                
                                Text(list)
                                    .foregroundColor(.black)
                                    .font(.system(size: 13))
                            }
                            .padding(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(15)
                .padding()
                .offset(y: offSet)
                .onAppear {
                    withAnimation(.spring()) {
                        offSet = 0
                    }
                }
            }
        }

    }
    
    func close() {
        withAnimation(.spring()) {
            offSet = 1000
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isShowOutdoor = false
        }
    }
}


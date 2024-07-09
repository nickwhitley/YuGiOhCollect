//
//  CardSmallView.swift
//  YugiohCollect
//
//  Created by nwhitley.vendor on 6/3/24.
//

import SwiftUI

struct CardListComponent: View {
    var cardId: String
    var cardName: String
    var cardType: String
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 100)
            .foregroundStyle(GetCardColor(cardType: cardType))
            .overlay(
                HStack {
                    Spacer()
                    CardImageView(cardId: cardId)
                        .clipShape(RightRoundedRectangle(radius: 20))
                }
                    .padding(.horizontal, 0))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black)
            )
            .overlay(
                GeometryReader { cardFrame in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(cardName)
                                .foregroundStyle(.white)
                                .bold()
                                .font(.title3)
                            Text(cardType)
                                .foregroundStyle(.white)
                                .bold()
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.trailing, cardFrame.size.width / 3)
                    .padding(.top, cardFrame.size.height / 6)
                }
            )
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
    }
    
    private func GetCardColor(cardType: String) -> Color {
        switch cardType {
            case "Normal Monster":
                return .normalMonster
            case "Effect Monster":
                return .effectMonster
            case "Spell Card":
                return .spell
            case "Trap Card":
                return .trap
            default:
                return .gray
            }
    }
}

struct CardImageView: View {
    var cardId: String
    var body: some View {
        AsyncImage(url: URL(string: "https://images.ygoprodeck.com/images/cards_cropped/\(cardId).jpg")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image("SmallCardPlaceholder") // Use the name of the image asset
                            .resizable()
                            .aspectRatio(contentMode: .fit)
        }
    }
}

struct RightRoundedRectangle: Shape {
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start from top left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        
        // Top right corner
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        
        // Move to bottom right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        
        // Bottom right corner
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        // Move to bottom left
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            CardListComponent(cardId: "34541863", cardName: "\"Infernoble Arms - Durendal\"",cardType: "Spell Card")
            CardListComponent(cardId: "34541863", cardName: "\"Infernoble Arms - Durendal\"",cardType: "Spell Card")
            CardListComponent(cardId: "34541863", cardName: "\"Infernoble Arms - Durendal\"",cardType: "Spell Card")
        }
    }

    return Preview()
}

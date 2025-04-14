HStack(spacing: 2) {
                            
                            ForEach((0...4).self, id: \.self) { index in
                                let starName = index < Int(ceil(place.reviewRating)) ? "star.fill" : "star"
                                
                                Image(systemName: starName)
                                    .frame(
                                        width: 1 * 14
                                    )
                                    .scaleEffect(0.75)
                            }
                        }
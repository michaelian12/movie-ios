//
//  ReviewMapper.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

final class ReviewMapper {

    static func mapReviewResponsesToDomains(input reviewResponse: [ReviewResponse]) -> [ReviewModel] {
        return reviewResponse.map { result in
            return ReviewModel(id: result.id ?? "0",
                               authorName: result.author ?? "Unknown author",
                               content: result.content ?? "-")
        }
    }

}

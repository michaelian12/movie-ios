//
//  VideoMapper.swift
//  Movie
//
//  Created by Michael Agustian on 16/04/21.
//

import Foundation

final class VideoMapper {

    static func mapVideoResponsesToDomains(input videoResponse: [VideoResponse]) -> [VideoModel] {
        return videoResponse.map { result in
            return VideoModel(id: result.id ?? "0",
                               youTubeId: result.key ?? "Unknown key")
        }
    }

}

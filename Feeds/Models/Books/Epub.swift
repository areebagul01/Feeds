import Foundation

struct Epub : Codable {
	let isAvailable : Bool?

	enum CodingKeys: String, CodingKey {

		case isAvailable = "isAvailable"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		isAvailable = try values.decodeIfPresent(Bool.self, forKey: .isAvailable)
	}

}

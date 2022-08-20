import Foundation

struct SearchInfo : Codable {
	let textSnippet : String?

	enum CodingKeys: String, CodingKey {

		case textSnippet = "textSnippet"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		textSnippet = try values.decodeIfPresent(String.self, forKey: .textSnippet)
	}

}

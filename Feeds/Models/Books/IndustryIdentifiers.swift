import Foundation

struct IndustryIdentifiers : Codable {
	let type : String?
	let identifier : String?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case identifier = "identifier"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		identifier = try values.decodeIfPresent(String.self, forKey: .identifier)
	}

}

import Foundation

struct SaleInfo : Codable {
	let country : String?
	let saleability : String?
	let isEbook : Bool?

	enum CodingKeys: String, CodingKey {

		case country = "country"
		case saleability = "saleability"
		case isEbook = "isEbook"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		saleability = try values.decodeIfPresent(String.self, forKey: .saleability)
		isEbook = try values.decodeIfPresent(Bool.self, forKey: .isEbook)
	}

}

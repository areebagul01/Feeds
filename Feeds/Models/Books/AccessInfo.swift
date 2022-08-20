import Foundation

struct AccessInfo : Codable {
	let country : String?
	let viewability : String?
	let embeddable : Bool?
	let publicDomain : Bool?
	let textToSpeechPermission : String?
	let epub : Epub?
	let pdf : Pdf?
	let webReaderLink : String?
	let accessViewStatus : String?
	let quoteSharingAllowed : Bool?

	enum CodingKeys: String, CodingKey {

		case country = "country"
		case viewability = "viewability"
		case embeddable = "embeddable"
		case publicDomain = "publicDomain"
		case textToSpeechPermission = "textToSpeechPermission"
		case epub = "epub"
		case pdf = "pdf"
		case webReaderLink = "webReaderLink"
		case accessViewStatus = "accessViewStatus"
		case quoteSharingAllowed = "quoteSharingAllowed"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		viewability = try values.decodeIfPresent(String.self, forKey: .viewability)
		embeddable = try values.decodeIfPresent(Bool.self, forKey: .embeddable)
		publicDomain = try values.decodeIfPresent(Bool.self, forKey: .publicDomain)
		textToSpeechPermission = try values.decodeIfPresent(String.self, forKey: .textToSpeechPermission)
		epub = try values.decodeIfPresent(Epub.self, forKey: .epub)
		pdf = try values.decodeIfPresent(Pdf.self, forKey: .pdf)
		webReaderLink = try values.decodeIfPresent(String.self, forKey: .webReaderLink)
		accessViewStatus = try values.decodeIfPresent(String.self, forKey: .accessViewStatus)
		quoteSharingAllowed = try values.decodeIfPresent(Bool.self, forKey: .quoteSharingAllowed)
	}

}

import Foundation

struct PanelizationSummary : Codable {
	let containsEpubBubbles : Bool?
	let containsImageBubbles : Bool?

	enum CodingKeys: String, CodingKey {

		case containsEpubBubbles = "containsEpubBubbles"
		case containsImageBubbles = "containsImageBubbles"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		containsEpubBubbles = try values.decodeIfPresent(Bool.self, forKey: .containsEpubBubbles)
		containsImageBubbles = try values.decodeIfPresent(Bool.self, forKey: .containsImageBubbles)
	}

}

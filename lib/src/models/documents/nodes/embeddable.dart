/// An object which can be embedded into a Quill document.
///
/// See also:
///
/// * [BlockEmbed] which represents a block embed.
class Embeddable {
  const Embeddable(this.type, this.data);

  /// The type of this object.
  final String type;

  /// The data payload of this object.
  final dynamic data;

  Map<String, dynamic> toJson() {
    final m = <String, String>{type: data};
    return m;
  }

  static Embeddable fromJson(Map<String, dynamic> json) {
    final m = Map<String, dynamic>.from(json);
    assert(m.length == 1, 'Embeddable map must only have one key');

    return BlockEmbed(m.keys.first, m.values.first);
  }
}

/// There are two built-in embed types supported by Quill documents, however
/// the document model itself does not make any assumptions about the types
/// of embedded objects and allows users to define their own types.
class BlockEmbed extends Embeddable {
  const BlockEmbed(String type, String data) : super(type, data);

  static const blockTypeList = [videoType,linkCardType];

  static const String imageType = 'image';
  static BlockEmbed image(String imageUrl) => BlockEmbed(imageType, imageUrl);

  static const String videoType = 'video';
  static BlockEmbed video(String videoUrl) => BlockEmbed(videoType, videoUrl);

  /// card of link
  static const String linkCardType = 'cardOfLink';
  static BlockEmbed linkCard(String script) => BlockEmbed(linkCardType, script);

}

class InlineEmbed extends Embeddable {
  const InlineEmbed(String type, String data) : super(type, data);

  static const String tagType = 'tag';
  static Embeddable tagEmbed(String script) => Embeddable(tagType, script);

  static const String metaType = 'meta';
  static Embeddable metaEmbed(String script) => Embeddable(metaType, script);

  static const String boardType = 'board';
  static Embeddable boardEmbed(String script) => Embeddable(boardType, script);
}